Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A52E606A32E
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=G0zHmHpq;
	dkim=pass (2048-bit key, unprotected) header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=N24stHU4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5jxF6/4/W+A1WjrCqJd2E9d0nCbxdlQgcbJ/7pkC9T0=; b=G0zHmHpq4h4gPBNMsHVf1O4V8H
	JVgSm2YCKR1gFahMMhdcc/r7EEFGzrvuSlA6YtDefQHVBwZgcQ0gVzZQB68gAMLevISfYc2xSnazX
	ELovsyOIXILSZt6CEikrZfGz6R2DNgACzk2cThs4gRjSlnYrRJCtvjMSNUKPXKuKVkOqkE7rJ0Djm
	es6Xku6Ws71HrXgMKD1rQkXsnPlPJpTl0in3xXpzFBTKD030Gfqlg5jqFiipZK17xSWhp9LWtpYbJ
	/DAxkTVlW8JDwVBqBr0ReYrifiNmyQJixA1ckbO1/gE6S0LCu+4LbaePEa52cJLTVf7etX2rutjoX
	PihzeV6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLhsy-00000004zbe-27wM;
	Tue, 27 Oct 2026 14:10:44 +0000
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLhst-00000004zaD-0o4l
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 14:10:43 +0000
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-8565d77c277so34902917b3.0
        for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 07:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1793110237; x=1793715037; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5jxF6/4/W+A1WjrCqJd2E9d0nCbxdlQgcbJ/7pkC9T0=;
        b=N24stHU4sgsnh+XbigMm+9p/FRf8VA8bM7eHcF9pGl2bxJFObwNvHdDbKjTxXd8/HI
         JAQJwecS1nbXMcpOWAWzw2AY1OoSNVlR9K7SXrfzouu2jiz38usnRqCC5ypA6z2oN42U
         xs98jON59Zxgfb8m0Oj7T/w05CbvSTFnmol5x6sExYQ/hu7W1EkriSYOn8cA8hs4jUZE
         a8S6ImTWzHuR806gB3XlFfWIP9HWa3onaxlHC42P2FuLElEYOcTkZRg7Ya0sFrbT1+8I
         Z/+FmOODAmJCRPV73ysKtQZtg9vyzPuc6PUpgCFfapKLmdFKocAoI5j8Wam2g7tK7GJt
         43LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793110237; x=1793715037;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5jxF6/4/W+A1WjrCqJd2E9d0nCbxdlQgcbJ/7pkC9T0=;
        b=nSv6cYF0rdntZjEHBlGx1WGuU5DR+DGthcrGwvIVyThcMNa+TXMpyMfJS2W5brZuJN
         NESmij+6JuWg+KWQ8SPXBI9K3YzPAhZvWS4zWJEnXHW2W0R62P8pVArUpJIIkxsYWv9F
         p80Wp5WZSXG1VsGJpz/NdNl7X5KpGO8h1MoyHE7O/iGL9x/EMVArIDjzpBLTmly0DefI
         NLv8uXGacaUN5kWTMvus7+9zwR8Dq0cs/VeuAid4vHtfiB6d+BLeEPUHZ1vAiSqT5dKX
         2+I23e8qkZ1YyVibdeQ4muG6vbomm7SXthNcBAnj42iAjoy8A1WBiIs4dWi/b1D74N9w
         y6Og==
X-Forwarded-Encrypted: i=1; AKwUvBwP7VQSxIxpMeJwZRjFvolp5y602f/KY9gbNaKczbgwnDoOiWlVeeNx1cQI7ZwKRrEXrf11tA==@lists.infradead.org
X-Gm-Message-State: AFq9FYK4zzPnBOEVg3/AFN0aSRhDjUG6FFUxmrrvfzvO4/ULIo7dhv/A
	N8KcJLsZvq4mFnEKUPvNPJB886vBOF/4VULzw1uHHkdbenDYMqv10zGs7LSdOm3AzQg=
