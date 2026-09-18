Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FF9C982F6
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xY6MkLtAML0NhdwFhEh6HEFrtMWS+BaF8Jv6SYbylCI=; b=1Q1ns0x6pfFbbzzzVVbULJ9rAl
	JB3Md73FkHFApZeXHrisz3+hAacd4mshXd+uvfCFdT679h0JUQMXW+KDoaGulyEmh4XxSqUpBn36O
	s+4InEg4MFGa+UPW5U+1hksnneIVseYkd/exp20ZqgpIhs/8P2+3sGKvDLB7+DbgUovJsRd8PqMpe
	nv7ze7xdvs4t5lZTfunPPQjPFx7uJ0F/40Lw0ED7R58hmLNs77PdDY2sUGFRRU26XMJPjiK2ljwA+
	PoSQL5cmC8g4wxCvd8W3fssDTbXpoVBLwZ8X2LoGHCACCrgnULOd/1eKAHUSok9VkdyD20+FTtjbj
	Td9z8TFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4X-00000000Mj3-16Xn;
	Sun, 20 Sep 2026 20:23:37 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7VSX-0000000E2bT-0ljs;
	Fri, 18 Sep 2026 10:04:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=xY6MkLtAML0NhdwFhEh6HEFrtMWS+BaF8Jv6SYbylCI=; b=IgWGV6vcfNipQv3hiPPbyp/73t
	2pfoD3lyhz+UNeW3OIOmaTO2lPC86w6sX7mkuGAs47oMe/Zj3ft1CVbf1OYkNzWt4ofM1kmZ0CuO2
	11qCeCpDwQf6fIsB8mO5PhJxgZdBGJwPNyav6qjzumx0AFiGUM8ThsKCLj6NyT1qpoFNK+1pnYI8f
	5+v0i0A+euYgjw0Fc/RGhLC9Stmm/KPsLh5Lry0QGFhprR1vFs3I+KqUbJhSPVQ8S0zIpt0m9lfiF
	ImPbQ9iKhh2U4H7Ygxi9n4dYaZguujBasajiLEIET2TVWw04ANM9C/l4enQ/Vfb7QinwHSsMta/jy
	1prweRiQ==;
Received: from canpmsgout05.his.huawei.com ([113.46.200.220])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x7VSS-00000009tau-2p6i;
	Fri, 18 Sep 2026 10:04:44 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xY6MkLtAML0NhdwFhEh6HEFrtMWS+BaF8Jv6SYbylCI=;
	b=C2eZF9MriTz09Fyd6sSJRN6eb3mHxLBMVzS2eueaGbQwfruJTStfHmzacHg2EphpPC7IEogVN
	vKy7HEOXjk8HJKqpXYqJT2TzYh11n9eTIQIYH9HAE08ba7TuLwPVwJITDWlXJ6ajgI17Ju7r/zg
	o/XgABw9N1BRe9NbOBaj9iM=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hmScM61twz12LHv;
	Fri, 18 Sep 2026 17:53:23 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id CF0FE20333;
	Fri, 18 Sep 2026 18:04:30 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 18:04:29 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <kees@kernel.org>, <thuth@redhat.com>,
	<ruanjinjie@huawei.com>, <gshan@redhat.com>, <ardb@kernel.org>,
	<james.morse@arm.com>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <robh@kernel.org>, <coxu@redhat.com>,
	<tangyouling@kylinos.cn>, <liukexin@kylinos.cn>, <guodongtai@kylinos.cn>,
	<maqianga@uniontech.com>, <zhangtianyang@loongson.cn>, <blum@kernel.org>,
	<adityag@linux.ibm.com>, <chao.gao@intel.com>, <kas@kernel.org>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <piliu@redhat.com>,
	<jbouron@amazon.com>, <me@linux.beauty>, <mclapinski@google.com>,
	<graf@amazon.com>, <bgwin@google.com>, <eric.devolder@oracle.com>,
	<hbathini@linux.ibm.com>, <takahiro.akashi@linaro.org>,
	<lizhengyu3@huawei.com>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<driver-core@lists.linux.dev>, <kexec@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v5 15/17] crash: Introduce crash_extra_elfcorehdr_size() helper
