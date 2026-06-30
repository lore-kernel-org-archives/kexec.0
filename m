Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670C5C43327
	for <kexec@archiver.kernel.org>; Tue, 30 Jun 2026 07:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kilHQAUiYtCIXGoXTLzkG+QFNETPWES64QJavnYCw8Q=; b=rhRaD0bwMbUCw3Dnn7Q0k/84q1
	sNqppABceBypNA7OBf+OHKUZHDQa9whCY5AMkqi1P+6Xso8mAYYLwDFpkyNpgzIdmv4TGiq4/khzv
	pq1mPgOiEBy4ISIq+vXN57Mox3jeIkRvHhW0edOEsR/GKSX5/KzPN3K3E+3NXn2uPexLT6iL5ZbjE
	Sji68O6Ew2ZTS3DHntIhXHXO/Xkd2Xsx/q6um4kIpe9iU+cGY5Bs6DHaPSpfB2NyaIBV+yEi9ezU3
	IGkdxLfvuukQfm2hZHvJc1PaF2LzdsTma0LUNpIT50YhtA6HI81vGHZ3y6Jg8EP5VkjrubIXYQFB/
	rhEMvjbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weTDL-0000000GAfR-39S6;
	Tue, 30 Jun 2026 07:49:03 +0000
Received: from mail-pj2-x04.google.com ([2607:f8b0:4864:39::4])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weTDA-0000000GAJB-1Fld
	for kexec@lists.infradead.org;
	Tue, 30 Jun 2026 07:48:57 +0000
Received: by mail-pj2-x04.google.com with SMTP id d9443c01a7336-2c99784b434so2273855ad.0
        for <kexec@lists.infradead.org>; Tue, 30 Jun 2026 00:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782805731; x=1783410531; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kilHQAUiYtCIXGoXTLzkG+QFNETPWES64QJavnYCw8Q=;
        b=Lxa3SNLewfjO1XWJBqKFQQAD+AD3/E18whJvgN/xGrbdPwTASdXJwiXHSP35YSqv00
         pT5FLKLDQUEgygiJTtGJl9UvOuDnTz0Kgiux5x+E7lWwZU4tbjr3JHsOuC4wpJMVMBKX
         zAi9dHNOKWrM7Qa72WowRkzpSlcstIWrMXSLV0u/7TJAKhs0B8c5uBOa2DxoHoTq88tR
         +bmwdZaUew2XBwS8ZsTXlLF3wdjVjnilBKErPP2S2mmzXCGpW4aUH0thzsDRInhyvnRq
         XbEjTnqNGhNxhf0LbvnvmLlHPKNzRsxs1s/exgazcnSqMG1ewH6Fa4bZcnOHYPACGVJd
         vusg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782805731; x=1783410531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kilHQAUiYtCIXGoXTLzkG+QFNETPWES64QJavnYCw8Q=;
        b=mIlAbTGVLVakh+aFJzRctL/JLD65IQ9PEOJ9TwXjAIj1jjqgre2L7ZXbI04Xuwv3uv
         GfpK3PD6DWhOMyI8gBVawN57vLp9WC4iX90CWv9r5HdbM5htRNUrMBIWCUqbymz/9DgY
         X9K251pVea1e71RqUdFeT+snYVU7jIUHY0qat8ztCLQStYJ6uPdAI3Af+H0Nag1TE9jZ
         m5/3mabZu3UvUTndIQ6pV1FAvFz04aJZSED4uh37m1HsaFFULcwmtTjLO2evdMTQf0uU
         GxdOphGYoyCSD2a5BsgLrdEzxIQMD5nUC13MNTTacbn25MEBpOcdfc8fF0bwnX1872Rc
         RBcA==
X-Forwarded-Encrypted: i=1; AHgh+Rr8R8pybBiZdfgr780d+gQY2v0xoNDzMXgtLWDdE2m+5HTGtd+Py5cpFQOeNQjx4p4bIFAa5Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YwVWvy61CYfdy/mqO9wXW+q+J1O+wwMx6lrrROs8t18XvkK+Z8H
	JBo+E7rJGIFYCnSqRs+N8tDBnaw3qRXHQEvJ2Mf5v0AVXtfIk/WB0fzj
X-Gm-Gg: AfdE7ckUDZSTZbpDsDAw+5tsDvrYATo/fEaVjSdloNW3dAcPNy6Vca11dfsD9fw4g1F
	+ospUpQsleNedwwwSjmQjElD4OJeGeXGqWQwIAApUDQXjtIGYdkJ5LIprIDa5vehoI6Kj/vUkJt
	fS17B5T0amd8xc59fn80W0WOAMyFhUigl2knNDYq7uF5oG/JW+gz51MKaEt/iKtFBEDSfp/wCrl
	bKPETevXbFgeG2pZtUxL5luXk1DpnTXEvCIivrVZ+7gvVzaA8K6Y8ViB0zd9CKQFQrNaZX8hLiW
	JzYo7wzwMoPk5dMeE5d5uOEvKyjOuk1vzOyWlxvLdzMjzPVf4z011MTWRsCQWJZmSmNhlQETMwa
	yFQ+Kvjwf0CnmRyLc1tccZaIG/PHDphGZ/0s+53bXWyGtaIaTRCg3HdCWZz05i03fRcc7au8bAn
	RuJgu18PY5NbHeoAhbJ94E5WkZXA==
X-Received: by 2002:a17:902:dad1:b0:2c9:d55d:2d3 with SMTP id d9443c01a7336-2ca2d55dedbmr19212325ad.15.1782805731371;
        Tue, 30 Jun 2026 00:48:51 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382a2d3dsm7821045ad.55.2026.06.30.00.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:48:50 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	saravanak@kernel.org,
	bhe@redhat.com,
	rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Subject: [PATCH v4 08/10] arm64: kdump: exclude non-dumpable reserved memory regions from vmcore
Date: Tue, 30 Jun 2026 15:47:12 +0800
Message-ID: <20260630074715.4126796-9-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630074715.4126796-1-chenwandun1@gmail.com>
References: <20260630074715.4126796-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_004852_381871_61BDB7E0 
X-CRM114-Status: GOOD (  10.70  )
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

Reserved memory regions are excluded from vmcore by default unless
marked dumpable. Honor the dumpable flag to filter out device firmware
regions (e.g., GPU, DSP, modem) reserved via device tree, since they
typically contain data not useful for kernel crash analysis and can
significantly increase vmcore size.

Use of_reserved_mem_kdump_exclude() to perform the exclusion, and
pre-size the crash_mem array via of_reserved_mem_kdump_nr_ranges().

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/machine_kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index e31fabed378a..1d65320c6ba4 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -17,6 +17,7 @@
 #include <linux/memblock.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -51,6 +52,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	nr_ranges = 2; /* for exclusion of crashkernel region */
 	for_each_mem_range(i, &start, &end)
 		nr_ranges++;
+	nr_ranges += of_reserved_mem_kdump_nr_ranges();
 
 	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
 	if (!cmem)
@@ -75,6 +77,10 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 			goto out;
 	}
 
+	ret = of_reserved_mem_kdump_exclude(cmem);
+	if (ret)
+		goto out;
+
 	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
 
 out:
-- 
2.43.0


