Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32397606A326
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 03:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NglhGvJH;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SF34kpsq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=UsyOruPU/4uzHcmKvCXiECAPVPbvFO7B0tp+W3CdJrI=; b=NglhGvJH52KHFe
	tuUeJDjjZAogE/1y4DQIuTofxgWSBnzW0AD8rtiie9NaalbogzrEZvq38Tf/yu7J68kDt9K/JH7yq
	KPCRgexWj6IYG3MNZOHAtRmC2soP36+OWz3ljjXoENuRcAmGJchT4/g6Qy6ifJxqYbqQCLK4g3y6A
	9rhSALf7NJ6jQuWhLdQukdEGNOXaQr5YvxariA7U1Yy7z/FaqB/S8h9Eggka61LMoLEmTyKlskV22
	+XVguxbPMjYodvQ9hbXaZOOoV9h0h34E6OL5isT8nI0hxJwUuGjq8a/Z+RRV8xWz/cha6fWx7u0zb
	K64S/iyhYQAV8PYOdnqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNj5u-0000000FTwZ-3MqW;
	Mon, 02 Nov 2026 03:52:26 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNj5r-0000000FTvZ-3vOx
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 03:52:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793591538; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UsyOruPU/4uzHcmKvCXiECAPVPbvFO7B0tp+W3CdJrI=;
	b=SF34kpsqFCapt2O8POrsULF5YJ7kz8UOHk5px2N5WzM66i4FJOko1sPuMRMQZZVfqXJsWre5USbHeWyqCYQHhc3wGol2G6IOyW5cJPneg7ZG0LAdw/Nk25+ET1u6HTc1w0IYQS9uuaFOwrCnLD1XM/UkHekLLJ7u22Up1yCH+7U=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=65;SR=0;TI=SMTPD_---0XDsjDyn_1793591534;
Received: from 30.74.144.167(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XDsjDyn_1793591534 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Nov 2026 11:52:15 +0800
Message-ID: <b684dbff-6f38-4d44-9709-1e9303e2158c@linux.alibaba.com>
Date: Mon, 2 Nov 2026 11:52:13 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/47] mm/shmem: make shmem_file() check the file's
 inode
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
 stable@vger.kernel.org, Chris Mason <mason@kernel.org>
References: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
 <20261031-fixes_core-v3-3-d6437171ecc3@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261031-fixes_core-v3-3-d6437171ecc3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261101_195224_395663_213E922E 
X-CRM114-Status: GOOD (  13.47  )
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
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/31/26 5:39 PM, David Hildenbrand (Arm) wrote:
> shmem_file() only checks if file->f_mapping is a shmem mapping. This
> mapping can belong to another file, however, as with a Coda file backed
> by a tmpfs container after mmap().
> 
> So it does not guarantee that the file inode is an actual shmem inode.
> 
> Seal handling and memfd preservation use this check before accessing
> shmem inode state, so they can access an inode of the wrong type.
> 
> Let's make shmem_file() check the inode's file operations instead, to
> identify shmem inodes reliably. This will identify regular shmem inodes,
> including memfds and ordinary tmpfs files, independently of wrapper file
> operations.
> 
> Use shmem_mapping() in collapse_file() instead to not change the behavior
> of collapse_file(): it operates on the page cache and uses mapping->host
> for shmem inode operations. Focusing on the file does not seem relevant.
> 
> Fixes: c49fcfcda8b5 ("mm/shmem: update file sealing comments and file checking")
> Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Suggested-by: Pratyush Yadav <pratyush@kernel.org>
> Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Make sense to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

