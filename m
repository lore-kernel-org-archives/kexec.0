Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBF7606A31C
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lTZQi6NP;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XJuN6bGQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=HcxVbOcOy4JVEhqcYNolqzI7uMO52IjTv8D4sfciG7I=; b=lTZQi6NPZ8Jh9n
	3TkY4awVSGw8kC6R+53v6uu9QSBiiO7yZuVg510GV+2zjg9VNtggoAz1RbM2DrZiiHrDxuAOlEFNt
	AzqkTnLjhVcijR4iITDZyS0ghTjgEBuwDbIalA362wQAyYfXh0I/mlN+thSFUxwR/7h6xxgq38SLC
	fi/xWQFQajizQO+kGspoNOxDRcP/vmL0Cs2yVqmF+qqsukbII/sfApcZ2xE9k/a9+7Vs9xAxlRDXl
	s3dFyfkUDsmpIaOSY2mvX8m81XiARrorDixm0Ol6vMP1Jlk2rQ+ov1uq0ND1oOBe12j5dPKN9+sw0
	OOoOsw5qCLFt5QDG9lgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSs6e-00000001ckw-0jwW;
	Mon, 16 Nov 2026 08:30:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSs6Y-00000001cjn-0tJC
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 08:30:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794817819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HcxVbOcOy4JVEhqcYNolqzI7uMO52IjTv8D4sfciG7I=;
	b=XJuN6bGQqf6W/ocxGmz8TkekE+MYOZaXko4yn6xoUI8nDAGyKZdITQydIbjAxjaaTbXtiC
	q8TZoVX2zpAXzLbDwgglE6NfXMv4v4rY5cGN0Zqh5R4d0AXExuSqZAro7gW1MzBqslsn2Z
	y5p3nolO4TF2dptyghW0Ui0nnWmsNyk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-d4XCmQkdNP6wz1Pbhi1hHw-1; Mon, 16 Nov 2026 03:30:18 -0500
X-MC-Unique: d4XCmQkdNP6wz1Pbhi1hHw-1
X-Mimecast-MFC-AGG-ID: d4XCmQkdNP6wz1Pbhi1hHw_1794817817
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e9501034c4so48436845ad.0
        for <kexec@lists.infradead.org>; Mon, 16 Nov 2026 00:30:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794817817; x=1795422617;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HcxVbOcOy4JVEhqcYNolqzI7uMO52IjTv8D4sfciG7I=;
        b=AYFCL1IxThI4EOf8nL5YOSoxuKx+je/zCGswlUOkjQaYiilRVLqX6Ga9CkIOeSrRff
         VIEKmntXgpaVYj2QasaxhkzqO5bULBSiVGv8nbvA8jauY/tbBcSmyHRiuSDqTbjfYtfS
         ca6Pwf2LwIhMWRc9Bwm2omDKpIy6FYE0C5GK3B/27Z4u+QzzB7kLBPmmF1pKKkfHw9zV
         iaRoYJZ2k5+gM+xcnoieoyUq2Im7l9FMW6B36XUOiLJU90N/xJWaEVixAwIeak2wkTiH
         wmu9gzz0Vf53y2LsaTS5n4n8syKMKzDDQWMwVJluQO6pkJQl0sKjScEoOEYxQ+vd+Eux
         Ly9g==
X-Forwarded-Encrypted: i=1; AL+hErEdJHnclbp+ta8GhsV5WZV7Pbpq/KSj6WC2uHCHV+AaV5hSNtPz0hZz3GWSZoyyPDufbl5I7A==@lists.infradead.org
X-Gm-Message-State: APuU4Z8utwGvKHvUDw4b46hTuysTlOIkQ8jRZC+IONwZxPRnfbavsOeW
	liWbyqUu8VQJ0iqvarj9IFifvwwCQktdMmzwzK/lxLiY9cQpfbToGn9otuVz5eebGMxhP0OIwKi
	BQGuS0bXpJapa66Cp+WFc+uwsm6DaF5k/P6Ifwl7aw0xHRctsIopBzFvcfJGrDw==
