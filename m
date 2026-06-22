Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492D6CD98F2
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 13:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VhYrUb7h1ceN7c1359dj3nTTbFlAmP+g8Ve9c/DlBsA=; b=IHMZZvj7RGBaaEA+AOkCVt8sFz
	nWjvVWgij++JYB1oNmXxe7EmoGUUYmDNLmsWJtlCLr2sUtR3PN4638vaA6EG3ct/T6epusEV7syUQ
	LiTdMcELui6za5TcEHwAvNX8SlVxc23DoWelhVC0/dbjU40QVQ2qXXdwI/bf97f1yfkHtDoUOll+U
	/PMAvVNYkadLQMYjgwwzxlRKgl24MTRkvK+RKfl4vsaTPZHAPZWSVX6rSMCwxCY/sENrfwNeVp26T
	P0MJTzRAUty2AJljztK4zgF6E/NWu8gLLSO9mBUxOxuSTg4xuBKyEYAHkBI2N7VqSTFT9SFOmqxSa
	T5JhOsIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbf8X-000000052W8-3DjR;
	Mon, 22 Jun 2026 13:56:29 +0000
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbf8U-000000052UT-3KEt;
	Mon, 22 Jun 2026 13:56:28 +0000
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 7B815EC03E2;
	Mon, 22 Jun 2026 09:56:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 22 Jun 2026 09:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1782136583; x=
	1782222983; bh=VhYrUb7h1ceN7c1359dj3nTTbFlAmP+g8Ve9c/DlBsA=; b=m
	SsDfKiD2cH630Zdy/SJbvEi5P4JQ4rQKR0UCVykbHx9LLHIS2dZ+A5MlNFPdN/IR
	4sk8otmgZc0kv/zRy1Che5yRyhYggL+0pMICRWH+VGTn6WzkNY/vKOqK/G3kbp2X
	fhf8ywioqI6zn3aKfiPdrimQRye8bzsygoigarVcCpyQjoyvoMOIuCmz3VssYmwg
	KiWV4oAW8VEg9Lw533EMxXFoiai4Xh+sC323gRDF2NzCYT1QYUdcKZv2D/r3KXbn
	r2jNJCP7RWxWha/qqDdoq3PAFwSJvDHxsjXkXdQppDmk9yQ5g9vzqQjqraJelK+F
	mn0LDgHD6vkp4ufyuovEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782136583; x=1782222983; bh=VhYrUb7h1ceN7c1359dj3nTTbFlAmP+g8Ve
	9c/DlBsA=; b=b0Wfx/3NbppsfWoYbxNC2ruxZdxrftnfHesvtHOAqKUmywOC0U2
	rMAUzLwtIPmsgbXdg7q3OHZdwT/AjJxeX4tlW5xGUTycRjHnna5vacM3lyLBW5pZ
	WuKhEDu/fciu6ITX8qKWn485Pj1+KqCEpo7JoQNihoAIEuy6771Y8OM8b7ulo2Q7
	Vovf2I5pvcl0v0itw7nc9P/C+zIAXUWz1vhz7vDwHA/Hpqqj6w3WWoWykWAVH7Bf
	bZwcMRxR51FWQU5fwVWSrGYzQJA3GwbTMySU175jqpDZsOoetYnNTbPT2DyOayao
	/avq0fsKYTuOdHhBZPFZSA18W4UiZnVbE4g==
X-ME-Sender: <xms:Bj85ak3ztU2mXAtnNdkwjfWf09QSCs6zUenmBZqcqAsRn2Fr79wlqg>
    <xme:Bj85aiPIL3PRunl8mNfAFN_omXNTVSCDX2lMNAHNmL7l0dFg0OFSujB86zwQW3wzH
    ZUuMmvY0W3hFa0Tdn-j_kVz_5TUMbVfk3WfXcV9S3rhKxzlqum_syJx>
X-ME-Received: <xmr:Bj85aqU6rPd2VuWAtUu3DLIC_fPiHPnIYKKiWWWxec-PkWqqxNrf4nkxTsmrfg>
X-ME-Proxy-Cause: dmFkZTFVAQTYJzrx2W7OlPD6aFcXGSlPcnnF59aG+l2XDgTmGcFPJFGQnsUN5cE2dKxpgI
    z578lLxrbCJJN66dbD+VSeBdH6bvY+Y9JFpQm56gjdfUpiLlHFJTnyo5IZIT6oYkQC8z4K
    mOENqM5tUaw9/Ifn99nm6MrIPiqz3NZi7Nm1m0xjovE08nHsmFQ8rZBJ9CK6PDttvu5R3f
    lx0X4AsR+9hV0JtfNjgJNSZxn3cA6vo1BSRQGqMHYPomyQmR0mNiTI80lufNLeWC7lfGeZ
    OpXTH+J7gkxCBuMfzmkEVnox84g2eVlsYYY3dlwt4vRl8C0mbbSLDoyafaTKIR4WV9cxDY
    RAuFRjPWeUOy84SWHTzYytpxkRKYVmjoRC69AFoEoTRDsiBXogo5l7M+Y09hMMT0tFKHOO
    92plwmYN5lvJDB8Qu9ESa1bDTH8i4TeZrx/MIxO0OW06wSlTSlBrv83Vq5KOFv/sG6i4V/
    ZBEA119uKOcEKs4jsm8RDquIAw+kdrci7deQcTOCxYW5xZpv8Rg1GTm7RRXsh0Gx9k0nN4
    Ft2XcEDXygPghPzS4ToVgRTE4pIySTM8kJlA6/XrdgNh+ZoxhQoCsSyfMT6Rjd3LvAVpBx
    AT1ScoEhJu8+yQkgD3YYHJMO/Ed3vRMQ6ue/gHDxHwNGw8RFTeljD49qqRDg
