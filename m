Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7504A606A334
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YYStbY/b;
	dkim=permerror header.d=jaseg.de header.i=@jaseg.de header.a=rsa-sha1 header.s=fm1 header.b=Q086wdPd;
	dkim=permerror header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha1 header.s=fm1 header.b=aDzSMFZP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qb+DMhDeJ8ctMrQDexBGyo2lF6FDBF9wGMJ9M72kVDk=; b=YYStbY/bG8lTWic4eq2iNGL333
	+f+HNu7oAj4GWyc4unYxe21GjrrBiI45+Tt2M5lRSLJs4M3EtdYlUjJkRgVpt8JULU64R4GWPSD4l
	pPq7jvH+NDaLJzf8QZi7XwLqIwX1++ekt/UI1+PCvns2Cr4AT/nqBMHaftp/C58IqFUuShEdj1IYv
	chg++QeQl2SwgJifyPFpIGjklx9PcqdNeP7SxesTFBWqcEKF30AxjI2if5QELFMh1pwjYMK147/XP
	HLD/K4lY5Cx/cVqO64zW/LUZRChhrdwl/B7ablB8P7rN54qxtlTmLFzOZUsW98hqq4oiAtXLYV2be
	T8MUMLYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ55y-0000000991L-2bC3;
	Tue, 20 Oct 2026 08:21:18 +0000
Received: from flow-a2-smtp.messagingengine.com ([103.168.172.137])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBF0J-0000000182V-2Rxz;
	Mon, 28 Sep 2026 17:19:05 +0000
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id AD33013804F5;
	Mon, 28 Sep 2026 13:19:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 28 Sep 2026 13:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790615942;
	 x=1790623142; bh=qb+DMhDeJ8ctMrQDexBGyo2lF6FDBF9wGMJ9M72kVDk=; b=
	Q086wdPdPofyYqOd6CCUgyN/t8mpJMMP/HIX8oP64Zj5das0e/ptd+qP/oIBR5Mb
	bSSletBqJYrsa1QoJg9+DRa40EOW8Bz7fFfT+JPOUNG3p4cbBKjM9ezoEeMOhm8k
	hY1Sk36qMxifAag37sVgXy+u7vM7JQAmF0OsgbdRLfxNnlUnqkVv7sYOsM6/InhX
	pHqyZABhdzHMb5OCZNAHlV5sxl7ExPt+Sd7AzhUK3yhVliCeYCeShOyDY3m7FLSy
	WNWpidTfbcK8AEy/8PA6g+FNQ44pTni5eODz5GFG0U3Q5sN97imskEAAQnLouI+w
	YRcLgaM4RSNDoy0xlR9aeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790615942; x=
	1790623142; bh=qb+DMhDeJ8ctMrQDexBGyo2lF6FDBF9wGMJ9M72kVDk=; b=a
	DzSMFZPIVCqGZA1xbK69h1yNlARU4T0F4w8pywsoDcSkWFgFWIJAPpRSmCj7hwU5
	iiuiTVbOAomCFtRJz6M6ceA1amvZsf0iqNrXs8SqbRrrpxdaUhI2qE1njVLKz8Hs
	DXQetu0p98p5SizHy3Sf1p/1lKhUblthxt3a3MdoA1sA/V8kGlF+sCFJI2HLY2Db
	PBWdQA3DxcnTbMZuvNEj5S8kNRcWMKogbOAtXycIaSZU+wDgb1EIib8T2qdWqvVZ
	WjvLvzBxxfVe1l86skhGJIBT6qFT0br0l69Fq8VQ4M0Z6jfW5Gla5mD0mQmFMBdC
	Jxpsh7/a8bn87pndxf0RQ==
