Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4AAC4167D
	for <kexec@archiver.kernel.org>; Wed, 13 Dec 2023 01:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bzkvWkI7irR+BVj8GqlcfOTVZCJ5JD7JDa7kuPLTNr0=; b=TzNlredqbPanC1
	gpdUvA4+RnTHkLhgHe2ZYCJO6/sW+p30KDOaALCFMWCuk4chALYm09ye46WHlF/IjIM2mAhoUSqMu
	X7hGqgHOF56SesYpp6P6tOJyu3iNdqbCg94v0h7t6KKmFIo3wVPgW7xtzwE/Sw3u9ov1jtfSA+mJ6
	h8DiAt0axkIdertqbjOyMoPypVz6whaN3byiD+m++JdQ8v8tlgAbkkqXY6BrsW10okiZ+jPdCrbx9
	e/19JYUYKtb6H8QXg84gH+cqGzp3X0RwUQj4ua2vNkC5oXkkJgZe7A2ndWXuhTFhPv0QdEzvuGKKY
	zgvnqsRPqm1ORLEnhwfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDDrN-00DHg7-13;
	Wed, 13 Dec 2023 01:16:25 +0000
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDClF-00D7KW-0T;
	Wed, 13 Dec 2023 00:06:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702425961; x=1733961961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZFw7vHojuqK3RNa1/vBeZMhNA6TKCzlzgnpxEyXCDLU=;
  b=uFxqNmQR5vUvsMtvHpx+N1FuaqB/ck4xViTQI+QZ6CSQkD9NAp5VgH1f
   789iOBzuwdyuSVx/kyZrXzfsWXc6scu9UdL7Ey7SSJhC7VL9IuyYz0lED
   AKu+cPIPRST2ylOK1Z6L97aOLIMTezmyCKH9T4zJCLxb2KlOBAJX3GS+u
   c=;
X-IronPort-AV: E=Sophos;i="6.04,271,1695686400"; 
   d="scan'208";a="316892987"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 00:05:49 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com (Postfix) with ESMTPS id C557460A68;
	Wed, 13 Dec 2023 00:05:39 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:63725]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.243:2525] with esmtp (Farcaster)
 id df4b2a7f-6229-4967-8f23-449065835394; Wed, 13 Dec 2023 00:05:39 +0000 (UTC)
X-Farcaster-Flow-ID: df4b2a7f-6229-4967-8f23-449065835394
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:05:39 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:05:35 +0000
From: Alexander Graf <graf@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-trace-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>, <x86@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rob Herring" <robh+dt@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Mark Rutland
	<mark.rutland@arm.com>, "Tom Lendacky" <thomas.lendacky@amd.com>, Ashish
 Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>, Stanislav
 Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Subject: [PATCH 05/15] kexec: Add KHO support to kexec file loads
Date: Wed, 13 Dec 2023 00:04:42 +0000
Message-ID: <20231213000452.88295-6-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213000452.88295-1-graf@amazon.com>
References: <20231213000452.88295-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_160601_226172_5537FE67 
X-CRM114-Status: GOOD (  34.36  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Kexec has 2 modes: A user space driven mode and a kernel driven mode.
For the kernel driven mode, kernel code determines the physical
addresses of all target buffers that the payload gets copied into.

With KHO, we can only safely copy payloads into the "scratch area".
Teach the kexec file loader about it, so it only allocates for that
area. In addition, enlighten it with support to ask the KHO subsystem
for its respective payloads to copy into target memory. Also teach the
KHO subsystem how to fill the images for file loads.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 include/linux/kexec.h  |   9 ++
 kernel/kexec_file.c    |  41 ++++++++
 kernel/kexec_kho_out.c | 210 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 260 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index a3c4fee6f86a..c8859a2ca872 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -362,6 +362,13 @@ struct kimage {
 	size_t ima_buffer_size;
 #endif
 
+#ifdef CONFIG_KEXEC_KHO
+	struct {
+		struct kexec_buf dt;
+		struct kexec_buf mem_cache;
+	} kho;
+#endif
+
 	/* Core ELF header buffer */
 	void *elf_headers;
 	unsigned long elf_headers_sz;
@@ -543,6 +550,7 @@ static inline bool is_kho_boot(void)
 
 /* egest handover metadata */
 void kho_reserve(void);
+int kho_fill_kimage(struct kimage *image);
 int register_kho_notifier(struct notifier_block *nb);
 int unregister_kho_notifier(struct notifier_block *nb);
 bool kho_is_active(void);
@@ -558,6 +566,7 @@ static inline void *kho_get_fdt(void) { return NULL; }
 
 /* egest handover metadata */
 static inline void kho_reserve(void) { }
+static inline int kho_fill_kimage(struct kimage *image) { return 0; }
 static inline int register_kho_notifier(struct notifier_block *nb) { return -EINVAL; }
 static inline int unregister_kho_notifier(struct notifier_block *nb) { return -EINVAL; }
 static inline bool kho_is_active(void) { return false; }
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f9a419cd22d4..d895d0a49bd9 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -113,6 +113,13 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	image->ima_buffer = NULL;
 #endif /* CONFIG_IMA_KEXEC */
 
+#ifdef CONFIG_KEXEC_KHO
+	kvfree(image->kho.mem_cache.buffer);
+	image->kho.mem_cache = (struct kexec_buf) {};
+	kvfree(image->kho.dt.buffer);
+	image->kho.dt = (struct kexec_buf) {};
+#endif
+
 	/* See if architecture has anything to cleanup post load */
 	arch_kimage_file_post_load_cleanup(image);
 
@@ -249,6 +256,11 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	/* IMA needs to pass the measurement list to the next kernel. */
 	ima_add_kexec_buffer(image);
 
+	/* If KHO is active, add its images to the list */
+	ret = kho_fill_kimage(image);
+	if (ret)
+		goto out;
+
 	/* Call image load handler */
 	ldata = kexec_image_load_default(image);
 
@@ -518,6 +530,24 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
 	return locate_mem_hole_bottom_up(start, end, kbuf);
 }
 
+#ifdef CONFIG_KEXEC_KHO
+static int kexec_walk_kho_scratch(struct kexec_buf *kbuf,
+				  int (*func)(struct resource *, void *))
+{
+	int ret = 0;
+
+	struct resource res = {
+		.start = kho_scratch_phys,
+		.end = kho_scratch_phys + kho_scratch_len,
+	};
+
+	/* Try to fit the kimage into our KHO scratch region */
+	ret = func(&res, kbuf);
+
+	return ret;
+}
+#endif
+
 #ifdef CONFIG_ARCH_KEEP_MEMBLOCK
 static int kexec_walk_memblock(struct kexec_buf *kbuf,
 			       int (*func)(struct resource *, void *))
@@ -612,6 +642,17 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
 	if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN)
 		return 0;
 
