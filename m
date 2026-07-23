Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4369C531CF
	for <kexec@archiver.kernel.org>; Thu, 23 Jul 2026 13:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m/t6g6wgy8f4j81AeTyq8Xtlv7t4otXq+WwFPCZjeiE=; b=F7cjCD4MTfom2Ib6PWW1s96plq
	50PcOqXxz3IDVkHhk/9/+a9NVxyP0Oc8ZaPpptAH/E8r4hjvVI7mdVmzhuX76sEfV2Gu/FakI1Y0D
	xu/MiE+9w9I7cnoiEu5ZXguOHldlMYal8LSMnS6JjU77PfNrgOVbgllaBzLUo6cd1U7lIDSM4rbKI
	1TTIenMqau7dURuhYKWejq5u/XdiRQOWImEt8Od5hFjKWT0i3+u2lH/gkBEC+ccddhn5vmEDwelcu
	9/r+uKLztgla86jJSQoqkeiD5eAbcg7jVAJj2ejQawUfqcb0Jmzu/+m2K/COnlH8DUK6xEYXzkGO/
	BduAva0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmtEK-0000000EKnH-1y4g;
	Thu, 23 Jul 2026 13:12:52 +0000
Received: from canpmsgout02.his.huawei.com ([113.46.200.217])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmtEF-0000000EKkL-417W;
	Thu, 23 Jul 2026 13:12:50 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=m/t6g6wgy8f4j81AeTyq8Xtlv7t4otXq+WwFPCZjeiE=;
	b=zezNzsembULU7OU1aBZKtmlXYMfqiyhuVd/0EUpFld6FoKfxvHy2SHqOb479kLgfg3L85Cdx8
	mFcP9trpiR6AmY+SzOas+7DcEuqhunASSnlRjjHpU37cVuiHPs/aDYZIE2xooHwPbR2Wc2GwkHB
	XJSpwQlYQPqIbe7aKweQzg0=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4h5WWc5Fbbzcb2y;
	Thu, 23 Jul 2026 21:03:08 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 970464057D;
	Thu, 23 Jul 2026 21:12:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Jul
 2026 21:12:37 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<akpm@linux-foundation.org>, <baoquan.he@linux.dev>, <rppt@kernel.org>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <thuth@redhat.com>,
	<ruanjinjie@huawei.com>, <vladimir.murzin@arm.com>, <mark.rutland@arm.com>,
	<ardb@kernel.org>, <james.morse@arm.com>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <robh@kernel.org>, <kees@kernel.org>,
	<coxu@redhat.com>, <sourabhjain@linux.ibm.com>, <ritesh.list@gmail.com>,
	<adityag@linux.ibm.com>, <hbathini@linux.ibm.com>, <makb@juniper.net>,
	<piliu@redhat.com>, <graf@amazon.com>, <liaoyuanhong@vivo.com>,
	<jbouron@amazon.com>, <bauerman@linux.ibm.com>, <bgwin@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <kexec@lists.infradead.org>
Subject: [PATCH 2/8] powerpc/kexec_file: Fix null-ptr-def in extra size calculation
Date: Thu, 23 Jul 2026 21:12:36 +0800
Message-ID: <20260723131242.1537633-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723131242.1537633-1-ruanjinjie@huawei.com>
References: <20260723131242.1537633-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_061248_459939_BC2C612A 
X-CRM114-Status: GOOD (  12.06  )
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

A static Sashiko AI review identified a potential NULL pointer
dereference in kexec_extra_fdt_size_ppc64().

On platforms without any reserved memory regions,
get_reserved_memory_ranges() can return 0 while leaving 'rmem'
unallocated as NULL. Passing it directly leads to a kernel panic when
evaluating 'rmem->nr_ranges'.

Add a NULL check for 'rmem' to prevent this crash.

Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org
Fixes: 0d3ff067331e ("powerpc/kexec_file: fix extra size calculation for kexec FDT")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/powerpc/kexec/file_load_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 8c72e12ea44e..6075b1c88511 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -664,7 +664,7 @@ unsigned int kexec_extra_fdt_size_ppc64(struct kimage *image, struct crash_mem *
 		extra_size += (cpu_nodes - boot_cpu_node_count) * cpu_node_size();
 
 	/* Consider extra space for reserved memory ranges if any */
-	if (rmem->nr_ranges > 0)
+	if (rmem && rmem->nr_ranges > 0)
 		extra_size += sizeof(struct fdt_reserve_entry) * rmem->nr_ranges;
 
 	return extra_size + kdump_extra_fdt_size_ppc64(image, cpu_nodes);
-- 
2.34.1


