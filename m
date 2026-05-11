Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFB0CD4F25
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 17:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bkxe1gWAGH8v6l2qZowllal6MfxGYJCDA5QU/w0N+nk=; b=VTb615MXAkR+P5OThhp5lJFh7A
	At2fgAYHxH+7w82RFGaQn+jQX1URDbnnYd8dBEx14tn6N2hfZjzVr+D36ChW8TX2jAmvDcjEAS666
	l+4aOCPy2AnvQPqMRK0MzR7emr2HR2+OGGEkWGLONiZx4sdAYDG9LjI3qTIlUXiXoeh1HEJuLAz5i
	PCq9TtoQDleGgCa4sKAnrfQ2tMfUCO7uVtnfbCzdDn+kMCr5m0iy5q6DT65XIN3TIAtgusEwCv2oJ
	mCCz2MAcCY7cKp1fbPs4b99YYxDTF1LwI8yeprsbogS4XWg/pmS1nfMr4nRvuHbM093grpQNUmtEn
	zo5tDVMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMrLL-0000000019w-2MIo;
	Tue, 12 May 2026 17:56:31 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMGyM-0000000C6xH-1Kux;
	Mon, 11 May 2026 03:06:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=Bkxe1gWAGH8v6l2qZowllal6MfxGYJCDA5QU/w0N+nk=; b=p05hPdV6KOYOYg1SUgJXF5j8++
	aXPvT2s47cCAGfYsviCHcaAPZGlxrG0/hsAJb4N7IuPuKPwFNW735YLhIDoIWGPqFHmxbAhxkPUrA
	MySrWtgdWqONQiuWHyb7SBJ9d45jwdcABINkEPCVSw3XlfdufcywKC/5USbF38Me5o2Wj2sgW+9iz
	xrJhaLXdMhEKC9Xjr4Yn3zgPy2v1GA7/fJbYjjOhu2dQ1EjnAIMSRTcVcbw1O/0maK/81aatdRPXW
	XU6Mrj1B/Rb4vpFiPQmlZJm5ufz0r/zqlpk98yzvOGnXPb3BSsvRcJgvJhfe8bA2I9qDMTMxSlpMZ
	Hk79hKVw==;
Received: from canpmsgout02.his.huawei.com ([113.46.200.217])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMGyH-0000000AV1e-3FKw;
	Mon, 11 May 2026 03:06:21 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Bkxe1gWAGH8v6l2qZowllal6MfxGYJCDA5QU/w0N+nk=;
	b=I8e4u/zBXrO2s+Nq5doy6kwI1J3APUyCWs6zR+sZ8hR6FCio1yGIYu+Bxjp/ZyzxkByzXvQrO
	aMqq9oaHZ0yTBn6xdZqD7NpZ3jPHtC2nquTX+rhIGrESzs/9sL2fQyeeFGGo2PTU+GszttVVMN6
	AKY3T151Rlh7qefVzuqJoSs=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gDPZ94hl3zcb1W;
	Mon, 11 May 2026 10:58:57 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id CA20040537;
	Mon, 11 May 2026 11:06:14 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 11 May
 2026 11:06:11 +0800
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
	<rdunlap@infradead.org>, <pmladek@suse.com>, <dapeng1.mi@linux.intel.com>,
	<kees@kernel.org>, <elver@google.com>, <kuba@kernel.org>,
	<ebiggers@kernel.org>, <lirongqing@baidu.com>, <paulmck@kernel.org>,
	<ruanjinjie@huawei.com>, <sourabhjain@linux.ibm.com>, <coxu@redhat.com>,
	<leitao@debian.org>, <jbohac@suse.cz>, <ryan.roberts@arm.com>,
	<osandov@fb.com>, <cfsworks@gmail.com>, <tangyouling@kylinos.cn>,
	<ritesh.list@gmail.com>, <adityag@linux.ibm.com>, <guoren@kernel.org>,
	<songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
	<vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>,
	<wangruikang@iscas.ac.cn>, <namcao@linutronix.de>, <chao.gao@intel.com>,
	<seanjc@google.com>, <fuqiang.wang@easystack.cn>, <ardb@kernel.org>,
	<chenjiahao16@huawei.com>, <hbathini@linux.ibm.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <lizhengyu3@huawei.com>,
	<x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
Subject: [PATCH v13 10/15] x86/kexec: Use crash_prepare_headers() helper to simplify code
Date: Mon, 11 May 2026 11:04:49 +0800
Message-ID: <20260511030454.1730881-11-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511030454.1730881-1-ruanjinjie@huawei.com>
References: <20260511030454.1730881-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_040618_865263_83E2931E 
X-CRM114-Status: GOOD (  18.86  )
X-Mailman-Approved-At: Tue, 12 May 2026 10:56:26 -0700
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

Use the newly introduced crash_prepare_headers() function to replace
the existing prepare_elf_headers(), allocate cmem and exclude crash kernel
memory in the crash core, which reduce code duplication.

