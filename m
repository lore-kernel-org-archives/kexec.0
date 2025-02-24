Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE3FC3600B
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 15:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A4GvaqVIL/hNKQlnj0DT9cN3mMKxJVdcE+NJpBmVvb8=; b=FdqbC0dPOxsHiqDGplZDIfzz4Q
	pjqGv/myRlHGWM6LbyX62ct76LaURCfWt8C81DofsZ9tj3XaZN1pX2q9TqM/S1GGhCM8ha9HJM4O9
	kaBuaHGyOMgiRrdA7dyjJiud4L9/du1eL+kjks/WMlhh/rZENR35Md8B/0Hf38PvV7T9iOnBtBsvX
	QKDhZfKHVKPPyCOcA9Dh+dwZ3Vf63XfjrsMrXHs5OgJrZKSNdjn73EQGpozou2fozYqqYqEp35sK0
	1JH6r3Vd5GJIq4MHWXFUqzsZ6QgT06aL1he8WX3/jZEmNvKKwe3hlIELaOcZ720fmdsl0g2YVoz/X
	mUPPKkuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvHRz-0000000CU1k-0uNh;
	Thu, 20 Mar 2025 15:04:51 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmNJn-0000000C4OU-18Ao;
	Mon, 24 Feb 2025 01:31:36 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5e04064af07so5560279a12.0;
        Sun, 23 Feb 2025 17:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740360693; x=1740965493; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4GvaqVIL/hNKQlnj0DT9cN3mMKxJVdcE+NJpBmVvb8=;
        b=X1MVpz5IvdD3JyFjiq4k8Hu200l0vQa4R+b0ABs4h5WENUUMfHqKE3vlx0CzVBsOWV
         JC7W2rYixVUsN+fvoOuF21txuLgtp4Ee4RvvInsfSU5qNwtmsS5NGre9ZTS07p3Y+s7H
         5gHQbXOgOVSa3FSi9vV1vMDYapabjWiMNFMy0pzI7tnoA87AKrM3Iw/SPbYKc0bfgbIS
         dETxff06ggJENSp+l5173qwTEWIcNRFGK8TTOMJ+z6f44cqNecYjrOC+M/iiI3MFB3l8
         VY1EuCG9uLuCQ9aPSOEdfdkm7WJtInG86BAWN4PZgdU5HsQ2LgaWhHC1LD1ePjt2ExBi
         UI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740360693; x=1740965493;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A4GvaqVIL/hNKQlnj0DT9cN3mMKxJVdcE+NJpBmVvb8=;
        b=kmEgXlbe3g39zLTebS/uNUvlrYtXR8gubXwbibI+gazilsYUMHBaYtkIR22NP3qaRT
         jGRaDOExGi1XEfTnUstpn2cTwnGOPRIcWcJok44aTQqD0+YaNsNwXw6Yz3dLivWkLWNQ
         7j/8JxquOauGK5sZF+bG3pfngo4H/mLEMBzWD0sknafP7I3OXksZoVuwLSMj5CAoBTCS
         3lFIcZ+0Tk8auqHCtCjr5W7c8v4AzmeE3xaBcZTeoCnTWxnVzgLU9kXga9iudyeAno03
         wFFftqVoisNiu71UQrhSBLA8WO5UiepDvy1EUviZ2oMktaxZ3Kb6Up0wZgwdBaH/7NBs
         hYsg==
X-Forwarded-Encrypted: i=1; AJvYcCVE2KqNUQidrbuWklOFttPc+CQG4gyeNdRdiCYR3flqHBsYF5sjQVXbcCx9GB7VomRLVMlXlN0K5GCFhaGX6UeIkg==@lists.infradead.org, AJvYcCX1Gl+X79E0Ati6nW10sWl8UCHDcGRsdCQ0svke/x3Z8eROx4/b8N2FazwxPkI2HI/hhwKzCg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy0vBsDDnfKKNbGZBFigjvwb2dBkpzZ1IxtfBcqXfbGqrB1aW3y
	HmhnNzBAFcrBhqRwn4Tawh6a93D3KSHTphZiSxusetZ24TKSTMU2
X-Gm-Gg: ASbGncuWsbOr8JQLEJAfDriRcgQ7c9cL9KkJ3tNhNuwpHsduj7NmIzwFYfKoGuOaE20
	CVfRB47ocTlvp49umfkZ7WX99/5z5wLetfKM9zjPXDGdJD9BXFBqM5NIIfJwquIznxMobAhjNSa
	XwXjF9hAWdx/CBJBc7Ti8LQKD+1i+WgWRx7dstpWHnXE+oPXXO2w+tKfAinK4jn+MTDXlztS0ic
	hX/19so4gBb0M1s1HgN9RbXloDmRVtfVEUJUPO3d0UlmFEPi0T8xlEN5cxfHmh4y0M3XhEU4c80
	TTI1BakL3ziMRZFCXGg6fA6oSg==
