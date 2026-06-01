Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EC7CD6E64
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 15:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8EnmU9JMCid8f25OUQXP00boV0OiTYhaVmjNgi7O15U=; b=I6sK4Nr19HfJGXQG8lDu44CABi
	CZDMytyS8/ONTyGyAC3kS1AvnGL8UK80vDDtC+LQpM9gEjWOKRgSODb3k0q5PdGcbDveE6/uRLokG
	0M/c2beKUg10cz8zhxponWRm9tvyE2ilVSUo/sJXFqea2Oji9jpSxZ16BozQublF0kSlvkobSA6Kt
	9Q9kV4K0mfr7TfiLTYOMhkNCHydgcZP26Bi7XuEf5WyAXvCysz87fftMdNc+g8kA4E8Mwrl0ngxBU
	IX4xtF1VaucJlXsZ9oeU6FctLyOLb/5muNMVNq10hAuUF9oczSaA9Jl00lzZ4hCQN/ZhQM7FVjKvI
	PyzspHkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUQrx-0000000DIfI-3oRe;
	Tue, 02 Jun 2026 15:17:29 +0000
Received: from canpmsgout05.his.huawei.com ([113.46.200.220])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTzGN-0000000AWic-3uvH;
	Mon, 01 Jun 2026 09:48:53 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8EnmU9JMCid8f25OUQXP00boV0OiTYhaVmjNgi7O15U=;
	b=FxpfysxrDR9Z3N/z2FzLQ1redjsb8v9bYZrgwkOLY1V7vvU9WSoFF5k9qkeJwx1wfpRWLcpVx
	swZvy2I8bsFWOiKD4o+W6S6rk20znDPInkJynNfB+gPu1Dd8JseMuHQSc1kNWZ6yZFBauRJxmHj
	33qeJTuPJ77dl1V2na7GErY=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gTTVD753tz12LGX;
	Mon,  1 Jun 2026 17:40:52 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id CDEA2201E9;
	Mon,  1 Jun 2026 17:48:49 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 1 Jun
 2026 17:48:45 +0800
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
Subject: [PATCH v15 04/23] powerpc/kexec_file: Fix memory range truncation in __merge_memory_ranges()
Date: Mon, 1 Jun 2026 17:47:46 +0800
Message-ID: <20260601094805.2928614-5-ruanjinjie@huawei.com>
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
X-CRM114-CacheID: sfid-20260601_024852_283387_23407842 
X-CRM114-Status: GOOD (  14.93  )
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

Sashiko AI review pointed out the following issue.

The __merge_memory_ranges() function incorrectly handles overlapping
memory ranges when merging them. Although sort_memory_ranges() sorts all
ranges by their start address in ascending order beforehand, the merge
logic remains defective in two ways:

1. It compares the current range's start against the previous element (i-1)
   instead of the running target index (idx)

2. It unconditionally overwrites 'ranges[idx].end' with 'ranges[i].end'.

This logic flaw leads to critical memory truncation when a larger memory
range completely subsumes subsequent smaller ranges.

For example, consider a sorted input array with three ranges:
  Range A (idx=0): [0x1000 - 0x9000]
  Range B (i=1):   [0x2000 - 0x5000] (completely inside Range A)
  Range C (i=2):   [0x6000 - 0x8000] (completely inside Range A)

1. When i=1 (Range B):
   ranges[1].start (0x2000) <= ranges[0].end + 1 (0x9001) is TRUE.
   The code executes: ranges[0].end = ranges[1].end, which erroneously
   shrinks Range A's end from 0x9000 down to 0x5000.

2. When i=2 (Range C):
   ranges[2].start (0x6000) <= ranges[1].end + 1 (0x5001) is FALSE.
   The code falls into the else block, creating a broken new range.

As a result, valid memory fragments [0x5001 - 0x5fff] and [0x8001 - 0x9000]
are completely lost from the kexec exclude lists, potentially allowing
the crash kernel to overwrite active memory, causing data corruption
or crashes.

Fix this by ensuring the start of the current range is compared against the
end of the active merged range (idx), and use max() to safely prevent the
outer boundary from being truncated.

Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org
Fixes: 180adfc532a8 ("powerpc/kexec_file: Add helper functions for getting memory ranges")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/powerpc/kexec/ranges.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
index 867135560e5c..eb45e89502ca 100644
--- a/arch/powerpc/kexec/ranges.c
+++ b/arch/powerpc/kexec/ranges.c
@@ -21,6 +21,7 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/memblock.h>
+#include <linux/minmax.h>
 #include <linux/crash_core.h>
 #include <asm/sections.h>
 #include <asm/kexec_ranges.h>
@@ -105,19 +106,16 @@ static void __merge_memory_ranges(struct crash_mem *mem_rngs)
 	struct range *ranges;
 	int i, idx;
 
-	if (!mem_rngs)
+	if (!mem_rngs || mem_rngs->nr_ranges <= 1)
 		return;
 
 	idx = 0;
-	ranges = &(mem_rngs->ranges[0]);
+	ranges = mem_rngs->ranges;
 	for (i = 1; i < mem_rngs->nr_ranges; i++) {
-		if (ranges[i].start <= (ranges[i-1].end + 1))
-			ranges[idx].end = ranges[i].end;
+		if (ranges[i].start <= (ranges[idx].end + 1))
+			ranges[idx].end = max(ranges[idx].end, ranges[i].end);
 		else {
 			idx++;
-			if (i == idx)
-				continue;
-
 			ranges[idx] = ranges[i];
 		}
 	}
-- 
2.34.1


