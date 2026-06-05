Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0259CD6E7C
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 21:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=czHxBAolVx1VraDScwu9+FjCluhxvvdJOEu/z08ODOE=; b=Y5Us+ZpJQ646ruFOxgsG0Quc5x
	nPniO8mcXzZ9Gr4L/pE2s9iV6995WvSR7lmSMT1gGJoB5Kp1cDqxuGj6Wt4dyP+PGNbpBRg3+y/lR
	8c8iZhzfVQpKhJ18g7qH8Nlq4osgjF+wpzD5c8MvuisT+Lj91gBdngOaSdO1KF505AoGvk6rLF7/c
	R1zDu0WEMxaycH8qPXqYF2Veqqx3loYKzCNaMARCgUxUf/DMzK7OXYMeMymMX2Fq0S93DOqfO8/p3
	M0/78H3Yt1d6n/9034bfmnsAyQ44ujFv+mpLeNwKXRAs0vN9r6aB3x3pk6FlZyREwyIqOqnOI4xiJ
	u4AnlcKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVbpq-00000001Bku-0suR;
	Fri, 05 Jun 2026 21:12:10 +0000
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVbpl-00000001BkP-3Bxh;
	Fri, 05 Jun 2026 21:12:09 +0000
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A7DAEEC0206;
	Fri,  5 Jun 2026 17:12:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 05 Jun 2026 17:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1780693922; x=1780780322; bh=czHxBAolVx1VraDScwu9+FjCluhxvvdJ
	OEu/z08ODOE=; b=VX88Al8obcXfoxjRgExahYgKrjn6grnWRYAtkqsTPjILQATZ
	J3t20mfP+NfKYuC0Dllw9PNsU54XX6DGRv9Bu+kOLn7rkGn2PvkIvRly6thsDQEn
	r2yTEvI2v2bSBXAqUmvHsCeYHMqK0RGBaiuDB0DTH3E0ta+OhbitYYh1wz5q8xew
	ZVIXJy033PEFMrFbHqVFwrKqzdb+bhtHXeAxpqvDLICR7AJW5I8yJ0CV8GtDjQBM
	r8lO/QURITe9ZO2k4nk9UrfV74q+SJ9HvwFKfnYFSrCDZRt12zy1zgNQr3pFG2IH
	nXff37xobHDhCqtzVD2YLT7MOh0AgxfBL53j0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780693922; x=
	1780780322; bh=czHxBAolVx1VraDScwu9+FjCluhxvvdJOEu/z08ODOE=; b=H
	00p6Q+nSFkftXzqgz7gPw81toaQYLcmOYe6+W8ZtVkTkByEY7IIEn6ideF3Yh2cs
	DJAw8iux16SCb8SV2tXO0bRBiyUeBB2SYWku6IiEesG2eOO3aHY1zKwtKdn6lr9y
	zGReszzPchLrP2ew7WCDYNSTP5CZm0UAl9M2srmmgdHPAvjscQn/0Yhxz1DD8VKf
	JB7P2M+LExZw9wZurOKbvxx2JVqOWO/kP10cYNRnCbsbQ0wtzb9SnBuulKFT9t9z
	DJTQ26IXcnEcP/okvPKwjQje0ae6QSOmRttWn1kb4bF/bKmQLmGAlu1cozdP9gH1
	vp38StTLP63z2PKkdq1rg==
X-ME-Sender: <xms:oTsjat85PCeYoOqO-_tPnLM2cq4BuoZFt-WOmd2w9hSpOEVTPVU2xg>
    <xme:oTsjak0AW1-0zxbVG-BVE4cgxe99b5QqiC6GvBCwSaxExlRMantsFmvAXmzata_qC
    9HJrr1oJYZCAIj4vARcXVa668k27WmEjZN9flsB9z1cMF-zqgWPvXk>
