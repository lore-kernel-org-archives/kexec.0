Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BDCC021AD
	for <kexec@archiver.kernel.org>; Tue, 18 Feb 2025 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mReLmHdUalr80UPhI614ZZFtZiFvIOnOjgDKsfY1PQg=; b=IFq5Ray8j/rysBY5Ia1dgr9Khq
	tyFy1bbUDsSzNlElHw+ULP5x8xAzgL7+zLjiZu3Lu8dVMjXH/k+ewt+X/mvcnmmiY9bU9GM4U09Cq
	5tFPoIcPZtta9dzqG8U/F2oeLKwChGVNorP21n5wScPzWrd3QSA+u+1J5E0pSXMiKi4EXeWcqxU7k
	0NWX46rLLNixpSkuNByUquzUM06lLSA3sVULrFZNtqV1Y23uVYnE+v1J2BEb3Lx3TYQY0pQHp9M3e
	Qa4QN/95drqzdnJlfl/F5KBgRJzx6xz/m5IBYlJXowzdrgFR8h4s8jixPxG2P/8DNWIKuWnU0vyP/
	sSNXbJwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkPrN-00000008pd7-2E7o;
	Tue, 18 Feb 2025 15:50:09 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkPrL-00000008pcM-1Tsw;
	Tue, 18 Feb 2025 15:50:08 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso939849766b.1;
        Tue, 18 Feb 2025 07:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739893805; x=1740498605; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mReLmHdUalr80UPhI614ZZFtZiFvIOnOjgDKsfY1PQg=;
        b=CfNqQSlBNY7iB9gHvS11zpHD+D/n1SlfhVQNyLE5Qv25B8j/2t2COAMAHiTweaOQRt
         H7CTFqWlvX8/QYuALvVZqVHXHUw6aUBBvcc0m8M5lCE9L7/T0SkhAcCMU2IVx1NvmPpC
         l1HfF0QUh5AXAsH0Qd70JUxgJh325J4jDuGLB9fxnsfMiGJS9kO1PnvjpcH70k26q35H
         qBh70VM4by3QVFQgsVIx+sXsjN8+VJ/JvYOEUGhTLBhgCMALxdhqfsEyIpIF2k1iHUc/
         TVmY4iMwzor6I19quMtcdQbv5m2AeDmguLZq06ibAK0GuAJXIjz4dzRN5PHK3Azl4sfs
         WpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739893805; x=1740498605;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mReLmHdUalr80UPhI614ZZFtZiFvIOnOjgDKsfY1PQg=;
        b=kfFUkH19mowBKJc4QgRGiNnuqkHrxoLTLG7lrYzykVK5uGIP+IZdb1yWVBX2oVUHFS
         LmdwN7vW0bgUEaiZkvQUZtqi5fNiDvW8ZAgk5HKq7cEml1iBSrAj9AUtMBH51HNQiME0
         ygsJX7Pd7jpEJsPeo5jBH2HArFwsisvTyobEeXpmfsz7hT8p/YqfxLf7ZrlxlDYDhr2D
         Hv57v3ZUo26/BsgHLYrMv/nddL5FWHDGy7AT2KqaY0uLW8Kl0nZgOLNEtkHFZGnkc8SG
         MYcWmfy49a8BwfKRAvSUIjLnTfWo9tqbNsCvisLfhL4GJQWS+cg+X7B9QtScgGtj+1jM
         V2VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf1DP2ywvk19Dy/J1yarqWel+sZefdylD1otUslav2zaTCufh9vitxX9NYmxYGlpx570cy39QYQrhxtictwDrM7g==@lists.infradead.org, AJvYcCXGfRlLX8a0F1+ldpGicMpfPyCoNJ69lrcSD2aV2tYc5SbMU9EeNbhIJZrlGh6oeP6PiDH9fg==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywj91xTC6a8ClLQ2gwLyDYFyShuniLtKmoutzwI+j6ZdPZ4b6nC
	9P/SiLOpLkKQduGac0tuqq4VVnfUWpxtgmdUBmWBFdScWhkdsgii
