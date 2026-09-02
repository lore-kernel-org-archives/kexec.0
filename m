Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6E6C624D4
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 07:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fTBZpbSvsidLVDHHiShy9f+wnGid6sRS2qRO19KqwKw=; b=XqiUWh9gJeP3WKDS2cxFEBSfk/
	av5vrUhWchaujxh7A2wWEnSJrOCjkRW692wVv96VuPdFtG7jVK+QQjTXnomyP0NI+EzrvMfGxIsX+
	JlRuity3GTrza0+qUFo2bZ8kXJZhT8H2kCvmFHTPCFafzZiSy4M1JEVynShW2JtK7G+eTsOazgS82
	tQAbPFjQyfdMreSj1YyB5d0LjmxJwsXWErJmVmcTZiErPJnzVOlniathLlCAmmGKxE07fss7mSFYa
	//S7NtMbVyJAwKSI56XXdAx9eQYpkcGyhL+L6AxMFGpzay/kW2mVfAQylCBOoAQnl93Vm7Ez9Hcap
	9TDYaTlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1fTO-0000000DwvZ-1ow3;
	Wed, 02 Sep 2026 07:33:30 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1fTH-0000000Dwq3-1DxY
	for kexec@bombadil.infradead.org;
	Wed, 02 Sep 2026 07:33:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=fTBZpbSvsidLVDHHiShy9f+wnGid6sRS2qRO19KqwKw=; b=mcd1UhqLYByV119WhK65zTs/Ph
	nuxSEarSkqF8p5tJzVKlnDbpk1tmgNCKPLG5jWsufZ+O7ySHZ3ooZMSYs1LcEPh4hf6ZPLfJzqW8I
	0ckIDKJLRPl6UUvyPy1+8O1AJGfOL6bMRVxsgz5uSKXCPmewpP7ryUtJk7R0LCntg9+8LX6jc08S6
	pGF7B8B9FvJH2KCJnF2cEmKMxXBegrdTQTR7vJawG2IiJsGYps5HxhTmEzxMp1F7hZrCLmEIk+AK6
	uuTlWF7EMEjMuqtruGv1DCFRk6GYWKaXZg0EdZxDdmYl12YtwyTbNizxUZTdpHteMGElDG8FreFvx
	jJfICE3Q==;
Received: from mail-pz2-x09.google.com ([2607:f8b0:4864:3b::9])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x1fTD-0000000Bh7k-3jUI
	for kexec@lists.infradead.org;
	Wed, 02 Sep 2026 07:33:22 +0000
Received: by mail-pz2-x09.google.com with SMTP id 41be03b00d2f7-cc1ddb3ba3eso440125a12.1
        for <kexec@lists.infradead.org>; Wed, 02 Sep 2026 00:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788334397; x=1788939197; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fTBZpbSvsidLVDHHiShy9f+wnGid6sRS2qRO19KqwKw=;
        b=NpdRcoLMRBJCdmLHNtRfXs3J9NarQ48ptrCBwogV0wbGKOqLjHDn/lgox7WkWQeGgV
         v6/qFCptlOyr3NgRX9kDbGXYVOwLNBQ0bjo5kPSliEqJy89SvQuMP2Fi4vf3P2E3cU6V
         cwIjhX3syemevrQQyB5ByE6n/k2nmRV2KwpNmqe5a11TJpoFNaMSrYIcc1rt8tii2N7A
         jOB2ezDilmJv/nUucG098+0cUw9axV39GTHahjxWOUDWnEgpiGt+USNWVWwbZDdIN8Sp
         jl6QnSJRiSIw9T+zUqfwklbSbfPgiKYfrR6Cl3gh73lhf3V2KJTolRfNRZJSBRWo7bRD
         4ncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788334397; x=1788939197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fTBZpbSvsidLVDHHiShy9f+wnGid6sRS2qRO19KqwKw=;
        b=bx8ZOS9TcXtYArlL24zpj/9Ee/G9cXkipQ5aTbMdV30YQV8GusAPyDgZy5pL1Z/nAv
         O4pkVcsOXQNMmhWEGr1LN2O5giFBxgs5SiinqKwmQqvcuFxMGtI0sZMhbqFXL62538FF
         WvsWtb1R9d/07e6h+IG5gM0kZRHmMwhWH4m7Vnnq+7ZK20MDj6si6p8wGm6tTvgfH2Uz
         iFnmBq9XebV63DZ8HWD1yM1YfcHgr0gMseLvORzDS3qzjFnroOBgWtKoDn5e0urSAobO
         iS8U2+Zgq4v21hHaR+Nzhomtm4IBr/ejue47VatbyoUy+fP+H4FmuVy6vCn2vKenftIF
         9+0Q==
