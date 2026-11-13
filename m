Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC56B606AA15
	for <kexec@archiver.kernel.org>; Fri, 13 Nov 2026 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4kIre6CZ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IM9TpDQ/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=zDSv49j+RC7blbeAA8J/fPgGpqdzGyAQV5qTaZUyPN8=; b=4kIre6CZ9nOEoL
	SMMjORjwfcfCoSlEUWk2Z0vbIP1sIKfRm92c8HrQ2Mn+Rk7xFqqyDee5g3F0y6O1nogJ4WZgdvvib
	HPwVv4PmyoKnoGqVwq78rT3JpjINmfkLq/ArNmzVYE6Qi05TIS4/aSrSompiEVC3uyWyMfMu4DDw0
	S/NtOY9pj9ZzBbL01Xh63Ao4HamabW9e2PCwiq2d1V/73DcsSRIV3H4qXsgySOnQYUu3TzqSUNhuA
	UV4VsoKxfpiLxcvaWCZJGa03HelHI9GJZZDDVJB3P77zSy2f/Wys4UKTxPLIiJ6VVRhmNXcHjT5qB
	xtIVPLxft/Q7Ii2ccoyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRuhT-0000000Dgo5-0gZB;
	Fri, 13 Nov 2026 17:04:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRuhQ-0000000Dgni-0NEC
	for kexec@lists.infradead.org;
	Fri, 13 Nov 2026 17:04:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794589465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDSv49j+RC7blbeAA8J/fPgGpqdzGyAQV5qTaZUyPN8=;
	b=IM9TpDQ/6yeiEZD5MT89wAjpbCAJgEdL2Ry6wrAQ0iw4OL5EQgNl3b1RKJ0usTh4Iuu5AV
	0hrXl5GEy4y3+1qS2FVY2FFTa0qaT6YW8q4v0i66WNxQaNvIo48gdBFQMz8pZfmc1w6GQN
	5k1v6zjTIhYeCzySQPefA4FzlN0XBkM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-vVejA01xMy6lMmsvZ-05hQ-1; Fri, 13 Nov 2026 12:04:21 -0500
X-MC-Unique: vVejA01xMy6lMmsvZ-05hQ-1
X-Mimecast-MFC-AGG-ID: vVejA01xMy6lMmsvZ-05hQ_1794589460
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b191f8a9b3so1716340a91.1
        for <kexec@lists.infradead.org>; Fri, 13 Nov 2026 09:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589460; x=1795194260;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zDSv49j+RC7blbeAA8J/fPgGpqdzGyAQV5qTaZUyPN8=;
        b=zekKXi3GMUtRHtIV1v/NTQRDbpvJY6HZgp12j1U0JCJ402kx5ygN5uf8GHZriIhMNN
         6SJKSdA1JAZpE8sS9T47mzkdLdm9MK4Nc/T30WsA2MdJeCYsc9ZgPmfLqglKTxN42xCE
         Zv5rYPmC5byIJwgyTaEHDyWg/rDN1xmNfaUSWf4C86r/xe/LiUGyUidwe/gGzu1KXy5D
         n93KCbzDQVf/u0HevAcLdGPIuqLhvxkLGZ2dwR2FioZhy4b0y9aq5f5RXo53PyGEe5RH
         +8dOEaDZgSb67lfod/pClVKdq6s1G7uf2jCWIKKVUGHArqHepcEX7aMIyDRqsqVaGwDx
         rJSw==
X-Forwarded-Encrypted: i=1; AL+hErFsVxMOToBFa0Thnx+OMHIEjBEUNqhkyLhLIJPnp64Z8oFDsVNkDFJsx1T2syMk5I2sAhLyFw==@lists.infradead.org
X-Gm-Message-State: APuU4Z/scBNclS8RGAYapeLEQOqFwAgC/TDZQFUp22RLgXQm/gMNqvLH
	pcVcA2FDUTYy+HXIXJ9VeMKDrYTIlAZKRtAkdjkkg4Z5BjelZGhDeo3nquf04GxOA2xEddOGCqw
	Z/ObL8XOMTg0/u6MV1k7ECeCTqiUIOtwYMfowDP8xhBFLdk0KL655ZWNDoQiARQ==