X-ME-Received: <xmr:oTsjaofgQI0e0VbyaHSzdJ3zAMs8Wf77Zgr2-xdbA9A6crx-_hKBjz5GlBONwg>
X-ME-Proxy-Cause: dmFkZTF6+RKNZQ2h+QZZ8V84GlsXWPKSHungM30Fc2pouxwSgqJm7MhKo7fs1dVyDK80uK
    qVH1x23rAWqn68hP3ng2DhcPR3tdN2vJOh29+FqGNN8qmvvrT7QVsG6qTgoDZ8AZbY3GDF
    qYi30DLyYPbfUHxkJmp9UfscujcPyGgkaak4vgoKESCkjHKbKiVahv2rlAbaxf5CYfrUAH
    MdDCLTFfmbgtZZSt/KFntxNdHe6iLMgz2Xjcv3o0g5Jued/LU8AafSnXk8UJM/4R1pN20c
    lJ7wXeHCu7nWm3FJnFNFC58hHGbWMeFznbu6FvQN/RfjXs28ubTdarP7m/30ALyBYCF7Kv
    ibcrV2d2hccGjRSGooJESWPsyJSHGanboeSvcWpxk6dajLu0U3TKJqMArDmkBQN0lmPTkD
    YVD/oPiezwPSN4FK634KjHM+zT16KLv/gMzgcpuWMPNgxNEHMvEeTY/E/VseHFOJ/ijPea
    KmEptg8112QdDRxOB1DZ5uRQEUUivPIiFF6K21MJvfIzYhhnRm7A1UqaWTt8xaBs6HyPmC
    IdC/F50Zus/uc7S6v6itFS3RiXsff3sWHgXjAkxmICcE/zV7M6QD9oYLlF+kZqNoqNHF/0
    u0a9LaV0KZPNOfNudiQ45D1hkY8+4EwFrWBlnfKKXUx7VV3N/udJDMwFwAbQ
X-ME-Proxy: <xmx:oTsjamBi74uXOSgp6IQUc-nKhUhAuRBO13WGIhGc0G4H_Ob1mpW4fg>
    <xmx:oTsjag1RrNKUst8DZ8tv2InyPk_D5DTwCkvq-MZHa2c6T73HrQfZ9A>
    <xmx:oTsjahMUt38BSOy88J9zHzQdE2yWOoB0Ib3avqNk1baU4OAMzMPuIg>
    <xmx:oTsjavZPsqKhI93Kvu847cCaVtYrNUUCPjukXaH9UFG9OwpwnVNuHQ>
    <xmx:ojsjailwItGn8nimtB2Zpm3krK0fGJOreir145z2GuaOShnhzq3c6d86>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 17:12:00 -0400 (EDT)
Date: Fri, 5 Jun 2026 22:11:57 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Doug Anderson <dianders@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Breno Leitao <leitao@debian.org>, 
	Julien Thierry <julien.thierry.kdev@gmail.com>, Lecopzer Chen <lecopzer.chen@mediatek.com>, 
	Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: wire SDEI NMI into the hardlockup watchdog
Message-ID: <aiM69AZXtGduS4VY@thinkstation>
References: <cover.1780496779.git.kas@kernel.org>
 <6172eafcb9de6e626c0f1c36426d67e1e562ed32.1780496779.git.kas@kernel.org>
 <CAD=FV=U4eJ__dQc1e8CGgj5sMDNrD1MgEEy9Cgj9M5n-WmYAXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=U4eJ__dQc1e8CGgj5sMDNrD1MgEEy9Cgj9M5n-WmYAXA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260605_141206_177474_854C51B7 
X-CRM114-Status: GOOD (  19.89  )
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

On Fri, Jun 05, 2026 at 01:03:05PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jun 3, 2026 at 7:36 AM Kiryl Shutsemau <kirill@shutemov.name> wrote:
> >
> > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> >
> > Select HAVE_HARDLOCKUP_DETECTOR_ARCH so the framework takes its backend
> > from this driver. A per-CPU hrtimer checks its buddy's heartbeat and
> > signals event 0 at a stalled CPU, which runs watchdog_hardlockup_check()
> > NMI-like.
> >
> > The source is chosen at boot: SDEI if firmware provides it, otherwise a
> > perf-NMI counter (pseudo-NMI) fallback -- one image covers both.
> >
> > Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > ---
> >  arch/arm64/Kconfig          |   1 +
> >  drivers/firmware/Kconfig    |   3 +
> >  drivers/firmware/sdei_nmi.c | 247 +++++++++++++++++++++++++++++++++++-
> >  3 files changed, 248 insertions(+), 3 deletions(-)
> 
> I'm a little confused about this patch. We already have a buddy
> hardlockup detector using the hrtimer, and it's even been improved
> recently to trigger in a smaller time bound. It looks as if you're
> duplicating bits of the perf and buddy detector here?
> 
> I don't think you need this patch at all. The existing buddy detector
> + patches #1 and #2 in your series should be sufficient.

You're mostly right.

Buddy + #2 covers the console case (the remote branch triggers the
culprit's backtrace, which #2 makes deliverable), and #4 gets the wedged
CPU's registers into the vmcore.

The one thing this patch adds that a config can't is boot-time source
selection: PERF-compiled kernels have no detector on a pseudo_nmi=0
boot, and PREFER_BUDDY costs the pseudo-NMI machines perf
self-detection. But that's arguably out of scope for the patchset.

I'll drop this patch in v2 and run PREFER_BUDDY here. If a runtime
perf->buddy fallback ever materializes, the gap closes entirely.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

