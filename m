Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3D6C369D9
	for <kexec@archiver.kernel.org>; Wed, 30 Apr 2025 12:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l4rDJaOTk4RX7FoHJnTSsKAbG34bCLAXiDBoAAm9OcM=; b=hahyUZWyrwrqf5gj38iqW5uz/L
	3AmdIe0xBJ7NOM4dxctoV1slgi/HCFCUFkuTClBF/DFE4b01nhdx7TUrupDhf31FQZDciRB1NjSWh
	F+Y9vRAgQAvI8ZZItoK9TdR2T6aUdIz+MMvxM5BkqNUsCeEGbiep5sjMhTWAFs0RQbPAMhohpKZvF
	oo3U+EBy8GmBvYFzuJ8GU9/Whlq0tf0+7Pd85i5+t14QOF1cBXQgH642ltNTqzbVbrh7T3TmGf2XU
	v9INdOntaih6x5HyHT7AjnGyjVayURDQZ4Mu31tSSeJEQ3udL2pBR1wY6+R3GRjZ5m6H8nd54NlCX
	P7PK45NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA6r7-0000000Crxl-1Qce;
	Wed, 30 Apr 2025 12:48:05 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA6r4-0000000Crw1-2g3W
	for kexec@lists.infradead.org;
	Wed, 30 Apr 2025 12:48:04 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D757C40E0214;
	Wed, 30 Apr 2025 12:47:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6ZDrEEMDyFL4; Wed, 30 Apr 2025 12:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746017273; bh=l4rDJaOTk4RX7FoHJnTSsKAbG34bCLAXiDBoAAm9OcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CkTOKCTu6r9r7oTTgdAtjKYYLKzO7MAayVNsqYCb+LF6qA5CtYCFurnaHYsbnI41f
	 UJj/PsWAXJsq/uyZNTClJ5zMaRzJGHvV/ejIqju502V2xCzPeeEqyscUkDo3ZeDEQ5
	 iBNZjQ6q27YQCbxAw3nSw3eALjegi5UCf+bY0pOO5OvMJ79WLVZSbg5apeZbS9S8aB
	 HUa0xpyNtvx8uBD+WWzH0zSkei6D8lu0sUTqB1uuws+etTH1DBY4TLjWtF46s9N98y
	 1DCSKreREjQlPt8lTx/iZIMHOxg7EBsqmFoTwa9bM06E88mjD/ZrH+0HR4rgSgvXAF
	 qlvs8Zt27laVfQFKLmnbZSZznx+cSEdoXEjNLPZs67vcLxifs2Z49frZoij8ouB4ki
	 hbKcL66canvNhpAcSzQcOUj6CKJFRwnnj3CZmgzW0/W1hjhI6Nl8CihFyxrLXIr+wX
	 yJsjXUuzwKUOSmILxo2nsicbyERq7WVbI6ndQXVYhqTBipUlWQC7d+thj+OylOPxxv
	 R8yqu9SipOYpZOzU9RFddmpY+vX51Y9pJm4X3BS4+dS9Ff1EU12hv4STnb8rXgMjRq
	 YOFLz3GQSbXQySFNrkYme3kwWyG6n0jpig92FaDliNo6Z8wITA0rhf72PhZYactIGM
	 nzyCZYzlcgTKqxRsAmTVf+nQ=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DF8CF40E0174;
	Wed, 30 Apr 2025 12:47:33 +0000 (UTC)
Date: Wed, 30 Apr 2025 14:47:28 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, thomas.lendacky@amd.com, hpa@zytor.com,
	kees@kernel.org, michael.roth@amd.com, nikunj@amd.com,
	seanjc@google.com, ardb@kernel.org, gustavoars@kernel.org,
	sgarzare@redhat.com, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev
Subject: Re: [PATCH v3] x86/sev: Do not touch VMSA pages during kdump of SNP
 guest memory
Message-ID: <20250430124728.GDaBIb4JTMxW2zO9gB@fat_crate.local>
References: <20250428214151.155464-1-Ashish.Kalra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250428214151.155464-1-Ashish.Kalra@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_054802_833192_B4A04D94 
X-CRM114-Status: GOOD (  19.16  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Apr 28, 2025 at 09:41:51PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> When kdump is running makedumpfile to generate vmcore and dumping SNP
> guest memory it touches the VMSA page of the vCPU executing kdump which
> then results in unrecoverable #NPF/RMP faults as the VMSA page is
> marked busy/in-use when the vCPU is running and subsequently causes
> guest softlockup/hang.
> 
> Additionally other APs may be halted in guest mode and their VMSA pages
> are marked busy and touching these VMSA pages during guest memory dump
> will also cause #NPF.
> 
> Issue AP_DESTROY GHCB calls on other APs to ensure they are kicked out
> of guest mode and then clear the VMSA bit on their VMSA pages.
> 
> If the vCPU running kdump is an AP, mark it's VMSA page as offline to
> ensure that makedumpfile excludes that page while dumping guest memory.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/coco/sev/core.c | 241 +++++++++++++++++++++++++--------------
>  1 file changed, 155 insertions(+), 86 deletions(-)

Some minor cleanups ontop:

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index b031cabb2ccf..9ac902d022bf 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -961,6 +961,7 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 
 static int vmgexit_ap_control(u64 event, struct sev_es_save_area *vmsa, u32 apic_id)
 {
+	bool create = event == SVM_VMGEXIT_AP_CREATE;
 	struct ghcb_state state;
 	unsigned long flags;
 	struct ghcb *ghcb;
@@ -971,8 +972,10 @@ static int vmgexit_ap_control(u64 event, struct sev_es_save_area *vmsa, u32 apic
 	ghcb = __sev_get_ghcb(&state);
 
 	vc_ghcb_invalidate(ghcb);
-	if (event == SVM_VMGEXIT_AP_CREATE)
+
+	if (create)
 		ghcb_set_rax(ghcb, vmsa->sev_features);
+
 	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
 	ghcb_set_sw_exit_info_1(ghcb,
 				((u64)apic_id << 32)	|
@@ -985,7 +988,7 @@ static int vmgexit_ap_control(u64 event, struct sev_es_save_area *vmsa, u32 apic
 
 	if (!ghcb_sw_exit_info_1_is_valid(ghcb) ||
 	    lower_32_bits(ghcb->save.sw_exit_info_1)) {
-		pr_err("SNP AP %s error\n", (event == SVM_VMGEXIT_AP_CREATE ? "CREATE" : "DESTROY"));
+		pr_err("SNP AP %s error\n", (create ? "CREATE" : "DESTROY"));
 		ret = -EINVAL;
 	}
 
@@ -1168,8 +1171,8 @@ static void shutdown_all_aps(void)
 		vmsa = per_cpu(sev_vmsa, cpu);
 
 		/*
-		 * BSP does not have guest allocated VMSA and there is no need
-		 * to clear the VMSA tag for this page.
+		 * The BSP or offlined APs do not have guest allocated VMSA
+		 * and there is no need  to clear the VMSA tag for this page.
 		 */
 		if (!vmsa)
 			continue;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

