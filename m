Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A2DCD98CF
	for <kexec@archiver.kernel.org>; Wed, 10 Jun 2026 06:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gDz8s7gLdDpXt5LNabigpz6pForwFKNZ/JJls2tiGIw=; b=2foQedYGyv7dyQABAvL2v44iU/
	MKfddzgWr8PCr13gJBFqb1dFhssUUWl1/wFxGr4MNrJMg+4isFm5qGsMLKkCroA5I0gyM5cn59glo
	or/d8AjFdBibHwEhriBPe6Yc33C8vEJXqQBUCKioLTqW+JlXRJCXjFlXV5cxokIVvvvlQpR9ZJ8OT
	SBRy6MjiSnafaXaoGLfEydNuRMWGhJcDhx94pGhf8ZPjshYQTjNrLcE+ay7BSHBPgEmYNgKlPFNxY
	bKsXYGoV6Jnr/XKq1Noh07/6bJRZpNamQjCI1AxeIRWnRXovYsFeNiOmEuWIUfMv5fyFzaTv3RTBJ
	zLjdks+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXCfq-00000006u9C-1Gix;
	Wed, 10 Jun 2026 06:44:26 +0000
Received: from canpmsgout11.his.huawei.com ([113.46.200.226])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWUXG-00000002z85-3qpS;
	Mon, 08 Jun 2026 07:36:40 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gDz8s7gLdDpXt5LNabigpz6pForwFKNZ/JJls2tiGIw=;
	b=W0rIiuxFDUrhz/Lzfw7QxUQgOWEWmSs6Jg7pCfxjpYt1dHQqHoaIf/JdL5z+6B+BsUkZghps4
	tR/LAD9ZI0CTPDQSKIPrfJS7jjaXEdaAtYMLXpBixDsRjH099mCvfoISyDWupKIJS5Go3Q/Hupx
	ijhMRayGNYlbH7dOsBrwYwU=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gYkDS0J9NzKm52;
	Mon,  8 Jun 2026 15:28:40 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 7357F40563;
	Mon,  8 Jun 2026 15:36:35 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 8 Jun
 2026 15:36:32 +0800
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
	<rdunlap@infradead.org>, <peterz@infradead.org>,
	<feng.tang@linux.alibaba.com>, <dapeng1.mi@linux.intel.com>,
	<kees@kernel.org>, <elver@google.com>, <kuba@kernel.org>,
	<lirongqing@baidu.com>, <ebiggers@kernel.org>, <paulmck@kernel.org>,
	<ruanjinjie@huawei.com>, <leitao@debian.org>, <coxu@redhat.com>,
	<Liam.Howlett@oracle.com>, <ryan.roberts@arm.com>, <osandov@fb.com>,
	<jbohac@suse.cz>, <cfsworks@gmail.com>, <tangyouling@kylinos.cn>,
	<sourabhjain@linux.ibm.com>, <ritesh.list@gmail.com>,
	<adityag@linux.ibm.com>, <liaoyuanhong@vivo.com>, <seanjc@google.com>,
	<fuqiang.wang@easystack.cn>, <ardb@kernel.org>, <chenjiahao16@huawei.com>,
	<guoren@kernel.org>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
Subject: [PATCH v16 06/10] riscv: kexec_file: Use crash_prepare_headers() helper to simplify code
Date: Mon, 8 Jun 2026 15:34:55 +0800
Message-ID: <20260608073459.3119290-7-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608073459.3119290-1-ruanjinjie@huawei.com>
References: <20260608073459.3119290-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_003639_306536_3F1700D6 
X-CRM114-Status: GOOD (  13.43  )
X-Mailman-Approved-At: Tue, 09 Jun 2026 23:44:17 -0700
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

Only the following two architecture functions need to be implemented:
- arch_get_system_nr_ranges(). Call get_nr_ram_ranges_callback()
  to pre-counts the max number of memory ranges.

- arch_crash_populate_cmem(). Use prepare_elf64_ram_headers_callback()
  to collects the memory ranges and fills them into cmem.

Cc: Paul Walmsley <pjw@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Guo Ren <guoren@kernel.org>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/riscv/kernel/machine_kexec_file.c | 47 +++++++-------------------
 1 file changed, 12 insertions(+), 35 deletions(-)

diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index 3f7766057cac..439cbc50dfa6 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -44,6 +44,15 @@ static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 	return 0;
 }
 
+unsigned int arch_get_system_nr_ranges(void)
+{
+	unsigned int nr_ranges = 2; /* For exclusion of crashkernel region */
+
+	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
+
+	return nr_ranges;
+}
+
 static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 {
 	struct crash_mem *cmem = arg;
@@ -55,41 +64,9 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 	return 0;
 }
 
-static int prepare_elf_headers(void **addr, unsigned long *sz)
+int arch_crash_populate_cmem(struct crash_mem *cmem)
 {
-	struct crash_mem *cmem;
-	unsigned int nr_ranges;
-	int ret;
-
-	nr_ranges = 2; /* For exclusion of crashkernel region */
-	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
-
-	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
-	if (!cmem)
-		return -ENOMEM;
-
-	cmem->max_nr_ranges = nr_ranges;
-	cmem->nr_ranges = 0;
-	ret = walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
-	if (ret)
-		goto out;
-
-	/* Exclude crashkernel region */
-	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
-	if (ret)
-		goto out;
-
-	if (crashk_low_res.end) {
-		ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
-		if (ret)
-			goto out;
-	}
-
-	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
-
-out:
-	kfree(cmem);
-	return ret;
+	return walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
 }
 
 static char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
@@ -281,7 +258,7 @@ int load_extra_segments(struct kimage *image, unsigned long kernel_start,
 	if (image->type == KEXEC_TYPE_CRASH) {
 		void *headers;
 		unsigned long headers_sz;
-		ret = prepare_elf_headers(&headers, &headers_sz);
+		ret = crash_prepare_headers(true, &headers, &headers_sz, NULL);
 		if (ret) {
 			pr_err("Preparing elf core header failed\n");
 			goto out;
-- 
2.34.1


