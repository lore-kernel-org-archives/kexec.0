Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F610C982DA
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 09:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mMUmZK0P8YmnJG/+8kD4oWYLxaHcjZK2HJ/Mgo1W5Pw=; b=qfwtLB3DZg3X7BgKqVE0SRJXiz
	1s+SPiwFm8XcbMPVpOd9C6n+XHNAwrQN/uu415KsgwQs45E0Kg3RX5+667mJYv5haTLW96/uFSqIl
	ebBFiso4CYsuY4GoeFeOG4yNQ+GwH5BmJByvmB9UFG+MaXVtpaw6Cdt+L5/f//EBnq/X5Wfvm6UAn
	cL2gN+9T6V1G9Lucfr5Zbx05Tf6hu7v16gwe/48UESqY/Ux1HfDsrkkoZJsllCAowwj+gTu8l7P3G
	6ts0+WxlJjepF1rI4UoX4EoRp9+q2WgRYu9z5I8wh+UR/9gws3fC2pVjYMzfZfOycEqYePxSR87TX
	Se2l5RdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Uzu-0000000Dxmr-2WYG;
	Fri, 18 Sep 2026 09:35:10 +0000
Received: from out-176.mta0.migadu.com ([91.218.175.176] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Uzs-0000000DxlX-1VzY
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 09:35:09 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=p/DQJd95U/7tkNehVUiamBQTKyTjZl52MTnDy+aDty8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789724104; v=1; x=1790328904;
 b=t7TZ60mtyBpGmXyqF9xUBXtjYq9ZtoFwrn0HSx2Ph+U4/WywNAhaY7HkNO2bIxtCLk/QXpXx
 ePKIRBMR7usKqfagJlrKT6QvXX4vhQ9JjEXuC8fYvlcP9wnXceW7kStV9BWvI9jpomfSYnSzZ8P
 /2Era6AfCaa01vvu6sABCWxY=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id c0e6a754c1f50c48;
	Fri, 18 Sep 2026 09:35:02 +0000
X-Mizu-Trace-ID: c0e6a754c1f50c48
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: pratyush@kernel.org
Cc: rppt@kernel.org,
	pasha.tatashin@soleen.com,
	sourabhjain@linux.ibm.com,
	graf@amazon.com,
	changyuanl@google.com,
	akpm@linux-foundation.org,
	chenhuacai@kernel.org,
	liukexin@kylinos.cn,
	guodongtai@kylinos.cn,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] liveupdate: kho: calculate per-node scratch sizes before allocation
Date: Fri, 18 Sep 2026 17:33:16 +0800
Message-ID: <20260918093317.12216-1-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2vxz1par7amw.fsf@kernel.org>
References: <2vxz1par7amw.fsf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_023508_546478_69385B7B 
X-CRM114-Status: GOOD (  15.39  )
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

Hi Sourabh, Pratyush, 

> But in practice, this problem is only on CONFIG_NUMA=n and I don't think
> in practice KHO or LUO is being used in non-NUMA systems. So while I
> think it is worth fixing, I think we should also have a test where we
> enable CONFIG_NUMA.

Confirmed. My vmtest kernel has CONFIG_NUMA unset, and your analysis
matches the data.

I reran the vmtest with Sourabh's debug prints on both configurations:
same kernel, same QEMU command, and without my this fix patch, so the
default percentage policy is exercised. The only difference is
CONFIG_NUMA.

Without CONFIG_NUMA:

  KHO: Before low and global scratch allocations
  KHO: low size = 330185 KB
  KHO: global size = 322 MB
  KHO: Per node 0 = 672 MB
  KHO: After low and global scratch allocations
  KHO: low size = 330185 KB
  KHO: global size = 322 MB
  KHO: Per node 0 = 672 MB
  KHO: Failed to reserve nid 0 scratch buffer
  KHO: Failed to reserve scratch area, disabling kexec handover

With CONFIG_NUMA=y:

  KHO: Before low and global scratch allocations
  KHO: low size = 330197 KB
  KHO: global size = 322 MB
  KHO: Per node 0 = 96 MB
  KHO: After low and global scratch allocations
  KHO: low size = 330197 KB
  KHO: global size = 322 MB
  KHO: Per node 0 = 96 MB
  KHO: After per node allocation
  KHO: low size = 428501 KB
  KHO: global size = 418 MB
  KHO: Per node 0 = 288 MB

In the run without CONFIG_NUMA, the reserved-kern sum the sizing sees
is 330185 KB, which is the 98.45 MiB baseline plus the 224 MiB lowmem
scratch area: with memblock_get_region_node() hardcoded to return 0,
the NUMA_NO_NODE lowmem area is counted as node 0's kernel reservation.
Node 0 therefore requests 200% of (98.45 MiB + 224 MiB), rounded up to
32 MiB alignment: 672 MiB. That no longer fits next to the other areas
in the 1 GiB guest, and KHO disables itself.

In the run with CONFIG_NUMA=y, the real node ID excludes the
NUMA_NO_NODE regions, so node 0 requests 96 MiB. The allocation
succeeds and is visible in the sums printed afterwards (330197 KB ->
428501 KB), and the KHO selftest passes end to end ("KHO: found kexec
handover data", restore succeeds).

Sourabh, this also answers your question. Your PowerPC system runs
CONFIG_NUMA=y, so the node filter excludes the lowmem and global areas
and your numbers stay flat. Your experiment and mine are the two halves
of the same mechanism.

> I think on NUMA systems the problem is the other way round. The
> calculation for the global scratch also counts per-node allocations.

> So I think the proper fix for scratch sizing is what this patch does
> and then a fixup for the global scratch calculation as well.

Agreed. For v2 I plan to:

  - Compute all scratch sizes (lowmem, global, per-node) before any
    scratch area is allocated, per Mike's comment. The sizes are a
    function of the pre-allocation state, so this seals both feedback
    directions at once.
  - State the !CONFIG_NUMA condition in the commit message. The feedback
    described there is not unconditional, which is what triggered the
    question.
  - Add the LLM attribution Mike asked for.
  - Include the CONFIG_NUMA=y vmtest result as coverage.
  - Look at the global scratch calculation on NUMA systems as a
    follow-up.

Thanks,
George

