Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BA1C43334
	for <kexec@archiver.kernel.org>; Tue, 28 Jun 2022 23:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i1DJUvyA1+hQnDyxVc9e7i4Gs1hDDXjR37XHIssnQwY=; b=2Vw2PIVH2iFUvA
	vT1DnN6CFFQTmBOhALiyrZw1t6FojcyUbHNC24DNIh6cRPX/gnh/uSQT2JeZx0rWvjS/AaBzpjXOh
	PA+EEnVut59tsLWYOKVCvgKFxzrdsaTiQS6QAmGGB5PTwATLUubt0Y/gof0v5H+iI3VHNdxZhtWy1
	F40mWpsOYyEXoAYW4x9mFKp0W1rCtvtWf9BbrfL4vV31w0G0PMR1rJ19IoPcz9OmaYPDj/8bqlx1C
	Z84kJxiC8fUuOms/giwsflAKZTwXDgEQroCcANEg5VbiYZcNE8RAvZxUWlNmNaLuFYl6wOYMkv9GS
	n5bBn7UBKuvhiHoovYsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6Kz9-008h2x-NB; Tue, 28 Jun 2022 23:51:11 +0000
Received: from mga05.intel.com ([192.55.52.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6Kz6-008h1X-Gg
	for kexec@lists.infradead.org; Tue, 28 Jun 2022 23:51:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656460268; x=1687996268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dI3HshvmacGZNIxLwiGqhbPCAPM3w/IVmJ97bcAXWCk=;
  b=elUgXQ+eaWXqS3tP1wxNsGwjY0GRVB79Xr2zVo3PR1brbq3U7fqTjXv2
   MFuCWmbqx2LbM+Nr+YmsR0N1MkEOfhSG6CAX9DYmeVaN/wfEW311tZyHX
   12r+l+MxJn4daXPRh/hXmEhQE76SLphqb0Gy5BKke/T/iAmtZ6W9/qU8h
   q+JcAl011Se5MoRtaisW2d9VbOHy3xbyjeblWVXJsfL7OEEWyb/TfEvo0
   NsLJlr4jgjYzf8x9F/bjN0atLaE8OPLOUfJMcK8KWKd2BWfxHkpK+bImk
   Q4L9cKXEUHfj649RE9C0FQDGGgsczZiQD3AQyp24LtMTKVsM8uZwmnUO9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="368190799"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="368190799"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 16:51:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="617363723"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 28 Jun 2022 16:50:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 95514CE; Wed, 29 Jun 2022 02:51:05 +0300 (EEST)
Date: Wed, 29 Jun 2022 02:51:05 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Joerg Roedel <jroedel@suse.de>, Ard Biesheuvel <ardb@kernel.org>,
	Andi Kleen <ak@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Varad Gautam <varad.gautam@suse.com>,
	Dario Faggioli <dfaggioli@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>, marcelo.cerri@canonical.com,
	tim.gardner@canonical.com, khalid.elmously@canonical.com,
	philip.cox@canonical.com, x86@kernel.org, linux-mm@kvack.org,
	linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCHv7 11/14] x86: Disable kexec if system has unaccepted
 memory
Message-ID: <20220628235105.z6ytdzxofrdkjti4@black.fi.intel.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-12-kirill.shutemov@linux.intel.com>
 <6be29d38-5c93-7cc9-0de7-235d3f83773c@intel.com>
 <87a6a3aw50.fsf@email.froward.int.ebiederm.org>
 <20220624020005.txpxlsbjbebf6oq4@black.fi.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220624020005.txpxlsbjbebf6oq4@black.fi.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220628_165108_624736_E98CB060 
X-CRM114-Status: GOOD (  23.95  )
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

On Fri, Jun 24, 2022 at 05:00:05AM +0300, Kirill A. Shutemov wrote:
> > If there is some deep and fundamental why this can not be supported
> > then it probably makes sense to put some code in the arch_kexec_load
> > hook that verifies that deep and fundamental reason is present.
> 
> Sounds straight-forward. I can do this.

What about the patch below?

From 0b758600e1eef5525f2a46630ab3559f118a272a Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Tue, 10 May 2022 19:02:18 +0300
Subject: [PATCH] x86: Disable kexec if system has unaccepted memory

On kexec, the target kernel has to know what memory has been accepted.
Information in EFI map is out of date and cannot be used.

boot_params.unaccepted_memory can be used to pass the bitmap between two
kernels on kexec, but the use-case is not yet implemented.

Disable kexec on machines with unaccepted memory for now.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/mm/unaccepted_memory.c | 16 ++++++++++++++++
 include/linux/kexec.h           |  2 ++
 kernel/kexec.c                  |  4 ++++
 kernel/kexec_core.c             |  5 +++++
 kernel/kexec_file.c             |  4 ++++
 5 files changed, 31 insertions(+)

diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
index 566c3a72aee8..529c3fd1dab3 100644
--- a/arch/x86/mm/unaccepted_memory.c
+++ b/arch/x86/mm/unaccepted_memory.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kexec.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/pfn.h>
@@ -98,3 +99,18 @@ bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
 
 	return ret;
 }
+
+#ifdef CONFIG_KEXEC_CORE
+int arch_kexec_load(void)
+{
+	if (!boot_params.unaccepted_memory)
+		return 0;
+
+	/*
+	 * TODO: Information on memory acceptance status has to be communicated
+	 * between kernel.
+	 */
+	pr_warn_once("Disable kexec: not yet supported on systems with unaccepted memory\n");
+	return -EOPNOTSUPP;
+}
+#endif
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ce6536f1d269..dfd9493d0b4b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -396,6 +396,8 @@ void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
 void arch_kexec_protect_crashkres(void);
 void arch_kexec_unprotect_crashkres(void);
 
+int arch_kexec_load(void);
+
 #ifndef page_to_boot_pfn
 static inline unsigned long page_to_boot_pfn(struct page *page)
 {
diff --git a/kernel/kexec.c b/kernel/kexec.c
index b5e40f069768..352b3742f07a 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -195,6 +195,10 @@ static inline int kexec_load_check(unsigned long nr_segments,
 {
 	int result;
 
+	result = arch_kexec_load();
+	if (result)
+		return result;
+
 	/* We only trust the superuser with rebooting the system. */
 	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
 		return -EPERM;
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 4d34c78334ce..4d51b9271f6b 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1238,3 +1238,8 @@ void __weak arch_kexec_protect_crashkres(void)
 
 void __weak arch_kexec_unprotect_crashkres(void)
 {}
+
+int __weak arch_kexec_load(void)
+{
+	return 0;
+}
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 145321a5e798..d531df94ffbb 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -324,6 +324,10 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	int ret = 0, i;
 	struct kimage **dest_image, *image;
 
+	ret = arch_kexec_load();
+	if (ret)
+		return ret;
+
 	/* We only trust the superuser with rebooting the system. */
 	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
 		return -EPERM;
-- 
 Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