X-ME-Sender: <xms:haG6alhcHtVpFxOcMYo9n7uQAaDEdH6pTvr92hds5jj6I_IIzXwecg>
    <xme:haG6agI-1xMGY9FvHYkLoQb5aORpkQY7EKUVJOFYQQ6UU5zGIaO4nC0WR-6PQX_0v
    jYauO9sPAX99QgqvMKjCVOm9uPV7jkiQ0qEbhOxEHw-RmFF1-Oq8zU>
X-ME-Received: <xmr:haG6ah3igJ8cyzNmVLUVotsuSTywoOje2f8xkAlZcy1CpQmLnFNgUnjsfAwEbcZ->
X-ME-Proxy-Cause: dmFkZTE/22e7clbyNdHwn0HCBx+H3lsiFyo6QkPV6dpSn20/QyCOxtHNd7QTmx6b7eJ6RH
    b7MD0YK3xmhVFW7pHJl/jJiaLCtzwYaWJ6VBcJNMtYB/lM8rXCQqoyXJAKc1Q+3NTJHLRu
    Q+616RIwRjK3mn/tprgeZTxr9VaE0UGr12rr0RgYUziHPYN8WsIu22gnQm98Dq7NFgLEYb
    bOn/3mv6ye0r5zsmXTZhHlWNyOVRZl7FwJjAmuaSy3Z2MGyz8Xby78ZPjGLjvAF+o1XCsp
    YM5+7QijkJtemWRQaETyS2I23TsNHUOR4KF7C0sS19NgtEnCYopA0Qb1idGIqDD/y3bARJ
    55TM2AUKDHkh3p2LJROf48L6qUKidKUf4FEmoaVrGC4BtePF1n4kQ/m8WMyNVrFYVliewq
    dRS1Y4N3HwhoW3IXajbctY0m6YFjInaMQqGsF+0XxDoGs/X/shiYh8etw6bVnh78U7lhY5
    szx7kaZUC6MoPnbZ48BDrm232jeMvKPGycpJAvfpGTGfOL+XzNv7JzJ2JsQZaz1R5t12c+
    xYYM5pcB1L1B0EzIKqkqE6GPShoGEd7zO6/R0O4maSUQ6gpHRmZDQFJXWcr6ZOTHseBEgU
    Mtz29FmBfsKN9cmGj5+5Q17gXknZhjm6ZUmWo0RbqMjw1Ly/hkmYCDe1Kajw
X-ME-Proxy: <xmx:haG6agL6TL1VrGy04BGifmRplHIpmxSdIKWGI6-UKYT_fwpPZPdTrA>
    <xmx:haG6anD0mj02oO8BLZk0_jzwJUYAw-qjgB_q9bIjdVUWvATeNYfeEw>
    <xmx:haG6aqZF_ZIfNFShTzDipDR2qQhxmZ39ydWfCm15MEvUhhbTc2keUw>
    <xmx:haG6ahX12vCFirqr5BnB2wgscdBu-oNGUDUG2Rw_U_Ap7614Ykkj6Q>
    <xmx:hqG6anhkNZna4tijWomazQ1rmPyFeQAnHZDb6oYfzgRBiTCfNwSWgqRj>
