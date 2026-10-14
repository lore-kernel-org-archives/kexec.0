Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC415CC6B1A
	for <kexec@archiver.kernel.org>; Wed, 14 Oct 2026 13:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KeAUB6ZxZwwTDAP+QZu/Wb9oM9Eo94NycgbH1JijO+o=; b=htsfN3kSS27CMx3IOCYhavqhuq
	lw5ggUBY11M/0AT7AM3TSOUB5AbSp6vWLn0dRTpEf4zkKEeOTUlWD5g4akKwjyocabrAlNZJTiwLV
	+sc71oA6Jg+WWosMsTKYcUNUiJ/gmlXZ+1gcmgrj5xADoCCbHvd8DvFc554nVpe6HBggoHFKOcXNu
	BOo3cAumFELvGLf72rMPV0pih7cawxmtDip7LZu0jGVPp9/GRP9yp1G9zdEoIOq255QdKUzDuLnSa
	wVn/GNMOO99wVK4qcOnktdqVs5hR9b41txCX2uHD6VMNoG/4npgx7dFIaXTNOFYfcY7HCYJiDrGXh
	oe5DfrdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGzCN-0000000FcVC-3FE2;
	Wed, 14 Oct 2026 13:39:15 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGzCM-0000000FcUr-207u
	for kexec@lists.infradead.org;
	Wed, 14 Oct 2026 13:39:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 81A1160218;
	Wed, 14 Oct 2026 13:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963201F000FF;
	Wed, 14 Oct 2026 13:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791985153;
	bh=KeAUB6ZxZwwTDAP+QZu/Wb9oM9Eo94NycgbH1JijO+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=j08Do2wFYG6/Um1aRNiQ05eoZuB8AAlPnGfra7QiROemMesaLcT19X+2jmrzjzRuB
	 8JgXYYS1HPkEXRDQe1bL8JW2c0FWHnalCGkhk61UAZBTbk6Ai6JxTSmZTvZqUR33fR
	 YQp5Ymnxyga19xW29g4HQxhKkOu9lWGtpxfcjV7vBbTb/foypPLZYXR0ys69+aEqVQ
	 XPHWg+jLPOV9zBIvC9wCub9E6boaBBzYsIEFVTyVpBG96hC0dwpmzbIyq5RecHDWbt
	 y2cOHFDEaZDa2CRVxtBoHaRNbAQ6c8tCvUxV0Pg9YrUfLBgl2HqPBwgGpo5PW1aiB0
	 p648uKxV6gi1g==
From: Pratyush Yadav <pratyush@kernel.org>
To: sashiko-bot@kernel.org
Cc: "Pratyush Yadav" <pratyush@kernel.org>,  "Mike Rapoport"
 <rppt@kernel.org>,  "Pasha Tatashin" <pasha.tatashin@soleen.com>,
  "Alexander Graf" <graf@amazon.com>,  sashiko-reviews@lists.linux.dev,
  kexec@lists.infradead.org,  "Bing Jiao" <bingjiao@google.com>
Subject: Re: [PATCH] kho: do not reserve empty per-node bootmem areas
In-Reply-To: <sashiko-outbox-171352@kernel.org> (sashiko-bot@kernel.org's
	message of "Wed, 14 Oct 2026 13:27:27 +0000")
References: <20261014131547.259138-1-pratyush@kernel.org>
	<sashiko-outbox-171352@kernel.org>
Date: Wed, 14 Oct 2026 15:39:10 +0200
Message-ID: <2vxzecdsiept.fsf@kernel.org>
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

On Wed, Oct 14 2026, sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] kho: incomplete fix for zero-size memblock allocations in bootmem
> --
>
> commit 67ab500bd948f5a3b52f1c8170626cb8f1dfc6c3
> Author: Pratyush Yadav (Google) <pratyush@kernel.org>
>
> kho: do not reserve empty per-node bootmem areas
>
> Some nodes do not allocate any early boot memory, causing memblock to
> return an address without reserving anything when requested with zero size.
> This address is recorded in kho_bootmem with a size of 0, and can cause KHO
> to fail to initialize. This patch skips bootmem reservation for memoryless
> nodes entirely.
>
>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>> index 7018e25e4eda1..6f1f55fe31819 100644
>> --- a/kernel/liveupdate/kexec_handover.c
>> +++ b/kernel/liveupdate/kexec_handover.c
>
> [ ... ]
>
>> @@ -882,6 +882,9 @@ static void __init kho_reserve_bootmem(void)
>>  	 */
>>  	for_each_node_state(nid, N_MEMORY) {
>>  		size = bootmem_size_node(nid);
>> +		if (!size)
>> +			continue;
>> +
>>  		addr = memblock_alloc_range_nid(size, BOOTMEM_ALIGNMENT_BYTES,
>
> [Severity: High]
> This adds a zero-size check for per-node bootmem allocations, but does the
> same issue exist for bootmem_size_lowmem and bootmem_size_global?

Valid point, but that should be solved by the general bootmem sizing
patches being developed separately.

[...]

-- 
Regards,
Pratyush Yadav

