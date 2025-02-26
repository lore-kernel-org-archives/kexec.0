Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1958C3600D
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 15:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jNDX0bDy82gk9QmnrN58DpzxWTxMxMF4PEgthtYO/y8=; b=YtPeg5g4eNC0acqAH6KZ6YwTEs
	ToQIS++XDW80BjFrgkxmCv75lRDArQ+wAbIvAI63hfJqKOBf7jY18fmA49GIXOJpa+u2Y94oBjhKM
	qvlCA6xjNCeL7hiuZNVBheCF0rgxxpGnBractObnnBjy+C5UpqmMur8h+656AJHxK1M0nHdfiijB/
	TsUxfoLjQQTbya3TkkXzXFNMVXxGWrapBCuqQp+S6//OA9wPMOHIrBnpiT993MlYJqJjau/EhTFeG
	SCMtHKoRwFYIhC7V9ab8VAbbsZpxqCUw8JVcDak6+7gg+qluVvBy6ZHYazxZe2KGaHQG3ZhRBmC0Y
	+uyGZgnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvHS0-0000000CU3U-1hL7;
	Thu, 20 Mar 2025 15:04:52 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tn6rP-0000000275g-1DPd;
	Wed, 26 Feb 2025 02:09:20 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5e04f87584dso9519628a12.3;
        Tue, 25 Feb 2025 18:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740535757; x=1741140557; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNDX0bDy82gk9QmnrN58DpzxWTxMxMF4PEgthtYO/y8=;
        b=OJlGHB4txTZyBn9B08S2SNKkTqiYhUYcAu0KEKm7/qZ1VLL+BNzUVBj3fYiuC3v92x
         eF6snukAOXJ7Qa8XU9piwiVKuFwKAd2nfmJoHqWyXhoYiLpOwZMqm9J0OJCOBEYMNsJt
         wQ4E//W9mFwm9isl+uKjgIud6IdrNb+ZpdtAujRU+gr1tX7H6+IlfbHXnqAXiugsMLes
         mzlKm5i8U0Y4Y53lkPxHsuD/p4DIGwkrZYWmZ/YPdPbaA++DfwbEBV0xX2NZCEqA6uhz
         256tZrxJU57bIP2+I2aVuf+/8/APMmzZuXk0dvcqa5NxO+iGCFQiw9XIc0e3qYPqHEsA
         yTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740535757; x=1741140557;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jNDX0bDy82gk9QmnrN58DpzxWTxMxMF4PEgthtYO/y8=;
        b=OY6VFB2ZcJ/OTbsVMUQM4lS3Op3Tsoo0yLUUWLg1rlFE5Ou5CyD9Zc96dOScq0DhrM
         wB4Z/M2KzhAceVs6POaVF9pZCCZoeIgP+bwdHhrmUx8Ej71rVAPsJKPpaKgFpN1rtZ6M
         HjW1wNF3HZH44ehcNMfcBXpcIC+wfg6/x4MjYmyF9QCx0wC37D8VWtNlxxxptm9LOW87
         NpCxA6Q9QyGa3UY/5FlTgNP3lwmMcKA2mNnbbJRUhpTDcq9wdz3xkD7ZU6J8IlPS9w9m
         0bzZuhWthsx2LktT7Eo4xuf/xc1ARmCjg6Gvxc2EvJVXnWIU5b3ZA3Rsp/th64DjGWo8
         LqQg==
X-Forwarded-Encrypted: i=1; AJvYcCWAtS+504ftqiySTKQt4tvCYHIHRFaMEBUddUgdXX8okFITJ7FDkXF6er6q4fImQfIhbttOyQ==@lists.infradead.org, AJvYcCWOkjNzEE/5eCWNDJ1sdMfpAEKedXnY4TRAWzbt1RhCMymWRivUmDdJRHLfaw4M7dspYoaAoRQ1pkJW0oabv/RLjg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyElOBf73P03Wp5ojdxCqyCXXsPmfft5CyU/uwQDtBp1AOCSGUL
	BYxWt59iQ4dN211gk/SJy72r7ejHKjRpUYa12FHUTkCvb9txssuB
X-Gm-Gg: ASbGncsCczz+mhw1QRACzv+gGSTvcOEdZyR9HwLDFYALu8PnnjqZpD3IRLeId9Y98fM
	tJQW9KF7f0EVvj6gkS57Z8XEKhZNjDGSYjP8fc0WIvF7C54wOI0NjPrDjx4DxhFNcyIVjkgOJby
	qmxaENC8jFGxpIEv8ZLH+VPSJsaRpQ632WuQqTfAxw/Goc8MhTdP1lslWEhskByGz86bAVuGMAk
	cwgaqZBvbSZiXvxpyuPJz+3D7lYKIcJ9CNLqlVUhj+d0d0IS5I6CrJPPn8B+0QBRpflNP0k7bqf
	cV8j5UC8+ZbskupN5UVeUV0QqA==
X-Google-Smtp-Source: AGHT+IGRtYD7rWXN/Sb7N5YCwL4iwg6Gy2cLXak4su8dMR+fikHn63505aewDuiYmopReDoTjLpqLQ==
X-Received: by 2002:a05:6402:5508:b0:5dc:cc02:5d25 with SMTP id 4fb4d7f45d1cf-5e4a0d71d15mr1703278a12.11.1740535757056;
        Tue, 25 Feb 2025 18:09:17 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e461f3e675sm1976282a12.72.2025.02.25.18.09.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Feb 2025 18:09:16 -0800 (PST)
