Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD4E60A2606
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WzCnPozm;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=0/VHn0iE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=IIjwTcz15PyMsksQJ/ixjXOV4ou2zq7XqHr0HTbVuxU=; b=WzCnPozmNHIx/CRHSPeRHzBtwo
	ZwzOBuWrUfPkVTn5MFFyiGffUhIDUZYOPCf0gsMkEFhQaj235silh6HzK1Y1OY/cQtdVcd3mHQq9v
	3t3st8mDcRrsHFi5Y7utxAsQK/H6k+TOdjcm9iCXqmWmGl4U4/HEh9JshcpINjUnixrT3S6KKy0JT
	taA/AvKlULvCToLMFmsWgAYscVmtLIPRbdESj9tJwe2Qfi09NG75GNU3jJwCk6pBrpxSLQ/js6h1O
	7les5OHXAVO3R5SajIWnGL0jD2rQ45A4nOq30MQRf5gltoEOYhCmS/VztCBdZTF7+pprN7SRyzH9r
	ksscv76Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRUx0-0000000A5KA-0HNJ;
	Thu, 12 Nov 2026 13:34:50 +0000
Received: from canpmsgout08.his.huawei.com ([113.46.200.223])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRUwv-0000000A5GA-1mdN;
	Thu, 12 Nov 2026 13:34:47 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IIjwTcz15PyMsksQJ/ixjXOV4ou2zq7XqHr0HTbVuxU=;
	b=0/VHn0iEGb0IPORrcHUCZuDCJqtkFCHQM1NvMeBpdC1cNSBSUA9ZqE98TmpC22IvlErEFnlCh
	h+a12v7jlnaSmyZbkdGSAsEFlj1ySCiupETxSkoDPMfuxOYFM03TJgZiBrMi9ML4/XkTAqnfd9Y
	/SEuLRkPeN9uDFXLxgENIxM=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4jQLvz4gDQzmV8H;
	Thu, 12 Nov 2026 21:34:23 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E9CE4048B;
	Thu, 12 Nov 2026 21:34:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 12 Nov
 2026 21:34:37 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <rppt@kernel.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <ruanjinjie@huawei.com>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <mpilaniy@redhat.com>, <robh@kernel.org>,
	<coiby.xu@gmail.com>, <Yeking@Red54.com>, <prudo@redhat.com>,
	<brads@mainlining.org>, <sourabhjain@linux.ibm.com>, <mkchauras@gmail.com>,
	<blum@kernel.org>, <adityag@linux.ibm.com>, <qirui.001@bytedance.com>,
	<hui.wang@canonical.com>, <sohammetha01@gmail.com>, <guoren@kernel.org>,
	<gaohan@iscas.ac.cn>, <ionut.nechita@windriver.com>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <ardb@kernel.org>,
	<richard.lyu@suse.com>, <arnd@arndb.de>, <tzimmermann@suse.de>,
	<rick.p.edgecombe@intel.com>, <kai.huang@intel.com>, <kas@kernel.org>,
	<piliu@redhat.com>, <thuth@redhat.com>, <shradhagupta@linux.microsoft.com>,
	<ebiggers@kernel.org>, <jbouron@amazon.com>, <me@linux.beauty>,
	<mclapinski@google.com>, <graf@amazon.com>, <tangyouling@kylinos.cn>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>
Subject: [PATCH v8 02/11] kexec: Add helpers to load the elf core header, initrd and FDT
Date: Thu, 12 Nov 2026 21:34:09 +0800
Message-ID: <20261112133418.4044428-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261112133418.4044428-1-ruanjinjie@huawei.com>
References: <20261112133418.4044428-1-ruanjinjie@huawei.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_053446_174838_FC2A7E38 
X-CRM114-Status: GOOD (  18.22  )
X-Spam-Score: -2.1 (--)
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

x86, arm64, LoongArch, RISC-V and powerpc all build an elf core header,
load the initrd by hand before loading the kdump kernel, while arm64 and
RISC-V also duplicate the code that builds the device tree for the kexec
kernel

Add the following 4 helpers for reuse:
- kexec_prepare_elf_core_header() builds the header once per image and
  returns the number of memory ranges, which x86 needs to reserve room
  for the crash hotplug updates.

- kexec_add_elf_core_header() places the prepared header as a segment.
  The caller provides the kexec_buf with its placement policy and the
  size to reserve.  On success it also records the segment index that
  the crash hotplug code uses to find the header.

- kexec_add_initrd() places the initrd from the image with the placement
  policy the caller put into the kexec_buf.

- kexec_add_fdt() builds the device tree for the kexec kernel, packs
  it and places it with the kexec_buf the caller passes in.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Link: https://lore.kernel.org/all/179430504583.425130.15302016434972990362.b4-review@b4/
Suggested-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/linux/kexec.h |  11 +++++
 kernel/kexec_file.c   | 104 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index bac11e940e74..89cb47521d6d 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -258,6 +258,17 @@ int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len);
 
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
 int kexec_locate_mem_hole(struct kexec_buf *kbuf);
