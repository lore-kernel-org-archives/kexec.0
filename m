Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD5AC28B30
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 15:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8V+X6vapuQnm7T0BErSGY0fSGWOIaeixziHNtlYjz6I=; b=XpoORpF5V3TQ0eCsKFA7L9Lii6
	Cn275IwYxqm4H83Jwe3rvnuZfHiyh2zRAv9+rPOnruTqx2Jtz6tm77HH+Xxi9xO9i0d1Nsaucz1a+
	UuB8i9ts0Yjx31SQ5/iEHsLkgCK0lbPOXJKTz9mzA9Q6qiMuOBG2qAxDu4niRRAPxFlm+lkPKcPki
	wcO3Hgt9DuAfxV8umOfK9yvgRANf04gCUmsAOyoO/n/2Qa65MlfUu2sukvvT0dubWfEj7aoA+H1El
	llH+kxzFhHsGO8Jm4FjtT8YD7XsbkXcy9Lm2CbHf9VIKvrPI2Xxrrhlpa7dX3z/BCABMbKVaPUj6/
	yHzNZ69w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvHS5-0000000CUDl-433D;
	Thu, 20 Mar 2025 15:04:57 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tv58y-0000000Akih-3VYl
	for kexec@bombadil.infradead.org;
	Thu, 20 Mar 2025 01:56:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8V+X6vapuQnm7T0BErSGY0fSGWOIaeixziHNtlYjz6I=; b=pKhZdfakhDsMso571rmlE3KFjP
	ZZ/XxuYDQHOkEvaW0D2o8Ux184OvoeILHnonnoO4lsgf3yMIcHH7IEFS41zznXptPKdFi5DC89Rcg
	RUNyGEdxW20vWkHkT8wPcGLGr+FjEl1IwK2wB9sVIbGo56isnCJCu83GDt30PN6uJ4cejInGsu7W1
	ISCOH2qm8fcxC1aHHu+Y4zcSJY5bRdn+1AeAL/gOpRCTG5P/3+8nRiDXVQDhqD/F9ivrkUDPjUXxr
	o4ZCCmdz22dZAZm+dqLxxwuqR6AJaVIq72DbutWEBYhsq16e3XziGJaRl3Xn9hGtkZsciqlo2oVWs
	93lEhs5w==;
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tv58v-000000043e6-2zpd
	for kexec@lists.infradead.org;
	Thu, 20 Mar 2025 01:56:23 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2242ade807fso6782515ad.2
        for <kexec@lists.infradead.org>; Wed, 19 Mar 2025 18:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742435776; x=1743040576; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8V+X6vapuQnm7T0BErSGY0fSGWOIaeixziHNtlYjz6I=;
        b=oRt2nd2VCOo1W4ECrttDPJJ51pLAQFkddxUnHvFQ7eFESPrn5tNTVRM+5ET5od/kTu
         WULr8nqQhkMMS7KjC66tY09pg5LIrsGSK7dauwWY33Flm0EpZWi7PQuWx+3WTK2TEzdv
         JxZs0dXwYj29FmKI3gv1pPRqNrmLGb2W5Ogd0Ekfuz40vS8Rol4Y8162IHNDhE97f3iC
         C46chi3d4xs57IUlL+156SOJrgtSH8LmeCfzBbyf0PgqVbJGgrhH3feAEx+U/9rn6LQJ
         xaLxuTKYLdfqvcsREJ0/IdsgwG2XVJWL2ptR7MQ5huse8gr9aMgV6t6w4Ly7v0JX/89I
         5raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742435776; x=1743040576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8V+X6vapuQnm7T0BErSGY0fSGWOIaeixziHNtlYjz6I=;
        b=OME9nzMEOaZG5fffv6TvgscWASTIkPeu9kWa2Bhis58m0b9dFTTjh4hivtVINRU9OI
         Qt0gZDD9fSUJbyRwZXfp7nF+VhO63j0iaHXpMIL40An702cESaoXm/V5Ab9xPu7/jSKh
         3lDDVKA2GmEHBeJZZLQ2WIirO+113aY5RMDQ6bx/0mxmYFigtqHpbAJKOUFK/61y88UF
         l3ll9JqO6TEUYPC7OdcNZXvoOiIi7xWh3m4G3asPkMGtfFlPt1bQy4s1CsRqsU9RR/PJ
         PiIdOMixz1iuzon6WTE2l7VifWlR0RcSoXh1N6zi3TriJfWSrPgB+vKgmNCHmhMHxqU4
         nx8w==
