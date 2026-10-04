Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6669CCA5FE6
	for <kexec@archiver.kernel.org>; Sun,  4 Oct 2026 13:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GsrDocJZdlQZzp7Ptz2pku4WR7O9fSJpN8UbwntIi3A=; b=TTmwOxDoaDuIAwUi8qUZ3+80rV
	hdX2b1HMxFg5+D5eTwHhPLQkzP9VeMd1HE1zLrC/y6A9FAq2B/eumAkADarRFjcdX07xV87WxYEhk
	Yq0tDya0RXkol6sAuwlcIx63CG8s7D/Hf97j4tdYs5uD7J/clUqj8UCXtc8vMjz3nDu/L9ze6bsU7
	tDBGCXgmg9IYCs80d1MZp/QcJV5UWUoDsH7JLRoA+xWZ08HawtNYHd+wxlvT/A/gqS8kykqW85qPg
	HyK4heYNq0Zty7tLTHjV11V+Qckx+C+wjGGxS3WdArC+K9PN4QpDnn77adqrxjCA39N3pNqcwHpWP
	r5RNkkVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDMRC-0000000Er60-2Iu5;
	Sun, 04 Oct 2026 13:39:34 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDMR7-0000000Er5s-49y9
	for kexec@lists.infradead.org;
	Sun, 04 Oct 2026 13:39:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 715BA409C6;
	Sun,  4 Oct 2026 13:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5187D1F000FF;
	Sun,  4 Oct 2026 13:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791121169;
	bh=GsrDocJZdlQZzp7Ptz2pku4WR7O9fSJpN8UbwntIi3A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ZcOs3bFTNsWZukdiTl3x+IP7PA8A2DliLliY5QfGjDg27+Z2MCB18ILo6snmzo0/W
	 xo7htjt3Fp6s2EEBNA4CZgWLFFiRbq0z8Np7J7OeRAtXN2ddBRb/g5UHnWRAiyd805
	 Qc+IDCsNXXpmRjHj/+DV/Bccru5g270fmeKKDXoo1IHTf4efZ4MQeDrqM7sKEyhii3
	 53CjYfZTtvNNSMnt0k7ksGc3imoaU9C3dKqwB7fLCYpqzi5GE9gWTeB9zhvKQNp9me
	 7tEtoSweYdktzE7hX/E7FHLU55YjOMVMelRl9n/74VzKyJAr8fnxGRYaL696gVLa5a
	 BuW+FJdbiyOIA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Chris Bainbridge <chris.bainbridge@canonical.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Miu <jasonmiu@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,  regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
	linux-mm@kvack.org, =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?=
 <mclapinski@google.com>
Subject: Re: [BUG] KHO handover hangs when memmap reserves PMEM
In-Reply-To: <asE0R_f2r2TL-3Sy@px13> (Chris Bainbridge's message of "Sat, 3
	Oct 2026 18:02:27 +0100")
References: <asE0R_f2r2TL-3Sy@px13>
Date: Sun, 04 Oct 2026 15:39:25 +0200
Message-ID: <2vxzcxtplh4i.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

Hi,

On Sat, Oct 03 2026, Chris Bainbridge wrote:

> Hello,
>
> I am reporting a regression in KHO handover.
>
> In the most recent Ubuntu 26.10 beta mini-ISO releases (2026-09-18 onwards),
> the first kernel reserves RAM for the downloaded ISO with a memmap directive
> such as memmap=<size>!4G, then kexecs a second kernel. On affected kernels, the
> first kernel reaches "kexec_core: Starting new kernel", but the second kernel
> produces no further output and QEMU spins at 100% CPU. On unaffected kernels,
> the second kernel starts and finds /dev/pmem0 with the expected "Persistent
> Memory (legacy)" range in /proc/iomem.

Just to confirm, the first kernel boots without memmap= right?

If so, I have seen this before. Michal (+Cc) found this originally in
our downstream test suite.

I think the main problem is that the radix tree pages can be anywhere in
memory. So on the first kernel, they can land in an area that the second
kernel's memmap= reserves. So kho_memory_init() might end up using
memory that memmap= reserved. I'm not sure why exactly the next kernel
doesn't produce any output, but IIRC memmap= memory is not mapped to the
direct map, so accessing those pages likely causes a page fault.

It is not easy to fix. We would need to make memmap= aware of KHO and
skip the radix tree pages, but that is pretty complicated to do for
early boot code. And honestly, I don't think it is worth it either.

So I'd suggest you turn KHO off for the kexec that adds memmap= if you
can.

>
> A source bisect identified 3f2ad90060f6 ("kho: adopt radix tree for preserved
> memory tracking") as the first bad commit; reverting it at the bisected
> revision restored the handover. The regression appears related to KHO metadata
> being accessed after the receiving kernel's memmap directive changes how the
> metadata's physical range is mapped.
>
> #regzbot introduced: 3f2ad90060f6
>
> I have an AI-generated candidate fix that changes 22 files. I have not attached
> or published it: although the AI did extensive verification on both x64 and
> arm64, I cannot review or explain the complete change, so I am not submitting
> it as a fix. If one of you thinks an unreviewed candidate would be useful for
> further analysis, please let me know.

-- 
Regards,
Pratyush Yadav

