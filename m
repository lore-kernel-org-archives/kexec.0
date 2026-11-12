Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F898606A323
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Pne9+OwG;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KmKFLwam
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=1b6A2kvQgpqKkzxc5p2W/1olpXK4SEEz0O9LviTyyRY=; b=Pne9+OwG4Pw2Xb
	j1LW4lYwcB1KqN+QjS2OX1J7/6ShkjjT+eO3x9LyTjuamaFxOXjpzjZt0Z3/ubSHhi1p7lfsBzThV
	MJKEqi/xNpW5vnu75eDWdABBzU7ohydDFQbuuRHwtypDbve0t29Y+vTRtVyweqMfQMr5pvC4/d8cx
	q9t2pvzQMxLk3mkxb0FOouXzI0j/SWv2Ffx1VF+3dd8GgI6qv/+FQAfx8WcBNj3bmBQlbmsg8P0yw
	1H/8oHH3Ks2Np2k8HDjfvKnCbuM6NsGQLfSti2L5aV5jQWtQ+P2X0Ja78QKYaEWFEQl+KDBPHnula
	Ii+sZZ8u7KKbJqOempsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRP8H-00000008ugo-169T;
	Thu, 12 Nov 2026 07:22:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRP83-00000008ueA-2JRI
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 07:21:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794468110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1b6A2kvQgpqKkzxc5p2W/1olpXK4SEEz0O9LviTyyRY=;
	b=KmKFLwamsFcabz30kspuI1sgxCuBodO+FdRuTn2P5ordb4h9H+T1cdZbD5SKhywzoub53J
	cS6Ee3jbQQNYwk1WsmbiIO7ug+Ekhq4pXecYs5egyZWgnmdqH112BoRfzvdjCZM2Ns8hHF
	b9RSxrDJoT+7Gh+4EzKfuHbHZqS2a+A=
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com
 [74.125.82.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-jKSM_4mOPGq3wHlHWigR8Q-1; Thu, 12 Nov 2026 02:21:49 -0500
X-MC-Unique: jKSM_4mOPGq3wHlHWigR8Q-1
X-Mimecast-MFC-AGG-ID: jKSM_4mOPGq3wHlHWigR8Q_1794468108
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-139b62317d0so256879c88.0
        for <kexec@lists.infradead.org>; Wed, 11 Nov 2026 23:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794468108; x=1795072908;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1b6A2kvQgpqKkzxc5p2W/1olpXK4SEEz0O9LviTyyRY=;
        b=mXwCI1+kdUPaLiT00hGSVkQiU/7u4nN2IiQ01sbcnQT7KFm2EO9g/cQfTqo5Ka5dtd
         YA3coyB3YJLDBX475rHu+kY3xyXZbZVmvC0ekQAlSNJudpjPYLvNaE7XAUbvC6eujSl6
         w0i4iesQ60s/nyCzHi6zJbuPnKsh2rIJhnJ7lrADXppVKD3FAfQ2WdMiqkFEVqvKbk7O
         pvPcmUEDqewy+6WzuDdP621arZtOyqIemwYATHg34KdaCt0OUm5AHeblSWtgCTr0hWU6
         YTnoA8cLMLdtof84ZHcaycGXV2xoUNYbPy+yvY63a1mIK4Qbq1m/I5TCvOrd/1mraVWl
         R+Rw==
X-Forwarded-Encrypted: i=1; AL+hErGdlrM35tO5/QJ3u9v4dGdBv5xxCpeLNKsS2ZmvMeW/j/Uj6UGT+zwQsHTtxS+mKGSm29+gFg==@lists.infradead.org
X-Gm-Message-State: APuU4Z8Cmxo5Mt3BxHHBZlb41mfo5pxSWjKLFKCLfrnExTPJpWJLMTkZ
	wMpSbMpMXIiQSuWpmEq+gZ8VUlK/4hirbX4UzQl+GJZM+BRfugJLjM8eQhd1zI5R9GA+eiCX2u1
	UF05GKzuMgsYtAI1XeF0g/osoJlAbbFz5D6rFeZhm3Z+K8Sd8hXZmK7a4SnFRsA==
X-Gm-Gg: AYBFou0LjzROltXjUyAY7t5QfeVa26zeVWSjY6KC2T0XHjgxqd7ATst8URghhn+Kguw
	XtBZJ8BHHwOEfj7eHdxjelPh1tuyuAhJNvcAotYHOjOAc7+2bbZX64Mcyd/9vCpu20lHF5KJvNG
	8GEucLBBLIr8W8xEqswjIM8buqgAYKFhX+13XC53xbFxQfldOXLNF7hMJ20ywFF8J+a8uXf1N+I
	/HYLamIqxHjOgTTWipVr9APc6ooHX18VFAyuGd/R7PSjygYpu2M8ahP5k4rIhvmX8sxHawDl1i0
	ff8IqEqc2MDcde5GT5BPZjyyY6xgimbIAJ9cSPO3lIZUM03dL+S3O3391+Fr0k3VliuQKJnmGKe
	amOqa4mRXqiV1JzPufHQ52nWQz2pVuiCV7QPPmnP+z+vpgFaFd0TkqTSold75H+NN0X9kH0E=
X-Received: by 2002:a05:7022:170a:b0:1b3:b3de:9232 with SMTP id a92af1059eb24-1b3c02f06bdmr4131960c88.9.1794468107344;
        Wed, 11 Nov 2026 23:21:47 -0800 (PST)
X-Received: by 2002:a05:7022:170a:b0:1b3:b3de:9232 with SMTP id a92af1059eb24-1b3c02f06bdmr4131931c88.9.1794468106682;
        Wed, 11 Nov 2026 23:21:46 -0800 (PST)
Received: from [192.168.1.102] ([117.207.221.165])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2eeffsm22991575c88.9.2026.11.11.23.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 23:21:46 -0800 (PST)
Message-ID: <6c57f062-345d-4bb4-9af9-213ef2912d76@redhat.com>
Date: Thu, 12 Nov 2026 12:51:38 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] kho: fix bootmem sizing
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Chen Pei <cp0613@linux.alibaba.com>, George Guo <guodongtai@kylinos.cn>,
 Kexin Liu <liukexin@kylinos.cn>, Sourabh Jain <sourabhjain@linux.ibm.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20261104-kho-bootmem-sizing-v2-0-b0d1a834780f@kernel.org>
 <20261104-kho-bootmem-sizing-v2-3-b0d1a834780f@kernel.org>
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <20261104-kho-bootmem-sizing-v2-3-b0d1a834780f@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D6QU9paKyVVcb-ImgTarQXX2sT3e5iH4MQGtImwxf-0_1794468108
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_232152_197413_AFA0D2C2 
X-CRM114-Status: GOOD (  34.30  )
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