X-Forwarded-Encrypted: i=1; AKwUvBzI+qS6ZNJHfN581/xd63ToWzmC+jka3zOYTl8DsApDyYqVku5F90aPsKWXqnopTFrA/NK+Pg==@lists.infradead.org
X-Gm-Message-State: AFuF++lvnwiaDouzXpl0HgZMBzHboOqYP5H9DZviJ44uhP9cj//we2kz
	cxnajkcbtKsOxicyHjm8Ua7FXiVyJvqfsNoWzZtjvDcUzS9DPohsnV1/
X-Gm-Gg: AYBFou2eOnzKCho6hxAAPtcsQBgjEFOSyRGu9GGubKKXmP84T6A6sAaJk9msbbkK7TL
	oJgpGjKJ3WvUXCI97vq52iTE+raGfFPg88F1Wa+Chn77f8RGLYj4j7Cei6du4EwssjcmgUrsGIl
	48HRCIyLG08l7zjgp/bHocoTTOXLl73WepW3/P4RLB4/M7x9zu26AggFr1H9UEVwzYrDE3wdQ9U
	fjWKXKQJwiB1Jn5wTpnbdyvjtUgHWs7Yu0ZFWJvFQEWfl8+1sFZrgy5Hy6B7mAZPfF7VAAj0GS3
	yuGGetysNPWs1XBCr44SObLChgOxRNXH+nyWQYaVh4lAWOV/ml5l9VJDjN+fCqyx1nrZ8nBchLN
	0MhqtySSkdwaAHkPMBk5rXQ/fb2bH++QhpRIi9sKsNYTHlDzZZzE1PtD3/eTm7yNJzDwtWFZthk
	APPkYqocbJ2LXDFS678i7NIHgDurQp2DjICnOyD6UjDD8KA4Bnns5LkQjN7o+ewB8oqOOXo7BqM
	zEvH8ZJl4I=
X-Received: by 2002:a05:6a00:4f83:b0:857:72f8:dc99 with SMTP id d2e1a72fcca58-85ed8fd714cmr4354975b3a.26.1788334396619;
        Wed, 02 Sep 2026 00:33:16 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db2adcbedsm926914b3a.20.2026.09.02.00.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:33:14 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	m.szyprowski@samsung.com
Cc: mark.rutland@arm.com,
	kernel@xen0n.name,
	alex@ghiti.fr,
	hpa@zytor.com,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH v6 08/10] of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
Date: Wed,  2 Sep 2026 15:31:14 +0800
Message-ID: <20260902073116.802752-9-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902073116.802752-1-chenwandun1@gmail.com>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_083320_488694_49F52A18 
X-CRM114-Status: GOOD (  13.76  )
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

From: Wandun Chen <chenwandun@lixiang.com>

Mark non-dumpable reserved-memory regions with MEMBLOCK_NODUMP so
kdump can omit them from the vmcore.

The marking is guarded by CONFIG_CRASH_DUMP so non-kdump kernels do not
pay the cost of splitting memblock.memory entries at NODUMP boundaries.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 drivers/of/fdt.c             |  1 +
 drivers/of/of_private.h      |  1 +
 drivers/of/of_reserved_mem.c | 15 +++++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index a64afc3ded3d..286fd4db6312 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1285,6 +1285,7 @@ void __init unflatten_device_tree(void)
 
 	/* Save the statically-placed regions in the reserved_mem array */
 	fdt_scan_reserved_mem_late();
+	fdt_mark_reserve_mem_nodump();
 
 	/* Populate an empty root node when bootloader doesn't provide one */
 	if (!fdt) {
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 0ae16da066e2..505735732c13 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -187,6 +187,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 
 int fdt_scan_reserved_mem(void);
 void __init fdt_scan_reserved_mem_late(void);
+void __init fdt_mark_reserve_mem_nodump(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 8c9d6395d6a3..f29a07e8fb23 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -677,6 +677,21 @@ static void __init fdt_init_reserved_mem_node(unsigned long node, const char *un
 	reserved_mem_count++;
 }
 
+void __init fdt_mark_reserve_mem_nodump(void)
+{
+	struct reserved_mem *rmem;
+	int i;
+
+	if (!IS_ENABLED(CONFIG_CRASH_DUMP))
+		return;
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		rmem = &reserved_mem[i];
+		if (rmem->size && !rmem->dumpable)
+			memblock_mark_nodump(rmem->base, rmem->size);
+	}
+}
+
 struct rmem_assigned_device {
 	struct device *dev;
 	struct reserved_mem *rmem;
-- 
2.43.0