X-Gm-Gg: AZFdTZeTT0IJcGxYdKMMOZsORUaEJMpDyLc0FmLMozRHWI95kxUT/v+yBZGsRBY1eVg
	6+QyUsiX2uyGVpctUNQbyCFldZnnFyvflHshPh7gGdJlpm/rqqcutu13P1NVCfcDQJ2meO7eB6Q
	UfuHHjgEd30VOlfGIdV84kV6ChSYBgbyUh/w0eMl0OQRtU2DSRgTNKDU9DsNBaFsuaSxrRANgNv
	HNEZuP8k7b1ba1kvlU/yEWSGTXF3iBiu/9oUA93offeVd6AtyEnLuZ0uwEBJX+drWOOC6t0ysou
	fBFtEPo8FKl1pMGvzmbTXGz2ULADhBGiL0PzOaxrph3tNXk51fwexUavf8s8gdmOyPmbKTdssdu
	58/YaqCY838T+IhmxAJCOsxWl6yZog4oX7AQthNzb2LKiqNhz3GwL+z2mq+8DsDT3nMD1
X-Received: by 2002:a17:903:2281:b0:2e9:55fc:ded2 with SMTP id d9443c01a7336-2ee0dec63demr105228465ad.52.1794817816650;
        Mon, 16 Nov 2026 00:30:16 -0800 (PST)
X-Received: by 2002:a17:903:2281:b0:2e9:55fc:ded2 with SMTP id d9443c01a7336-2ee0dec63demr105228045ad.52.1794817816125;
        Mon, 16 Nov 2026 00:30:16 -0800 (PST)
