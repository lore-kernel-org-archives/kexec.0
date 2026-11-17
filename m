Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92BC606A33D
	for <kexec@archiver.kernel.org>; Tue, 17 Nov 2026 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RaH+QEwx;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=wcMqPt0Q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=NelY0F3SQaoHpZaa48RfVKojhT0mMWhbxVhRpg0tfCU=; b=RaH+QEwxfBm+xl
	I+bA+LXbMtjpe421VG/QRF/SsD2cG2HqpVfJDWRm3gz7Enyc4UPhWXcsiUgiJnNR5+kXmlTbDpw1q
	ywB64jvbZtl39GddvKg/4PI34Bvo1MVu47X22GI/JMUsWBKlD8qAhA98zsLdtBjlQXWuUUEVe4eMd
	z81gLryPJ1A3RDpkq8UunLmJ1y7F9e+brb0Dpq3NvPg8fg2/EvThmiTQwqeoKbPKDk6YGGXxec5k5
	k6pUFiZW3mLiidMRsQC3fY9ZB3xrw13RBuymc0AeT6cdcky+ljWcEXYhCsNQjQbTSp0uBelnAm/Va
	iJtgCta8tr+D+azCCPjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTFNg-000000053de-2Ysm;
	Tue, 17 Nov 2026 09:21:36 +0000
Received: from canpmsgout05.his.huawei.com ([113.46.200.220])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTFNd-000000053ZP-1TNh;
	Tue, 17 Nov 2026 09:21:36 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NelY0F3SQaoHpZaa48RfVKojhT0mMWhbxVhRpg0tfCU=;
	b=wcMqPt0QhszyRzva4g7wZmx964J1LB82GE/yeVL9LyN+DZ3q7eziWeveRgCFaAaPBdYeCBQiX
	9FaWQ1vHk5u3RT5eFgJLnfpdsyXTk+FiUTHQg8fFnGbdIKoRqYmksHh6O0iFhakPsKKPB35Ps5S
	cmyonBF0d5EmEbjEKCpSmik=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jTK2j3ctZz12LD4;
	Tue, 17 Nov 2026 17:20:29 +0800 (CST)
Received: from whupemk100004.china.huawei.com (unknown [7.152.185.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 503DB203AB;
	Tue, 17 Nov 2026 17:21:22 +0800 (CST)
Received: from [10.173.125.21] (10.173.125.21) by
 whupemk100004.china.huawei.com (7.152.185.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 17 Nov 2026 17:21:18 +0800
Subject: Re: [PATCH v6 3/7] mm/memory-failure: add hwpoison_boot_page() to
 flag an inherited frame
To: Breno Leitao <leitao@debian.org>
CC: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-cxl@vger.kernel.org>,
	<driver-core@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<rmikey@meta.com>, <riel@surriel.com>, <harry@kernel.org>,
	<kernel-team@meta.com>, Ard Biesheuvel <ardb@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
	<liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
	<rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
	<mhocko@suse.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, Oscar Salvador
	<osalvador@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, <kas@kernel.org>,
	<kexec@lists.infradead.org>, Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	<shakeel.butt@linux.dev>
References: <20261016-hwpoison-kho-v6-0-f304255147da@debian.org>
 <20261016-hwpoison-kho-v6-3-f304255147da@debian.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <869891e5-3f4f-e404-1068-53e6ff169805@huawei.com>
Date: Tue, 17 Nov 2026 17:21:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261016-hwpoison-kho-v6-3-f304255147da@debian.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemk100004.china.huawei.com (7.152.185.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_012134_040238_2B00376C 
X-CRM114-Status: GOOD (  25.65  )
X-Spam-Score: -3.8 (---)
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/10/16 20:15, Breno Leitao wrote:
> A kernel that kexecs inherits the frames its predecessor found
> hardware-poisoned. It has to carry them as PG_hwpoison in its own memmap,
> so that everything that already understands the flag covers them,
> including the kexec segment placement check.
> 
> Add a helper that sets the flag and counts the frame in
> num_poisoned_pages. It runs while the memmap is initialised, before
> memory_dev_init() has run. memblk_nr_poison_inc() divides by
> sections_per_block, which memory_dev_init() sets, so the helper
> increments num_poisoned_pages itself instead of calling
> num_poisoned_pages_inc().
> 
> An inherited frame is a hardware failure like any other, so the helper
> sets hw_memory_failure. Without it, unpoison_memory() accepts the frame,
> clears the flag and drops the last reference, which frees a frame that
> is still bad.
> 
> The helper also counts the frame as managed, as a frame that fails at
> run time stays counted. Memory offlining subtracts every frame of the
> block that is not PageOffline, so a frame that was never counted leaves
> the managed page count too low after an offline.
> 
> The per-node memory failure statistics are not updated. This kernel
> handled no failure, it only inherited one.
> 

Thanks for your patches. :) Some questions below.

> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  mm/internal.h       | 5 +++++
>  mm/memory-failure.c | 8 ++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index da14c56fb24e11..4bd3bbce86e0ad 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1169,6 +1169,7 @@ void SetPageHWPoisonTakenOff(struct page *page);
>  void ClearPageHWPoisonTakenOff(struct page *page);
>  bool take_page_off_buddy(struct page *page);
>  bool put_page_back_buddy(struct page *page);
> +void __init hwpoison_boot_page(struct page *page);
>  struct task_struct *task_early_kill(struct task_struct *tsk, int force_early);
>  void add_to_kill_ksm(struct task_struct *tsk, const struct page *p,
>  		     struct vm_area_struct *vma, struct list_head *to_kill,
> @@ -1181,6 +1182,10 @@ static inline int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, b
>  {
>  	return -EBUSY;
>  }
> +
> +static inline void hwpoison_boot_page(struct page *page)
> +{
> +}
>  #endif
>  
>  extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index a2ca8df501caee..d0d6b184ee469f 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -96,6 +96,14 @@ void num_poisoned_pages_sub(unsigned long pfn, long i)
>  		memblk_nr_poison_sub(pfn, i);
>  }
>  
> +void __init hwpoison_boot_page(struct page *page)

Should we add some debug aids to let users know the origin of these hwpoisoned pages?

> +{
> +	SetPageHWPoison(page);

Should we try to hold an extra page refcnt, as memory_failure does?

> +	atomic_long_inc(&num_poisoned_pages);
> +	hw_memory_failure = true;
> +	adjust_managed_page_count(page, 1);

Is what adjust_managed_page_count does inconsistent with what the hwpoison_boot_page
function describes? Should it be factored out?
Also, is adjust_managed_page_count time-consuming? Should we consider batching the calls
to reduce the impact on system boot latency? Maybe I'm overthinking it...

Thanks.
.


