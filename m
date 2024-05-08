Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A569BC19F4F
	for <kexec@archiver.kernel.org>; Wed,  8 May 2024 12:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ln6Z2qoD7oU277CV68ShEGpWA1LFKzOMj3C8SLAHYFc=; b=L/rVg04h/uwrd4
	sCLPk2OAjPd3rtMwwHscpFVyb8vqKg26rumnfmBGTyF7al8PsSwr0I+YJYOKlqINALPYWXQzXMc5S
	PkzRpMp8JVLSdQ3qXcOQI5gqhQMYUiY/8vTCQAhYnuSUrVF8r4+2+pLfqjDJwkLYk2Ys5VZbqQZXa
	f30/Xl6frdOxJltaGAtpI7uyJstARjiPn2auVLrasDdkYRclh0Wwvb0G9RffuaLsV4ibrtqXsC+nq
	6DlfKPfAUr1inodiRhrXAYgz4BN7aDdXx/aoB5HsvJvtS9fyIrXICFhDlLXnsKBwnkZZ7kx0ZsCnO
	JZjw8LUjZqnaaQipzTUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4gAD-0000000FP3p-1Q5u;
	Wed, 08 May 2024 12:12:49 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4gAA-0000000FP32-14VT
	for kexec@lists.infradead.org;
	Wed, 08 May 2024 12:12:48 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 228C340E024C;
	Wed,  8 May 2024 12:12:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZMrQa-G91QOC; Wed,  8 May 2024 12:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715170361; bh=qN/y9cHUEBVLV8pGVkdG+RsChyPSuLA4sQE7tRTsrxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kr3l/QTGRMA0C5rE0e/SeORwk40rtp/+BlatDIUPkby0/3PC8MCiewul76UFf2in2
	 Ay+annVxKQt1fUIKjlAE9jM5vbfVrJ7kwvX+exRaaDaWUIzhXkcrVAr8RpNie+8Pp0
	 7x+CWCVvXEIhaPQ/Rtoh5RwlmMNh/c7NKfnmguE6pss4+qMg143hA1L+zgE59wn56d
	 pvcaw0j9kCRe0Qpve8BNC0VksaR/CzY4ImhJ2ai0G4vu2euysByIjJYc9V521UBSg3
	 iBFg+YhOhwo5BfeYDWxzhpa6vdducb2lole5f6sE65fX+MOV3EAB23pc3+Zbpln3fg
	 auKQXjxDb/bB7r9n/N/djgbl9qOOte9b+EraRYAwdcYuS3+sh1v7BYbt//8nISZtOW
	 /Cv2eGLyOHRJgvvoz52LrVXv6SXFOOOIgRK8iWZB+xGDWNQfF7Ro79R1+pXEOpFVbb
	 vcRn4Hxiy1Rj1YSUmQPlDMJBJBoeTlpSPZCWODe0ar9r8JW0abP5wYTK2QA/dI1QFm
	 bpfYE2Syrw3vTkaJg1p9otjauGTDojtkVyqHowuzJvuhhxSdcC8Vb3z8Z0J3xwenIL
	 mJGdwJbme+2f7xJd7Aa8LDT2ea/zGzWzCJW8YvL/dqG6QeX0t8ZRKD7p4BjTImLPJX
	 0RKhFREPvR17HSa7OwJ2IY20=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B01E140E01A3;
	Wed,  8 May 2024 12:12:18 +0000 (UTC)
Date: Wed, 8 May 2024 14:12:17 +0200
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
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
	Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv10 11/18] x86/mm: Make e820_end_ram_pfn() cover
 E820_TYPE_ACPI ranges
Message-ID: <20240508121217.GDZjtsIZmROSwirNUF@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-12-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240409113010.465412-12-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_051246_634237_7CDE9B49 
X-CRM114-Status: UNSURE (   7.90  )
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

On Tue, Apr 09, 2024 at 02:30:03PM +0300, Kirill A. Shutemov wrote:
> Subject: Re: [PATCHv10 11/18] x86/mm: Make e820_end_ram_pfn() cover E820_TYPE_ACPI ranges
						^^^^^^^

e820__end_of_ram_pfn()

> e820__end_of_ram_pfn() is used to calculate max_pfn which, among other
> things, guides where direct mapping ends. Any memory above max_pfn is
> not going to be present in the direct mapping.
> 
> e820__end_of_ram_pfn() finds the end of the ram based on the highest

RAM

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
