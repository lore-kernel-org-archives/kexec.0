Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB45C43327
	for <kexec@archiver.kernel.org>; Fri, 26 Jun 2026 19:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xZleOJPXENCZTiyBq0Gs6OTAspcEjOZFDjSgU59flgU=; b=cvnVPew6UnVoI2mBa05TdUXgeC
	3EyiTXip9dMR5PMGrCZoA6S9GHuIol1gd1c13UTevhDWvcxd+ng7sVSqdurjPuppxjF9TkUkgMNQ1
	bDmKbAt2VaOfcExDxDw+c568igQkpVt9UyrtqIT1M4L2srtGvYi9ogsRGpTlxgF1K+6+fp9VdrpRg
	cvspnYfta04qSXVagcuAW20CNxdpdQLileh9pCjFjeIveSNMcKQkiRVaEDNtwAun81ecMLGvOfS/D
	c80TsxlfHpqhJtSbtMVD3QHMzuAUjfLqbKXGfBUByiAjtYVAaPpxpUWuxWaDLtyszjcDLKeH4wxB5
	niSEsSfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdCQB-0000000BnGN-3RCL;
	Fri, 26 Jun 2026 19:41:03 +0000
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdCQ8-0000000BnFL-23gC;
	Fri, 26 Jun 2026 19:41:02 +0000
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2F804140011E;
	Fri, 26 Jun 2026 15:40:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 26 Jun 2026 15:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1782502857; x=
	1782589257; bh=xZleOJPXENCZTiyBq0Gs6OTAspcEjOZFDjSgU59flgU=; b=N
	c35uCDFov6urT3p2RzZ7fApzEqHgpOvrspC10elAhfsmS5G/MuInMb2HPPu9cbeP
	VmfEtwAmilyIHmbdMPlMLHkJ1RySgQYKBILdM+P45VYD/gGLcltuch+311/1ETUr
	K0W36N09WhQTJs49/Bs/18P2Wonjy6o+9qh13a8UCjW04NYGaNlb3DAZyn5YF3CU
	CouymF5fI9iWPlpXV0c8LYGQDaCEQk4elruC9fyf5NQX7t/fhKYKu1FiMumFVAsk
	vBWD0l/P3Oav7TrOzYMOlHtjP41ewai0w2pqnB4QjUq5wZ3YJcffBv+i+Rr7ALqO
	KyVLYP0Mq1zhOG9xI7JRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782502857; x=1782589257; bh=xZleOJPXENCZTiyBq0Gs6OTAspcEjOZFDjS
	gU59flgU=; b=BhMJ7aih3j1kXphoSb75WW/5H6a4SDRqBgygAM4eynysyEgghWf
	81pZfIjFpAYAxP/39YmzPoG1haC7kwogNvlxsX6bmITcK128ivLd5mVn3enCj4FV
	OgQDV5afuGpCazkX4LQXO2eWW6hVXydUhfkPMq89smj4uIY09qU9DXM399zPMXL8
	1amxDdhRtYdA6Jc0s945T222FIPUOVbYkgAB1/vJHPWd3DXPZ5gFtD9DrN8FkvTQ
	wYszW274a01gNViA9GorWzmH4UFOo3SNWmYOzM4d2HEqap0kgcCH6ilI1JIb3rvn
	VvAww7v2bxKz67LzAVPCsT6fo074SySQekQ==
X-ME-Sender: <xms:yNU-au9DY8JAgr8VoAwaKJL9hUF2fMmmSYd2Hhkhe9_iIyJnFYoVqw>
    <xme:yNU-aoE44fmalSS97GfowXIEpdokWzFayjQ1Z3T_eT98YZWgXFF3UvPfuIOl_DGND
    K3bY0GHHhmpWY0gC6iCLWMT5i3MKFS5MivWCTGWAQdA1_S-LdrmEGU>
