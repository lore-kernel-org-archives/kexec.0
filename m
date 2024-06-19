Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F78DC27C53
	for <kexec@archiver.kernel.org>; Wed, 19 Jun 2024 10:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v+BMsJNFjf7lHdqJUE8tf68WQ/nrr6OF/k+YhspvsgM=; b=zLVlsTlAN+fQaH
	xLAIeiQo+WOu+2zZgsXOlHNtUJpolaj1UjcI4WMjdm1RWvUm9BDeFNe4xj1qAaoQL6aB6uuf/ay82
	SIfRZm59T4ynLgLz+XobHGfNVPuufHluXOVBKUiI561K4QXbAwSqmZ22J+hP/VHlTIdgukOoxBWOy
	Atn+kxR1/rDxw0M0oB+SyTcPin63I/4NhIMS9QyGVdqJxxufXSeYVmZr3HSs6sZfdVVG/+Oa8m6sl
	Sc1IHl1enrK3qlPJFYE4FsiR0u5VW1We0FS4ET54TdMCquoAZ5BogOq1DyAXHVYE1LpYNgotv7cYW
	tHYOXxClpuQIQAU2TlTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJsSt-00000000mb7-2hhN;
	Wed, 19 Jun 2024 10:22:55 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJsSm-00000000mXM-3Lj6
	for kexec@lists.infradead.org;
	Wed, 19 Jun 2024 10:22:52 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4143140E01A5;
	Wed, 19 Jun 2024 10:22:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tqsSqcqMWpEs; Wed, 19 Jun 2024 10:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718792561; bh=NtIsvmuAB5lmdfcT3XAT/v26mliNMhCSNzj+OQIz5tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NEH71NANb/E51X70+ikDKU6tmHUoKWInDWTo3zpEvrAGRrmaRZfo6SSfDrj9/q8NC
	 fWtI/14idZ2pllxb2IfZF/f8eND1uFlpZKN/jXK7MQB52Aaxnq4TbvYRsq9646JgmH
	 vQ9IWVVC/YP5QWoi/fdsLTYT9m9Tmsd8ZCQiOHHrF+uVXjc3/6Sh0bSHdj+JfQF5AT
	 DUo7bi3dDz3I37UXduIQn8L3gIZ9tbDjh6WRaadjNfTOIHuYLmpWA8tmocgpfHpmTL
	 AYwuj3wtLhO4as6xQmFQtOvmDMy9FmDOIoD9HiHJdo++ER0CgLBn9QM5XcGUP3DPbb
	 mVbAKRwJ37subPuO2yULPAku+kZa+Pmzw2ZPtwejl1KKq1cRwj/FmnIpu8O+CYmlmD
	 faL/KvFRvbBCcZjYRdsw3H53Z3DxiO/EYxzSdRSUPb7AmnCNtAg6Gp65uR8b1pcYHk
	 BQDOhy+SmkxLfEi+Sv+RMYauFr9+UGISmgz349M47mCTPP2ZMlPuHPzvbNDRUhf+Ms
	 WRnVObtmgdWVKMK4Dq2w8Ci+JHSRzhjs5C+KuYtoHSloEric2dCPS0cBW6PSpDEJNJ
	 MwieToCG5XS5swFuvIepnKb3pjUSy0aUhd4fLJ/33Z9ccI2h/sNX6KKYDbqoLZkZ7h
	 DMeYTDph41w6KTINsm60HCFc=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 92C2640E0219;
	Wed, 19 Jun 2024 10:22:12 +0000 (UTC)
Date: Wed, 19 Jun 2024 12:22:06 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, rafael@kernel.org, hpa@zytor.com,
	peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, dyoung@redhat.com,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] x86/boot/compressed: Skip Video Memory access in
 Decompressor for SEV-ES/SNP.
Message-ID: <20240619102206.GGZnKxTv-nE88Omvwb@fat_crate.local>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
 <cover.1718657194.git.ashish.kalra@amd.com>
 <ff99398317efde228d3632b3876832676d11cd01.1718657194.git.ashish.kalra@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ff99398317efde228d3632b3876832676d11cd01.1718657194.git.ashish.kalra@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_032249_092240_365384A8 
X-CRM114-Status: GOOD (  20.90  )
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

On Mon, Jun 17, 2024 at 09:15:12PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> Accessing guest video memory/RAM during kernel decompressor
> causes guest termination as boot stage2 #VC handler for
> SEV-ES/SNP systems does not support MMIO handling.
> 
> This issue is observed with SEV-ES/SNP guest kexec as
> kexec -c adds screen_info to the boot parameters
> passed to the kexec kernel, which causes console output to
> be dumped to both video and serial.
> 
> As the decompressor output gets cleared really fast, it is
> preferable to get the console output only on serial, hence,
> skip accessing video RAM during decompressor stage to
> prevent guest termination.
> 
> Add early_sev_detect() to detect SEV-ES/SNP guest and skip
> accessing video RAM during decompressor stage.
> 
> Serial console output during decompressor stage works as
> boot stage2 #VC handler already supports handling port I/O.
> 
> Suggested-by: Borislav Petkov <Borislav.Petkov@amd.com>
> Suggested-by: Thomas Lendacy <thomas.lendacky@amd.com>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  arch/x86/boot/compressed/misc.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Use this massaged version for your next submission:

From: Ashish Kalra <ashish.kalra@amd.com>
Date: Mon, 17 Jun 2024 21:15:12 +0000
Subject: [PATCH] x86/boot: Skip video memory access in the decompressor for SEV-ES/SNP

Accessing guest video memory/RAM in the decompressor causes guest
termination as the boot stage2 #VC handler for SEV-ES/SNP systems does
not support MMIO handling.

This issue is observed during a SEV-ES/SNP guest kexec as kexec -c adds
screen_info to the boot parameters passed to the second kernel, which
causes console output to be dumped to both video and serial.

As the decompressor output gets cleared really fast, it is preferable to
get the console output only on serial, hence, skip accessing the video
RAM during decompressor stage to prevent guest termination.

Serial console output during decompressor stage works as boot stage2 #VC
handler already supports handling port I/O.

  [ bp: Massage. ]

Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
Suggested-by: Thomas Lendacy <thomas.lendacky@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/boot/compressed/misc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 944454306ef4..826b4d5cb1f0 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -385,6 +385,19 @@ static void parse_mem_encrypt(struct setup_header *hdr)
 		hdr->xloadflags |= XLF_MEM_ENCRYPTION;
 }
 
+static void early_sev_detect(void)
+{
+	/*
+	 * Accessing video memory causes guest termination because
+	 * the boot stage2 #VC handler of SEV-ES/SNP guests does not
+	 * support MMIO handling and kexec -c adds screen_info to the
+	 * boot parameters passed to the kexec kernel, which causes
+	 * console output to be dumped to both video and serial.
+	 */
+	if (sev_status & MSR_AMD64_SEV_ES_ENABLED)
+		lines = cols = 0;
+}
+
 /*
  * The compressed kernel image (ZO), has been moved so that its position
  * is against the end of the buffer used to hold the uncompressed kernel
@@ -440,6 +453,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	 */
 	early_tdx_detect();
 
+	early_sev_detect();
+
 	console_init();
 
 	/*
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
