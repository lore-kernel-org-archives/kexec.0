Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6108DCCA489
	for <kexec@archiver.kernel.org>; Tue, 26 Jul 2022 09:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vPxL9wI7eNYQ8sXD/NXD0M9AqYYdhBeHj9qS91dNO3Y=; b=2MCz4olBItaPiF
	SfZ8oJPaQPCmDWd46FuCroGww6w7CJqknlVoGC4drdKbyOvyKz7O+F7ZjtMqLWcpOYEhCu1lQ93cP
	U3xY4z3/rWqLrXv4pH/Eb3UaLJIU0Arej93m7vLufbOzqWicttHk4cW0yZC4zUSC0C67kgQ4YcT5Y
	98/Iirbe/Cz7kZnEuaxjJlO8LZA80fJHAoFtlwJumYfWSFl1NwQFw5Iv7rTQikWbz1UX/Jqpy6iHg
	LNuO3z86zTG6iH556hoIUAZZRZgGJOj37p7ilaUZIoxsEIdVb9lERMEjSgA4WEgJS9vHWhp2/2Ncg
	SuMmHhpDTcwEDatkpW2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGH1U-00Bg3l-Mk; Tue, 26 Jul 2022 09:38:40 +0000
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGH0b-00BehU-Cl; Tue, 26 Jul 2022 09:37:47 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VKUwha8_1658828258;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VKUwha8_1658828258)
          by smtp.aliyun-inc.com;
          Tue, 26 Jul 2022 17:37:39 +0800
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
	corbet@lwn.net
Cc: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	crash-utility@redhat.com,
	huanyi.xj@alibaba-inc.com,
	heinrich.schuchardt@canonical.com,
	k-hagio-ab@nec.com,
	hschauhan@nulltrace.org,
	Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH V4 5/5] riscv: crash_core: Export kernel vm layout, phys_ram_base
Date: Tue, 26 Jul 2022 17:37:29 +0800
Message-Id: <20220726093729.1231867-6-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220726093729.1231867-1-xianting.tian@linux.alibaba.com>
References: <20220726093729.1231867-1-xianting.tian@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220726_023745_692348_9E000D72 
X-CRM114-Status: UNSURE (   7.00  )
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

These infos are needed by the kdump crash tool. Since these values change
from time to time, it is preferable to export them via vmcoreinfo than to
change the crash's code frequently.

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 .../admin-guide/kdump/vmcoreinfo.rst          | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 8419019b6a88..6b76284a503c 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -595,3 +595,34 @@ X2TLB
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
+Indicates the virtual kernel start address of direct-mapped RAM region.
+
+phys_ram_base
+-------------
+
+Indicates the start physical RAM address.
+
+MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END
+-----------------------------------------------------------------------------
+KASAN_SHADOW_START|KASAN_SHADOW_END|KERNEL_LINK_ADDR|ADDRESS_SPACE_END
+----------------------------------------------------------------------
+
+Used to get the correct ranges:
+	MODULES_VADDR ~ MODULES_END : Kernel module space.
+	VMALLOC_START ~ VMALLOC_END : vmalloc() / ioremap() space.
+	VMEMMAP_START ~ VMEMMAP_END : vmemmap region, used for struct page array.
+	KASAN_SHADOW_START ~ KASAN_SHADOW_END : kasan shadow space.
+	KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END : Kernel link and BPF space.
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