On 04/11/26 10:20 pm, Mike Rapoport (Microsoft) wrote:
> Bootmem areas are sized from overlapping views of the memory reserved in
> memblock:
> 
> * the global area is sized from all reserved memory, including memory
>   allocated on specific nodes, so on NUMA systems everything allocated
>   on a node is accounted in both the global area and the area of that
>   node.
> * per-node sizes are calculated after the lowmem and the global areas
>   are reserved. With CONFIG_NUMA=n all memblock regions belong to node 0,
>   so the lowmem and the global areas are accounted in the size of node 0
>   area and scaled once again.
> 
> As a result, bootmem is about twice bigger than it should be on NUMA
> systems and about four times bigger with CONFIG_NUMA=n. On small systems
> reservation of the bootmem may fail and then KHO gets disabled.
> 
> Make the areas cover separate parts of the reserved memory: the lowmem
> area covers allocations below ARCH_LOW_ADDRESS_LIMIT, per-node areas
> cover allocations above it on each node and the global area covers
> allocations that are not bound to any node. Calculate all sizes before
> reserving any of the areas.
> 
> With CONFIG_NUMA=n the global area becomes empty and it is not reserved.
> 
> If ARCH_LOW_ADDRESS_LIMIT covers all memory, as may happen on arm64, any
> area can serve lowmem allocations, so don't reserve the lowmem area.
The documentation still describes the old layout says __there is always
a boot memory region per node plus one for node-less allocations__,
which stops being true as soon as the global or the lowmem area is
empty, and the lowmem area is not mentioned at all. So please update the
documentation as well.

Reviewed-by: Mukesh Pilaniya <mpilaniy@redhat.com>

