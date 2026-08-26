Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC9AC5DF97
	for <kexec@archiver.kernel.org>; Wed, 26 Aug 2026 09:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oXgq3/Gz7CGC/Wi4k6l57KKkgsMLlKANbfKYe/2S3+8=; b=ByV6zxu7W3Zfrtg5aNj/y/6xfN
	Da9u5t8OoQbZ8My99HgE9ambYJ8wclOcaeDr8aLhSJtgEcfFrS8vTzslFQEhNDwE18yPon+AV//EC
	kK16GH9vJnLDel6erwTAXsVtPTEiVJ8Y4yYrP2W/7OhraY4wN8MlOWdtYkdfHCNtfijNuGXScYO+d
	gFFDNV7LWIdAnvOk7PTjEXQCspEZR1aEMERtl8R0Jk7dRg9XBh/Deg+GECPTUfuRHCB3Uyh3F27A7
	duiJ1y0SBhoBkCLs7Ah9NiA+VHIYnvZ4i9yr+cDmcjH3nnv08OWO3e+p7x3F1ISFJvpBA7tABHdBQ
	wGGcImQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz9tg-00000002BWG-01U8;
	Wed, 26 Aug 2026 09:26:16 +0000
Received: from canpmsgout06.his.huawei.com ([113.46.200.221])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz9tA-00000002B5i-1jWP;
	Wed, 26 Aug 2026 09:25:49 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oXgq3/Gz7CGC/Wi4k6l57KKkgsMLlKANbfKYe/2S3+8=;
	b=M2WCjUV36RnHb5fNe4vvLb2ECdr0SMY463sjrUv623cM5rtnEGxtrh7Jm17vAKP9UZkTNrCdo
	4xEpxcC38LZJXMGdX94QIQPU5uBerz/eQFv4Hc6UV3ZlxTKy/gxQTre5I4ALJj/5VKN0N7CO2JZ
	Dri1ZnSNgYAZMZLggRJdoJE=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hVJrf11brzRhR0;
	Wed, 26 Aug 2026 17:14:58 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id CE3AC40537;
	Wed, 26 Aug 2026 17:25:41 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Aug
 2026 17:25:39 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <rppt@kernel.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <ruirui.yang@linux.dev>, <kees@kernel.org>,
	<thuth@redhat.com>, <gshan@redhat.com>, <jic23@kernel.org>,
	<james.morse@arm.com>, <ardb@kernel.org>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <sourabhjain@linux.ibm.com>, <coxu@redhat.com>,
	<tangyouling@kylinos.cn>, <hbathini@linux.ibm.com>, <adityag@linux.ibm.com>,
	<ionut.nechita@windriver.com>, <liaoyuanhong@vivo.com>, <seanjc@google.com>,
	<fuqiang.wang@easystack.cn>, <makb@juniper.net>, <piliu@redhat.com>,
	<ebiggers@kernel.org>, <jbouron@amazon.com>, <mclapinski@google.com>,
	<me@linux.beauty>, <graf@amazon.com>, <bgwin@google.com>, <robh@kernel.org>,
	<takahiro.akashi@linaro.org>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v3 14/17] x86/crash: Simplify crash_load_segments() using crash_extra_elfcorehdr_size()
Date: Wed, 26 Aug 2026 17:25:38 +0800
Message-ID: <20260826092541.3905933-15-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826092541.3905933-1-ruanjinjie@huawei.com>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260826_022544_999059_EF545FB2 
X-CRM114-Status: GOOD (  13.98  )
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

Replace the open-coded elfcorehdr reservation logic in
crash_load_segments() with the generic crash_extra_elfcorehdr_size()
helper. The helper centralizes all PN_XNUM and memory range checks,
reducing code duplication.

The elfcorehdr_index is handled separately in crash_handle_hotplug_event()
during the first hotplug event, so it does not need to be set in
crash_load_segments().

Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/x86/kernel/crash.c | 32 +++++---------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index afe2aea19f47..99eb8583d932 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -348,42 +348,20 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 
 int crash_load_segments(struct kimage *image)
 {
-	int ret;
-	unsigned long pnum = 0;
 	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
 				  .buf_max = ULONG_MAX, .top_down = false };
+	unsigned long nr_ranges = 0;
+	int ret;
 
 	/* Prepare elf headers and add a segment */
 	ret = crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &kbuf.buffer,
-				    &kbuf.bufsz, &pnum);
+				    &kbuf.bufsz, &nr_ranges);
 	if (ret)
 		return ret;
 
 	image->elf_headers	= kbuf.buffer;
-	image->elf_headers_sz	= kbuf.bufsz;
-	kbuf.memsz		= kbuf.bufsz;
-
-#ifdef CONFIG_CRASH_HOTPLUG
-	/*
-	 * The elfcorehdr segment size accounts for VMCOREINFO, kernel_map,
-	 * maximum CPUs and maximum memory ranges.
-	 */
-	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
-		pnum = 2 + num_possible_cpus() + CONFIG_CRASH_MAX_MEMORY_RANGES;
-	else
-		pnum += 2 + num_possible_cpus();
-
-	if (pnum < (unsigned long)PN_XNUM) {
-		kbuf.memsz = elf64_phdr_size(pnum);
-
-		image->elfcorehdr_index = image->nr_segments;
-
-		/* Mark as usable to crash kernel, else crash kernel fails on boot */
-		image->elf_headers_sz = kbuf.memsz;
-	} else {
-		pr_err("number of Phdrs %lu exceeds max\n", pnum);
-	}
-#endif
+	kbuf.memsz = kbuf.bufsz + crash_extra_elfcorehdr_size(nr_ranges);
+	image->elf_headers_sz	= kbuf.memsz;
 
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
-- 
2.34.1


