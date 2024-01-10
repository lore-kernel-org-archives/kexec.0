Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA3BC47073
	for <kexec@archiver.kernel.org>; Wed, 10 Jan 2024 07:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ol1wLykqTLwSspYle7Kru685ZHnWJJc7jvVW2x52aao=; b=NqKQDunlRkv9Fi
	yvMNN5slBGmuL1I+khjh8WXCc31sAb5HcCe4lBHNa2X28L64MKY8uu3XgeQDg/d4E669YHXuRI5pS
	cQZvwvGv3uuzTzjsdIP/P/RXI//5Rs3PjWc8ITfGJrJE0KAr7VdSJKewVpsUBDQVz5ZRkCe13A2I+
	eeT5LU85KZdfKi3PEDFWeTv/tt3AtfJ1SPlzoWeQfPhBY6dg23EupxcBt6kpF16Y4AZchAz6HD2wx
	W17JhAIts8rK/6eKqH+vqJcrcM/KaO3TXQkj+3qtLopt6xnLr54MHkqWi69okXUr5Nh5LHX7iWJjl
	vXngUEeQ+qvoqKHxlrgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNSps-00AaL0-2z;
	Wed, 10 Jan 2024 07:17:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNSpo-00AaK9-1q
	for kexec@lists.infradead.org;
	Wed, 10 Jan 2024 07:17:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704871026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBE8JDxyIcX3XnD0pP2q5BqXiSX10f124bX6uMmNC58=;
	b=TKdKkC8xyFG0dEjMnMW5n7ZaKd91oncUgh7jCR/s04/QLih0W81o48bECru9e7cPL8yLeZ
	qAvdfgO1EoEZgTJrQk4q2NuPP+AoyEpKD0yaALOGpvZo0XqV1XmxLTa+hj8mKGJUYI4+B4
	p7j4iDdlWGMeO6F/5d/4AhPcx/AHQ4s=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-0thWLCKMOcy_6u6yHI-MMw-1; Wed, 10 Jan 2024 02:15:36 -0500
X-MC-Unique: 0thWLCKMOcy_6u6yHI-MMw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28d532578a4so2010012a91.1
        for <kexec@lists.infradead.org>; Tue, 09 Jan 2024 23:15:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704870934; x=1705475734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBE8JDxyIcX3XnD0pP2q5BqXiSX10f124bX6uMmNC58=;
        b=tmlO1VsHhE5cBZclZhn0TymANGnNTPupb23uKls+YB+vQ/OxllUBvTodrWKSsF+1sk
         FOGKLjVp4Tdw23LUSOkNNyvBi+aO7WLmhU/dTl6JrXaK9JzeyM/mnS2a6VvjPoWRr7Jo
         O/9QL2k+xZpyTh+/k/3j2rU8p6NlQo6Oe1b2TSFUBjJW+xr7VHesO9C79qIupWcLu2uq
         hocDBJQCzZkj493UXwBgwWB0/WQKaAHj/PidlzcaKnW9J7YmYDdv2NkyXwowvMuKIgCx
         aX1KS+GLlVGpLWu49rOXkx+hfClNh9tU0CyaX5fI2IqSVzZlgJJHJsxNS3gY0SPwGsSg
         zzxA==
X-Gm-Message-State: AOJu0YyQpzgY0bew+lFtmHDWKChtuTg4nqdifTQ2vsJu8b9mvuNsnHWz
	BCK4NSrr7qyYQm7e7R7Ox7Jw/ARy6PVARjFQtYeKp9OLaE7slypbMPmsFZwcqHyfMODYimIQBXt
	Q4W6ZPdLj29Sk/m6o5LMK73wEdbQcdAeX8kxEJJIqY7Xn+p0eYnsgZvKZf6maawVbAGIdA483ND
	gpCDgcDSAyiLQaX/Y=
X-Received: by 2002:a17:90b:e0c:b0:28b:e09f:58c4 with SMTP id ge12-20020a17090b0e0c00b0028be09f58c4mr242195pjb.67.1704870934106;
        Tue, 09 Jan 2024 23:15:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbr8Y7pHWBLgmB5dAnNAAdqpjnYReE9oYBoscYaP8UswLavR5htEwSOes6Jgz3Ih8a0UUJDA==
X-Received: by 2002:a17:90b:e0c:b0:28b:e09f:58c4 with SMTP id ge12-20020a17090b0e0c00b0028be09f58c4mr242170pjb.67.1704870933631;
        Tue, 09 Jan 2024 23:15:33 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id se3-20020a17090b518300b00274b035246esm434215pjb.1.2024.01.09.23.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 23:15:33 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	dm-devel@redhat.com,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v2 2/5] crash_dump: save the dm crypt key temporarily
