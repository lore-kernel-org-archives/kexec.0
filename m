Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FE1C55162
	for <kexec@archiver.kernel.org>; Thu, 30 Jul 2026 11:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XmU45OCNuFOiwGfrBinV6WwQ/rNggasBHJ+eyOZDXdo=; b=boXkO6xKmfyOwqcnB0UykWKQd/
	KM0kCmSYLyHeoCdqg1w8YwTOuMmO3inoIzr2EkQHBiJEVe4LhSkSbUQcVzSIxeezCLnZROUWiICuy
	17wEhGhrN6osCvr14chCeECfdoNJF5JI+seWNB94tvfaJu9IXI3cSf3Kx+MZAMTsafhQqPn+GTiku
	p2P2EsbiFrUW1b5JdEUZRCOKBScGaNqjKEabvNLlukEKWptFxOq/PqQLn4vRlOIEtp5xBE8x02E6a
	DVuC5yQ8NntlW4+E6UhAT62Zi5pjrhQUhUpzs5T56aGEORNTs13m5snyeP2OrGy3s2EfK9xBYfB6r
	oHyGpYfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpPFi-0000000ANuf-0z94;
	Thu, 30 Jul 2026 11:48:42 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpPFh-0000000ANuM-000Q
	for kexec@lists.infradead.org;
	Thu, 30 Jul 2026 11:48:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B1C7840832;
	Thu, 30 Jul 2026 11:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B66A1F000E9;
	Thu, 30 Jul 2026 11:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785412119;
	bh=XmU45OCNuFOiwGfrBinV6WwQ/rNggasBHJ+eyOZDXdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=KKR4hC0hisUM68EidQUezR8zfwNy0414zRBBLqO65Nl+SsArL+flSO5eWsVfIE24o
	 AfQQNHa8nvQ8Ri2p8ghrcZ86orQfPeVsaquEYI1xm2CjqTrS20K4EaLnyLcsjs25Si
	 ZQw1C7ANRR92SQPXctO2KqWJn8WCnWNLp77U3sUr18v36L1X6JvXKboeYtNJ1IPo6h
	 caQ8FAjONcV87XXUOa1zCIiGRQpzpxm/uEb1aiRQ95h1HEb+tC9YrFxX5QOHKApn44
	 gEuifJKyeNAmxwe2LQJcCo+KD7XF5DbGRKwao4yLlKXTDPVm37hmehQpfQbgtEoyfo
	 +DGmTfWAh/G3w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,  Jork
 Loeser <jloeser@linux.microsoft.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 18/22] kho: extend scratch
In-Reply-To: <178540063445.2151126.14089645580528118019.b4-review@b4> (Mike
	Rapoport's message of "Thu, 30 Jul 2026 11:37:14 +0300")
References: <20260729145610.2827231-1-pratyush@kernel.org>
	<20260729145610.2827231-19-pratyush@kernel.org>
	<178540063445.2151126.14089645580528118019.b4-review@b4>
Date: Thu, 30 Jul 2026 13:48:36 +0200
Message-ID: <2vxzqzkk7l63.fsf@kernel.org>
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

On Thu, Jul 30 2026, Mike Rapoport wrote:

>> +static void __init kho_extend_scratch(void)
>> +{
>> +	const struct kho_radix_walk_cb kho_cb = {
>> +		.leaf = kho_ext_walk_leaf,
>> +		.node = kho_ext_walk_node,
>> +	};
>> +	const struct kho_radix_walk_cb ext_cb = {
>> +		.leaf = kho_ext_mark_scratch,
>> +	};
>> +	struct kho_radix_tree radix;
>> +	phys_addr_t prev_end = 0;
>> +	int err = 0;
>> +
>> +	err = kho_radix_init_tree(&radix, NULL);
>> +	if (err)
>> +		goto print;
>> +
>> +	/* Walk the KHO radix tree to find busy blocks. */
>> +	err = kho_radix_walk_tree(&kho_in.radix_tree, &kho_cb, &radix);
>
> sashiko: Will this trigger a lockdep recursive locking warning?
>
> I think it will.

It does indeed, but that's a false positive. These are different trees
and so they have different mutexes. So I ignored this when sending the
v5.

But now that you also point it out, I went and did some digging. And I
think I know how to fix this. Setting a different lockdep class for the
local tree makes the warning go away. And from my sampling of other
users of lockdep_set_class(), this does seem to be right right usage of
the API, though I can't find much documentation on it.

While trying to explain in a comment why this is needed, I also realized
"radix" is not a descriptive name at all, and I renamed it to
"busy_blocks".

I'll send a v6 shortly with these changes.

-- 
Regards,
Pratyush Yadav

