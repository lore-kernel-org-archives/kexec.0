Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F1E606D804
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ii6s5nWL;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IBacwDrO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1q50kbPjm0laMW43CAFUAOZZKVJRQfTQZ2GnkZN13bI=; b=ii6s5nWLoE6BPrNz00Wq/EoYb8
	+dYwA4SdXRQALXIbmcog4KffbW6kd4gLy2ZFU/8oFaWhtZBTMydYfTMJgAe6woz6Llo+BjppuBHme
	EYKXa8dJ6xUFxGplAeAs6x0h8+q35bkw930NL0+DqFcgu3r71OPV70zKDnE7AaJGFpyWN68vgktYp
	NlZwV8e6LrTzVx4kHiGoKAWLBIRCjHtoh9rBjNSQdSVfn7h5OLQZHBD2xytwIJknGVYV1AmFVYOz5
	L5fjEH/Supyw8FsHE0dg2mOlE+z25DG5rQkxsSlgp5n2Q0NK8I/JR5EhPZK3H9zD2dLfBNKHOoNXZ
	XrmWkYhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOZoA-00000005GS7-1XQB;
	Wed, 04 Nov 2026 12:09:38 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOZo9-00000005GS0-13HR
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 12:09:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2C5DB60F1C;
	Wed,  4 Nov 2026 12:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69461F000C1;
	Wed,  4 Nov 2026 12:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793794175;
	bh=1q50kbPjm0laMW43CAFUAOZZKVJRQfTQZ2GnkZN13bI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=IBacwDrOzTcQPD6MCzu5ag+D5mCuIXCB25VBCeCuKwjRnD/yTDiBogxZl5jYquVve
	 N/U4Xgvva0AWTbh/czKe742mHd0uC0vYPThPEpYAb2YXeBo/pqTK+v1ukztA+/Pz9V
	 HGxTNqvaVYGHwy/p4rTyhbTlyW9BGHVeFn07LX1lyc1fPobEvsKQcEkbo5IzuUG1tN
	 buCEbkuRpb111d29csvEspHKSAFNA22GtU1fjipNnyVIefLnc0YZJnuaMMHlbqkqaJ
	 GY2c7l+XEoMg8KeeS7WKj1xOWOGD2D5PSrPbF8ucj879OhUM4eGyMevn3pT8EDNefA
	 jEdUudXx0W4Sg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Andrew
 Morton <akpm@linux-foundation.org>,  Chen Pei <cp0613@linux.alibaba.com>,
  George Guo <guodongtai@kylinos.cn>,  Kexin Liu <liukexin@kylinos.cn>,
  Sourabh Jain <sourabhjain@linux.ibm.com>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [PATCH 1/2] kho: skip zero-sized lowmem and global bootmem areas
In-Reply-To: <auoo0EOKJLn9GUIw@kernel.org> (Mike Rapoport's message of "Tue, 3
	Nov 2026 20:32:48 +0200")
References: <20261103-kho-bootmem-sizing-v1-0-45aa74098f34@kernel.org>
	<20261103-kho-bootmem-sizing-v1-1-45aa74098f34@kernel.org>
	<2vxza4nqm27n.fsf@kernel.org> <auoo0EOKJLn9GUIw@kernel.org>
Date: Wed, 04 Nov 2026 13:09:32 +0100
Message-ID: <2vxzwlqslrwj.fsf@kernel.org>
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03 2026, Mike Rapoport wrote:

> On Tue, Nov 03, 2026 at 03:14:36PM +0100, Pratyush Yadav wrote:
>> Hi Mike,
>> 
>> On Tue, Nov 03 2026, Mike Rapoport (Microsoft) wrote:
>> 
>> > The lowmem and the global bootmem areas can have zero size, for example
>> > when none or all of the memory is below ARCH_LOW_ADDRESS_LIMIT, or when
>> > either of those areas is explicitly set to zero with kho_bootmem=.
>> >
>> > For a zero-sized allocation memblock returns an address without reserving
>> > anything, and that empty area is recorded in kho_bootmem. If there is no
>> > memory below ARCH_LOW_ADDRESS_LIMIT, allocation of the empty lowmem area
>> > fails and KHO gets disabled.
>> >
>> > Extract a helper that checks for zero size and allocates memory from
>> > memblock, and use it to skip empty areas the same way as empty per-node
>> > areas are skipped.
>> >
>> > Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
>> > Reported-by: Chen Pei <cp0613@linux.alibaba.com>
>> > Closes: https://lore.kernel.org/all/20261026131851.9942-1-cp0613@linux.alibaba.com
>> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> 
>> Thanks for the patch! LGTM for the most part, one minor nitpick below.
>> 
>> > ---
>> >  kernel/liveupdate/kexec_handover.c | 61 ++++++++++++++++++--------------------
>> >  1 file changed, 29 insertions(+), 32 deletions(-)
>> >
>> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>> > index 6f1f55fe31819..f268c57413a7e 100644
>> > --- a/kernel/liveupdate/kexec_handover.c
>> > +++ b/kernel/liveupdate/kexec_handover.c
>> > @@ -820,6 +820,27 @@ bool kho_bootmem_overlap(phys_addr_t phys, size_t size)
>> >  	return false;
>> >  }
>> >  
>> > +static int __init kho_reserve_bootmem_area(int *idx, phys_addr_t size,
>> > +					   phys_addr_t end, int nid)
>> > +{
>> > +	phys_addr_t addr;
>> > +	int i = *idx;
>> > +
>> > +	if (!size)
>> > +		return 0;
>> > +
>> > +	addr = memblock_alloc_range_nid(size, BOOTMEM_ALIGNMENT_BYTES, 0, end,
>> > +					nid, true);
>> > +	if (!addr)
>> > +		return -ENOMEM;
>> > +
>> > +	kho_bootmem[i].addr = addr;
>> > +	kho_bootmem[i].size = size;
>> > +	*idx = i + 1;
>> > +
>> > +	return 0;
>> 
>> I reckon it will be cleaner if you update kho_bootmem_cnt here directly.
>> So you directly do:
>> 
>> 	kho_bootmem[kho_bootmem_cnt].addr = addr;
>> 	kho_bootmem[kho_bootmem_cnt].size = size;
>> 	kho_bootmem_cnt++;
>> 
>> You won't have to pass around *idx and you won't need the final
>> kho_bootmem_cnt assignment.
>
> Ack.
>  
>> You might also want to have a kho_bootmem_max_cnt and do some bounds
>> checking here.
>
> Hmm, feels like over protecting. And if future patches will miss it AI will
> yell anyway :)

All right, fair enough.

-- 
Regards,
Pratyush Yadav