> 
> Bootmem sizes in MiB in x86 QEMU VMs, before -> after:
> 
>                      CONFIG_NUMA=y     CONFIG_NUMA=n
>   1G,  1 node         176 ->   92       320 ->   80
>   4G,  1 node         508 ->  332      1264 ->  316
>   16G, 2 nodes       1268 ->  704      2944 ->  736
>   32G, 4 nodes       2296 -> 1224      5196 -> 1300
>   64G, 4 nodes       4344 -> 2248      9664 -> 2420
> 
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Reported-by: Kexin Liu <liukexin@kylinos.cn>
> Reported-by: George Guo <guodongtai@kylinos.cn>
> Closes: https://lore.kernel.org/all/20260904025101.9959-1-dongtai.guo@linux.dev
> Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Closes: https://lore.kernel.org/all/20260922131217.698809-1-sourabhjain@linux.ibm.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  kernel/liveupdate/kexec_handover.c | 93 ++++++++++++++++++++++----------------
>  1 file changed, 54 insertions(+), 39 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 5b1797d1289c8..c4b697a612f67 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -685,6 +685,7 @@ static unsigned int bootmem_scale __initdata = 200;
>  static phys_addr_t bootmem_size_global __initdata;
>  static phys_addr_t bootmem_size_pernode __initdata;
>  static phys_addr_t bootmem_size_lowmem __initdata;
> +static phys_addr_t bootmem_size_node[MAX_NUMNODES] __initdata;
>  
>  static int __init kho_parse_bootmem_size(char *p)
>  {
> @@ -754,29 +755,58 @@ static int __init kho_parse_bootmem_size(char *p)
>  }
>  early_param("kho_bootmem", kho_parse_bootmem_size);
>  
> +static phys_addr_t __init reserved_mem_size(phys_addr_t limit, int nid)
> +{
> +	return memblock_reserved_kern_size(limit, nid) -
> +	       memblock_reserved_hugetlb_size(limit, nid);
> +}
> +
> +static phys_addr_t __init bootmem_scale_size(phys_addr_t size)
> +{
> +	return size * bootmem_scale / 100;
> +}
> +
> +/*
> + * The lowmem area covers allocations below ARCH_LOW_ADDRESS_LIMIT, per-node
> + * areas cover allocations above it on each node and the global area covers
> + * allocations that are not bound to any node.
> + *
> + * The reserved memory on a node and the total reserved memory include
> + * lowmem, so it is subtracted from both.
> + *
> + * If ARCH_LOW_ADDRESS_LIMIT covers all memory, any area can serve lowmem
> + * allocations and there is no lowmem area.
> + *
> + * All sizes must be calculated before any area is reserved, otherwise the
> + * areas reserved first will be accounted in the sizes of the others.
> + */
>  static void __init bootmem_size_update(void)
>  {
> -	/*
> -	 * If fixed sizes are not provided via command line, calculate them now.
> -	 * Remove HugeTLB allocations from it because they never get allocated
> -	 * from bootmem.
> -	 */
> +	int nid;
> +
>  	if (bootmem_scale) {
> -		phys_addr_t size;
> -
> -		size = memblock_reserved_kern_size(ARCH_LOW_ADDRESS_LIMIT,
> -						   NUMA_NO_NODE);
> -		size -= memblock_reserved_hugetlb_size(ARCH_LOW_ADDRESS_LIMIT,
> -						       NUMA_NO_NODE);
> -		size = size * bootmem_scale / 100;
> -		bootmem_size_lowmem = size;
> -
> -		size = memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
> -						   NUMA_NO_NODE);
> -		size -= memblock_reserved_hugetlb_size(MEMBLOCK_ALLOC_ANYWHERE,
> -						       NUMA_NO_NODE);
> -		size = size * bootmem_scale / 100 - bootmem_size_lowmem;
> -		bootmem_size_global = size;
> +		phys_addr_t low_limit = ARCH_LOW_ADDRESS_LIMIT;
> +		phys_addr_t lowmem, global, size;
> +
> +		if (low_limit >= memblock_end_of_DRAM() - 1)
> +			low_limit = 0;
> +
> +		lowmem = reserved_mem_size(low_limit, NUMA_NO_NODE);
> +		global = reserved_mem_size(MEMBLOCK_ALLOC_ANYWHERE, NUMA_NO_NODE);
> +		global -= lowmem;
> +
> +		for_each_node_state(nid, N_MEMORY) {
> +			size = reserved_mem_size(MEMBLOCK_ALLOC_ANYWHERE, nid) -
> +			       reserved_mem_size(low_limit, nid);
> +			bootmem_size_node[nid] = bootmem_scale_size(size);
> +			global -= size;
> +		}
> +
> +		bootmem_size_lowmem = bootmem_scale_size(lowmem);
> +		bootmem_size_global = bootmem_scale_size(global);
> +	} else {
> +		for_each_node_state(nid, N_MEMORY)
> +			bootmem_size_node[nid] = bootmem_size_pernode;
>  	}
>  
>  	/*
> @@ -785,24 +815,9 @@ static void __init bootmem_size_update(void)
>  	 */
>  	bootmem_size_lowmem = round_up(bootmem_size_lowmem, BOOTMEM_ALIGNMENT_BYTES);
>  	bootmem_size_global = round_up(bootmem_size_global, BOOTMEM_ALIGNMENT_BYTES);
> -}
> -
> -static phys_addr_t __init bootmem_size_node(int nid)
> -{
> -	phys_addr_t size;
> -
> -	if (bootmem_scale) {
> -		size = memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
> -						   nid);
> -		/* Do not count HugeTLB pages. */
> -		size -= memblock_reserved_hugetlb_size(MEMBLOCK_ALLOC_ANYWHERE,
> -						       nid);
> -		size = size * bootmem_scale / 100;
> -	} else {
> -		size = bootmem_size_pernode;
> -	}
> -
> -	return round_up(size, BOOTMEM_ALIGNMENT_BYTES);
> +	for_each_node_state(nid, N_MEMORY)
> +		bootmem_size_node[nid] = round_up(bootmem_size_node[nid],
> +						  BOOTMEM_ALIGNMENT_BYTES);
>  }
>  
>  bool kho_bootmem_overlap(phys_addr_t phys, size_t size)
> @@ -899,7 +914,7 @@ static void __init kho_reserve_bootmem(void)
>  	 * memoryless nodes, as we can not allocate bootmem areas there.
>  	 */
>  	for_each_node_state(nid, N_MEMORY) {
> -		if (kho_reserve_bootmem_area(bootmem_size_node(nid),
> +		if (kho_reserve_bootmem_area(bootmem_size_node[nid],
>  					     MEMBLOCK_ALLOC_ACCESSIBLE, nid)) {
>  			pr_err("Failed to reserve nid %d bootmem\n", nid);
>  			goto err_free_bootmem_areas;
> 

-- 
Regards,
Mukesh Pilaniya


