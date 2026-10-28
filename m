Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9C8606A325
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mHavGiRG;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KNqOZbIU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yWahGggqBAzZZ1F2MkgON1x5Ts+WaoFBXhlIZHQR+vo=; b=mHavGiRGHHpkZ4YFI21Q5Hm6Qn
	KIepokvmhZDWIc6RiXD8i5hg+uEM40O1Nw9StNRLa/qSBcqz00Q3yZgJaiYZ4kn75yjb6ko4eXFHS
	o4jWtBUHRz7xATMUgrl8eb+A5aP7EXVuCC36kT2nTbe9mRFEPD/zw9jLNnV2PSRE9vvOEdyN63fuM
	o11bNbVzh3ow9Qq2ZBoY+mmt94GBXkanpDq60KSRAJLeShdjqO45ZSN7+dAPnvqUzluGCZm94MTHi
	iDpEkuB60FCdzG5NfoxyA3A5rhFO/9xcNbsNlYuLlIEtHpkkFDjmVsS5KXvruGXeNLhuCu/r9yhtQ
	6FVZ8xWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMCgm-000000083Dw-3y6V;
	Wed, 28 Oct 2026 23:04:12 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMCgm-000000083Dm-01ld
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 23:04:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E245A409C8;
	Wed, 28 Oct 2026 23:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C601F01825;
	Wed, 28 Oct 2026 23:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793228650;
	bh=yWahGggqBAzZZ1F2MkgON1x5Ts+WaoFBXhlIZHQR+vo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=KNqOZbIURlmWF8VcvD8mRkm1HnRRbtmWbwKy9abPnYENuciE+fk/k3MTfo8pGyvte
	 LaYii0YidCo1CDVUe0bSDPr2vH04VR7ZmXl7uZx2kSW2QqRZkoVhbfeXgPXdhLv1xq
	 w2NCKn2T0TwUdIT4NGGIbJsCXvAZE84LeeL5q9GmqESxWLvFq3bUx+7M7wMjX67c5k
	 d+/lSbFJGE6+yBAemzswM6MQIdkH40nSa2pHPYGfvOoJNA4FEyebvRTs9fm/U3tZCM
	 Sj2+s9T/YkNbmY9izzYzRDl54rzQiuF8p++cz6VnsHux8HFu+jOFJEfQA+vhy2bhRi
	 xVBiqrGRlIHBA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>,  Jan
 Kara <jack@suse.cz>,  "Matthew Wilcox (Oracle)" <willy@infradead.org>,
  Hugh Dickins <hughd@google.com>,  Baolin Wang
 <baolin.wang@linux.alibaba.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  David Hildenbrand <david@kernel.org>,  Zi
 Yan <ziy@nvidia.com>,  "Liam R. Howlett" <liam@infradead.org>,  Nico Pache
 <nico.pache@linux.dev>,  Ryan Roberts <ryan.roberts@arm.com>,  Dev Jain
 <dev.jain@arm.com>,  Barry Song <baohua@kernel.org>,  Lance Yang
 <lance.yang@linux.dev>,  Usama Arif <usama.arif@linux.dev>,  Kiryl
 Shutsemau <kas@kernel.org>,  Mike Rapoport <rppt@kernel.org>,  Matthew
 Brost <matthew.brost@intel.com>,  Joshua Hahn <joshua.hahnjy@gmail.com>,
  Byungchul Park <byungchul@sk.com>,  Gregory Price <gourry@gourry.net>,
  Ying Huang <ying.huang@linux.alibaba.com>,  Alistair Popple
 <apopple@nvidia.com>,  Kairui Song <kasong@tencent.com>,  Qi Zheng
 <qi.zheng@linux.dev>,  Shakeel Butt <shakeel.butt@linux.dev>,  Axel
 Rasmussen <axelrasmussen@google.com>,  Yuanchu Xie <yuanchu@google.com>,
  Wei Xu <weixugc@google.com>,  Baoquan He <baoquan.he@linux.dev>,
  Johannes Weiner <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,
  Lorenzo Stoakes <ljs@kernel.org>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  kexec@lists.infradead.org
