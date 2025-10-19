Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F5FCCD1A7
	for <kexec@archiver.kernel.org>; Sun, 19 Oct 2025 06:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pa/MsfNPB6bG2GsTxSNKTLsrafwlRF2VsAPzt2eBf8E=; b=cj2/69sjtYmxCcaAg0mV/D4z1P
	v1yJkds/W5MJU7C5xh/jWPePNEKExwqE4SCthv/bgGI5bfXW8fkN4QdmDNeC084YRLGC0hb8AxeFo
	WB1rCaRom1UsmP1FFtLPOtf2slSm7km3pg9i91xsMFnMLVh68iZRrKfvzqTifvxzHvi7RsggKNrX/
	vht/OTgqaphXtxRraUxar4R7zAQekvjtdLRtYRLmUTl3mSQTXinTqBpL4PAA6VwndA6NIgu7ZeOpd
	4ngXodEeWAxMQlgx/ogKUTui2klc7hqa2MH4RfGYZxRc3uZ3ydVNiz/8lxGtGxWpz+CvOEJuylcK0
	XdsP6D6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMjE-0000000AjFK-0fWl;
	Sun, 19 Oct 2025 06:17:16 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMjB-0000000AjCx-38GK
	for kexec@lists.infradead.org;
	Sun, 19 Oct 2025 06:17:15 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-33ba38ed94eso3685134a91.1
        for <kexec@lists.infradead.org>; Sat, 18 Oct 2025 23:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760854633; x=1761459433; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pa/MsfNPB6bG2GsTxSNKTLsrafwlRF2VsAPzt2eBf8E=;
        b=NA7k32CqtvLaFqlAGZqov4Rll4nJ3x6asEFlPbxwgEGS++V2uEKH5wHF/WNZ6T/bKG
         +SKYqn5wBOlIdy2M+cb0MtR3J2JSsyfja00WvLU/JkIfTn/zR9Hew4kpGCoa2sOwYSOW
         3DBpGChFl+arRF4ymGCCow4csBpSpumG51MrrSn1IpAQLuzj4M6/Xv1sGrj5Bi8Q0tlj
         POJnrM98hQtw36C8AclKRupqCAW0RTgvChMpe2zH2wtF5iGvS2hZQd8WoOrQAvY3GcMO
         KzYMZoRM4SI6oCTTUuNgADTc9Kjmt4zqpAU0gv9DOWUlQxqsQCVms7nr7himrTBp3si7
         6dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760854633; x=1761459433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pa/MsfNPB6bG2GsTxSNKTLsrafwlRF2VsAPzt2eBf8E=;
        b=Yntgm0hbc1uU9OPnRWdIB5gEqXiC/kCIpzUWzzA662LtpBPccZKifjkNOwOtLMEqO6
         kPhXyIDXcy36GEElFVAEkwulXhL4AeQv2kcibFfXVcm1cCy1L3NJZmf/FW8A1DYRsxqI
         ZlotMVkHquKtSxr2wCqpM0Lx+SqClaRNhSn/x99Tv5dMTeERt4A42ZHqcKel2/Uokgrg
         QkkOgOymKeI+Pc1TIpyoLpWqgIIQTcuQK2mGpR7uvV1YUa11oVM7IFZ0WdqbX5etvsgU
         RttVv6PY/vEsgOudQZlofz6kgQTy9/dxElcxGn8XjYxR25Q/T8KAZOAewN2FJeXuL3/+
         Fwwg==
X-Forwarded-Encrypted: i=1; AJvYcCV91jEfRe1s0A89DidKQQJuSkC5F49pz5XeDichMn66fCF3JkfTbNQOSIgAgSxuG72oKJOgBw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwAM/bHGux3Ts+/c0ce5XOd6lBuqviElVAYgmN/KVWJLSttMGQI
	UW6/fmdhBR8o6dyatSla39z8iTK0IUjPBkQxEoppznYpfXaUB4LEqnni