Date: Fri, 18 Sep 2026 18:04:40 +0800
Message-ID: <20260918100442.3841135-16-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918100442.3841135-1-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_110442_608848_37688A06 
X-CRM114-Status: GOOD (  12.51  )
X-Mailman-Approved-At: Sun, 20 Sep 2026 13:23:20 -0700
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

Extract the elfcorehdr extra space calculation from powerpc into a
generic helper crash_extra_elfcorehdr_size() for use by other
architectures like arm64.

Strengthen the original powerpc check: instead of only checking
the loose CONFIG_CRASH_MAX_MEMORY_RANGES, the new helper enforces
a strict compile-time BUILD_BUG_ON() to guarantee that the absolute
maximum theoretical number of ELF Program Headers will never exceed
the ELF physical limit of PN_XNUM. This ensures absolute safety across
all architectures with zero runtime overhead.

The helper also provides a zero-size stub when crash memory hotplug
is disabled.

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Dave Young <ruirui.yang@linux.dev>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/powerpc/kexec/file_load_64.c | 15 +--------------
 include/linux/crash_core.h        | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index bd80c5fb1b1f..d3512c85ea83 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -374,19 +374,6 @@ static int load_backup_segment(struct kimage *image, struct kexec_buf *kbuf)
 	return 0;
 }
 
-static unsigned int kdump_extra_elfcorehdr_size(struct crash_mem *cmem)
-{
-#if defined(CONFIG_CRASH_HOTPLUG) && defined(CONFIG_MEMORY_HOTPLUG)
-	if (CONFIG_CRASH_MAX_MEMORY_RANGES > (unsigned int)PN_XNUM)
-		pr_warn("Number of Phdrs %u exceeds max\n", CONFIG_CRASH_MAX_MEMORY_RANGES);
-	else if (cmem->nr_ranges >= CONFIG_CRASH_MAX_MEMORY_RANGES)
-		pr_warn("Configured crash mem ranges may not be enough\n");
-	else
-		return (CONFIG_CRASH_MAX_MEMORY_RANGES - cmem->nr_ranges) * sizeof(Elf64_Phdr);
-#endif
-	return 0;
-}
-
 /**
  * load_elfcorehdr_segment - Setup crash memory ranges and initialize elfcorehdr
  *                           segment needed to load kdump kernel.
@@ -424,7 +411,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 	 * Account for extra space required to accommodate additional memory
 	 * ranges in elfcorehdr due to memory hotplug events.
 	 */
-	kbuf->memsz = headers_sz + kdump_extra_elfcorehdr_size(cmem);
+	kbuf->memsz = headers_sz + crash_extra_elfcorehdr_size(cmem->nr_ranges);
 	kbuf->top_down = false;
 
 	ret = kexec_add_buffer(kbuf);
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 1296a9b29974..aee2449f343b 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -107,4 +107,24 @@ ssize_t dm_crypt_keys_read(char *buf, size_t count, u64 *ppos);
 static inline int crash_load_dm_crypt_keys(struct kimage *image) {return 0; }
 #endif
 
+#if defined(CONFIG_CRASH_HOTPLUG) && defined(CONFIG_MEMORY_HOTPLUG)
+static inline unsigned int crash_extra_elfcorehdr_size(unsigned int nr_mem_ranges)
+{
+	BUILD_BUG_ON((2 + CONFIG_NR_CPUS + CONFIG_CRASH_MAX_MEMORY_RANGES) >=
+		     (unsigned int)PN_XNUM);
+
+	if (nr_mem_ranges >= CONFIG_CRASH_MAX_MEMORY_RANGES) {
+		pr_warn_once("Configured crash mem ranges may not be enough\n");
+		return 0;
+	}
+
+	return (CONFIG_CRASH_MAX_MEMORY_RANGES - nr_mem_ranges) * sizeof(Elf64_Phdr);
+}
+#else
+static inline unsigned int crash_extra_elfcorehdr_size(unsigned int nr_mem_ranges)
+{
+	return 0;
+}
+#endif
+
 #endif /* LINUX_CRASH_CORE_H */
-- 
2.34.1