X-Google-Smtp-Source: AGHT+IHSNuXjvZ6j34bY7irzKgYOPZ2Pc9eRXhFT7vf6gvwUpLsnEqOodUyWWZF1htL/xJzW8ObUNw==
X-Received: by 2002:a05:6402:4313:b0:5de:4b81:d3fd with SMTP id 4fb4d7f45d1cf-5e0b70fa0efmr10728444a12.13.1740360692719;
        Sun, 23 Feb 2025 17:31:32 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1c43a0sm17589157a12.28.2025.02.23.17.31.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2025 17:31:31 -0800 (PST)
Date: Mon, 24 Feb 2025 01:31:31 +0000
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
Message-ID: <20250224013131.fzz552bn7fs64umq@master>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-3-rppt@kernel.org>
 <20250218155004.n53fcuj2lrl5rxll@master>
 <Z7WHL_Xqgoln9oLg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7WHL_Xqgoln9oLg@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250223_173135_314234_AA2E936A 
X-CRM114-Status: GOOD (  28.08  )
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

On Wed, Feb 19, 2025 at 09:24:31AM +0200, Mike Rapoport wrote:
>Hi,
>
>On Tue, Feb 18, 2025 at 03:50:04PM +0000, Wei Yang wrote:
>> On Thu, Feb 06, 2025 at 03:27:42PM +0200, Mike Rapoport wrote:
>> >From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>> >
>> >to denote areas that were reserved for kernel use either directly with
>> >memblock_reserve_kern() or via memblock allocations.
>> >
>> >Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> >---
>> > include/linux/memblock.h | 16 +++++++++++++++-
>> > mm/memblock.c            | 32 ++++++++++++++++++++++++--------
>> > 2 files changed, 39 insertions(+), 9 deletions(-)
>> >
>> >diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> >index e79eb6ac516f..65e274550f5d 100644
>> >--- a/include/linux/memblock.h
>> >+++ b/include/linux/memblock.h
>> >@@ -50,6 +50,7 @@ enum memblock_flags {
>> > 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
>> > 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
>> > 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
>> >+	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
>> 
>> Above memblock_flags, there are comments on explaining those flags.
>> 
>> Seems we miss it for MEMBLOCK_RSRV_KERN.
>
>Right, thanks!
> 
>> > 
>> > #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
>> >@@ -1459,14 +1460,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>> > again:
>> > 	found = memblock_find_in_range_node(size, align, start, end, nid,
>> > 					    flags);
>> >-	if (found && !memblock_reserve(found, size))
>> >+	if (found && !__memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN))
>> 
>> Maybe we could use memblock_reserve_kern() directly. If my understanding is
>> correct, the reserved region's nid is not used.
>
>We use nid of reserved regions in reserve_bootmem_region() (commit
>61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")) but KHO needs to
>know the distribution of reserved memory among the nodes before
>memmap_init_reserved_pages().
> 
>> BTW, one question here. How we handle concurrent memblock allocation? If two
>> threads find the same available range and do the reservation, it seems to be a
>> problem to me. Or I missed something?
>
>memblock allocations end before smp_init(), there is no possible concurrency.
> 

Thanks, I still have one question here.

Below is a simplified call flow.

    mm_core_init()
        mem_init()
            memblock_free_all()
                free_low_memory_core_early()
                    memmap_init_reserved_pages()
                        memblock_set_node(..., memblock.reserved, )   --- (1)
                    __free_memory_core()
        kmem_cache_init()
            slab_state = UP;                                          --- (2)

And memblock_allloc_range_nid() is not supposed to be called after
slab_is_available(). Even someone do dose it, it will get memory from slab
instead of reserve region in memblock.

From the above call flow and background, there are three cases when
memblock_alloc_range_nid() would be called:

  * If it is called before (1), memblock.reserved's nid would be adjusted correctly.
  * If it is called after (2), we don't touch memblock.reserved.
  * If it happens between (1) and (2), it looks would break the consistency of
    nid information in memblock.reserved. Because when we use
    memblock_reserve_kern(), NUMA_NO_NODE would be stored in region.

So my question is if the third case happens, would it introduce a bug? If it
won't happen, seems we don't need to specify the nid here?

-- 
Wei Yang
Help you, Help me