X-Gm-Gg: ASbGnct2wl8Urj74kd5MBwyF8Uj3cbgsk4JVSgNcIAZatrDa3tlScOIjBX9qFgAUoJZ
	w6HyySf0DN15rZx6NaCG339NaZVi5JHbqRxrSyb0XphO9YHKEhAXpYhJwL+D4CMYjGXLQlyRMeH
	oga4YhIkZAMU2UjctDfQO3JVhPCrJ1ydG+2EAYa4LPp3nZ8xA6QXeOT+2O9TL1pm8FskttTJKo5
	9f0y9Mgs6MHnCWxtHHg4U9Nc5whUTh6wPcC1ryuV6vSO1rx7Ef7gHZkpqxtd3MSfdE7HPPkCn8K
	8mhD3e0Xb16/N0iAaWmOM0WFK5dsTTMI+T+knei7/JtfY7C9UXW0Kuy0VhjSPpcXeg5JiaStXWP
	8Q8MV9oskkDDZXzFNf2NoMBdflT8kIxCxVWTT4YTJAo+AeNWeIOtQCzTOrKT/UoSaEi+YiJ7/kp
	wjM0T7kFAiw1RRO+Q=
X-Google-Smtp-Source: AGHT+IEcU9YEdbUoIaZ58UmrsaoQiSd0FUGy1FLPQQWXoQbBycgCM+6raP4xZnOBinCzMBaBjeximQ==
X-Received: by 2002:a17:90b:2ec7:b0:33b:6650:57c3 with SMTP id 98e67ed59e1d1-33bcf8ec60dmr11689870a91.21.1760854632902;
        Sat, 18 Oct 2025 23:17:12 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:bc87:d8fe:3e55:7ffb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm4332032a12.38.2025.10.18.23.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 23:17:12 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: jiri@resnulli.us,
	stefanha@redhat.com,
	multikernel@lists.linux.dev,
	pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch v2 11/16] kexec: Add /proc/kimage interface for kimage tracking
Date: Sat, 18 Oct 2025 23:16:25 -0700
Message-Id: <20251019061631.2235405-12-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
References: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251018_231713_826689_BA0A451A 
X-CRM114-Status: GOOD (  16.66  )
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

Add a dedicated /proc/kimage file to provide read-only access to
all loaded kernel images in the system, for both regular kexec kernel
images and multikernel images.

The interface displays kernel images in a tabular format showing:
- Type: kexec type (default, crash, multikernel)
- Start Address: entry point in hexadecimal format
- Segments: number of memory segments

This interface is particularly useful for inspecting kimages, debugging
kexec, and verifying that kernel images are loaded correctly.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 kernel/kexec_core.c | 63 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index ed5c97b4531e..7db755e64dd6 100644
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
@@ -1214,6 +1216,52 @@ struct kimage *kexec_image;
 struct kimage *kexec_crash_image;
 static int kexec_load_disabled;
 
+/*
+ * Proc interface for /proc/kimage
+ */
+static int kimage_proc_show(struct seq_file *m, void *v)
+{
+	struct kimage *image;
+	const char *type_names[] = {
+		[KEXEC_TYPE_DEFAULT] = "default",
+		[KEXEC_TYPE_CRASH] = "crash",
+		[KEXEC_TYPE_MULTIKERNEL] = "multikernel"
+	};
+
+	seq_printf(m, "MK_ID  Type        Start Address   Segments\n");
+	seq_printf(m, "-----  ----------  --------------  --------\n");
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
+			seq_printf(m, "%5d  %-10s  0x%012lx  %8lu\n",
+				   image->mk_id, type_name, image->start, image->nr_segments);
+		}
+	}
+	kimage_list_unlock();
+
+	return 0;
+}
+
+static int kimage_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, kimage_proc_show, NULL);
+}
+
+static const struct proc_ops kimage_proc_ops = {
+	.proc_open	= kimage_proc_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= single_release,
+};
+
 #ifdef CONFIG_SYSCTL
 static int kexec_limit_handler(const struct ctl_table *table, int write,
 			       void *buffer, size_t *lenp, loff_t *ppos)
@@ -1285,6 +1333,21 @@ static int __init kexec_core_sysctl_init(void)
 late_initcall(kexec_core_sysctl_init);
 #endif
 
+static int __init kimage_proc_init(void)
+{
+	struct proc_dir_entry *entry;
+
+	entry = proc_create("kimage", 0444, NULL, &kimage_proc_ops);
+	if (!entry) {
+		pr_err("Failed to create /proc/kimage\n");
+		return -ENOMEM;
+	}
+
+	pr_debug("Created /proc/kimage interface\n");
+	return 0;
+}
+late_initcall(kimage_proc_init);
+
 bool kexec_load_permitted(int kexec_image_type)
 {
 	struct kexec_load_limit *limit;
-- 
2.34.1


