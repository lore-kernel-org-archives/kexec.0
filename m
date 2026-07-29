Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A7BC54F51
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 09:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l28RUUIO0sTYXTUgslp8RhU5Xau1YXhJe+DpH+cC4Js=; b=C6OUEnlWSQeeRtYKcVzlaNO1Yz
	IgFHAKHMUXgIne9qNtYiAT60jKDP+3xpLY8MIoTvcw6/TZfe4bX6WxddDpLERAU++aQngtV/bKQ1f
	pTnbly1ubCBk7vSGJbaGyjqD92bq+MyHpUPSMtow2m0JbA1m5zXTJQHlioCmmjaS5Ih/e47QyvAOs
	TbRUEF4uYLqs2y2mEqVpTBUssuP7lC+x4TfzO3pKuPlWBIzdJ8rokDZQ97POVF+xwEDNEMmLVrkOH
	wyN3TEkouw1Orx5xxZP4QPM3EglykQ2nCyGqWCdNRyGvjUcgV2CZSHB0NbByP6kJ4htKmdS6z4LFw
	rgSEct7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp0fO-00000007Nqq-11CQ;
	Wed, 29 Jul 2026 09:33:34 +0000
Received: from canpmsgout07.his.huawei.com ([113.46.200.222])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp0fK-00000007NpL-1Ybo
	for kexec@lists.infradead.org;
	Wed, 29 Jul 2026 09:33:33 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=l28RUUIO0sTYXTUgslp8RhU5Xau1YXhJe+DpH+cC4Js=;
	b=0cbv10gEwX5uu9GIcx/ZyCSFDsAMaWqXcnMDdrzJ6IyLWtJojWvfk8o1RVjTRNKzAwe3xAGcb
	HchCKLYBh9BmJo2N85ZSseW5l5z3Y/n/vzf3322ZrFh4b+N/3rS65VcHVJTLTWLty1vMUH84yjK
	1I7foOTOqYlmbZv6hROzRnE=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4h96Mr4BNtzLlXX;
	Wed, 29 Jul 2026 17:23:52 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 9365B40572;
	Wed, 29 Jul 2026 17:33:19 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 29 Jul 2026 17:33:19 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 29 Jul 2026 17:33:18 +0800
Subject: Re: [PATCH] kexec: keep the next kernel off hardware-poisoned pages
To: Breno Leitao <leitao@debian.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>, <rmikey@meta.com>, <riel@surriel.com>,
	<kernel-team@meta.com>, Kiryl Shutsemau <kas@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Vlastimil
 Babka" <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Baoquan He
	<baoquan.he@linux.dev>, Pasha Tatashin <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>
References: <20260728-kexec_posioned-v1-1-160c81d180fe@debian.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <16c18549-c9a1-ba55-91b8-52d9368ebbc0@huawei.com>
Date: Wed, 29 Jul 2026 17:33:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20260728-kexec_posioned-v1-1-160c81d180fe@debian.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.124.160]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq500010.china.huawei.com (7.202.194.235)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_023331_036210_B31E3602 
X-CRM114-Status: GOOD (  29.85  )
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

