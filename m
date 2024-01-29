Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56BFC47DA9
	for <kexec@archiver.kernel.org>; Mon, 29 Jan 2024 11:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MfntMQ99k0+WvhLZNfnjCULoq51oTugwS+Vc0o3QT+E=; b=mLQ0UToP5vJe4v
	VV+Qu2IgyQ8k0CtSNTG+APNInqIldmIONp4WxyeZoeCgWjsbF7CPIYdm5QgIKrus28xpiGCxdAkLr
	tTQ34hIAn8f3GdO3XNQlFZd3VHGR6gChXELKvzfedYzADgGvYhLQGFUmltjYdwdmG9x6uwh63hF3+
	xCSs5f7/0y5HW5/7rXUEYeI4XzfUN7/VEaViYX9+PRaSQOkZ7tcg1MRsAqS4SUmozlheS+gJcLMz0
	uwp0XQbNNDwT16XXhC64HnSMlNo2pb0I4nq6XdvKX7yMbGTpZhXyvQK1f16LL+vkCzGm93iDDShF6
	6UogncDN5FB9zBhhZ4kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUPad-0000000CMse-0Aq9;
	Mon, 29 Jan 2024 11:14:11 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUPaZ-0000000CMqh-32UD
	for kexec@lists.infradead.org;
	Mon, 29 Jan 2024 11:14:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706526848; x=1738062848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I4gxSa9YE8dZelntOrU+Hi4kAJP1ulsGJuomatELRgY=;
  b=PLXdZQBXrFbo25ZV2gOoOH//kXVUtu2SzVzV0ZFixR9XqZ5vVT+G5YeI
   pvw9K14rSVc/i4GhlhPxkBqcuBzcFJvjwa/OkcFEb8NCKZktUnbmG0RYf
   QAeeZPr3pYZoJL5ohKj6Vezxnk5tWZjWZF9SBalTJUz7UoekZ2TcA8H3j
   UOoM0sOB8bZuNQg7q0i349wTEaX7LopG/O0FggThUwlLIb0ggH5sexeSv
   HEW4o/S/5xWKlP5y29q9PwsJGaujuvWoITo6fisjfwtiqHkKxGFUn3VfT
   jirAKJXFwCMBBBKa8w5Eu6YRJEEk1Z0yA4GIx4HN1fEH8OCSme83WDIhE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="21448890"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="21448890"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 03:14:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="878044370"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="878044370"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jan 2024 03:14:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 29C46125; Mon, 29 Jan 2024 12:36:09 +0200 (EET)
Date: Mon, 29 Jan 2024 12:36:09 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Sean Christopherson <seanjc@google.com>, 
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 10/16] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <r5logoyy46fztohkm6bjobomsrst2izbs2nsts4fegii2uswca@fovizly7y5ju>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <20240124125557.493675-11-kirill.shutemov@linux.intel.com>
 <f0677a02-72ea-49e8-9499-18eca6b5e8d7@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f0677a02-72ea-49e8-9499-18eca6b5e8d7@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_031407_888206_EBEE4FC4 
X-CRM114-Status: GOOD (  14.16  )
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

On Mon, Jan 29, 2024 at 04:24:09AM -0600, Kalra, Ashish wrote:
> In case of SNP and crash/kdump case, we need to prevent the boot_ghcb being
> converted to shared (in snp_kexec_unshare_mem()) as the boot_ghcb is
> required to handle all I/O for disabling IO-APIC/lapic, hpet, etc., as the
> enc_kexec_unshare_mem() callback is invoked before the apics, hpet, etc. are
> disabled.
> 
> Is there any reason why enc_kexec_unshare_mem() callback is invoked in crash
> case before the IO-APIC/lapic, hpet, etc. are shutdown/disabled ?

Not really. Either way works for TDX. I've tested the patch below. Is it
what you want?

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 6585a5f2c2ba..3001f4857ed7 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -107,11 +107,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 
 	crash_smp_send_stop();
 
-	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
-		x86_platform.guest.enc_kexec_stop_conversion(true);
-		x86_platform.guest.enc_kexec_unshare_mem();
-	}
-
 	cpu_emergency_disable_virtualization();
 
 	/*
@@ -129,6 +124,12 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 #ifdef CONFIG_HPET_TIMER
 	hpet_disable();
 #endif
+
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
+		x86_platform.guest.enc_kexec_stop_conversion(true);
+		x86_platform.guest.enc_kexec_unshare_mem();
+	}
+
 	crash_save_cpu(regs, safe_smp_processor_id());
 }
 
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