Received: from [192.168.1.41] ([117.245.173.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f4ad519sm33628995ad.2.2026.11.16.00.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 00:30:15 -0800 (PST)
Message-ID: <f402c25e-df9f-4007-914c-263694a00885@redhat.com>
Date: Mon, 16 Nov 2026 14:00:08 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] kho: walk bootmem areas in address order
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Chen Pei <cp0613@linux.alibaba.com>, George Guo <guodongtai@kylinos.cn>,
 Kexin Liu <liukexin@kylinos.cn>, Sourabh Jain <sourabhjain@linux.ibm.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20261104-kho-bootmem-sizing-v2-0-b0d1a834780f@kernel.org>
 <20261104-kho-bootmem-sizing-v2-1-b0d1a834780f@kernel.org>
 <990cc079-70ab-4fcf-9974-679aaf07849e@redhat.com>
 <avV9qoaPMBLCNOXD@kernel.org>
 <7d5f300f-ab18-4086-8a61-c3347168067a@redhat.com>
 <avl5QjUdYWcCP8Yo@kernel.org>
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <avl5QjUdYWcCP8Yo@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pBYR8dlbzuXhlbuN6PG1_-sQT-cWfAZUjXVbHkli2Gc_1794817817
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_003022_358553_688C8664 
X-CRM114-Status: GOOD (  45.52  )
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mike,

On 15/11/26 2:50 pm, Mike Rapoport wrote:
> On Fri, Nov 13, 2026 at 10:34:06PM +0530, Mukesh Pilaniya wrote:
>> Hi Mike,
>>
>> Thanks for the quick check. I apologies in advance if I am missing
>> something obvious.
>>
>> On 12/11/26 2:19 pm, Mike Rapoport wrote:
>>> On Thu, Nov 12, 2026 at 12:02:05PM +0530, Mukesh Pilaniya wrote:
>>>> Hi Mike,
>>>>
>>>> On 04/11/26 10:20 pm, Mike Rapoport (Microsoft) wrote:
>>>>> kexec_add_buffer() users may depend on the order in which memory holes are
>>>>> searched. For instance, arm64 places the kernel bottom-up and then
>>>>> requires the DTB to be above the kernel.
>>>>>
>>>>> kho_walk_bootmem() walks the bootmem areas in the order they were
>>>>> reserved, so if the kernel lands in a small area at the top of the memory
>>>>> there is no room left for the DTB and kexec fails. For example, on an
>>>>> arm64 VM with 2G of RAM and kho_bootmem=8M,64M,64M, the lowmem area is
>>>>> reserved first at the top of the memory, the kernel image takes most of
>>>>> it and kexec fails with
>>>>>
>>>>>   kexec_file(Image): Could not find any suitable kernel location!
>>>>>
>>>>> Sort the bootmem areas by address and walk them in ascending order, or in
>>>>> descending order for top-down searches, like kexec_walk_resources() does.
>>>>>
>>>>> Fixes: 3bdecc3c93f9 ("kexec: add KHO support to kexec file loads")
>>>>> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>>>> ---
>>>>>  kernel/liveupdate/kexec_handover.c | 57 ++++++++++++++++++++++++++++++--------
>>>>>  1 file changed, 46 insertions(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>>>>> index 6f1f55fe31819..2ac5d94f33fd4 100644
>>>>> --- a/kernel/liveupdate/kexec_handover.c
>>>>> +++ b/kernel/liveupdate/kexec_handover.c
>>>>> @@ -26,6 +26,7 @@
>>>>>  #include <linux/list.h>
>>>>>  #include <linux/memblock.h>
>>>>>  #include <linux/page-isolation.h>
>>>>> +#include <linux/sort.h>
>>>>>  #include <linux/unaligned.h>
>>>>>  #include <linux/vmalloc.h>
>>>>>  
>>>>> @@ -820,6 +821,14 @@ bool kho_bootmem_overlap(phys_addr_t phys, size_t size)
>>>>>  	return false;
>>>>>  }
>>>>>  
>>>>> +static int __init kho_bootmem_cmp(const void *_a, const void *_b)
>>>>> +{
>>>>> +	const struct kho_bootmem *a = _a;
>>>>> +	const struct kho_bootmem *b = _b;
>>>>> +
>>>>> +	return cmp_int(a->addr, b->addr);
>>>>> +}
>>>>> +
>>>>>  /**
>>>>>   * kho_reserve_bootmem - Reserve a contiguous chunk of memory for kexec
>>>>>   *
>>>>> @@ -904,6 +913,9 @@ static void __init kho_reserve_bootmem(void)
>>>>>  	 */
>>>>>  	kho_bootmem_cnt = i;
>>>>>  
>>>>> +	sort(kho_bootmem, kho_bootmem_cnt, sizeof(*kho_bootmem),
>>>>> +	     kho_bootmem_cmp, NULL);
>>>> This only covers the case where this kernel allocated the areas itself.
>>>> On a KHO boot the array comes from the previous kernel. A kernel with
>>>> this series that is handed over from one without it therefore keeps
>>>> walking the areas in reservation order for every following
>>>> kexec_file_load, and the arm64 failure you describe comes back until the
>>>> next cold boot and vise versa because the ABI string is still
>>>> "kho-v4".
>>>
>>> If we were able to kexec from a kernel with no reservation ordering, the
>>> issue is not there, isn't it?
>> IMHO that holds for the image that was just handed over, but maybe not
>> for the next one. The producer's last kexec_file_load did place that
>> exact Image, DTB and command line through the areas in that order, so I
>> agree that reloading the same image from the consumer will find the same
>> spot. The order is still arbitrary though, and whether it works seems to
>> depend on the size of the image being loaded.
>>
>> To give you the case I was looking at: on a QEMU arm64 guest with 4K
>> pages, 2 GiB of RAM and kho_bootmem=44M,64M,64M, the 44 MiB lowmem area
>> is reserved first, at the top of RAM (0xb8800000). The Image is about
>> 38 MiB, and the DTB has to go above it on a 2 MiB boundary, which lands
>> exactly on 0xbb400000, the end of that area. The load then fails with
>> "kexec_file_load failed: Cannot assign requested address", and the next
>> area is never tried, because the walk stops at the first area that
>> cannot take the buffer. With the areas walked in address order the same
>> image is placed in a lower, larger area and boots. So the first area
>> decides, and a few MiB of growth in the Image or a larger DTB is enough
>> to flip the result -- which is the part that makes me a bit nervous
>> about the first kexec after a handover.
> 
> There's always a risk that KHO will run out of bootmem, even presuming we
> fixed all our bugs :)
> 
> In your example it happens sooner then it should because there's still
> free memory that kexec won't use, but it's still the same - we've run out
> of bootmem.
> 
> I prefer to keep the sorting in the cold boot going forward to save a few
> cycles at kexec time, so I'd rather not add sorting to the kexec'ed boot.
Fair enough, and I'll drop the sorting-in-retrieve suggestion.

