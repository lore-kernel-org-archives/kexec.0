Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9E7C46CD3
	for <kexec@archiver.kernel.org>; Fri, 29 Dec 2023 08:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nTcCOt3G8jr16GT2GBbYD0BdbX6knOx2Q3qXahtPK50=; b=lO+iDwp+4Hn601
	eLZ9VCEbQNrjbWbZe3FAfJXBrsAhQfCbjRdTnJ8zmFWY+oRHd+hUyYtmqMHiy1Arq4Fr5QveJgxC8
	KIN8/HvO084Qaaw9+14vkl1gYjGwnkdlde/inNcWQJSFSjlGhXbuIshzyZ6aJOS0nOfqReMfhnJlL
	3SjO920/YZohufW5F5AkEpX1WDrKVVj/VxZY+0pFBH/j8lhNw5hiHzSF7RpQT7nrFqQoaPoRvtRBn
	Sdd17xVQ91rBf2jti/xZq7f0V4pOd2GuDxWDHCaEWX2QA3cDkhhd54HO23S5X2w66I5NRF4om4l7c
	WV+y9JsJ6dfPSbQH13nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rJ7pN-000Pzt-09;
	Fri, 29 Dec 2023 08:02:45 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rJ7pK-000Pz0-0R
	for kexec@lists.infradead.org;
	Fri, 29 Dec 2023 08:02:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 83CBDCE169E;
	Fri, 29 Dec 2023 08:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2140C433C8;
	Fri, 29 Dec 2023 08:02:31 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Youling Tang <tangyouling@kylinos.cn>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] kdump: Defer the insertion of crashkernel resources
Date: Fri, 29 Dec 2023 16:02:13 +0800
Message-Id: <20231229080213.2622204-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231229_000242_544997_B781B45D 
X-CRM114-Status: UNSURE (   8.61  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

In /proc/iomem, sub-regions should be inserted after their parent,
otherwise the insertion of parent resource fails. But after generic
crashkernel reservation applied, in both RISC-V and ARM64 (LoongArch
will also use generic reservation later on), crashkernel resources are
inserted before their parent, which causes the parent disappear in
/proc/iomem. So we defer the insertion of crashkernel resources to an
early_initcall().

1, Without 'crashkernel' parameter:

 100d0100-100d01ff : LOON0001:00
   100d0100-100d01ff : LOON0001:00 LOON0001:00
 100e0000-100e0bff : LOON0002:00
   100e0000-100e0bff : LOON0002:00 LOON0002:00
 1fe001e0-1fe001e7 : serial
 90400000-fa17ffff : System RAM
   f6220000-f622ffff : Reserved
   f9ee0000-f9ee3fff : Reserved
   fa120000-fa17ffff : Reserved
 fa190000-fe0bffff : System RAM
   fa190000-fa1bffff : Reserved
 fe4e0000-47fffffff : System RAM
   43c000000-441ffffff : Reserved
   47ff98000-47ffa3fff : Reserved
   47ffa4000-47ffa7fff : Reserved
   47ffa8000-47ffabfff : Reserved
   47ffac000-47ffaffff : Reserved
   47ffb0000-47ffb3fff : Reserved

2, With 'crashkernel' parameter, before this patch:

 100d0100-100d01ff : LOON0001:00
   100d0100-100d01ff : LOON0001:00 LOON0001:00
 100e0000-100e0bff : LOON0002:00
   100e0000-100e0bff : LOON0002:00 LOON0002:00
 1fe001e0-1fe001e7 : serial
 e6200000-f61fffff : Crash kernel
 fa190000-fe0bffff : System RAM
   fa190000-fa1bffff : Reserved
 fe4e0000-47fffffff : System RAM
   43c000000-441ffffff : Reserved
   47ff98000-47ffa3fff : Reserved
   47ffa4000-47ffa7fff : Reserved
   47ffa8000-47ffabfff : Reserved
   47ffac000-47ffaffff : Reserved
   47ffb0000-47ffb3fff : Reserved

3, With 'crashkernel' parameter, after this patch:

 100d0100-100d01ff : LOON0001:00
   100d0100-100d01ff : LOON0001:00 LOON0001:00
 100e0000-100e0bff : LOON0002:00
   100e0000-100e0bff : LOON0002:00 LOON0002:00
 1fe001e0-1fe001e7 : serial
 90400000-fa17ffff : System RAM
   e6200000-f61fffff : Crash kernel
   f6220000-f622ffff : Reserved
   f9ee0000-f9ee3fff : Reserved
   fa120000-fa17ffff : Reserved
 fa190000-fe0bffff : System RAM
   fa190000-fa1bffff : Reserved
 fe4e0000-47fffffff : System RAM
   43c000000-441ffffff : Reserved
   47ff98000-47ffa3fff : Reserved
   47ffa4000-47ffa7fff : Reserved
   47ffa8000-47ffabfff : Reserved
   47ffac000-47ffaffff : Reserved
   47ffb0000-47ffb3fff : Reserved

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 kernel/crash_core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index d4313b53837e..755d8d4ef5b0 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -377,7 +377,6 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
 
 	crashk_low_res.start = low_base;
 	crashk_low_res.end   = low_base + low_size - 1;
-	insert_resource(&iomem_resource, &crashk_low_res);
 #endif
 	return 0;
 }
@@ -459,8 +458,19 @@ void __init reserve_crashkernel_generic(char *cmdline,
 
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
-	insert_resource(&iomem_resource, &crashk_res);
 }
+
+static __init int insert_crashkernel_resources(void)
+{
+	if (crashk_res.start < crashk_res.end)
+		insert_resource(&iomem_resource, &crashk_res);
+
+	if (crashk_low_res.start < crashk_low_res.end)
+		insert_resource(&iomem_resource, &crashk_low_res);
+
+	return 0;
+}
+early_initcall(insert_crashkernel_resources);
 #endif
 
 int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-- 
2.39.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
