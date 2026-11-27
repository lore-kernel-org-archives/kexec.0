Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C23606A31E
	for <kexec@archiver.kernel.org>; Fri, 27 Nov 2026 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WnqiL1Vj;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=IC63r5K+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=s8qObomYCecJVouy0UUz+TSdHIjxdSuOA9Xb1SkdQ/Q=; b=WnqiL1VjEqeURnA23j5VEqtwCS
	MjeZbmBgm3jeQ8PdWwpmcr0ggSu/BZp3Issr3OvAI9XPx6t2araky4H4dc4MB/irVtSDiJrGkOt82
	uSRsatbdBLg83KbGDF96i0Tgv8shMv7zpGChCwdlqyAClkrTrFzTrnaOn4RQZIT3sKnIDoAVf37ow
	609fi/FNoMls3k6taopbkrcFLXboT+8+FrK96R4M9TaeuDG0vaaaVsPvXkJhYao8LLC5Z33mSnric
	OC/RWe45fpzBN68rb5Sdw/Hp/32UPHhS4FxyduUHZ+/DR190Cgj1paeUEeM49FBRBV8++7KgI1eWR
	46gBWhAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWsu4-0000000FWwE-3gZA;
	Fri, 27 Nov 2026 10:10:04 +0000
Received: from canpmsgout07.his.huawei.com ([113.46.200.222])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWstu-0000000FWlR-00fq;
	Fri, 27 Nov 2026 10:09:59 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=s8qObomYCecJVouy0UUz+TSdHIjxdSuOA9Xb1SkdQ/Q=;
	b=IC63r5K+Z2IIgXCeb1fWJfUEaEt/dzATCLrM9y9Me68yOdckVKVnal/PNhIqdwEXxEQ+q/biP
	wQqsXtzp+/Y8rPlUAkDBI7aeJ3bi4Ac2zgIh3nXuU3DacCfNqAxSvOIJo2JEk1C94viw/MDyoGZ
	d20+N1HvUWkr0eAYJSE0V3E=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4jbTfX2Xz7zLlY2;
	Fri, 27 Nov 2026 18:09:24 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 7DCD340565;
	Fri, 27 Nov 2026 18:09:49 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 27 Nov
 2026 18:09:47 +0800
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
Subject: [PATCH v9 04/11] LoongArch: kexec_file: Load the other segments with common helpers
Date: Fri, 27 Nov 2026 18:09:18 +0800
Message-ID: <20261127100925.3019877-5-ruanjinjie@huawei.com>
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
X-CRM114-CacheID: sfid-20261127_020954_700609_63C17965 
X-CRM114-Status: GOOD (  17.90  )
X-Spam-Score: -2.8 (--)
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

Use the common segment helpers to load the elf core header and the initrd
instead of open coding them. The initrd and the command line come from
the image.

Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/loongarch/include/asm/kexec.h         |  3 +-
 arch/loongarch/kernel/kexec_efi.c          |  3 +-
 arch/loongarch/kernel/kexec_elf.c          |  3 +-
 arch/loongarch/kernel/machine_kexec_file.c | 71 +++++++---------------
 4 files changed, 25 insertions(+), 55 deletions(-)