> 
> So the kernel from 7.5 will have it right and if there's a case when we use
> an older stable kernel for the cold boot, and we see that we *really* need
> sorting after kexec there we can just add such sort as a fix for stable.
That works for me. The change is small, so the backport should be
mechanical.

> 
> BTW, in your case it's enough to switch lowmem and global sizes to gain a
> few megs for future image growth, isn't it?
>  
>> It also does not settle down the chain, as far as I can tell. A kernel
>> booted by KHO never reserves, so it never sorts: B inherits A's order,
>> C inherits B's order, and only a cold boot sorts. That makes the same
>> binary behave differently depending on how it was started. Sorting in
>> kho_mem_retrieve as well would cover it.
>>>
>>> And after a cycle of KHO boots to newer kernels we anyway can get to the
>>> point when bootmem is not large enough.
>> That is the same argument, and it is probably why I am not fully
>> convinced that the previous successful kexec covers the ordering case
>> either. The inherited state was adequate for the load that produced the
>> running kernel, not necessarily for the load it is about to perform.
>>
>>>  
>>>>> +static int kho_bootmem_walk_top_down(struct kexec_buf *kbuf,
>>>>> +				     int (*func)(struct resource *, void *))
>>>>>  {
>>>>>  	int ret = 0;
>>>>> -	int i;
>>>>>  
>>>>> -	for (i = 0; i < kho_bootmem_cnt; i++) {
>>>>> -		struct resource res = {
>>>>> -			.start = kho_bootmem[i].addr,
>>>>> -			.end = kho_bootmem[i].addr + kho_bootmem[i].size - 1,
>>>>> -		};
>>>>> +	for (int i = kho_bootmem_cnt - 1; i >= 0; i--) {
>>>>
>>>> kho_bootmem_cnt is unsigned, but the reverse loops in
>>>> kho_reserve_bootmem() and kho_bootmem_walk_top_down() start an int
>>>> counter at kho_bootmem_cnt - 1, which for a zero count is UINT_MAX
>>>> converted to int.  That conversion is implementation-defined; with the
>>>> current compilers it yields -1 and the loop body is skipped.
>>>
>>> We never get here with kho_bootmem_cnt == 0.
>> Unless I am misreading it, we do, via kho_bootmem=0%. The parser accepts
>> it and stores the scale without a zero check, then bootmem_size_update()
>> takes the explicit-size branch and assigns the zero-initialised
>> bootmem_size_pernode to every node. kho_reserve_bootmem_area() returns
>> early for a zero size without recording the area, so kho_bootmem_cnt
>> stays 0 and kho_enable is left alone and only the error path clears it.
>>
>> kho_locate_mem_hole() is guarded by kho_enable only, so with cnt == 0
>> both walks return 0 and the caller turns that into -EADDRNOTAVAIL: KHO
>> is enabled with no regions and every kexec_file_load fails with "Cannot
>> assign requested address".
>>
>> FWIW this became possible with 214f9649 commit, before it the
>> zero-sized areas were recorded, so cnt was never 0. The zero-scale patch
>> you posted in the v4 series [v3 1/5]thread closes this one.
>>
>>>  
>>>> How about using this one.
>>>> 	for (unsigned int i = kho_bootmem_cnt; i-- > 0;)
>>>>
>>>> Reviewed-by: Mukesh Pilaniya <mpilaniy@redhat.com>
>>>
>>> Thanks!
>>>  
>>>> -- 
>>>> Regards,
>>>> Mukesh Pilaniya
>>>>
>>>
>>
>> -- 
>> Regards,
>> Mukesh Pilaniya
>>
> 

-- 
Regards,
Mukesh Pilaniya


