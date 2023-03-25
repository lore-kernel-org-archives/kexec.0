Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967ECC6FD1F
	for <kexec@archiver.kernel.org>; Sat, 25 Mar 2023 16:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=216uhPhg+kGFSkkmH4oEtADG6f05yS2zRNlR+oC3Y/c=; b=tplRWZ967GE6IM
	KvbOgGGFr3V/u0aYAQHPGIHEquFBPEp6B+LkrwhXEJkPhzeHt9IFugUW/AhEBoD1jTfpcaH4ySJhL
	xa43RCyARJlA7JSbm7Qz2G1AjMC1POjGm4/TSvW0ItWJiMFIsUqY6FQR9bv00FSgqZmEh+JMHIS90
	Lz/c3v37ZWV00suBSSYg35/HUQwp6gRx3K4M+ztjxCD/QRVq42bebUvIBG3San3hF0emRsEjgw2AK
	8c7zyrJVBhp9CtM8nX2y/UKodM7KIiK7HmpWdTMpkzbvbtzdzrM3kVp8AWDSnx0V6SGMXtvPw8JSs
	TtTAZR9dr5lMOcMpyE6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pg6Ky-006xZ9-1P;
	Sat, 25 Mar 2023 16:01:48 +0000
Received: from mga03.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pg6Ks-006xYN-0e
	for kexec@lists.infradead.org;
	Sat, 25 Mar 2023 16:01:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679760102; x=1711296102;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5dVs+q2gLQVLDGkLHXJqHU1Gk6hiIVR86jEv5ozZ6/4=;
  b=ZKPbKzGlBxEGK8PqTX6V1oPzF9yb1PdwX6DdiTzKT9Gn2Km+YwNFWNkn
   MayoguSys9M6RGSxPMRXxoeqTkj5eTEPmKnfxjyWWl7yYiiwEhPqUKg3E
   7/UMGAFpiOsqfcjnEviAU3NnI58n0S/sWIrqnGSpAyWgnRCQNwKi9lY5T
   S/KmCsEalefYAfkGcvSYUKNoiUmwswZUR65hlHM7ElEkaS5tPKJi34SoJ
   23GlujdbE+AvA/cmjfODwQox7mEB2ShUopURmTFjakRnaQmcH1Y5Z4ZCb
   ym9TKA6VUxkR9UwuXgyLuVfFEO0nLMRXIuvvfyBNXX8D5q9pB3945n+gV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10660"; a="342385466"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="342385466"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 09:01:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10660"; a="747506632"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="747506632"
Received: from benfis1x-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.47.35])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 09:01:37 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id D62E510A607; Sat, 25 Mar 2023 19:01:34 +0300 (+03)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] x86: Disable kexec for TDX guests
Date: Sat, 25 Mar 2023 19:01:28 +0300
Message-Id: <20230325160128.21857-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230325_090142_306959_130D8A4A 
X-CRM114-Status: GOOD (  17.37  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Kexec enabling inside TDX guest requires addressing several issues:

 - Avoid clearing CR4.MCE during kexec;

 - Convert all shared memory back to private on kexec, so the next
   kernel could start normally;

 - Add support for offlining secondary CPUs, so the new kernel could
   bring them up again.

The first two items are relatively straight-forward. The initial attempt
to implement them can be found here - [1].

The last item is tricky. TDX guests use ACPI MADT MPWK to bring up
secondary CPUs. The mechanism doesn't allow to put a CPU back offline if
it has woken up.

It is clearly missing functionality from the ACPI mechanism and it has
to be changed to allow offlining. The work in this direction has
started, but it takes time.

For now, disable kexec for TDX guests. It will fail kexec instead of
crashing on attempt.

[1] https://lore.kernel.org/all/20230213234836.3683-1-kirill.shutemov@linux.intel.com

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/kexec.h       |  3 +++
 arch/x86/kernel/machine_kexec_64.c | 10 ++++++++++
 include/linux/kexec.h              |  7 +++++++
 kernel/kexec.c                     |  4 ++++
 kernel/kexec_file.c                |  4 ++++
 5 files changed, 28 insertions(+)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index a3760ca796aa..89693684a7d1 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -189,6 +189,9 @@ extern void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages);
 void arch_kexec_protect_crashkres(void);
 #define arch_kexec_protect_crashkres arch_kexec_protect_crashkres
 
+int arch_kexec_load(void);
+#define arch_kexec_load arch_kexec_load
+
 void arch_kexec_unprotect_crashkres(void);
 #define arch_kexec_unprotect_crashkres arch_kexec_unprotect_crashkres
 
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 0611fd83858e..9a0ded12df70 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -600,3 +600,13 @@ void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages)
 	 */
 	set_memory_encrypted((unsigned long)vaddr, pages);
 }
+
+int arch_kexec_load(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
+		pr_warn_once("Disable kexec: not yet supported in TDX guest\n");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 6883c5922701..9fa88c191605 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -442,6 +442,13 @@ static inline void arch_kexec_protect_crashkres(void) { }
 static inline void arch_kexec_unprotect_crashkres(void) { }
 #endif
 
+#ifndef arch_kexec_load
+static inline int arch_kexec_load(void)
+{
+	return 0;
+}
+#endif
+
 #ifndef page_to_boot_pfn
 static inline unsigned long page_to_boot_pfn(struct page *page)
 {
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 92d301f98776..70e4923c135d 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -194,6 +194,10 @@ static inline int kexec_load_check(unsigned long nr_segments,
 			 KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
 	int result;
 
+	result = arch_kexec_load();
+	if (result)
+		return result;
+
 	/* We only trust the superuser with rebooting the system. */
 	if (!kexec_load_permitted(image_type))
 		return -EPERM;
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f1a0e4e3fb5c..d02b7eb0f6e6 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -331,6 +331,10 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	struct kimage **dest_image, *image;
 	int ret = 0, i;
 
+	ret = arch_kexec_load();
+	if (ret)
+		return ret;
+
 	/* We only trust the superuser with rebooting the system. */
 	if (!kexec_load_permitted(image_type))
 		return -EPERM;
-- 
2.39.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