X-Gm-Gg: AYBFou14/W6fqEZ3naAvb1TifT8nebsoXrAiaOHa8MIJ7lc8ecvL1n7OOeG58ja776S
	AAJXnv0a0SD2Jk0xvtTDIKAqq5CR1vmKYEn3QhUzXkecmeONKFQ5CnvsfiCvmikmwdvGrusxhV8
	XzCEoTnlJWQ3b3uyw6+MVjtqJVJm3TLGBAuczO4wb3Y0MFR3lAK5SEVbgsHMENeznYU6OZ5rBjg
	2E6inMSjnlJryxvrs7eY4FjDTk2JZxFMoPlF7GlHE6ORclkAx/xOsHIUyw3GBLm1qFy52Bb/B9z
	B0AByV0tTMsDxxgesRUFPmEPFAyVYNLieLcBNtVD5MOrNTVJwlEzf65Ld695mORobRVZvHdZTlH
	OOPCVKe0pObHBviFhWyJDmhy8p+UDMQP15cmhpYUsg+Btp5PNMOBq72bg/JqHYEcnTIQRRH8=
X-Received: by 2002:a17:90b:4e8f:b0:3b0:ce1c:e754 with SMTP id 98e67ed59e1d1-3b1b0b52de7mr2828514a91.62.1794589459492;
        Fri, 13 Nov 2026 09:04:19 -0800 (PST)
X-Received: by 2002:a17:90b:4e8f:b0:3b0:ce1c:e754 with SMTP id 98e67ed59e1d1-3b1b0b52de7mr2828163a91.62.1794589454220;
        Fri, 13 Nov 2026 09:04:14 -0800 (PST)
