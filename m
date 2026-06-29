Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FC5C43458
	for <kexec@archiver.kernel.org>; Mon, 29 Jun 2026 15:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QadHf/c4nC9yt2VwHXLTFiroUss5lFXWZ9eyxJMcwGc=; b=KX/CGR96Vvobz3wORmeeEAaUKP
	pfG7BPLrw9svmJ9IQejw/f64/ovgHW4W/ZnK4yWi2r79ZTkO58HpqFjEPrK+sB7cDViXl9p5Uy9+y
	ywH8GJGVwUuf6sIJOlTvsRqdVMEI+kxjcyibvUL2fbvB0MTtCH9GEwWgN3HzEqyBl7V+Ce4sLGYGp
	ysJq9SDgZHfVnvl2k6dgJC9mRXMDflT2dqrJ7WeZ2vt7R9OBwSeonc5cm5S538XyPENMM7AoF8cJ1
	K06K+Se6xo+ZoVtSh/o0khklf6G10K84mc56jTugTXFXDrTJzpIG64IVtX1WyY/lpBuuCAKMpieYQ
	T2aLL5sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weEJZ-0000000F8S7-1Pt1;
	Mon, 29 Jun 2026 15:54:29 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weEJW-0000000F8RT-3Qgw;
	Mon, 29 Jun 2026 15:54:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56B93339;
	Mon, 29 Jun 2026 08:54:19 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9C053F673;
	Mon, 29 Jun 2026 08:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782748463; bh=PEmFDKBgCksf81j7VvtfZ7vWMDUHtqYjKsy1c3eLLHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q1Ds7g8LQm/f/sRY3aU8CRxFBcAhXW5+3DKKrIdJnaV+H333kFK30OtA740u8lsQq
	 2IpCqmDqJNRRLqAChO9LN4I1enJxHu5S2gEbGoT7vbXJxNI84W4Tq+RT22YtWNWJXj
	 F2D2POYOIFlmQpXS7/BHGFY3vpHzOTb0vAudG+hU=
Date: Mon, 29 Jun 2026 16:54:18 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Puranjay Mohan <puranjay@kernel.org>,
	Usama Arif <usama.arif@linux.dev>, Breno Leitao <leitao@debian.org>,
	Julien Thierry <julien.thierry.kdev@gmail.com>,
	Lecopzer Chen <lecopzer@gmail.com>,
	Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] arm64: cross-CPU NMI via SDEI
Message-ID: <akKVKhOsv6EJVFv4@arm.com>
References: <cover.1781709543.git.kas@kernel.org>
 <aj6xvvY4AA-fQG2X@arm.com>
 <aj7Pm5H0MN5WwhDK@thinkstation>
 <akJsQK2iG2oZ3vYE@thinkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akJsQK2iG2oZ3vYE@thinkstation>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_085427_043741_14D6010E 
X-CRM114-Status: GOOD (  25.18  )
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

On Mon, Jun 29, 2026 at 02:05:14PM +0100, Kiryl Shutsemau wrote:
> On Fri, Jun 26, 2026 at 08:40:57PM +0100, Kiryl Shutsemau wrote:
> > But I have not tried calling CPU_OFF directly, without completing the
> > event. I assumed it is required. Will give it a try when I have time.
> 
> Tried it now, and it doesn't work either -- in a more interesting way.
> 
> Calling PSCI CPU_OFF directly from the SDEI handler (event left
> uncompleted) reproducibly breaks the kdump capture kernel, and this
> reproduces under QEMU's TF-A, not just on Grace -- so it isn't a Grace
> firmware quirk.

I had a quick grep (with the help of claude) through the TF-A code and
it doesn't seem to be compliant with the spec. It should subscribe to
the PSCI CPU_OFF event and complete the SDEI but it doesn't. It seems to
handle CPU_ON but that may not be sufficient. It only EIOs the SGI once
the OS completed the event, which doesn't happen if you issue CPU_OFF.

> The test: a CPU wedged with interrupts masked is stopped via the SDEI
> rung; its handler calls __cpu_try_die() instead of parking. A/B in QEMU,
> changing only that wedged CPU's handling (everything else identical):
> 
>   - park it (current series):  capture kernel boots fully to a shell.
>   - CPU_OFF from the handler:  capture kernel hangs in early boot, around
>                                SDEI re-init, never reaches a shell.
> 
> Powering the PE off while its SDEI event is still active leaves EL3's
> dispatch state dangling, and the capture kernel trips over it. Completing
> the event first and then CPU_OFF -- what I tried originally -- silently
> wedges EL3 on Grace instead.
> 
> So both routes off fail, and the CPU stays parked. The dump is complete
> either way; only re-onlining the stopped CPU in an SMP capture kernel is
> lost. It's a cheap QEMU repro now if anyone wants to dig into the EL3
> side.

Have you tried SDEI_EVENT_COMPLETE_AND_RESUME instead? Just COMPLETE
won't return to the kernel. We have sdei_handler_abort() to complete the
event and, hopefully, you can continue with the CPU_OFF. It's a work
around the TF-A non-compliance but I think this is useful even if you
don't issue the CPU_OFF (e.g. no CPU hotplug, just the park loop).

-- 
Catalin

