Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5B3FF8873
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 07:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nuWPT+XdRkD5quZoMJ/j/U0upX+W05bC344BAJoReBo=; b=D6bDb0GdaeWXsYSm+fXPpLUp4/
	39otOqyNRB4se/j3ypFAgpqPYNj6jBGjbmjVtJmcB4/MyztBxkyT6cHc0tn73kGbrWeHFr6IREwaV
	mk3xTadxMEOm8x+Kk8M6j8wo2T8tPUSnCKpn082bwmev4ROVmmvli2IEM4w4Q9hNf/8aULwo5YuwD
	WYEo1iXXKk+W1FbEuqDI+de5eHMcCPFxC1Daq43O/DQV+Sn1JM2SCkMQODu0zC+yKaa+wz2cGgFHD
	J8fYx1+1hlIZKKv4L210KaaaAI0gsrO3KHUZs8rhpdXu8Jsog+Jl13l2gzT/Ko13PaJieHUtZh1ug
	xhxeQtHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHytv-000000035lN-0xs4;
	Wed, 29 Apr 2026 07:00:03 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHytm-000000035c3-2q7J
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 06:59:56 +0000
Received: by mail-pg1-x544.google.com with SMTP id 41be03b00d2f7-c70fb6aa323so4333773a12.3
        for <kexec@lists.infradead.org>; Tue, 28 Apr 2026 23:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777445993; x=1778050793; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuWPT+XdRkD5quZoMJ/j/U0upX+W05bC344BAJoReBo=;
        b=L3nK81GOZXZNhp/3hXpYCJO2FcqXuQokXYf5yFBjqo836PowFhlse4oPppN1mgMUj7
         uXQTjSVFDi9WQqipt2OSquoCbjBlb0SFgo862sswObaTfmsZp+uTZLWPotr8FJ3cPnHO
         MQgjvNvmsv4W+IVKcLb3uUGlbDhn6R5tziyfXhMBwUesO+ooPos+I0ERS+mQX96H2v1L
         jMMtoywn7p062kG0/BmqqxQQ7EgTFgjYUqb5xx/3pwK1aq2tvuNjpD+uNRR3hxUEVFho
         6U2N736v2D1a2FiY457hr4Vn/eU89/23NuHwrADdFPHWR6diD29tIg3XhLSNZeF2eRwD
         sECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777445993; x=1778050793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nuWPT+XdRkD5quZoMJ/j/U0upX+W05bC344BAJoReBo=;
        b=eMqqYWaET1JYkNBBU6g3a1+7OZDa1WpZGs7UOjTpINwhbtZN4tJJORBdkTrgvgklEH
         p1/i1IffAaBQMFKVTWqNjtKQuXBts3JRgpkU+7NU4eq5/uX69KmVwjimUz0KtUtNabkD
         HRuqye4rkrnsPJbMV+h1PtqA2ejFMb3LvrG7sXTbPxbsLYBQcY4fjRzg6n1dXbzTWKtw
         jpfPz3+zKlRMqH+Ka3TVcc7vC/09MiosTMKJFkDdefjxu03NixCofYnk0WrvEmHhH43w
         QhNQMnyN+gxjcrvpQ/R2HuvslvjgK0TYR2/C+AS2F4igwksD09M73WXrWtecyOcpPT40
         Z6jw==
X-Gm-Message-State: AOJu0Yy6d+lZ6Z7ddhNkPBCO9aw+ia6FR9X2fYCG0bYsoglvUzvC3Uuv
	r53DcPXT7bMyVXoz9vsRFArzedIl+UJz5EEEd1MhLX69PP8I2qzV6O8NjSy0V4O5Ce687po6
X-Gm-Gg: AeBDieuSdEuD279bpYyHn0sDsDUD9aisnIyXuJLHlp7zYUxx2z6/uK9P0S96LbHpKMl
	/sAAKm5G7HytD7v1FsAs3zIhl16A0sfvJf+IZSCNZ715ig4p8iffs36KpCy3FurYyeamBrxVSZZ
	p6hCsVLkCa8/mGB4E/d6ddOxFrXpAJBVhfG0oenVPlvdg+rPJvzoCZidr9CumR/o6JajIOAixsk
	jlffIuUGrEYH3NHF+x9o9MniTq3XPbL9dpy6pZPzVp5AdPZoyxHUQpxWwoUv1WvPqdlTa0NFcIg
	6obhpNUp6b18SbX56evOi2GzRhIVgGevv2KmgVqDZ4EFNVg6HWyHWBZ6BKAKQwDv5IxfiUBm46h
	s6Lk9GtiGLcRDj4OaUioWmCGsHNhoB1Un369okfOO6EXHM3/ao2AyO46829h1cIzLHgWma9FzZ2
	DBe/+RFWPXEE0zfSZ5zWSQvy6ykZDKcfZrQljzZh3fKfySZCLCDlIbrIHl6iw=
X-Received: by 2002:a05:6a21:33a7:b0:3a2:cc5f:2187 with SMTP id adf61e73a8af0-3a3af541a19mr3029899637.28.1777445993005;
        Tue, 28 Apr 2026 23:59:53 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed7eaf93sm1043146b3a.40.2026.04.28.23.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 23:59:52 -0700 (PDT)
