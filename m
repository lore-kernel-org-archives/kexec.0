Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B99CD6E57
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 15:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mhbjseTwLH5bkq29znj9WodUduQsJ+dnwL0KiZfm0D0=; b=pZBUmqJB5p1jZpTRnCB1441sVL
	oZv4kqRwZPcOOr/sopkKVZKhDLMmlAw98Uk8IYXTTftlMLpscSow/NsNbwjhGArROC3nJdZsCf8IH
	I6gmc/DkcovocRXRYUgLW7b+bZ9AKbEcdagS6NH1FHFE0BGhKhUJeNFA3637UppnyoUtvLlV+lv7P
	dL/W4Dob4hJLEZ1lk8ZTKTrSfcqPkIyqizRl4aBgGUw/X+uwa+j9iWB5E12oBPAIfvPLUOattFXsB
	TRAlVNl4ErElPEkUaGlcpnjH8R3bvDVL/JbU8UFFQtjOV3eqQs2O6tzYuJ6uiLNOR2vTGlNxCoHe2
	c/guStqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUQs1-0000000DIls-0O4y;
	Tue, 02 Jun 2026 15:17:33 +0000
Received: from canpmsgout04.his.huawei.com ([113.46.200.219])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTzGd-0000000AWxq-2jqK;
	Mon, 01 Jun 2026 09:49:09 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mhbjseTwLH5bkq29znj9WodUduQsJ+dnwL0KiZfm0D0=;
	b=bFXrEAmxNUF6FjQBgDHXLvQgRz1WzTvJpan8xYXPMuWfugdqx4Wk0Iq4YlyEzum2/zn00Si80
	OoGDUvHH6r0WlRCzADhKozhdYN/ZsA3n/2DN5UKl/Z8ZltJVBpyZZVb/hA66rwLSaJ7innpLd3l
	iqivnTTAbyDpUGrGO3E1rrc=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gTTVf21jPz1prLw;
	Mon,  1 Jun 2026 17:41:14 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 86E714048F;
	Mon,  1 Jun 2026 17:49:05 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 1 Jun
 2026 17:49:01 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <rppt@kernel.org>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <ruirui.yang@linux.dev>,
	<rdunlap@infradead.org>, <feng.tang@linux.alibaba.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<kuba@kernel.org>, <lirongqing@baidu.com>, <ebiggers@kernel.org>,
	<paulmck@kernel.org>, <sourabhjain@linux.ibm.com>, <thuth@redhat.com>,
	<ardb@kernel.org>, <masahiroy@kernel.org>, <gshan@redhat.com>,
	<james.morse@arm.com>, <maz@kernel.org>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <coxu@redhat.com>, <suzuki.poulose@arm.com>,
	<cfsworks@gmail.com>, <osandov@fb.com>, <jbohac@suse.cz>,
	<ryan.roberts@arm.com>, <tangyouling@kylinos.cn>, <ritesh.list@gmail.com>,
	<adityag@linux.ibm.com>, <hbathini@linux.ibm.com>, <bjorn@rivosinc.com>,
	<songshuaishuai@tinylab.org>, <vishal.moola@gmail.com>,
	<junhui.liu@pigmoral.tech>, <djordje.todorovic@htecgroup.com>,
	<austin.kim@lge.com>, <namcao@linutronix.de>, <djbw@kernel.org>,
	<chao.gao@intel.com>, <seanjc@google.com>, <fuqiang.wang@easystack.cn>,
	<liaoyuanhong@vivo.com>, <makb@juniper.net>, <graf@amazon.com>,
	<piliu@redhat.com>, <rafael.j.wysocki@intel.com>,
	<mario.limonciello@amd.com>, <jbouron@amazon.com>, <chenjiahao16@huawei.com>,
	<guoren@kernel.org>, <bauerman@linux.ibm.com>, <bgwin@google.com>,
	<takahiro.akashi@linaro.org>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v15 08/23] arm64: kexec_file: Fix image->elf_headers memory leak during retry loop
Date: Mon, 1 Jun 2026 17:47:50 +0800
Message-ID: <20260601094805.2928614-9-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260601094805.2928614-1-ruanjinjie@huawei.com>
References: <20260601094805.2928614-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_024908_037694_065C5C57 
X-CRM114-Status: GOOD (  20.35  )
X-Mailman-Approved-At: Tue, 02 Jun 2026 08:17:11 -0700
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

Sashiko AI code review pointed out a potential memory leak of
image->elf_headers when load_other_segments() fails on error paths.

In the arm64 kexec_file file-load path, kexec_image.c runs a retry loop
calling kexec_add_buffer() to find a suitable location for the kernel
segment. On each iteration, load_other_segments() is invoked to allocate
and populate alternative segments such as initrd, DTB, and ELF headers.

