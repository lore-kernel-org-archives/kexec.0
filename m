Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0D5606A328
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 03:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hnyQfgaq;
	dkim=temperror header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XCevM6i0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=VPL6FGJI6mYbfWVdagRDwQTQgREcZN8JpaFK/cgIs8Y=; b=hnyQfgaqQifgYe
	/G8t4wtRS+SUipMuw3n6mRCZrzimme9GBA1GGhdFKJ4kVfhs1dAJPDC3BbkaM5Mdcb3dtRDdzk2sW
	Rydux7HZ09Lg+kn6lMS73aauDy3HWjJtdwHHa0oiPH7HN/QiSKbGClVZAN0pAAwBhRaR3RGplOnSb
	04FBdBuIJ8gHoKIIYEkfecOh6S1QygUxblga1j8OijdpCEwksw45r5qmDCndq1ewvyJdXlLbsr+5o
	nGjlLt1CVDg6FkjcI9vDIuyAR8nViDaVO0CZ54zqPpmrO7E20mqmF3nRi9FE+p5s+9pjgFqQr6Sy9
	jVWRm7eIAkaW66ErL8yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOoO0-00000007h8E-3XZT;
	Thu, 05 Nov 2026 03:43:36 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOoNw-00000007h78-05fN
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 03:43:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793850208; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VPL6FGJI6mYbfWVdagRDwQTQgREcZN8JpaFK/cgIs8Y=;
	b=XCevM6i0pje7urS0yRu8hs6ccSWgXhKWUrNSTJscVXRnD7c7hFWmNmYNYRyuk6rYtY2vpmwPsEbBA3JKSXOaY9KA6pPicWrECBRzWq4+1iL/msUYBBBaaxEcnoMQsdlYkFTT1Z4tPLVVhw8V7TH1YWxxLLUdEx8/vm4VxmbbsAA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=64;SR=0;TI=SMTPD_---0XE7Nmrn_1793850203;
Received: from 30.74.144.136(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XE7Nmrn_1793850203 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Nov 2026 11:43:26 +0800
Message-ID: <d0f78f0f-c883-4919-a416-fe738eb7323a@linux.alibaba.com>
Date: Thu, 5 Nov 2026 11:43:22 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/47] mm/khugepaged: check if PTE table is empty in
 try_collapse_pte_mapped_thp()
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Baoquan He <baoquan.he@linux.dev>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>,
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>,
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org,
 Muhammad Usama Anjum <usama.anjum@arm.com>
References: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
 <20261031-fixes_core-v3-18-d6437171ecc3@kernel.org>
 <62268831-f6f3-4666-a32f-a77546b95432@linux.alibaba.com>
 <979fb046-32dc-4af8-b6a3-177c78f1e557@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <979fb046-32dc-4af8-b6a3-177c78f1e557@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_194332_226148_061D85EA 
X-CRM114-Status: GOOD (  14.41  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-24.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/26 5:13 PM, David Hildenbrand (Arm) wrote:
> On 11/2/26 09:20, Baolin Wang wrote:
>>
>>
>> On 10/31/26 5:39 PM, David Hildenbrand (Arm) wrote:
>>> The existing code is rather horrible and already resulted in bugs in the
>>> past: we special-case UFFD inserting anonymous folios by grabbing the PMD
>>> lock early, but ignore any other markers (guard, poison through uffd) that
>>> could have been inserted into the page table in the meantime, effectively
>>> dropping them.
>>>
>>> Let's just unify and simplify the locking: try to grab the PMD table
>>> lock and if that fails, flush the TLB, drop the PTE lock, take PT locks in
>>> the right order and check if the page table is still empty.
>>>
>>> We still perform the heavy lifting (zapping the folio ptes) under PTE table
>>> lock only.
>>>
>>> Include <linux/hugetlb.h> for now, as x86's flush_tlb_range() macro
>>> depends on hugetlb helpers. This dependency needs a separate cleanup.
>>>
>>> Both issues this fixes are rather corner cases. Let's not CC stable for
>>> now.
>>>
>>> Fixes: f807123d578d ("mm: allow guard regions in file-backed and read-only
>>> mappings")
>>> Fixes: 1043173eb5eb ("mm/khugepaged: collapse_pte_mapped_thp() with
>>> mmap_read_lock()")
>>> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
>>> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
>>> Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>>> ---
>>>    mm/khugepaged.c | 64 ++++++++++++++++++++++++++++-----------------------------
>>>    1 file changed, 31 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index ce794d9760a87..ad07c8caa3bd9 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -10,6 +10,7 @@
>>>    #include <linux/mm_inline.h>
>>>    #include <linux/kthread.h>
>>>    #include <linux/khugepaged.h>
>>> +#include <linux/hugetlb.h>
>>>    #include <linux/freezer.h>
>>>    #include <linux/mman.h>
>>>    #include <linux/hashtable.h>
>>> @@ -1832,6 +1833,17 @@ static enum scan_result set_huge_pmd(struct
>>> vm_area_struct *vma, unsigned long a
>>>        return SCAN_SUCCEED;
>>>    }
>>>    +static bool pte_table_empty(pte_t *pte)
>>> +{
>>> +    int i;
>>> +
>>> +    for (i = 0; i < HPAGE_PMD_NR; i++, pte++) {
>>
>> Using PTRS_PER_PTE to iterate PTEs seems more straightforward? Otherwise LGTM.
> 
> As I pulled this patch out from the stable fixes, I fixed it up.

Thanks.

> I realized that this helper should likely move to some header later and be
> reused elsewehere (zap_pte_table_if_empty), but that's something for a later
> cleanup.

Indeed.