X-ME-Received: <xmr:yNU-atJzt8HD811elOe0QZ0XM5PSCDYcvgwZ7Vz7XEupu-J9rN3Ox7BvcDSNDA>
X-ME-Proxy-Cause: dmFkZTGW1HqdjaJoFQUXHWjWh9D9hOSFIJsyccNvsLPRtGB9mH7fc1kAT7fHoGH3Hu85I9
    k/c3Z7Nb4r54bT5MEEkjmFGiJiu04ZC7NwEzcdsuQvf1CLqjpKYxBI27a6yWDq1/28x1RM
    8zsFgUAo5jkHgCzsB5V2Q5N6XYX2veo3WfywnhV2OHrN8xLBECodxM09aiaO1zN7R+k780
    Q9KUglIq75DgRugyZRP8YDl3KFlnOp8Qm3bbUE7ljJZEWPz9zlzS+4hWSMxULkCZ3gTwi8
    v2K1itOsX+A0jEIbKYds7EgZcectBAfujot9nNFh5LF86Pgk0OqsAih1iMEiHC0XosUek6
    FikrX9i3SEXmWGteumPlq9VIPvqQBefAve4qrFZNYi4HN4wHMrWgwwJeLbKX/gJoRSyehR
    N/Iugv5JP8nbxYKqmAJQAvZ4iT/j2HrdEVRP1fCNvAvtzi/RMAO1tQnTi4nhmq9g/Y2iZI
    txldL+oBIgDghSB13xufo5A4XXk3HDfUjFKqSvoQLyNih8F8f7WaLzevjwzUE0TOQxLkRU
    7dscJsqOjjAVXq6SaKqDVEf4wQumsUe3DUhfIgkuraxmEzSKge6K2L3mGVI9nGZvy+8ET3
    E/uHBaXi2Dkz1gFiIFdNzqQFbuVDkPL/BjUZBgreuZdp3fqZdQ+npzruknJg
X-ME-Proxy: <xmx:yNU-apcqoGlwx28Ophj9ToZArVvWERcA8TS9glkkY4KeB6H7S75Hfg>
    <xmx:yNU-atWvNBK2hxZZEke3Sa11aA-sT4FjIDXOoJvtA6zeItO749s_hA>
    <xmx:yNU-apDt9a5czOrxpRqPyrxWcTm8Popz8gVyf2gRbXvxxCtjQzKEcA>
    <xmx:yNU-as8bfiNEtpFDtKZlhU-isYgddu8R4liv_RldTRk-28lGWtB2ew>
    <xmx:ydU-asd9yeAu_0qH1gj3LsO4RTCSyEV81AjuP8JIB3_TxfYRzsDYTFTP>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 15:40:55 -0400 (EDT)
Date: Fri, 26 Jun 2026 20:40:54 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Doug Anderson <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Breno Leitao <leitao@debian.org>, 
	Julien Thierry <julien.thierry.kdev@gmail.com>, Lecopzer Chen <lecopzer@gmail.com>, 
	Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] arm64: cross-CPU NMI via SDEI
Message-ID: <aj7Pm5H0MN5WwhDK@thinkstation>
References: <cover.1781709543.git.kas@kernel.org>
 <aj6xvvY4AA-fQG2X@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aj6xvvY4AA-fQG2X@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_124100_953485_5EB50E8D 
X-CRM114-Status: GOOD (  18.61  )
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

On Fri, Jun 26, 2026 at 06:07:10PM +0100, Catalin Marinas wrote:
> On Wed, Jun 17, 2026 at 08:20:01PM +0100, Kiryl Shutsemau wrote:
> >   - A CPU stopped by the SDEI rung is parked, not powered off via PSCI
> >     CPU_OFF. Reaching and dumping the wedged CPU -- the point of the
> >     series -- works, and it matches the shared stop path's own park
> >     fallback when CPU_OFF is unavailable. The consequence is that an SMP
> >     crash-capture kernel cannot re-online such a CPU (it stays "already
> >     on"); the capture kernel boots and runs on the remaining CPUs.
> >     Powering the stopped CPU off so a capture kernel can reclaim it
> >     requires completing the SDEI event and then CPU_OFF, which hit a
> >     firmware-specific issue still under investigation; it is left as a
> >     follow-up and does not affect the dump's contents.
> 
> Just to understand, your firmware cannot cope with a PSCI CPU_OFF from
> the SDEI handler? This is one of the required calls to be supported.

I did chase it a fair bit. Bisecting on Grace: completing the event and
parking (no CPU_OFF) works, and so does the stack-switch + C-call setup
on its own. The hang only appears once I call PSCI CPU_OFF after the
event -- and it persists even with DAIF masked and the GIC PMR reset
first, so it isn't leftover interrupt/priority state from the dispatch.
It's a silent wedge: no TF-A exception report, nothing after the
last console line.

But I have not tried calling CPU_OFF directly, without completing the
event. I assumed it is required. Will give it a try when I have time.

Either way this is a side quest: it only lets a crash kernel reclaim the
stopped CPU. The dump itself is complete, so it's nice-to-have, not
required for the series.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

