Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C7B606A320
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GsyDchrG;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Qniwr2Mp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=mfJDf2saZhRyM8lhlYVnrxJjuWkMOyjzX5Pm7gBK9aM=; b=GsyDchrGl2CLIkR4skO6RJlB3W
	QLOSw5T4SB0kx6EXxJ0kTgAvlXPR+KtN9GiMIX67Z8W0sPQosHFW6Ay8Lrg0HObOv5YUGyuP4CC43
	t44AeLMa8v5nzleF07yZaHg7JvzQpILP+j/9cUIPCr/OOWaO4Ju4cNYKSBbOnlZkNkqnT6QUCKQYC
	NVAII0GPm5ZbBX+PLhAqolCZ9XqIpG1mHCPvjZs9By2k//H5vEhzzAaQ7PYN8kmC9Jf4xDuqqEUyw
	XW7Az24Dig4ypXXHgEWujJqw2KtK7sa52tLGz56euduq/B/ztU7ctnnIGvAJK0H3IWUppSnADvIv+
	0oRK1/zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLFWS-00000001sgs-3eYK;
	Mon, 26 Oct 2026 07:53:36 +0000
Received: from [113.46.200.217] (helo=canpmsgout02.his.huawei.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLFWE-00000001sHr-0ZhO;
	Mon, 26 Oct 2026 07:53:24 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mfJDf2saZhRyM8lhlYVnrxJjuWkMOyjzX5Pm7gBK9aM=;
	b=Qniwr2MpK7TJoN1Qu7La4LzKRnHeo01r6FPCPpP3sshmuH6ql6KbjD55Cw/f61CYiRNabI0l/
	6PbkoAJqeToWnCcDZmm3Q5eTDMXEUJFkLUvBtmATOqy0YZvvTK81+hldzY2t/Q06ig7MJ0r+keq
	mgGy9JFFZIHNZY3aNER5I3M=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jCm852YzwzcbTF;
	Mon, 26 Oct 2026 15:53:09 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 598BC40579;
	Mon, 26 Oct 2026 15:53:19 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 26 Oct
 2026 15:53:17 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <rppt@kernel.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <thuth@redhat.com>, <ruanjinjie@huawei.com>,
	<leitao@debian.org>, <yeoreum.yun@arm.com>, <robh@kernel.org>,
	<sourabhjain@linux.ibm.com>, <kees@kernel.org>, <coiby.xu@gmail.com>,
	<Yeking@Red54.com>, <tangyouling@kylinos.cn>, <maqianga@uniontech.com>,
	<zhangtianyang@loongson.cn>, <guodongtai@kylinos.cn>, <blum@kernel.org>,
	<adityag@linux.ibm.com>, <hui.wang@canonical.com>, <sohammetha01@gmail.com>,
	<guoren@kernel.org>, <gaohan@iscas.ac.cn>, <kai.huang@intel.com>,
	<kas@kernel.org>, <vishal.l.verma@intel.com>, <piliu@redhat.com>,
	<jbouron@amazon.com>, <mclapinski@google.com>, <me@linux.beauty>,
	<graf@amazon.com>, <bgwin@google.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <kexec@lists.infradead.org>
Subject: [PATCH v7 13/15] arm64: kexec_file: Use kexec_load_other_segments() to simplify code
Date: Mon, 26 Oct 2026 15:51:59 +0800
Message-ID: <20261026075201.699550-14-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261026075201.699550-1-ruanjinjie@huawei.com>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_005322_634805_C24EE8C5 
X-CRM114-Status: GOOD (  19.07  )
X-Spam-Score: -1.3 (-)
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the local copy with the common helper.

The retry loop stays. And the DTB and the dm-crypt keys move to the setup
hook and the keys are loaded after the initrd now.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/kexec.h         |  5 --
 arch/arm64/kernel/kexec_image.c        | 12 +++-
 arch/arm64/kernel/machine_kexec_file.c | 95 ++++----------------------
 3 files changed, 23 insertions(+), 89 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 892e5bebda95..8fc04e0e7dad 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -123,11 +123,6 @@ extern const struct kexec_file_ops kexec_image_ops;
 
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
 #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
-
-extern int load_other_segments(struct kimage *image,
-		unsigned long kernel_load_addr, unsigned long kernel_size,
-		char *initrd, unsigned long initrd_len,
-		char *cmdline);
 #endif
 
 #endif /* __ASSEMBLER__ */
diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 6ed1991e3142..f5a7f1f92afc 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -44,6 +44,12 @@ static void *image_load(struct kimage *image,
 	struct kexec_buf kbuf = {};
 	unsigned long text_offset, kernel_segment_number;
 	struct kexec_segment *kernel_segment;
+	struct kexec_load_params params = {
+		.initrd = initrd,
+		.initrd_len = initrd_len,
+		.cmdline = cmdline,
+		.cmdline_len = cmdline_len,
+	};
 	int ret;
 
 	/*
@@ -101,9 +107,9 @@ static void *image_load(struct kimage *image,
 	while ((ret = kexec_add_buffer(&kbuf)) == 0) {
 		/* Try to load additional data */
 		kernel_segment = &image->segment[kernel_segment_number];
-		ret = load_other_segments(image, kernel_segment->mem,
-					  kernel_segment->memsz, initrd,
-					  initrd_len, cmdline);
+		params.kernel_load_addr = kernel_segment->mem;
+		params.kernel_size = kernel_segment->memsz;
+		ret = kexec_load_other_segments(image, &params, false);
 		if (!ret)
 			break;
 
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index e7f280915e8d..44754b380bf1 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -63,91 +63,30 @@ int arch_crash_populate_cmem(struct crash_mem *cmem)
 }
 #endif
 
-/*
- * Tries to add the initrd and DTB to the image. If it is not possible to find
- * valid locations, this function will undo changes to the image and return non
- * zero.
- */
-int load_other_segments(struct kimage *image,
-			unsigned long kernel_load_addr,
-			unsigned long kernel_size,
-			char *initrd, unsigned long initrd_len,
-			char *cmdline)
+int arch_kexec_setup_other_segments(struct kimage *image,
+				    struct kexec_load_params *params,
+				    unsigned long initrd_load_addr)
 {
 	struct kexec_buf kbuf = {
 		.image = image,
-		/* not allocate anything below the kernel */
-		.buf_min = kernel_load_addr + kernel_size,
-		.buf_max = ULONG_MAX,
+		.buf_min = params->kernel_load_addr + params->kernel_size,
 	};
-	void *dtb = NULL;
-	unsigned long initrd_load_addr = 0, dtb_len,
-		      orig_segments = image->nr_segments;
-	int ret = 0;
+	unsigned long dtb_len;
+	void *dtb;
+	int ret;
 
-#ifdef CONFIG_CRASH_DUMP
-	/* load elf core header */
 	if (image->type == KEXEC_TYPE_CRASH) {
-		ret = crash_prepare_headers(true, &kbuf.buffer, &kbuf.bufsz, NULL);
-		if (ret) {
-			pr_err("Preparing elf core header failed\n");
-			goto out_err;
-		}
-
-		if (unlikely(image->elf_headers))
-			vfree(image->elf_headers);
-
-		image->elf_headers = kbuf.buffer;
-		image->elf_headers_sz = kbuf.bufsz;
-
-		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
-		kbuf.memsz = kbuf.bufsz;
-		kbuf.buf_align = SZ_64K; /* largest supported page size */
-		kbuf.top_down = true;
-
-		ret = kexec_add_buffer(&kbuf);
-		if (ret)
-			goto out_err;
-
-		image->elf_load_addr = kbuf.mem;
-
-		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
-
 		ret = crash_load_dm_crypt_keys(image);
 		if (ret)
-			goto out_err;
-	}
-#endif
-
-	/* load initrd */
-	if (initrd) {
-		kbuf.buffer = initrd;
-		kbuf.bufsz = initrd_len;
-		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
-		kbuf.memsz = initrd_len;
-		kbuf.buf_align = 0;
-		/* within 1GB-aligned window of up to 32GB in size */
-		kbuf.buf_max = round_down(kernel_load_addr, SZ_1G)
-						+ (unsigned long)SZ_1G * 32;
-		kbuf.top_down = false;
-
-		ret = kexec_add_buffer(&kbuf);
-		if (ret)
-			goto out_err;
-		initrd_load_addr = kbuf.mem;
-
-		kexec_dprintk("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-			      initrd_load_addr, kbuf.bufsz, kbuf.memsz);
+			return ret;
 	}
 
 	/* load dtb */
 	dtb = of_kexec_alloc_and_setup_fdt(image, initrd_load_addr,
-					   initrd_len, cmdline, 0);
+					   params->initrd_len, params->cmdline, 0);
 	if (!dtb) {
 		pr_err("Preparing for new dtb failed\n");
-		ret = -EINVAL;
-		goto out_err;
+		return -EINVAL;
 	}
 
 	/* trim it */
@@ -163,8 +102,10 @@ int load_other_segments(struct kimage *image,
 	kbuf.top_down = true;
 
 	ret = kexec_add_buffer(&kbuf);
-	if (ret)
-		goto out_err;
+	if (ret) {
+		kvfree(dtb);
+		return ret;
+	}
 	image->arch.dtb = dtb;
 	image->arch.dtb_mem = kbuf.mem;
 
@@ -172,12 +113,4 @@ int load_other_segments(struct kimage *image,
 		      kbuf.mem, kbuf.bufsz, kbuf.memsz);
 
 	return 0;
-
-out_err:
-	while (image->nr_segments > orig_segments) {
-		kexec_free_segment_cma(image, image->nr_segments - 1);
-		image->nr_segments--;
-	}
-	kvfree(dtb);
-	return ret;
 }
-- 
2.34.1


