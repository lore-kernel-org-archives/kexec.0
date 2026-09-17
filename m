Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BCAC982D7
	for <kexec@archiver.kernel.org>; Thu, 17 Sep 2026 22:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IXOjluZcFhH/flCEevB3M2TpvgfJxkLhPY+HcD+KzfE=; b=I8Dcszs0QnisKgi5ZwVkAXn7U3
	hhluwxvXrfYtRtK2A8mRY1XW23obFoibJeD/HRVU19gKSoCo4/K0Ej7OPjqwOPnRFOq+YOO3kbZ+Q
	pIBz7A8O3RCxWjeWTatcoRdcOJ36YpUHX19WccAPbH5fRIQVvxEhalK94p6IRPZ/7Wu1Tfa4jldn4
	rTZxbU4ShHhiXJU16MtD6ZEEgIHyrB84xDLL1GfgdeSXtCSp9BKWhjSdgHA/6y+mMBcACNtRaesQs
	4WPd4m39/MtukW7yZfAA3v2vV2zHsXNssyJq60W5mjT9E9x/ePwtHWSQ/Xwh5K3TTCZZZJeGKAU7s
	kgq6iesA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Kz0-0000000CiE2-18LD;
	Thu, 17 Sep 2026 22:53:34 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Kyy-0000000CiDl-3DXT
	for kexec@lists.infradead.org;
	Thu, 17 Sep 2026 22:53:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CF3DC601EF;
	Thu, 17 Sep 2026 22:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1AC1F000FF;
	Thu, 17 Sep 2026 22:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789685611;
	bh=IXOjluZcFhH/flCEevB3M2TpvgfJxkLhPY+HcD+KzfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=CWDH0coQlEF0AK9ifcMlkpSjaSisLZfGRekijJzsGseP8S+XXRhiiios8D2k0rtzp
	 8/F2Bs5PXVT3Wm6PKbjY/N/xKFxDn+G2SJQYyFztHY2uSQssWBTWg2H1D2f3JkUvBG
	 uBLJVuF2bF8/cLdT+UqQWjo4GhxvECq2Rw1+/GDaCG7mazusN32fcbR2i8pW0M1NTw
	 lGoVq2TGGab8GVy2iaN81U1qpD5SGZutBlq8Ahx5AaJJrVcFie30Cl0ULk2P+VqvdH
	 BcKFgdjLsHj0EKzKGY0l3hdaAVKhUxO1f+aF2+MND+job3dbmW3MtoNId3U8Fltliw
	 SQDq8cROLWhYA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: George Guo <dongtai.guo@linux.dev>,  rppt@kernel.org,
  pasha.tatashin@soleen.com,  pratyush@kernel.org,  graf@amazon.com,
  changyuanl@google.com,  akpm@linux-foundation.org,
  chenhuacai@kernel.org,  liukexin@kylinos.cn,  guodongtai@kylinos.cn,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  loongarch@lists.linux.dev,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] liveupdate: kho: calculate per-node scratch sizes
 before allocation
