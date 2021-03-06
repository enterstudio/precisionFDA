class Challenge
  include ActiveModel::Model

  def self.consistency(context)
    consistency_discussion = Discussion.accessible_by_public.find_by(id: CONSISTENCY_DISCUSSION_ID)
    return {
      path: Rails.application.routes.url_helpers.consistency_challenges_path,
      results_path: Rails.application.routes.url_helpers.consistency_challenges_path + "/results",
      title: "Consistency Challenge",
      thumbnail: "challenges/pFDA-C1-Diagram-Thumbnail",
      responses_count: consistency_discussion.answers.accessible_by_public.size,
      followers_count: consistency_discussion.count_user_followers,
      launched: !consistency_discussion.nil? && consistency_discussion.public?,
      joined: context.logged_in? && !consistency_discussion.nil? && consistency_discussion.followed_by?(context.user),
      start_date: CONSISTENCY_CHALLENGE_START_DATE,
      end_date: CONSISTENCY_CHALLENGE_END_DATE,
      results_date: CONSISTENCY_CHALLENGE_RESULTS_DATE,
      active: DateTime.now.in_time_zone < CONSISTENCY_CHALLENGE_END_DATE,
      ended: DateTime.now.in_time_zone >= CONSISTENCY_CHALLENGE_END_DATE,
      results_announced: true
      # CONSISTENCY_CHALLENGE_RESULTS_DATE && DateTime.now.in_time_zone >= CONSISTENCY_CHALLENGE_RESULTS_DATE
    }
  end

  def self.truth(context)
    truth_discussion = Discussion.find_by(id: TRUTH_DISCUSSION_ID)
    return {
      path: Rails.application.routes.url_helpers.truth_challenges_path,
      results_path: Rails.application.routes.url_helpers.truth_challenges_path + "/results",
      title: "Truth Challenge",
      thumbnail: "challenges/pFDA-C2-Diagram-Thumbnail",
      responses_count: truth_discussion.answers.accessible_by_public.size,
      followers_count: truth_discussion.count_user_followers,
      launched: !truth_discussion.nil? && truth_discussion.public?,
      joined: context.logged_in? && !truth_discussion.nil? && truth_discussion.followed_by?(context.user),
      start_date: TRUTH_CHALLENGE_START_DATE,
      end_date: TRUTH_CHALLENGE_END_DATE,
      results_date: TRUTH_CHALLENGE_RESULTS_DATE,
      active: DateTime.now.in_time_zone < TRUTH_CHALLENGE_END_DATE,
      ended: DateTime.now.in_time_zone >= TRUTH_CHALLENGE_END_DATE,
      results_announced: TRUTH_CHALLENGE_RESULTS_DATE && DateTime.now.in_time_zone >= TRUTH_CHALLENGE_RESULTS_DATE,
      results: {
        overview: TRUTH_CHALLENGE_RESULTS_OVERVIEW,
        medals: TRUTH_CHALLENGE_MEDALS,
        recognitions: TRUTH_CHALLENGE_RECOGNITIONS,
        answers_to_username_map: TRUTH_CHALLENGE_RESULTS_OVERVIEW.reduce({}) do |h, v|
          obj = {}
          obj[v[:"Answer id"]] = v[:"Submitter username"]
          h.merge obj
        end
      }
    }
  end

  #TODO: May need to change this to support more appathons in future
  def self.appathons(context)
    meta_appathon = MetaAppathon.find_by_handle(APPATHON_IN_A_BOX_HANDLE)
    now = DateTime.now.in_time_zone
    return {
      path: Rails.application.routes.url_helpers.appathon_in_a_box_path,
      results_path: Rails.application.routes.url_helpers.appathon_in_a_box_path,
      title: meta_appathon.title,
      thumbnail: "appathons/appathon-toolbox.png",
      responses_count: meta_appathon.apps.count,
      followers_count: meta_appathon.count_user_followers,
      launched: meta_appathon.start_at < now,
      joined: context.logged_in? && meta_appathon.followed_by?(context.user),
      start_date: meta_appathon.start_at,
      end_date: meta_appathon.end_at,
      results_date: APPATHON_IN_A_BOX_RESULTS_DATE,
      active: meta_appathon.start_at < now && now < meta_appathon.end_at,
      ended: now >= meta_appathon.end_at,
      results_announced: true,
    }
  end

  TRUTH_CHALLENGE_MEDALS = {
    "SNP-recall": "bgallagher-sentieon",
    "SNP-precision": "astatham-gatk",
    "SNP-Fscore": "rpoplin-dv42",
    "INDEL-recall": "dgrover-gatk",
    "INDEL-precision": "hfeng-pmm3",
    "INDEL-Fscore": "dgrover-gatk"
  }

  TRUTH_CHALLENGE_RECOGNITIONS = {
    "SNP-recall": %w(eyeh-varpipe dgrover-gatk jli-custom ckim-dragen rpoplin-dv42 jlack-gatk hfeng-pmm3 hfeng-pmm2 hfeng-pmm1 raldana-dualsentieon),
    "SNP-precision": %w(hfeng-pmm1 hfeng-pmm3 rpoplin-dv42 egarrison-hhga hfeng-pmm2 ndellapenna-hhga ckim-isaac raldana-dualsentieon ckim-vqsr dgrover-gatk),
    "SNP-Fscore": %w(hfeng-pmm3 hfeng-pmm1 dgrover-gatk hfeng-pmm2 jli-custom bgallagher-sentieon raldana-dualsentieon),
    "INDEL-recall": %w(astatham-gatk bgallagher-sentieon ckim-dragen ckim-gatk),
    "INDEL-precision": %w(ltrigg-rtg1 jli-custom hfeng-pmm1 ltrigg-rtg2 hfeng-pmm2 raldana-dualsentieon dgrover-gatk ckim-vqsr astatham-gatk cchapple-custom),
    "INDEL-Fscore": %w(jli-custom hfeng-pmm3 astatham-gatk hfeng-pmm1 hfeng-pmm2)
  }

  TRUTH_CHALLENGE_RESULTS_OVERVIEW = [
    {
      "Order of submission": 1,
      "Label": "raldana-dualsentieon",
      "Submitter username": "rafael.aldana",
      "Answer id": 24,
      "Submitter": "Rafael Aldana",
      "Additional Users": "Hanying Feng, Brendan Gallagher, Jun Ye",
      "Organization": "Sentieon",
      "Org popover": nil,
      "HG001 VCF file id": "file-Bvx0Jgj0xgFJYy3jyj950Z80",
      "HG002 VCF file id": "file-Bvx0Jgj0xgF6PB4yz47bxVy0",
      "SNP-recall": 0.999131,
      "SNP-precision": 0.999389,
      "SNP-Fscore": 0.99926,
      "INDEL-recall": 0.987566,
      "INDEL-precision": 0.994648,
      "INDEL-Fscore": 0.991095,
      "HG001 VCF filename": "Challenge201605_Sentieon_dualmap_HG001_final.vcf.gz",
      "HG002 VCF filename": "Challenge201605_Sentieon_dualmap_HG002_final.vcf.gz"
    },
    {
      "Order of submission": 2,
      "Label": "bgallagher-sentieon",
      "Submitter username": "brendan.gallagher",
      "Answer id": 25,
      "Submitter": "Brendan Gallagher",
      "Additional Users": "Hanying Feng, Rafael Aldana, Jun Ye",
      "Organization": "Sentieon",
      "Org popover": nil,
      "HG001 VCF file id": "file-BvQ3K1Q00k9vfXJfXJvbyzJQ",
      "HG002 VCF file id": "file-BvQ3p5807Bv5v9kB6vY3f8YK",
      "SNP-recall": 0.999673,
      "SNP-precision": 0.998919,
      "SNP-Fscore": 0.999296,
      "INDEL-recall": 0.992143,
      "INDEL-precision": 0.993213,
      "INDEL-Fscore": 0.992678,
      "HG001 VCF filename": "Sentieon DNAseq Gallagher HG001.vcf",
      "HG002 VCF filename": "Sentieon DNAseq Gallagher HG002.vcf"
    },
    {
      "Order of submission": 3,
      "Label": "mlin-fermikit",
      "Submitter username": "mike.lin",
      "Answer id": 26,
      "Submitter": "Mike Lin",
      "Additional Users": nil,
      "Organization": "DNAnexus Science",
      "Org popover": nil,
      "HG001 VCF file id": "file-BvVG23Q0JPPK4J7z4VykjvvP",
      "HG002 VCF file id": "file-BvVGVv008VZXXxgBVvVq9k1Q",
      "SNP-recall": 0.982311,
      "SNP-precision": 0.995029,
      "SNP-Fscore": 0.988629,
      "INDEL-recall": 0.948918,
      "INDEL-precision": 0.963183,
      "INDEL-Fscore": 0.955997,
      "HG001 VCF filename": "HG001.fermikit.raw.vcf.gz",
      "HG002 VCF filename": "HG002.fermikit.raw.vcf.gz"
    },
    {
      "Order of submission": 4,
      "Label": "jmaeng-gatk",
      "Submitter username": "juheon.maeng",
      "Answer id": 31,
      "Submitter": "Ju Heon Maeng",
      "Additional Users": nil,
      "Organization": "Yonsei University",
      "Org popover": nil,
      "HG001 VCF file id": "file-Bx3845803qX6BVz1v8qV70Kg",
      "HG002 VCF file id": "file-Bx3y0x803qX2yzYjk9xVxJ2F",
      "SNP-recall": 0.994608,
      "SNP-precision": 0.997686,
      "SNP-Fscore": 0.996144,
      "INDEL-recall": 0.990216,
      "INDEL-precision": 0.991981,
      "INDEL-Fscore": 0.991098,
      "HG001 VCF filename": "HG001-NA12878-50x_illumina_WGS_TruthChallenge.RGadded.marked.realigned.fixed.recal.Haplotype.raw.snps.filtered.noheader.vcf.gz",
      "HG002 VCF filename": "HG002-NA24385-50x_illumina_WGS_TruthChallenge.RGadded.marked.realigned.fixed.recal.Haplotype.raw.snps.filtered.noheader.vcf.gz"
    },
    {
      "Order of submission": 5,
      "Label": "ckim-dragen",
      "Submitter username": "changhoon.kim",
      "Answer id": 34,
      "Submitter": "Changhoon Kim",
      "Additional Users": nil,
      "Organization": "Macrogen",
      "Org popover": nil,
      "HG001 VCF file id": "file-Bvxzgb808byYbQ44zkFQKZXF",
      "HG002 VCF file id": "file-BvzJBg008byZVvFX981pX1GJ",
      "SNP-recall": 0.999524,
      "SNP-precision": 0.997015,
      "SNP-Fscore": 0.998268,
      "INDEL-recall": 0.991574,
      "INDEL-precision": 0.991143,
      "INDEL-Fscore": 0.991359,
      "HG001 VCF filename": "DRAGEN_HG001-NA12878-50x.hard-filtered.vcf.gz",
      "HG002 VCF filename": "DRAGEN_HG002-NA24385-50x.vcf.gz"
    },
    {
      "Order of submission": 6,
      "Label": "ckim-gatk",
      "Submitter username": "changhoon.kim",
      "Answer id": 34,
      "Submitter": "Changhoon Kim",
      "Additional Users": nil,
      "Organization": "Macrogen",
      "Org popover": nil,
      "HG001 VCF file id": "file-BvxzJ1Q08byXFkgK7jgJJ4KY",
      "HG002 VCF file id": "file-BvzGjv008byz443Kvbxk0F66",
      "SNP-recall": 0.994788,
      "SNP-precision": 0.99815,
      "SNP-Fscore": 0.996466,
      "INDEL-recall": 0.991551,
      "INDEL-precision": 0.992992,
      "INDEL-Fscore": 0.992271,
      "HG001 VCF filename": "GATK_HG001-NA12878.Filtered.Variants.vcf.gz",
      "HG002 VCF filename": "GATK_HG002-NA24385.Filtered.Variants.vcf.gz"
    },
    {
      "Order of submission": 7,
      "Label": "ckim-isaac",
      "Submitter username": "changhoon.kim",
      "Answer id": 34,
      "Submitter": "Changhoon Kim",
      "Additional Users": nil,
      "Organization": "Macrogen",
      "Org popover": nil,
      "HG001 VCF file id": "file-BvxzvBj08byvgBkGybFjVKQZ",
      "HG002 VCF file id": "file-BvzGqQj08byZqVZ0ZQYJB5jb",
      "SNP-recall": 0.971616,
      "SNP-precision": 0.999494,
      "SNP-Fscore": 0.985357,
      "INDEL-recall": 0.937006,
      "INDEL-precision": 0.980163,
      "INDEL-Fscore": 0.958099,
      "HG001 VCF filename": "ISAAC_HG001-NA12878_all_passed_variants.vcf.gz",
      "HG002 VCF filename": "ISAAC_HG002-NA24385_all_passed_variants.vcf.gz"
    },
    {
      "Order of submission": 8,
      "Label": "ckim-vqsr",
      "Submitter username": "changhoon.kim",
      "Answer id": 34,
      "Submitter": "Changhoon Kim",
      "Additional Users": nil,
      "Organization": "Macrogen",
      "Org popover": nil,
      "HG001 VCF file id": "file-BvyQfX008bykZpXPf4Y5gZ62",
      "HG002 VCF file id": "file-BvzGkx008byQ9xPFxkxX210K",
      "SNP-recall": 0.986511,
      "SNP-precision": 0.999303,
      "SNP-Fscore": 0.992866,
      "INDEL-recall": 0.990614,
      "INDEL-precision": 0.994476,
      "INDEL-Fscore": 0.992541,
      "HG001 VCF filename": "VQSR_HG001-NA12878.recalibrated_variants.vcf.gz",
      "HG002 VCF filename": "VQSR_HG002-NA24385.recalibrated_variants.vcf.gz"
    },
    {
      "Order of submission": 9,
      "Label": "ltrigg-rtg2",
      "Submitter username": "len.trigg",
      "Answer id": 35,
      "Submitter": "Len Trigg",
      "Additional Users": nil,
      "Organization": "RTG",
      "Org popover": "Real Time Genomics",
      "HG001 VCF file id": "file-Bx3qbz00gf6Vjv3F88x50QF5",
      "HG002 VCF file id": "file-Bx3qj500gf6Q0XVq2G712v1V",
      "SNP-recall": 0.998935,
      "SNP-precision": 0.998562,
      "SNP-Fscore": 0.998749,
      "INDEL-recall": 0.988759,
      "INDEL-precision": 0.996347,
      "INDEL-Fscore": 0.992539,
      "HG001 VCF filename": "RTG-HG001-NA12878-50x-AVR.vcf.gz",
      "HG002 VCF filename": "RTG-HG002-NA24385-50x-AVR.vcf.gz"
    },
    {
      "Order of submission": 10,
      "Label": "ltrigg-rtg1",
      "Submitter username": "len.trigg",
      "Answer id": 35,
      "Submitter": "Len Trigg",
      "Additional Users": nil,
      "Organization": "RTG",
      "Org popover": "Real Time Genomics",
      "HG001 VCF file id": "file-Bx1x6580gf6QVfX298Kf15zZ",
      "HG002 VCF file id": "file-Bx1xfqj0gf6fJvZXQbvb6yx7",
      "SNP-recall": 0.998921,
      "SNP-precision": 0.998587,
      "SNP-Fscore": 0.998754,
      "INDEL-recall": 0.983355,
      "INDEL-precision": 0.997061,
      "INDEL-Fscore": 0.99016,
      "HG001 VCF filename": "RTG-HG001-NA12878-50x-GQ20.vcf.gz",
      "HG002 VCF filename": "RTG-HG002-NA24385-50x-GQ20.vcf.gz"
    },
    {
      "Order of submission": 11,
      "Label": "hfeng-pmm1",
      "Submitter username": "hanying.feng",
      "Answer id": 36,
      "Submitter": "Hanying Feng",
      "Additional Users": "Rafael Aldana, Brendan Gallagher, Jun Ye",
      "Organization": "Sentieon",
      "Org popover": nil,
      "HG001 VCF file id": "file-Bx2Ppp00pFqxy2G0kb1f1fx8",
      "HG002 VCF file id": "file-Bx35JjQ0pFqvBkPBF0QX6bB4",
      "SNP-recall": 0.999227,
      "SNP-precision": 0.999766,
      "SNP-Fscore": 0.999496,
      "INDEL-recall": 0.990289,
      "INDEL-precision": 0.996526,
      "INDEL-Fscore": 0.993397,
      "HG001 VCF filename": "Sentieon-HG001-PMM1.vcf.gz",
      "HG002 VCF filename": "Sentieon-HG002-PMM1.vcf.gz"
    },
    {
      "Order of submission": 12,
      "Label": "hfeng-pmm2",
      "Submitter username": "hanying.feng",
      "Answer id": 36,
      "Submitter": "Hanying Feng",
      "Additional Users": "Rafael Aldana, Brendan Gallagher, Jun Ye",
      "Organization": "Sentieon",
      "Org popover": nil,
      "HG001 VCF file id": "file-Bx2z6Q80pFqkzj5GyJ6BKxK8",
      "HG002 VCF file id": "file-Bx37JY00pFqpFK62KvQvBypK",
      "SNP-recall": 0.999254,
      "SNP-precision": 0.999579,
      "SNP-Fscore": 0.999416,
      "INDEL-recall": 0.990152,
      "INDEL-precision": 0.996103,
      "INDEL-Fscore": 0.993119,
      "HG001 VCF filename": "Sentieon-HG001-PMM2.vcf.gz",
      "HG002 VCF filename": "Sentieon-HG002-PMM2.vcf.gz"
    },
    {
      "Order of submission": 13,
      "Label": "hfeng-pmm3",
      "Submitter username": "hanying.feng",
      "Answer id": 36,
      "Submitter": "Hanying Feng",
      "Additional Users": "Rafael Aldana, Brendan Gallagher, Jun Ye",
      "Organization": "Sentieon",
      "Org popover": nil,
      "HG001 VCF file id": "file-Bx2z6QQ0pFqXZ1J4v568zgKp",
      "HG002 VCF file id": "file-Bx35JjQ0pFqzf3f9zG6ZKpzK",
      "SNP-recall": 0.999339,
      "SNP-precision": 0.999756,
      "SNP-Fscore": 0.999548,
      "INDEL-recall": 0.990161,
      "INDEL-precision": 0.99712,
      "INDEL-Fscore": 0.993628,
      "HG001 VCF filename": "Sentieon-HG001-PMM3.vcf.gz",
      "HG002 VCF filename": "Sentieon-HG002-PMM3.vcf.gz"
    },
    {
      "Order of submission": 14,
      "Label": "jlack-gatk",
      "Submitter username": "justin.lack",
      "Answer id": 38,
      "Submitter": "Justin Lack",
      "Additional Users": nil,
      "Organization": "NIH",
      "Org popover": "National Institutes of Health",
      "HG001 VCF file id": "file-Bx2vk380JvF2Z1J4v568zfJ7",
      "HG002 VCF file id": "file-Bx2vk380JvF5Y8X8x5xxjKKZ",
      "SNP-recall": 0.999393,
      "SNP-precision": 0.995016,
      "SNP-Fscore": 0.9972,
      "INDEL-recall": 0.988138,
      "INDEL-precision": 0.985664,
      "INDEL-Fscore": 0.986899,
      "HG001 VCF filename": "NA12878_CCBR.vcf.gz",
      "HG002 VCF filename": "NA24385_CCBR.vcf.gz"
    },
    {
      "Order of submission": 15,
      "Label": "astatham-gatk",
      "Submitter username": "aaron.statham",
      "Answer id": 39,
      "Submitter": "Aaron Statham",
      "Additional Users": "Mark Cowley, Joseph Copty, Mark Pinese",
      "Organization": "KCCG",
      "Org popover": "Kinghorn Center for Clinical Genomics",
      "HG001 VCF file id": "file-Bx333q80YvykYYb5yjk6F6Gy",
      "HG002 VCF file id": "file-Bx333ZQ0k071g3V9y0k9BgYY",
      "SNP-recall": 0.992091,
      "SNP-precision": 0.999807,
      "SNP-Fscore": 0.995934,
      "INDEL-recall": 0.992404,
      "INDEL-precision": 0.994446,
      "INDEL-Fscore": 0.993424,
      "HG001 VCF filename": "AStatham-Garvan-HG001.hc.vqsr.vcf.gz",
      "HG002 VCF filename": "AStatham-Garvan-HG002.hc.vqsr.vcf.gz"
    },
    {
      "Order of submission": 16,
      "Label": "qzeng-custom",
      "Submitter username": "qian.zeng",
      "Answer id": 40,
      "Submitter": "Qian Zeng",
      "Additional Users": nil,
      "Organization": "LabCorp",
      "Org popover": nil,
      "HG001 VCF file id": "file-Bx37YVQ0qz73Kz7qv5xvBvV1",
      "HG002 VCF file id": "file-Bx37f080qz7Pj18FjVxpJY8q",
      "SNP-recall": 0.992413,
      "SNP-precision": 0.997533,
      "SNP-Fscore": 0.994966,
      "INDEL-recall": 0.968703,
      "INDEL-precision": 0.967929,
      "INDEL-Fscore": 0.968316,
      "HG001 VCF filename": "LabCorp_HG001.vcf.gz",
      "HG002 VCF filename": "LabCorp_HG002.vcf.gz"
    },
    {
      "Order of submission": 17,
      "Label": "anovak-vg",
      "Submitter username": "adam.novak",
      "Answer id": 41,
      "Submitter": "Adam Novak",
      "Additional Users": "Erik Garrison, Eric Dawson, Glenn Hickey, Mike Lin",
      "Organization": "vgteam",
      "Org popover": nil,
      "HG001 VCF file id": "file-Bx37ZK009P4bX5g3qjkFZV38",
      "HG002 VCF file id": "file-Bx37ZbQ022f1YzF7j0k7KJkZ",
      "SNP-recall": 0.983357,
      "SNP-precision": 0.985736,
      "SNP-Fscore": 0.984545,
      "INDEL-recall": 0.697491,
      "INDEL-precision": 0.712591,
      "INDEL-Fscore": 0.70496,
      "HG001 VCF filename": "vg_may.HG001.vcf.gz",
      "HG002 VCF filename": "vg_may.HG002.vcf.gz"
    },
    {
      "Order of submission": 18,
      "Label": "eyeh-varpipe",
      "Submitter username": "erhchan.yeh",
      "Answer id": 42,
      "Submitter": "ErhChan Yeh",
      "Additional Users": "*",
      "Organization": "Academia Sinica",
      "Org popover": nil,
      "HG001 VCF file id": "file-Bx2vfFj0J25Vvvpv216y2bYj",
      "HG002 VCF file id": "file-Bx2vfFj0J25gXVybq5xk48V9",
      "SNP-recall": 0.999638,
      "SNP-precision": 0.989751,
      "SNP-Fscore": 0.99467,
      "INDEL-recall": 0.913854,
      "INDEL-precision": 0.938021,
      "INDEL-Fscore": 0.925779,
      "HG001 VCF filename": "HG001-NA12878_varpipe_1.vcf",
      "HG002 VCF filename": "HG002-NA24385_varpipe_1.vcf"
    },
    {
      "Order of submission": 19,
      "Label": "ciseli-custom",
      "Submitter username": "christian.iseli",
      "Answer id": 44,
      "Submitter": "Christian Iseli",
      "Additional Users": "Nicolas Guex, Maxime Jan, Theirry Schuepbach, Brian Stevenson, Ioannis Xenarios",
      "Organization": "SIB",
      "Org popover": "Swiss Institute of Bioinformatics",
      "HG001 VCF file id": "file-Bx3Fqkj07Z8Pby3JYb3fjQ7k",
      "HG002 VCF file id": "file-Bx38p5807Z83Kz7qv5xvBvXF",
      "SNP-recall": 0.988356,
      "SNP-precision": 0.967169,
      "SNP-Fscore": 0.977648,
      "INDEL-recall": 0.825314,
      "INDEL-precision": 0.845844,
      "INDEL-Fscore": 0.835453,
      "HG001 VCF filename": "SIB-HG001.vcf.gz",
      "HG002 VCF filename": "SIB-HG002.vcf.gz"
    },
    {
      "Order of submission": 20,
      "Label": "ccogle-snppet",
      "Submitter username": "christopher.cogle.2",
      "Answer id": 45,
      "Submitter": "Christopher Cogle",
      "Additional Users": "Leylah Drusbosky, Sanjiv Bhave, William C. Curtiss, Shaukat Rangwala, Taher Abbasi",
      "Organization": "CancerPOP",
      "Org popover": nil,
      "HG001 VCF file id": "file-Bx2k5800Q4k3XP26bb1vFK7p",
      "HG002 VCF file id": "file-Bx3PGJ00Q4k3Kz7qv5xvByp0",
      "SNP-recall": 0,
      "SNP-precision": 0,
      "SNP-Fscore": 0,
      "INDEL-recall": 0,
      "INDEL-precision": 0,
      "INDEL-Fscore": 0,
      "HG001 VCF filename": "HG001_NA12878_CancerPOP.vcf",
      "HG002 VCF filename": "HG002_NA24385_CancerPOP.vcf"
    },
    {
      "Order of submission": 21,
      "Label": "asubramanian-gatk",
      "Submitter username": "ayshwarya.subramanian",
      "Answer id": 46,
      "Submitter": "Ayshwarya Subramanian",
      "Additional Users": "Yossi Farjoun, Jonathan Bloom",
      "Organization": "Broad Institute",
      "Org popover": nil,
      "HG001 VCF file id": "file-Bx3g7JQ0Yf8Pf3f9zG6ZP0xg",
      "HG002 VCF file id": "file-Bx3j1xQ0Yf81BZJ0255Ffz1Z",
      "SNP-recall": 0.979985,
      "SNP-precision": 0.998954,
      "SNP-Fscore": 0.989379,
      "INDEL-recall": 0.985404,
      "INDEL-precision": 0.991451,
      "INDEL-Fscore": 0.988418,
      "HG001 VCF filename": "pfda-truth-bi.hg001-rerun2.vcf.gz",
      "HG002 VCF filename": "pfda-truth-bi.hg002-rerun2.vcf.gz"
    },
    {
      "Order of submission": 22,
      "Label": "rpoplin-dv42",
      "Submitter username": "ryan.poplin",
      "Answer id": 47,
      "Submitter": "Ryan Poplin",
      "Additional Users": "Mark DePristo, Verily Life Sciences Team",
      "Organization": "Verily Life Sciences",
      "Org popover": nil,
      "HG001 VCF file id": "file-Bx34Pp80b41F97fxJ0QfK3bk",
      "HG002 VCF file id": "file-Bx3VPxj0b419Z45Fy5xZ13bJ",
      "SNP-recall": 0.999447,
      "SNP-precision": 0.999728,
      "SNP-Fscore": 0.999587,
      "INDEL-recall": 0.987882,
      "INDEL-precision": 0.991728,
      "INDEL-Fscore": 0.989802,
      "HG001 VCF filename": "HG001-NA12878-pFDA.vcf.gz",
      "HG002 VCF filename": "HG002-NA24385-pFDA.vcf.gz"
    },
    {
      "Order of submission": 23,
      "Label": "cchapple-custom",
      "Submitter username": "charles.chapple",
      "Answer id": 48,
      "Submitter": "Charles Chapple",
      "Additional Users": "Andreas Massouras",
      "Organization": "Saphetor",
      "Org popover": nil,
      "HG001 VCF file id": "file-Bx3Xpxj0KkzGZY3qz56KgqG2",
      "HG002 VCF file id": "file-Bx3Xq5Q0KkzGZY3qz56KgqG4",
      "SNP-recall": 0.998832,
      "SNP-precision": 0.998063,
      "SNP-Fscore": 0.998448,
      "INDEL-recall": 0.988448,
      "INDEL-precision": 0.994346,
      "INDEL-Fscore": 0.991388,
      "HG001 VCF filename": "Saphetor-hg001.vcf.gz",
      "HG002 VCF filename": "Saphetor-hg002.vcf.gz"
    },
    {
      "Order of submission": 24,
      "Label": "gduggal-bwafb",
      "Submitter username": "geet.duggal",
      "Answer id": 49,
      "Submitter": "Geet Duggal",
      "Additional Users": "Mike Lin, Singer Ma, Brad Chapman",
      "Organization": "DNAnexus Science",
      "Org popover": nil,
      "HG001 VCF file id": "file-Bx30G5j0J7YzkQXf2V9XKb0Q",
      "HG002 VCF file id": "file-Bx3Zyv80zfGk9BXq88jJbg9x",
      "SNP-recall": 0.998619,
      "SNP-precision": 0.997021,
      "SNP-Fscore": 0.99782,
      "INDEL-recall": 0.955004,
      "INDEL-precision": 0.98439,
      "INDEL-Fscore": 0.969474,
      "HG001 VCF filename": "NA12878-bwa-HG001-freebayes-keeplcr.vcf.gz",
      "HG002 VCF filename": "NA24385-bwa-HG002-freebayes-keeplcr.vcf.gz"
    },
    {
      "Order of submission": 25,
      "Label": "gduggal-bwaplat",
      "Submitter username": "geet.duggal",
      "Answer id": 49,
      "Submitter": "Geet Duggal",
      "Additional Users": "Mike Lin, Singer Ma, Brad Chapman",
      "Organization": "DNAnexus Science",
      "Org popover": nil,
      "HG001 VCF file id": "file-Bx31jVQ01qp354K4jjk3Bk41",
      "HG002 VCF file id": "file-Bx3q1480v1jY54K4jjk47Pb1",
      "SNP-recall": 0.980471,
      "SNP-precision": 0.996958,
      "SNP-Fscore": 0.988646,
      "INDEL-recall": 0.870843,
      "INDEL-precision": 0.990034,
      "INDEL-Fscore": 0.926621,
      "HG001 VCF filename": "NA12878-bwa-HG001-platypus-keeplcr.vcf.gz",
      "HG002 VCF filename": "NA24385-bwa-HG002-platypus-keeplcr.vcf.gz"
    },
    {
      "Order of submission": 26,
      "Label": "gduggal-bwavard",
      "Submitter username": "geet.duggal",
      "Answer id": 49,
      "Submitter": "Geet Duggal",
      "Additional Users": "Mike Lin, Singer Ma, Brad Chapman",
      "Organization": "DNAnexus Science",
      "Org popover": nil,
      "HG001 VCF file id": "file-Bx31jv80BZ9P061154pz66y6",
      "HG002 VCF file id": "file-Bx3q1g80qbYyJvpX38pY241b",
      "SNP-recall": 0.990431,
      "SNP-precision": 0.996083,
      "SNP-Fscore": 0.993249,
      "INDEL-recall": 0.871769,
      "INDEL-precision": 0.875166,
      "INDEL-Fscore": 0.873464,
      "HG001 VCF filename": "NA12878-bwa-HG001-vardict-keeplcr.vcf.gz",
      "HG002 VCF filename": "NA24385-bwa-HG002-vardict-keeplcr.vcf.gz"
    },
    {
      "Order of submission": 27,
      "Label": "gduggal-snapfb",
      "Submitter username": "geet.duggal",
      "Answer id": 49,
      "Submitter": "Geet Duggal",
      "Additional Users": "Mike Lin, Singer Ma, Brad Chapman",
      "Organization": "DNAnexus Science",
      "Org popover": nil,
      "HG001 VCF file id": "file-Bx31fGj060Pqz2Gk78j5gvfX",
      "HG002 VCF file id": "file-Bx3q5200FGkP061154pQ41zV",
      "SNP-recall": 0.998026,
      "SNP-precision": 0.987037,
      "SNP-Fscore": 0.992501,
      "INDEL-recall": 0.905733,
      "INDEL-precision": 0.940112,
      "INDEL-Fscore": 0.922602,
      "HG001 VCF filename": "NA12878-snap-HG001-freebayes-keeplcr.vcf.gz",
      "HG002 VCF filename": "NA24385-snap-HG002-freebayes-keeplcr.vcf.gz"
    },
    {
      "Order of submission": 28,
      "Label": "gduggal-snapplat",
      "Submitter username": "geet.duggal",
      "Answer id": 49,
      "Submitter": "Geet Duggal",
      "Additional Users": "Mike Lin, Singer Ma, Brad Chapman",
      "Organization": "DNAnexus Science",
      "Org popover": nil,
      "HG001 VCF file id": "file-Bx31fxQ0FYfk9BXq88jJ3f6X",
      "HG002 VCF file id": "file-Bx3q5F0032GbX5g3qjkGQY0X",
      "SNP-recall": 0.986815,
      "SNP-precision": 0.993266,
      "SNP-Fscore": 0.99003,
      "INDEL-recall": 0.690418,
      "INDEL-precision": 0.855664,
      "INDEL-Fscore": 0.76421,
      "HG001 VCF filename": "NA12878-snap-HG001-platypus-keeplcr.vcf.gz",
      "HG002 VCF filename": "NA24385-snap-HG002-platypus-keeplcr.vcf.gz"
    },
    {
      "Order of submission": 29,
      "Label": "gduggal-snapvard",
      "Submitter username": "geet.duggal",
      "Answer id": 49,
      "Submitter": "Geet Duggal",
      "Additional Users": "Mike Lin, Singer Ma, Brad Chapman",
      "Organization": "DNAnexus Science",
      "Org popover": nil,
      "HG001 VCF file id": "file-Bx31g8Q044PjgyX00Gpkfb7Q",
      "HG002 VCF file id": "file-Bx3q5P80xG5jgyX00GppGp6V",
      "SNP-recall": 0.989341,
      "SNP-precision": 0.992406,
      "SNP-Fscore": 0.990871,
      "INDEL-recall": 0.834429,
      "INDEL-precision": 0.826139,
      "INDEL-Fscore": 0.830264,
      "HG001 VCF filename": "NA12878-snap-HG001-vardict-keeplcr.vcf.gz",
      "HG002 VCF filename": "NA24385-snap-HG002-vardict-keeplcr.vcf.gz"
    },
    {
      "Order of submission": 30,
      "Label": "ghariani-varprowl",
      "Submitter username": "gunjan.hariani",
      "Answer id": 50,
      "Submitter": "Gunjan Hariani",
      "Additional Users": "Chad Brown, Jeff Jasper, Jason Powers",
      "Organization": "Quintiles",
      "Org popover": nil,
      "HG001 VCF file id": "file-Bx3fYkQ0y9KJfK1K016z1Vp4",
      "HG002 VCF file id": "file-Bx3g5Pj0y9K2B78v4Q73P1px",
      "SNP-recall": 0.998685,
      "SNP-precision": 0.988361,
      "SNP-Fscore": 0.993496,
      "INDEL-recall": 0.873272,
      "INDEL-precision": 0.870781,
      "INDEL-Fscore": 0.872025,
      "HG001 VCF filename": "default_with_model_NA12878.vcf.gz",
      "HG002 VCF filename": "default_with_model_NA24385.vcf.gz"
    },
    {
      "Order of submission": 31,
      "Label": "jpowers-varprowl",
      "Submitter username": "jason.powers",
      "Answer id": 51,
      "Submitter": "Jason Powers",
      "Additional Users": "Chad Brown, Jeff Jasper, Gunjun Hariani",
      "Organization": "Q2 Solutions",
      "Org popover": nil,
      "HG001 VCF file id": "file-Bx3fz580zgxJfK1K016z1X7k",
      "HG002 VCF file id": "file-Bx3fz580zgx9zj5GyJ6BPK9B",
      "SNP-recall": 0.995447,
      "SNP-precision": 0.994561,
      "SNP-Fscore": 0.995004,
      "INDEL-recall": 0.852886,
      "INDEL-precision": 0.877226,
      "INDEL-Fscore": 0.864885,
      "HG001 VCF filename": "HG001-NA12878-50x.vcf.gz",
      "HG002 VCF filename": "HG002-NA24385-50x.vcf.gz"
    },
    {
      "Order of submission": 32,
      "Label": "dgrover-gatk",
      "Submitter username": "deepak.grover",
      "Answer id": 53,
      "Submitter": "Deepak Grover",
      "Additional Users": nil,
      "Organization": "Sanofi-Genzyme",
      "Org popover": nil,
      "HG001 VCF file id": "file-Bx3ggG809V3qGgv2PvQVP43J",
      "HG002 VCF file id": "file-Bx3gY7809V3Q0XVq2G712pBP",
      "SNP-recall": 0.999631,
      "SNP-precision": 0.999282,
      "SNP-Fscore": 0.999456,
      "INDEL-recall": 0.993458,
      "INDEL-precision": 0.994561,
      "INDEL-Fscore": 0.994009,
      "HG001 VCF filename": "HG001-NA12878-dgrover.vcf.gz",
      "HG002 VCF filename": "HG002-NA24385-dgrover.vcf.gz"
    },
    {
      "Order of submission": 33,
      "Label": "egarrison-hhga",
      "Submitter username": "erik.garrison",
      "Answer id": 54,
      "Submitter": "Erik Garrison",
      "Additional Users": "Nikete Della Penna",
      "Organization": "-",
      "Org popover": nil,
      "HG001 VCF file id": "file-Bx3jPk009j5zxjZQ9Gj1Z650",
      "HG002 VCF file id": "file-Bx3jVjj0FKy7V2p26GjPyvf2",
      "SNP-recall": 0.998365,
      "SNP-precision": 0.999607,
      "SNP-Fscore": 0.998985,
      "INDEL-recall": 0.971646,
      "INDEL-precision": 0.976874,
      "INDEL-Fscore": 0.974253,
      "HG001 VCF filename": "HG001d.wg.hhga_yeoq.model.98.vcf.gz",
      "HG002 VCF filename": "HG002d.wg.hhga_yeoq.model.98.vcf.gz"
    },
    {
      "Order of submission": 34,
      "Label": "jli-custom",
      "Submitter username": "jian.li",
      "Answer id": 55,
      "Submitter": "Jian Li",
      "Additional Users": "Marghoob Mohiyuddin, Hugo Lam",
      "Organization": "Roche",
      "Org popover": nil,
      "HG001 VCF file id": "file-Bx3kV580yvVV6q64416YkK0q",
      "HG002 VCF file id": "file-Bx3pQB00yvVpv47G187374xV",
      "SNP-recall": 0.999603,
      "SNP-precision": 0.99916,
      "SNP-Fscore": 0.999382,
      "INDEL-recall": 0.990788,
      "INDEL-precision": 0.99658,
      "INDEL-Fscore": 0.993675,
      "HG001 VCF filename": "pfdaTC_Bina_HG001.vcf.gz",
      "HG002 VCF filename": "pfdaTC_Bina_HG002.vcf.gz"
    },
    {
      "Order of submission": 35,
      "Label": "ndellapenna-hhga",
      "Submitter username": "nicolas.dellapenna",
      "Answer id": 56,
      "Submitter": "Nicolas Della Penna",
      "Additional Users": nil,
      "Organization": "ANU",
      "Org popover": "Australian National University",
      "HG001 VCF file id": "file-Bx3pGYj0ppP77Ppj199p48YY",
      "HG002 VCF file id": "file-Bx3pGkj05F0gkPyf5Zj9FQxb",
      "SNP-recall": 0.998118,
      "SNP-precision": 0.999519,
      "SNP-Fscore": 0.998818,
      "INDEL-recall": 0.970938,
      "INDEL-precision": 0.976756,
      "INDEL-Fscore": 0.973838,
      "HG001 VCF filename": "HG001d.wg.hhga_refined_prague.model.18.vcf.gz",
      "HG002 VCF filename": "HG002d.wg.refined_prague.model.18.vcf.gz"
    }
  ]

end
