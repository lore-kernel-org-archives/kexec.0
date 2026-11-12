Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E38606A88C
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pgUKkGvt;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=gxvGi8l5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VAYr9WX92dg3SvFjZudKbj8hGUmjBf0kHQsMj3Huy2A=; b=pgUKkGvtnxdYuvkhJn05mr/fnL
	KHRuIp/Myt9GBZWyShtlDsaUYmMWk4BJ+EuOH+4cO3EDag7HeWqGIMPHrTOdPesq9WjlTO1rbMAa3
	RwilcBBYy1bbACNqJf8kvEcYtET4yvFzNM6ihBtv8wJZxOJXbJTe6PHi59jDGCom6C6ILIyYeqTBW
	cBQgO1qSuBFeQYCex1EAHtCaF0q/PmSRWP6I0eMfnOl1zqSG8xW07Uv6Sj1MgJ64gAhBPm4qO9nMy
	RC1ZJMZQ64d3rdpVdPiHuynDfi701mEhxdFc9VRCxeXe4jYx2UCPPpns7IuZ0Ahwr6vyBtV/K81/R
	ddEPR1Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRUxG-0000000A5fk-3r35;
	Thu, 12 Nov 2026 13:35:06 +0000
Received: from canpmsgout05.his.huawei.com ([113.46.200.220])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRUx0-0000000A5IE-26Aj;
	Thu, 12 Nov 2026 13:34:52 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VAYr9WX92dg3SvFjZudKbj8hGUmjBf0kHQsMj3Huy2A=;
	b=gxvGi8l5GYdAixG1QRWsiSMLXXsHyOINqSPUArEqcmmeWhWDwV6nk3CkHtY7MDp+FMWYyzx6n
	HOBPUbx0XU/w94jHsTYt7dspTnSwdWfKEmGxB/qdyl9efuTCs2wvrwlVEjkDtbQfNn79EZnH2fE
	I8C2D6gS4O3csk5lTZtUg8E=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jQLwW6CCwz12Lf0;
	Thu, 12 Nov 2026 21:34:51 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 4125240575;
	Thu, 12 Nov 2026 21:34:46 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 12 Nov
 2026 21:34:44 +0800
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
Subject: [PATCH v8 07/11] powerpc: kexec_file: Use the common segment helpers
Date: Thu, 12 Nov 2026 21:34:14 +0800
Message-ID: <20261112133418.4044428-8-ruanjinjie@huawei.com>
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
X-CRM114-CacheID: sfid-20261112_053450_971975_BC08A533 
X-CRM114-Status: GOOD (  13.15  )
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

load_elfcorehdr_segment() builds the elf core header from the powerpc
crash memory ranges and places it as a segment.  The header needs
powerpc specific post processing, so keep building it here, but use
kexec_add_elf_core_header() to place it.

elf64_load() also loads the initrd by hand, use kexec_add_initrd()
for it.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <chleroy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/powerpc/kexec/elf_64.c       |  9 ++-------
 arch/powerpc/kexec/file_load_64.c | 14 ++++----------
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
index d9a466cd602e..1ef444494641 100644
--- a/arch/powerpc/kexec/elf_64.c
+++ b/arch/powerpc/kexec/elf_64.c
@@ -96,18 +96,13 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 
 	kexec_dprintk("Command line: %s", cmdline ? cmdline : "");
 
-	if (initrd != NULL) {
-		kbuf.buffer = initrd;
-		kbuf.bufsz = kbuf.memsz = initrd_len;
+	if (initrd) {
 		kbuf.buf_align = PAGE_SIZE;
 		kbuf.top_down = false;
-		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
-		ret = kexec_add_buffer(&kbuf);
+		ret = kexec_add_initrd(image, &kbuf);
 		if (ret)
 			goto out;
 		initrd_load_addr = kbuf.mem;
-
-		kexec_dprintk("Loaded initrd at 0x%lx\n", initrd_load_addr);
 	}
 
 	ret = get_reserved_memory_ranges(&rmem);
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 0cf03cee35a7..77652db7d1ca 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -416,9 +416,8 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 	/* Fix the offset for backup region in the ELF header */
 	sync_backup_region_phdr(image, headers, false);
 
-	kbuf->buffer = headers;
-	kbuf->mem = KEXEC_BUF_MEM_UNKNOWN;
-	kbuf->bufsz = headers_sz;
+	image->elf_headers = headers;
+	image->elf_headers_sz = headers_sz;
 
 	/*
 	 * Account for extra space required to accommodate additional memory
@@ -427,13 +426,9 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 	kbuf->memsz = headers_sz + kdump_extra_elfcorehdr_size(cmem);
 	kbuf->top_down = false;
 
-	ret = kexec_add_buffer(kbuf);
-	if (ret) {
-		vfree(headers);
+	ret = kexec_add_elf_core_header(image, kbuf);
+	if (ret)
 		goto out;
-	}
-
-	image->elf_load_addr = kbuf->mem;
 
 	/*
 	 * If CONFIG_CRASH_HOTPLUG is enabled, the elfcorehdr kexec segment
@@ -442,7 +437,6 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 	 * memory in the FDT prepared for kdump.
 	 */
 	image->elf_headers_sz = kbuf->memsz;
-	image->elf_headers = headers;
 out:
 	kfree(cmem);
 	return ret;
-- 
2.34.1


