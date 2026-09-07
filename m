Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900B5C79F9E
	for <kexec@archiver.kernel.org>; Mon,  7 Sep 2026 12:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MWYcbaLX2p2UByqhrLVYGoAeGhCajPS1DD+9MAEVZJI=; b=fLzeKPVksEjtIQTZxcWD3wotyM
	tr1i/QFKsJScCoK2jwmmrT0K4aeZz7OuifEiz50aLwxsTlUqNYUqNOqN3Rh/r7RoqG0GA/xp/1IgW
	TbXIxgMCITGg46M/kJJExAGVnYb4SzefWf3mEMdX7cZYDcdFrWDr9BtNVdsk57XzQOiXqga4/kfRy
	KmPRplHub5eVZ01jB6Tw61UckFM6pyH+Y7bDdLcsEsQtlxWj0KBAs5Jvjm2+NAeURRghDWbLpQ5tj
	cMZaOYaSyR1GuNR9QteBpYN3HnEViP1wYVsA4ZyflsHUa5VJ/afDhbldt6qALuivu1nmzqizWWqCc
	4jcY/feA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3YrO-00000006rPi-243u;
	Mon, 07 Sep 2026 12:54:06 +0000
Received: from canpmsgout02.his.huawei.com ([113.46.200.217])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3Yr2-00000006r64-1E7w;
	Mon, 07 Sep 2026 12:53:51 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=MWYcbaLX2p2UByqhrLVYGoAeGhCajPS1DD+9MAEVZJI=;
	b=gR4Oea8zK/29aJ7RLHno9CLpbS4RZ5sZw5cTFB2WKWnzxU8xtNxJ2Vh7v1HG5zIZSPs1xEehl
	Xnka2BWgYoSzlwkTab3Mx1Kn8mGPYxZT91iczi4tA+JzWBxS4EWmLjnuDOuoM8o2ii+tfUIM5Qd
	oy3VxnFoymLznncxBOoBxy8=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hdmtp0hYSzcb4j;
	Mon,  7 Sep 2026 20:42:42 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 302D7203B8;
	Mon,  7 Sep 2026 20:53:37 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 20:53:35 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <rppt@kernel.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <ruirui.yang@linux.dev>, <kees@kernel.org>,
	<ruanjinjie@huawei.com>, <thuth@redhat.com>, <jic23@kernel.org>,
	<tan.shaopeng@jp.fujitsu.com>, <zengheng4@huawei.com>, <james.morse@arm.com>,
	<ardb@kernel.org>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <robh@kernel.org>, <coxu@redhat.com>,
	<tangyouling@kylinos.cn>, <hbathini@linux.ibm.com>, <adityag@linux.ibm.com>,
	<djbw@kernel.org>, <seanjc@google.com>, <liaoyuanhong@vivo.com>,
	<vishal.l.verma@intel.com>, <fuqiang.wang@easystack.cn>, <makb@juniper.net>,
	<piliu@redhat.com>, <ebiggers@kernel.org>, <jbouron@amazon.com>,
	<mclapinski@google.com>, <me@linux.beauty>, <graf@amazon.com>,
	<bgwin@google.com>, <takahiro.akashi@linaro.org>, <palmer@rivosinc.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <kexec@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v4 09/12] elf: Introduce elf64_phdr_size() helper
Date: Mon, 7 Sep 2026 20:54:01 +0800
Message-ID: <20260907125404.922123-10-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260907125404.922123-1-ruanjinjie@huawei.com>
References: <20260907125404.922123-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_055344_821729_46847240 
X-CRM114-Status: GOOD (  13.63  )
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

Add a common helper to compute the total size of an ELF64 header
(Ehdr + program headers) from the number of program headers.
Replace open-coded calculations in powerpc, x86, vmcore,
and crash_core.

On ppc64, struct elfhdr maps to elf64_hdr, so the powerpc change
is a pure cleanup.