+int kexec_add_initrd(struct kimage *image, struct kexec_buf *kbuf);
+#ifdef CONFIG_CRASH_DUMP
+int kexec_prepare_elf_core_header(struct kimage *image, bool need_kernel_map,
+				  unsigned long *nr_ranges);
+int kexec_add_elf_core_header(struct kimage *image, struct kexec_buf *kbuf);
+#endif
+#if defined(CONFIG_OF) && defined(CONFIG_OF_FLATTREE)
+int kexec_add_fdt(struct kimage *image, struct kexec_buf *kbuf,
+		  unsigned long initrd_load_addr, const char *cmdline,
+		  void **fdt);
+#endif
 
 #ifndef arch_kexec_apply_relocations_add
 /*
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 1f128c6e6fa3..25c9bef639d2 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -14,7 +14,9 @@
 #include <linux/file.h>
 #include <linux/slab.h>
 #include <linux/kexec.h>
+#include <linux/libfdt.h>
 #include <linux/memblock.h>
+#include <linux/of.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/fs.h>
@@ -109,6 +111,108 @@ static void kexec_free_elf_headers(struct kimage *image)
 	image->elf_headers_sz = 0;
 }
 
+#ifdef CONFIG_CRASH_DUMP
+int kexec_prepare_elf_core_header(struct kimage *image, bool need_kernel_map,
+				  unsigned long *nr_ranges)
+{
+	int ret;
+
+	if (image->elf_headers)
+		return 0;
+
+	ret = crash_prepare_headers(need_kernel_map, &image->elf_headers,
+				    &image->elf_headers_sz, nr_ranges);
+	if (ret)
+		pr_err("Preparing elf core header failed\n");
+
+	return ret;
+}
+
+int kexec_add_elf_core_header(struct kimage *image, struct kexec_buf *kbuf)
+{
+	unsigned long memsz = kbuf->memsz;
+	int ret;
+
+	kbuf->buffer = image->elf_headers;
+	kbuf->bufsz = image->elf_headers_sz;
+	kbuf->mem = KEXEC_BUF_MEM_UNKNOWN;
+
+	ret = kexec_add_buffer(kbuf);
+	if (ret)
+		return ret;
+
+	image->elf_load_addr = kbuf->mem;
+
+	/* The crash hotplug reservation can exceed the header size. */
+	if (memsz > image->elf_headers_sz) {
+		image->elf_headers_sz = memsz;
+#ifdef CONFIG_CRASH_HOTPLUG
+		image->elfcorehdr_index = image->nr_segments - 1;
+#endif
+	}
+
+	kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		      image->elf_load_addr, kbuf->bufsz, kbuf->memsz);
+
+	return 0;
+}
+#endif /* CONFIG_CRASH_DUMP */
+
+int kexec_add_initrd(struct kimage *image, struct kexec_buf *kbuf)
+{
+	int ret;
+
+	kbuf->buffer = image->initrd_buf;
+	kbuf->bufsz = kbuf->memsz = image->initrd_buf_len;
+	kbuf->mem = KEXEC_BUF_MEM_UNKNOWN;
+
+	ret = kexec_add_buffer(kbuf);
+	if (ret)
+		return ret;
+
+	kexec_dprintk("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		      kbuf->mem, kbuf->bufsz, kbuf->memsz);
+
+	return 0;
+}
+
+#if defined(CONFIG_OF) && defined(CONFIG_OF_FLATTREE)
+int kexec_add_fdt(struct kimage *image, struct kexec_buf *kbuf,
+		  unsigned long initrd_load_addr, const char *cmdline,
+		  void **fdt)
+{
+	void *new_fdt;
+	int ret;
+
+	new_fdt = of_kexec_alloc_and_setup_fdt(image, initrd_load_addr,
+					       image->initrd_buf_len,
+					       cmdline, 0);
+	if (!new_fdt) {
+		pr_err("Preparing for new dtb failed\n");
+		return -EINVAL;
+	}
+
+	fdt_pack(new_fdt);
+
+	kbuf->buffer = new_fdt;
+	kbuf->bufsz = kbuf->memsz = fdt_totalsize(new_fdt);
+	kbuf->mem = KEXEC_BUF_MEM_UNKNOWN;
+
+	ret = kexec_add_buffer(kbuf);
+	if (ret) {
+		kvfree(new_fdt);
+		return ret;
+	}
+
+	*fdt = new_fdt;
+
+	kexec_dprintk("Loaded dtb at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		      kbuf->mem, kbuf->bufsz, kbuf->memsz);
+
+	return 0;
+}
+#endif /* CONFIG_OF && CONFIG_OF_FLATTREE */
+
 /*
  * Free up memory used by kernel, initrd, and command line. This is temporary
  * memory allocation which is not needed any more after these buffers have
-- 
2.34.1


