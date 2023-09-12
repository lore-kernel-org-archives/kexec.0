Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853DDEE3F10
	for <kexec@archiver.kernel.org>; Tue, 12 Sep 2023 19:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ofBCffPHBjvn+wfIgP7eYvq+IWqbi59opEIRZ/+7Md0=; b=ncKP7lGSiM5FPc
	XujkyfQMVRJbOpKNvDoNcLWb9DpVrtWQTKuJ/1VhrCJyEBhIs33ENWsPaCcG94oCrt5ArA+aVQsEz
	eCh8Nh74Z6/UzbzU1IU3FTjlDUP0OcqSw8GDOHjqOq+Y5uXVXcnILyXzHf3fWa2wE1yneR3eJGyw/
	Oz4Lze/b/Eu5yeKJOj3np6BBDCBvpDC6KivBwzYuhYn2kXCUhmnYbhkBlwZkFLXU/KCwr/v6irGZa
	WfuDqG/BDyzj5kQcckT8CtwNL2YDD0OPG7XhMjN2NRP8a5+dm79nf4ormdsfNlCfDB3I4lG+vsqhH
	cNPm56P7HupkIUELyqig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg8zd-0042SZ-2F;
	Tue, 12 Sep 2023 19:24:13 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg8zb-0042RD-23
	for kexec@lists.infradead.org;
	Tue, 12 Sep 2023 19:24:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C60D661342;
	Tue, 12 Sep 2023 19:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF55C433C8;
	Tue, 12 Sep 2023 19:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694546646;
	bh=bSeMPRZdOhqkBgklu+WQU2Wv24CUcxj6J17hMG5Lse0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=PuI6NTqXJU1+0eeCQYHD6rSEuEYw4ZnM7mBwYquu/sX0RvZH+Jhs7y9VRQkXhAbyL
	 xBvBsyU+FexIyvaMBqcQoJ6f+2C0zRl+2rA+gk/kPp2QYtl/oQ3HuUV2k1eTYpyz7p
	 G+fwu6SXNVSexF23NKb+yri94kKCM6DLC2PUHoRXBgfOrC3CrFJHRyQGLM+M5kSsXT
	 /w27UER/0O/7DX9XtgOxXptOnlh3oq3lui/4zirGGH/q0WXC035zHXSPWzoeabA0nM
	 wyMWxvI5fFipZfe1Csmf3y2PeV2dOS0fC1lm5wCCfIVauFamAMBjbOUEwEecN1jxny
	 VVALdgkrEmIlA==
Mime-Version: 1.0
Date: Tue, 12 Sep 2023 22:24:02 +0300
Message-Id: <CVH6NGLENMPH.271W6X80061M@suppilovahvero>
Cc: <kexec@lists.infradead.org>, <x86@kernel.org>, <tglx@linutronix.de>,
 <dhowells@redhat.com>, <vgoyal@redhat.com>, <keyrings@vger.kernel.org>,
 <akpm@linux-foundation.org>, "Baoquan He" <bhe@redhat.com>,
 <bhelgaas@google.com>, <lennart@poettering.net>, "Luca Boccassi"
 <bluca@debian.org>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jan Hendrik Farr" <kernel@jfarr.cc>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
 <1d974586-1bf7-42e8-9dae-e5e41a3dbc9f@app.fastmail.com>
 <CVGVCYUGNKAI.1WYRZGI9HYDMC@suppilovahvero>
 <9580df76-c143-4077-8a39-b1fcc0ed37bd@app.fastmail.com>
 <CVH4GZXQFZ1F.2V5BIZNSKQ1FA@suppilovahvero>
 <5a67051d-eb21-4a96-acc4-40f829a59e23@app.fastmail.com>
In-Reply-To: <5a67051d-eb21-4a96-acc4-40f829a59e23@app.fastmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_122411_716751_2951AA18 
X-CRM114-Status: GOOD (  15.90  )
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

On Tue Sep 12, 2023 at 9:56 PM EEST, Jan Hendrik Farr wrote:
> > What sort of bottleneck does the EFI stub have so that we need yet
> > another envelope?
>
> Well I can come up with a few advantages of UKI compared to normal bzImage with builtin initrd and cmdline.
>
> 1. You already identified this one. Using addons to adjust your cmdline

It is not a benefit as this is already possible today.

> 2. I can use my normal initramfs generation tooling. Just install my
> compiled kernel, my distros install script will generate the
> initramfs. Then I package it up as a UKI. This will be a lot more
> awkward with a builtin initrd.
> 3. Measured boot. You can place PCR signatures in the UKI using
> systemd-measure. This will sign the expected PCR values for booting
> this UKI. I think with normal bzImage this will be a lot more
> difficult. If you place those PCR signatures in the builtin initrd
> this will change the kernel image which means now the values you
> signed no longer match (depending on how you measure the kernel; I
> don't think the normal EFI stub even measures the kernel in first
> place, but I could be mistaken about this)
> 4. UKIs are automatically recognized by systemd-boot

These are sort of "tautological" arguments. There must be some
objective reasons why this architecture was chosen instead of
other (i.e. using what already pre-exists).

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
