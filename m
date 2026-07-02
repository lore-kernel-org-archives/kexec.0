Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B82C43458
	for <kexec@archiver.kernel.org>; Thu,  2 Jul 2026 13:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6NWmfe8Dq8JrZ1DQwcJzSv5BvctIaK/5J/1ExFQCV9M=; b=ADvWp9flO+q6lETMY8koB4ea1Q
	FdxX6OpI6gDdYPi34U2MgpgMPphBvpFwyke+eF2LZyyLJBryB0wsKzt2T2xo5lRawz21J+A1GEmJo
	gjmJOFYz/euRlSgeJlvgfb1BmE2UWrKr2tN1kNc+JC3/qIX2GcAtKT0wkwJV6TDcQPcfe6ZjKXSoc
	mlySHgWyHsmYv///RsGq2aWZH6C7O3MFjHVrrMSOJIytHVkelEJowhnYKkFi/j1eIioT5H6D8nuDs
	jN/ZBn+0DdYfk6teCHCgyivT2CxB/vXdALbkG89irKu2IMgTkHzIIVok0U2MnaE8aoF2RFplbI/qX
	65jpoVXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfHv4-00000004Zvw-1std;
	Thu, 02 Jul 2026 13:57:34 +0000
Received: from fout-b1-smtp.messagingengine.com ([202.12.124.144])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfHv0-00000004Zv4-3uzV;
	Thu, 02 Jul 2026 13:57:32 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E164F1D000CF;
	Thu,  2 Jul 2026 09:57:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 02 Jul 2026 09:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1783000646; x=
	1783087046; bh=6NWmfe8Dq8JrZ1DQwcJzSv5BvctIaK/5J/1ExFQCV9M=; b=x
	1pqw1n2RUrH8p9ce2f6m8cqwdOnFzMZjhtlookQDnZVzj9/yCKZvROg7nOyvElQb
	/BBniiB8S0ZulcFEc15Op0r5VAzi/Hafa0Glraa1qszqdon+XOUHfLMjfvXuBe8R
	ukEQb1CrGkZQKieEj8hQPljx/Gmff3ingVh9/37fw0uP5cfRZLhHK+iXJ8hfO+O6
	BcTs7pGl9CqfRJYwWPV9vrVcocDpaNXuxPvNJ9F8Frrvc04hfmkRQjikndBs7DEM
	f5V0VLgr9nxBhDO7sdwnQAx+gmw4GxzIRF3CT83IQ9jvVbyUhI2S7NyuHvS1arpp
	dipOquNQsEjOh0Cr3IApg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783000646; x=1783087046; bh=6NWmfe8Dq8JrZ1DQwcJzSv5BvctIaK/5J/1
	ExFQCV9M=; b=AXKajFxTOEdTPvlMWtoC/EAQvzNml9bcFd71+Nt1qCW3uOHBLsJ
	1BVFkJmRETUKSFd2ZMjBQkKpjLKfUClB0QaIN3pYZE8pC0wCAuGCGd0mqB8qF9jb
	fXgyzZJHYEaIqqDyK+stxK7ep3Suj/Y45wW1NygZD7xfH1qQ8nQnmUpwzKW9ar7N
	r+oNxlqRxIVewalvZan14obwJ999CWQAKzsy0u/UoOiktmKqieGYmk5zA+ufGhiX
	RtBTw5fGNlH9gAUJfHl1xjI5K9SKImAUSKq1Nmmj2T39BJmZVPh6w9eoHTAEy3Hn
	ukn6y61LcidboQA5/4BFLrVef5pWRmYRCzw==
X-ME-Sender: <xms:RW5GaueEmDtXlZ9AoRmciw5NVL0CpngPFm9ZGTz3Z6XmnT0go3FEJQ>
    <xme:RW5GarUicBEDb_RCbGhGRrgB2Lx_jVfNnhfiJ0qdrGtwL84p80-k01ELVy3TTj70k
    MU5CB9CTIxmh-YXG2NWPRBwQQ7GTYVEzk_SOLBpxkcxxni3_DooDfY>