In-Reply-To: <0969ede4-f617-4e24-b32e-c5e30a96880e@linux.ibm.com> (Sourabh
	Jain's message of "Thu, 17 Sep 2026 16:00:00 +0530")
References: <20260904025101.9959-1-dongtai.guo@linux.dev>
	<616daf17-4598-4a30-8574-16480dfc23cb@linux.ibm.com>
	<0969ede4-f617-4e24-b32e-c5e30a96880e@linux.ibm.com>
Date: Fri, 18 Sep 2026 00:53:27 +0200
Message-ID: <2vxz1par7amw.fsf@kernel.org>
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

On Thu, Sep 17 2026, Sourabh Jain wrote:

> Hello George,
>
> On 12/09/26 12:03, Sourabh Jain wrote:
>> Hello George,
>>
>> On 04/09/26 08:21, George Guo wrote:
>>> From: George Guo <guodongtai@kylinos.cn>
>>>
>>> The default percentage-based policy sizes scratch areas from the current
>>> kernel's MEMBLOCK_RSRV_KERN footprint. This is a reasonable heuristic for
>>> predicting the early memory demand of the next kernel.
>>>
>>> scratch_size_update() calculates the lowmem and global sizes before either
>>> area is allocated. However, kho_reserve_scratch() calculates each per-node
>>> size only after allocating the lowmem and global areas. Since memblock
>>> allocations are marked MEMBLOCK_RSRV_KERN, the per-node calculation
>>> includes those newly allocated scratch areas and scales them again.
>>
>> I may be missing something here, but doesn't memblock_reserved_kern_size()
>> check the node ID of the region before checking the region flag
>> (MEMBLOCK_RSRV_KERN)?
>>
>> Code snippet from memblock_reserved_kern_size()
>> ```
>> if (nid == memblock_get_region_node(r) || !numa_valid_node(nid))
>>     if (r->flags & MEMBLOCK_RSRV_KERN)
>>         total += size;
>> ```
>>
>> For a valid nid, my understanding is that the global and lowmem scratch
>> areas should not be counted because they are allocated with NUMA_NO_NODE
>> (-1). So, ideally, these regions should be excluded when calculating the
>> reserved memory for a specific node ID.
>>
>> Based on this, I am not sure that marking the lowmem and global areas as
>> MEMBLOCK_RSRV_KERN is what causes the per-node size calculation to be
>> inflated. I am looking into the code further to better understand the
>> actual cause of the issue that this patch is trying to address.
>
> I added some prints in kho_reserve_scratch() and found that the per-node size
> calculation is not impacted by the lowmem and global scratch memory allocations.
>
> KHO: Before low and global scratch allocations
> KHO: low size = 899 KB
> KHO: global size = 137 MB
> KHO: Per node 2 = 80 MB
>
> KHO: After low and global scratch allocations
> KHO: low size = 312195 KB
> KHO: global size = 441 MB
> KHO: Per node 2 = 80 MB
>
> KHO: After per node allocation
> KHO: low size = 394115 KB
> KHO: global size = 521 MB
> KHO: Per node 2 = 240 MB
>
> I only had one NUMA node (nid=2), and the per-NUMA
> allocation before and after the lowmem and global scratch
> memory allocations remained the same at 80 MB.
>
> The experiment was done on the PowerPC architecture.
>
> I am wondering how the per-NUMA allocation in your setup is
> getting inflated due to the lowmem and global scratch memory
> reservations.

I had the same question, so I asked AI. Here's what it says:

--- 8< ---

The bug was reported and tested using the KHO self-test runner
(tools/testing/selftests/kho/vmtest.sh), which builds a test kernel
using make olddefconfig with only a minimal set of CONFIG_* options.
Crucially, CONFIG_NUMA is not enabled.

When CONFIG_NUMA is disabled:

    #ifndef CONFIG_NUMA
    static inline void memblock_set_region_node(struct memblock_region *r, int nid)
    {
    }
    
    static inline int memblock_get_region_node(const struct memblock_region *r)
    {
        return 0;
    }
    #endif


struct memblock_region does not even contain an nid member.

memblock_set_region_node() is a no-op (the NUMA_NO_NODE argument is
simply discarded), and memblock_get_region_node() is hardcoded to always
return 0.

There is only one node (nid = 0), so for_each_node_state(nid, N_MEMORY)
loops once for nid = 0.

Both memblock_phys_alloc_range() and memblock_phys_alloc() mark their
allocations with MEMBLOCK_RSRV_KERN. Therefore, when
scratch_size_node(0) runs after allocating the lowmem scratch buffer,
memblock_get_region_node(r) returns 0 for that lowmem scratch buffer,
and r->flags & MEMBLOCK_RSRV_KERN is true. As a result,
scratch_size_node(0) counts the lowmem scratch area as part of Node 0's
kernel footprint and scales it by scratch_scale (200%) again.

--- >8 ---

I didn't look closer, but it does seem to make sense.

But in practice, this problem is only on CONFIG_NUMA=n and I don't think
in practice KHO or LUO is being used in non-NUMA systems. So while I
think it is worth fixing, I think we should also have a test where we
enable CONFIG_NUMA.

Your system probably has CONFIG_NUMA=y and that's why you aren't able to
reproduce this bug.

I think on NUMA systems the problem is the other way round. The
calculation for the global scratch also counts per-node allocations.

So I think the proper fix for scratch sizing is what this patch does and
then a fixup for the global scratch calculation as well.

[...]

-- 
Regards,
Pratyush Yadav

