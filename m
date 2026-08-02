Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17699C55171
	for <kexec@archiver.kernel.org>; Sun,  2 Aug 2026 11:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FqGL/ivu0kPMFEoqQ4nvJHR3lkRTVyHnKZqNJ5UqfJw=; b=pbxu7Z3p5zB+gsksCPal3EgY3U
	Fe9ICJSNPmFxXXZNvHGHRUIuNc5Uqvn19KSkEBw4cNWiVR8CMHneVFvSD7GODHLfdnEsY+7Op/kHq
	pIBUyC+mPg9HxV8qFVYgvK6G+KENGQk8LhVGTQElBJ9t9ys8NrKyojcEsp65g0yB0i46amt0PPvrd
	cbAca2kdNxv2zp4EwWSrAo1LYWP1JwWxJEsXJNoNClgEtWDQdgCQT/uc5Ez7x37QGDFzaqdNkXdzz
	u8MbVP8eomJb9PKDF1zTCy/LPdYO/DS/t016Z+w+npiK6VFqzNjXmGIZFVhP7pYtxz+Zli/xkOrgG
	gK8Gzmsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqUK0-0000000FZLw-2cwj;
	Sun, 02 Aug 2026 11:25:36 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqUJy-0000000FZLq-29ux
	for kexec@lists.infradead.org;
	Sun, 02 Aug 2026 11:25:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 34A3C6057A;
	Sun,  2 Aug 2026 11:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717591F000E9;
	Sun,  2 Aug 2026 11:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785669931;
	bh=FqGL/ivu0kPMFEoqQ4nvJHR3lkRTVyHnKZqNJ5UqfJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UdHSFmIUrefEUW2F0hPEyBcCVPw1XXJjlW1RaBg2UmleH4ra6hVKzCgK7xN9wMApt
	 Frrt61qEC8uAoiqw1WzSBukPaU+7+rX3Z4vptgMqVqwjoFuobTxOUVYUNoomCa38Y0
	 7KjQxky2138aS9nFyLfzMGMON4v5xuwTLhAiDf6pjTthfDHLEfH4jHvY8OczLq7KZj
	 rOfvi22ec3G/rQBqONbDbmQ3zn5zH8cssC/EE+dx391nsoMSTAQSHakhkT6fNprPhW
	 wuoEQEGWOzSGMWvd2/w0VB16SKN5y+4/fbMqYFoWKaKqie9+8UVVBa/L1idd+nxz7u
	 3w1Zmr7xOgS8A==
Date: Sun, 2 Aug 2026 14:25:24 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>,
	Jork Loeser <jloeser@linux.microsoft.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 04/22] kho: return virtual address of mem_map from
 kho_get_mem_map()
Message-ID: <am8pJCeLv0cOMzpf@kernel.org>
References: <20260801084833.1897543-1-pratyush@kernel.org>
 <20260801084833.1897543-5-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801084833.1897543-5-pratyush@kernel.org>
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

On Sat, Aug 01, 2026 at 10:48:13AM +0200, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> Currently the preserved memory map address is returned by
> kho_get_mem_map_phys(). It is only used by kho_populate().
> kho_populate() doesn't use the actual value. It only cares that the
> address exists and is valid.
> 
> In coming patches, more callers will be added, all of which will need
> the virtual address of the preserved memory map. Since kho_populate()
> doesn't care about the actual value and only cares about validity, it
> can also use the virtual address returned by kho_get_mem_map(). It only
> needs to make sure the returned value is not NULL.
> 
> Rename kho_get_mem_map_phys() to kho_get_mem_map() and return the
> virtual address of the preserved memory map.
> 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
>  kernel/liveupdate/kexec_handover.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index e7451743b87e..5c35c11c273b 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -512,19 +512,24 @@ static int __init kho_preserved_memory_reserve(unsigned long key)
>  	return 0;
>  }
>  
> -/* Returns physical address of the preserved memory map from FDT */
> -static phys_addr_t __init kho_get_mem_map_phys(const void *fdt)
> +/* Returns virtual address of the preserved memory map from FDT */
> +static __init void *kho_get_mem_map(const void *fdt)
>  {
>  	const void *mem_ptr;
> +	phys_addr_t mem_map_phys;
>  	int len;
>  
>  	mem_ptr = fdt_getprop(fdt, 0, KHO_FDT_MEMORY_MAP_PROP_NAME, &len);
>  	if (!mem_ptr || len != sizeof(u64)) {
>  		pr_err("failed to get preserved memory map\n");
> -		return 0;
> +		return NULL;
>  	}
>  
> -	return get_unaligned((const u64 *)mem_ptr);
> +	mem_map_phys = get_unaligned((const u64 *)mem_ptr);
> +	if (!mem_map_phys)
> +		return NULL;
> +
> +	return phys_to_virt(mem_map_phys);

This time sashiko found a real issue with this on arm64:

  Will calling phys_to_virt() unconditionally here cause a panic on ARM64
  during early boot?

  When booting with KHO properties, early_init_dt_scan() calls kho_populate()
  which then calls kho_get_mem_map(). Since this happens before
  arm64_memblock_init() sets up memstart_addr, the internal phys_to_virt()
  implementation evaluates PHYS_OFFSET with an uninitialized memstart_addr.
  This fails the VM_BUG_ON(memstart_addr & 1) assertion when CONFIG_DEBUG_VM
  is enabled.

I fixed this up by keeping kho_get_mem_map_phys() and adding a thin
kho_get_mem_map() that returns the virtual address.

This caused some rebase conflicts afterwards, please check I didn't mess up
anything :)

>  }
>  
>  /*
> @@ -1647,9 +1652,8 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  {
>  	unsigned int scratch_cnt = scratch_len / sizeof(*kho_scratch);
>  	struct kho_scratch *scratch = NULL;
> -	phys_addr_t mem_map_phys;
> -	void *fdt = NULL;
>  	bool populated = false;
> +	void *fdt = NULL;
>  	int err;
>  
>  	/* Validate the input FDT */
> @@ -1671,8 +1675,13 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  		goto unmap_fdt;
>  	}
>  
> -	mem_map_phys = kho_get_mem_map_phys(fdt);
> -	if (!mem_map_phys)
> +	/*
> +	 * At this point phys_to_virt() doesn't work properly and so
> +	 * kho_get_mem_map() can return a pre-KASLR virtual address. But here we
> +	 * only want to make sure the mem_map is valid so the actual value
> +	 * doesn't matter as long as it isn't NULL.
> +	 */
> +	if (!kho_get_mem_map(fdt))
>  		goto unmap_fdt;
>  
>  	scratch = early_memremap(scratch_phys, scratch_len);
> -- 
> 2.55.0.571.g244d577d93-goog
> 

-- 
Sincerely yours,
Mike.