X-ME-Received: <xmr:RW5Gas_2CUXNnm0uxkUKLiQSwckwLZjtlA005_Av6PH6uVWIVusL5o9-jVBY6Q>
X-ME-Proxy-Cause: dmFkZTE4TWolB9uoCJVQSvHueLDkUcuW2os1IWqvEyWWpdqUcd4XiL+54kqQ61TrnEGAh6
    0rlcn5ENk0MJJheNNyEAcxUjLBrOsv0K64/FUoONqzjX0YJjCtGpxHcO1VQ+nCMFQrhOTn
    Dq6vLJNM3aJFHfxF5c+SFmY9C/SKkrjqIkvfe/EKvQTNcOXfqjbO6+3neM/zHXpUPGKvOL
    Vaq9+dU5iSP5fKCS4iRI6DLyBCh38T8fe2Eka+C+aI/5uvFxa55erSYbWOAPQVaaurHonk
    d3xdLEBq8WjP7sVJh4BTwGGAs3R88epaGZlwd3S9vxkmLa7aygDmv0rgKjp8/RVDAkjroV
    djwEMJwnmYt+RO21T0WTejjDU263fqviOFscWdY6s+B8T2bfsUz/PgHGRw5841J6d/k/ZZ
    TFEU5pC7ouXLtJIbmxAULG0t14id2aGgbDeDlbT+oDtBiMRc++o7qDVAmxILtQkzMPsnBG
    n9UKrc0rBY5xhX5YWWxDM0UlXxk1c3hi+0tXChawd0mVjecV8RySI6M2yXbWcby9GFFPU9
    qypj0S97WffxXus+lbltGOJRf58TuxeGMVtzV1Q6zJ7rI/iMIyfrQmzQU/XjPcAASLL5/R
    sPd6JVuFSlh1ByC0gWBfmzyXaMIt15uD2o79v+taq3iHjS8JEp+bPZ2jaKiw
X-ME-Proxy: <xmx:RW5GagiP8nC5e4sFIhf5FkJa9krmBTBFjLTl4HHOH-BxYQYIWY0AAw>
    <xmx:RW5GapVEBQq2LsDLTubzwuYZe487n1V3V3uHFNKh-akUceZKWyHqQQ>
    <xmx:RW5Gavv0wmyolvEz1pwEwjPmBLXm5Ps1B-Q-2olbOX4dSu63f-Q0GA>
    <xmx:RW5Gar6CscIW8QO6cTilKZufPUk731Xro8Nu66m8nSGICo9tfWaTRA>
    <xmx:Rm5Gal1xI0ow-_X7ewTJxvrou9riiqujrnfOijGrMPpDzM-KS944IQYg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 09:57:24 -0400 (EDT)
Date: Thu, 2 Jul 2026 14:57:23 +0100
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
Message-ID: <akZq-CAdtgg3PbkC@thinkstation>
References: <cover.1781709543.git.kas@kernel.org>
 <aj6xvvY4AA-fQG2X@arm.com>
 <aj7Pm5H0MN5WwhDK@thinkstation>
 <akJsQK2iG2oZ3vYE@thinkstation>
 <akKVKhOsv6EJVFv4@arm.com>
 <akKiV3CAKWLwHnsW@thinkstation>
 <akOT3yaYVM6BTm_4@thinkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akOT3yaYVM6BTm_4@thinkstation>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_065731_275220_D2824A3C 
X-CRM114-Status: GOOD (  28.81  )
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

