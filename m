Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13D8C982DE
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 09:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oJTPjIaIqy30CyW5gdpqj1ltYgKaERSOMcSOuwRttqY=; b=kNBlRrzVC3PEoj8egUCkP3RLCa
	bET8LG8qD7/EdS+s679ZFimm7RVophkvi5XMnOFZ75bgUhtmn8M6DtoPjt/9v0vwcJTniICcC5+Ee
	8N7T02hf1lhNEtR7VHQPhJaZWtxmlID25+ujJXuupqH8Mj/LI37EE272NcGed6w1AyZdrGSkPXivU
	3HIIWFCoIYaY5GL6eUol0Jza7pD7n7dvJjbVfPEcY+tyTaP/saredExvCmnCNa6YTS9OEbkR4dtOB
	DkgOGNnqg9Yd9LHCNxGBD+L/VOlfDCB8lSFOnRb5y6aWaK4NDDk/2OdZIBJxdxRDrMWkEfGMEjAYU
	1kV+dlrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ad7-00000001ZV8-1LeD;
	Mon, 21 Sep 2026 09:48:09 +0000
Received: from canpmsgout10.his.huawei.com ([113.46.200.225])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Zwn-00000001RRR-1xxU;
	Mon, 21 Sep 2026 09:04:28 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oJTPjIaIqy30CyW5gdpqj1ltYgKaERSOMcSOuwRttqY=;
	b=Xk3K1Lag16/7PUJwSJwRKAWcXn51YKwa9K4bTVig/jzNn34hk7LewtIKmtx+01VSKzFVqRzzQ
	wGiFlBwGpaMhKzr9S/eyYz1vcdeUtXIbZr9e9FiAHiBznYDu4EF1evoWFkMInlmtdm/yuNtiMKX
	/P1HTZPUO81RTQgB5/AToOM=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hpH7b1rDqz1K9D2;
	Mon, 21 Sep 2026 16:53:15 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 2860E40586;
	Mon, 21 Sep 2026 17:04:17 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 17:04:15 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <robh@kernel.org>, <coxu@redhat.com>,
	<kees@kernel.org>, <tangyouling@kylinos.cn>, <liukexin@kylinos.cn>,
	<zhangtianyang@loongson.cn>, <guodongtai@kylinos.cn>,
	<maqianga@uniontech.com>, <chao.gao@intel.com>, <kai.huang@intel.com>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <piliu@redhat.com>,
	<thuth@redhat.com>, <jbouron@amazon.com>, <me@linux.beauty>,
	<mclapinski@google.com>, <graf@amazon.com>, <bgwin@google.com>,
	<hbathini@linux.ibm.com>, <eric.devolder@oracle.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <palmer@rivosinc.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <driver-core@lists.linux.dev>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v6 11/14] crash: Factor out crash_find_elfcorehdr() helper
Date: Mon, 21 Sep 2026 17:04:47 +0800
Message-ID: <20260921090450.807575-12-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921090450.807575-1-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_020425_837826_53B5FCDE 
X-CRM114-Status: GOOD (  12.98  )
X-Mailman-Approved-At: Mon, 21 Sep 2026 02:47:56 -0700
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

The elfcorehdr segment is located by scanning the segments for
the ELF magic. Factor that scan out into a new helper function,
crash_find_elfcorehdr(), to clean up crash_handle_hotplug_event()
and prepare for its reuse in crash hotplug code.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Dave Young <ruirui.yang@linux.dev>
Cc: Breno Leitao <leitao@debian.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/crash_core.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 406b68d2adfd..4a990b17b66c 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -647,6 +647,28 @@ int crash_check_hotplug_support(void)
 	return rc;
 }
 
+static void crash_find_elfcorehdr(struct kimage *image)
+{
+	unsigned char *ptr;
+	unsigned long mem;
+	unsigned int n;
+
+	if (image->elfcorehdr_index >= 0)
+		return;
+
+	for (n = 0; n < image->nr_segments; n++) {
+		mem = image->segment[n].mem;
+		ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+		if (!ptr)
+			continue;
+
+		/* The segment containing elfcorehdr */
+		if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
+			image->elfcorehdr_index = (int)n;
+		kunmap_local(ptr);
+	}
+}
+
 /*
  * To accurately reflect hot un/plug changes of CPU and Memory resources
  * (including onling and offlining of those resources), the relevant
@@ -702,22 +724,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
 	 * is allocated. Find the segment containing the elfcorehdr,
 	 * if not already found.
 	 */
-	if (image->elfcorehdr_index < 0) {
-		unsigned long mem;
-		unsigned char *ptr;
-		unsigned int n;
-
-		for (n = 0; n < image->nr_segments; n++) {
-			mem = image->segment[n].mem;
-			ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
-			if (ptr) {
-				/* The segment containing elfcorehdr */
-				if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
-					image->elfcorehdr_index = (int)n;
-				kunmap_local(ptr);
-			}
-		}
-	}
+	crash_find_elfcorehdr(image);
 
 	if (image->elfcorehdr_index < 0) {
 		pr_err("unable to locate elfcorehdr segment");
-- 
2.34.1


