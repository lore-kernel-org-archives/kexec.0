Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFB5C43458
	for <kexec@archiver.kernel.org>; Mon, 29 Jun 2026 16:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6d/g78nARanRf8gSDZnSYai0WcH3apHlQ9zVtHuPszY=; b=sRQ7t+anfDddmD7JeHstvBqwPK
	YPOXoQw0FAHkpS/QK3SvCQHch+LGWG7+GFzq84ShLoUjEbpF3ki/c0uCzF8ZfVR2nc5uiukSvrIcy
	p3/nrz0VaSF3n97Wa9haqW19pwDhjzntb2FAO2aUuFh9w1fXPnE4B1bIa4y8hNy5lp/lI0350yway
	W/B0jCTqvqypXWQBXZLOuLUzi9adhLOMcg+njjlbW8Os1CGKNTFMZW07VPwomJsLIfrep1X3opJg9
	UQjbOgmE0lrztNfAlleTn+85l/I7bNsIVrjw11cCvaaIGAVII0fAdxJUPHwnDOFI1Pl+st0AsJobm
	gFsg37Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weFFB-0000000FG4B-1I6f;
	Mon, 29 Jun 2026 16:54:01 +0000
Received: from fout-a5-smtp.messagingengine.com ([103.168.172.148])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weFF8-0000000FG3V-2RUs;
	Mon, 29 Jun 2026 16:54:00 +0000
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 2B039EC006E;
	Mon, 29 Jun 2026 12:53:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 29 Jun 2026 12:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1782752037; x=
	1782838437; bh=6d/g78nARanRf8gSDZnSYai0WcH3apHlQ9zVtHuPszY=; b=N
	ZGXNR6l5Q5v6NSr0q7LeE3fgkfIyMitsQCjVn7v8EvVru91478oo7MeDOSbQM26m
	jXS7ZK8I0eDYmVea6vlN5n1uZ/0jhMJZWxwctEzmWRFX9JwQ+g5dYAiwmnABUeqO
	iQQnaeVwxmFbXfcW303hDGplMiP925vknxX7jjhBw/aB6ZIPOdeLrKpiigBS+NH7
	QKi59d5tw57ViTA7i/7lozw/kxWgNHfc5ViGHZqaL+KIxTxAptlsY2roq/A8WR+K
	6RG0YPVeTHFlz+8apZFIB33tG9nAbyhib9xNDIePDD2ahIbtLVBqA+GjPd18FGRY
	4coNxb4WD7seVtSuvUYEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782752037; x=1782838437; bh=6d/g78nARanRf8gSDZnSYai0WcH3apHlQ9z
	VtHuPszY=; b=VcLy23F2+rXWsexJnDQ9eY3tf1dz+WSD4OsddeGafhV3XOXsvza
	vPyvN+x/K6o9oIUQGmrnDOW+Y3eMWGF/O2/ieYNRNtL30o5MLRZ22/9G4paMnV7k
	IUcNB2wf5gs7QpkFkR54877YrjuOdaooBd2M1Z/HVL8+bTCmi7pVKYCSJRMqU1Wz
	9My4n07gFiuajN34yG0+jXFr9vACJlGYx6cM1Uj07adSwT8JQvRZ3BLb8vsTTSQx
	fU6iyNJQyL0xTJzPAdJQ5IlYNrlL/R8k6aHNH2iFr/hXcUgmu6ELLqlVnH0Nadxw
	uhhpKQgzIpoSPvrC7tk41ruayEwpqjuJdGA==
X-ME-Sender: <xms:JKNCao6v9mqnJhXtz4YURts2z0BtLhuXfKTy6V2ZcbCR5Em7o5PogA>
    <xme:JKNCatBVzvo5QVRA8h-7p9SEyeVvn75WtlwUTfrkLKPG_JQ2bXpo0rZeQ-DDZQox7
    AhTB8DBJLrHI4Nap55Wwq14VEKHEQeQ4_8Kug7F7fX0zo20hoh7_fBI>
