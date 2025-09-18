Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AAECAC5A7
	for <kexec@archiver.kernel.org>; Thu, 18 Sep 2025 22:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BwRb7SzhfZg7neWGwUqJxva5Q/Tf1fgxJiUlDnCKY6o=; b=ZT83Xi3Ityja6LRT4SnrwV7bIb
	fQ5SVybCiO2aCI1S8P9rLml1s1bm/EhLqownvmsamR3cz/4Owa2ZWQ8Pg8mkuzh+moRZrDTDY+kbC
	3AHfXkCSLWLA3MEF0TIaevEFlYAOin9rIgS5OBDmTyfptlnhFx5LTK/7qg5/tsg0Tk/wLVGWYK5ow
	QRw9h/0Siij7L1qcyW0kd61y+Td0+cbFPGGE1hdnG+uDYjMOUTvc20Uepf+QWTV4iSQepAATSkqlg
	Vdq1hrVgbVQ8qO24PMC/aPIZdEqnVUVVLeDbAkz8q/a7PQWnklKihozJVQZbWF8+S0cQ81PIh4vFX
	WgMg/GBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzN5I-00000001KSS-194x;
	Thu, 18 Sep 2025 22:26:36 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzN5F-00000001KPD-3VCT
	for kexec@lists.infradead.org;
	Thu, 18 Sep 2025 22:26:34 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-77251d7cca6so1566121b3a.3
        for <kexec@lists.infradead.org>; Thu, 18 Sep 2025 15:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758234393; x=1758839193; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwRb7SzhfZg7neWGwUqJxva5Q/Tf1fgxJiUlDnCKY6o=;
        b=e5JRl1Ksg4H9lBYUVr+FxnUqcJBAZoASfoEpaBj954cvbO6zJ0ckn4RihRYejz9Agi
         IZoS3OCFHafef7y03/eNslVlAWyHDmHb7C1krr1d8glFFJoCzkftPLOmdt9/Z0fGp7+7
         y7kqz7o8YcIHcGUBDYW39SIE8GADoIlg6Sqcx49x29865lb3JI+EPpIg71hFvMKPSy1S
         nQ4XrMXrwdc9do34gI7A+Z2o3b20glV/Fb7O20/HVbshF6vTAjcplhs6Y/m2egOrQbJu
         d0D5QmaNCblgLEj97TAGQT9Xkrc8O2h7odAAhUoheEklRa4UttZ1y3TYqQoGmdoh8Q3e
         9mKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758234393; x=1758839193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwRb7SzhfZg7neWGwUqJxva5Q/Tf1fgxJiUlDnCKY6o=;
        b=UeDcD4+85SnT8PaE2s71WMvWgJ+prs7dSQW7XTIxLtM/aIH4aA4gu8mKFO3QHlGkI/
         82mg3tF20Z5MmXm4dNS3L7+XRbTPdCAC3J+36qcbFBhyn2tu5eZhObZGjUGgyo+hDpir
         r75VP243N0r5ezs3JofmxON3PdIssmfJE0y1P3o2orQpp3c1DspDZPrYkU+z0ifRE1q/
         35L51hjKCTMmRsV5P1hpo0Li+nMPUmUxxB8rxXR9m1/x7E1HYZNxUiYuvyyTeXD7wm/a
         sXG/gB/buY/7gxoEKi0R9U3zuFLFLCVhkkDtzNZ9s13zTsyjEV1eF6WkQnTbKd4sttI6
         nQ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUNNPndF5RGpuuEEg2OKHPZXmKIGuKu5jY7UPWsp2MyOfME0hPzDAWpzzNTS9g5kmFiFVphQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwUCcMT2sWkWvGuv3B4uFxn1nNm30gqIrqHUqmm4IUbqPBvPNY/
	Udi+u1LbW0P7JQqw2PHjDL1yPxJdF1FfxAQ9RFLCh76ELYjb7QZE70Kw
X-Gm-Gg: ASbGnctIOHkzSujPIBOGZLc055DAr+vHhHDFZRrA0Fmw++z6EYhBjsNu+/v3BJhEbQ3
	Mz6DPKaeVpmlmIGMNNV660gGtUQMZZp8mnYRHYLcmmIYHqbZ0PPGHFSefJjKqmvopVOA+qbj+bs
	D+kU9O6xmnZEx4fn02eArpMH2IQvK4aMIr6rQ7dKF9BXoWH64rSvhO1CdapbuDauNEwqWunXZ+l
	oExxGOyUEQKh3OCeWB9hq7aWOoNfJqA48deBaVO94FyVIOWXbq12Oar7FBq4XqACeu3iHzQ/fuh
	gjAM3hpBTelMqPJh5iEYaclIIvEHfCLh2Ov2p3WxicNGVxhzBIYpFEa60fPFeVprED0EHlgJN6L
	O/sm5iMRxk07qQhP3IPABMnqxMeBVHI2p1bBs4EeRZcnNR1U=
