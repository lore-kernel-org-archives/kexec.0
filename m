Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41ABACD4F3C
	for <kexec@archiver.kernel.org>; Wed, 20 May 2026 09:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ciQnv+j7sn9Iwh07+rP7odEwkTvIV/Tmpz7NteXq2I8=; b=IeEtuw9W07wPzyn3KzJpG1DmYd
	ZSRHCILKZq4HZTvoBZd78H8au756FMiLpEycU1rXIFDb/rpWkwpMJwdVuvBMtrm7+1GdxifcNKdSM
	d9r54QzHyNLeLb/oqCUqM5zozMKt4drq4ssZziKaP+oRg78vBn0xbIERqCNQAJiUwUZAWaHBjKuS3
	RCjTzPPy0pRe7bfP5gOp/hthaHsZncdFAKtyiFz7tZYa08XdMScvUIdNpDndZ8y410CuUGAAPFfE4
	FWX554mXCadHqexP+fL+ipXMhvLNpXDrfMTJEutQur9lS8zPkva2i4HEWFpek7XDWTESSDV1XVaQK
	fC7bsx4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPd5U-000000046YP-1lAh;
	Wed, 20 May 2026 09:19:36 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPd5Q-000000046Us-0eH2
	for kexec@lists.infradead.org;
	Wed, 20 May 2026 09:19:35 +0000
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-83659d38e38so1838292b3a.1
        for <kexec@lists.infradead.org>; Wed, 20 May 2026 02:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779268771; x=1779873571; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciQnv+j7sn9Iwh07+rP7odEwkTvIV/Tmpz7NteXq2I8=;
        b=UrGsCwAhe5LLei38v2Ny6ro2CWr3NLMkRhyohqx6MGpVdhjA3CpAuf2ig8kYkgfZL/
         H3YSk85j9V8FnWc38Yx1slfE2CAzqk7KRVtX/WoheUFOIqBHekakX9eGjhfI6FLYNuTW
         gCsiOvQh/eC/azlRNQKz4gPS9AOz1v9AUhgZKh0CYG8h+AQjbREZz5r/mgJ14nWcQFRn
         fu4vjXDqLJ4tNjMh5W1OySlK9Q/1L5UmeiKP9B4A6Dse7iVfsMlDAk//xjpa3W1uikUX
         t+SjONPZuAkyNsPYoRfHk4uhVCmTKXIzsnE+18q9jzbud5jGr2I3WdLjsJcOKrgAvcG7
         xkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779268771; x=1779873571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ciQnv+j7sn9Iwh07+rP7odEwkTvIV/Tmpz7NteXq2I8=;
        b=IsvtfJSTz9XvKTEfqHix1JheTlSzEoYK6ZYa6aeEplG46I8d0Bax0DOrGfzr3KHNIu
         y7fAJOvdNDxYsqWrkxV/8MoMEmK41BV75azIHSNSBok9pJ9NR17UnutcGozk7dS2A4gB
         7s4DvOluNvOkTNzDsbGo9f39UlfrZHVvyScnrMAzC5815WErD/lhAS0KQtyi/0k+9jOW
         AnZ1bZv9PkjrLDfU7TVrVM/FUnUJNcgYFxtsMErMDUqfP7jMLD0aFXtTaHUrlhAJ8bLW
         apr+iFGSoEBbYQePtAq6Gm2O8gBUd4n0YmP5yAsM98zpE3TmaJMpWRcfuImhx+mKxntd
         k6jA==
X-Forwarded-Encrypted: i=1; AFNElJ9CZmEiSkOEDJB2DKvrRp1u+o1641QCSopbRvWH09+bG9Ufj1IVM5sRQuX9Najrmst+Oic+PA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyBW6sMxFYOQjUUAKB2hpxLEe1m3XsWGB7ugHNw9VT4XN70LYna
	WPUR5FTp9vIDy9VbNNK/GJ5hsZwjzD1b3V0hWGV9/uKm0E129VyGBGrY
X-Gm-Gg: Acq92OE3cBNQNd91dq41mZ5sgLgVz/9ICXQgFuLDUK8yA9hizdawAzWu7oXWCPP1b3j
	HsESd4C9wnsokQHagGWppInyP6HhyizGQYpSM6WvAQ9rLewHd76SAGLo/JGlHlJrtMfbYnSJYmJ
	VUO+4XIrjzPj3sF9fNwM4v3Eh1BhHpcvQEwNbHbdIz07T73pO5Poh8MtfEAUBJMZqPesJoG4zhs
	V0flJKq8fVY8urLt7GJMYLmB5Qa5jgJB1UiZYbyKUn8SL9zYCotY/EHq4lI+esMOhEE9sYnD+QX
	rx8GWia3e7cAfRejp1SveaNcMD9TxaHH3I0M7P72FhlK578f/41G5fTZKnc9hLAL0q4vqv97Gmr
	FJPHh89PNCLgSf9ZRhZ3ZQnSo7TzanJGGEGYSZcdV/znO0tmnkn3dcnRJ0KoGKTJV0Go0rHkDFp
	YDkPTh5wJf9CnLgfpogUurTDHq82E25+MwJWywTy6mA8u9PquH
X-Received: by 2002:a05:6a00:90aa:b0:829:8c08:d1f4 with SMTP id d2e1a72fcca58-83f33ccd856mr24019073b3a.39.1779268771454;
        Wed, 20 May 2026 02:19:31 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f63bb986dsm10208967b3a.48.2026.05.20.02.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 02:19:30 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
X-Google-Original-From: Wandun Chen <chenwandun@lixiang.com>
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
	leitao@debian.org,
	kees@kernel.org,
	coxu@redhat.com,
	tangyouling@kylinos.cn,
	songshuaishuai@tinylab.org
Subject: [PATCH v2 3/8] of: reserved_mem: add dumpable flag to opt-in vmcore
Date: Wed, 20 May 2026 17:18:39 +0800
Message-ID: <20260520091844.592753-4-chenwandun@lixiang.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520091844.592753-1-chenwandun@lixiang.com>
References: <20260520091844.592753-1-chenwandun@lixiang.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_021932_201112_2F6E73C7 
X-CRM114-Status: GOOD (  13.28  )
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

From: Wandun Chen <chenwandun1@gmail.com>

From: Wandun Chen <chenwandun@lixiang.com>

Add a 'dumpable' flag to struct reserved_mem so the kernel can decide
whether a reserved area should be included in the kdump vmcore. Most
reserved regions are owned by devices and do not contain data useful
for kernel crash analysis, so excluding them by default is the right
behaviour.

Reusable CMA regions are different: pages in a CMA region are handed
back to the buddy allocator and may contain key data for crash
analysis, so set dumpable to true in rmem_cma_setup().

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Link: https://lore.kernel.org/all/20260506144542.GA2072596-robh@kernel.org/
---
 include/linux/of_reserved_mem.h | 1 +
 kernel/dma/contiguous.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index e8b20b29fa68..55a67cee41ea 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -15,6 +15,7 @@ struct reserved_mem {
 	phys_addr_t			base;
 	phys_addr_t			size;
 	void				*priv;
+	bool				dumpable;
 };
 
 struct reserved_mem_ops {
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 03f52bd17120..eddec89eb414 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -579,6 +579,7 @@ static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 		dma_contiguous_default_area = cma;
 
 	rmem->priv = cma;
+	rmem->dumpable = true;
 
 	pr_info("Reserved memory: created CMA memory pool at %pa, size %ld MiB\n",
 		&rmem->base, (unsigned long)rmem->size / SZ_1M);
-- 
2.43.0