X-Forwarded-Encrypted: i=1; AJvYcCXxClNvq5inJGK9WPDUzWf7hloZeB+PhvNGD+viVGfWQckAjko4r5aZpDdbQYK068eCeTOjNg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyhOUMBO/4QL1tVsjjeUl5hxg/jndjU1OkHeKPbm5Gwd2j5qm4C
	dUt01CISih5qX4d5t5vEAAJG89Xgfk92rVY+au0J0Awm5WmpNVSGhYRRdr6vD2UYHg994ZFL7t8
	BpD24YP+P6KmTiSx2cQ==
X-Google-Smtp-Source: AGHT+IEM1zhUI4aB8FBWWC+mYMClc6ahuDGj6ZxX8EDQ9DE5DKRFOEqA+5eaTn1Hw9R605eYXv4+w1iX7+c1hN7N
X-Received: from pltk7.prod.google.com ([2002:a17:902:6947:b0:223:6930:304e])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:db0a:b0:223:f408:c3f7 with SMTP id d9443c01a7336-2265edc7b36mr19232405ad.16.1742435776171;
 Wed, 19 Mar 2025 18:56:16 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:55:45 -0700
In-Reply-To: <20250320015551.2157511-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320015551.2157511-11-changyuanl@google.com>
Subject: [PATCH v5 10/16] kexec: add KHO support to kexec file loads
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	dave.hansen@linux.intel.com, dwmw2@infradead.org, ebiederm@xmission.com, 
	mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, krzk@kernel.org, 
	rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org, tglx@linutronix.de, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, will@kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, x86@kernel.org, Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_015621_879775_77F83A7F 
X-CRM114-Status: GOOD (  25.44  )
X-Mailman-Approved-At: Thu, 20 Mar 2025 08:04:44 -0700
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

From: Alexander Graf <graf@amazon.com>

Kexec has 2 modes: A user space driven mode and a kernel driven mode.
For the kernel driven mode, kernel code determines the physical
addresses of all target buffers that the payload gets copied into.

With KHO, we can only safely copy payloads into the "scratch area".
Teach the kexec file loader about it, so it only allocates for that
area. In addition, enlighten it with support to ask the KHO subsystem
for its respective payloads to copy into target memory. Also teach the
KHO subsystem how to fill the images for file loads.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 include/linux/kexec.h   |   7 +++
 kernel/kexec_core.c     |   4 ++
 kernel/kexec_file.c     |  19 +++++++
 kernel/kexec_handover.c | 108 ++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_internal.h |  18 +++++++
 5 files changed, 156 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index fad04f3bcf1d..d59eee60e36e 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -364,6 +364,13 @@ struct kimage {
 	size_t ima_buffer_size;
 #endif
 
+#ifdef CONFIG_KEXEC_HANDOVER
+	struct {
+		struct kexec_segment *scratch;
+		struct kexec_segment *fdt;
+	} kho;
+#endif
+
 	/* Core ELF header buffer */
 	void *elf_headers;
 	unsigned long elf_headers_sz;
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 640d252306ea..67fb9c0b3714 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1053,6 +1053,10 @@ int kernel_kexec(void)
 		goto Unlock;
 	}
 
+	error = kho_copy_fdt(kexec_image);
+	if (error)
+		goto Unlock;
+
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
 		/*
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3eedb8c226ad..070ef206f573 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -253,6 +253,11 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	/* IMA needs to pass the measurement list to the next kernel. */
 	ima_add_kexec_buffer(image);
 
+	/* If KHO is active, add its images to the list */
+	ret = kho_fill_kimage(image);
+	if (ret)
+		goto out;
+
 	/* Call image load handler */
 	ldata = kexec_image_load_default(image);
 
@@ -636,6 +641,14 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
 	if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN)
 		return 0;
 