From: Chen Wandun <chenwandun1@gmail.com>
X-Google-Original-From: Chen Wandun <chenwandun@lixiang.com>
To: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: akpm@linux-foundation.org,
	bhe@redhat.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	saravanak@kernel.org,
	chenwandun@lixiang.com,
	zhaomeijing@lixiang.com,
	everyzhao@126.com
Subject: [PATCH 07/11] of: reserved_mem: add no-dump crash_mem exclusion helpers
Date: Wed, 29 Apr 2026 14:58:27 +0800
Message-ID: <20260429065831.1510858-8-chenwandun@lixiang.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429065831.1510858-1-chenwandun@lixiang.com>
References: <20260429065831.1510858-1-chenwandun@lixiang.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_235954_801965_3B421B02 
X-CRM114-Status: GOOD (  17.29  )
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

Provide two kdump-oriented helpers so that arch kexec_file code does
not have to open-code the no-dump filtering loop:

 - of_reserved_mem_no_dump_nr_ranges() returns the number of reserved
   regions flagged with linux,no-dump. Each exclusion may split one
   existing crash_mem range into two, so callers use this count to
   pre-size their crash_mem allocation.

 - of_reserved_mem_exclude_no_dump() walks the reserved_mem[] array
   and calls crash_exclude_mem_range() for each no-dump region.

Both helpers are guarded by CONFIG_KEXEC_FILE; empty inline stubs are
provided for the !KEXEC_FILE case so architecture code can call them
unconditionally.

The consumers are added in the following arm64, riscv and loongarch
patches in this series.

Signed-off-by: Chen Wandun <chenwandun@lixiang.com>
Tested-by: Zhao Meijing <zhaomeijing@lixiang.com>
---
 drivers/of/of_reserved_mem.c    | 54 +++++++++++++++++++++++++++++++++
 include/linux/of_reserved_mem.h | 15 +++++++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 4b80420da2d2..038056a6408a 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -27,6 +27,10 @@
 
 #include "of_private.h"
 
+#ifdef CONFIG_KEXEC_FILE
+#include <linux/crash_core.h>
+#endif
+
 static struct reserved_mem reserved_mem_array[MAX_RESERVED_REGIONS] __initdata;
 static struct reserved_mem *reserved_mem __refdata = reserved_mem_array;
 static int total_reserved_mem_cnt = MAX_RESERVED_REGIONS;
@@ -916,6 +920,56 @@ struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(of_reserved_mem_lookup);
 
+#ifdef CONFIG_KEXEC_FILE
+/**
+ * of_reserved_mem_no_dump_nr_ranges() - count reserved regions flagged
+ * with the linux,no-dump property.
+ *
+ * Each such region may split an existing crash_mem range into two when
+ * it is excluded, so callers can use this count to pre-size their
+ * crash_mem allocation.
+ */
+unsigned int of_reserved_mem_no_dump_nr_ranges(void)
+{
+	unsigned int i, n = 0;
+
+	for (i = 0; i < reserved_mem_count; i++)
+		if (reserved_mem[i].no_dump)
+			n++;
+	return n;
+}
+
+/**
+ * of_reserved_mem_exclude_no_dump() - exclude no-dump reserved regions
+ * from a crash_mem list.
+ * @cmem: crash memory list to modify
+ *
+ * Walks the reserved_mem[] array and calls crash_exclude_mem_range() for
+ * every region with no_dump set. Intended to be called from arch kdump
+ * code when constructing the elfcorehdr.
+ *
+ * Returns 0 on success, or a negative error returned by
+ * crash_exclude_mem_range() on the first failure.
+ */
+int of_reserved_mem_exclude_no_dump(struct crash_mem *cmem)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		struct reserved_mem *r = &reserved_mem[i];
+
+		if (!r->no_dump || !r->size)
+			continue;
+		ret = crash_exclude_mem_range(cmem, r->base,
+					      r->base + r->size - 1);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+#endif /* CONFIG_KEXEC_FILE */
+
 /**
  * of_reserved_mem_region_to_resource() - Get a reserved memory region as a resource
  * @np:		node containing 'memory-region' property
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 29674f572673..cd0f88f29579 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -8,6 +8,7 @@
 struct of_phandle_args;
 struct reserved_mem_ops;
 struct resource;
+struct crash_mem;
 
 struct reserved_mem {
 	const char			*name;
@@ -94,6 +95,20 @@ static inline int of_reserved_mem_region_count(const struct device_node *np)
 }
 #endif
 
+#if defined(CONFIG_OF_RESERVED_MEM) && defined(CONFIG_KEXEC_FILE)
+unsigned int of_reserved_mem_no_dump_nr_ranges(void);
+int of_reserved_mem_exclude_no_dump(struct crash_mem *cmem);
+#else
+static inline unsigned int of_reserved_mem_no_dump_nr_ranges(void)
+{
+	return 0;
+}
+static inline int of_reserved_mem_exclude_no_dump(struct crash_mem *cmem)
+{
+	return 0;
+}
+#endif
+
 /**
  * of_reserved_mem_device_init() - assign reserved memory region to given device
  * @dev:	Pointer to the device to configure
-- 
2.43.0