Date: Wed, 26 Feb 2025 02:09:15 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 02/14] memblock: add MEMBLOCK_RSRV_KERN flag
Message-ID: <20250226020915.ytxusrrl7rv4g64l@master>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-3-rppt@kernel.org>
 <20250218155004.n53fcuj2lrl5rxll@master>
 <Z7WHL_Xqgoln9oLg@kernel.org>
 <20250224013131.fzz552bn7fs64umq@master>
 <Z711VP45tjBi0kwx@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z711VP45tjBi0kwx@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_180919_329523_AA592D8A 
X-CRM114-Status: GOOD (  33.23  )
X-Mailman-Approved-At: Thu, 20 Mar 2025 08:04:44 -0700
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, Feb 25, 2025 at 09:46:28AM +0200, Mike Rapoport wrote:
>On Mon, Feb 24, 2025 at 01:31:31AM +0000, Wei Yang wrote:
>> On Wed, Feb 19, 2025 at 09:24:31AM +0200, Mike Rapoport wrote:
>> >Hi,
>> >
>> >On Tue, Feb 18, 2025 at 03:50:04PM +0000, Wei Yang wrote:
>> >> On Thu, Feb 06, 2025 at 03:27:42PM +0200, Mike Rapoport wrote:
>> >> >From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>> >> >
>> >> >to denote areas that were reserved for kernel use either directly with
>> >> >memblock_reserve_kern() or via memblock allocations.
>> >> >
>> >> >Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> >> >---
>> >> > include/linux/memblock.h | 16 +++++++++++++++-
>> >> > mm/memblock.c            | 32 ++++++++++++++++++++++++--------
>> >> > 2 files changed, 39 insertions(+), 9 deletions(-)
>> >> >
>> >> >diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> >> >index e79eb6ac516f..65e274550f5d 100644
>> >> >--- a/include/linux/memblock.h
>> >> >+++ b/include/linux/memblock.h
>> >> >@@ -50,6 +50,7 @@ enum memblock_flags {
>> >> > 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
>> >> > 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
>> >> > 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
>> >> >+	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
>> >> 
>> >> Above memblock_flags, there are comments on explaining those flags.
>> >> 
>> >> Seems we miss it for MEMBLOCK_RSRV_KERN.
>> >
>> >Right, thanks!
>> > 
>> >> > 
>> >> > #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
>> >> >@@ -1459,14 +1460,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>> >> > again:
>> >> > 	found = memblock_find_in_range_node(size, align, start, end, nid,
>> >> > 					    flags);
>> >> >-	if (found && !memblock_reserve(found, size))
>> >> >+	if (found && !__memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN))
>> >> 
>> >> Maybe we could use memblock_reserve_kern() directly. If my understanding is
>> >> correct, the reserved region's nid is not used.
>> >
>> >We use nid of reserved regions in reserve_bootmem_region() (commit
>> >61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")) but KHO needs to
>> >know the distribution of reserved memory among the nodes before
>> >memmap_init_reserved_pages().
>> > 
>> >> BTW, one question here. How we handle concurrent memblock allocation? If two
>> >> threads find the same available range and do the reservation, it seems to be a
>> >> problem to me. Or I missed something?
>> >
>> >memblock allocations end before smp_init(), there is no possible concurrency.
>> > 
>> 
>> Thanks, I still have one question here.
>> 
>> Below is a simplified call flow.
>> 
>>     mm_core_init()
>>         mem_init()
>>             memblock_free_all()
>>                 free_low_memory_core_early()
>>                     memmap_init_reserved_pages()
>>                         memblock_set_node(..., memblock.reserved, )   --- (1)
>>                     __free_memory_core()
>>         kmem_cache_init()
>>             slab_state = UP;                                          --- (2)
>> 
>> And memblock_allloc_range_nid() is not supposed to be called after
>> slab_is_available(). Even someone do dose it, it will get memory from slab
>> instead of reserve region in memblock.
>> 
>> From the above call flow and background, there are three cases when
>> memblock_alloc_range_nid() would be called:
>> 
>>   * If it is called before (1), memblock.reserved's nid would be adjusted correctly.
>>   * If it is called after (2), we don't touch memblock.reserved.
>>   * If it happens between (1) and (2), it looks would break the consistency of
>>     nid information in memblock.reserved. Because when we use
>>     memblock_reserve_kern(), NUMA_NO_NODE would be stored in region.
>> 
>> So my question is if the third case happens, would it introduce a bug? If it
>> won't happen, seems we don't need to specify the nid here?
>
>We don't really care about proper assignment of nodes between (1) and (2)
>from one side and the third case does not happen on the other side. Nothing
>should call membloc_alloc() after memblock_free_all(). 
>

My point is if no one would call memblock_alloc() after memblock_free_all(),
which set nid in memblock.reserved properly, it seems not necessary to do
__memblock_reserve() with exact nid during memblock_alloc()? 

As you did __memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN) in this
patch.

>But it's easy to make the window between (1) and (2) disappear by replacing
>checks for slab_is_available() in memblock with a variable local to
>memblock.
> 
>> -- 
>> Wei Yang
>> Help you, Help me
>
>-- 
>Sincerely yours,
>Mike.

-- 
Wei Yang
Help you, Help me

