Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70000CDE008
	for <kexec@archiver.kernel.org>; Fri, 26 Jun 2026 08:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AoJVBmYqkYYc7bgnl/B8M++q57EqJtQnmodoViGs4lE=; b=uMai+xwXanTCebZMTP2c9H/7ZG
	ZOd97HiW1wflDFc/41qsaU6XfWelhulp9cleymvDeRkbyrHfSH6fjmPYyoI0EpjPQmzoZUQKL//7t
	LWiO7ei4mV/eW1huE4XciDFo64aCJvg3C8xeDgXZMqcYnlC3o+M5YouabSrNoYqOnC0dRyhJM501C
	TMJzjiUR5EVhSnwIHF8bUG2w0hEscuJKHI3O1uU2UPICDmwnJcoWS0sEerc+k9ZdCC7FtP9WuwMmI
	wVv09raCzA5W6C3vxLRJTPznyV++v3K86V38qqx2G91RjmhIMtuUk0x3LFLFMXg522mYed4tWQVRO
	wiWIJUmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd1sc-0000000ArGC-0fAj;
	Fri, 26 Jun 2026 08:25:42 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd1sX-0000000ArDr-2gjA;
	Fri, 26 Jun 2026 08:25:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782462331; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=AoJVBmYqkYYc7bgnl/B8M++q57EqJtQnmodoViGs4lE=;
	b=JYLDaGLyOzEYrj7eDD5UH4PdP9PIGtrz7c5LkgDWqYRV56GiICd8bmep63xellvfgm/23ekOBGGLLjOnY/VgZpvuz98/RAuhZ8y0495Z5pi7OAdZXvXXF+VVWSwT2y0jDRB72KP1yqCSdIdloBZ9tjb0IJPrV72zhzw15kxv/Y0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=fengwei_yin@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0X5e6nOB_1782462325;
Received: from U-V2QX163P-2032.local(mailfrom:fengwei_yin@linux.alibaba.com fp:SMTPD_---0X5e6nOB_1782462325 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 26 Jun 2026 16:25:27 +0800
Date: Fri, 26 Jun 2026 16:25:24 +0800
From: YinFengwei <fengwei_yin@linux.alibaba.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Marc Zyngier <maz@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
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
Message-ID: <aj43dFtbcZHvWBv5@U-V2QX163P-2032.local>
References: <cover.1781709543.git.kas@kernel.org>
 <ajVLeseWOZn0XXY2@arm.com>
 <868q8asj1u.wl-maz@kernel.org>
 <ajk-Vge2qhaY-TwJ@thinkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajk-Vge2qhaY-TwJ@thinkstation>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_012538_595587_2B338B77 
X-CRM114-Status: GOOD (  31.17  )
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

Hi Kirill
On Mon, Jun 22, 2026 at 02:56:16PM +0100, Kiryl Shutsemau wrote:
> On Fri, Jun 19, 2026 at 03:26:21PM +0100, Marc Zyngier wrote:
> > > Does your firmware set ICC_CTLR_EL1.PMHE? I'd be curious to see the
> > > numbers if the DSB was omitted on the enable path.
> >
> > I certainly don't observe this sort of overhead on the HW I have
> > access to, and would like to understand where this is coming from with
> > actual profiling data.
> 
> Full disclosure: the ~66% figures come from internal testing about a year ago.
> I no longer have the details of the machine it ran on and can't confirm whether
> ICC_CTLR_EL1.PMHE was set there -- it may well have been. I shouldn't have
> carried those numbers forward without being able to stand behind them, so
> please disregard them.
> 
> Here are fresh numbers from NVIDIA Grace (Neoverse V2). Importantly, this
> box reports:
> 
>   GICv3: Pseudo-NMIs enabled using relaxed ICC_PMR_EL1 synchronisation
> 
> i.e. PMHE == 0, so the synchronising DSB on the unmask path is already
> patched to a NOP (ARM64_HAS_GIC_PRIO_RELAXED_SYNC). What's left is the
> floor cost of PMR-based masking itself plus the PMR save/restore on
> exception entry/exit -- not the DSB. So this is the case Catalin asked
> about (DSB omitted), and there is still a measurable cost.
> 
> A trivial single-threaded gettid() loop (1e6 calls, median of 5,
> performance governor, ASLR off):
> 
>   pseudo_nmi=0 (DAIF):       178.4 ns/call
>   pseudo_nmi=1 (PMR):        252.5 ns/call
>   delta:                     +74.1 ns/call  (~230-250 cycles)
>                              +41.5% wall time / 0.706 throughput
I tested the u-bench.c on a Neoverse N2 based arm64 server. The result
is as following:
   pseudo_nmi=0 (DAIF):       96.3  ns/call
   pseudo_nmi=1 (PMR):        169.8 ns/call
   delta:                     +73.5 ns/call

> 
>   --- u-bench.c ---
>   #include <unistd.h>
>   #include <sys/syscall.h>
>   #include <time.h>
>   #include <stdio.h>
>   int main(void) {
>           struct timespec a, b;
>           clock_gettime(CLOCK_MONOTONIC, &a);
>           for (long i = 0; i < 1000000; i++)
>                   syscall(SYS_gettid);
>           clock_gettime(CLOCK_MONOTONIC, &b);
>           printf("%f ns\n", (b.tv_sec-a.tv_sec)*1e9 + (b.tv_nsec-a.tv_nsec));
>           return 0;
>   }
> 
> will-it-scale agrees independently. sched_yield (ops/s, median of 5):
> 
>                       1 task       72 tasks
>   pseudo_nmi=0      3,195,656    230,824,534
>   pseudo_nmi=1      2,253,753    163,914,837
>   ratio                0.705          0.710
> 
> The ratio is flat across the whole 1-to-72 sweep, so -- relevant to the
> scalability question -- it's a constant per-syscall tax, not a contention
> effect. The impact tracks syscall/exception density: page_fault1, a more
> realistic workload, stays within ~5%.
> 
> > The direction of travel is to deprecate SDEI. I wouldn't add more stuff
> > on top of this interface.
> 
> I understand FEAT_NMI is the long-term answer, and I'm not arguing against
> deprecating SDEI. My concern is the gap in between. By our estimate it's
> 10+ years before the last non-FEAT_NMI machine retires from the fleet --
> for scale, we're still running Skylake today. So there's roughly a
> decade where a large installed base has neither FEAT_NMI nor affordable
> pseudo-NMI, and no way to reach a DAIF-masked CPU for an all-CPU
> backtrace or to capture a wedged CPU in a crash dump. That's the
> functional gap this series tries to cover.
> 
> Given the deprecation direction, I deliberately kept the SDEI footprint as
> small as I could. The series adds no new firmware interface and no vendor
> SMC -- it uses only the standard software-signalled event (event 0) via
> SDEI_EVENT_SIGNAL, which is already present on these systems for
> firmware-first RAS (APEI/GHES). And SDEI is only ever invoked in a "bad
> state": to deliver a backtrace signal to a CPU that a normal IPI can't
> reach, or to stop a CPU that ignored the stop IPIs. Nothing on any hot or
> steady-state path touches it.
> 
> If even that minimal use is unacceptable on a deprecated interface, I'd
> rather know now and redirect the effort -- but I'd appreciate a pointer to
> what should cover this gap for existing silicon in the meantime.
I couldn't agree more: We need a solution for existing system. And
like to see this patchset merged. Thanks.

Regards
Yin, Fengwei
> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
> 

