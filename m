Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17184CD8CA6
	for <kexec@archiver.kernel.org>; Mon,  8 Jun 2026 09:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BFff0qw1eQAiypeysJZENVXCeIwuiMgTCoupaaA1AGg=; b=mfIW9pM3nXg+XbnwZDBzoqHjhm
	zXf3zkd0cvwW/+U1QuvIYd4+kemdJsov+jiDN3ea2i+y1/1z+g59i1L2+fS6JYi5rwbjHtprgr3pI
	d5agOSfHg+Fpepp7uLsniQZvHMS3Fk/bPJ6lonYDVXQMWSJe72W+g3ynTcPCY2PuGz6T9D/Z6sCwB
	JbN4q+LhcPEawwQCoacpl79th8sOCg9P6ZM3j6u6L2yV4zaCoebZm3hAA562zrCGd7BswnPGmRyDp
	MYrJEYAi2ZqzfPq2Jwi3vaS8OEEEUrQPeEENP3XJsrp+poQs5PncrBtc80qNj793xPIyraNuR0YMT
	6TzB43HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWW0g-000000039O8-0Qqr;
	Mon, 08 Jun 2026 09:11:06 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWW0e-000000039Nv-1eNB
	for kexec@lists.infradead.org;
	Mon, 08 Jun 2026 09:11:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7A526600AE;
	Mon,  8 Jun 2026 09:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE0A1F00893;
	Mon,  8 Jun 2026 09:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780909863;
	bh=BFff0qw1eQAiypeysJZENVXCeIwuiMgTCoupaaA1AGg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ItR0pG3QoAc09PLrAgHj7dzp9NWDYPsSmEmIv+MSZypxRomUz4VHNPTpGSviY7RiQ
	 cG9rLDGeopY9FhwrDKxtb9zKgebONgf7oKI42YN06s+hl8oyL/wiygF/KfIBUJENCk
	 QVj2IgTjlGCZU5CIalas4DHj4o+f8Tq/KPmmAvB3XJ5bm8O2YRveb9/2kD6q6P4u94
	 hjUgvAyz5mDHWapAF0+agr/bJ1JzGbLgR+h11S+YMCbgzLu9cYD6I+it6y+XN1mHRA
	 HRA4TRDC1U3dazGiyOnbRtx5X9PA2H4U5gc4IxN3Hd86rADLwxWX6/H6Bm/qmSXWrP
	 UsHNoW4hwc/Kw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jork Loeser <jloeser@linux.microsoft.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Alexander Graf
 <graf@amazon.com>,  Muchun Song <muchun.song@linux.dev>,  Oscar Salvador
 <osalvador@suse.de>,  David Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/18] kho: disallow wide keys in radix tree
In-Reply-To: <fb7ed559-557-b8c1-1f6-5f879feab0ec@linux.microsoft.com> (Jork
	Loeser's message of "Fri, 5 Jun 2026 15:06:05 -0700 (PDT)")
References: <20260605183501.3884950-1-pratyush@kernel.org>
	<20260605183501.3884950-3-pratyush@kernel.org>
	<fb7ed559-557-b8c1-1f6-5f879feab0ec@linux.microsoft.com>
Date: Mon, 08 Jun 2026 11:10:59 +0200
Message-ID: <2vxzwlw9tn18.fsf@kernel.org>
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

On Fri, Jun 05 2026, Jork Loeser wrote:

> On Fri, 5 Jun 2026, Pratyush Yadav wrote:
>
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>>
>> The KHO radix tree was designed to track preserved pages. So it does not
>> provide the capability to track any 64-bit key. Instead, it limits the
>> key width to how much it needs for tracking PFNs and their orders.
>> Limiting the width reduces the number of levels in the tree.
>>
>> KHO is not expected to be the only user of the radix tree. With the API
>> generalized to allow other users, now it is possible to add any key to
>> the tree.
>>
>> Check the key width at kho_radix_add_key(), and error out if it exceeds
>> what the tree can handle. Do this instead of increasing the tree depth
>> since right now there are no users that need to use wider keys, so this
>> avoids memory overhead and ABI breakage.
>>
>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>> ---
>> include/linux/kho/abi/kexec_handover.h |  8 ++++++++
>> kernel/liveupdate/kexec_handover.c     | 12 ++++++++++++
>> 2 files changed, 20 insertions(+)
>>
>> diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
>> index fb2d37417ad9..6dbb98bfb586 100644
>> --- a/include/linux/kho/abi/kexec_handover.h
>> +++ b/include/linux/kho/abi/kexec_handover.h
>> @@ -278,6 +278,14 @@ enum kho_radix_consts {
>> 			     KHO_TABLE_SIZE_LOG2) + 1,
>> };
>>
>> +/*
>> + * The maximum key width this radix tree can track.
>> + *
>> + * This value isn't ABI itself, but it is derived from values that are ABI.
>> + */
>> +#define KHO_RADIX_KEY_WIDTH (((KHO_TREE_MAX_DEPTH - 1) * KHO_TABLE_SIZE_LOG2) + \
>> +			     KHO_BITMAP_SIZE_LOG2)
>
> Love the auto-derivation of these values, this totally makes sense. That said,
> my lazy brain complained a bit when I asked it "so how many bits can a consumer
> actually use?". So I wonder:
>
> 1) Why is the value not "ABI itself"; it feels like it should as it
>    determines client behavior.

The main idea was that if you delve into the details, the value is a
combination of other values, and doesn't directly influence the binary
structure. For example, KHO_ORDER_0_LOG2 (64 - PAGE_SHIFT) influences it
directly. It decides the width of the keys that can be supported.

But now that I think of this again, I think this patch is kind of
stupid. The equation for KHO_RADIX_KEY_WIDTH is exactly the inverse of
the equation KHO_TREE_MAX_DEPTH. The max key width is (KHO_ORDER_0_LOG2
+ 1), and the equation for KHO_TREE_MAX_DEPTH uses that to arrive at the
tree depth.

All this is very obscure unfortunately. First of all, KHO_ORDER_0_LOG2
is a very undescriptive name. I have no idea what it is supposed to mean
or represent. The comment above doesn't help much either and I think is
misleading.

Second, the equation for KHO_TREE_MAX_DEPTH hides in itself the fact
that we need one extra bit on top of KHO_ORDER_0_LOG2. KHO_ORDER_0_LOG2
is essentially the width of PFN. And we need one more bit for the order.
That +1 is hidden in

    DIV_ROUND_UP(KHO_ORDER_0_LOG2 - KHO_BITMAP_SIZE_LOG2 + 1, ...),

I think we should to the following:

1. Rename KHO_ORDER_0_LOG2 to KHO_RADIX_KEY_WIDTH and make its equation
   (64 - PAGE_SHIFT + 1) with the comment above clearly explaining the
   reasoning.

2. Now that the +1 is in the key width itself, the equation for tree
   depth can be simplified to:

       ((KHO_RADIX_KEY_WIDTH - KHO_BITMAP_SIZE_LOG2) / KHO_TABLE_SIZE_LOG2) + 1

   ... which is an improvement I think.

I've been tripped by this radix tree math before, so I think this might
help out a bit. Will fix that in the next version.

>
> 2) Would you consider expanding the actual values for the most relevant
>    architectures (x86-64 w/ 4kb pages, arm64 w/ 4k/16/64k page-sizes) and
>    put it in a block-comment?

Good idea. Will do.

[...]

-- 
Regards,
Pratyush Yadav