However, if a placement or allocation failure occurs later in
load_other_segments() (e.g., when adding initrd or dtb), the execution
jumps to the out_err label. While this path restores image->nr_segments
via orig_segments, it returns an error back to the caller without freeing
the previously allocated image->elf_headers vmalloc buffer.

As a result, the retry loop in image_load() unconditionally allocates
new ELF headers on the next iteration and overwrites image->elf_headers,
permanently leaking the memory blocks allocated in previous iterations.

To fix this, decouple the ELF header allocation from the target-seeking
retry loop. Since the contents and size of ELF headers only depend on
the host memory layout and do not change with the kernel's physical
placement, move prepare_elf_headers() completely outside and prior to
the while retry loop in image_load().

And if kexec_add_buffer() for elf headers fails, not need to vfree
headers, because the err path will vfree `image->elf_headers` by calling
arch_kimage_file_post_load_cleanup().

This optimization eliminates redundant memory allocation/deallocation
overhead during kexec placement retries and eradicates the Use-After-Free
and memory leak risk.

Concurrently, remove the prepare_elf_headers() call from inside
load_other_segments() and have it directly reuse the single, pre-allocated
image->elf_headers.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Coiby Xu <coxu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Benjamin Gwin <bgwin@google.com>
Cc: stable@vger.kernel.org
Fixes: 108aa503657e ("arm64: kexec_file: try more regions if loading segments fails")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v15:
- Use image->elf_headers and image->elf_headers_sz instead of adding function
  parameters for load_other_segments() to simplify the fix.
---
 arch/arm64/include/asm/kexec.h         |  1 +
 arch/arm64/kernel/kexec_image.c        | 16 ++++++++++++++++
 arch/arm64/kernel/machine_kexec_file.c | 23 +++++------------------
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 892e5bebda95..7ffa2ff5fcfd 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -128,6 +128,7 @@ extern int load_other_segments(struct kimage *image,
 		unsigned long kernel_load_addr, unsigned long kernel_size,
 		char *initrd, unsigned long initrd_len,
 		char *cmdline);
+extern int prepare_elf_headers(void **addr, unsigned long *sz);
 #endif
 
 #endif /* __ASSEMBLER__ */
diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index ffcb7f9075e6..424b9527db09 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -89,6 +89,22 @@ static void *image_load(struct kimage *image,
 
 	kernel_segment_number = image->nr_segments;
 
+#ifdef CONFIG_CRASH_DUMP
+	if (image->type == KEXEC_TYPE_CRASH) {
+		/* load elf core header */
+		unsigned long headers_sz;
+		void *headers;
+
+		ret = prepare_elf_headers(&headers, &headers_sz);
+		if (ret) {
+			pr_err("Preparing elf core header failed\n");
+			return ERR_PTR(ret);
+		}
+		image->elf_headers = headers;
+		image->elf_headers_sz = headers_sz;
+	}
+#endif
+
 	/*
 	 * The location of the kernel segment may make it impossible to satisfy
 	 * the other segment requirements, so we try repeatedly to find a
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 13c247c28866..4cbb71e1f8ed 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -40,7 +40,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 }
 
 #ifdef CONFIG_CRASH_DUMP
-static int prepare_elf_headers(void **addr, unsigned long *sz)
+int prepare_elf_headers(void **addr, unsigned long *sz)
 {
 	struct crash_mem *cmem;
 	unsigned int nr_ranges;
@@ -105,32 +105,19 @@ int load_other_segments(struct kimage *image,
 	kbuf.buf_min = kernel_load_addr + kernel_size;
 
 #ifdef CONFIG_CRASH_DUMP
-	/* load elf core header */
-	void *headers;
-	unsigned long headers_sz;
 	if (image->type == KEXEC_TYPE_CRASH) {
-		ret = prepare_elf_headers(&headers, &headers_sz);
-		if (ret) {
-			pr_err("Preparing elf core header failed\n");
-			goto out_err;
-		}
-
-		kbuf.buffer = headers;
-		kbuf.bufsz = headers_sz;
+		kbuf.buffer = image->elf_headers;
+		kbuf.bufsz = image->elf_headers_sz;
 		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
-		kbuf.memsz = headers_sz;
+		kbuf.memsz = image->elf_headers_sz;
 		kbuf.buf_align = SZ_64K; /* largest supported page size */
 		kbuf.buf_max = ULONG_MAX;
 		kbuf.top_down = true;
 
 		ret = kexec_add_buffer(&kbuf);
-		if (ret) {
-			vfree(headers);
+		if (ret)
 			goto out_err;
-		}
-		image->elf_headers = headers;
 		image->elf_load_addr = kbuf.mem;
-		image->elf_headers_sz = headers_sz;
 
 		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
 			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
-- 
2.34.1


