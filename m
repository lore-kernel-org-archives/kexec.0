Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD80D606A68D
	for <kexec@archiver.kernel.org>; Fri, 27 Nov 2026 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hFvU1AIV;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xHdaySEE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=o2JgAdhOUezhb7GopSWs/4mAyB0d8SaoL2siDpc178w=; b=hFvU1AIVopkYXXIz+OlNCPstuG
	zQiL6VSjS0xK+T26YzwopwqNuhSAR77U1mElU16C2nRAB7lnOwr7bHejXJXjNvS72J4GBLLpnd6GU
	CiAEcSZhmq95fjbHer0kHZHWLRnOGcinDaCTTUhd9U769oCIMHFvDl3QXVy01rNrrLcsqX7Etdq9a
	7Q09gc7aRSz3aYf5Q/GHSHg9OkAPq5i5kd7IBzbwGu3wmZZiXQHqS1HCsbxseBwoQqYU6BBZT6E2u
	BDK9Aa0Fb0fZbwmgP6n7wb0r6UDawsnu4eUmK9JGtSjg6bGK3FXzv6AQXKLDrBPbqa1AO41lwj/6S
	6AZ3vuBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWsu1-0000000FWsU-1Wky;
	Fri, 27 Nov 2026 10:10:01 +0000
Received: from canpmsgout06.his.huawei.com ([113.46.200.221])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWstq-0000000FWjK-1AQi;
	Fri, 27 Nov 2026 10:09:57 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=o2JgAdhOUezhb7GopSWs/4mAyB0d8SaoL2siDpc178w=;
	b=xHdaySEEyaH0POGVQRnc6Wwb+5tU4iQ95bHxmODrOZ/ParLiLSPPewxEFFlP+rhAjn6FbYlDS
	od8iQIoyVKC5Kds2HldEFZJtEnscS9UBTt0/RV+odveJO6GIJBF/xMr/St4Q7GiIu5vPxjhszxy
	usVJenJk4IgG9aFFrNB/9X0=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4jbTfY6GyBzRhRf;
	Fri, 27 Nov 2026 18:09:25 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id B875940561;
	Fri, 27 Nov 2026 18:09:45 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 27 Nov
 2026 18:09:43 +0800
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
Subject: [PATCH v9 02/11] kexec: Add helpers to load the elf core header, initrd and FDT
Date: Fri, 27 Nov 2026 18:09:16 +0800
Message-ID: <20261127100925.3019877-3-ruanjinjie@huawei.com>
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
X-CRM114-CacheID: sfid-20261127_020950_977784_BB5BE727 
X-CRM114-Status: GOOD (  16.57  )
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

arm64, LoongArch and RISC-V load the kdump kernel's elf core header and
initrd by hand, and arm64 and RISC-V also build the device tree for the
kexec kernel and place it as a segment.  Add helpers for them so that
every architecture keeps its own placement policy, which the caller
puts into the kexec_buf:

- kexec_prepare_elf_core_header() builds the header once per image and
  returns the number of memory ranges, which x86 needs to size its
  crash hotplug reservation.

- kexec_add_elf_core_header() places the prepared header as a segment.
  The caller provides the kexec_buf with its placement policy and the
  size to reserve: x86 and powerpc put their crash hotplug reservation
  there, the other architectures the header size.

- kexec_add_initrd() places the initrd from the image.

- of_kexec_add_fdt() builds the device tree for the kexec kernel, packs
  it and places it.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Suggested-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/of/kexec.c    | 35 +++++++++++++++++++++++++
 include/linux/kexec.h |  6 +++++
 include/linux/of.h    |  4 +++
 kernel/kexec_file.c   | 60 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 105 insertions(+)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index bb4e0d9bfd38..a6f07c33fc40 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -533,3 +533,38 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 
 	return fdt;
 }
+
+int of_kexec_add_fdt(struct kimage *image, struct kexec_buf *kbuf,
+		     unsigned long initrd_load_addr, const char *cmdline,
+		     void **fdt)
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
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index bac11e940e74..491046a90ffa 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -258,6 +258,12 @@ int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len);
 
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
 int kexec_locate_mem_hole(struct kexec_buf *kbuf);
+int kexec_add_initrd(struct kimage *image, struct kexec_buf *kbuf);
+#ifdef CONFIG_CRASH_DUMP
+int kexec_prepare_elf_core_header(struct kimage *image, bool need_kernel_map,
+				  unsigned long *nr_ranges);
+int kexec_add_elf_core_header(struct kimage *image, struct kexec_buf *kbuf);
+#endif
 
 #ifndef arch_kexec_apply_relocations_add
 /*
diff --git a/include/linux/of.h b/include/linux/of.h
index 44d83133a65a..5934097e7a21 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -480,10 +480,14 @@ int of_map_msi_id(const struct device_node *np, u32 id,
 phys_addr_t of_dma_get_max_cpu_address(struct device_node *np);
 
 struct kimage;
+struct kexec_buf;
 void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 				   unsigned long initrd_load_addr,
 				   unsigned long initrd_len,
 				   const char *cmdline, size_t extra_fdt_size);
+int of_kexec_add_fdt(struct kimage *image, struct kexec_buf *kbuf,
+		     unsigned long initrd_load_addr, const char *cmdline,
+		     void **fdt);
 #else /* CONFIG_OF */
 
 static inline void of_core_init(void)
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 1f128c6e6fa3..66f389346c2b 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -109,6 +109,66 @@ static void kexec_free_elf_headers(struct kimage *image)
 	image->elf_headers_sz = 0;
 }
 
+#ifdef CONFIG_CRASH_DUMP
+int kexec_prepare_elf_core_header(struct kimage *image, bool need_kernel_map,
+				  unsigned long *nr_ranges)
+{
+	int ret;
+
+	/*
+	 * The header does not depend on where the segments are placed, so
+	 * the loaders' placement retries can reuse the same build.
+	 */
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
 /*
  * Free up memory used by kernel, initrd, and command line. This is temporary
  * memory allocation which is not needed any more after these buffers have
-- 
2.34.1


