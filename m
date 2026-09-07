Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B621C79FA7
	for <kexec@archiver.kernel.org>; Mon,  7 Sep 2026 12:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=36bd1Aryi5uvtn548uu4wSOfSDdMAA0WJBii4KWoLys=; b=yAsBfws7oBLZL5YrRVMXsaZN/k
	CVzV4s7kDp4/F6dR+ST6UgiyNmvu/Co3GXRj396M1kFTpbYfIRBqLhVGXGS+I0Ba9CgVE9O5yvO8M
	opHm188+oTmpNGGkqMPNEQaEHXILtxcAZNw1RQOVXBJt+hw7VlShe8i7PT50hp1A9h/+PTvL1bz2J
	x4DvOzc6nFVRzZda67VA3ajIVXWpxN78VwmY54DhhVLRPzpmYHrNjWZ3CYkNIM9EPpiHTOaMdTDnC
	btXkpPR3bP6N1DjCyWeXyzq2j8ZaW1U+2S0VCyINkXxjHxBJb644LKJ5KZC8KprDnOePvlDJTZ9S3
	/aTjZg9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3YrO-00000006rP8-19e7;
	Mon, 07 Sep 2026 12:54:06 +0000
Received: from canpmsgout04.his.huawei.com ([113.46.200.219])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3Yr0-00000006r5e-1HDg;
	Mon, 07 Sep 2026 12:53:51 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=36bd1Aryi5uvtn548uu4wSOfSDdMAA0WJBii4KWoLys=;
	b=n6KAgHz6AmQudNNRUdMm9Y1neIc7wALlg5aNvxTbqdqGiHB+U26TuDZdrvBnX+EQxmfeelZE5
	CRCDDv5sfI43GDMRnSpw7v6x7KPkT4tMVlVGlZ1XWLqB+S1Xn8pfDJg8R+pnnHB7k0i2VM7pr5s
	kOWQ33LQzfCzBoyxFpXHRF0=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hdmtq6pmlz1prlJ;
	Mon,  7 Sep 2026 20:42:43 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id B2E1640575;
	Mon,  7 Sep 2026 20:53:38 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 20:53:36 +0800
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
Subject: [PATCH v4 10/12] crash: Introduce crash_extra_elfcorehdr_size() helper
Date: Mon, 7 Sep 2026 20:54:02 +0800
Message-ID: <20260907125404.922123-11-ruanjinjie@huawei.com>
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
X-CRM114-CacheID: sfid-20260907_055344_708228_51D0D099 
X-CRM114-Status: GOOD (  12.89  )
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
 arch/powerpc/kexec/file_load_64.c | 19 +------------------
 include/linux/crash_core.h        | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 6075b1c88511..2b0325e4a628 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -374,23 +374,6 @@ static int load_backup_segment(struct kimage *image, struct kexec_buf *kbuf)
 	return 0;
 }
 
-static unsigned int kdump_extra_elfcorehdr_size(struct crash_mem *cmem)
-{
-#if defined(CONFIG_CRASH_HOTPLUG) && defined(CONFIG_MEMORY_HOTPLUG)
-	unsigned int extra_sz = 0;
-
-	if (CONFIG_CRASH_MAX_MEMORY_RANGES > (unsigned int)PN_XNUM)
-		pr_warn("Number of Phdrs %u exceeds max\n", CONFIG_CRASH_MAX_MEMORY_RANGES);
-	else if (cmem->nr_ranges >= CONFIG_CRASH_MAX_MEMORY_RANGES)
-		pr_warn("Configured crash mem ranges may not be enough\n");
-	else
-		extra_sz = (CONFIG_CRASH_MAX_MEMORY_RANGES - cmem->nr_ranges) * sizeof(Elf64_Phdr);
-
-	return extra_sz;
-#endif
-	return 0;
-}
-
 /**
  * load_elfcorehdr_segment - Setup crash memory ranges and initialize elfcorehdr
  *                           segment needed to load kdump kernel.
@@ -428,7 +411,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 	 * Account for extra space required to accommodate additional memory
 	 * ranges in elfcorehdr due to memory hotplug events.
 	 */
-	kbuf->memsz = headers_sz + kdump_extra_elfcorehdr_size(cmem);
+	kbuf->memsz = headers_sz + crash_extra_elfcorehdr_size(cmem->nr_ranges);
 	kbuf->top_down = false;
 
 	ret = kexec_add_buffer(kbuf);
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index a68c0a6346f4..b447facf37cc 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -106,4 +106,24 @@ ssize_t dm_crypt_keys_read(char *buf, size_t count, u64 *ppos);
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


