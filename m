Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7BBC4345F
	for <kexec@archiver.kernel.org>; Fri, 26 Apr 2024 14:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vm0EuRMB3tH4wWjKhHni9am6k0I25rLEUVOctmJrYUA=; b=wWKaay45NcUuLs
	9SvvgGygsG+T+3XQRde11FyMc/0kxAfy7d+YwUEgK8T9dUDhE2Nfw+Jj6KBOdKccuVp7cWOCyjYr6
	CiWDQIkKPTMY8/NYMK/5gj5+E7WzCPDJrHecF/+OxZMOsDTEqj9lk7pJN+tLClYnCunKXHIHHX0RS
	IGfj4B51cxigGIgwKwUNMgKcVxiPzFzE5k/FhCL2RWNj9MyRF96gX8g75mCGelMoh0jB+SdG9qqne
	gR1Et6FexA8GyX+WSKi+gtF1WRKyYXOy7HIEF7H+eIWU5cjGmwEywhmXUtEVQ5511u/iJJfw0SVdO
	g9y3pZowoijfqio35YgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0MT1-0000000CogQ-3i9f;
	Fri, 26 Apr 2024 14:22:23 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0MSx-0000000CoZy-3DJS
	for kexec@lists.infradead.org;
	Fri, 26 Apr 2024 14:22:22 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A561B40E0247;
	Fri, 26 Apr 2024 14:21:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4nr6ztsoQAeU; Fri, 26 Apr 2024 14:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714141312; bh=S5ZM4B6BQIwAX7AeKzf8qU0S9c3jJ6RtzIBBBo7BmUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F4nGAP97ss/AfZh+ukrQwTcMEJZtdG1sbwaKNitN20yduwb7gHFd0MAWB/POEXh8D
	 nozHf/jAPO67nYwIMAWGnobXVH4I9+cQSDjzocW+9DtmEIH1OnvtBm0hFGPV/leG0X
	 Ce22/yPF/rywQdXZb+wyke3fV0qTBcOd9LnAsuUVudQKKDngFQ9fH/cvs0ttQ4EsJh
	 wYiSzdh+75NsvdEH6Sh2G1HIoa1f6jov65xVjeSykBAJi4beDoKJwk4OR2xiboE+3s
	 uGgCvxWXagN5EM3q1csR1gL8/B8V2JPLXyGrI7z6G0ZHtQhRClB2Ue9DOp2r6wXazH
	 XVZt7T9mHCEYyEjzpAIqYPMvA1/R9QXPHfY4HKZwMaFcr3dOgYEIZJWnlclmdyOd4V
	 wKcNEziLWXGWpZyTYTJyzLLazZduq/dgqssRKUfbYz5WgZRElloS3+w54ACCPqD1cU
	 wNxIOYZ2IC1PX3QwwS7jy3XuiOk82910etfsfYTkkzLPa/fXyqrBgPNk1ThrRiRxkY
	 Fo9lecmpFLaE0M0GHDzFklziwJdgTFEFovOebmwJucq3vUXaGJJBFKgKtsDDgPz4Yc
	 FGPiAzTjFnyRvFE4L7TLOQlmY5vdAa4jBuPkfW5Q1zeRB+NeMCrYzOeYBUYiRYpwuo
	 ZD1iBr1Ua0SrdzHG8FVDY10s=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 42A2140E0177;
	Fri, 26 Apr 2024 14:21:26 +0000 (UTC)
Date: Fri, 26 Apr 2024 16:21:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, rafael@kernel.org, peterz@infradead.org,
	adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	jun.nakajima@intel.com, rick.p.edgecombe@intel.com,
	thomas.lendacky@amd.com, michael.roth@amd.com, seanjc@google.com,
	kai.huang@intel.com, bhe@redhat.com,
	kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] efi/x86: skip efi_arch_mem_reserve() in case of
 kexec.
Message-ID: <20240426142119.GEZiu4X8VPK5He4zH1@fat_crate.local>
References: <cover.1712694667.git.ashish.kalra@amd.com>
 <cover.1713222642.git.ashish.kalra@amd.com>
 <a3032e4b7a5406c26aeb66e9380043c410d07e3d.1713222642.git.ashish.kalra@amd.com>
 <20240424144807.GEZikbp0NjFP5AM_ms@fat_crate.local>
 <16b34494-7e5f-4feb-8a21-58e7b8fa97e2@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <16b34494-7e5f-4feb-8a21-58e7b8fa97e2@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240426_072219_982056_95B74D10 
X-CRM114-Status: UNSURE (   7.03  )
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

On Wed, Apr 24, 2024 at 04:17:09PM -0500, Kalra, Ashish wrote:
> With SNP guest kexec and during nested guest kexec, observe the following
> efi memmap corruption :

Before we delve any deeper here, lemme make sure I understand this
correctly:

* You're in a SNP guest and you're kexec-ing into a new kernel?

or

* You have a plain hypervisor which runs a non-CoCo guest and that guest
is a hypervisor too and it starts a level 2 guest and *in* *that* level
2 guest you kexec a kernel?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
