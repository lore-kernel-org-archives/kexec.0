Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06527CD4F3C
	for <kexec@archiver.kernel.org>; Wed, 20 May 2026 09:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=42F8CHAqoHCrwDp1G0wHxf9X6caXzIhKy/g2LWPqXJ4=; b=KwQr+8Igmuv7uV5u19clEgxvg4
	9+Yxv62d67foGB24TcIZBQBP33GPse960o56bQyu3ZSN+r3+44vnPMHDsxXeFLQnj1KY3z5j6Z/gB
	HE01LJg7VKtkhdE2z7/xS7RWR8L4gwYk0tVTeiRPHuE73LL1QkOfy1D5+QHvyn1r9zcrIEjLuAFhH
	fZeeuZhysIibFhq3VEjSurUkIj3FL3LolsPY6IWWPiT0mL/HP3LkQ78xdSaN8p7dLzptBqrvfXVPq
	swg5qLU4AZDUZn/FLwfGxO7L1feOP/pvRVXKN1POKtOPoiXJ2sCSKyMNPIxsM5dLbVTO2u6KfnqAK
	/MpwA1Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPd65-0000000472Q-0foz;
	Wed, 20 May 2026 09:20:13 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPd5v-000000046wR-2Ylm
	for kexec@bombadil.infradead.org;
	Wed, 20 May 2026 09:20:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=42F8CHAqoHCrwDp1G0wHxf9X6caXzIhKy/g2LWPqXJ4=; b=MlXiVaWb7FQWP9oi+Q/44CflFe
	vkaeJUFQIkjQWpC2J/NcfryRn+Z9/NhrMN41vnuhApL22AY1exR8uGfwy20ft9Ry4WvkYmfnordD6
	Gy9Ab0KDl5updyJkOBrlHZiSPGl/9bO2vspmYmetTBUjl0cWfIV5S26S0ME27e0SQpVC/TLcuD7ce
	tY3e7tUYwonfWWp8WYgdNWNAcXDNbSxAfh6ZtwoGzHSl0wi36i0JqYigOEnp28aw7jxVSQbbHlx+R
	EbbTCpfn06cQot9835laXcZftskGA/Xe1Pmki0xN17wjIxQBPCGLbgGXocj5EasFyv/WMh+NKh1Wn
	hSsCJ8Zg==;
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
	by casper.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPd5p-00000006xHv-0luw
	for kexec@lists.infradead.org;
	Wed, 20 May 2026 09:20:01 +0000
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-82faf871346so3620163b3a.0
        for <kexec@lists.infradead.org>; Wed, 20 May 2026 02:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779268792; x=1779873592; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42F8CHAqoHCrwDp1G0wHxf9X6caXzIhKy/g2LWPqXJ4=;
        b=To8a5coTJnJvj0ceMQHmLZhNfjyERA3xAfLIKZrzfmj02cI+5tOP5OHqxcrgUci/9s
         5IDX2DJ2Mbij/ZL4EVebcFWJnm5ap9ngorMN29pv88dV2qtSACDVwqfWp6opA/r/NqvU
         Fi/DYi842F6jwOtSzcHyZYyIgFyi3Qhr9nNupJokgihQoF0JW+IPdaaLVZiFWGQ4yFJ7
         7QFf42tGRQGdGT0ugbIFykk5jI0+QSoVL/BMlUK5LUqL/Lw4/RMcIRsz54x9uFWdf76m
         DsJdBS/TMEGB8c/dJQsAGWu/NLa3464Agc9d9/dn7Sa7KOACKQjzv1DmX55xqWPKuTDb
         vc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779268792; x=1779873592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=42F8CHAqoHCrwDp1G0wHxf9X6caXzIhKy/g2LWPqXJ4=;
        b=h7Xo7zlY2foFg9cbWydaBIXwIoSoOH4cLT/g4JDburojiP1xnYmZg1F8jCxjkj9kGL
         t2+6fIxp8TWX9kXbVW2yAsdeRbo6ZM2OGiejtaH9Pk4SbaAJXn2BnFhZkfaKXI+D3eZz
         OG4ly3+/LS9G9s955ApqA9P3hnn4zzghJ5vI4DvDy//bqac3kCaAlg4U8l6z79SUj6KU
         VVrHExN9W3glazYFUbuZImMHaS4Aw7zMdAxcK47Ei88GcBvFezTGBlH6ZZI7+r8iTBO/
         xtaIETHAJNF2CcqPW8MquAlQcsCEY33EiRjuKP49C29EQW75yNIHED9zjPsQ6oDo/W84
         LjQA==
X-Forwarded-Encrypted: i=1; AFNElJ9Sch6ZP7uLO6/ig5aVUYBzk3QNX28tXe9WKJd1LhqM+GTfywKVISjh0TNP126danAvfNRp0g==@lists.infradead.org
X-Gm-Message-State: AOJu0YwbL7IuJdrmrFeXQ6g/FDvdxUdhQfwAivC2IJlrpG4rRWRKrRPs
	aXmNg/LGr9WonODoUP+kXiBUln7qDZtXdmmgzEnnFRksKrWtg1huQI6Q