X-Gm-Gg: ASbGnct/2aC7zSoYuO0I++LHxUr8TPHSl7eyg6//TrVLJUoojhn2OFNL4JvbuhVSdKu
	2tSOFcntDQ4jDiA+cdwNgciFtdjWDb5rteco9qx6KqrdRSeHmQP9BJKBxrla6ySevp7i47AsAbi
	fimbHOiBJErvpZH+vEgi9lSHoPbwpzllrJHJUwM5MbHkUlYgUh6dAxgr7iNzIVa+5xn/so1LsNV
	Jh3gp/s6WUGkSd2Ntmo+UVb2A4MQwCtlGyxyMyG3vKsEUgLHYIezEFBAKVPr9D9CqAQnqbUUxSk
	9NTHThf4dK+hPYE=
X-Google-Smtp-Source: AGHT+IHtAyydbfoXbx9zeo04VNjwSnQ27Knmz0ItYzncGEjZUASU18pITXXeMFFJlPuU/Bj7x5gW4g==
X-Received: by 2002:a17:907:3d8e:b0:ab7:462f:647f with SMTP id a640c23a62f3a-abb70b35f1amr1476203766b.25.1739893805155;
        Tue, 18 Feb 2025 07:50:05 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba002f790sm351966766b.164.2025.02.18.07.50.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2025 07:50:04 -0800 (PST)
Date: Tue, 18 Feb 2025 15:50:04 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
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
Message-ID: <20250218155004.n53fcuj2lrl5rxll@master>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-3-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206132754.2596694-3-rppt@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_075007_386840_31D122AE 
X-CRM114-Status: GOOD (  23.43  )
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

On Thu, Feb 06, 2025 at 03:27:42PM +0200, Mike Rapoport wrote:
>From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
>to denote areas that were reserved for kernel use either directly with
>memblock_reserve_kern() or via memblock allocations.
>
>Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>---
> include/linux/memblock.h | 16 +++++++++++++++-
> mm/memblock.c            | 32 ++++++++++++++++++++++++--------
> 2 files changed, 39 insertions(+), 9 deletions(-)
>
>diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>index e79eb6ac516f..65e274550f5d 100644
>--- a/include/linux/memblock.h
>+++ b/include/linux/memblock.h
>@@ -50,6 +50,7 @@ enum memblock_flags {
> 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
> 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
> 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
>+	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */

Above memblock_flags, there are comments on explaining those flags.

Seems we miss it for MEMBLOCK_RSRV_KERN.

> };
> 
> /**
>@@ -116,7 +117,19 @@ int memblock_add_node(phys_addr_t base, phys_addr_t size, int nid,
> int memblock_add(phys_addr_t base, phys_addr_t size);
> int memblock_remove(phys_addr_t base, phys_addr_t size);
> int memblock_phys_free(phys_addr_t base, phys_addr_t size);
>-int memblock_reserve(phys_addr_t base, phys_addr_t size);
>+int __memblock_reserve(phys_addr_t base, phys_addr_t size, int nid,
>+		       enum memblock_flags flags);
>+
>+static __always_inline int memblock_reserve(phys_addr_t base, phys_addr_t size)
>+{
>+	return __memblock_reserve(base, size, NUMA_NO_NODE, 0);
                                                            ^ MEMBLOCK_NONE ?

>+}
>+
>+static __always_inline int memblock_reserve_kern(phys_addr_t base, phys_addr_t size)
>+{
>+	return __memblock_reserve(base, size, NUMA_NO_NODE, MEMBLOCK_RSRV_KERN);
>+}
>+
> #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> int memblock_physmem_add(phys_addr_t base, phys_addr_t size);
> #endif
>@@ -477,6 +490,7 @@ static inline __init_memblock bool memblock_bottom_up(void)
> 
> phys_addr_t memblock_phys_mem_size(void);
> phys_addr_t memblock_reserved_size(void);
>+phys_addr_t memblock_reserved_kern_size(int nid);
> unsigned long memblock_estimated_nr_free_pages(void);
> phys_addr_t memblock_start_of_DRAM(void);
> phys_addr_t memblock_end_of_DRAM(void);
>diff --git a/mm/memblock.c b/mm/memblock.c
>index 95af35fd1389..4c33baf4d97c 100644
>--- a/mm/memblock.c
>+++ b/mm/memblock.c
>@@ -491,7 +491,7 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
> 	 * needn't do it
> 	 */
> 	if (!use_slab)
>-		BUG_ON(memblock_reserve(addr, new_alloc_size));
>+		BUG_ON(memblock_reserve_kern(addr, new_alloc_size));
> 
> 	/* Update slab flag */
> 	*in_slab = use_slab;
>@@ -641,7 +641,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
> #ifdef CONFIG_NUMA
> 			WARN_ON(nid != memblock_get_region_node(rgn));
> #endif
>-			WARN_ON(flags != rgn->flags);
>+			WARN_ON(flags != MEMBLOCK_NONE && flags != rgn->flags);
> 			nr_new++;
> 			if (insert) {
> 				if (start_rgn == -1)
>@@ -901,14 +901,15 @@ int __init_memblock memblock_phys_free(phys_addr_t base, phys_addr_t size)
> 	return memblock_remove_range(&memblock.reserved, base, size);
> }
> 
>-int __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t size)
>+int __init_memblock __memblock_reserve(phys_addr_t base, phys_addr_t size,
>+				       int nid, enum memblock_flags flags)
> {
> 	phys_addr_t end = base + size - 1;
> 
>-	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
>-		     &base, &end, (void *)_RET_IP_);
>+	memblock_dbg("%s: [%pa-%pa] nid=%d flags=%x %pS\n", __func__,
>+		     &base, &end, nid, flags, (void *)_RET_IP_);
> 
>-	return memblock_add_range(&memblock.reserved, base, size, MAX_NUMNODES, 0);
>+	return memblock_add_range(&memblock.reserved, base, size, nid, flags);
> }
> 
> #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
>@@ -1459,14 +1460,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
> again:
> 	found = memblock_find_in_range_node(size, align, start, end, nid,
> 					    flags);
>-	if (found && !memblock_reserve(found, size))
>+	if (found && !__memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN))

