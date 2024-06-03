Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FC8C25B75
	for <kexec@archiver.kernel.org>; Mon,  3 Jun 2024 16:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=60zggv7hCDTO+aVtRmw4VpJAcHfwP8kVC/HrnY2S65Q=; b=CkOM4grvh8uGZw
	Fn+zrTqJ2IjDsVu9brsHAMHz2NCRXKbkFDnYJ4l78/3qi+riiVjfig4Z6WdZDv+usMeXkvCd8XPjG
	7FCUDTSny1H81oBbyiYUnhRb4I+0T26y4ljEmbns9eQvyaoQtJBkKxC4kNVKLFIFUm0x9eNJutNJS
	nT0gEjF4BxDa9wmXT0T1Zsz/APAKjsDrKk/QxolcY42oNVeAZfXxCVychZ40e+kRfNWYKP/9i79Ph
	+6vukrKquCcpeISM+n0iGC+9yNYhNaPkNrDFYKb+CHTKtSnb4xXRqAkkxIu+tuc+z4FBauzd0bzAH
	vr6bGAPPX1vvBdpM/Sbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEB0x-0000000HR4J-44El;
	Mon, 03 Jun 2024 16:58:31 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEB0v-0000000HR35-0DdJ
	for kexec@lists.infradead.org;
	Mon, 03 Jun 2024 16:58:30 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9475D40E016E;
	Mon,  3 Jun 2024 16:58:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7mEEOYRQqEWz; Mon,  3 Jun 2024 16:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717433897; bh=5Ye8WQXQcDM0Pbn/WLfdstI1LprqRnXUsBOMSmIce1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TE1Juqy6WPbqwr6uB9fEtuD3rF3JlqT7316Kf427rRDAvagZPD12LRCbcRhJtiCEG
	 A+IbVVBf/HxDtMrzsg/i43YFHSIBUQ0jKZw2Slc52HIdCWpy8WQtm9cqKrCvqjo9hL
	 0i0RNRAoojit05frOOu2qH7rMOoIn1KmWU+5w5tSie6d89Mbj/+uPDIFwZTY3VU+b1
	 Jf04JSqAqYa/wRKrfJxjQnVWQGQZjCIQhc3dXMKXesQeqs0zmrh5MQ1iutL6uCs6Vy
	 4s6NQoearde7AF9/5hOpDlGiZ4rN+G2L/W8PqbSqokd3ldcswvipHcksTZJtn6nrFi
	 VgZ42KmNxeLpdQN3zKZ4UaXm/G0JirSW9fGp56NtAdl6gSnVufixs8seDODtpA40RK
	 6Zhh7E+2cRvFfWa/ZShtfnkAoFnU4LC22n2N1fygbD8e0lk8U6KiZ5yIBJU+ZXpYM9
	 CavqhJurk9OFIP+JaOl88Y4uJXUKi56SaMzdLhk741XRX3uH0KzyFIsFFiFedzqCAD
	 RKWQnhlaPlezhC1erdtYPJjKBQ27Gs4QDcMUul0/Ddl/4SlzV1bDCV89Y0cXENwCpU
	 QFLvzqUfjt4tRoGzqaA+3p4chOhbEU4CVGExemMMBE4KH97LH66t4/dJLPAtOexNCT
	 QmBw/4QTQvWHDolYRXt4dgiQ=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 22DF840E00C9;
	Mon,  3 Jun 2024 16:57:48 +0000 (UTC)
Date: Mon, 3 Jun 2024 18:57:47 +0200
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
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Message-ID: <20240603165747.GGZl32C9yrmXJ4nhPT@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <cover.1717111180.git.ashish.kalra@amd.com>
 <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
 <Zl3hwYL2GDiyUfGo@kernel.org>
 <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_095829_297110_97D983C3 
X-CRM114-Status: UNSURE (   7.92  )
X-CRM114-Notice: Please train this message.
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

On Mon, Jun 03, 2024 at 11:48:03AM -0500, Kalra, Ashish wrote:
> Yes, something similar as above, as efi_mem_reserve() is used to reserve
> boot service memory and is not necessary for kexec boot.
> 
> So, Dave Young (dyoung@redhat.com) had suggested that we skip
> efi_arch_mem_reserve() for kexec by checking the set EFI_MEMORY_RUNTIME
> attribute as below:a

efi_arch_mem_reserve() or efi_mem_reserve() altogether?

Btw, that below got really gibberished by your mail client. Snipped.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