X-ME-Proxy: <xmx:Bj85aia1Q2Yg_Mb2dD7XkEEuFDnxLTJ2zkzsA3N5CHWLvc4xHgHpxQ>
    <xmx:Bj85altzeY2T8jzx3Jldl3Nbp8awZNAus2ZXdaGkt2n3ZMtvUJkHFQ>
    <xmx:Bj85aknDyJnTaYyJi1m3eqs8ofZdjsUX4sySjZvcTLepqbFDDE2AJQ>
    <xmx:Bj85avRtbPmLZrdyUT3cNKCmlfDR_HU4Lx39VMIuJ6kVFl-VfuOabw>
    <xmx:Bz85aluqe3-yQ1Gzyq4aw2rgPyaw7xOwzSHKFe8ngO1SR0vItw3uRF8D>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 09:56:20 -0400 (EDT)
Date: Mon, 22 Jun 2026 14:56:16 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Doug Anderson <dianders@chromium.org>, 
	Petr Mladek <pmladek@suse.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
	Breno Leitao <leitao@debian.org>, Julien Thierry <julien.thierry.kdev@gmail.com>, 
	Lecopzer Chen <lecopzer@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] arm64: cross-CPU NMI via SDEI
Message-ID: <ajk-Vge2qhaY-TwJ@thinkstation>
References: <cover.1781709543.git.kas@kernel.org>
 <ajVLeseWOZn0XXY2@arm.com>
 <868q8asj1u.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <868q8asj1u.wl-maz@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_065627_315680_00C000A1 
X-CRM114-Status: GOOD (  21.31  )
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

On Fri, Jun 19, 2026 at 03:26:21PM +0100, Marc Zyngier wrote:
> > Does your firmware set ICC_CTLR_EL1.PMHE? I'd be curious to see the
> > numbers if the DSB was omitted on the enable path.
>
> I certainly don't observe this sort of overhead on the HW I have
> access to, and would like to understand where this is coming from with
> actual profiling data.

Full disclosure: the ~66% figures come from internal testing about a year ago.
I no longer have the details of the machine it ran on and can't confirm whether
ICC_CTLR_EL1.PMHE was set there -- it may well have been. I shouldn't have
carried those numbers forward without being able to stand behind them, so
please disregard them.

Here are fresh numbers from NVIDIA Grace (Neoverse V2). Importantly, this
box reports:

  GICv3: Pseudo-NMIs enabled using relaxed ICC_PMR_EL1 synchronisation

i.e. PMHE == 0, so the synchronising DSB on the unmask path is already
patched to a NOP (ARM64_HAS_GIC_PRIO_RELAXED_SYNC). What's left is the
floor cost of PMR-based masking itself plus the PMR save/restore on
exception entry/exit -- not the DSB. So this is the case Catalin asked
about (DSB omitted), and there is still a measurable cost.

A trivial single-threaded gettid() loop (1e6 calls, median of 5,
performance governor, ASLR off):

  pseudo_nmi=0 (DAIF):       178.4 ns/call
  pseudo_nmi=1 (PMR):        252.5 ns/call
  delta:                     +74.1 ns/call  (~230-250 cycles)
                             +41.5% wall time / 0.706 throughput

  --- u-bench.c ---
  #include <unistd.h>
  #include <sys/syscall.h>
  #include <time.h>
  #include <stdio.h>
  int main(void) {
          struct timespec a, b;
          clock_gettime(CLOCK_MONOTONIC, &a);
          for (long i = 0; i < 1000000; i++)
                  syscall(SYS_gettid);
          clock_gettime(CLOCK_MONOTONIC, &b);
          printf("%f ns\n", (b.tv_sec-a.tv_sec)*1e9 + (b.tv_nsec-a.tv_nsec));
          return 0;
  }

will-it-scale agrees independently. sched_yield (ops/s, median of 5):

                      1 task       72 tasks
  pseudo_nmi=0      3,195,656    230,824,534
  pseudo_nmi=1      2,253,753    163,914,837
  ratio                0.705          0.710

The ratio is flat across the whole 1-to-72 sweep, so -- relevant to the
scalability question -- it's a constant per-syscall tax, not a contention
effect. The impact tracks syscall/exception density: page_fault1, a more
realistic workload, stays within ~5%.

> The direction of travel is to deprecate SDEI. I wouldn't add more stuff
> on top of this interface.

I understand FEAT_NMI is the long-term answer, and I'm not arguing against
deprecating SDEI. My concern is the gap in between. By our estimate it's
10+ years before the last non-FEAT_NMI machine retires from the fleet --
for scale, we're still running Skylake today. So there's roughly a
decade where a large installed base has neither FEAT_NMI nor affordable
pseudo-NMI, and no way to reach a DAIF-masked CPU for an all-CPU
backtrace or to capture a wedged CPU in a crash dump. That's the
functional gap this series tries to cover.

Given the deprecation direction, I deliberately kept the SDEI footprint as
small as I could. The series adds no new firmware interface and no vendor
SMC -- it uses only the standard software-signalled event (event 0) via
SDEI_EVENT_SIGNAL, which is already present on these systems for
firmware-first RAS (APEI/GHES). And SDEI is only ever invoked in a "bad
state": to deliver a backtrace signal to a CPU that a normal IPI can't
reach, or to stop a CPU that ignored the stop IPIs. Nothing on any hot or
steady-state path touches it.

If even that minimal use is unacceptable on a deprecated interface, I'd
rather know now and redirect the effort -- but I'd appreciate a pointer to
what should cover this gap for existing silicon in the meantime.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

