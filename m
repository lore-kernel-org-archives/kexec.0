Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD329606A321
	for <kexec@archiver.kernel.org>; Sat, 31 Oct 2026 01:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=o0jUL/Vk;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=i4RxBCx4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=i5beK/wqta6fa7ekid99EnBANYB7xsLLW6wDEnyFugQ=; b=o0jUL/VkB+aMUx
	uM8938F+QrOngIO9iaNJsHnWS0O5I9kJHQkhzLMw22xpU2da9mQsKwBfWkXmNcG5vnBLYjcVpXyTp
	/fBMXHENGJmqZay9n3rTx9CMgfEJDjWiQ1EZ2eDPRDDmQ8KWAkbI4F6OkHBdsm15TboxI89Te9ln7
	cHH4QERRH9K9YmtIyz9QKY2OgNrAeuPF3jnGgBFXv+y3HRM5LTLmj7wqL20xasXr01+yHO82x1xg7
	Vg3k8XbOaUildZZ5NPjrrJdNYbOUnhL/05o8qqi9KIWow5Y62ezs4nCQuBkvt7R0R+s1E8yVrZmir
	o7mFKYV3t/mxq2huiaEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMy6x-0000000CpiF-3T0G;
	Sat, 31 Oct 2026 01:42:23 +0000
Received: from out-18.mta1.migadu.com ([95.215.58.18] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMy6t-0000000CpgP-2RW3
	for kexec@lists.infradead.org;
	Sat, 31 Oct 2026 01:42:22 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=MpJ2KknoxvhydMM0mBu6hlDwlGwxhQOvcnm75Ft8d4M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793410933; v=1; x=1794015733;
 b=i4RxBCx4+vXFIwhiP6CNwflbt3rAtoBok+EdOFAGJXqPkgnid6trH1RYGNUsz+s0B79enYr8
 c7kWo/qZ/bkJtum4X3dvnr5XpPJDNhEMkqmtbV5EHWkoKh7AlaPIljgPOcsVoG9ZsLRhFMyZGU8
 PtnFVSvFeTCx34K90DjAn8LY=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id bee3307f5ff8da89;
	Sat, 31 Oct 2026 01:42:12 +0000
X-Mizu-Trace-ID: bee3307f5ff8da89
X-Migadu-Flow: FLOW_OUT
Message-ID: <febf6aeb-82dd-4a98-9a33-0ef321792285@linux.dev>
Date: Sat, 31 Oct 2026 09:41:50 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/47] mm/mglru: don't use stack pointers when walking
 PUD and PMD tables
To: "David Hildenbrand (Arm)" <david@kernel.org>, SJ Park <sj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Baoquan He <baoquan.he@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
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
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 stable@vger.kernel.org, Muhammad Usama Anjum <usama.anjum@arm.com>
References: <20261030002004.154595-1-sj@kernel.org>
 <6d679adb-a866-4a76-b9ea-3b8c64171fae@kernel.org>
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <6d679adb-a866-4a76-b9ea-3b8c64171fae@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261030_184220_535575_8AAB0FBE 
X-CRM114-Status: GOOD (  10.66  )
X-Spam-Score: -2.8 (--)
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/30/2026 6:21 PM, David Hildenbrand (Arm) wrote:
> On 10/30/26 01:20, SJ Park wrote:
>> 'get_maintainer.pl --nogit --nogit-fallback' suggests adding below recipients.
>> But I can show there are already quite a number of recipients, so I'm just
>> noting here.
>>
>> - Brian Geffon <bgeffon@google.com>
>> - Oleksandr Natalenko <oleksandr@natalenko.name>
>> - Steven Barrett <steven@liquorix.net>
>> - Yu Zhao <yuzhao@google.com>
> 
> The CC list was so long that I limited it to people that area either a reviewer
> or a maintainer of code.
> 
> MGLRU not having any real maintainer is a big problem; because that maintainer
> would know whom to CC.
> 
Agreed. FWIW, I think Barry Song and Kairui Song would be good candidates
for the maintainer role.

Both of them have been contributing to MGLRU consistently and
substantially. Barry is currently working on improving aging and fixing
the swappiness-related issues, and Kairui is driving the MGLRU-FG
optimization work.

They have also been active in reviewing MGLRU patches, and their review
comments are usually to the point and helpful. They have been looking
after this code well, so I think they would be a good fit as
maintainers.

-- 
Best regards
Ridong