Received: from [192.168.1.102] ([117.245.168.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f7d9971sm13310855ad.34.2026.11.13.09.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 09:04:13 -0800 (PST)
Message-ID: <7d5f300f-ab18-4086-8a61-c3347168067a@redhat.com>
Date: Fri, 13 Nov 2026 22:34:06 +0530
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
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <avV9qoaPMBLCNOXD@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YdUKMCGqS_upaWdrB9Gi5GF6HED3MJsfTuXXqdMsfA8_1794589460
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_090428_232135_F5EFE773 
X-CRM114-Status: GOOD (  39.53  )
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

Thanks for the quick check. I apologies in advance if I am missing
something obvious.

On 12/11/26 2:19 pm, Mike Rapoport wrote:
> On Thu, Nov 12, 2026 at 12:02:05PM +0530, Mukesh Pilaniya wrote:
>> Hi Mike,
>>
>> On 04/11/26 10:20 pm, Mike Rapoport (Microsoft) wrote:
>>> kexec_add_buffer() users may depend on the order in which memory holes are
>>> searched. For instance, arm64 places the kernel bottom-up and then
>>> requires the DTB to be above the kernel.
>>>
>>> kho_walk_bootmem() walks the bootmem areas in the order they were
>>> reserved, so if the kernel lands in a small area at the top of the memory
>>> there is no room left for the DTB and kexec fails. For example, on an
>>> arm64 VM with 2G of RAM and kho_bootmem=8M,64M,64M, the lowmem area is
>>> reserved first at the top of the memory, the kernel image takes most of
>>> it and kexec fails with
>>>
>>>   kexec_file(Image): Could not find any suitable kernel location!
>>>
>>> Sort the bootmem areas by address and walk them in ascending order, or in
>>> descending order for top-down searches, like kexec_walk_resources() does.
>>>
>>> Fixes: 3bdecc3c93f9 ("kexec: add KHO support to kexec file loads")
>>> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>> ---
>>>  kernel/liveupdate/kexec_handover.c | 57 ++++++++++++++++++++++++++++++--------
>>>  1 file changed, 46 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>>> index 6f1f55fe31819..2ac5d94f33fd4 100644
>>> --- a/kernel/liveupdate/kexec_handover.c
>>> +++ b/kernel/liveupdate/kexec_handover.c
>>> @@ -26,6 +26,7 @@
>>>  #include <linux/list.h>
>>>  #include <linux/memblock.h>
>>>  #include <linux/page-isolation.h>
>>> +#include <linux/sort.h>
>>>  #include <linux/unaligned.h>
>>>  #include <linux/vmalloc.h>
>>>  
>>> @@ -820,6 +821,14 @@ bool kho_bootmem_overlap(phys_addr_t phys, size_t size)
>>>  	return false;
>>>  }
>>>  
>>> +static int __init kho_bootmem_cmp(const void *_a, const void *_b)
>>> +{
>>> +	const struct kho_bootmem *a = _a;
>>> +	const struct kho_bootmem *b = _b;
>>> +
>>> +	return cmp_int(a->addr, b->addr);
>>> +}
>>> +
>>>  /**
>>>   * kho_reserve_bootmem - Reserve a contiguous chunk of memory for kexec
>>>   *
>>> @@ -904,6 +913,9 @@ static void __init kho_reserve_bootmem(void)
>>>  	 */
>>>  	kho_bootmem_cnt = i;
>>>  
>>> +	sort(kho_bootmem, kho_bootmem_cnt, sizeof(*kho_bootmem),
>>> +	     kho_bootmem_cmp, NULL);
>> This only covers the case where this kernel allocated the areas itself.
>> On a KHO boot the array comes from the previous kernel. A kernel with
>> this series that is handed over from one without it therefore keeps
>> walking the areas in reservation order for every following
>> kexec_file_load, and the arm64 failure you describe comes back until the
>> next cold boot and vise versa because the ABI string is still
>> "kho-v4".
> 
> If we were able to kexec from a kernel with no reservation ordering, the
> issue is not there, isn't it?
IMHO that holds for the image that was just handed over, but maybe not
for the next one. The producer's last kexec_file_load did place that
exact Image, DTB and command line through the areas in that order, so I
agree that reloading the same image from the consumer will find the same
spot. The order is still arbitrary though, and whether it works seems to
depend on the size of the image being loaded.

To give you the case I was looking at: on a QEMU arm64 guest with 4K
pages, 2 GiB of RAM and kho_bootmem=44M,64M,64M, the 44 MiB lowmem area
is reserved first, at the top of RAM (0xb8800000). The Image is about
38 MiB, and the DTB has to go above it on a 2 MiB boundary, which lands
exactly on 0xbb400000, the end of that area. The load then fails with
"kexec_file_load failed: Cannot assign requested address", and the next
area is never tried, because the walk stops at the first area that
cannot take the buffer. With the areas walked in address order the same
image is placed in a lower, larger area and boots. So the first area
decides, and a few MiB of growth in the Image or a larger DTB is enough
to flip the result -- which is the part that makes me a bit nervous
about the first kexec after a handover.

It also does not settle down the chain, as far as I can tell. A kernel
booted by KHO never reserves, so it never sorts: B inherits A's order,
C inherits B's order, and only a cold boot sorts. That makes the same
binary behave differently depending on how it was started. Sorting in
kho_mem_retrieve as well would cover it.
> 
> And after a cycle of KHO boots to newer kernels we anyway can get to the
> point when bootmem is not large enough.
That is the same argument, and it is probably why I am not fully
convinced that the previous successful kexec covers the ordering case
either. The inherited state was adequate for the load that produced the
running kernel, not necessarily for the load it is about to perform.

>  
>>> +static int kho_bootmem_walk_top_down(struct kexec_buf *kbuf,
>>> +				     int (*func)(struct resource *, void *))
>>>  {
>>>  	int ret = 0;
>>> -	int i;
>>>  
>>> -	for (i = 0; i < kho_bootmem_cnt; i++) {
>>> -		struct resource res = {
>>> -			.start = kho_bootmem[i].addr,
>>> -			.end = kho_bootmem[i].addr + kho_bootmem[i].size - 1,
>>> -		};
>>> +	for (int i = kho_bootmem_cnt - 1; i >= 0; i--) {
>>
>> kho_bootmem_cnt is unsigned, but the reverse loops in
>> kho_reserve_bootmem() and kho_bootmem_walk_top_down() start an int
>> counter at kho_bootmem_cnt - 1, which for a zero count is UINT_MAX
>> converted to int.  That conversion is implementation-defined; with the
>> current compilers it yields -1 and the loop body is skipped.
> 
> We never get here with kho_bootmem_cnt == 0.
Unless I am misreading it, we do, via kho_bootmem=0%. The parser accepts
it and stores the scale without a zero check, then bootmem_size_update()
takes the explicit-size branch and assigns the zero-initialised
bootmem_size_pernode to every node. kho_reserve_bootmem_area() returns
early for a zero size without recording the area, so kho_bootmem_cnt
stays 0 and kho_enable is left alone and only the error path clears it.

kho_locate_mem_hole() is guarded by kho_enable only, so with cnt == 0
both walks return 0 and the caller turns that into -EADDRNOTAVAIL: KHO
is enabled with no regions and every kexec_file_load fails with "Cannot
assign requested address".

FWIW this became possible with 214f9649 commit, before it the
zero-sized areas were recorded, so cnt was never 0. The zero-scale patch
you posted in the v4 series [v3 1/5]thread closes this one.

>  
>> How about using this one.
>> 	for (unsigned int i = kho_bootmem_cnt; i-- > 0;)
>>
>> Reviewed-by: Mukesh Pilaniya <mpilaniy@redhat.com>
> 
> Thanks!
>  
>> -- 
>> Regards,
>> Mukesh Pilaniya
>>
> 

-- 
Regards,
Mukesh Pilaniya


