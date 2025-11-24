Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10C3CFD317
	for <kexec@archiver.kernel.org>; Mon, 24 Nov 2025 13:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VnvBX/XZZCUCV5Tjc3nbVAUiO6caprpKW+yLpMrITTs=; b=FBwLs/X/mJ3FLc78VCKE5Giqt5
	Ewy2kz017mDvZ+o72HSIuE5i6nZ4PE/pK1EFvFfkjQVRW1e44WUawnP2q9xd1sxY372f8AtHwE/nC
	h9liGFjqOd5X42Uj9qt/lCQWkc5kjfH6GnxpJZ9vWR/3/2L1vOi6oj5Ui1+7jLDEL6mNSN1UHIuQw
	+La74nX7p4bmRdebqCyX4IlIssM5idihfo/ldZy6HCxUI4BzGqla4uFEI4klvzQqq0Qc9uGOF3DC6
	T6A/u//aymfbqzzoFrvQTc3OfxgDIKCpTcyMJhCAwHRo1aH1H+kItCBb/vjGbifAwQo4ORWgjgdon
	k0wGXGOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNWZt-0000000Bkdu-1x87;
	Mon, 24 Nov 2025 13:26:01 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNWZr-0000000BkdS-00lY
	for kexec@lists.infradead.org;
	Mon, 24 Nov 2025 13:26:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A6D31429DA;
	Mon, 24 Nov 2025 13:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5B3C4CEF1;
	Mon, 24 Nov 2025 13:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763990758;
	bh=V3pNaPV0kKnax3zGGnv1AnsUhY0LbnCFMQ5OaJ21pJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CYTjpF4IqP6zSOrYyA371vjXfNJC7bd00OTA1CE5rpfF6muw17PEE2UxeKCi15eLq
	 PQxSKfXFIgFWxfzPAYgfMtTjyX5g80i197Ya+zrjB7Sw9Cyy+NCIkFgg7jfzi5qcNW
	 b41ni0lnkTl61chQhTW85fIs872WP5c4GTYZzcUuPdAI1GDVpCZrY9uEhS+l5nDImj
	 l0XWnjCK579Po2HYhTBgnPZthYY/E19895OxnfPmAoIi8XVq96ZrczHVKeplcZsaDA
	 USypK0KqHUs4xEfdivciT9uT3FLODj0pbwolLV7dU9zvVaL6JKk6X10jIl6OpLZxVN
	 I1Nmy/oMt9gXA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: ranxiaokai627@163.com,  rppt@kernel.org,  akpm@linux-foundation.org,
  catalin.marinas@arm.com,  changyuanl@google.com,  graf@amazon.com,
  pasha.tatashin@soleen.com,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  ran.xiaokai@zte.com.cn
Subject: Re: [PATCH v3] KHO: Fix boot failure due to kmemleak access to
 non-PRESENT pages
In-Reply-To: <mafs0see3zkug.fsf@kernel.org> (Pratyush Yadav's message of "Mon,
	24 Nov 2025 13:16:55 +0100")
References: <20251124025943.94469-1-ranxiaokai627@163.com>
	<mafs0see3zkug.fsf@kernel.org>
Date: Mon, 24 Nov 2025 14:25:55 +0100
Message-ID: <mafs0ms4bzhng.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_052559_081789_E745E1A8 
X-CRM114-Status: GOOD (  15.17  )
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

On Mon, Nov 24 2025, Pratyush Yadav wrote:

> On Mon, Nov 24 2025, ranxiaokai627@163.com wrote:
>
>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>
>> When booting with debug_pagealloc=on while having:
>> CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT=y
>> CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=n
>> the system fails to boot due to page faults during kmemleak scanning.
>>
>> This occurs because:
>> With debug_pagealloc is enabled, __free_pages() invokes
>> debug_pagealloc_unmap_pages(), clearing the _PAGE_PRESENT bit for
>> freed pages in the kernel page table.
>> KHO scratch areas are allocated from memblock and noted by kmemleak. But
>> these areas don't remain reserved but released later to the page allocator
>> using init_cma_reserved_pageblock(). This causes subsequent kmemleak scans
>> access non-PRESENT pages, leading to fatal page faults.
>>
>> Mark scratch areas with kmemleak_ignore_phys() after they are allocated
>> from memblock to exclude them from kmemleak scanning before they are
>> released to buddy allocator to fix this.
>>
>> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
>> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> ---
>>  kernel/liveupdate/kexec_handover.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>> index 224bdf5becb6..c729d455ee7b 100644
>> --- a/kernel/liveupdate/kexec_handover.c
>> +++ b/kernel/liveupdate/kexec_handover.c
>> @@ -11,6 +11,7 @@
>>  
>>  #include <linux/cleanup.h>
>>  #include <linux/cma.h>
>> +#include <linux/kmemleak.h>
>>  #include <linux/count_zeros.h>
>>  #include <linux/kexec.h>
>>  #include <linux/kexec_handover.h>
>> @@ -1369,6 +1370,7 @@ static __init int kho_init(void)
>>  		unsigned long count = kho_scratch[i].size >> PAGE_SHIFT;
>>  		unsigned long pfn;
>>  
>> +		kmemleak_ignore_phys(kho_scratch[i].addr);
>
> Can you please put the explanation you gave in [0] for why this is not
> necessary in KHO boot as a comment here?

And also an explanation of why this is necessary in the first place. You
do explain that in the commit message, but a shorter version as a
comment will make this a lot easier to understand instead of having to
dig through git history.

[...]

-- 
Regards,
Pratyush Yadav