No functional change intended.

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Dave Young <ruirui.yang@linux.dev>
Cc: Kees Cook <kees@kernel.org>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/powerpc/kexec/crash.c                 | 2 +-
 arch/powerpc/platforms/powernv/opal-core.c | 3 +--
 arch/x86/kernel/crash.c                    | 3 +--
 fs/proc/vmcore.c                           | 6 ++----
 include/linux/elf.h                        | 4 ++++
 kernel/crash_core.c                        | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index 775895f31037..fc0105c7af4c 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -478,7 +478,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		phdr_cnt += CONFIG_CRASH_MAX_MEMORY_RANGES;
 
-	return sizeof(struct elfhdr) + (phdr_cnt * sizeof(Elf64_Phdr));
+	return elf64_phdr_size(phdr_cnt);
 }
 
 /**
diff --git a/arch/powerpc/platforms/powernv/opal-core.c b/arch/powerpc/platforms/powernv/opal-core.c
index 32662d30d70f..fc0aad61504b 100644
--- a/arch/powerpc/platforms/powernv/opal-core.c
+++ b/arch/powerpc/platforms/powernv/opal-core.c
@@ -309,8 +309,7 @@ static int __init create_opalcore(void)
 	char *bufp;
 
 	/* Get size of header & CPU notes for OPAL core */
-	hdr_size = (sizeof(Elf64_Ehdr) +
-		    ((oc_conf->ptload_cnt + 1) * sizeof(Elf64_Phdr)));
+	hdr_size = elf64_phdr_size(oc_conf->ptload_cnt + 1);
 	cpu_notes_size = ((oc_conf->num_cpus * (CRASH_CORE_NOTE_HEAD_BYTES +
 			  CRASH_CORE_NOTE_NAME_BYTES +
 			  CRASH_CORE_NOTE_DESC_BYTES)) +
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index d6430a593778..e164749c5c1d 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -374,8 +374,7 @@ int crash_load_segments(struct kimage *image)
 		pnum += 2 + CONFIG_NR_CPUS_DEFAULT;
 
 	if (pnum < (unsigned long)PN_XNUM) {
-		kbuf.memsz = pnum * sizeof(Elf64_Phdr);
-		kbuf.memsz += sizeof(Elf64_Ehdr);
+		kbuf.memsz = elf64_phdr_size(pnum);
 
 		image->elfcorehdr_index = image->nr_segments;
 
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 44d15436439f..ff324969d798 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1238,8 +1238,7 @@ static int __init parse_crash_elf64_headers(void)
 	}
 
 	/* Read in all elf headers. */
-	elfcorebuf_sz_orig = sizeof(Elf64_Ehdr) +
-				ehdr.e_phnum * sizeof(Elf64_Phdr);
+	elfcorebuf_sz_orig = elf64_phdr_size(ehdr.e_phnum);
 	elfcorebuf_sz = elfcorebuf_sz_orig;
 	elfcorebuf = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
 					      get_order(elfcorebuf_sz_orig));
@@ -1605,8 +1604,7 @@ static int vmcore_add_device_ram_elf64(struct list_head *list, size_t count)
 	}
 
 	/* elfcorebuf_sz must always cover full pages. */
-	new_size = sizeof(Elf64_Ehdr) +
-		   (ehdr->e_phnum + count) * sizeof(Elf64_Phdr);
+	new_size = elf64_phdr_size(ehdr->e_phnum + count);
 	new_size = roundup(new_size, PAGE_SIZE);
 
 	/*
diff --git a/include/linux/elf.h b/include/linux/elf.h
index 5c402788da19..400f58a13d92 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -109,4 +109,8 @@ static inline int arch_elf_adjust_prot(int prot,
 }
 #endif
 
+static inline unsigned long elf64_phdr_size(unsigned long phdr_cnt)
+{
+	return phdr_cnt * sizeof(Elf64_Phdr) + sizeof(Elf64_Ehdr);
+}
 #endif /* _LINUX_ELF_H */
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 39feb39b53be..b57a81f38ef4 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -193,7 +193,7 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 	 */
 
 	nr_phdr++;
-	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
+	elf_sz = elf64_phdr_size(nr_phdr);
 	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
 
 	buf = vzalloc(elf_sz);
-- 
2.34.1


