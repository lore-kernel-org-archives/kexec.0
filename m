Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A3ACDB479
	for <kexec@archiver.kernel.org>; Wed, 24 Jun 2026 13:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kYlbsNCB5Y7k7wf7H2fvFo08C54gNtYTSRX/Cm+qbWM=; b=4244uny6uByxRpNprXwe3OQ9ru
	ClwVyM9XD3HcchBogtAX6x/OCmDVpKyrVDMvQS+6OtIAvICYhZBe7K56kYwSDY0WcpLMq/sFCsy0x
	j+sZyUUaov3tH9oCunsoqTDzDVwEEGAUO4naVwzn0RheeaaXNBhJCfHnWt1+VygLk3FTUqYwvHyKg
	V63NGyXGU3GrnlTh4YyFfFyN1L4TshpxPkWCnPN0fr4F7mC0c3fyKqccy3tCqr1YVzgiARvRmxGp7
	w+ySD21jdgMLBlN3zue3p8BLLeP7IkNPRcDi1NGJBN79IDuHDWPtZiT2uxQSCzGqOTwYT/Xs1CxVb
	/BeP15aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcNvp-00000007qfh-0QIz;
	Wed, 24 Jun 2026 13:46:21 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcNvn-00000007qet-0Lep
	for kexec@lists.infradead.org;
	Wed, 24 Jun 2026 13:46:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3C9EC60216;
	Wed, 24 Jun 2026 13:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620DE1F000E9;
	Wed, 24 Jun 2026 13:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782308778;
	bh=kYlbsNCB5Y7k7wf7H2fvFo08C54gNtYTSRX/Cm+qbWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=mCcRCXHCV98flmEkeWGULIwa4FVuqjTSq4bqGMhm/vXUFQXnkNWbuNJNcBO2Yk9kC
	 0p1sXX/+mkrw1YH/9PISPObfmwjI2m3/Qu3oqAQQ750KlKEg0eYoDwaO22NpiH4dgU
	 GsdoZ+rf2iNqO3J8CKWNPn0yE7ba6Pw+FjxO9A2K3SeKp8NX1DHNXFa8ZYbKGYEyW/
	 CYAqsZhSWSWNgvyWoyV/IDww4ErBNhVyREsECfBdDPT4qFoYyKNbZTOWJZxCqXe/EO
	 W7Llaeb5g6Seg6K+ItPs3sZK+YKPgECOQacgbR38FmeRQ2jeXvqEmiLfQqLa7WqKXj
	 NrKfq4C4OuiYw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Breno Leitao <leitao@debian.org>,  Ard Biesheuvel <ardb@kernel.org>,
  nao.horiguchi@gmail.com,  linmiaohe@huawei.com,  david@kernel.org,
  lance.yang@linux.dev,  akpm@linux-foundation.org,  baoquan.he@linux.dev,
  rppt@kernel.org,  pratyush@kernel.org,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  rneu@meta.com,  riel@surriel.com,  caggio@meta.com
Subject: Re: mm/hwpoison: persist poisoned PFN list across kexec via KHO [RFC]
In-Reply-To: <aju5_WjBtagTOSJw@thinkstation> (Kiryl Shutsemau's message of
	"Wed, 24 Jun 2026 13:04:19 +0100")
References: <ajut_LDQGYCShApx@gmail.com> <aju5_WjBtagTOSJw@thinkstation>
Date: Wed, 24 Jun 2026 15:46:14 +0200
Message-ID: <2vxzo6h0kq55.fsf@kernel.org>
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

On Wed, Jun 24 2026, Kiryl Shutsemau wrote:

> On Wed, Jun 24, 2026 at 03:39:38AM -0700, Breno Leitao wrote:
>>   * Consumer: early in the next boot (fs_initcall_sync, before the
>>     buddy allocator has handed anything out) it restores that array
>>     and re-runs memory_failure() on each PFN, re-offlining the frame
>>     and rebuilding the full hwpoison state (PG_hwpoison, counters,
>>     HardwareCorrupted).
>
> fs_initcall_sync is not before buddy hands anything out - buddy has been
> live since memblock_free_all() in start_kernel(), and every initcall before
> this one has allocated freely. So this is recovery, not prevention: you may
> be running memory_failure() against a frame already in use, possibly by a
> kernel allocation.
>
> Two windows are missed entirely:
>
>   - memblock allocations between setup_arch() and memblock_free_all()
>     (page tables, mem_map[], percpu) can land on the bad frame.
>
>   - The kernel image itself: KASLR picks its location in the
>     decompressor/stub, long before any initcall. The next kernel can end
>     up running *on* the bad frame.

With KHO, you have "scratch memory", a pre-reserved area of memory on
cold boot. The kernel image is always in this area when KHO is used. I
think it would be a fair idea to deny kexec if any of the pages in this
scratch area are poisoned. Because at that point you can't reliably boot
anyway.

Normally, all allocations between setup_arch() and memblock_free_all()
_also_ happen from scratch memory, so this check would solve the first
problem too... but I recently added patches [0] to change this. So I
think we do need to identify the poisoned pages early in boot.

[0] https://lore.kernel.org/kexec/20260605183501.3884950-16-pratyush@kernel.org/

[...]

-- 
Regards,
Pratyush Yadav

