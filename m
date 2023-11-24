Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3A3C61DF4
	for <kexec@archiver.kernel.org>; Fri, 24 Nov 2023 03:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xWEXXKtta29FYv/GmbVJ/rur+hoEm4qaBjAjeU5KjGs=; b=K5+ucBXFUx8y2k
	cYbjK0SxYutHYG0OrPvomUUO/JrSMM6yiG5AdqH+KzgDdN8Mb2e+9/Tgd47TOHQeQa868jA3Oz40P
	9mE+H1dwoFHo5Lclwmjbn/ldn2flafuriURgu3reOqZDtfC/AjuNPLURvjJ520VfQnq7w7QVPUDCE
	LrunuhjE7e7tKIY/XcrMUKLAgJ0Bl9FlM/DGiFCBJ7Gb13GA/Nx66sp2LYNKsfjErP9s4Qu6pu6vc
	ZVA7hOX973NyNY9Aq/X0bTdtpqOhmA5SzNH7orqXUNwEejOZNAr8/ajK/+qAbxelSlIgcNw4WSVGD
	HhUkeaNC9LiV7Z6wfGsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6N0L-0062v6-0a;
	Fri, 24 Nov 2023 03:37:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r6N08-0062lo-0D
	for kexec@lists.infradead.org;
	Fri, 24 Nov 2023 03:37:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700797025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ypSBKOvs5nashSP3TmwrugZ2AS56bQmFrg9V7LWlVpY=;
	b=Xen9/vqUcXTjeAEzkIGTj9MegRd9tQQLTc29SEtFrd/81kdE5xoG0QpErnQjCP506rQ3dx
	T21OC0jHh5NXpjK3bqchrdaA0RLot0Sk02b+KHTdEasJsx+GBbnmJEYoPiD29L4oiyEyZ+
	q8BEWr+kkFqaNDlPthYUUe6GbYFhHH8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-j-to0uXUNdemQMs-yqzn9w-1; Thu,
 23 Nov 2023 22:37:00 -0500
X-MC-Unique: j-to0uXUNdemQMs-yqzn9w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF59B1C0434A;
	Fri, 24 Nov 2023 03:36:59 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.8])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 61AAB492BE7;
	Fri, 24 Nov 2023 03:36:55 +0000 (UTC)
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
	yujie.liu@intel.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 2/7] kexec_file: print out debugging message if required
Date: Fri, 24 Nov 2023 11:36:37 +0800
Message-ID: <20231124033642.520686-3-bhe@redhat.com>
In-Reply-To: <20231124033642.520686-1-bhe@redhat.com>
References: <20231124033642.520686-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231123_193708_213154_CA30CA67 
X-CRM114-Status: GOOD (  12.44  )
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

Replace pr_debug() with the newly added kexec_dprintk() in kexec_file
loading related codes.

And also print out type/start/head of kimage and flags to help debug.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c                | 5 ++++-
 kernel/kexec_file.c                | 7 ++++++-
 security/integrity/ima/ima_kexec.c | 2 +-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index efe87d501c8c..1485fd7bb67f 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -551,9 +551,12 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
 		phdr->p_align = 0;
 		ehdr->e_phnum++;
-		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
+#ifdef CONFIG_KEXEC_FILE
+		kexec_dprintk("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, "
+			"sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
 			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
 			ehdr->e_phnum, phdr->p_offset);
+#endif
 		phdr++;
 	}
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 4c35500ae40a..7ae1b0901aa4 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -206,6 +206,8 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	if (ret < 0)
 		return ret;
 	image->kernel_buf_len = ret;
+	kexec_dprintk("kernel: %p kernel_size: %#lx\n",
+		      image->kernel_buf, image->kernel_buf_len);
 
 	/* Call arch image probe handlers */
 	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
@@ -389,11 +391,12 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	if (ret)
 		goto out;
 
+	kexec_dprintk("nr_segments = %lu\n", image->nr_segments);
 	for (i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
 		ksegment = &image->segment[i];
-		pr_debug("Loading segment %d: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
+		kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
 			 i, ksegment->buf, ksegment->bufsz, ksegment->mem,
 			 ksegment->memsz);
 
@@ -408,6 +411,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	if (ret)
 		goto out;
 
+	kexec_dprintk("kexec_file_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
+		      image->type, image->start, image->head, flags);
 	/*
 	 * Free up any temporary buffers allocated which are not needed
 	 * after image has been loaded
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index ad133fe120db..e692624bcab3 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -129,7 +129,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 	image->ima_buffer_size = kexec_segment_size;
 	image->ima_buffer = kexec_buffer;
 
-	pr_debug("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
+	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
 		 kbuf.mem);
 }
 #endif /* IMA_KEXEC */
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