+#ifdef CONFIG_KEXEC_KHO
+	/*
+	 * If KHO is active, only use KHO scratch memory. All other memory
+	 * could potentially be handed over.
+	 */
+	if (kho_is_active() && kbuf->image->type != KEXEC_TYPE_CRASH) {
+		ret = kexec_walk_kho_scratch(kbuf, locate_mem_hole_callback);
+		return ret == 1 ? 0 : -EADDRNOTAVAIL;
+	}
+#endif
+
 	if (!IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
 		ret = kexec_walk_resources(kbuf, locate_mem_hole_callback);
 	else
diff --git a/kernel/kexec_kho_out.c b/kernel/kexec_kho_out.c
index e6184bde5c10..24ced6c3013f 100644
--- a/kernel/kexec_kho_out.c
+++ b/kernel/kexec_kho_out.c
@@ -50,6 +50,216 @@ int unregister_kho_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(unregister_kho_notifier);
 
+static int kho_mem_cache_add(void *fdt, struct kho_mem *mem_cache, int size,
+			     struct kho_mem *new_mem)
+{
+	int entries = size / sizeof(*mem_cache);
+	u64 new_start = new_mem->addr;
+	u64 new_end = new_mem->addr + new_mem->len;
+	u64 prev_start = 0;
+	u64 prev_end = 0;
+	int i;
+
+	if (WARN_ON((new_start < (kho_scratch_phys + kho_scratch_len)) &&
+		    (new_end > kho_scratch_phys))) {
+		pr_err("KHO memory runs over scratch memory");
+		return -EINVAL;
+	}
+
+	/*
+	 * We walk the existing sorted mem cache and find the spot where this
+	 * new entry would start, so we can insert it right there.
+	 */
+	for (i = 0; i < entries; i++) {
+		struct kho_mem *mem = &mem_cache[i];
+		u64 mem_end = (mem->addr + mem->len);
+
+		if (mem_end < new_start) {
+			/* No overlap */
+			prev_start = mem->addr;
+			prev_end = mem->addr + mem->len;
+			continue;
+		} else if ((new_start >= mem->addr) && (new_end <= mem_end)) {
+			/* new_mem fits into mem, skip */
+			return size;
+		} else if ((new_end >= mem->addr) && (new_start <= mem_end)) {
+			/* new_mem and mem overlap, fold them */
+			bool remove = false;
+
+			mem->addr = min(new_start, mem->addr);
+			mem->len = max(mem_end, new_end) - mem->addr;
+			mem_end = (mem->addr + mem->len);
+
+			if (i > 0 && prev_end >= mem->addr) {
+				/* We now overlap with the previous mem, fold */
+				struct kho_mem *prev = &mem_cache[i - 1];
+
+				prev->addr = min(prev->addr, mem->addr);
+				prev->len = max(mem_end, prev_end) - prev->addr;
+				remove = true;
+			} else if (i < (entries - 1) && mem_end >= mem_cache[i + 1].addr) {
+				/* We now overlap with the next mem, fold */
+				struct kho_mem *next = &mem_cache[i + 1];
+				u64 next_end = (next->addr + next->len);
+
+				next->addr = min(next->addr, mem->addr);
+				next->len = max(mem_end, next_end) - next->addr;
+				remove = true;
+			}
+
+			if (remove) {
+				/* We folded this mem into another, remove it */
+				memmove(mem, mem + 1, (entries - i - 1) * sizeof(*mem));
+				size -= sizeof(*new_mem);
+			}
+
+			return size;
+		} else if (mem->addr > new_end) {
+			/*
+			 * The mem cache is sorted. If we find the current
+			 * entry start after our new_mem's end, we shot over
+			 * which means we need to add it by creating a new
+			 * hole right after the current entry.
+			 */
+			memmove(mem + 1, mem, (entries - i) * sizeof(*mem));
+			break;
+		}
+	}
+
+	mem_cache[i] = *new_mem;
+	size += sizeof(*new_mem);
+
+	return size;
+}
+
+/**
+ * kho_alloc_mem_cache - Allocate and initialize the mem cache kexec_buf
+ */
+static int kho_alloc_mem_cache(struct kimage *image, void *fdt)
+{
+	int offset, depth, initial_depth, len;
+	void *mem_cache;
+	int size;
+
+	/* Count the elements inside all "mem" properties in the DT */
+	size = offset = depth = initial_depth = 0;
+	for (offset = 0;
+	     offset >= 0 && depth >= initial_depth;
+	     offset = fdt_next_node(fdt, offset, &depth)) {
+		const struct kho_mem *mems;
+
+		mems = fdt_getprop(fdt, offset, "mem", &len);
+		if (!mems || len & (sizeof(*mems) - 1))
+			continue;
+		size += len;
+	}
+
+	/* Allocate based on the max size we determined */
+	mem_cache = kvmalloc(size, GFP_KERNEL);
+	if (!mem_cache)
+		return -ENOMEM;
+
+	/* And populate the array */
+	size = offset = depth = initial_depth = 0;
+	for (offset = 0;
+	     offset >= 0 && depth >= initial_depth;
+	     offset = fdt_next_node(fdt, offset, &depth)) {
+		const struct kho_mem *mems;
+		int nr_mems, i;
+
+		mems = fdt_getprop(fdt, offset, "mem", &len);
+		if (!mems || len & (sizeof(*mems) - 1))
+			continue;
+
+		for (i = 0, nr_mems = len / sizeof(*mems); i < nr_mems; i++) {
+			const struct kho_mem *mem = &mems[i];
+			ulong mstart = PAGE_ALIGN_DOWN(mem->addr);
+			ulong mend = PAGE_ALIGN(mem->addr + mem->len);
+			struct kho_mem cmem = {
+				.addr = mstart,
+				.len = (mend - mstart),
+			};
+
+			size = kho_mem_cache_add(fdt, mem_cache, size, &cmem);
+			if (size < 0)
+				return size;
+		}
+	}
+
+	image->kho.mem_cache.buffer = mem_cache;
+	image->kho.mem_cache.bufsz = size;
+	image->kho.mem_cache.memsz = size;
+
+	return 0;
+}
+
+int kho_fill_kimage(struct kimage *image)
+{
+	int err = 0;
+	void *dt;
+
+	mutex_lock(&kho.lock);
+
+	if (!kho.active)
+		goto out;
+
+	/* Initialize kexec_buf for mem_cache */
+	image->kho.mem_cache = (struct kexec_buf) {
+		.image = image,
+		.buffer = NULL,
+		.bufsz = 0,
+		.mem = KEXEC_BUF_MEM_UNKNOWN,
+		.memsz = 0,
+		.buf_align = SZ_64K, /* Makes it easier to map */
+		.buf_max = ULONG_MAX,
+		.top_down = true,
+	};
+
+	/*
+	 * We need to make all allocations visible here via the mem_cache so that
+	 * kho_is_destination_range() can identify overlapping regions and ensure
+	 * that no kimage (including the DT one) lands on handed over memory.
+	 *
+	 * Since we conveniently already built an array of all allocations, let's
+	 * pass that on to the target kernel so that reuse it to initialize its
+	 * memory blocks.
+	 */
+	err = kho_alloc_mem_cache(image, kho.dt);
+	if (err)
+		goto out;
+
+	err = kexec_add_buffer(&image->kho.mem_cache);
+	if (err)
+		goto out;
+
+	/*
+	 * Create a kexec copy of the DT here. We need this because lifetime may
+	 * be different between kho.dt and the kimage
+	 */
+	dt = kvmemdup(kho.dt, kho.dt_len, GFP_KERNEL);
+	if (!dt) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/* Allocate target memory for kho dt */
+	image->kho.dt = (struct kexec_buf) {
+		.image = image,
+		.buffer = dt,
+		.bufsz = kho.dt_len,
+		.mem = KEXEC_BUF_MEM_UNKNOWN,
+		.memsz = kho.dt_len,
+		.buf_align = SZ_64K, /* Makes it easier to map */
+		.buf_max = ULONG_MAX,
+		.top_down = true,
+	};
+	err = kexec_add_buffer(&image->kho.dt);
+
+out:
+	mutex_unlock(&kho.lock);
+	return err;
+}
+
 bool kho_is_active(void)
 {
 	return kho.active;
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