Only the following three architecture functions need to be implemented:
- arch_get_system_nr_ranges(). Call get_nr_ram_ranges_callback()
  to pre-count the max number of memory ranges.

- arch_crash_populate_cmem(). Use prepare_elf64_ram_headers_callback()
  to collect the memory ranges and fills them into cmem.

- arch_crash_exclude_ranges(). Exclude the low 1M for x86.

By the way, remove the unused "nr_mem_ranges" in
arch_crash_handle_hotplug_event().

Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/x86/kernel/crash.c | 89 +++++------------------------------------
 1 file changed, 11 insertions(+), 78 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index fa6a1feb1bf1..8cf6e115196e 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -153,16 +153,8 @@ static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 	return 0;
 }
 
-/* Gather all the required information to prepare elf headers for ram regions */
-static struct crash_mem *fill_up_crash_elf_data(void)
+unsigned int arch_get_system_nr_ranges(void)
 {
-	unsigned int nr_ranges = 0;
-	struct crash_mem *cmem;
-
-	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
-	if (!nr_ranges)
-		return NULL;
-
 	/*
 	 * Exclusion of crash region, crashk_low_res and/or crashk_cma_ranges
 	 * may cause range splits. So add extra slots here.
@@ -177,49 +169,16 @@ static struct crash_mem *fill_up_crash_elf_data(void)
 	 * But in order to lest the low 1M could be changed in the future,
 	 * (e.g. [start, 1M]), add a extra slot.
 	 */
-	nr_ranges += 3 + crashk_cma_cnt;
-	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
-	if (!cmem)
-		return NULL;
-
-	cmem->max_nr_ranges = nr_ranges;
+	unsigned int nr_ranges = 3 + crashk_cma_cnt;
 
-	return cmem;
+	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
+	return nr_ranges;
 }
 
-/*
- * Look for any unwanted ranges between mstart, mend and remove them. This
- * might lead to split and split ranges are put in cmem->ranges[] array
- */
-static int elf_header_exclude_ranges(struct crash_mem *cmem)
+int arch_crash_exclude_ranges(struct crash_mem *cmem)
 {
-	int ret = 0;
-	int i;
-
 	/* Exclude the low 1M because it is always reserved */
-	ret = crash_exclude_mem_range(cmem, 0, SZ_1M - 1);
-	if (ret)
-		return ret;
-
-	/* Exclude crashkernel region */
-	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
-	if (ret)
-		return ret;
-
-	if (crashk_low_res.end)
-		ret = crash_exclude_mem_range(cmem, crashk_low_res.start,
-					      crashk_low_res.end);
-	if (ret)
-		return ret;
-
-	for (i = 0; i < crashk_cma_cnt; ++i) {
-		ret = crash_exclude_mem_range(cmem, crashk_cma_ranges[i].start,
-					      crashk_cma_ranges[i].end);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
+	return crash_exclude_mem_range(cmem, 0, SZ_1M - 1);
 }
 
 static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
@@ -236,35 +195,9 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 	return 0;
 }
 
-/* Prepare elf headers. Return addr and size */
-static int prepare_elf_headers(void **addr, unsigned long *sz,
-			       unsigned long *nr_mem_ranges)
+int arch_crash_populate_cmem(struct crash_mem *cmem)
 {
-	struct crash_mem *cmem;
-	int ret;
-
-	cmem = fill_up_crash_elf_data();
-	if (!cmem)
-		return -ENOMEM;
-
-	ret = walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
-	if (ret)
-		goto out;
-
-	/* Exclude unwanted mem ranges */
-	ret = elf_header_exclude_ranges(cmem);
-	if (ret)
-		goto out;
-
-	/* Return the computed number of memory ranges, for hotplug usage */
-	*nr_mem_ranges = cmem->nr_ranges;
-
-	/* By default prepare 64bit headers */
-	ret = crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
-
-out:
-	vfree(cmem);
-	return ret;
+	return walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
 }
 #endif
 
@@ -422,7 +355,8 @@ int crash_load_segments(struct kimage *image)
 				  .buf_max = ULONG_MAX, .top_down = false };
 
 	/* Prepare elf headers and add a segment */
-	ret = prepare_elf_headers(&kbuf.buffer, &kbuf.bufsz, &pnum);
+	ret = crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &kbuf.buffer,
+				    &kbuf.bufsz, &pnum);
 	if (ret)
 		return ret;
 
@@ -515,7 +449,6 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
 void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 {
 	void *elfbuf = NULL, *old_elfcorehdr;
-	unsigned long nr_mem_ranges;
 	unsigned long mem, memsz;
 	unsigned long elfsz = 0;
 
@@ -533,7 +466,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 	 * Create the new elfcorehdr reflecting the changes to CPU and/or
 	 * memory resources.
 	 */
-	if (prepare_elf_headers(&elfbuf, &elfsz, &nr_mem_ranges)) {
+	if (crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &elfbuf, &elfsz, NULL)) {
 		pr_err("unable to create new elfcorehdr");
 		goto out;
 	}
-- 
2.34.1