X-Gm-Gg: Acq92OFBwfvGzBZoatHG1dx+eX0Ztj8JhfMJO6np9Sq8quqCKTlyrSZGjrlk/KpPHHZ
	dr/DXd2c790RJjU/LP7PR3SSdcUnkKKhnRbL+qiQGye8C8k3RYRJP9QGhi6D3SP7yZUpEfAHHCh
	VnI6hD1JEBfwAA6Xc4vocfDtyLtXJfOYnQIHyC6XDWoifdjgK8dbqtff3udzc6aRfEORvKaf1/k
	fx2U6GpwX8vyXQeF0VO8XIkRq2zWyaY5Utoac94QqjPFbzE3Gl1QR5j34GPGkx5/u3Sd9HRaeUO
	BQfOfbwrre+NgjnjobaH9BEdPY3jkadq+045ETa/aF0yPOTHi74c7LU+CIVyxKGPtBpFjqnaZWp
	0IbaLIagpplXg3INEnwhoplTVVwwZkamjaENttw9+OSjJu/y6zUNIbUu5LUDgCVU+WKGyxuGYjJ
	va8kzCzl7J7rY0Ne0W7eWJzgRgD8dmZUnUGDvENQ==
X-Received: by 2002:a05:6a00:ab0d:b0:82a:6ef8:cb43 with SMTP id d2e1a72fcca58-83f33b34ca2mr23552441b3a.19.1779268792063;
        Wed, 20 May 2026 02:19:52 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f63bb986dsm10208967b3a.48.2026.05.20.02.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 02:19:51 -0700 (PDT)
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
Subject: [PATCH v2 5/8] of: reserved_mem: add kdump helpers to exclude non-dumpable regions
Date: Wed, 20 May 2026 17:18:41 +0800
Message-ID: <20260520091844.592753-6-chenwandun@lixiang.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520091844.592753-1-chenwandun@lixiang.com>
References: <20260520091844.592753-1-chenwandun@lixiang.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_101957_336849_93A85293 
X-CRM114-Status: GOOD (  16.86  )
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

Add two helpers to exclude non-dumpable regions for arch-specific
code.

 - of_reserved_mem_kdump_nr_ranges() returns the count of regions
   that are not dumpable. Each excluded region may split an existing
   crash_mem range into two, so callers use this to calculate
   crash_mem allocation size.

 - of_reserved_mem_kdump_exclude() walks reserved_mem[] and calls
   crash_exclude_mem_range() for every non-dumpable region.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 drivers/of/of_reserved_mem.c    | 34 +++++++++++++++++++++++++++++++++
 include/linux/of_reserved_mem.h | 14 ++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 6dfe9e03c535..ef9732865783 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
+#include <linux/crash_core.h>
 
 #include "of_private.h"
 
@@ -851,6 +852,39 @@ struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(of_reserved_mem_lookup);
 
+/*
+ * Count non-dumpable reserved regions. Excluding each one may split a
+ * crash_mem range in two, callers use this to size the allocation.
+ */
+unsigned int of_reserved_mem_kdump_nr_ranges(void)
+{
+	unsigned int i, n = 0;
+
+	for (i = 0; i < reserved_mem_count; i++)
+		if (reserved_mem[i].size && !reserved_mem[i].dumpable)
+			n++;
+	return n;
+}
+
+/* Exclude non-dumpable reserved regions from @cmem. */
+int of_reserved_mem_kdump_exclude(struct crash_mem *cmem)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		struct reserved_mem *r = &reserved_mem[i];
+
+		if (!r->size || r->dumpable)
+			continue;
+		ret = crash_exclude_mem_range(cmem, r->base,
+					      r->base + r->size - 1);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 /**
  * of_reserved_mem_region_to_resource() - Get a reserved memory region as a resource
  * @np:		node containing 'memory-region' property
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 55a67cee41ea..70db99f1fbff 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -8,6 +8,7 @@
 struct of_phandle_args;
 struct reserved_mem_ops;
 struct resource;
+struct crash_mem;
 
 struct reserved_mem {
 	const char			*name;
@@ -48,6 +49,9 @@ int of_reserved_mem_region_to_resource_byname(const struct device_node *np,
 					      const char *name, struct resource *res);
 int of_reserved_mem_region_count(const struct device_node *np);
 
+unsigned int of_reserved_mem_kdump_nr_ranges(void);
+int of_reserved_mem_kdump_exclude(struct crash_mem *cmem);
+
 #else
 
 #define RESERVEDMEM_OF_DECLARE(name, compat, ops)			\
@@ -92,6 +96,16 @@ static inline int of_reserved_mem_region_count(const struct device_node *np)
 {
 	return 0;
 }
+
+static inline unsigned int of_reserved_mem_kdump_nr_ranges(void)
+{
+	return 0;
+}
+
+static inline int of_reserved_mem_kdump_exclude(struct crash_mem *cmem)
+{
+	return 0;
+}
 #endif
 
 /**
-- 
2.43.0


