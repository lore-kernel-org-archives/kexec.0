Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8168EC25B75
	for <kexec@archiver.kernel.org>; Mon,  3 Jun 2024 14:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H1kLXWbf4OazKc5sQCWNohEGKaDZUjX1WXW6+ISpbK4=; b=G7+Gw3ujwPztGl
	25HmYCsz3QBsIpNNVViMKWXwyCAOSazM2z2RFz4hvbJ2rwzBWV80aQo8dQIf8Zc/b9w93HSYBp5Bg
	Vomt9rdSFBRHQGZdLxCoOIiloBIleOLBsU6RVxv6/rcI0wSSSie4OeUNoCI+7p3Y0N4Zwg+oVM9ax
	iyQLPyn7HGYB6pkiMG+pCwYvx/Voyk2lQhlfNp1p+gPCHyUP1Ejdrz24DF69mdchwdcknKD1JEMZ5
	a/IQiB+/b2CzRkwsF6/owuCCJqtSWsRguKfZZpAAE1k9NBw/0A/408ODwGbXHm112rafJKsQ/bPGT
	NfiQ/4Y5sqbH+mysbqmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE8y5-0000000H8Yc-0k1u;
	Mon, 03 Jun 2024 14:47:25 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE8y1-0000000H8XX-3Jbk
	for kexec@lists.infradead.org;
	Mon, 03 Jun 2024 14:47:23 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6FCF640E016A;
	Mon,  3 Jun 2024 14:47:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Gb4dWofyMxa2; Mon,  3 Jun 2024 14:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717426033; bh=VL1yo98odqtq37ExaplA9J6PHtb1WIm7FJJQvcfweUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YXkrxRbI8PYf3jv4X7adpYPudQ/d8WcrvXAumyvQemvH/CIarQh3pyBNp7obyQlWb
	 WTEghwqKBy5z5z3E2j27MtB5rtJlHwsG3xU8PecD7Cwl+icI1oWO5Vfx6Cxp7/jdYO
	 rfW7KAuFP4PUkV7PuQxAPvE3s1CeJOYj4koJxxodLUFff17wfJ06BmGPz3e2ytnb8B
	 diH+J8bTELC6vW3P4qzGovZ9jYmnAS5E7gNAj6BdtYmwXWYOKzTeWABRJwMXwP8GG7
	 gpOJ8kucnAw99h87rJoVeP3YYIEF46mvGLNDLSfKvUoZHNwFrrh2LeJVQ7OX988xsd
	 RZ+cfjd3YQ636+6HdTbK+VJmqLwAVsHdJUFOvO8RIvQxH5TzeekLA8WzvlbI3tsqZb
	 2MAUo9S/lzjXCcmTy2O216qCeEfChlBb+xoQQvvW1yCg+NpMachzHY6ust5bGfQN3b
	 G79FA5T7Fi5Wc5GAstBPho+0xKJ5IkCPIEQv4AOWGadca1eHW9IBDVtBdsOamx4AMK
	 gTSAIdoz6wV41HWV7dXFY3zyVZLKS6fo2Pyx1KeRCUfpArw/GCpDs89Y1n9KDQaMks
	 6jdzgQmgg/H9iyABpJKAAQ5kk6qHy4F/GAgw1azq6m8CMcFkS9yYb/n44l2RVAGXi7
	 cPwi1PUA6AqljN7U6bB3bZ+I=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D763A40E0081;
	Mon,  3 Jun 2024 14:46:44 +0000 (UTC)
Date: Mon, 3 Jun 2024 16:46:39 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Mike Rapoport <rppt@kernel.org>, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org,
	hpa@zytor.com, peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Message-ID: <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <cover.1717111180.git.ashish.kalra@amd.com>
 <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_074722_013655_D8FF596C 
X-CRM114-Status: GOOD (  10.45  )
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

On Mon, Jun 03, 2024 at 09:01:49AM -0500, Kalra, Ashish wrote:
> If we skip efi_arch_mem_reserve() (which should probably be anyway skipped
> for kexec case), then for kexec boot, EFI memmap is memremapped in the same
> virtual address as the first kernel and not the allocated memblock address.

Are you saying that we should simply do

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index fdf07dd6f459..410cb0743289 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -577,6 +577,9 @@ void __init efi_mem_reserve(phys_addr_t addr, u64 size)
 	if (WARN_ON_ONCE(efi_enabled(EFI_PARAVIRT)))
 		return;
 
+	if (kexec_in_progress)
+		return;
+
 	if (!memblock_is_region_reserved(addr, size))
 		memblock_reserve(addr, size);
 
and skip that whole call?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
