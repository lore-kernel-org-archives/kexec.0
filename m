Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6932DC25B7C
	for <kexec@archiver.kernel.org>; Tue, 28 May 2024 13:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j06IY4eD/NayJZpRHwUmvZ/IqEv5tv75LBEFfMenovo=; b=I7HjZsf4H22iVo
	jx9rDjBmYcwfKm4tnNeiacYfd/cMqPRvJTInm4Zbdu6DnF1DGeOJ583D0Dkpp/+QSuFEl5wqC7gzA
	4+HyadxYiIoCrrgCu8VtPONVlltDdBFSGNLSv2rRgCMNbP6bP6MkCe6Jx/9nxWzQe5Sidrs7/Muxc
	E9LisqucNwM5DRhHPDc0fcVs2MGNo8vCHeUvONOmqMB2L1k36smPBpGWPCfnd9jZy1bkVpJ3iOyP3
	rSPNcNBGuvhBwyviJDgfHWDM/TEks1vnRVyfX4xO1RLT2fdZkcWbakY1mtNr1mkNHLBmzShJKMTcy
	4PIQJNWhip9XZ50tGYVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBxBl-00000000s7A-1xev;
	Tue, 28 May 2024 13:48:29 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBxBh-00000000s1l-2sP7
	for kexec@lists.infradead.org;
	Tue, 28 May 2024 13:48:28 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7FD7E40E01E8;
	Tue, 28 May 2024 13:48:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CWC8d6f-MDCs; Tue, 28 May 2024 13:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716904086; bh=Guy/h4AS3sgPsJ1ZoSa+dXWo2WOj/mHMhGiRjv7+LKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UHVe+VJLKxqmmtkpxms4dUr0g/20OaUMpQ+JRwZRuN1GSfREbHsKJk+wWNo3sBASH
	 vViwlJqr0X3E50WR/RV2rb9br0vG7P4HHCH+X992vEcu8o8VsXdOmeuyfkfzoRk5Id
	 mgzRod/x6CXL2OrgSEKzUVLq8Uu+vHMoXNjAgq196nD2B3h+A/Tw27OwxJebUsH6uE
	 ijScMkhRN+y/S96jP/wtRYQSKM/SYysV+8dzCx6FOYVYob4GUH/b9wd0fB5Hg5CtQ6
	 IKtuoxENR6sgoU7MP53+xCfRN09gw1R31Hzmebne7xKPw0EUGPFOJZrOO1HX1X6Tq6
	 Bqct9q38hnC59egLzl+drAo7XKWQqQTUBT5/DjFEO036M7T0dZKdEadmeKJPsX6qXo
	 39ffhazzPIfSkpdril9twBshfoyvbb1EPnKelclQpzgWk0dl27wyKIn76sUM1R95Xq
	 ss4FKsfTLH7ncDroEpTC6jg8+W17ilVa/IviXbOgLEZTADalBxOE/TQEoEEy/LWHI3
	 lIlJ10Yqxydv1RkkysonL81mOsbiVkj0UQ2B01qSOiVfNrB8x2TMWJ9mGUzbujVkb9
	 bEbNGx+hklBRDxaaRRN1F5gGFwwkpY94w/BnLkhbtNxmwdA2zwdecVb4DnRC2XzFjU
	 DMFJEQBguDr6la4S4voQfyOU=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0A1B840E0177;
	Tue, 28 May 2024 13:47:39 +0000 (UTC)
Date: Tue, 28 May 2024 15:47:32 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv11 01/19] x86/acpi: Extract ACPI MADT wakeup code into a
 separate file
Message-ID: <20240528134732.GHZlXgdO88f3j0Biu9@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240528095522.509667-2-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240528_064825_909275_4A615B18 
X-CRM114-Status: GOOD (  14.08  )
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

On Tue, May 28, 2024 at 12:55:04PM +0300, Kirill A. Shutemov wrote:
> In order to prepare for the expansion of support for the ACPI MADT
> wakeup method, move the relevant code into a separate file.
> 
> Introduce a new configuration option to clearly indicate dependencies
> without the use of ifdefs.
> 
> There have been no functional changes.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Acked-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Tao Liu <ltao@redhat.com>
> ---
>  arch/x86/Kconfig                   |  7 +++
>  arch/x86/include/asm/acpi.h        |  5 ++
>  arch/x86/kernel/acpi/Makefile      |  1 +
>  arch/x86/kernel/acpi/boot.c        | 86 +-----------------------------
>  arch/x86/kernel/acpi/madt_wakeup.c | 82 ++++++++++++++++++++++++++++
>  5 files changed, 96 insertions(+), 85 deletions(-)
>  create mode 100644 arch/x86/kernel/acpi/madt_wakeup.c

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