X-ME-Received: <xmr:JKNCak7788qMfyw2E3E7cuuZer7kOXeqNxmCKuzhr8y0Pc9aFwfXh_dhndluEQ>
X-ME-Proxy-Cause: dmFkZTEzzn6OgJCgoJErvGmXtkQgHIU8zND7m0wTMLGAHBlOG8NESTBmLsw97avQ8mqKmv
    6Utolx1pAcqyJypNeKEtYm8JWl1pX9x1mCAwaKZrBoFF445lJbgx9KdFGtEPq+K29okb2/
    GX2qOqaHUaxHPYGzgJ1ezEOlhOax32ciKt1bvZjbGyUAdl9/pp7SKN4tg2364f/kIciFBx
    vhKBZzOA8AfVHiY8IYqGu/eTt2W4ocxoQcBSy9kono6UHQpJoHumvxlql/oZaZ2i6ChXzx
    r7Q9YXOJnEIcwzDi6PHmtDTyBWgHTXI/qLdwYfMvCburY83E7VBnbeXga/IYsJsPFZk/Y9
    tum8cSWFzNNeUvGxZrk1hq+viFDxGo+aNzQgla9mg7a/+P2RZ8KJETcTb/0oTKTrIvFqL8
    G0tr9UfyC6EsqIwIIzYROWTUZca8Fsn0KRCX0yM0ewQdjBZxEUdczSxTYT0MOilPHSaiZP
    zDAf/DV+WFpKAAq3/igyF3nd7b04DgMv35CwlN8+D0rJPnANvcHDbCH5K5oP4BLZVS24R3
    wr6mAhbrpE+EO6a9mwyDr9uHGPBvjlDC+LsgbGwjtS6pZ11e7SduTP8dGHBXMINONAbuhV
    fn0TODSdVkaKHjbJdYQVJSgrfx4zbXgXdv6o5gmfGO0U1UzoCBhnd8Nwg3Vg
X-ME-Proxy: <xmx:JKNCahuTtPzanffSa5-Q7EnYsy7zkM7x0DZAYQeW_cs9nH7JvEJb3Q>
    <xmx:JKNCaqwSzhbZCRVYt7XQrkJxxdXnWPa1PqbChw1bfgRytYEzMXPoDg>
    <xmx:JKNCasZenza9aO6cScS7AOXemQEYw5HMbFNInoYT0UrIma8bXSW2hw>
    <xmx:JKNCai3wuk3ev92TG89NwWF4zNSWSNZs7ylY3tOq937Du365jUgg4Q>
    <xmx:JaNCatQuGJWUU7v2OjSZKkwvETUMsh4BM05qg36L5qZajk02KUKWPWTW>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 12:53:56 -0400 (EDT)
Date: Mon, 29 Jun 2026 17:53:55 +0100
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
Message-ID: <akKiV3CAKWLwHnsW@thinkstation>
References: <cover.1781709543.git.kas@kernel.org>
 <aj6xvvY4AA-fQG2X@arm.com>
 <aj7Pm5H0MN5WwhDK@thinkstation>
 <akJsQK2iG2oZ3vYE@thinkstation>
 <akKVKhOsv6EJVFv4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akKVKhOsv6EJVFv4@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_095358_925533_40EE9D78 
X-CRM114-Status: GOOD (  15.47  )
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

On Mon, Jun 29, 2026 at 04:54:18PM +0100, Catalin Marinas wrote:
> Have you tried SDEI_EVENT_COMPLETE_AND_RESUME instead? Just COMPLETE
> won't return to the kernel. We have sdei_handler_abort() to complete the
> event and, hopefully, you can continue with the CPU_OFF. It's a work
> around the TF-A non-compliance but I think this is useful even if you
> don't issue the CPU_OFF (e.g. no CPU hotplug, just the park loop).

Tried it. The result is the opposite of what I expected, and it argues
against doing the complete at all under QEMU's TF-A.

Same A/B harness as before -- a CPU wedged with interrupts masked is
stopped via the SDEI rung; I only vary how its handler ends. kdump
capture kernel boot under QEMU:

  - park, event left uncompleted (current series):   boots to a shell
  - sdei_handler_abort() then CPU_OFF:               hangs at SDEI re-init
  - sdei_handler_abort() then park (no CPU_OFF):     hangs at SDEI re-init
  - CPU_OFF, event left uncompleted:                 hangs at SDEI re-init

The third line is the surprising one: completing the event via
sdei_handler_abort() and then just parking -- no CPU_OFF at all -- breaks
the capture kernel too, at the same point as CPU_OFF does. The only
variant that boots is the one that leaves the event uncompleted and
parks. So here it's completing the event that the capture kernel trips
over, not the dangling dispatch -- backwards from the non-compliance
theory, where completing should be the safe thing and "useful even
without CPU_OFF".

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

