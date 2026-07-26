Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E78DC531C9
	for <kexec@archiver.kernel.org>; Sun, 26 Jul 2026 18:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bajTzRfqbEOMEZh0AynaaPxjycs9nvGrQz4Q0pmWNeM=; b=iXVkrIfiwAb7TZUBna2DXljqpl
	OOIy1ZEGIC1EuL5foggC7aN4sVy5KhCJ/PXmH8uxW4QYRQ0Kp5g8152gQsPyQkyiyf37YEeEPMdj4
	Fq06J8PajfsyceyJ7LYn2QXqpVK74TtKuD5OptuSST95118YbFbVoy9n9ddDT2RNRwTbik6KpSg3a
	AHbu9rgqUbEFYjxtVdYrUdsdH9pEa8BoOQrTQKOiIPakpaBKGKGZPisdCUw3CyaMVIcHdwtV129hp
	VHXLVMxIYePVLdveu2ehXnFMiRav28u565OdWy4o6Z7va3O+UZhrZgwTkFo4ZUcUIXJIsthGu0Znt
	HHj8e8pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wo3h8-00000001Uwx-2fvj;
	Sun, 26 Jul 2026 18:35:26 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wo3h7-00000001Uwo-2PrN;
	Sun, 26 Jul 2026 18:35:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 84FEB60A6F;
	Sun, 26 Jul 2026 18:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675F21F00A3A;
	Sun, 26 Jul 2026 18:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785090924;
	bh=bajTzRfqbEOMEZh0AynaaPxjycs9nvGrQz4Q0pmWNeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fce73Hj5N+/AzPrSShZX+VlGeVnIjeqGBQFx/3d4zgTqVdX+KL6PdAV9JBO/LKN7V
	 HReUjnZVtZ9JQXutwLewQ1zx3iUlv8TwPz/u3p6Az9Rp+NuJnudiAcd+kRjnhv/X2J
	 t5xxpGmgEqqQHKYsFCCSwMoAztyeUlDskUyad5obMVRhbLht1tSJ7Wc3jUS6UEpNLF
	 SFCnMSgufbby15MVAhEqeRKEAjDB7Ipv7BuUEotN7+Yp5ET15PKPpNPpqi93ToD4qo
	 jGM+bOzTvWFYpe8/DZw3bUN7HEgpj/0qkfiUBpQJ3odDQbT5yW1A5YT49kCLQRc6c6
	 LBd5i2UTCn3GA==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8399EF40084;
	Sun, 26 Jul 2026 14:35:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 26 Jul 2026 14:35:22 -0400
X-ME-Sender: <xms:alNmauwlsCe0_RYCAM-Aw23KOu13fgJkWnWjQ6YiY6741eGcvri1iA>
    <xme:alNmatYvxphwZeqnfmPCHo5UvnOf_1H3HNBwz1b347VPY_Jv08o-Scv1TRDxoxg3M
    ayr8OuOOeJr-ZvwJ4sQDGqxK6uHep00vqiG95Ax6xSxfPfocQtwVKI>
X-ME-Received: <xmr:alNmatwz5eyJ1qzQsW5hif-xKaVqxnF3CaNnKZZrP1TmmRNJGUwgIY1FH7WOrg>
X-ME-Proxy-Cause: dmFkZTG0EtMps4K7/E77adivV7MLv/F4vqy+iYJ5InaxdmJRYEik2jKa1rYpVtZnOdebxQ
    SXIlXAaWVJgfp/tPj5wNe+YwQOIRA3SDq5+iadpdhUxiJeZkK1C10QzRW8JfZTm/EBDpn6
    UzNjVNWszpBmZh5SYPfxQ5md0w+Fi3DlaEz/huniQkb2iwl68tpEyJA5P13SXw7JaiLRWi
    PeT8lZqONfwPBGo5WIadhRrwtW7gI89J2/nzKwuuRcEPfcF3MvqoI/MUwr/ZAgNK7mjvbh
    0NlA4cJsxkg61OZocgbbAbaiKgCsHS5spNdylzzhuk2DGr1uYmtMN2D1XDI7GrXHpxUMlS
    vz8sF1e8okDfSs/+xdJ1dPmNPyhO/PQW+FNkBr6cu/TuYQcEQfi3ORC39LTnUC4KmZnFb1
    wkew+Aj1Ycs2wtSnCBA77qOOD2btaMWnjyJoRKaqyUTLWAL5NKVkSl/sKVP/dlm27qznsU
    gK0b4ykKUzA5uG+nm/uYG3LgJOq6wdlTEMUqBnJpagMKsH/sUlS/Ltsr/XkLuG7E+CNwgt
    YbKZnRDr+EQ+1xoKOup25xkv8ndAnZaAwCL2YxVOu0ZxTFvmA4gOKaBg4vLQHJcSMM0pLr
    ZKNPf425Z2RgkFFA9n36/4cnclroQALPVUm6qkzQ8jMpqOgFWrI/EtvoqOUg
