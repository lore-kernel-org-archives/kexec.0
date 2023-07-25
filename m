Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C11FC0015E
	for <kexec@archiver.kernel.org>; Tue, 25 Jul 2023 13:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RNGDGQi91UrbaXZ1sK8Tap8PewJtx0B6wXZzkIOBfoU=; b=ZDLhZQC81mQDZf
	G6u1FvFfm0Nwm5ungQJD7no8KeH0Crl9rCoLmaiYlKjh9RBoBkDuReKgvilpcL6D9JqscxQIFteTp
	ZUDigFVS9WgdwTg5zRlDd3uMhlCdnXsZLQCLThfDYjdPFmO9w0k/uNZeiYbYzb3ur62EiKh6GpZmY
	1Rx6l6IcT6IfS03UBu+NnBkKhpAsTEn3ePrp7o4gBI0cq6f0dfWRIngfJpOlUbdWmkU/14CZauZy9
	vPrutb325ZHVRm/WFXFCCgRpzKHuqGCzLt1P8mMzANgwBqFEA/LptBLZ39n5Y8jeMNLE57CXGpTT9
	6a7wMTnvFKH3p/ZE3jLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOILr-007ftd-05;
	Tue, 25 Jul 2023 13:45:23 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOILn-007fsJ-1H;
	Tue, 25 Jul 2023 13:45:21 +0000
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R9JD12p5PzrS0t;
	Tue, 25 Jul 2023 21:44:17 +0800 (CST)
Received: from huawei.com (10.67.174.205) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 21:45:09 +0800
From: Chen Jiahao <chenjiahao16@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<conor.dooley@microchip.com>, <guoren@kernel.org>, <heiko@sntech.de>,
	<bjorn@rivosinc.com>, <alex@ghiti.fr>, <akpm@linux-foundation.org>,
	<atishp@rivosinc.com>, <bhe@redhat.com>, <thunder.leizhen@huawei.com>,
	<horms@kernel.org>
CC: <chenjiahao16@huawei.com>
Subject: [PATCH -next v8 2/2] docs: kdump: Update the crashkernel description for riscv
Date: Tue, 25 Jul 2023 21:44:12 +0000
Message-ID: <20230725214413.2488159-3-chenjiahao16@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725214413.2488159-1-chenjiahao16@huawei.com>
References: <20230725214413.2488159-1-chenjiahao16@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.67.174.205]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230725_064519_869327_534D0805 
X-CRM114-Status: GOOD (  11.20  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Now "crashkernel=" parameter on riscv has been updated to support
crashkernel=X,[high,low]. Through which we can reserve memory region
above/within 32bit addressible DMA zone.

Here update the parameter description accordingly.

Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d3e762b3ad01..275cf32e9919 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -862,7 +862,7 @@
 			memory region [offset, offset + size] for that kernel
 			image. If '@offset' is omitted, then a suitable offset
 			is selected automatically.
-			[KNL, X86-64, ARM64] Select a region under 4G first, and
+			[KNL, X86-64, ARM64, RISCV] Select a region under 4G first, and
 			fall back to reserve region above 4G when '@offset'
 			hasn't been specified.
 			See Documentation/admin-guide/kdump/kdump.rst for further details.
@@ -875,14 +875,14 @@
 			Documentation/admin-guide/kdump/kdump.rst for an example.
 
 	crashkernel=size[KMG],high
-			[KNL, X86-64, ARM64] range could be above 4G. Allow kernel
-			to allocate physical memory region from top, so could
-			be above 4G if system have more than 4G ram installed.
-			Otherwise memory region will be allocated below 4G, if
-			available.
+			[KNL, X86-64, ARM64, RISCV] range could be above 4G.
+			Allow kernel to allocate physical memory region from top,
+			so could be above 4G if system have more than 4G ram
+			installed. Otherwise memory region will be allocated
+			below 4G, if available.
 			It will be ignored if crashkernel=X is specified.
 	crashkernel=size[KMG],low
-			[KNL, X86-64, ARM64] range under 4G. When crashkernel=X,high
+			[KNL, X86-64, ARM64, RISCV] range under 4G. When crashkernel=X,high
 			is passed, kernel could allocate physical memory region
 			above 4G, that cause second kernel crash on system
 			that require some amount of low memory, e.g. swiotlb
@@ -893,6 +893,7 @@
 			size is	platform dependent.
 			  --> x86: max(swiotlb_size_or_default() + 8MiB, 256MiB)
 			  --> arm64: 128MiB
+			  --> riscv: 128MiB
 			This one lets the user specify own low range under 4G
 			for second kernel instead.
 			0: to disable low allocation.
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