X-Google-Smtp-Source: AGHT+IENSD4FSp5oCJNvN+B+S7Ehm9laSk+STvS8UEs+QD3NwWg6ip8ENfOjlvBCKPM94MRsd6BQ9g==
X-Received: by 2002:a05:6a00:139a:b0:772:7ddd:3fe0 with SMTP id d2e1a72fcca58-77e4d03267emr1101959b3a.2.1758234392993;
        Thu, 18 Sep 2025 15:26:32 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:c5c1:2e33:6cf2:beed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e5fe6de75sm407542b3a.19.2025.09.18.15.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 15:26:32 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch 7/7] kexec: Add /proc/multikernel interface for kimage tracking
Date: Thu, 18 Sep 2025 15:26:06 -0700
Message-Id: <20250918222607.186488-8-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_152633_878098_7DDA4515 
X-CRM114-Status: GOOD (  17.98  )
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

From: Cong Wang <cwang@multikernel.io>

Add a dedicated /proc/multikernel file to provide read-only access to
all loaded kernel images in the system.

The interface displays kernel images in a tabular format showing:
- Type: kexec type (default, crash, multikernel)
- Start Address: entry point in hexadecimal format
- Segments: number of memory segments

A lot more information needs to be added here, for example a unique kernel
ID allocated for each kimage. For now, let's focus on the design first.

This interface is particularly useful for debugging multikernel setups,
system monitoring, and verifying that kernel images are loaded correctly.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 kernel/kexec_core.c | 63 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 4e489a7031e6..8306c10fc337 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -13,6 +13,8 @@
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/kexec.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/highmem.h>
@@ -1224,6 +1226,52 @@ struct kimage *kexec_image;
 struct kimage *kexec_crash_image;
 static int kexec_load_disabled;
 
+/*
+ * Proc interface for /proc/multikernel
+ */
+static int multikernel_proc_show(struct seq_file *m, void *v)
+{
+	struct kimage *image;
+	const char *type_names[] = {
+		[KEXEC_TYPE_DEFAULT] = "default",
+		[KEXEC_TYPE_CRASH] = "crash",
+		[KEXEC_TYPE_MULTIKERNEL] = "multikernel"
+	};
+
+	seq_printf(m, "Type        Start Address   Segments\n");
+	seq_printf(m, "----------  --------------  --------\n");
+
+	kimage_list_lock();
+	if (list_empty(&kexec_image_list)) {
+		seq_printf(m, "No kimages loaded\n");
+	} else {
+		list_for_each_entry(image, &kexec_image_list, list) {
+			const char *type_name = "unknown";
+
+			if (image->type < ARRAY_SIZE(type_names) && type_names[image->type])
+				type_name = type_names[image->type];
+
+			seq_printf(m, "%-10s  0x%012lx  %8lu\n",
+				   type_name, image->start, image->nr_segments);
+		}
+	}
+	kimage_list_unlock();
+
+	return 0;
+}
+
+static int multikernel_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, multikernel_proc_show, NULL);
+}
+
+static const struct proc_ops multikernel_proc_ops = {
+	.proc_open	= multikernel_proc_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= single_release,
+};
+
 #ifdef CONFIG_SYSCTL
 static int kexec_limit_handler(const struct ctl_table *table, int write,
 			       void *buffer, size_t *lenp, loff_t *ppos)
@@ -1295,6 +1343,21 @@ static int __init kexec_core_sysctl_init(void)
 late_initcall(kexec_core_sysctl_init);
 #endif
 
+static int __init multikernel_proc_init(void)
+{
+	struct proc_dir_entry *entry;
+
+	entry = proc_create("multikernel", 0444, NULL, &multikernel_proc_ops);
+	if (!entry) {
+		pr_err("Failed to create /proc/multikernel\n");
+		return -ENOMEM;
+	}
+
+	pr_debug("Created /proc/multikernel interface\n");
+	return 0;
+}
+late_initcall(multikernel_proc_init);
+
 bool kexec_load_permitted(int kexec_image_type)
 {
 	struct kexec_load_limit *limit;
-- 
2.34.1


