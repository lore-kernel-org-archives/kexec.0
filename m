Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAC9C27C4F
	for <kexec@archiver.kernel.org>; Thu, 13 Jun 2024 14:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JDK4WSPJvDqt1mfQR1jJrzrMgP5DqaY3dk9gq7hPzY0=; b=FAJvBsASrXjA4V
	+Ai9qLAVxrMyJZppeNfvf2GpgInqRSPWeZOCJULuJg6mBfH+4sV61pydO3e5N5yuFgPRCBX2Ufuci
	sHOrucTkVcr1ylm9BjuNpzNU3sUgZNp42lunHLxKZqhBbyRt0WttsjAgXQyg91W8Veqpx6BmpmnOs
	rI032x4D1YQ8k3VN7a8NPCtGdfvqpcImFiIuBfOnLw/e1tqRY3j9Ru9hMdmVE9mK30XUMM8U5OU4i
	UtwMTo/aXAeNVlcBreDpe2T1+NdDqh8mcS02knxAKk7aXTvs6vS91is8vWYCBN9GqKVhgh/06h5Bw
	AIcNDjKo7zgkXn9bYnHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHltL-0000000H3QO-1Dzb;
	Thu, 13 Jun 2024 14:57:31 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHltH-0000000H3NQ-1XIu
	for kexec@lists.infradead.org;
	Thu, 13 Jun 2024 14:57:29 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 371AB40E00C9;
	Thu, 13 Jun 2024 14:57:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VxFUwAUY_gPk; Thu, 13 Jun 2024 14:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718290629; bh=4PpkPfFOmQteTZnPUEGfiyHPxl3RB0xgm8bItFqnfk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ja3zVbuEKXRUlqooI8H7OOrG10geSsCj9PBH5w2Id4s1ieQGglEfA7XJoKDFTF9JX
	 epVhd/OSmSar4OcKkNykGLcf6rMfDeLqA2tharfM0zkRXHajeBWf4w7K+StiHBaYy+
	 UmDqQGt6Gj6JW1RRmZEYjjYb9ugcch3i4wkay5YCl94poFAL1newXDTzG4cEGkoLWv
	 NFTAg/aE+yDOGGuge2S6Ph8C9MIGPr1cm1iHz/TOedm1P4nH3dzgcwu7Oq6QCyNBwk
	 QYqYkNMfTqbbiiMnckCwDq3Z5e6kt+LlkdDk1O4x9qCwldl17tWmfZ2BUKjgNxXRbB
	 2/ckNhH1LU+HhGZC8VmO3+KkBDwJ8D7mUE2I63WKZGNOlnQdQt1ZalHutsPPm9fnfa
	 iiRJCFaTfi8wE5Zdz7IPFHXJpdKwMeCYplQvoz0iM+RgxPC9lN1fMVR9b3Ih9nGfd2
	 tHvDFD2YFDfqZ4+ljm6uk/Z4rpLfmpRIevGB+ZBZS5tJ12HYHcKp+jttN8SVc+N/uO
	 lNQqFpWTSFrXj2kUWtXUw/aAhSIR0kw7wNt9hBDphnTPZeQDgkW48SqxzTM10A7j0b
	 yquOA/Sp4tsEXR60IN3GhEe0pX6itv6tdbmM/O81pLhEwP+hGqkFA2xUtwPTWTTM8k
	 x1TfveMz3kITMZ845FfSr1YE=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BC90040E0031;
	Thu, 13 Jun 2024 14:56:41 +0000 (UTC)
Date: Thu, 13 Jun 2024 16:56:36 +0200
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
Subject: Re: [PATCHv11 18/19] x86/acpi: Add support for CPU offlining for
 ACPI MADT wakeup method
Message-ID: <20240613145636.GGZmsIpHn16R04QlaN@fat_crate.local>
References: <20240528095522.509667-19-kirill.shutemov@linux.intel.com>
 <20240603083930.GNZl2BQk2lQ8WtcE4o@fat_crate.local>
 <icu4yecqfwhmbexupo4zzei4lbe5sgavsfkm27jd6t6gyjynul@c2wap3jhtik7>
 <20240610134020.GCZmcCRFxuObyv1W_d@fat_crate.local>
 <hidvykk3yan5rtlhum6go7j3lwgrcfcgxlwyjug3osfakw2x6f@4ohvo23zaesv>
 <nh7cihzlsjtoddtec6m62biqdn62k3ka5svs6m64qekhpebu5z@dkplwad2urgp>
 <20240611194653.GGZmiprSNzK0JSJL17@fat_crate.local>
 <2kc27uzrsvpevtvos2harqj3bgfkizi5dhhxkigswlylpnogr5@lk6fi2okv53i>
 <20240612092943.GCZmlqh7O662JB-yGu@fat_crate.local>
 <w6ohbffl5wwmralg255ec7nozxksge4z4nnkmwncthxzhuv46d@qq46r2wrjlog>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <w6ohbffl5wwmralg255ec7nozxksge4z4nnkmwncthxzhuv46d@qq46r2wrjlog>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_075728_036992_C76331F2 
X-CRM114-Status: GOOD (  11.24  )
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

On Thu, Jun 13, 2024 at 04:41:00PM +0300, Kirill A. Shutemov wrote:
> It is easy enough to do. See the patch below.

Thanks, will have a look.

> But I am not sure if I can justify it properly. If someone doesn't really
> need 5-level paging, disabling it at compile-time would save ~34K of
> kernel code with the configuration.
> 
> Is it worth saving ~100 lines of code?

Well, it goes both ways: is it worth saving ~34K kernel text and for that make
the code a lot less conditional, more readable, contain less ugly ifdeffery,
...?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
