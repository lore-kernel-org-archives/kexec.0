Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60649CA9ED1
	for <kexec@archiver.kernel.org>; Mon, 12 Oct 2026 13:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F9zvoH+Az/uKJAB5P1uYqjIh12NKolhbo6fDlfYMw64=; b=1eR1MYD4blNE3Zb7rIywH3Xj+m
	UqNZyX8vkUqlMDQwZw1OCLaPCkb3EIXZ65a5OnOSqOxDSFXW9/JzBbDAVXMrMIwS1gG63gq+xJl6d
	JQEMw4Yjxrg25l1JTYxBTYvzMphcWwr3GN1bhbe1IQpICB5kXRJSLEKW0obW5BypFnvdWWriHqtRb
	FD2IcAxTwsN8VCLmAjPEnlX0Flc79JFChsQo3dOzG84ULSr040IL4FvYWpwZO59TYkT6TTnnf5h/i
	Kra/xI4sYCoXUY75ywp5qOO4oCP1o+YCJKP8ScojcisvddorkOjd2GrfATrhz9EBCPkZof1nZSGPC
	QmJN1g7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGGSR-0000000AcMN-2xg6;
	Mon, 12 Oct 2026 13:52:51 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGGSQ-0000000AcMH-1FJq
	for kexec@lists.infradead.org;
	Mon, 12 Oct 2026 13:52:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B1D804034C;
	Mon, 12 Oct 2026 13:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4261F0089B;
	Mon, 12 Oct 2026 13:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791813169;
	bh=F9zvoH+Az/uKJAB5P1uYqjIh12NKolhbo6fDlfYMw64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=h4D7CJZiCRGU+lPZNmqJvvEAhNSYLhq9GPvvpK7JAaEosOCbCqrc/e1vDiTCifuwv
	 GIaKs3DvMIyAGi/IX56wBYQLO8TqaOUHt5GiIKt28T+cezs8pyCeCRM/lKscYihELm
	 7dEcJMPE8V7cmMDkzLUzQV7zjTJYClCewLD1RpnBVm7glxBNyO1E4c7NPWINcLXiZd
	 lKSsnoozEOoy9p6OkGhHgTMNtbCaOnzR2zxcIbHptpod3PyPWB5Q7aFmeS8Cp81Gmk
	 h0BHrs+VLm1tvYXY+jntzjQn5CDroi9CdjHAiZWwYUdRe+HHYeja44ClQWRIaimzM/
	 l+5eIWxHtiXYg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,  kexec@lists.infradead.org,
  Alexander Graf <graf@amazon.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  George Guo <guodongtai@kylinos.cn>,  Pasha
 Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [PATCH] kho: fix global scratch size calculation
In-Reply-To: <asC3-4WNiTF3n7l1@kernel.org> (Mike Rapoport's message of "Sat, 3
	Oct 2026 10:08:27 +0200")
References: <20260922131217.698809-1-sourabhjain@linux.ibm.com>
	<asC3-4WNiTF3n7l1@kernel.org>
Date: Mon, 12 Oct 2026 15:52:46 +0200
Message-ID: <2vxzo6czjaa9.fsf@kernel.org>
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

On Sat, Oct 03 2026, Mike Rapoport wrote:

> On Tue, Sep 22, 2026 at 06:42:16PM +0530, Sourabh Jain wrote:
>> KHO calculates the global scratch size based on memblock-reserved kernel
>> memory. It passes NUMA_NO_NODE to memblock_reserved_kern_size() for
>> this calculation.
>> 
>> When memblock_reserved_kern_size() is called with NUMA_NO_NODE, it
>> counts both:
>> 
>> - memory reserved for a specific NUMA node
>> - memory reserved with NUMA_NO_NODE
>> 
>> KHO needs to distinguish between these two types of reservations.
>> When calculating the size of global scratch memory, KHO only needs to
>> account for reservations made with NUMA_NO_NODE. Reservations made for
>> a specific NUMA node must not be included in the global scratch size.
>> 
>> Add memblock_reserved_size_nid() to calculate reserved memory for a
>> given reservation type and NUMA node. When NUMA_NO_NODE is passed, it
>> counts only memory reserved with NUMA_NO_NODE.
>> 
>> Use the new API for lowmem, global, and per-node KHO scratch size
>> calculations. For lowmem and global scratch, count only memory
>> reservations that were made with NUMA_NO_NODE. For per-node scratch,
>> count only memory reservations that were made with the corresponding
>> NUMA node ID.
>> 
>> Remove memblock_reserved_hugetlb_size() since it has the same
>> implementation as the new API and differs only in the memblock
>> reservation flag being checked. The new API handles both kernel and
>> HugeTLB reservations through its reservation type argument.
>> 
>> Define the new helper as a static function in the KHO implementation,
>> since it is only used by KHO and has no users outside
>> kernel/liveupdate/kexec_handover.c.
>
> I looked again and this feels like a band-aid to me.
>
> I think we need to step back and rethink the order of the
> scratch/kho-bootmem sizing and consider how NUMA and lowmem are involved
> there.

Could you elaborate? How else would you calculate the sizes?

To me, the idea sounds fine (although I also share your comments on the
code style). This is what the global scratch size should have been doing
from the get-go. Today it over-allocates by counting both global
allocations and _all_ per-node allocations.

There is a separate problem with CONFIG_NUMA=n, but for that I think we
should just have a different allocation path where we only do lowmem and
global scratch.

>  
>> On powerpc, the difference can be seen in the scratch_len values
>> reported by:
>> 
>> cat /sys/kernel/debug/kho/out/scratch_len
>> 
>> Before this change, the global scratch allocation was 0x12000000
>> (288 MB):
>> 
>> 0x1000000   (16 MB)
>> 0x12000000  (288 MB)  <- global allocation
>> 0x5000000   (80 MB)
>> 
>> After this change, the global scratch allocation is 0xd000000
>> (208 MB):
>> 
>> 0x1000000   (16 MB)
>> 0xd000000   (208 MB)  <- global allocation
>> 0x5000000   (80 MB)
>> 
>> The 80 MB difference is the per-node reservation that was previously
>> being included in the global allocation.
>> 
>> The same issue also affects lowmem scratch memory, but its impact is
>> limited because the lowmem scratch memory calculation is restricted to
>> the first 4G of memory. The changes also cover the lowmem scratch
>> memory case.
>> 
>> Cc: Alexander Graf <graf@amazon.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: George Guo <guodongtai@kylinos.cn>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
>> Cc: Pratyush Yadav <pratyush@kernel.org>
>> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
[...]

-- 
Regards,
Pratyush Yadav

