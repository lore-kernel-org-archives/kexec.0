Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6195CFA373E
	for <kexec@archiver.kernel.org>; Wed, 26 Oct 2022 14:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gl0yQtgtYWgUTg2P6JgP9Sy5TBP83RuceoEASLCK3vE=; b=nPlTC/AYKM3daQ
	5as9F+RBfTvT+wxmupCwZKkPzzTKhjy2u8cD7BEPTYIBzIUIgNSb8j4UaEbiP25mfcbGOWiEOytlF
	UCHHgo6rEYTuWbgg5LMtQBY3hvZWPddvtDa0pRPlCQ7iCisAvNwmdKF8tSqcHfS3PnRPXa6lwi5Hg
	n/uLS4e86sEWyWS+UbRG03PjFq/XKNmzlNlwgg7a8EcfmywPhLZvXn2jQl3h7a+xvrPKl5SdNcarE
	IANEIeOCbyc/Z1RViYocWaN8bqfuoJXlOmWbgRKHSx5dbWQjfUXdwZFP79jBye73tclyjPaWTDLus
	vPPNiAk2ezK8fISp23aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onhcD-009iAY-KL; Wed, 26 Oct 2022 14:42:45 +0000
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onhcB-009i58-0M; Wed, 26 Oct 2022 14:42:44 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VT7dcpZ_1666795345;
Received: from localhost.localdomain(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VT7dcpZ_1666795345)
          by smtp.aliyun-inc.com;
          Wed, 26 Oct 2022 22:42:26 +0800
From: Xianting Tian <xianting.tian@linux.alibaba.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	anup@brainfault.org,
	heiko@sntech.de,
	guoren@kernel.org,
	mick@ics.forth.gr,
	alexandre.ghiti@canonical.com,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	corbet@lwn.net,
	Conor.Dooley@microchip.com,
	bagasdotme@gmail.com
Cc: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	crash-utility@redhat.com,
	heinrich.schuchardt@canonical.com,
	k-hagio-ab@nec.com,
	hschauhan@nulltrace.org,
	yixun.lan@gmail.com,
	Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH V5 2/2] Documentation: kdump: describe VMCOREINFO export for RISCV64
Date: Wed, 26 Oct 2022 22:42:08 +0800
Message-Id: <20221026144208.373504-3-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221026144208.373504-1-xianting.tian@linux.alibaba.com>
References: <20221026144208.373504-1-xianting.tian@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_074243_278344_A4B3AACF 
X-CRM114-Status: UNSURE (   5.75  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The following interrelated definitions and ranges are needed by the kdump
crash tool, which are exported by "arch/riscv/kernel/crash_core.c":
    VA_BITS,
    PAGE_OFFSET,
    phys_ram_base,
    KERNEL_LINK_ADDR,
    MODULES_VADDR ~ MODULES_END,
    VMALLOC_START ~ VMALLOC_END,
    VMEMMAP_START ~ VMEMMAP_END,

Document these RISCV64 exports above.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 .../admin-guide/kdump/vmcoreinfo.rst          | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 6726f439958c..86fd88492870 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -595,3 +595,32 @@ X2TLB
 -----
 
 Indicates whether the crashed kernel enabled SH extended mode.
+
+RISCV64
+=======
+
+VA_BITS
+-------
+
+The maximum number of bits for virtual addresses. Used to compute the
+virtual memory ranges.
+
+PAGE_OFFSET
+-----------
+
+Indicates the virtual kernel start address of the direct-mapped RAM region.
+
+phys_ram_base
+-------------
+
+Indicates the start physical RAM address.
+
+MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END|KERNEL_LINK_ADDR
+----------------------------------------------------------------------------------------------
+
+Used to get the correct ranges:
+
+  * MODULES_VADDR ~ MODULES_END : Kernel module space.
+  * VMALLOC_START ~ VMALLOC_END : vmalloc() / ioremap() space.
+  * VMEMMAP_START ~ VMEMMAP_END : vmemmap space, used for struct page array.
+  * KERNEL_LINK_ADDR : start address of Kernel link and BPF
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