+	/*
+	 * If KHO is active, only use KHO scratch memory. All other memory
+	 * could potentially be handed over.
+	 */
+	ret = kho_locate_mem_hole(kbuf, locate_mem_hole_callback);
+	if (ret <= 0)
+		return ret;
+
 	if (!IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
 		ret = kexec_walk_resources(kbuf, locate_mem_hole_callback);
 	else
@@ -764,6 +777,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
 		if (ksegment->kbuf == pi->purgatory_buf)
 			continue;
 
+#ifdef CONFIG_KEXEC_HANDOVER
+		/* Skip KHO FDT as its contects are copied in kernel_kexec(). */
+		if (ksegment == image->kho.fdt)
+			continue;
+#endif
+
 		ret = crypto_shash_update(desc, ksegment->kbuf,
 					  ksegment->bufsz);
 		if (ret)
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 592563c21369..5108e2cc1a22 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -245,6 +245,85 @@ int kho_node_check_compatible(const struct kho_in_node *node,
 }
 EXPORT_SYMBOL_GPL(kho_node_check_compatible);
 
+int kho_fill_kimage(struct kimage *image)
+{
+	ssize_t scratch_size;
+	int err = 0;
+
+	if (!kho_enable)
+		return 0;
+
+	/* Allocate target memory for KHO FDT */
+	struct kexec_buf fdt = {
+		.image = image,
+		.buffer = NULL,
+		.bufsz = 0,
+		.mem = KEXEC_BUF_MEM_UNKNOWN,
+		.memsz = kho_out.fdt_max,
+		.buf_align = SZ_64K, /* Makes it easier to map */
+		.buf_max = ULONG_MAX,
+		.top_down = true,
+	};
+	err = kexec_add_buffer(&fdt);
+	if (err) {
+		pr_err("failed to reserved a segment for KHO FDT: %d\n", err);
+		return err;
+	}
+	image->kho.fdt = &image->segment[image->nr_segments - 1];
+
+	scratch_size = sizeof(*kho_scratch) * kho_scratch_cnt;
+	struct kexec_buf scratch = {
+		.image = image,
+		.buffer = kho_scratch,
+		.bufsz = scratch_size,
+		.mem = KEXEC_BUF_MEM_UNKNOWN,
+		.memsz = scratch_size,
+		.buf_align = SZ_64K, /* Makes it easier to map */
+		.buf_max = ULONG_MAX,
+		.top_down = true,
+	};
+	err = kexec_add_buffer(&scratch);
+	if (err)
+		return err;
+	image->kho.scratch = &image->segment[image->nr_segments - 1];
+
+	return 0;
+}
+
+static int kho_walk_scratch(struct kexec_buf *kbuf,
+			    int (*func)(struct resource *, void *))
+{
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < kho_scratch_cnt; i++) {
+		struct resource res = {
+			.start = kho_scratch[i].addr,
+			.end = kho_scratch[i].addr + kho_scratch[i].size - 1,
+		};
+
+		/* Try to fit the kimage into our KHO scratch region */
+		ret = func(&res, kbuf);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+int kho_locate_mem_hole(struct kexec_buf *kbuf,
+			int (*func)(struct resource *, void *))
+{
+	int ret;
+
+	if (!kho_enable || kbuf->image->type == KEXEC_TYPE_CRASH)
+		return 1;
+
+	ret = kho_walk_scratch(kbuf, func);
+
+	return ret == 1 ? 0 : -EADDRNOTAVAIL;
+}
+
 /*
  * Keep track of memory that is to be preserved across KHO.
  *
@@ -1141,6 +1220,35 @@ static int kho_finalize(void)
 	return err;
 }
 
+int kho_copy_fdt(struct kimage *image)
+{
+	int err = 0;
+	void *fdt;
+
+	if (!kho_enable || !image->file_mode)
+		return 0;
+
+	if (!kho_out.fdt) {
+		err = kho_finalize();
+		kho_out_update_debugfs_fdt();
+		if (err)
+			return err;
+	}
+
+	fdt = kimage_map_segment(image, image->kho.fdt->mem,
+				 PAGE_ALIGN(kho_out.fdt_max));
+	if (!fdt) {
+		pr_err("failed to vmap fdt ksegment in kimage\n");
+		return -ENOMEM;
+	}
+
+	memcpy(fdt, kho_out.fdt, fdt_totalsize(kho_out.fdt));
+
+	kimage_unmap_segment(fdt);
+
+	return 0;
+}
+
 /* Handling for debug/kho/out */
 static int kho_out_finalize_get(void *data, u64 *val)
 {
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index d35d9792402d..ec9555a4751d 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -39,4 +39,22 @@ extern size_t kexec_purgatory_size;
 #else /* CONFIG_KEXEC_FILE */
 static inline void kimage_file_post_load_cleanup(struct kimage *image) { }
 #endif /* CONFIG_KEXEC_FILE */
+
+struct kexec_buf;
+
+#ifdef CONFIG_KEXEC_HANDOVER
+int kho_locate_mem_hole(struct kexec_buf *kbuf,
+			int (*func)(struct resource *, void *));
+int kho_fill_kimage(struct kimage *image);
+int kho_copy_fdt(struct kimage *image);
+#else
+static inline int kho_locate_mem_hole(struct kexec_buf *kbuf,
+				      int (*func)(struct resource *, void *))
+{
+	return 1;
+}
+
+static inline int kho_fill_kimage(struct kimage *image) { return 0; }
+static inline int kho_copy_fdt(struct kimage *image) { return 0; }
+#endif /* CONFIG_KEXEC_HANDOVER */
 #endif /* LINUX_KEXEC_INTERNAL_H */
-- 
2.48.1.711.g2feabab25a-goog


