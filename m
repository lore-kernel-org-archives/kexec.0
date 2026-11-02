Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F44606A324
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hm+ziJPs;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tD3FBqvv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Qm2rnyse/ykhHOoe09sGuMes6K54FQWZVf+H4ljHjfM=; b=hm+ziJPs7xvO6f
	YQUSW/B7h+FFJ8cndcvX0WQmGp6MP1zYZ7r6wU/bGnUMLBnvHuXQVPdYaPBfUXAqrzqIPmbxbn5h9
	ngCR+YggeIKKxvbL4BHGpP2g6Nw05Vck9kJ0R6fbBpUTWGK/kkqlqYhQT9q3erueBrTh+QBctSbFA
	PM9tmhs9fWDNzj/EOuBPeLZ7Ply9TgXeQFVrywg8VYOWLjWYyhNmKbl9zj/F7hf4upQeLoGmltUCd
	HnzmtDpEU+5hd7aSVnBR+/XpDlGgw26OBQoM6KY/v5jV1A1/rmlUS+/+I37Xdz5OIT55yPrCr8L03
	uHSe3F56aWw8AvAv81VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNmFH-0000000Fj5O-1iwi;
	Mon, 02 Nov 2026 07:14:19 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNmFC-0000000Fj4B-38Rr
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 07:14:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793603652; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Qm2rnyse/ykhHOoe09sGuMes6K54FQWZVf+H4ljHjfM=;
	b=tD3FBqvvf6/jAXU5deKLdxFcgZC+3vumynZLxU6JHsNY/O8n0JXkttljQbOieRCOmO+mkhNtQOyWicUYL7AJjkXUi26XEqcVb+YY4SQgL1bWAtEhwi105IvQcUAyN4noQataINSriu+foNbRcTL6fTwGigJ1Sefhs56iG9xzXIc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=66;SR=0;TI=SMTPD_---0XDv-BWP_1793603647;
Received: from 30.74.144.167(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XDv-BWP_1793603647 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Nov 2026 15:14:09 +0800
Message-ID: <72c3964c-1355-4272-b61c-5767f5591f43@linux.alibaba.com>
Date: Mon, 2 Nov 2026 15:14:06 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/47] mm/khugepaged: fix PMD table lock leak in
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
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org,
 Muhammad Usama Anjum <usama.anjum@arm.com>
References: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
 <20261031-fixes_core-v3-16-d6437171ecc3@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261031-fixes_core-v3-16-d6437171ecc3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261101_231414_966511_9284EBBB 
X-CRM114-Status: GOOD (  10.99  )
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
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/31/26 5:39 PM, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> For a private mapping with userfaultfd, try_collapse_pte_mapped_thp()
> takes the PMD table lock before it maps the page table for the second time.
> If that (pte_offset_map_rw_nolock) fails, because the page table vanished
> in the meantime due to concurrent page table reclaim, it leaves through
> the abort label, where the PMD table lock is unlocked if it differs from
> PTE table lock.
> 
> In case the PMD table lock and the PTE table lock match, which is the
> case without CONFIG_SPLIT_PTE_PTLOCKS after pte_offset_map_rw_nolock()
> failed, we miss to unlock the PMD table.
> 
> To fix it, forget the PTE table lock when we unmap+unlock the PTE table.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: 6375e95f381e ("mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: move the ptl = NULL handling; rewrite description, drop wrong comments ]
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

