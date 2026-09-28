Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321EDCA5FA2
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 11:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nyi2h4pBa6aCzJLG0YIuvLzyd1MNYWiHYXFs0BMepts=; b=owaBfIFm2jIQvKhiohtqJDk8Uv
	KZA+rVkuZ2Soz561OCslkl5+WGfpPGEqnXL51UgEUqa9il7nfYvB2xJNVat16gmiSh4SR+vLqAUmn
	mNG6TR1yinUy+a4LDntpa07th2ovysq1kcyuoxxc7MnR36Rc3JBwqhihYdwBoDl4TlOIuV0L0aKuY
	cNcep+g6jr4QMV6vbG68uezTJMZsrY64zvLNnUzfhY9KbjH4G+fsQj2qsHwqq419TVBfAXP17HiWB
	juDwA1dHh8v7qXwxoXzy5988bbX6tJEtQRDgbv/0njBKvRBtLV+p4Gep9qbttQfP+2yZWG2wfQ/FT
	eNS6arkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB9kj-00000000Ub4-1pDI;
	Mon, 28 Sep 2026 11:42:37 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB9ki-00000000Uay-2ZSb
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 11:42:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 98F24432D0;
	Mon, 28 Sep 2026 11:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731591F00893;
	Mon, 28 Sep 2026 11:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790595755;
	bh=nyi2h4pBa6aCzJLG0YIuvLzyd1MNYWiHYXFs0BMepts=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ru89tl2QGLKPM68mggJL9czQCpnCrSr+isKp3atpqRRcql6+o7opzpvFWSzcIDXPl
	 JGByY9q8sjUYq9vWIS01Jc7lEgCJbIWajWkTl2390FTR+0mYhFnu5WaDSK3VtWUFHx
	 9ho3EtniK5Gr/rRTNr0sooak9eJVV2rZ7/FzOkRT5auf/komgOjVdu5J4RFbAmh90D
	 hw52plXyg9wNAt1IAWmWHFHoRrJYTU/6+hNz1W/jNPQUdhtUbLd3NpLC93/BbZaY/p
	 TdtfnTpxgtNJWEUBC0p8b/zzqhisqyNT0eX2sMtoaaVePMxL20iqy6hGuGUjBu0NEg
	 khg8Rm8cAnosw==
Message-ID: <4a57b255-cb38-4e8e-908b-d32e55a1a326@kernel.org>
Date: Mon, 28 Sep 2026 13:42:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vmcoreinfo: export SECTION_HAS_MEM_MAP
To: Dave Young <ruirui.yang@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He
 <baoquan.he@linux.dev>, David Carlier <devnexen@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kexec@lists.infradead.org
References: <20260928-section_has_mem_map-v1-1-4129f6ba2838@kernel.org>
 <9c47dad9-2716-4ae0-b6e2-9e6b5c718859@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <9c47dad9-2716-4ae0-b6e2-9e6b5c718859@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/28/26 12:23, Dave Young wrote:
> On 9/28/26 4:48 PM, David Hildenbrand (Arm) wrote:
>> The crash tool currently hardcodes SECTION_HAS_MEM_MAP, and makedumpfile
>> needs similar information (although still relying on
>> SECTION_MARKED_PRESENT, it should switch to SECTION_HAS_MEM_MAP).
>>
>> Let's just export the value instead, so tools that work on vmcoreinfo
>> will not have to guess.
>>
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>> Result of the discussion in reply to "[PATCH v2 00/13] mm/sparse: remove
>> SECTION_MARKED_PRESENT and further cleanups" [1]
>>
>> This patch can go in independently. It would be preferable if both
>> go into the same kernel release ;)
>>
>> [1] https://lore.kernel.org/r/20260921-b4-sparsemem_cleanups-v2-0-54d81d65e125@kernel.org 
>> ---
>>  kernel/vmcore_info.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
>> index 5a417f8a922a..7833a36064a8 100644
>> --- a/kernel/vmcore_info.c
>> +++ b/kernel/vmcore_info.c
>> @@ -182,6 +182,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>>  	VMCOREINFO_STRUCT_SIZE(mem_section);
>>  	VMCOREINFO_OFFSET(mem_section, section_mem_map);
>>  	VMCOREINFO_NUMBER(SECTION_SIZE_BITS);
>> +	VMCOREINFO_NUMBER(SECTION_HAS_MEM_MAP);
>>  	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
>>  #endif
>>  	VMCOREINFO_STRUCT_SIZE(page);
> 
> Current crash code looks below:
> #define SECTION_MARKED_PRESENT          (1UL<<0)
> #define SECTION_HAS_MEM_MAP             (1UL<<1)
> #define SECTION_IS_ONLINE               (1UL<<2)
> #define SECTION_IS_EARLY                (1UL<<3)
> #define SECTION_TAINT_ZONE_DEVICE       (1UL<<4)
> #define SECTION_MAP_LAST_BIT            (1UL<<5)
> #define SECTION_MAP_MASK                (~(SECTION_MAP_LAST_BIT-1))
> 
> 
> And it does not match the kernel for below chunk with ifdef
> #ifdef CONFIG_ZONE_DEVICE
>         SECTION_TAINT_ZONE_DEVICE_BIT,
> #endif
> #ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
>         SECTION_IS_VMEMMAP_PREINIT_BIT,
> #endif
> 
> The last bit could be wrong in crash.  So all numbers should be exported in vmcoreinfo.
> 
> Thoughts?

You know the crash code best, so likely ... it's time one of the crash people
takes over this patch?

-- 
Cheers,

David