diff --git a/arch/loongarch/include/asm/kexec.h b/arch/loongarch/include/asm/kexec.h
index 6be136e9f0a0..b000e97c95f6 100644
--- a/arch/loongarch/include/asm/kexec.h
+++ b/arch/loongarch/include/asm/kexec.h
@@ -51,8 +51,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image);
 #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
 
 extern int load_other_segments(struct kimage *image,
-		unsigned long kernel_load_addr, unsigned long kernel_size,
-		char *initrd, unsigned long initrd_len, char *cmdline, unsigned long cmdline_len);
+		unsigned long kernel_load_addr, unsigned long kernel_size);
 #endif
 
 typedef void (*do_kexec_t)(unsigned long efi_boot,
diff --git a/arch/loongarch/kernel/kexec_efi.c b/arch/loongarch/kernel/kexec_efi.c
index 28a1d0420ba3..4824c47907ac 100644
--- a/arch/loongarch/kernel/kexec_efi.c
+++ b/arch/loongarch/kernel/kexec_efi.c
@@ -77,8 +77,7 @@ static void *efi_kexec_load(struct kimage *image,
 		/* Try to load additional data */
 		kernel_segment = &image->segment[kernel_segment_number];
 		ret = load_other_segments(image, kernel_segment->mem,
-					  kernel_segment->memsz, initrd,
-					  initrd_len, cmdline, cmdline_len);
+					  kernel_segment->memsz);
 		if (!ret)
 			break;
 
diff --git a/arch/loongarch/kernel/kexec_elf.c b/arch/loongarch/kernel/kexec_elf.c
index 1b6b64744c7f..6fda49de330f 100644
--- a/arch/loongarch/kernel/kexec_elf.c
+++ b/arch/loongarch/kernel/kexec_elf.c
@@ -83,8 +83,7 @@ static void *elf_kexec_load(struct kimage *image,
 
 	/* Load additional data */
 	kernel_segment = &image->segment[kernel_segment_number];
-	ret = load_other_segments(image, kernel_segment->mem, kernel_segment->memsz,
-				  initrd, initrd_len, cmdline, cmdline_len);
+	ret = load_other_segments(image, kernel_segment->mem, kernel_segment->memsz);
 	if (ret < 0)
 		goto out;
 
diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
index f16d9ab14726..00940f20b45e 100644
--- a/arch/loongarch/kernel/machine_kexec_file.c
+++ b/arch/loongarch/kernel/machine_kexec_file.c
@@ -115,19 +115,20 @@ static void cmdline_add_elfcorehdr(struct kimage *image, unsigned long *cmdline_
  * locations, this function will undo changes to the image and return non zero.
  */
 int load_other_segments(struct kimage *image,
-			unsigned long kernel_load_addr, unsigned long kernel_size,
-			char *initrd, unsigned long initrd_len, char *cmdline, unsigned long cmdline_len)
+			unsigned long kernel_load_addr, unsigned long kernel_size)
 {
-	int ret = 0;
+	struct kexec_buf kbuf = {
+		.image = image,
+		/* Don't allocate anything below the kernel */
+		.buf_min = kernel_load_addr + kernel_size,
+		.buf_max = ULONG_MAX,
+	};
 	unsigned long cmdline_tmplen = 0;
 	unsigned long initrd_load_addr = 0;
 	unsigned long orig_segments = image->nr_segments;
+	char *cmdline = image->cmdline_buf;
 	char *modified_cmdline = NULL;
-	struct kexec_buf kbuf = {};
-
-	kbuf.image = image;
-	/* Don't allocate anything below the kernel */
-	kbuf.buf_min = kernel_load_addr + kernel_size;
+	int ret = 0;
 
 	modified_cmdline = kzalloc(COMMAND_LINE_SIZE, GFP_KERNEL);
 	if (!modified_cmdline)
@@ -140,79 +141,51 @@ int load_other_segments(struct kimage *image,
 #ifdef CONFIG_CRASH_DUMP
 	/* Load elf core header */
 	if (image->type == KEXEC_TYPE_CRASH) {
-		void *headers;
-		unsigned long headers_sz;
-
-		ret = crash_prepare_headers(true, &headers, &headers_sz, NULL);
-		if (ret < 0) {
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
-		if (ret < 0) {
-			vfree(headers);
+		ret = kexec_add_elf_core_header(image, &kbuf);
+		if (ret)
 			goto out_err;
-		}
-
-		if (unlikely(image->elf_headers))
-			vfree(image->elf_headers);
-
-		image->elf_headers = headers;
-		image->elf_load_addr = kbuf.mem;
-		image->elf_headers_sz = headers_sz;
-
-		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
 
 		/* Add the mem=size@start parameter to the command line */
 		cmdline_add_mem(&cmdline_tmplen, modified_cmdline);
 
 		/* Add the elfcorehdr=size@start parameter to the command line */
-		cmdline_add_elfcorehdr(image, &cmdline_tmplen, modified_cmdline, headers_sz);
+		cmdline_add_elfcorehdr(image, &cmdline_tmplen, modified_cmdline,
+				       image->elf_headers_sz);
 	}
 #endif
 
 	/* Load initrd */
-	if (initrd) {
-		kbuf.buffer = initrd;
-		kbuf.bufsz = initrd_len;
-		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
-		kbuf.memsz = initrd_len;
+	if (image->initrd_buf) {
 		kbuf.buf_align = 0;
 		/* within 1GB-aligned window of up to 32GB in size */
 		kbuf.buf_max = round_down(kernel_load_addr, SZ_1G) + (unsigned long)SZ_1G * 32;
 		kbuf.top_down = false;
 
-		ret = kexec_add_buffer(&kbuf);
-		if (ret < 0)
+		ret = kexec_add_initrd(image, &kbuf);
+		if (ret)
 			goto out_err;
 		initrd_load_addr = kbuf.mem;
 
-		kexec_dprintk("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-			      initrd_load_addr, kbuf.bufsz, kbuf.memsz);
-
 		/* Add the initrd=start,size parameter to the command line */
 		cmdline_add_initrd(image, &cmdline_tmplen, modified_cmdline, initrd_load_addr);
 	}
 
-	if (cmdline_len + cmdline_tmplen > COMMAND_LINE_SIZE) {
+	if (image->cmdline_buf_len + cmdline_tmplen > COMMAND_LINE_SIZE) {
 		pr_err("Appending command line exceeds COMMAND_LINE_SIZE\n");
 		ret = -EINVAL;
 		goto out_err;
 	}
 
-	memcpy(modified_cmdline + cmdline_tmplen, cmdline, cmdline_len);
-	cmdline = modified_cmdline;
-	image->arch.cmdline_ptr = (unsigned long)cmdline;
+	memcpy(modified_cmdline + cmdline_tmplen, cmdline, image->cmdline_buf_len);
+	image->arch.cmdline_ptr = (unsigned long)modified_cmdline;
 
 	return 0;
 
-- 
2.34.1