Date: Wed, 10 Jan 2024 15:15:17 +0800
Message-ID: <20240110071522.1308935-3-coxu@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110071522.1308935-1-coxu@redhat.com>
References: <20240110071522.1308935-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240109_231708_701339_E2996F31 
X-CRM114-Status: GOOD (  23.35  )
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

User space is supposed to write the key description to
/sys/kernel/crash_dm_crypt_key so the kernel will read the key and save
a temporary copy for later user. User space has 2 minutes at maximum to
load the kdump initrd before the key gets wiped. And after kdump
retrieves the key, the key will be wiped immediately.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/crash_core.h   |   7 +-
 include/linux/kexec.h        |   4 ++
 kernel/Makefile              |   2 +-
 kernel/crash_dump_dm_crypt.c | 121 +++++++++++++++++++++++++++++++++++
 kernel/ksysfs.c              |  23 ++++++-
 5 files changed, 153 insertions(+), 4 deletions(-)
 create mode 100644 kernel/crash_dump_dm_crypt.c

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 5126a4fecb44..7078eda6418d 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -125,6 +125,12 @@ static inline void __init reserve_crashkernel_generic(char *cmdline,
 {}
 #endif
 
+struct kimage;
+
+int crash_sysfs_dm_crypt_key_write(const char *key_des, size_t count);
+int crash_pass_temp_dm_crypt_key(void **addr, unsigned long *sz);
+int crash_load_dm_crypt_key(struct kimage *image);
+
 /* Alignment required for elf header segment */
 #define ELF_CORE_HEADER_ALIGN   4096
 
@@ -140,7 +146,6 @@ extern int crash_exclude_mem_range(struct crash_mem *mem,
 extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 				       void **addr, unsigned long *sz);
 
-struct kimage;
 struct kexec_segment;
 
 #define KEXEC_CRASH_HP_NONE			0
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 6f4626490ebf..bf7ab1e927ef 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -366,6 +366,10 @@ struct kimage {
 	void *elf_headers;
 	unsigned long elf_headers_sz;
 	unsigned long elf_load_addr;
+
+	/* dm crypt key buffer */
+	unsigned long dm_crypt_key_addr;
+	unsigned long dm_crypt_key_sz;
 };
 
 /* kexec interface functions */
diff --git a/kernel/Makefile b/kernel/Makefile
index 3947122d618b..48859bf63db5 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -119,7 +119,7 @@ obj-$(CONFIG_PERF_EVENTS) += events/
 
 obj-$(CONFIG_USER_RETURN_NOTIFIER) += user-return-notifier.o
 obj-$(CONFIG_PADATA) += padata.o
-obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
+obj-$(CONFIG_CRASH_DUMP) += crash_dump.o crash_dump_dm_crypt.o
 obj-$(CONFIG_JUMP_LABEL) += jump_label.o
 obj-$(CONFIG_CONTEXT_TRACKING) += context_tracking.o
 obj-$(CONFIG_TORTURE_TEST) += torture.o
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
new file mode 100644
index 000000000000..3a0b0b773598
--- /dev/null
+++ b/kernel/crash_dump_dm_crypt.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <keys/user-type.h>
+#include <linux/crash_dump.h>
+
+static u8 *dm_crypt_key;
+static unsigned int dm_crypt_key_size;
+
+void wipe_dm_crypt_key(void)
+{
+	if (dm_crypt_key) {
+		memset(dm_crypt_key, 0, dm_crypt_key_size * sizeof(u8));
+		kfree(dm_crypt_key);
+		dm_crypt_key = NULL;
+	}
+}
+
+static void _wipe_dm_crypt_key(struct work_struct *dummy)
+{
+	wipe_dm_crypt_key();
+}
+
+static DECLARE_DELAYED_WORK(wipe_dm_crypt_key_work, _wipe_dm_crypt_key);
+
+static unsigned __read_mostly wipe_key_delay = 120; /* 2 mins */
+
+static int crash_save_temp_dm_crypt_key(const char *key_desc, size_t count)
+{
+	const struct user_key_payload *ukp;
+	struct key *key;
+
+	if (dm_crypt_key) {
+		memset(dm_crypt_key, 0, dm_crypt_key_size * sizeof(u8));
+		kfree(dm_crypt_key);
+	}
+
+	pr_debug("Requesting key %s", key_desc);
+	key = request_key(&key_type_user, key_desc, NULL);
+
+	if (IS_ERR(key)) {
+		pr_debug("No such key %s", key_desc);
+		return PTR_ERR(key);
+	}
+
+	ukp = user_key_payload_locked(key);
+	if (!ukp)
+		return -EKEYREVOKED;
+
+	dm_crypt_key = kmalloc(ukp->datalen, GFP_KERNEL);
+	if (!dm_crypt_key)
+		return -ENOMEM;
+	memcpy(dm_crypt_key, ukp->data, ukp->datalen);
+	dm_crypt_key_size = ukp->datalen;
+	pr_debug("dm crypt key (size=%u): %8ph\n", dm_crypt_key_size, dm_crypt_key);
+	schedule_delayed_work(&wipe_dm_crypt_key_work,
+			      round_jiffies_relative(wipe_key_delay * HZ));
+	return 0;
+}
+
+int crash_sysfs_dm_crypt_key_write(const char *key_desc, size_t count)
+{
+	if (!is_kdump_kernel())
+		return crash_save_temp_dm_crypt_key(key_desc, count);
+	return -EINVAL;
+}
+EXPORT_SYMBOL(crash_sysfs_dm_crypt_key_write);
+
+int crash_pass_temp_dm_crypt_key(void **addr, unsigned long *sz)
+{
+	unsigned long dm_crypt_key_sz;
+	unsigned char *buf;
+	unsigned int *size_ptr;
+
+	if (!dm_crypt_key)
+		return -EINVAL;
+
+	dm_crypt_key_sz = sizeof(unsigned int) + dm_crypt_key_size * sizeof(u8);
+
+	buf = vzalloc(dm_crypt_key_sz);
+	if (!buf)
+		return -ENOMEM;
+
+	size_ptr = (unsigned int *)buf;
+	memcpy(size_ptr, &dm_crypt_key_size, sizeof(unsigned int));
+	memcpy(size_ptr + 1, dm_crypt_key, dm_crypt_key_size * sizeof(u8));
+	*addr = buf;
+	*sz = dm_crypt_key_sz;
+	wipe_dm_crypt_key();
+	return 0;
+}
+
+int crash_load_dm_crypt_key(struct kimage *image)
+{
+	int ret;
+	struct kexec_buf kbuf = {
+		.image = image,
+		.buf_min = 0,
+		.buf_max = ULONG_MAX,
+		.top_down = false,
+		.random = true,
+	};
+
+	image->dm_crypt_key_addr = 0;
+	ret = crash_pass_temp_dm_crypt_key(&kbuf.buffer, &kbuf.bufsz);
+	if (ret)
+		return ret;
+
+	kbuf.memsz = kbuf.bufsz;
+	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	ret = kexec_add_buffer(&kbuf);
+	if (ret) {
+		vfree((void *)kbuf.buffer);
+		return ret;
+	}
+	image->dm_crypt_key_addr = kbuf.mem;
+	image->dm_crypt_key_sz = kbuf.bufsz;
+	pr_debug("Loaded dm crypt key at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		 image->dm_crypt_key_addr, kbuf.bufsz, kbuf.bufsz);
+
+	return ret;
+}
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 1d4bc493b2f4..f3bb6bc6a604 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -165,16 +165,34 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
 }
 KERNEL_ATTR_RO(vmcoreinfo);
 
+static ssize_t crash_dm_crypt_key_show(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  char *buf)
+{
+	return 0;
+}
+
+static ssize_t crash_dm_crypt_key_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					   const char *buf, size_t count)
+{
+	int ret;
+
+	ret = crash_sysfs_dm_crypt_key_write(buf, count);
+	return ret < 0 ? ret : count;
+}
+KERNEL_ATTR_RW(crash_dm_crypt_key);
+
 #ifdef CONFIG_CRASH_HOTPLUG
 static ssize_t crash_elfcorehdr_size_show(struct kobject *kobj,
-			       struct kobj_attribute *attr, char *buf)
+					  struct kobj_attribute *attr,
+					  char *buf)
 {
 	unsigned int sz = crash_get_elfcorehdr_size();
 
 	return sysfs_emit(buf, "%u\n", sz);
 }
 KERNEL_ATTR_RO(crash_elfcorehdr_size);
-
 #endif
 
 #endif /* CONFIG_CRASH_CORE */
@@ -267,6 +285,7 @@ static struct attribute * kernel_attrs[] = {
 #endif
 #ifdef CONFIG_CRASH_CORE
 	&vmcoreinfo_attr.attr,
+	&crash_dm_crypt_key_attr.attr,
 #ifdef CONFIG_CRASH_HOTPLUG
 	&crash_elfcorehdr_size_attr.attr,
 #endif
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
