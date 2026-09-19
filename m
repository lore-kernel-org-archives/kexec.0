Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C473C982D7
	for <kexec@archiver.kernel.org>; Sat, 19 Sep 2026 10:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+T4o7Z4sldFW89gg456PmAN7vw155d0OxgwruAX/bjg=; b=OqK+T5mN0VK+vVqBhM3+CPkPMb
	gLLWZ47GVE6TCDewgxpQ4aJgSLgwR+W7LcFj7FDbphMPTmDOldsh7Uia8KLTyUHkvB3tz1oVBpHNo
	zhlSRXQUWFHzqT1UrcrELHGC1iE/g63i4/9FdLXm8lpdlQBa1aCN+ItfMfOfEu5DrIHpCD7R3j+93
	sGSUxiu0eCyazj37kuU8Wjbg5mVp+IoB0dgbts2U2e78lD7Kz/P6fxw4KhrkEs2BaV7u3FtroBMMa
	jT6ZwXWb8n1EaXzVhWwa/GPPVZHyW4KKODJnZmoELZzjT8+rfgN2zXN0SjYjshT9Qy1dpkHv5hGvw
	cxQn7rNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7sJ4-0000000GAgo-2sO1;
	Sat, 19 Sep 2026 10:28:30 +0000
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7sJ2-0000000GAdr-1hyT
	for kexec@lists.infradead.org;
	Sat, 19 Sep 2026 10:28:29 +0000
Received: by mail-pj2-x10.google.com with SMTP id 98e67ed59e1d1-396ccc02279so1273793a91.1
        for <kexec@lists.infradead.org>; Sat, 19 Sep 2026 03:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789813707; x=1790418507; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+T4o7Z4sldFW89gg456PmAN7vw155d0OxgwruAX/bjg=;
        b=DHZHc1WhPB8NuvZh36MDHEEexfNrU0kv8NZ5Qg77ZGNWmN5zNEUrdF+kps7O91IhBY
         bzMaqPrSsDUWdFL2fm4Kb2xbveOfR1KuUjAjoZTMJxlME52kiox1VpnMWhZuKQEocpfj
         oahD5zPEn/anQwOaxeETU7ycXfF6qlxig9+Zqp2hd5ioDtoopSVTPP/+FOk5PnzNvd66
         3Dx9JS05oWVjsd1cxzhz5Rz1Z+0ar2FwnGIizxbkiux1+DxsnABqCCI+bm3a4k6wsMgR
         ry101QcPcaeP4LFdXMAwysuCNenVdGvMIYDB3B5WaKa3gBRcp3gmwEqUDrUEABqYLscq
         ygGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789813707; x=1790418507;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+T4o7Z4sldFW89gg456PmAN7vw155d0OxgwruAX/bjg=;
        b=MUrJv4c1tTzzcrFURQOQly5lIdIpwN6jsf69DfTLT4ZVS2h83/PO2dNzgiYbQpCOMn
         wn74Hf25RTALi8QO1RxvfV/3GVrzfYh/UtyDEkvSyWcUFpMMuxMXY4JfS3Q0h4wSuCyY
         NgYfn6eKxOYBVJBilpgLCmUo7wTSRHXAGLEuCupEzQXklUqfRJk4rFiNv6T5PbOHQ/pw
         dVCxMpgv4jmMVGkEa27Nt797t8IZC7/81sbgYdkKvuB117m4Hny7Iih5r896VxTPdSVa
         bQYGKo+jLlitsDayIfbPLvHDjfieConZ8IeNqVJKkAXsJKInonaCZCveiVCD6lpZSK2U
         LZLA==
X-Forwarded-Encrypted: i=1; AKwUvBwVWTfExi11zuNGs835wzRnrFS55MDQFDWW9QZx2vutcMxkyy8Onkjy962hNkBZk+KGr4I4nQ==@lists.infradead.org
X-Gm-Message-State: AFuF++lQAQekuzFF/YbzCcJWF3mWmCeeQuhxQQGMXsIkm+xOQ+32wyIQ
	MNc+F977nwoz4wyLVPhLT8Baf6BDljw1LeCyxCLzf/WpCcRiwS5nU3NO
X-Gm-Gg: AYBFou1iFLQRd6u+WWfXluVvVyS/NwBWTkaY5gLf7XmHIAT1DdwpFKXPeugtKSJzlW7
	koZhsKVlP4lznA6fHmEv6pT8N4cYCetdJmEAqw3vXHxx4fgQ2bzkJD7WHpeMfdDbVEWtZTHA9kK
	fyDpmAel2DJdAOd9RQaBps32u3JWx5mYeYL6SFZC6mB3yS/w+omcxCXSBye1FhGiLx771tOyBx5
	ZuipOTaLNHg358S51HpunvdiB9JwtngspAulMplzvn7MjlfUoX34JbarvYjddvkc2EiutHI9Aq8
	ezUT81X7okf5WjG6g5ad8q6C0qB4iTBteT5vOZTim4+Ia4RZ5Fme7uI/x6/fQdPNz6IG2jYRwOS
	72cfDmQAM2fTujhPVCC/6FKn7KUVA8T4YKvsuY3FL3jTMJ3+pZythje9VLRj2OwDXgrQLn2mKH6
	eBuqLVII/CTQhD9xpV5gDHgRIQv3YqS2rWNTlOe3Ope3ywtLxGeS9hmdxE1+vTAd5jjrr9m53ga
	fG0KeK/W6Y=
