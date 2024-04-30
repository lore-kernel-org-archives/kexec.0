Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9290C4345F
	for <kexec@archiver.kernel.org>; Tue, 30 Apr 2024 14:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=svnHcQeVUCn1zb18tecIzgPBcm1pIPQi2nTnW1DgpZc=; b=oUCEgwYXeynhQj
	ZpizVDH2ZayVtY2lvlO7GPtI/1Wdv8qj6FfAAxlVg2udAHxegDGLBfkJ3tMUfXz6pWXz7sOGGcxum
	h60sbxJzBSmiexFASXEwgUgbszuPwGiZsPpydHfS9QK0dSpy3dtXkmZ5TOPv6QMI8zRdQrlavfDvT
	mq+lYt7716b3pX7NGfi3+j/N6Z79NrWGlmPQseqIseDmGt1iPZKWKxFVn9E3Zf9MpWS3kkwOGVQW+
	udFx3H0AhVJ+RN1NjAxhoqPV3Zh5ZRBUoyAgjf5mIBua/UpvRCIGTxTnDYZ/zTkI46WtNIsPcxd2h
	HntzjJRgM0fqmJ+n6/7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1onT-00000006v68-2cfP;
	Tue, 30 Apr 2024 14:49:31 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1onR-00000006v4r-2ivH
	for kexec@bombadil.infradead.org;
	Tue, 30 Apr 2024 14:49:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ha0LjX0J0jUG9gde9CPxdLE46fxAysA7o9hmw6V2XA0=; b=IHbXVhUZZxF9pwjhJMLP+H2X96
	lOK8NO3eUKGmJwgylKW4rzDGsIRQ4UXkqEAerlJm6gDLiQo7RP9Q60j1YYJmLndqNzrKrpjGV8Y8n
	cBKGfPNwR8PvdQlvFz5F7pTHYWHPSyPW6vHt0o0KsSma6tGu/ZXWHNCHt/87c2gLzKK0GJxxyHieG
	LQrtTp+tPa0ShjPt4DYoVtXyW7lMVftZKtGkD1POUoYYo3Boo8e+5PQf3SlnP+Dee/rCaS9wsNwBI
	opbQ4yFtYDdwfpXxmnugokV3Hf58pciGMfhsABbzsF3q2m2vimSzJV+Q5f2iNH30TG/xyk8D8Ou7R
	13Pgocpw==;
Received: from mgamail.intel.com ([198.175.65.13])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1onM-0000000GzlN-28wF
	for kexec@lists.infradead.org;
	Tue, 30 Apr 2024 14:49:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714488565; x=1746024565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D8fOR3tKfUk/VedpB6Kp/qfPdRU/1bC9Ahf877NrOig=;
  b=WoyvR1s4KGcBUfbpL3WoPKAi+05CUOHUWPsq7BpFPBMPm0PP1vFEY2yg
   698NBaR/KCAax4R6XZhI93Kn4GyY8pSw8bJC2WQJsz1J1kAtDKee/How7
   YojeRpcmoelugztTzLgy2k8wKlkzfU/cd1DC8N2SzosQ5UzMT58DrfPKd
   cB0CJnEqNvK2oK6qzLLl7ps9++O/aL2becTACHVSYepgalFvhFVWTWZPQ
   +bJxNhYVoc/nlU3LSleixBL9QA+nLHbe+KPTPeMrjEANE6SZ/GnROl97+
   kt7bLA4zED7aKPPrpGtFK3FF/AXFhJykA9vhV5fqZOShSsKtSs+aqRqGp
   g==;
X-CSE-ConnectionGUID: ipJzTDXYRGqbgOiCya1Y8A==
X-CSE-MsgGUID: o+F/n0n+Qi2p0sm7nFXxDQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="21350245"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="21350245"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 07:49:15 -0700
X-CSE-ConnectionGUID: cK5AUJaAQWiWfFZrIJ3DXA==
X-CSE-MsgGUID: JhJfI17xS8CacJcZ6ZtrSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="31280904"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 30 Apr 2024 07:49:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4FF831A1; Tue, 30 Apr 2024 17:49:08 +0300 (EEST)
Date: Tue, 30 Apr 2024 17:49:08 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv10 05/18] x86/kexec: Keep CR4.MCE set during kexec for
 TDX guest
Message-ID: <rneuozes2fafzowtyftfhsqznapdr4tlfwpd5bbuw5ssvflaxo@fq3ufljshsid>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
 <20240430130323.GAZjDsG00Xdhv5mv8W@fat_crate.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240430130323.GAZjDsG00Xdhv5mv8W@fat_crate.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240430_154925_086571_47233DA5 
X-CRM114-Status: GOOD (  17.42  )
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

On Tue, Apr 30, 2024 at 03:03:23PM +0200, Borislav Petkov wrote:
> On Tue, Apr 09, 2024 at 02:29:57PM +0300, Kirill A. Shutemov wrote:
> > +1:
> > +	testq	$X86_CR4_MCE, %r13
> > +	jz	1f
> > +	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
> >  1:
> 
> Please add the below patch to your set. Those same-number labels are
> just abominable.
> 
> Thx.
> 
> ---
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Tue, 30 Apr 2024 15:00:16 +0200
> Subject: [PATCH] x86/relocate_kernel: Use named labels for less confusion
> 
> That identity_mapped() function was loving that "1" label to the point
> of completely confusing its readers.
> 
> Use named labels in each place for clarity.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  arch/x86/kernel/relocate_kernel_64.S | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 8e2037d78a1f..0077c9e562a7 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -152,13 +152,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>  	 */
>  	movl	$X86_CR4_PAE, %eax
>  	testq	$X86_CR4_LA57, %r13
> -	jz	1f
> +	jz	no_la57
>  	orl	$X86_CR4_LA57, %eax
> -1:
> +no_la57:

I assume all of these new labels have to be prefixed with ".L", right?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