X-ME-Proxy: <xmx:alNmapE7IXDpJ59sCfR_DCkz2i74J8chbvs9hdAbqVeK_64Ev1zPTg>
    <xmx:alNmaurQM3zGgLvmYoVJCECIs23xucuT2TeJn_rJlX_5mXayu8yTug>
    <xmx:alNmaiwTBfE0O1llOvWvcisrsTeED7Uvzge9vfFw1Gqi7jbrLdfgww>
    <xmx:alNmaptjJM3bVHNpxLrHCHB2GhKkvGnbLF2ubKTRxV6E4DyeZVZ5KQ>
    <xmx:alNman5AeBdwDeXwYf1LMDLoCufw0EBFjXpBKAY-AOZc8cnTOUlrSaa9>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Jul 2026 14:35:21 -0400 (EDT)
Date: Sun, 26 Jul 2026 19:35:20 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	James Morse <james.morse@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Doug Anderson <dianders@chromium.org>, 
	Petr Mladek <pmladek@suse.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
	Breno Leitao <leitao@debian.org>, Julien Thierry <julien.thierry.kdev@gmail.com>, 
	Lecopzer Chen <lecopzer@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/4] arm64: cross-CPU NMI via SDEI
Message-ID: <amZRtS2Lu1epc0S4@thinkstation>
References: <cover.1782744912.git.kas@kernel.org>
 <ak_IRHwd02EjWMf8@thinkstation>
 <amYR5VWHWC1WdFXc@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amYR5VWHWC1WdFXc@willie-the-truck>
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

On Sun, Jul 26, 2026 at 02:55:49PM +0100, Will Deacon wrote:
> On Thu, Jul 09, 2026 at 05:16:37PM +0100, Kiryl Shutsemau wrote:
> > On Mon, Jun 29, 2026 at 04:07:14PM +0100, Kiryl Shutsemau wrote:
> > > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> > > 
> > > A class of debug/observability features needs to interrupt a CPU that has
> > > its interrupts locally masked: the all-CPU backtrace behind sysrq-l /
> > > RCU-stall / hung-task / hard-lockup dumps, and crash_smp_send_stop()
> > > capturing a stuck CPU's state into the vmcore. On arm64 these need a
> > > mechanism that reaches a CPU spinning with DAIF masked, which a normal IPI
> > > cannot.
> > 
> > Gentle ping. Any feedback?
> > 
> > I'm looking forward to finding an upstreamable solution to the problem.
> 
> This is all pretty small, self-contained and it's useful to you, so I'm
> inclined to merge it.

Thanks!

> However, the one vague concern I have is about the direction of SDEI in
> the future. AFAIK, the TF-A implementation is known to have issues, it's
> not supported at all by R-FA and I worry that the spec is going to fall
> behind the architecture, particularly as FEAT_NMI becomes available.
> 
> So it would be good to understand what we're signing up to maintain here.
> Kiryl, do you see an (eventual) migration over to FEAT_NMI, giving us a
> path to deprecating SDEI altogether, or do you think the two will live
> alongside each other for the forseeable future?

Realistically, the foreseeable future.

FEAT_NMI is the endgame and a machine that has it needs none of this,
but non-FEAT_NMI parts stay in fleets for many years, so I can't
honestly give you a date for dropping SDEI.

While this change is pretty self-contained, I understand that SDEI infra
maintenance can be a burden.

Is there anything on the wider SDEI infrastructure that would lower the
maintenance burden or keep it more out of your way -- consolidation,
tighter isolation, docs, help carrying it? If there's work there that
makes SDEI more palatable to keep while non-FEAT_NMI parts are in
service, I'm glad to take it on.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

