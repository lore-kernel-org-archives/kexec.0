Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE862606A31E
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 04:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=edVhq4xq;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WeW0dcEy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=hoaYYE9clIuJ0Ig445chvZt4nolRKxe5BT9MRTh3Egg=; b=edVhq4xq1EIUTY
	BVOaBeYczIhEN0oYzeUSmfR6zA38l1qCZA7M8F0eX+mvtjYhP5a26g1qJpS7ptjP8In18/LJhEfXq
	h9M0110OaVmkh2ZDuG/TbVLoBEQ+EzXwyNG0mqmExYih1OPjAIZPJvb6BAPL2jkvS3bUoq0pwyZux
	sOz5YTh1jBUG45/ORKkXYXMf/qjNXAB1kzalEddHXh23sX9JRw8U5Cv+SS+be4IcwLsmOezgcwBwe
	w4OUKZGtrU3Zt44dM3N3HHyLm63UlSIl1CE33mIrhg7WsmwmOoxiRKyC4wItEgz8Iz+VTkT0Veyed
	bZ6HpMc2F4lFZ3PxxRNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLvLv-00000006HqT-28Am;
	Wed, 28 Oct 2026 04:33:31 +0000
Received: from out-123.mta0.migadu.com ([2001:41d0:1004:224b::7b] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLvLs-00000006Hph-0NXu
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 04:33:30 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=T4efCo2Hap6aPJgKK/ehUGhK0yIt+mn0LCQnSmlQd0s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793162000; v=1; x=1793766800;
 b=WeW0dcEyzkw6mTIdVt2Z06iHEedOA9csfafpNxIqlvgXWGNleOMk4G5+xIqtxnfY0oJlEGQo
 3RIOLo03odtO32V/gvt274JFHEpf0OAsY2K6WgJh+s2w2M9H9KOLel/juzZL0FcuRQ3OjvRdcI0
 9UEAxWdkfJdjVzGrmw7+tycY=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id bee4a2cb7972e2c2;
	Wed, 28 Oct 2026 04:33:20 +0000
X-Mizu-Trace-ID: bee4a2cb7972e2c2
X-Migadu-Flow: FLOW_OUT
Message-ID: <fa0f07af-e8d7-44b0-b1e7-ad325d75ac34@linux.dev>
Date: Wed, 28 Oct 2026 12:32:54 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/46] mm/memory_hotplug: avoid races in
 pfn_to_online_page() with dying pgmap
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
 qi.zheng@linux.dev, shakeel.butt@linux.dev, ljs@kernel.org,
 kasong@tencent.com, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
 baolin.wang@linux.alibaba.com, liam@infradead.org, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, kees@kernel.org,
 peterz@infradead.org, jannh@google.com, pfalcato@suse.de, hughd@google.com,
 pasha.tatashin@soleen.com, pratyush@kernel.org, willy@infradead.org,
 jack@suse.cz, ziy@nvidia.com, riel@surriel.com, harry@kernel.org,
 apopple@nvidia.com, nico.pache@linux.dev, ryan.roberts@arm.com,
 dev.jain@arm.com, usama.arif@linux.dev, kas@kernel.org,
 matthew.brost@intel.com, jhubbard@nvidia.com, peterx@redhat.com,
 will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 osalvador@suse.de, minchan@kernel.org, muchun.song@linux.dev,
 xu.xin@linux.dev, chengming.zhou@linux.dev, chrisl@kernel.org,
 shikemeng@huaweicloud.com, nphamcs@gmail.com, youngjun.park@lge.com,
 gourry@gourry.net, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 ying.huang@linux.alibaba.com, jgg@ziepe.ca, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-cxl@vger.kernel.org, josef@toxicpanda.com
References: <20261027-fixes_core-v1-32-6f74bec9a5bb@kernel.org>
 <20261027121307.40431-1-lance.yang@linux.dev>
 <87e3d64e-8b25-4d51-a984-7ab8a58f785d@kernel.org>
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <87e3d64e-8b25-4d51-a984-7ab8a58f785d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_213328_324365_B35686CC 
X-CRM114-Status: GOOD (  16.03  )
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026/10/28 03:41, David Hildenbrand (Arm) wrote:
>> LLM stumbled upon a possible race in kpage_read() ...
>>
>> Say the reader passes pfn_section_valid() for a device PFN in a section
>> shared with online RAM, gets preempted, and resumes after
>> pgmap_array_delete(). We'd then find no pgmap and return pfn_to_page(pfn),
>> even though the subsection is no longer valid ...
> 
> I think that's similar to our pfn_to_online_page() vs. memory offlining races,
> just slightly different. Getting these races down to 0 is pretty hard.
> 
> This patch here tries to do better and arguably almost looks like a cleanup.
> 
> I wouldn't worry about that one for now; it's extremely unlikely to hit. And it'

Ack.

>>
>> Could we take the memory hotplug read lock in kpage_read(), covering both
>> the lookup and the metadata reads? We can drop it before put_user(), once
>> we're done with the page.
>>
>> Maybe along these lines?
>>
>> ---8<---
>> diff --git a/fs/proc/page.c b/fs/proc/page.c
>> index 6aa99e42ec22..12bed36d76dc 100644
>> --- a/fs/proc/page.c
>> +++ b/fs/proc/page.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/hugetlb.h>
>>   #include <linux/memremap.h>
>>   #include <linux/memcontrol.h>
>> +#include <linux/memory_hotplug.h>
>>   #include <linux/mmu_notifier.h>
>>   #include <linux/page_idle.h>
>>   #include <linux/kernel-page-flags.h>
>> @@ -77,6 +78,8 @@ static ssize_t kpage_read(struct file *file, char __user *buf,
>>   	count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
>>
>>   	while (count > 0) {
>> +		/* Prevent memory removal while inspecting the memmap. */
>> +		get_online_mems();
> get_online_mems() is the big hammer we try to avoid (or ideally remove at some
> point). And it's most pfn_to_online_page() users that are affected.
> 
> A seqcount in pfn_to_online_page() could detect concurrent pgmap removal and
> retry from the start. But I'd rather delay something like that.

Fair enough, let's leave it alone for now given how unlikely it is to hit :)

> Thanks for taking a look! (Can I convince you to review some of the THP fixes?
> pleeeeaaasseee :) )

Of coursssssssse! I'm already looking through the THP fixes :D

Cheers, Lance


