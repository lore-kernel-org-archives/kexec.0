Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7671FC02199
	for <kexec@archiver.kernel.org>; Thu,  6 Feb 2025 13:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dwgPwEXkcwGOXGQmeLgJ7EjQPMg4p6VQGy7v4D8ZRag=; b=GJTqz6DwKpghD3rr2W56hkZkiM
	Ogm5mZOk6gYH6UmAN2y88W5404htNiUXjLAc6f+R+vHCFYjI1mNQYeB3V6wqEcSAdSIE4VyQILHpf
	L7IEwUBSmMa3UWpYkiGbFEs2WMGwJi8GST11Blt6Ovf2i/sgNxACze5Lq0+QPReuOOEFXMGnhequ9
	j4iJbt9dH0T8HpDXc5/jQD1Wnhwsm9Vr3CDKpShwGZ+cKP0FtXnkZQ5MdO7ihrGuoLUHdwd84WiI5
	0yZQNgIuTSAxRxclbAyrilf9r4s6sdsPo6N/SMj2HXoT3AolhyTGxOKMqZ832xesk1B90ZkbbvR7V
	xUx5Czgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tg23j-00000006SMS-0ZMW;
	Thu, 06 Feb 2025 13:36:47 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tg1vn-00000006QdV-0xOo;
	Thu, 06 Feb 2025 13:28:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=dwgPwEXkcwGOXGQmeLgJ7EjQPMg4p6VQGy7v4D8ZRag=; b=A9cy1h+nn1J2vlgPqRtPSqgj0x
	XXdwIGwSfHQ4mBh2n9k58JWsAIcwTrFieM60SuIgvJ3u81uc1W5JINZcVXVXRI3OKAxypp8C/mLwF
	1m6XllZIiQGHqXJuBjYGLuTUpjkwT5ms5oLwhdsE4GYQaUuHoxfLdDAU52mm+rRPXxbclJKqE4cUh
	b071mVczUGsT/fSTfH/NnAkC3c95nqSHJ9s0uhUwbZWgAtao9AAAuG+n1OE8khHOcPUzuZVD5jDSa
	oBvnwc56yJD9EtKIfsT4iAgqQUmvKacaq0S8JqdG/T1tTJTb1xJRCm6u2hN41AvlZnIk5v/YmWJ1u
	YisUqw7g==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tg1vk-0000000GwuS-00cw;
	Thu, 06 Feb 2025 13:28:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 98CB35C5036;
	Thu,  6 Feb 2025 13:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B3EC4CEE8;
	Thu,  6 Feb 2025 13:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738848510;
	bh=7To/iR/9rk2Ld4I6CBIN7hsqKtoOH+4meeYk+05Pg1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gX7xnL6GCVqc63zHzfRGBVkVXmpG/UInlzAamHp6vWIxeNSlWeMw/gWcWyc0yWTSS
	 BWxYBGynAl51oCkZFwu7C8eswNs1UrjGbvPC+ieegpopxsbnHfj5IyryQnq70zC0FN
	 B3VcUdPxUB9Z3qgOXAiUblAJh9z+mGkASNvE69WcxMel63Bdv7nW8Z7smXHPcooJ5B
	 foloDgLeRj5zqgo5nMOI1Ia8x2BwRWlwVmxQFR+EFxzG+BIPcapmdTRenMIRm44tfy
	 p6M/KDBMiWoC6IyvgbJgFAdHs+eEVS8/MJzW8ZyEVVyD7BziWY7QNBT0HGAJdoHVH7
	 GXtbyy+SA5x1A==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH v4 02/14] memblock: add MEMBLOCK_RSRV_KERN flag
Date: Thu,  6 Feb 2025 15:27:42 +0200
Message-ID: <20250206132754.2596694-3-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250206132754.2596694-1-rppt@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250206_132832_446692_1E22C1AD 
X-CRM114-Status: GOOD (  17.54  )
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

