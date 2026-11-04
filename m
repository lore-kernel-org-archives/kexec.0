Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114CA606D83D
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CaPnfwwd;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=YIj2TMGk;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=gBXYQX1R
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=iDac3SJ3sAacdSf0W+GWhjMPaQx0+h6n24uVhknSWmw=; b=CaPnfwwduhWM3o
	GJthSixOJyqqa+hwiX+ACDwtGxKOB3raRQDEWofcE32+yBNXyUYmy/zTmxa31AkoMGvNvpHI6vUau
	XivpaF+LkJAslnlEzKMh71O8jGLPDmswlzZdS0+I07LmZp19iAUgWMjjduQQNtFH0iZmxoohyfS7h
	RHPonvZpB+MKKwIpzNETwUCZyTDMzR3xZaXHApesW3omes7YzC5Xxbu54jsUhL8MUayN8OQQP+Kk+
	dtoEUHV5TAb39p7/NXKhwwa5GONKTCPArnepbUoB7etXZ6VqjLjG325waWXUHumQfMI/FLTVcT+gV
	PKbYZ0AdzddK8BPQlNug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgAf-00000006U2A-32RM;
	Wed, 04 Nov 2026 18:57:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgAd-00000006TuD-07QM
	for kexec@bombadil.infradead.org;
	Wed, 04 Nov 2026 18:57:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Message-Id:Date:References:In-Reply-To
	:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=iDac3SJ3sAacdSf0W+GWhjMPaQx0+h6n24uVhknSWmw=; b=YIj2TMGkkPoe0z/rMF2MUEamVY
	VXNfTT7HG4vRTPPywfK+3VehDqPxcd4nWgU9tNMSULNwmIxsxHTerI6+UU1MKADq+VRBMylOB/aMa
	Ki0hMiJ3OQ5vmSu11LUX0XgoUAilLZe+tSGeX+FHxJH0RdeTb94vy/eF2UEjsuowf3gXSQTl01Ztg
	f9WBGUnhEzsDyfjWG8v69oUy6TQTimNeI6atbo2qVwQbfe+MTL/VncGM4ov2h5KDDVnwJXQLevrIn
	18yelGJrsC3qOea1Pur5aHaZH0X/JHVVwTDcu27KvF3mQIIPaUPnn9P9Dq64zgggTIquhZreA1Po0
	GAZPbQpQ==;
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgAa-000000020V5-03p6
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 18:57:13 +0000
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-980c4f5c921so347703241.2
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 10:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793818630; x=1794423430; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iDac3SJ3sAacdSf0W+GWhjMPaQx0+h6n24uVhknSWmw=;
        b=gBXYQX1RklVBfFjaeDDaslm2+KzsdHAHp0LB9HEIOwtdW7D7l7McUx4E4dUesgA8od
         3EksU/apXQ8xCmBOLa25xHME3+u2HpGNotIcPP9YhO+YkNZb4IFRbiZYO645tAQeBWuZ
         pylxkFa0B0+sV/OtHOnp9rpU1v+kEg9W1bYrsQN4DNE9etCSqBdOlb9JE4Bdhg90bhOH
         knl+mDFG4Ss9nBSgkmHRq49PcdlkSDkCfk2WVzcAtLB8bqg4CXYnp2UrnsMtGd0GBkGj
         jkj1yzEMBL+V3UAfEcr0OiPWWSSkUIXBzpWkJL7/vCnNsDrnP55oihIMETvOe3+WDSfU
         VKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818630; x=1794423430;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iDac3SJ3sAacdSf0W+GWhjMPaQx0+h6n24uVhknSWmw=;
        b=QONFayOjuhu2ePXnXmDjcZa8TW4l+roZwnEB7tAMTBOX5zl52pcI9A0S68ot7zpord
         SOGPEbtSOwQR0c51FGilaqR3m/1E246A5kH1Vh5CFSqrXKbgR9L2vaELYLtCJ/HPhwrj
         VgausfhHMoaV3LPJsfDEPMOnO6uxkaYAQAICwfDg+tWsh+1XNd8TVS/LtgqSS12UB1Kn
         4qO1VbfjmH4e6guAwYSEs5vxFqKFoSnald9SsNw89873gz70pEbCr61uk0SboXZhWmmM
         NoseZbg+R78xfrJfM8+eRdfoFyvlEMw8AcL3zxKxwrOyvVM3xWz4Q2fvVbcPR9sQM+/U
         iXng==
X-Forwarded-Encrypted: i=1; AKwUvBw58EPTmweOxBDuC6S7Y2DnmYE9yqAvPub+XBWthGXo/fVyqjRpAMWQfk334+QqPpAWFEs7Mg==@lists.infradead.org
X-Gm-Message-State: APuU4Z/gDbCZrvn35OLxU31OTh0GV3gzVrjItYCGnnoQrBprBPM+YOET
	3r9GUMk+7QMvqIy1s4v0UHx4fDTZ6l8r7h46Zho2mDSfjbyHjh8aRNkT2fmMioqxV88=