X-Gm-Gg: AYBFou2IeCgfBGuousahukjmK2PX7pWpeztGoTmPJ3OBU78McYGaJgLDigKXlWyaC5m
	52dxGzk4egPQcdYBEtKW/p8bah8dfUoF2ef+b3rJhJWILwJCXnxbIdn4FWGrpXGUxqtmiDCD3+o
	2hM1s7SS6gVkxPEwQESyi/TI/NRDEYPIvyK/Qsfjegd5DFgKBm9t/J3pAgqP6kLMhvXJaSnrXb7
	3Ihu5X1nQNl9/gClsPcP7rQ1yhURbYuYwq5ef21Pnt3x3B6LWYkepgULWHfdiEOaQS7ghCGI3dX
	MBWO3FDfLTXY2HjwKNcBrMCHPmkBBS/5KhVPIe3ZGdJ8xoEUlcu9a/+IZRsrSXBosLCgGGuBTOT
	YhPpRj+o0RLk9yQOuBaT1uSnEeDmqpDicvZJcYpP52sq2ixJhI+h1wPuzfUBmG1zFRqeMhUCR2N
	WdIYSxoBzygtQGKqrnLgk2EgzdLsvs741aM57SB0nmKxW8N21Lr5hoWQvcQFlL95E91mM4xfmDA
	r507xY3ohXWSbV/siuNxifMBB8UUdxgwM9pfY1mH8DQNv3gjYaxqRo=
X-Received: by 2002:a05:690e:bcf:b0:678:907b:3014 with SMTP id 956f58d0204a3-67a6b942174mr1866452d50.63.1793110236828;
        Tue, 27 Oct 2026 07:10:36 -0700 (PDT)
Received: from localhost ([2605:8600:200:14e3:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a7a07daf6sm127367d50.7.2026.10.27.07.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:10:36 -0700 (PDT)
Date: Tue, 27 Oct 2026 10:10:35 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>, Alistair Popple <apopple@nvidia.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Youngjun Park <youngjun.park@lge.com>,
	Gregory Price <gourry@gourry.net>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org, stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 10/46] mm/huge_memory: fix list corruption when
 deferred_split_scan() races with deferred_split_folio()
Message-ID: <auCw2-_yjh1_RjiO@cmpxchg.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-10-6f74bec9a5bb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-fixes_core-v1-10-6f74bec9a5bb@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_071039_541840_90FBC089 
X-CRM114-Status: GOOD (  18.29  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 12:17:30AM +0100, David Hildenbrand (Arm) wrote:
> Since the deferred split queue became a list_lru, the isolate callback
> moves the folios it took a reference on to an on-stack list, linked
> through folio->_deferred_list, and deferred_split_scan() takes them off
> that list with list_del_init() without holding the list_lru lock.
> 
> deferred_split_folio() does not know about the on-stack list. It only
> holds the list_lru lock when it looks at the same list_head, and it can
> run for such a folio: a THP is queued when it is mapped, as a candidate
> for the underused check, and is queued "again" when a part of it gets
> unmapped:
> 
>   CPU0 deferred_split_scan()          CPU1 deferred_split_folio()
>   list_del_init(&folio->_deferred_list)
>     next->prev = prev
>     prev->next = next
>     entry->next = entry
>                                       list_lru_lock_irqsave()
>                                       folio_set_partially_mapped()
>                                       __list_lru_add()
>                                         list_empty(item)  -> true
>                                         list_add_tail(item, &l->list)
>                                           item->next = &l->list
>                                           item->prev = tail
>     entry->prev = entry
> 
> The folio now sits on the list_lru with ->prev pointing to itself. The
> next removal leaves the neighbours pointing to it, and they still do so
> after the folio has been freed. With CONFIG_DEBUG_LIST:
> 
>   list_del corruption. prev->next should be ffd4000000270090, but was
>   ffd4000000278090. (prev=ffd4000000270090)
> 
> Fix it by grabbing the lock around list_del_init() so
> deferred_split_folio() cannot race with it.
> 
> Fixes: fafaeceb89a5 ("mm: switch deferred split shrinker to list_lru")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>