to denote areas that were reserved for kernel use either directly with
memblock_reserve_kern() or via memblock allocations.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/memblock.h | 16 +++++++++++++++-
 mm/memblock.c            | 32 ++++++++++++++++++++++++--------
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index e79eb6ac516f..65e274550f5d 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -50,6 +50,7 @@ enum memblock_flags {
 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
+	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
 };
 
 /**
@@ -116,7 +117,19 @@ int memblock_add_node(phys_addr_t base, phys_addr_t size, int nid,
 int memblock_add(phys_addr_t base, phys_addr_t size);
 int memblock_remove(phys_addr_t base, phys_addr_t size);
 int memblock_phys_free(phys_addr_t base, phys_addr_t size);
-int memblock_reserve(phys_addr_t base, phys_addr_t size);
+int __memblock_reserve(phys_addr_t base, phys_addr_t size, int nid,
+		       enum memblock_flags flags);
+
+static __always_inline int memblock_reserve(phys_addr_t base, phys_addr_t size)
+{
+	return __memblock_reserve(base, size, NUMA_NO_NODE, 0);
+}
+
+static __always_inline int memblock_reserve_kern(phys_addr_t base, phys_addr_t size)
+{
+	return __memblock_reserve(base, size, NUMA_NO_NODE, MEMBLOCK_RSRV_KERN);
+}
+
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
 int memblock_physmem_add(phys_addr_t base, phys_addr_t size);
 #endif
@@ -477,6 +490,7 @@ static inline __init_memblock bool memblock_bottom_up(void)
 
 phys_addr_t memblock_phys_mem_size(void);
 phys_addr_t memblock_reserved_size(void);
+phys_addr_t memblock_reserved_kern_size(int nid);
 unsigned long memblock_estimated_nr_free_pages(void);
 phys_addr_t memblock_start_of_DRAM(void);
 phys_addr_t memblock_end_of_DRAM(void);
diff --git a/mm/memblock.c b/mm/memblock.c
index 95af35fd1389..4c33baf4d97c 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -491,7 +491,7 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
 	 * needn't do it
 	 */
 	if (!use_slab)
-		BUG_ON(memblock_reserve(addr, new_alloc_size));
+		BUG_ON(memblock_reserve_kern(addr, new_alloc_size));
 
 	/* Update slab flag */
 	*in_slab = use_slab;
@@ -641,7 +641,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 #ifdef CONFIG_NUMA
 			WARN_ON(nid != memblock_get_region_node(rgn));
 #endif
-			WARN_ON(flags != rgn->flags);
+			WARN_ON(flags != MEMBLOCK_NONE && flags != rgn->flags);
 			nr_new++;
 			if (insert) {
 				if (start_rgn == -1)
@@ -901,14 +901,15 @@ int __init_memblock memblock_phys_free(phys_addr_t base, phys_addr_t size)
 	return memblock_remove_range(&memblock.reserved, base, size);
 }
 
-int __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t size)
+int __init_memblock __memblock_reserve(phys_addr_t base, phys_addr_t size,
+				       int nid, enum memblock_flags flags)
 {
 	phys_addr_t end = base + size - 1;
 
-	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
-		     &base, &end, (void *)_RET_IP_);
+	memblock_dbg("%s: [%pa-%pa] nid=%d flags=%x %pS\n", __func__,
+		     &base, &end, nid, flags, (void *)_RET_IP_);
 
-	return memblock_add_range(&memblock.reserved, base, size, MAX_NUMNODES, 0);
+	return memblock_add_range(&memblock.reserved, base, size, nid, flags);
 }
 
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
@@ -1459,14 +1460,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 again:
 	found = memblock_find_in_range_node(size, align, start, end, nid,
 					    flags);
-	if (found && !memblock_reserve(found, size))
+	if (found && !__memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN))
 		goto done;
 
 	if (numa_valid_node(nid) && !exact_nid) {
 		found = memblock_find_in_range_node(size, align, start,
 						    end, NUMA_NO_NODE,
 						    flags);
-		if (found && !memblock_reserve(found, size))
+		if (found && !memblock_reserve_kern(found, size))
 			goto done;
 	}
 
@@ -1751,6 +1752,20 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
 	return memblock.reserved.total_size;
 }
 
+phys_addr_t __init_memblock memblock_reserved_kern_size(int nid)
+{
+	struct memblock_region *r;
+	phys_addr_t total = 0;
+
+	for_each_reserved_mem_region(r) {
+		if (nid == memblock_get_region_node(r) || !numa_valid_node(nid))
+			if (r->flags & MEMBLOCK_RSRV_KERN)
+				total += r->size;
+	}
+
+	return total;
+}
+
 /**
  * memblock_estimated_nr_free_pages - return estimated number of free pages
  * from memblock point of view
@@ -2397,6 +2412,7 @@ static const char * const flagname[] = {
 	[ilog2(MEMBLOCK_NOMAP)] = "NOMAP",
 	[ilog2(MEMBLOCK_DRIVER_MANAGED)] = "DRV_MNG",
 	[ilog2(MEMBLOCK_RSRV_NOINIT)] = "RSV_NIT",
+	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
 };
 
 static int memblock_debug_show(struct seq_file *m, void *private)
-- 
2.47.2