Feedback-ID: i60a14417:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 13:18:47 -0400 (EDT)
From: =?utf-8?q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>
Date: Mon, 28 Sep 2026 19:17:50 +0200
Subject: [PATCH v3 02/12] lib, kexec: Add a secret pool for key material
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260928-crash-memaction-upstream-20260921-v3-2-e511e9ee2329@jaseg.de>
References: <20260928-crash-memaction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de>
In-Reply-To: <20260928-crash-memaction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de>
To: Jonathan Corbet <corbet@lwn.net>,
  Shuah Khan <skhan@linuxfoundation.org>,
  Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh@kernel.org>,
  Saravana Kannan <saravanak@kernel.org>,
  Andrew Morton <akpm@linux-foundation.org>,
  Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,
 Dave Young <ruirui.yang@linux.dev>,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,  Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
  David Hildenbrand <david@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>,
  Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
  Brendan Jackman <brendan.jackman@linux.dev>,
  Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
  Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,  Mark Rutland <mark.rutland@arm.com>,
 Alasdair Kergon <agk@redhat.com>,  Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
  Benjamin Marzinski <bmarzins@redhat.com>,
  Herbert Xu <herbert@gondor.apana.org.au>,
  "David S. Miller" <davem@davemloft.net>,
 Mimi Zohar <zohar@linux.ibm.com>,  David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,  Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,  "Serge E. Hallyn" <serge@hallyn.com>,
  James Bottomley <James.Bottomley@HansenPartnership.com>,
  "Liam R. Howlett" <liam@infradead.org>,
 Lorenzo Stoakes <ljs@kernel.org>,  Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>,  Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry@kernel.org>,  Lance Yang <lance.yang@linux.dev>,
  Baolin Wang <baolin.wang@linux.alibaba.com>,
  Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
  Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
  Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
  Matthew Brost <matthew.brost@intel.com>,
  Joshua Hahn <joshua.hahnjy@gmail.com>,
 Byungchul Park <byungchul@sk.com>,  Gregory Price <gourry@gourry.net>,
  Ying Huang <ying.huang@linux.alibaba.com>,
  Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>,
  Arnd Bergmann <arnd@arndb.de>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 kexec@lists.infradead.org, driver-core@lists.linux.dev, linux-mm@kvack.org, 
 linux-arm-kernel@lists.infradead.org, dm-devel@lists.linux.dev, 
 linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, 
 keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 =?utf-8?q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_101903_721682_44E1B196 