On Tue, Jun 30, 2026 at 11:04:14AM +0100, Kiryl Shutsemau wrote:
> On Mon, Jun 29, 2026 at 05:53:57PM +0100, Kiryl Shutsemau wrote:
> > On Mon, Jun 29, 2026 at 04:54:18PM +0100, Catalin Marinas wrote:
> > > Have you tried SDEI_EVENT_COMPLETE_AND_RESUME instead? Just COMPLETE
> > > won't return to the kernel. We have sdei_handler_abort() to complete the
> > > event and, hopefully, you can continue with the CPU_OFF. It's a work
> > > around the TF-A non-compliance but I think this is useful even if you
> > > don't issue the CPU_OFF (e.g. no CPU hotplug, just the park loop).
> > 
> > Tried it. The result is the opposite of what I expected, and it argues
> > against doing the complete at all under QEMU's TF-A.
> 
> I have to walk back on this. My test setup was broken. I will be back to
> you with proper data.

Back with proper data. Short version: CPU_OFF from the SDEI stop does not
work on Grace, whether or not the event is completed first, so the series
stays with the park. Details below.

What was broken before
======================
My QEMU kdump harness had three faults that together made CPU_OFF look
like it broke the capture kernel:

  - a race between the sysrq-c crash and the buddy detector -- the script
    that wedges the CPU wasn't pinned off it, so which crash path ran (and
    thus the outcome) was random;
  - the capture kernel's console went quiet at the boot-console handover,
    so "nothing after Bye!" was mostly lost output, not a hang (keep_bootcon
    shows it booting on);
  - the one genuine early stall was the capture kernel's CFI probe of the
    secure NOR flash -- it reproduces with the whole series compiled out
    (CONFIG_ARM_SDEI_NMI=n) and disappears with
    initcall_blacklist=physmap_init, i.e. nothing to do with SDEI.

With those fixed, QEMU/TF-A boots the capture kernel to userspace for both
park and raw CPU_OFF, and CPU_OFF really powers the PE off. But QEMU can't
decide the question that matters: its post-kexec hold-pen can't revive any
CPU_OFF'd core (even a cleanly hotplug-offlined one), so re-onlining is
undecidable there. Hence Grace.

Grace (Neoverse V2, EL3 TF-A)
=============================
  - Series as posted (park): the SDEI rung stops the wedged CPU, its
    context lands in the vmcore, the capture kernel boots. Works.
    Bringing up secondary CPUs complains that it cannot get the CPU up,
    but proceeds.
  - raw CPU_OFF from the uncompleted SDEI event: the capture kernel boots
    but hangs at "smp: Bringing up secondary CPUs ..." -- it cannot
    re-online the CPU that was CPU_OFF'd. This is exactly the TF-A point
    you raised: the SDEI dispatch is left dangling on CPU_OFF and the PE
    won't come back cleanly.
  - complete-then-CPU_OFF: same hang at secondary bring-up. Completing the
    event first does not help.

For that last one I did not use sdei_handler_abort(): it can't express
"complete, then CPU_OFF" from the handler, because its COMPLETE_AND_RESUME
lands on the "1: ret" trampoline, which resumes the *interrupted* (wedged)
context -- so nothing after it runs. I used a COMPLETE_AND_RESUME whose
resume PC is a PSCI CPU_OFF stub, so the event is genuinely completed and
then the PE powers off. It still can't be re-onlined. (I suspect the
"complete-then-CPU_OFF wedged EL3" I mentioned earlier was in fact the
sdei_handler_abort() path resuming the wedged loop, i.e. never doing the
CPU_OFF at all.)

Conclusion
==========
CPU_OFF from the SDEI stop is unusable on current TF-A, with or without
completing the event first -- a concrete real-HW consequence of the
non-compliance you flagged (TF-A subscribes SDEI to PSCI CPU_ON and
suspend-wakeup, but not CPU_OFF). So the series keeps the park: the dump
is complete either way, and only re-onlining the SDEI-stopped CPU in an
SMP capture kernel is lost -- the same fallback the shared stop path
already takes when CPU_OFF is unavailable. Powering the PE off for reuse
is a firmware follow-up (TF-A completing or tearing down the SDEI dispatch
on PSCI CPU_OFF), not something the kernel can paper over.

Please consider applying v5.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