Maybe we could use memblock_reserve_kern() directly. If my understanding is
correct, the reserved region's nid is not used.

BTW, one question here. How we handle concurrent memblock allocation? If two
threads find the same available range and do the reservation, it seems to be a
problem to me. Or I missed something?

> 		goto done;
> 
> 	if (numa_valid_node(nid) && !exact_nid) {
> 		found = memblock_find_in_range_node(size, align, start,
> 						    end, NUMA_NO_NODE,
> 						    flags);
>-		if (found && !memblock_reserve(found, size))
>+		if (found && !memblock_reserve_kern(found, size))
> 			goto done;
> 	}
> 
>@@ -1751,6 +1752,20 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
> 	return memblock.reserved.total_size;
> }
> 
>+phys_addr_t __init_memblock memblock_reserved_kern_size(int nid)
>+{
>+	struct memblock_region *r;
>+	phys_addr_t total = 0;
>+
>+	for_each_reserved_mem_region(r) {
>+		if (nid == memblock_get_region_node(r) || !numa_valid_node(nid))
>+			if (r->flags & MEMBLOCK_RSRV_KERN)
>+				total += r->size;
>+	}
>+
>+	return total;
>+}
>+
> /**
>  * memblock_estimated_nr_free_pages - return estimated number of free pages
>  * from memblock point of view
>@@ -2397,6 +2412,7 @@ static const char * const flagname[] = {
> 	[ilog2(MEMBLOCK_NOMAP)] = "NOMAP",
> 	[ilog2(MEMBLOCK_DRIVER_MANAGED)] = "DRV_MNG",
> 	[ilog2(MEMBLOCK_RSRV_NOINIT)] = "RSV_NIT",
>+	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
> };
> 
> static int memblock_debug_show(struct seq_file *m, void *private)
>-- 
>2.47.2
>

-- 
Wei Yang
Help you, Help me