X-Received: by 2002:a17:90b:184d:b0:39e:6a7f:1dcc with SMTP id 98e67ed59e1d1-39e6a7f222amr3389602a91.40.1789813707258;
        Sat, 19 Sep 2026 03:28:27 -0700 (PDT)
Received: from localhost ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c615f05sm4060068a91.15.2026.09.19.03.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 03:28:26 -0700 (PDT)
Date: Sat, 19 Sep 2026 15:58:25 +0530
From: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, kas@kernel.org,
	kexec@lists.infradead.org, David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, hannes@cmpxchg.or,
	shakeel.butt@linux.dev, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, rmikey@meta.com,
	riel@surriel.com, harry@kernel.org, linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v5 8/9] mm/memory-failure: add hwpoison_boot_page() to
 flag an inherited frame
Message-ID: <aq5jyXzuDAANeCJs@acer-nitro-anv15-41>
References: <20260915-hwpoison-kho-v5-0-3bc7a57bd503@debian.org>
 <20260915-hwpoison-kho-v5-8-3bc7a57bd503@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260915-hwpoison-kho-v5-8-3bc7a57bd503@debian.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260919_032828_454165_E67713B8 
X-CRM114-Status: GOOD (  26.12  )
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

On Tue, Sep 15, 2026 at 05:53:42AM -0700, Breno Leitao wrote:
> A frame the previous kernel recorded as poisoned has to be flagged before
> it reaches the allocator, which is long before memory_failure() can run.
> Add a helper that leaves it in the state a frame poisoned by this kernel
> would be in, so everything that already understands PG_hwpoison covers it,
> the kexec segment placement check included.
> 
> num_poisoned_pages_inc() does not work at boot: its per memory block half
> looks the block up by pfn, and memory_dev_init() has not run, so it
> divides by zero. Take only the global counter there. A hotplugged block is
> already there, so that path takes both counters as usual.
> 
> The caller comes later in this series.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/linux/mm.h  |  7 +++++++
>  mm/memory-failure.c | 26 ++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b68824fcfbef19..8039830998dd4b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -5225,6 +5225,8 @@ extern const struct attribute_group memory_failure_attr_group;
>  extern void memory_failure_queue(unsigned long pfn, int flags);
>  void num_poisoned_pages_inc(unsigned long pfn);
>  void num_poisoned_pages_sub(unsigned long pfn, long i);
> +void __meminit hwpoison_boot_page(struct page *page,
> +				  enum meminit_context context);
>  phys_addr_t range_first_hwpoison(phys_addr_t start, unsigned long size);
>  phys_addr_t range_last_hwpoison(phys_addr_t start, unsigned long size);
>  #else
> @@ -5232,6 +5234,11 @@ static inline void memory_failure_queue(unsigned long pfn, int flags)
>  {
>  }
>  
> +static inline void hwpoison_boot_page(struct page *page,
> +				      enum meminit_context context)
> +{
> +}
> +
>  static inline void num_poisoned_pages_inc(unsigned long pfn)
>  {
>  }
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index d9b8be696aac38..60e9682434700b 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -137,6 +137,32 @@ phys_addr_t range_last_hwpoison(phys_addr_t start, unsigned long size)
>  	return range_hwpoison(start, size, false);
>  }
>  
> +static void update_per_node_mf_stats(unsigned long pfn, enum mf_result result);
> +
> +void __meminit hwpoison_boot_page(struct page *page,
> +				  enum meminit_context context)
> +{
> +	unsigned long pfn = page_to_pfn(page);
> +
> +	if (PageHWPoison(page))
> +		return;
> +
> +	SetPageHWPoison(page);
> +	set_page_count(page, 1);
> +	/* The page has been completely isolated == MF_RECOVERED */
> +	update_per_node_mf_stats(pfn, MF_RECOVERED);


snip

> +
> +	/*
> +	 * The per memory block half of num_poisoned_pages_inc() has no block to
> +	 * find at boot, and divides by zero looking for one. A hotplugged block
> +	 * is already there.
> +	 */
> +	if (context == MEMINIT_HOTPLUG)
> +		num_poisoned_pages_inc(pfn);
> +	else
> +		atomic_long_inc(&num_poisoned_pages);
> +}

Hi Breno,

num_poisoned_pages_inc() currently assumes that the supplied PFN can
be used for per-memory-block accounting and therefore calls
memblk_nr_poison_inc() unconditionally. The early-boot path needs
global-only accounting because the memory-block infrastructure is not
initialized yet.

Could num_poisoned_pages_inc() treat -1UL as global-only accounting,
matching num_poisoned_pages_sub()?

Example as below:

void num_poisoned_pages_inc(unsigned long pfn)
{
	atomic_long_inc(&num_poisoned_pages);

	if (pfn != -1UL)
		memblk_nr_poison_inc(pfn);
}


The caller could then use:

num_poisoned_pages_inc(context == MEMINIT_HOTPLUG ? pfn : -1UL);

This would keep updates to `num_poisoned_pages` encapsulated rather than
manipulating the counter directly here, while also making the increment
and decrement interfaces consistent.

Thanks,
Shaikh Kamaluddin.
> +
>  /**
>   * MF_ATTR_RO - Create sysfs entry for each memory failure statistics.
>   * @_name: name of the file in the per NUMA sysfs directory.
> 
> -- 
> 2.53.0-Meta
> 