X-Gm-Gg: AYBFou0L+NUF2jk2zMEjWVwHeK5FCqRnSGnKMnik7A4/LnmYXFhY34q1YYYldVvOJJN
	rXhwxJRrzz5Bw7ybYT7NlsnKXVKXDJXfZCNvnrbP8f8CzhnemPcj+CQwFCCcBq3JJyMmEXw0ceM
	kbDymTeF04l8PreZS6wqk0tx8IHjJ4gZeDL3aCo96QUfQnJRwd1+aH7DmJI3MxCcMvNiZ5geP7r
	IWzm3XHP7xYPVHNPne1V18/F2UtArGI3oy+uz7fUeJa2Qi3UcReNPX5GIEgcCpmIPaZdkjrAWnl
	U0UlEv8HW1dUhRODlxb9KAP/0WJbaGYA/7uB36BH66pl2DF2cr7LcwqqUdUhi5Lt/fOwxT8BOMm
	miTay2fLQs4K06IJZ4ijx9JjCJEAHXta+yNPdnYgDNQ6p8e7j6aOFUaz8PxiDWfYo6FhlPhxYXh
	rO2FAdctLuUnUsRdCpQBZTpG4OCoj7RD8IcjSvX/42QAu5UEgHiIWMkvV2VxqcTroOFWE9pzd0n
	MXctT1BAuzyE3jev5ukvgv1Yg+9eRchI+VGzIFl5j9+B0a+ALTTzPD4oCqCbEZc6NiHJ0bTRMBI
	wOCWFFd/tN8GqxbEThilrlSgtwjIPlBe/qZaKlvdr9YAMxDo+umnKmsLGx+MpzIS6PcjG7ayzYS
	ZmdmeNFo47cloayCXM0/U4rAU3vLrPDN8WoCDtIHB1O05
X-Received: by 2002:a05:6102:3f8b:b0:7b5:4700:3a6a with SMTP id ada2fe7eead31-7d07267f972mr6534578137.26.1793818629622;
        Wed, 04 Nov 2026 10:57:09 -0800 (PST)
Received: from soleen.c.googlers.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-999f3006224sm736210241.9.2026.11.04.10.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:57:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 3/3] kho: fix bootmem sizing
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Chen Pei <cp0613@linux.alibaba.com>, George Guo <guodongtai@kylinos.cn>, 
 Kexin Liu <liukexin@kylinos.cn>, Sourabh Jain <sourabhjain@linux.ibm.com>, 
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261104-kho-bootmem-sizing-v2-3-b0d1a834780f@kernel.org>
References: <20261104-kho-bootmem-sizing-v2-0-b0d1a834780f@kernel.org>
 <20261104-kho-bootmem-sizing-v2-3-b0d1a834780f@kernel.org>
Date: Wed, 04 Nov 2026 13:57:03 -0500
Message-Id: <179381862329.2089669.11972657670874869389.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6733;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=8NqiYICk6wvIGUqgp0gIb5QmvDxLmCEuClGbEqhbbDE=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq64ACI6dHufVqtKRAfASZU9NnRUoz33nR3D/hW
 5PGUMiqqByJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCauuAAgAKCRC7dyhM23N6
 3q47D/460EB5pARhfkcmCTGOpBx3BVr9a19rLtkQ6IrAevVjF5Usw/TPnwMpU8Ix3kYcbE2HpHO
 g/wizPi9m2UDvdGZX+7Z/UfLYhxq0nc8wtN95e8YGoDhxZUT6qrSX9Uy8bQE2roqYWqsSF1LJgr
 ZJDQBstGnNLSC8oc36m1rwMPmaewALX69WBBsjBiYxjfscHWjSaiLLhL7g1FMDNf9RxWf79NR7d
 daUDV1DoFeNVbe/o+AcvafKPuZfrbfxtikuln4wO6d/0xM+cOy7o31nTslA1XtaWA9DpqlpyifJ
 bV1NjvAMnKfmwiGFYPH1HBAd6BbWxOEhR4I2aJfD9DT9AhwSqrgZMN+H04cflhGprYEIg2Axsdi
 mWLd/R7OYvsdqeZOOKgL5SUHJ6fzeg1pfefjwn2KFervJjfpBqonfzHoR0+bNG5NPYqmNluH0D5
 wlKiEhcRbG33gj6aQuOrXZeYXyXnn6GMogLZgahuIydGI6HBaCWj2P40bbD7sEK8N+QcRCu7GQT
 6tyG+UwuSRYLuUHCe1BYooIhGvmF+tMXM1kQZpvDfZbaAccsD+sgjbXfA7MrvdyTBxcjNS/nl2y
 5SnK4Y4e909G3Z1kx2p6aqysRv3f0nT0ytC4EmB1JStQWhVaLQHJGiYuNbf2GDPCNn0A84Lvcpr
 zcKUMYSVpL4L+ug==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_185712_008546_DAF093ED 
X-CRM114-Status: GOOD (  31.19  )
X-Spam-Score: -0.2 (/)
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 5b1797d1289c..c4b697a612f6 100644
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

Nit, but I prefer to avoid multi-line indented statements without 
braces. Just put a braces around the above.

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha


