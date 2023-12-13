Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB876C4332F
	for <kexec@archiver.kernel.org>; Wed, 13 Dec 2023 05:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZqsQeFdYURCNK95mfG0fmDY2JJBVqDZ7TwOR3KYTEuA=; b=MIRK1kwk5K43hG
	HgptIM5TmqCuUhn/YZ0/JSvSljCWuiXUiCVIJrctIkw4k47gGYWBCsw3Yf6RNQn8b8HmwxH96ma78
	cTYJJLDlFGyiRaEZhYELhr2ZZGJDsPqf/HpgGVh5vJk0oMB6m2YiY4QaUlE28/KB+3IqbLkwn1htM
	xDS6UFzehtAVNsXqYQO8Ic7Ezi6nAxGFtsgOTaZwMkzb6KUa04TLQomsA1ce6+y3rzrmw6jlHE798
	96vG8xIPFfILQOK42MjTEAveaT3LKjqoq3spGWm7YVXpkb5L2OtTLidiRkrHrUHBQs93CHHtECV9d
	3z87qBaiEGIoIPaNGLLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDIGZ-00DhNA-1H;
	Wed, 13 Dec 2023 05:58:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDIGV-00DhHV-0p
	for kexec@lists.infradead.org;
	Wed, 13 Dec 2023 05:58:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702447118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u+nizh1tMPmgMi9rWLcfDIJVZXo890tgFXcJI8oK+Eg=;
	b=EFb7wdI1UXklGhK1eMk4ceYD5hl6nS+mhE0Sfwlqc8ngG5Q5dyYfdcaLiaN6c+E2phV2zt
	/rOmXOmarCDTcEBY4O7uxWKH67qKePc0e/KuEdN0wPimHktvPaFrxG3Zj4uULGTnlCP6Gk
	+AdaBqrVicgtDFpQDHzXb5ST8cJwgN8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-Zj51puNjOzqeoSuykk6hJg-1; Wed,
 13 Dec 2023 00:58:30 -0500
X-MC-Unique: Zj51puNjOzqeoSuykk6hJg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FB7A3C40B50;
	Wed, 13 Dec 2023 05:58:30 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.83])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9508A1C060AF;
	Wed, 13 Dec 2023 05:58:24 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-parisc@vger.kernel.org,
	akpm@linux-foundation.org,
	joe@perches.com,
	nathan@kernel.org,
	conor@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 6/7] kexec_file, power: print out debugging message if required
Date: Wed, 13 Dec 2023 13:57:46 +0800
Message-ID: <20231213055747.61826-7-bhe@redhat.com>
In-Reply-To: <20231213055747.61826-1-bhe@redhat.com>
References: <20231213055747.61826-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_215839_399963_6216C1ED 
X-CRM114-Status: GOOD (  13.00  )
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

Then when specifying '-d' for kexec_file_load interface, loaded
locations of kernel/initrd/cmdline etc can be printed out to help
debug.

Here replace pr_debug() with the newly added kexec_dprintk() in
kexec_file loading related codes.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/powerpc/kexec/elf_64.c       |  8 ++++----
 arch/powerpc/kexec/file_load_64.c | 18 +++++++++---------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
index eeb258002d1e..904016cf89ea 100644
--- a/arch/powerpc/kexec/elf_64.c
+++ b/arch/powerpc/kexec/elf_64.c
@@ -59,7 +59,7 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 	if (ret)
 		goto out;
 
-	pr_debug("Loaded the kernel at 0x%lx\n", kernel_load_addr);
+	kexec_dprintk("Loaded the kernel at 0x%lx\n", kernel_load_addr);
 
 	ret = kexec_load_purgatory(image, &pbuf);
 	if (ret) {
@@ -67,7 +67,7 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 		goto out;
 	}
 