On 2026/7/29 0:22, Breno Leitao wrote:
> Memory failures (such as unrecoverable ECCs errors) are getting more and
> more common. The kernel knows how to handle it while running, marking it
> as poisoned (and SIGBUS user tasks).
> 
> Poisoned memory is removed from the buddy allocator, but, not from
> other places. A current problem is that kexec will load new kernel
> on top of a bad/poisoned memory, which is undesirable.
> 
> If the next kernel's image, initrd or purgatory lands on poisoned frame,
> the relocation copy writes to the bad memory and the machine checks
> during the kexec.
> 
> Skip hardware-poisoned frames when placing segments: check them in the
> kexec_file hole finder so it lays the next kernel down on good memory,
> and reject a poisoned destination in sanity_check_segment_list() for
> the kexec_load path, which cannot relocate.
> 
> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/linux/mm.h  |  6 ++++++
>  kernel/kexec_core.c | 10 ++++++++++
>  kernel/kexec_file.c | 14 ++++++++++++++
>  mm/memory-failure.c | 18 ++++++++++++++++++
>  4 files changed, 48 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7fabe6c66b4b7..a89108bcc3f90 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -5192,6 +5192,7 @@ extern const struct attribute_group memory_failure_attr_group;
>  extern void memory_failure_queue(unsigned long pfn, int flags);
>  void num_poisoned_pages_inc(unsigned long pfn);
>  void num_poisoned_pages_sub(unsigned long pfn, long i);
> +bool range_contains_hwpoison(phys_addr_t start, unsigned long size);
>  #else
>  static inline void memory_failure_queue(unsigned long pfn, int flags)
>  {
> @@ -5204,6 +5205,11 @@ static inline void num_poisoned_pages_inc(unsigned long pfn)
>  static inline void num_poisoned_pages_sub(unsigned long pfn, long i)
>  {
>  }
> +
> +static inline bool range_contains_hwpoison(phys_addr_t start, unsigned long size)
> +{
> +	return false;
> +}
>  #endif
>  
>  #if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_MEMORY_HOTPLUG)
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index dc770b9a6d053..18793f925835f 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -212,6 +212,16 @@ int sanity_check_segment_list(struct kimage *image)
>  	}
>  #endif
>  
> +	/*
> +	 * Reject destinations that land on hardware-poisoned memory: the
> +	 * relocation copy would machine-check on the bad frame.
> +	 */
> +	for (i = 0; i < nr_segments; i++) {
> +		if (range_contains_hwpoison(image->segment[i].mem,
> +					    image->segment[i].memsz))
> +			return -EADDRNOTAVAIL;
> +	}
> +
>  	/*
>  	 * The destination addresses are searched from system RAM rather than
>  	 * being allocated from the buddy allocator, so they are not guaranteed
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 59fb9d71e9d86..cd77350f12f85 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -504,6 +504,13 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
>  			continue;
>  		}
>  
> +		/* Avoid placing the next kernel on hardware-poisoned memory */
> +		if (range_contains_hwpoison(temp_start,
> +					    temp_end - temp_start + 1)) {
> +			temp_start = temp_start - PAGE_SIZE;
> +			continue;
> +		}
> +
>  		/* We found a suitable memory range */
>  		break;
>  	} while (1);
> @@ -546,6 +553,13 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
>  			continue;
>  		}
>  
> +		/* Avoid placing the next kernel on hardware-poisoned memory */
> +		if (range_contains_hwpoison(temp_start,
> +					    temp_end - temp_start + 1)) {
> +			temp_start = temp_start + PAGE_SIZE;
> +			continue;
> +		}
> +
>  		/* We found a suitable memory range */
>  		break;
>  	} while (1);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index a8b03e2920ba8..032bb23db7566 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -96,6 +96,24 @@ void num_poisoned_pages_sub(unsigned long pfn, long i)
>  		memblk_nr_poison_sub(pfn, i);
>  }
>  
> +/*
> + * Check if any page in [start, start + size) has hardware-poisoned segments
> + */
> +bool range_contains_hwpoison(phys_addr_t start, unsigned long size)
> +{
> +	unsigned long pfn, end_pfn;
> +
> +	if (!size || !atomic_long_read(&num_poisoned_pages))
> +		return false;
> +
> +	end_pfn = PHYS_PFN(start + size - 1);
> +	for (pfn = PHYS_PFN(start); pfn <= end_pfn; pfn++) {
> +		if (pfn_valid(pfn) && PageHWPoison(pfn_to_page(pfn)))

Should we use pfn_to_online_page here? I doubt we might meet the same problem
in [1] if pfn_to_page is used here.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=d613f53c83ec47089c4e25859d5e8e0359f6f8da

Thanks.
.



