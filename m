Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F955C27C50
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 09:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=shAFLxBmR9S/SRagGwYfg+RUgFK3vK8UrV1WnH1EbMY=; b=UJV0orG9A7qSSv
	50Wu9MyqFPHRRSgs4L6aNC0800AkwmMAijiHEVW0pmf5FUjCw46q38dmWl91jRKluFQf5QsNvoGaQ
	ncHZ+F/UyLkijL3Irx/n7LqeHn4/pw1uSvGj2xnKDwRICa/biA30rh4gahSDd37snvIUcYd5Qgr8L
	T6PZNy3lsExouVeIPv4ah1O4jbrgPsnZQvJopMWm04pPsMiRwk4VBTurbyIg+KqMr9crfwiUO+lS4
	kUo891JSuRlhr5IS72X3FB4FzuPhigU2GF1MP43yTGdScRpzcsd+0v3O8cz/8dallQyw7F/pmqWlb
	R7iFkj0K2u2sfiBzgSMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEQGy-00000001oeg-2RDP;
	Tue, 04 Jun 2024 09:16:04 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEQGt-00000001oUy-47KI
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 09:16:03 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A3B6840E0176;
	Tue,  4 Jun 2024 09:15:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ulBYaKGPw-vH; Tue,  4 Jun 2024 09:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717492540; bh=m7NFIk8+6rvmt15s5vCen1cbEwqjokjsUgs57ILsKtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iSXAQOJn+SPDaD84vEh7wouOYiZfNCaoiWTp8IPjbiadFjeUbQ8PgOq9mgi7jWbuB
	 Rm3LQjYTbnpdicihxVy1yB07uSul8gr+Z1gaL7WeDAiwfwqkFMzX+2TGECuiXmhDA4
	 iSlqfTMjYs9AfTUpI055P9dnTsOjXQmdcnM5TeuC0Mbgo5lc56brjSNqBpHib4ypnO
	 gCmeqhMFDjnpAFTpEriJjZiYIQSt6rWHxHZP91+aq119WX55MnsAV/sDeoUt4lWHJ8
	 KFxtXI6OcP1YDtpUUwXpwY9rTFm6SOFEm9YUAQrKWrjC0TErYpKinePUPvrMt/AjaG
	 nhHNfSE9qW+YOI94ONFGWjwJqvQV3wtQUoBLS6TWKQFxhe4OUMqebRCfFLLNCYXcEV
	 U4g3HjizjUXvjeZLEQ55FODZEJkRqyH/e8O+n0MpgewAno8Fovq7xeyInc2IQS3L8A
	 k96/PUr5SRZjrEXHGz3hIay6/6WYwAPA5Ut5ILbQCy33psGebm4rsFuXUK5NG3Odlh
	 wWFWvJWDPZXAr+gwwH0jpG8nriHspHEfS6rXaK8FHG5wDXAo0FmyJUSTTPB6KHfG3Q
	 WhBJ+sqT/SIm6U9Ic2kvopPHvEQpFhwhmfiB1F3kgoVGjpbH+8W7qL4xFSLk/KWhG2
	 UKgi1KIS3RI6wwRh5/Bu5Muw=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A28D540E016C;
	Tue,  4 Jun 2024 09:15:12 +0000 (UTC)
Date: Tue, 4 Jun 2024 11:15:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
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
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv11 05/19] x86/relocate_kernel: Use named labels for less
 confusion
Message-ID: <20240604091503.GQZl7bF14qTSAjqUhN@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-6-kirill.shutemov@linux.intel.com>
 <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
 <t3zx4f6ynru7qp4oel4syza2alcuxz7q7hxqgf2lxusgobnsnh@vtnecqrsxci5>
 <748d3b70-60b4-44e0-bd81-9117f1ab699d@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <748d3b70-60b4-44e0-bd81-9117f1ab699d@zytor.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_021600_588325_69DEF365 
X-CRM114-Status: GOOD (  13.14  )
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

On Mon, Jun 03, 2024 at 05:24:00PM -0700, H. Peter Anvin wrote:
> Trying one more time; sorry (again) if someone receives this in duplicate.
> 
> > > > 
> > > > diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> > > > index 56cab1bb25f5..085eef5c3904 100644
> > > > --- a/arch/x86/kernel/relocate_kernel_64.S
> > > > +++ b/arch/x86/kernel/relocate_kernel_64.S
> > > > @@ -148,9 +148,10 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> > > >    	 */
> > > >    	movl	$X86_CR4_PAE, %eax
> > > >    	testq	$X86_CR4_LA57, %r13
> > > > -	jz	1f
> > > > +	jz	.Lno_la57
> > > >    	orl	$X86_CR4_LA57, %eax
> > > > -1:
> > > > +.Lno_la57:
> > > > +
> > > >    	movq	%rax, %cr4
> 
> If we are cleaning up this code... the above can simply be:
> 
> 	andl $(X86_CR4_PAE | X86_CR4_LA54), %r13
> 	movq %r13, %cr4
> 
> %r13 is dead afterwards, and the PAE bit *will* be set in %r13 anyway.

Yeah, with a proper comment. The testing of bits is not really needed.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