Subject: Re: [PATCH 1/3] mm/memfd_luo: don't use memfd_pin_folios()
In-Reply-To: <179321872100.1775665.6881420026761127422.b4-review@b4> (Pasha
	Tatashin's message of "Wed, 28 Oct 2026 16:18:41 -0400")
References: <20261027173031.763213-1-pratyush@kernel.org>
	<20261027173031.763213-2-pratyush@kernel.org>
	<179321872100.1775665.6881420026761127422.b4-review@b4>
Date: Thu, 29 Oct 2026 00:04:03 +0100
Message-ID: <2vxz4ie5o2ak.fsf@kernel.org>
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

On Wed, Oct 28 2026, Pasha Tatashin wrote:

>> memfd_luo takes a snapshot of the folios in the file's mapping. To make
>> sure the snapshot does not go out of sync, it pins the folios in the
>> file via memfd_pin_folios(). The pinning also migrates the folios out of
>> MIGRATE_MOVABLE to make sure doesn't land in KHO boot memory or in a CMA
>> region.
>> 
>> memfd_pin_folios() does not lock the folios. So it can race with
>> shmem_writeout(). A folio returned by memfd_pin_folios() might already
>> be in swap cache. This happens to work but is fragile. memfd_luo looks
>> at folio flags and index on a folio that isn't in the memfd's page
>> cache.
>> 
>> In addition, memfd_pin_folios() needs the caller to allocate an array of
>> folios. memfd_luo does not really need that since it will vmalloc
>> folios_ser and store the information there anyway. The folios array is
>> unnecessary overhead.
>> 
>> Finally, memfd_pin_folios() fills in holes in the memfd. This makes
>> preserving sparse memfds very expensive in both compute and memory.
>> While this patch doesn't yet stop filling in the holes, it sets up the
>> infrastructure to make it simpler.
>
> +1, this is problematic and should be resolved. In some setups, VMMs 
> leave holes for PCI/IO space; with the current approach, single memfd 
> preservation does not work for such use cases.

Yep, agreed. There are a couple parts to this. First is this patch. Next
is KHO xarray. The patchset is ready, I'll send it after -rc1.

I think I will move this patch to that series and then make the series
also support holes.

>
>> Fix all this by walking the page cache directly using shmem_get_folio()
>> with SGP_CACHE. This returns a locked folio with an elevated refcount.
>> memfd_luo holds that reference until the memfd is unpreserved. This
>> blocks compaction, migration, etc.
>> 
>> There is still a need to migrate folios out of MIGRATE_MOVABLE page
>> blocks. This is because those might be CMA or KHO scratch. memfd_luo
>> will hold a longterm reference to the folios so it will block migration
>> in that pageblock. Introduce memfd_luo_migrate_folio() to do this.
>> 
>> Also factor out folio unpreservation logic into memfd_luo_put_folios()
>> and use it from memfd_luo_unpreserve_folios() and from error paths in
>> memfd_luo_preserve_folios().
>> 
>> Since shmem_get_folio() always returns uptodate folios, drop the folio
>> zeroing logic.
>> 
>> This change also improves preservation performance, shown in the table
>> below.
>> 
>> |------------------+----------+------------+-------|
>> | memfd            | baseline | this patch | delta |
>> |------------------+----------+------------+-------|
>> | 4K pages, 32 GiB | 748 ms   | 600 ms     |  -20% |
>> | THP, 4 GiB       | 0.59 ms  | 0.59 ms    |    0% |
>> | THP, 16 GiB      | 2.99 ms  | 2.61 ms    |  -13% |
>> | THP, 32 GiB      | 4.83 ms  | 5.21 ms    |   +8% |
>> | sparse, 32 GiB   | 8695 ms  | 7269 ms    |  -16% |
>> |------------------+----------+------------+-------|
>
> For THP 16 GiB / 32 GiB, the -13% / +8% swings look like high run-to-run 
> variance. However, maybe not: is it because vmalloc_array() is 
> overallocating memory for folios_ser?

Could be, I only did a handful of runs. But I also reckon this is
vmalloc_array() over-allocating. It over-allocated before this patch
too, for the folios array, but that allocation was half as big since
folios_ser is 16 bytes each.

>
> Also, could you clarify what "sparse, 32 GiB" means in this benchmark? 
> Was the memfd completely unfaulted before preserve (so preserve faults 
> in all 4K pages), or partially populated?

It was completely unfaulted. Size was set via ftruncate() and then
preserved. So it is the worse case of "sparse".

[...]
>> @@ -113,99 +213,77 @@ static int memfd_luo_preserve_folios(struct file *file,
>>  	 * Guess the number of folios based on inode size. Real number might end
>>  	 * up being smaller if there are higher order folios.
>>  	 */
>> -	max_folios = PAGE_ALIGN(size) / PAGE_SIZE;
>> -	folios = kvmalloc_objs(*folios, max_folios);
>> -	if (!folios)
>> +	end = DIV_ROUND_UP_ULL(size, PAGE_SIZE);
>> +	max_folios = end;
>> +	folios_ser = vmalloc_array(max_folios, sizeof(*folios_ser));
>> +	if (!folios_ser)
>>  		return -ENOMEM;
>
> I bet in practice memfds almost always contain folios of the same size, 
> so why not estimate the folios_ser size based on the first folio's 
> order, and only if that ends up being too small, vrealloc() to match the 
> maximum possible remaining size?

That's a good idea! But I think the switch to KHO Xarray will remove the
need for this.

>
> It would be a different change though.
>
[...]
>> +
>> +		if (unlikely(!folio_is_longterm_pinnable(folio))) {
>> +			folio_unlock(folio);
>> +			err = memfd_luo_migrate_folio(folio);
>> +			/* Someone else might have it isolated, retry a bit. */
>> +			if (err == -EBUSY && ++busy_retries < MEMFD_LUO_MIGRATE_RETRIES)
>> +				continue;
>> +			if (err)
>> +				goto err_restore;
>> +			continue;
>>  		}
>
> Nit:
>
> I would suggest adding another helper, memfd_luo_get_folio(inode, index, 
> &folio), that wraps:
>
> - shmem_get_folio()
> - The !folio_is_longterm_pinnable() migration retry loop logic
>
> I think this would make the final code a bit more manageable.

Sounds good, will do.

>
> Other than that the patch looks alright, feel free to add
> Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Once the nit is addressed.

Thanks!

I think the MM side might take some time to gather reviews so I will
send this out as part of a liveupdate-only series. This patch is useful
on its own anyway.

-- 
Regards,
Pratyush Yadav

