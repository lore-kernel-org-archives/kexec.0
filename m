Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C926606A9E2
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JmsGIaq1;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kUjnB7jj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Ex4dVJ9I9Q8lqhJNdjzHP1bMR0am48AWVaJF7+qsMjA=; b=JmsGIaq1G0VqkqHu55hQ/0XvlE
	WaGzqcsmRb/WlXyiG8gHp2NzcWKFDwxdp1MSiWSLiRY0ogBSY3vBShxy0Uxgw85SNF/6S3jw3Gtzh
	DmRtaYbhdwqy10WyVVW1hUf1fywLkOBF2bMBa119Wlz9587CTR5dewIssEWysHp2StuJWzC1nPckm
	2n0M9YotAfg28rl0CknbYSJPCPOMdZQwX4GHMPuApLxlnB8fjeKdlohggYEChGElgqnWUTTNyZF3k
	V1KsZYUlxe6Sy/4XjA00ZPJbWyLKlDhDmm0tRgRCwD8A2sZ0xy34NDia++bOPXt1eBQdWA2FteF2B
	ZYr6QKWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQp6q-00000004bdH-1EBW;
	Tue, 10 Nov 2026 16:54:12 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQp6o-00000004bd8-39sl
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 16:54:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F220461DB4;
	Tue, 10 Nov 2026 16:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953741F0089F;
	Tue, 10 Nov 2026 16:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329649;
	bh=Ex4dVJ9I9Q8lqhJNdjzHP1bMR0am48AWVaJF7+qsMjA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=kUjnB7jjWwbn6apvOgtDPvTzekBFurc2yWAt+G4hqRvI8O5lNsAhUcsIyDTfsh+Si
	 SeTF3N+b4eOamAS0Ibbv55mh92DVwaX96cf8VKOxWASg0HLYtUZDtqVANs7j9tRUP8
	 TdLmGIphHJhyp8LCoz8oSqLhi1QjBhg8jqNjDAmOy1kOkVNjq3Xkn2Psn99hvE9mvb
	 fnx1bzYQWtKg+xG5bi7ehexY1sbmWYYUIBOAzUFGoE2RFDDE75jnLYKjjzuedaWMup
	 nxzG8Nb7E5fD248tLjuX7ToqybB/EqltODzgwyJErS2Q5swvfHJrAkZur0+Ici9BMR
	 vLYdm4F5aVAUg==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Chen Pei <cp0613@linux.alibaba.com>,  George
 Guo <guodongtai@kylinos.cn>,  Kexin Liu <liukexin@kylinos.cn>,  Sourabh
 Jain <sourabhjain@linux.ibm.com>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [PATCH v2 3/3] kho: fix bootmem sizing
In-Reply-To: <20261104-kho-bootmem-sizing-v2-3-b0d1a834780f@kernel.org> (Mike
	Rapoport's message of "Wed, 04 Nov 2026 18:50:11 +0200")
References: <20261104-kho-bootmem-sizing-v2-0-b0d1a834780f@kernel.org>
	<20261104-kho-bootmem-sizing-v2-3-b0d1a834780f@kernel.org>
Date: Tue, 10 Nov 2026 17:54:06 +0100
Message-ID: <2vxz33t8iq4x.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04 2026, Mike Rapoport (Microsoft) wrote:

> Bootmem areas are sized from overlapping views of the memory reserved in
> memblock:
>
> * the global area is sized from all reserved memory, including memory
>   allocated on specific nodes, so on NUMA systems everything allocated
>   on a node is accounted in both the global area and the area of that
>   node.
> * per-node sizes are calculated after the lowmem and the global areas
>   are reserved. With CONFIG_NUMA=n all memblock regions belong to node 0,
>   so the lowmem and the global areas are accounted in the size of node 0
>   area and scaled once again.
>
> As a result, bootmem is about twice bigger than it should be on NUMA
> systems and about four times bigger with CONFIG_NUMA=n. On small systems
> reservation of the bootmem may fail and then KHO gets disabled.
>
> Make the areas cover separate parts of the reserved memory: the lowmem
> area covers allocations below ARCH_LOW_ADDRESS_LIMIT, per-node areas
> cover allocations above it on each node and the global area covers
> allocations that are not bound to any node. Calculate all sizes before
> reserving any of the areas.
>
> With CONFIG_NUMA=n the global area becomes empty and it is not reserved.
>
> If ARCH_LOW_ADDRESS_LIMIT covers all memory, as may happen on arm64, any
> area can serve lowmem allocations, so don't reserve the lowmem area.
>
> Bootmem sizes in MiB in x86 QEMU VMs, before -> after:
>
>                      CONFIG_NUMA=y     CONFIG_NUMA=n
>   1G,  1 node         176 ->   92       320 ->   80
>   4G,  1 node         508 ->  332      1264 ->  316
>   16G, 2 nodes       1268 ->  704      2944 ->  736
>   32G, 4 nodes       2296 -> 1224      5196 -> 1300
>   64G, 4 nodes       4344 -> 2248      9664 -> 2420
>
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Reported-by: Kexin Liu <liukexin@kylinos.cn>
> Reported-by: George Guo <guodongtai@kylinos.cn>
> Closes: https://lore.kernel.org/all/20260904025101.9959-1-dongtai.guo@linux.dev
> Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Closes: https://lore.kernel.org/all/20260922131217.698809-1-sourabhjain@linux.ibm.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