X-CRM114-Status: GOOD (  18.21  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Tue, 20 Oct 2026 01:21:06 -0700
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Key material allocated with kmalloc() shares its slab pages with
unrelated allocations. crash_memaction marks memory at page granularity,
so smaller objects in shared slab pages can't cleanly be marked or
unmarked. This commit adds a secret pool built on kmem_buckets to
hold such keys in marked pages.

Allocations from the pool are marked CRASH_MEMACTION_SECRET. The
marking compiles to nothing without CONFIG_CRASH_MEMACTION, and stays
a no-op at runtime unless "secret" is among the types enabled on the
kernel command line.

The pool requires SLAB_BUCKETS, which in turn depends on !SLUB_TINY,
hence the new dependency for CRASH_MEMACTION. Without SLAB_BUCKETS,
allocations fall back to ordinary kmalloc allocations. The pool
likewise falls back to the ordinary kmalloc caches when it is used
before its initcall runs, or after pool creation failed.

Markings are set on object allocation since there's no clean way to hook
page allocation in kmem_buckets. This comes at a small per-allocation
overhead. Markings are cleared implicitly by the page allocator in
post_alloc_hook() when it hands out a reclaimed page to its next owner.

Using this pool for secrets has a useful side effect from a
defense-in-depth perspective. Where SLAB_BUCKETS is enabled, it keeps
secrets away from other kernel data, which makes UAF or out-of-bounds
read vulnerabilities less likely to reach secrets.

Signed-off-by: Jan Sebastian Götte <linux@jaseg.de>
Assisted-by: Claude Opus 5 <noreply@anthropic.com>
---
 MAINTAINERS                 |  2 ++
 include/linux/secret_pool.h | 47 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/Kconfig.kexec        |  2 ++
 lib/Makefile                |  1 +
 lib/secret_pool.c           | 27 ++++++++++++++++++++++++++
 5 files changed, 79 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c6350fd34f4c..bcb11c2138bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14260,8 +14260,10 @@ F:	fs/proc/vmcore.c
 F:	include/linux/crash_core.h
 F:	include/linux/crash_dump.h
 F:	include/linux/crash_memaction.h
+F:	include/linux/secret_pool.h
 F:	include/uapi/linux/vmcore.h
 F:	kernel/crash_*.c
+F:	lib/secret_pool.c
 
 KEENE FM RADIO TRANSMITTER DRIVER
 M:	Hans Verkuil <hverkuil@kernel.org>
diff --git a/include/linux/secret_pool.h b/include/linux/secret_pool.h
new file mode 100644
index 000000000000..aa9296c981c5
--- /dev/null
+++ b/include/linux/secret_pool.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SECRET_POOL_H
+#define _LINUX_SECRET_POOL_H
+
+#include <linux/gfp.h>
+#include <linux/numa.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+void *secret_pool_alloc_node(size_t size, gfp_t flags, int node)
+	__alloc_size(1);
+
+static inline __alloc_size(1) void *secret_pool_alloc(size_t size, gfp_t flags)
+{
+	return secret_pool_alloc_node(size, flags, NUMA_NO_NODE);
+}
+
+static inline __alloc_size(1) void *secret_pool_zalloc_node(size_t size,
+							    gfp_t flags,
+							    int node)
+{
+	return secret_pool_alloc_node(size, flags | __GFP_ZERO, node);
+}
+
+static inline __alloc_size(1) void *secret_pool_zalloc(size_t size,
+						       gfp_t flags)
+{
+	return secret_pool_alloc_node(size, flags | __GFP_ZERO, NUMA_NO_NODE);
+}
+
+static inline void secret_pool_free(const void *objp)
+{
+	kfree_sensitive(objp);
+}
+
+#define secret_pool_alloc_obj(P, ...) \
+	__alloc_objs(secret_pool_alloc, default_gfp(__VA_ARGS__), typeof(P), 1)
+#define secret_pool_zalloc_obj(P, ...) \
+	__alloc_objs(secret_pool_zalloc, default_gfp(__VA_ARGS__), typeof(P), 1)
+#define secret_pool_alloc_flex(P, FAM, COUNT, ...) \
+	__alloc_flex(secret_pool_alloc, default_gfp(__VA_ARGS__), typeof(P), \
+		     FAM, COUNT)
+#define secret_pool_zalloc_flex(P, FAM, COUNT, ...) \
+	__alloc_flex(secret_pool_zalloc, default_gfp(__VA_ARGS__), typeof(P), \
+		     FAM, COUNT)
+
+#endif /* _LINUX_SECRET_POOL_H */
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index f7326fa6476b..890c35199bea 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -186,6 +186,8 @@ config CRASH_MEMACTION
 	bool "Register kdump actions for certain memory ranges"
 	depends on CRASH_DUMP
 	depends on KEXEC_FILE
+	depends on !SLUB_TINY
+	select SLAB_BUCKETS
 	depends on ARCH_SUPPORTS_CRASH_MEMACTION
 	help
 	  Track pages that may require special handling by the kdump kernel:
diff --git a/lib/Makefile b/lib/Makefile
index 43421c39d21b..0e69633bd79f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -60,6 +60,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
 	 generic-radix-tree.o bitmap-str.o
 obj-y += string_helpers.o
+obj-y += secret_pool.o
 obj-y += hexdump.o
 obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
 obj-y += kstrtox.o
diff --git a/lib/secret_pool.c b/lib/secret_pool.c
new file mode 100644
index 000000000000..62954847091a
--- /dev/null
+++ b/lib/secret_pool.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/crash_memaction.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/secret_pool.h>
+#include <linux/slab.h>
+
+static kmem_buckets * secret_pool __ro_after_init;
+
+static int __init secret_pool_init(void)
+{
+	secret_pool = kmem_buckets_create("secret", 0, 0, 0, NULL);
+
+	return 0;
+}
+core_initcall(secret_pool_init);
+
+void *secret_pool_alloc_node(size_t size, gfp_t flags, int node)
+{
+	void *p = kmem_buckets_alloc_node_track_caller(secret_pool, size,
+						       flags, node);
+
+	crash_memaction_mark(p, size, CRASH_MEMACTION_SECRET);
+
+	return p;
+}
+EXPORT_SYMBOL_GPL(secret_pool_alloc_node);

-- 
2.55.0


