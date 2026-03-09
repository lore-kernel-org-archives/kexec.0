Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7415CEA8542
	for <kexec@archiver.kernel.org>; Mon,  9 Mar 2026 03:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=t3ndmHXGauxJDS4CGjqJ7QWuEKcJ5XQ5EkIe5CSnHwM=; b=p05AP123J9mngZr5EPe8rmRZOw
	WB5OSTVhaqKli7iZevh5LhibeZszpUj3ExZtwgwkMoob7rHEaTDz/sQuZ7mujSHNO9GQY7f5ZM29s
	u6tcNGT791lEEm1YaRZeOhZW0Ufn0LxQWJXicEIWjWirbacT6lG6VcxW3FHfhhS4aWvc3Jrtx0Jo0
	0QQEhpgAQOQP7snbt4hh8iEK7AIDhGFpQ7KJMslmAOahX4RLmYmrdYxEAHSVedeDRNvb0qa3X9GGa
	3btyZzIiA+UlkjsN37GRRRXbqjvvyq7e4D+bobKtuYTOELz0SUCxN94h5xZFXoie6QPvvDreqdHmg
	vn40C5zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzRQf-00000006bgH-2aDW;
	Mon, 09 Mar 2026 03:37:13 +0000
Received: from m16.mail.163.com ([117.135.210.2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzRQb-00000006bfv-1R3K
	for kexec@lists.infradead.org;
	Mon, 09 Mar 2026 03:37:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=t3
	ndmHXGauxJDS4CGjqJ7QWuEKcJ5XQ5EkIe5CSnHwM=; b=hoaJWPfPXNVXybqq+W
	reo4bRfQfdtqU0ZM7nEflYp6UjOLydJN3U3ZMfc/YocFwi+m+jtenipADQxOMWFm
	iR7af+As1v7xhqO+4+Ae/ehPzJd1DHmrgfqWlmIO/hZ0c9K3/ZPkJg5fyg/WQNEe
	VcTbinJN1WE/U/J0EMk1IfeQI=
Received: from ubuntu24-z.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3KbcFQK5pXpqWPQ--.7196S2;
	Mon, 09 Mar 2026 11:35:33 +0800 (CST)
From: ranxiaokai627@163.com
To: graf@amazon.com,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	pratyush@kernel.org,
	pasha.tatashin@soleen.com,
	jasonmiu@google.com
Cc: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com
Subject: [PATCH] kho: fix child node parsing for debugfs in/sub_fdts
Date: Mon,  9 Mar 2026 03:35:30 +0000
Message-ID: <20260309033530.244508-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3KbcFQK5pXpqWPQ--.7196S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF4ftw43Gw1fKF4xCr4fAFb_yoW8WF18p3
	WkCF1DJw4UAw1YvFyFk3WFy34fX3ykXw15ta4v9343Ar13trn3Xa95uFW3KryxZ395KF15
	KF1Yqa4FvF1UWFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pinjjfUUUUU=
X-Originating-IP: [117.176.242.62]
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbCxgUXY2muQAUN3gAA3m
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260308_203710_762738_C443BCA6 
X-CRM114-Status: UNSURE (   9.94  )
X-CRM114-Notice: Please train this message.
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

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

Commit e0c1731f5d57 ("kho: adopt radix tree for preserved memory tracking")
changed KHO_FDT_SUB_TREE_PROP_NAME from "fdt" to "preserved-data". However,
kho debugfs code still hard-coded the "fdt" string when parsing the
device tree, causing the debugfs node /debugfs/kho/in/sub_fdts/
fail to parse child nodes correctly.

Fix this by including the header file and using KHO_FDT_SUB_TREE_PROP_NAME
instead of the hard-coded string.

Fixes: e0c1731f5d57 ("kho: adopt radix tree for preserved memory tracking")
Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 kernel/liveupdate/kexec_handover_debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
index 3f395fbd978f..acf368222682 100644
--- a/kernel/liveupdate/kexec_handover_debugfs.c
+++ b/kernel/liveupdate/kexec_handover_debugfs.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <linux/libfdt.h>
 #include <linux/mm.h>
+#include <linux/kho/abi/kexec_handover.h>
 #include "kexec_handover_internal.h"
 
 static struct dentry *debugfs_root;
@@ -121,7 +122,7 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 		const char *name = fdt_get_name(fdt, child, NULL);
 		const u64 *fdt_phys;
 
-		fdt_phys = fdt_getprop(fdt, child, "fdt", &len);
+		fdt_phys = fdt_getprop(fdt, child, KHO_FDT_SUB_TREE_PROP_NAME, &len);
 		if (!fdt_phys)
 			continue;
 		if (len != sizeof(*fdt_phys)) {
-- 
2.25.1


