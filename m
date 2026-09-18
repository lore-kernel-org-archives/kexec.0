Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9C7C98308
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2Eq1XJNYhRFTE/SJtlUDPWTtcQMeeDeygEezx5WcQDg=; b=ksdi9OhGg3eClhSZcJFvMuZfMC
	Sw8zzwnrrGouIF8pnlg7QWFr/wjVmGR6xH0UrB5vEBbdBa7IjCSFjQU3P136+znXabjO3U5hfcf1g
	xxMC1Ah+0g6lqZG76RY3hoRkH2Pb568f8fHiVUvG0K3dfayyRMF7ZQdli5Rat5PgIy9BglCRjyIs6
	y1ubi4YKTOEA1f8v+JIrUewlOj+gwJlMfcZJVPjRxPDOKJ2H46aTlEAAlF0ilsLqgXks1aNAVaK0V
	t4tfVW+ilTg4htN4GfgOqVSFv5gdL1qYejiY4UTPJWy6c3pOaelgSrb24RjjZDoqMhXT8S91jUwlx
	HIRkUK5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4T-00000000MYI-17LB;
	Sun, 20 Sep 2026 20:23:33 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7VSJ-0000000E2Pi-2h64;
	Fri, 18 Sep 2026 10:04:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=2Eq1XJNYhRFTE/SJtlUDPWTtcQMeeDeygEezx5WcQDg=; b=jEzZ5O1H14wLiLokH5W1aREsNB
	kR9r24Ostg9lmOLHGhVcFoFsKzAqDINLIY4YsTY0Wg+rI47cf8xjIr3PAxbE7fCymmL+zaggzOvwZ
	o878zB/KMEf930KB1grDC6HFjHBE0BH1Zwbxbe8jTf345uBQfUNc5G3C8pCChaWJZGccjf4gk3OMk
	zk4u7ch14uI2ePUBXjJPoaWZ0bDzGLEkrQJDfT1srY5MM67frK+/PHuCPV8jQmDEO4GE1GEMQ5GWs
	b+0aujAB1J23KTLtbKX/PpmHnHzqmfQnJG1KKT8hvkk9wLWSJvwdyU/d5bsDKke4zP5ilzKl5qQOS
	1qdxxy9Q==;
Received: from canpmsgout03.his.huawei.com ([113.46.200.218])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x7VSG-00000009tTz-1unt;
	Fri, 18 Sep 2026 10:04:30 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2Eq1XJNYhRFTE/SJtlUDPWTtcQMeeDeygEezx5WcQDg=;
	b=M3xDCzOSH1ex1aIXQYlZy5bUMNl8IOExQZttwkBTy/1chlRHO/kzqULiUCzyJpa1xmha57Pt9
	6lPA8D6mDEfjpfxI7U4GV7kTxHty4Tg4b4+dOqX5QVt6cyuL1vky1HDVwNZXgBujl8bGaIfFt0t
	WgzQI/6r2eltMXLNXd6LJ7c=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hmSbD4MBGzpStW;
	Fri, 18 Sep 2026 17:52:24 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id B2E5B40537;
	Fri, 18 Sep 2026 18:04:13 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 18:04:12 +0800
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
Subject: [PATCH v5 03/17] kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
Date: Fri, 18 Sep 2026 18:04:28 +0800
Message-ID: <20260918100442.3841135-4-ruanjinjie@huawei.com>
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
X-CRM114-CacheID: sfid-20260918_110429_132546_508BEF52 
X-CRM114-Status: GOOD (  12.84  )
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

kimage_free_cma() relies on image->nr_segments to iterate over segments.
When an architecture loader (e.g., arm64) truncates nr_segments on a
mid-way failure, CMA pages allocated beyond the new boundary become
unreachable, causing silent memory leaks.

Extract the per-segment freeing logic into the exported helper
kexec_free_segment_cma(), so that architecture loaders can release
individual segments before nr_segments is truncated. Refactor
kimage_free_cma() to loop over the new helper, preserving existing
behavior.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/linux/kexec.h |  2 ++
 kernel/kexec_core.c   | 27 +++++++++++++++------------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 6b1df80524bf..72258d813301 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -533,6 +533,7 @@ extern bool kexec_file_dbg_print;
 
 extern void *kimage_map_segment(struct kimage *image, int idx);
 extern void kimage_unmap_segment(void *buffer);
+void kexec_free_segment_cma(struct kimage *image, unsigned long idx);
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
@@ -544,6 +545,7 @@ static inline int kexec_crash_loaded(void) { return 0; }
 static inline void *kimage_map_segment(struct kimage *image, int idx)
 { return NULL; }
 static inline void kimage_unmap_segment(void *buffer) { }
+static inline void kexec_free_segment_cma(struct kimage *image, unsigned long idx) { }
 #define kexec_in_progress false
 #endif /* CONFIG_KEXEC_CORE */
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 5493591a9e4b..31c8228318a7 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -554,23 +554,26 @@ static void kimage_free_entry(kimage_entry_t entry)
 	kimage_free_pages(page);
 }
 
-static void kimage_free_cma(struct kimage *image)
+void kexec_free_segment_cma(struct kimage *image, unsigned long idx)
 {
-	unsigned long i;
+	unsigned long nr_pages = image->segment_cma_pages[idx];
+	struct page *cma = image->segment_cma[idx];
 
-	for (i = 0; i < image->nr_segments; i++) {
-		struct page *cma = image->segment_cma[i];
-		unsigned long nr_pages = image->segment_cma_pages[i];
+	if (!cma)
+		return;
 
-		if (!cma)
-			continue;
+	arch_kexec_pre_free_pages(page_address(cma), (unsigned int)nr_pages);
+	dma_release_from_contiguous(NULL, cma, (int)nr_pages);
+	image->segment_cma[idx] = NULL;
+	image->segment_cma_pages[idx] = 0;
+}
 
-		arch_kexec_pre_free_pages(page_address(cma), (unsigned int)nr_pages);
-		dma_release_from_contiguous(NULL, cma, (int)nr_pages);
-		image->segment_cma[i] = NULL;
-		image->segment_cma_pages[i] = 0;
-	}
+static void kimage_free_cma(struct kimage *image)
+{
+	unsigned long i;
 
+	for (i = 0; i < image->nr_segments; i++)
+		kexec_free_segment_cma(image, i);
 }
 
 void kimage_free(struct kimage *image)
-- 
2.34.1


