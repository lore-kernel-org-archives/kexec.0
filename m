Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B1F606A31E
	for <kexec@archiver.kernel.org>; Fri, 27 Nov 2026 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WhuPKEZ/;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=UPNi952W;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ralukStp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Y+8esIzy3HGc7baFOxr0J9l5i1aOQIteFiEEQAEe5Wc=; b=WhuPKEZ/H6xDoDw1Gk9O3ndiKZ
	o7/H+Nld+zfAcqreSqlC2grJ7uvSZ4whoczy4TPMrlcfsMhqWwSl+78SO2iVjV4uc90o7aY6y57i+
	DruOC4EbpPsf1eF5XT2OGv4Ms9ig7yXpYGczJ70BBEcaSlG4vJm9VNPnsq4/8u+8PBHYwv0LQoORW
	FxXtr6O+hq+C6/nWsciLpVNuiTYIHOf0UF/Ue7ERgr7QjGSFlqkCY1SqBCjtrr8s2WY9XolgmbclG
	TLKZdjCb7aOlg+z2ILzgPG0buV4gbqFfoZsfOB3UvQahhTKhgqdQMTO4D4H1DkJMBPxhr4iMynHpE
	3iy0Of0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWsuS-0000000FXNi-2Ddi;
	Fri, 27 Nov 2026 10:10:28 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWsuC-0000000FX5z-2RJA;
	Fri, 27 Nov 2026 10:10:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Y+8esIzy3HGc7baFOxr0J9l5i1aOQIteFiEEQAEe5Wc=; b=UPNi952WwyYw3mX5JjxEeH8/zq
	nXQkqgqKcurfzCL0vMlDptpzCfMOHhALl9VeOW/uA11cczoGL7i1NOfjqIkGOgBK5YXTOvsSeLweg
	Lt4uDXqoIoBMQ06SeQNalKdOqTGl+zQNkBttIB2zKRUQNMjUwXXMN3Bt5q8OzZQMdIxeai7V2NGzR
	XzM8IRStgM6u9O1IIDdn/fRksg/1VLua0BD2UVf4nSf+k32CCULfa0E2Fqmr78IZLZL1zZNHl2x8x
	iw/rzbwyXJ4cF892LLujhODv31nnGKgRL7KaC4e3TrryPj3lZc2cfhoDZRBbDZVGh5ZZXAAFQO5GO
	nv+uCvpA==;
Received: from [113.46.200.227] (helo=canpmsgout12.his.huawei.com)
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWsu6-00000007Ysa-1wms;
	Fri, 27 Nov 2026 10:10:11 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Y+8esIzy3HGc7baFOxr0J9l5i1aOQIteFiEEQAEe5Wc=;
	b=ralukStpMnZCFDbjsBNKi23H9eY1q0Ay52QwscAWmLrQ5o4Hvw/ZRgVZV5BhNn7F6HqgzyKk9
	Fm/nX3ahDDG4/8JaE7Buydy1FOnlrXMkK2iOd1mAUlm3kZ73EiJAyJy1yaKuGn1ggbZT1T4G0fm
	Gc47bnfBIesSI/2v9ZkaSFE=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4jbTf35gbbznTWH;
	Fri, 27 Nov 2026 18:08:59 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C6C140561;
	Fri, 27 Nov 2026 18:09:47 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 27 Nov
 2026 18:09:45 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <robh@kernel.org>,
	<saravanak@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ben@cressey.dev>, <leitao@debian.org>, <mpilaniy@redhat.com>,
	<yeoreum.yun@arm.com>, <coiby.xu@gmail.com>, <Yeking@Red54.com>,
	<prudo@redhat.com>, <bradley.morgan@linux.dev>, <sourabhjain@linux.ibm.com>,
	<blum@kernel.org>, <hbathini@linux.ibm.com>, <qirui.001@bytedance.com>,
	<hui.wang@canonical.com>, <sohammetha01@gmail.com>, <guoren@kernel.org>,
	<gaohan@iscas.ac.cn>, <ionut.nechita@windriver.com>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <ardb@kernel.org>,
	<arnd@arndb.de>, <tzimmermann@suse.de>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <mhklinux@outlook.com>, <piliu@redhat.com>,
	<shradhagupta@linux.microsoft.com>, <thuth@redhat.com>,
	<ebiggers@kernel.org>, <me@linux.beauty>, <mclapinski@google.com>,
	<graf@amazon.com>, <tangyouling@kylinos.cn>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v9 03/11] arm64: kexec_file: Load the other segments with common helpers
Date: Fri, 27 Nov 2026 18:09:17 +0800
Message-ID: <20261127100925.3019877-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127100925.3019877-1-ruanjinjie@huawei.com>
References: <20261127100925.3019877-1-ruanjinjie@huawei.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261127_101006_841039_37EEC05E 
X-CRM114-Status: GOOD (  16.41  )
X-Spam-Score: 0.4 (/)
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

Use the common segment helpers to load the elf core header, the initrd
and the DTB instead of open coding them.  The initrd and the command line
come from the image.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/kexec.h         |  4 +-
 arch/arm64/kernel/kexec_image.c        |  3 +-
 arch/arm64/kernel/machine_kexec_file.c | 81 ++++++--------------------
 3 files changed, 20 insertions(+), 68 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 0be042ec22c1..f844fb5fe3ef 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -127,9 +127,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image);
 #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
 
 extern int load_other_segments(struct kimage *image,
-		unsigned long kernel_load_addr, unsigned long kernel_size,
-		char *initrd, unsigned long initrd_len,
-		char *cmdline);
+		unsigned long kernel_load_addr, unsigned long kernel_size);
 #endif
 
 #endif /* __ASSEMBLER__ */
diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index f4ad22447259..a2a7c283b331 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -104,8 +104,7 @@ static void *image_load(struct kimage *image,
 		/* Try to load additional data */
 		kernel_segment = &image->segment[kernel_segment_number];
 		ret = load_other_segments(image, kernel_segment->mem,
-					  kernel_segment->memsz, initrd,
-					  initrd_len, cmdline);
+					  kernel_segment->memsz);
 		if (!ret)
 			break;
 
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 097ee397e949..dff2cd613f87 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -68,54 +68,33 @@ int arch_crash_populate_cmem(struct crash_mem *cmem)
  * valid locations, this function will undo changes to the image and return non
  * zero.
  */
-int load_other_segments(struct kimage *image,
-			unsigned long kernel_load_addr,
-			unsigned long kernel_size,
-			char *initrd, unsigned long initrd_len,
-			char *cmdline)
+int load_other_segments(struct kimage *image, unsigned long kernel_load_addr,
+			unsigned long kernel_size)
 {
-	struct kexec_buf kbuf = {};
+	unsigned long initrd_load_addr = 0, orig_segments = image->nr_segments;
+	struct kexec_buf kbuf = {
+		.image = image,
+		/* not allocate anything below the kernel */
+		.buf_min = kernel_load_addr + kernel_size,
+		.buf_max = ULONG_MAX,
+	};
 	void *dtb = NULL;
-	unsigned long initrd_load_addr = 0, dtb_len,
-		      orig_segments = image->nr_segments;
 	int ret = 0;
 
-	kbuf.image = image;
-	/* not allocate anything below the kernel */
-	kbuf.buf_min = kernel_load_addr + kernel_size;
-
 #ifdef CONFIG_CRASH_DUMP
 	/* load elf core header */
-	void *headers;
-	unsigned long headers_sz;
 	if (image->type == KEXEC_TYPE_CRASH) {
-		ret = crash_prepare_headers(true, &headers, &headers_sz, NULL);
-		if (ret) {
-			pr_err("Preparing elf core header failed\n");
+		ret = kexec_prepare_elf_core_header(image, true, NULL);
+		if (ret)
 			goto out_err;
-		}
 
-		kbuf.buffer = headers;
-		kbuf.bufsz = headers_sz;
-		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
-		kbuf.memsz = headers_sz;
 		kbuf.buf_align = SZ_64K; /* largest supported page size */
-		kbuf.buf_max = ULONG_MAX;
 		kbuf.top_down = true;
+		kbuf.memsz = image->elf_headers_sz;
 
-		ret = kexec_add_buffer(&kbuf);
-		if (ret) {
-			vfree(headers);
+		ret = kexec_add_elf_core_header(image, &kbuf);
+		if (ret)
 			goto out_err;
-		}
-
-		vfree(image->elf_headers);
-		image->elf_headers = headers;
-		image->elf_load_addr = kbuf.mem;
-		image->elf_headers_sz = headers_sz;
-
-		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
 
 		ret = crash_load_dm_crypt_keys(image);
 		if (ret)
@@ -124,56 +103,32 @@ int load_other_segments(struct kimage *image,
 #endif
 
 	/* load initrd */
-	if (initrd) {
-		kbuf.buffer = initrd;
-		kbuf.bufsz = initrd_len;
-		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
-		kbuf.memsz = initrd_len;
+	if (image->initrd_buf) {
 		kbuf.buf_align = 0;
 		/* within 1GB-aligned window of up to 32GB in size */
 		kbuf.buf_max = round_down(kernel_load_addr, SZ_1G)
 						+ (unsigned long)SZ_1G * 32;
 		kbuf.top_down = false;
 
-		ret = kexec_add_buffer(&kbuf);
+		ret = kexec_add_initrd(image, &kbuf);
 		if (ret)
 			goto out_err;
 		initrd_load_addr = kbuf.mem;
-
-		kexec_dprintk("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-			      initrd_load_addr, kbuf.bufsz, kbuf.memsz);
 	}
 
 	/* load dtb */
-	dtb = of_kexec_alloc_and_setup_fdt(image, initrd_load_addr,
-					   initrd_len, cmdline, 0);
-	if (!dtb) {
-		pr_err("Preparing for new dtb failed\n");
-		ret = -EINVAL;
-		goto out_err;
-	}
-
-	/* trim it */
-	fdt_pack(dtb);
-	dtb_len = fdt_totalsize(dtb);
-	kbuf.buffer = dtb;
-	kbuf.bufsz = dtb_len;
-	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
-	kbuf.memsz = dtb_len;
 	/* not across 2MB boundary */
 	kbuf.buf_align = SZ_2M;
 	kbuf.buf_max = ULONG_MAX;
 	kbuf.top_down = true;
 
-	ret = kexec_add_buffer(&kbuf);
+	ret = of_kexec_add_fdt(image, &kbuf, initrd_load_addr,
+			       image->cmdline_buf, &dtb);
 	if (ret)
 		goto out_err;
 	image->arch.dtb = dtb;
 	image->arch.dtb_mem = kbuf.mem;
 
-	kexec_dprintk("Loaded dtb at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-		      kbuf.mem, kbuf.bufsz, kbuf.memsz);
-
 	return 0;
 
 out_err:
-- 
2.34.1


