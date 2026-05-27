Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D38CD5BD2
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 03:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e5OPTsG2OKxcjvVozOjImSDH+Fj8Htwruv9sukUXajw=; b=34WuhDpXLVp/ZCD+O9mihzY6FR
	dQcdXSdsXK4FubC7ckfn01zsGcHBauxzzn3BgJGC6Rf8aM/gaA1hYEUGsqUWm+Ne/lvTzHKixXiUc
	O+eAGzaMG61TzfAfegImU+J+ml/Jjv1QoDJYv7c0h/nVlhlRUsOajCPd4riGKX8fqYOPP6eX5li9+
	ePwPBlk263EbkHlPcwotS9IBpVvWA7SxG8+GjZcaCOmt4BNHxsQMyZILzb32bWS+UmHXhaBTC9A4w
	k5ufISpmSaMv6qKHvtjAbvDxNKaa0OYW+veW4OmZ+CwqT4PscRrrhZONMjzKO5aSz35DeHU406BkU
	cnw0s26A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4zI-00000003Ft3-2cS6;
	Wed, 27 May 2026 03:31:23 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4zH-00000003FrU-16i6
	for kexec@bombadil.infradead.org;
	Wed, 27 May 2026 03:31:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=e5OPTsG2OKxcjvVozOjImSDH+Fj8Htwruv9sukUXajw=; b=e0spCvquzZQPXqph2kY82TnRre
	mkao4/FTzxcor+ARZZSrd+DZv7qsy5xKWSb0et3giGDQrDByrRSYxSk2xTrjfc3UOUZGHhxPpgs61
	2T4bXG2pTNqP7xlLPhARnUChh36vb5QL1+koUpUx+dsynziMWNUNOcf+PuCh8LHY98xwwYqnG3EVS
	ilCcISdVlG35vwSy8Fabox2IPrjQiJUi+B/PJYvGIMFU1PWmF6zWaq9eyOkLpLykNYSREit2Lu0iS
	dX3AWD8U0c5x2/FQ/dAySyJGV8O6fNHS74RYkuoisCXlM1SYILGraD+yWNop6kDTu8Xxxe3ZogQB4
	5fnGgwqA==;
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4zD-0000000CqrV-0UV3
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 03:31:17 +0000
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-824c9da9928so5377657b3a.3
        for <kexec@lists.infradead.org>; Tue, 26 May 2026 20:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779852673; x=1780457473; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5OPTsG2OKxcjvVozOjImSDH+Fj8Htwruv9sukUXajw=;
        b=Km46P8GY9MhY4ifTCAW3pWic16G3/1Xs6IY6YdKHrpL43Eunt8YXpaMnfIqy+Bu37V
         vJiSY6P1+8coC5lq14eob7aRSRQwOYJxo/Mu9CtGex+/aMJNxTjQ8Ogenos3WhchF17F
         tQmzlppudEXS2E0k9P5Zz4Qc6zfa34iephhc0i6zn3AdyZT6awnkcYpw0wSvHYu+M9YO
         o7H5PcxofFyHkdCLguaXroB+3aPFwPTgOQ2c6j6PBQvc8ZkO3zz7pUuR+wAh1+bmRk1i
         Ww49JlYoerODD6jiX6SmrF4m4oR/O12v8odazw2DAKDPCDMLiLtbaDsmW/H2vIg/lOpH
         fySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779852673; x=1780457473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e5OPTsG2OKxcjvVozOjImSDH+Fj8Htwruv9sukUXajw=;
        b=Yw5NXmCY/KsXT5fNA2Lo6x/+UOuIH4lzXYqy3sJ1RBqQ0Zs+xaan2uffDqYavZupaf
         W8RyQMALeMlvojrNEFAPccKZgTsRqnQ75sNWru3MJ4VWNlvyxCfQhrDYmNgVF3q76nrP
         B81FFdWDaF9bd5IcohzE9CC3UT4cmleXyae1Tnk5xnWjc4ywaSnNYz7pNlsWolIpFw3e
         Rrfarem1YYWBDMCBQGmZSAoVmLC1pAhJs41SktnqZpb+3K4zN0NkOmBAZgOoaZaTzBHV
         r0hzqgpPOK4R5f4KgN73gkYULgwu/bYKB511OHvn5IuDLKxU0MG2fdwaFNM8Xg1i5B6/
         KOWw==
X-Forwarded-Encrypted: i=1; AFNElJ9VBhU10eHhTNh+7iqzJbQLzNRe5/5EfzxwORpPSqa1WBOU0VFabapoL5M0vNV9taBr63nhFA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxssyRG02n0fO9Xw8wZ/shOjXnaa/axXo1eTxWwp7REVzcL6low
	DHIIMQRi1o9rJ6guALXyDoAWfbupfQMg0CQZQYCk8obQM2YQYxtHaOUa
X-Gm-Gg: Acq92OHwdtN8XTrZMEXB5qsIjbVMoPu5iH8CfOhIf+Te8HRNHDPW01gMLBXMpAGn0KX
	vfndEyUMZVlOHjNK2ghmL/3jK8ZVNw5mqDEuurx0BNfBkWVXy357jllu2wufBSgjmulwIoRMbqd
	emLWD9nBo9JNKycLs0HZkW1BAZP6JqODikocTNpDodHyTV7IrpwML/ELcMlAPcbpyRnxbngKsdW
	ZU0DGQxHIWhK5PtrzftvStKLTsCtv0NVQQmFWBGcwzyDfv/kG2rrG9gpe/3fdOMOmdXswGr+Hpc
	PdcuO5qFynRpibCDxFPylDVfeTqC7In17KLm9J1YYJ+SDmzPHeHy4PTUBf/+Jxd0lEk7p7czFs8
	f3LxoSMM7wQzSuPeeeydGy10q5p0eX/wKz17gIuxQgNElCfXxGIXMczQGksE52vFcqs1BG5o3/v
	P52aG556tLpVWAg1BBnN7b4MVtz12UUGLC2uWmivIbI/ZcDbc=
X-Received: by 2002:a05:6a00:2ea7:b0:835:4291:6975 with SMTP id d2e1a72fcca58-8415f363b30mr20565995b3a.39.1779852673468;
        Tue, 26 May 2026 20:31:13 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d7307596sm749688b3a.59.2026.05.26.20.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:31:13 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	quic_obabatun@quicinc.com
Subject: [PATCH v3 09/11] arm64: kdump: exclude non-dumpable reserved memory regions from vmcore
Date: Wed, 27 May 2026 11:29:15 +0800
Message-ID: <20260527032917.3385849-10-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527032917.3385849-1-chenwandun1@gmail.com>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_043116_003699_46AF6DDA 
X-CRM114-Status: GOOD (  11.07  )
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