-	pr_debug("Loaded purgatory at 0x%lx\n", pbuf.mem);
+	kexec_dprintk("Loaded purgatory at 0x%lx\n", pbuf.mem);
 
 	/* Load additional segments needed for panic kernel */
 	if (image->type == KEXEC_TYPE_CRASH) {
@@ -99,7 +99,7 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 			goto out;
 		initrd_load_addr = kbuf.mem;
 
-		pr_debug("Loaded initrd at 0x%lx\n", initrd_load_addr);
+		kexec_dprintk("Loaded initrd at 0x%lx\n", initrd_load_addr);
 	}
 
 	fdt = of_kexec_alloc_and_setup_fdt(image, initrd_load_addr,
@@ -132,7 +132,7 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 
 	fdt_load_addr = kbuf.mem;
 
-	pr_debug("Loaded device tree at 0x%lx\n", fdt_load_addr);
+	kexec_dprintk("Loaded device tree at 0x%lx\n", fdt_load_addr);
 
 	slave_code = elf_info.buffer + elf_info.proghdrs[0].p_offset;
 	ret = setup_purgatory_ppc64(image, slave_code, fdt, kernel_load_addr,
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 961a6dd67365..5b4c5cb23354 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -577,7 +577,7 @@ static int add_usable_mem_property(void *fdt, struct device_node *dn,
 		       NODE_PATH_LEN, dn);
 		return -EOVERFLOW;
 	}
-	pr_debug("Memory node path: %s\n", path);
+	kexec_dprintk("Memory node path: %s\n", path);
 
 	/* Now that we know the path, find its offset in kdump kernel's fdt */
 	node = fdt_path_offset(fdt, path);
@@ -590,8 +590,8 @@ static int add_usable_mem_property(void *fdt, struct device_node *dn,
 	/* Get the address & size cells */
 	n_mem_addr_cells = of_n_addr_cells(dn);
 	n_mem_size_cells = of_n_size_cells(dn);
-	pr_debug("address cells: %d, size cells: %d\n", n_mem_addr_cells,
-		 n_mem_size_cells);
+	kexec_dprintk("address cells: %d, size cells: %d\n", n_mem_addr_cells,
+		      n_mem_size_cells);
 
 	um_info->idx  = 0;
 	if (!check_realloc_usable_mem(um_info, 2)) {
@@ -664,7 +664,7 @@ static int update_usable_mem_fdt(void *fdt, struct crash_mem *usable_mem)
 
 	node = fdt_path_offset(fdt, "/ibm,dynamic-reconfiguration-memory");
 	if (node == -FDT_ERR_NOTFOUND)
-		pr_debug("No dynamic reconfiguration memory found\n");
+		kexec_dprintk("No dynamic reconfiguration memory found\n");
 	else if (node < 0) {
 		pr_err("Malformed device tree: error reading /ibm,dynamic-reconfiguration-memory.\n");
 		return -EINVAL;
@@ -776,8 +776,8 @@ static void update_backup_region_phdr(struct kimage *image, Elf64_Ehdr *ehdr)
 	for (i = 0; i < ehdr->e_phnum; i++) {
 		if (phdr->p_paddr == BACKUP_SRC_START) {
 			phdr->p_offset = image->arch.backup_start;
-			pr_debug("Backup region offset updated to 0x%lx\n",
-				 image->arch.backup_start);
+			kexec_dprintk("Backup region offset updated to 0x%lx\n",
+				      image->arch.backup_start);
 			return;
 		}
 	}
@@ -850,7 +850,7 @@ int load_crashdump_segments_ppc64(struct kimage *image,
 		pr_err("Failed to load backup segment\n");
 		return ret;
 	}
-	pr_debug("Loaded the backup region at 0x%lx\n", kbuf->mem);
+	kexec_dprintk("Loaded the backup region at 0x%lx\n", kbuf->mem);
 
 	/* Load elfcorehdr segment - to export crashing kernel's vmcore */
 	ret = load_elfcorehdr_segment(image, kbuf);
@@ -858,8 +858,8 @@ int load_crashdump_segments_ppc64(struct kimage *image,
 		pr_err("Failed to load elfcorehdr segment\n");
 		return ret;
 	}
-	pr_debug("Loaded elf core header at 0x%lx, bufsz=0x%lx memsz=0x%lx\n",
-		 image->elf_load_addr, kbuf->bufsz, kbuf->memsz);
+	kexec_dprintk("Loaded elf core header at 0x%lx, bufsz=0x%lx memsz=0x%lx\n",
+		      image->elf_load_addr, kbuf->bufsz, kbuf->memsz);
 
 	return 0;
 }
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
