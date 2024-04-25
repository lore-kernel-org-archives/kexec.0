Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96926C10F15
	for <kexec@archiver.kernel.org>; Thu, 25 Apr 2024 10:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7jX/Znz1Hx0f+b7T0dAoTAHM3vhL9jDp9o28HVOj1p8=; b=xnCim3YLKS+VZY
	nuL1YZAocRpFqK8qn5cfhMTsnP3uEzq8ZKUD00FLXtoJpyq4ggv0KGI27GCwaBJOjeJd2BJyOAXOl
	Dn1katveOT8JR18xypm3DKyLyUYULVxhVGdA2NKzQqW3Cz23ZP6mixttCFiVBcGMio1E+OFTUNRuv
	DHfRq8En1dyRjRc1ZumQg9PrIMnJ2rFO3LQgFozP+BHw8BzoV1FfH8zBc15olb+Pycx256jepuoz3
	maa78yzhibkpfmK5iGjtHu47fNDETKYgsMyeuXxJmSDoN0hxVjHYRTU0W7p8oKolck4zLcFJ2LS/u
	5IRZBVdWotjjBGdX4ViA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzvyH-00000007kd2-0ItK;
	Thu, 25 Apr 2024 10:04:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzvyD-00000007kaM-2OM3
	for kexec@lists.infradead.org;
	Thu, 25 Apr 2024 10:04:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714039488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1WvQVElEBbzuyapN0iJk9xUP1lV1tjo8L1zhcJQztk=;
	b=CKKEnovqHOeMlMZL77d91Xg9lslbA8dNQIB1c14Hzv502yjXJGTbDG4W5vHRQMi4UEoWc4
	EmLX1HvZFNRObxYr3tTLsD8Ffr4Wx/iH3uIGvzyVSJBpRDsL+LFhNBc1t3W55sogo9TV89
	P3cybJ+sIxSv8HQ1QnCCXjSmHdujPlg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-2Yyfixe2MoGgFfvwt_nsYQ-1; Thu, 25 Apr 2024 06:04:47 -0400
X-MC-Unique: 2Yyfixe2MoGgFfvwt_nsYQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e45572fb3fso7958535ad.0
        for <kexec@lists.infradead.org>; Thu, 25 Apr 2024 03:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714039485; x=1714644285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1WvQVElEBbzuyapN0iJk9xUP1lV1tjo8L1zhcJQztk=;
        b=hLN8AG+hCyZSeArG+8yX62B2mqc9yDfpk+QEz/HBg78ej/YGpgG7RDXa2Q2QV7PbZl
         AW8ccQfTJz5P3kzdLBROh8UTLl/Ho6SUf3WsX90jwaVkypqLd1rVAAyr7+ruALFDiqQv
         Hi6N5oFbzNrGsePzeFIgGP2PNqdtacfgmZGPX1x77a74qY6YRLmIittA6szEwq0h2nJo
         RRENf263vZ0LgQho1/OPAJJkvpiJJD0ECkdwVseGitOynJs7YlCSFkMKyKBYNAoXz/3F
         uhWCoeumbLfFimmeSKwp7MCwUHVSG/gGEsISqaTFsZ6dWwVwOVas1MNELiQ3F00Wnh7N
         VBew==
X-Gm-Message-State: AOJu0Yz/ISUggoTzMN0fXQkW3glvrno1Z9B7iPrUpE8O2We59iUUNiAe
	QMY2Zb1ALZr+MiPvR8PQFR503zVQ1f3ZMgzpTWOlQEmDhPp9RdrqDkDw4h0XsYZr80tkmwWTraU
	sci7VZmI8YJG1RrwJ9SF3QeTgfh1sf/XGsUJad/JPIFKasTrOjtIkL7fj45WViJMDR651SFp7JW
	aDHWbZbMgiHdfu2uT4UsJoAcy6pwScC4/qjI2+mgxXmPzE
X-Received: by 2002:a17:903:32c6:b0:1e4:dcfe:848f with SMTP id i6-20020a17090332c600b001e4dcfe848fmr6586859plr.16.1714039484962;
        Thu, 25 Apr 2024 03:04:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6pO2drBoU+AkObmupaAop6L5yQaI22V7bV87rZpQugB2zH3HfS0+Y89xAPgCuV9dfoJZNjw==
X-Received: by 2002:a17:903:32c6:b0:1e4:dcfe:848f with SMTP id i6-20020a17090332c600b001e4dcfe848fmr6586754plr.16.1714039483991;
        Thu, 25 Apr 2024 03:04:43 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902680300b001e107222eb5sm13626951plk.191.2024.04.25.03.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 03:04:43 -0700 (PDT)
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
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by\b)
Subject: [PATCH v3 2/7] crash_dump: make dm crypt keys persist for the kdump kernel
Date: Thu, 25 Apr 2024 18:04:26 +0800
Message-ID: <20240425100434.198925-3-coxu@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425100434.198925-1-coxu@redhat.com>
References: <20240425100434.198925-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240425_030449_749935_1A76EFD2 
X-CRM114-Status: GOOD (  22.30  )
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

A sysfs /sys/kernel/crash_dm_crypt_keys is provided for user space to make
the dm crypt keys persist for the kdump kernel. User space can send the
following commands,
- "init KEY_NUM"
  Initialize needed structures
- "record KEY_DESC"
  Record a key description. The key must be a logon key.

User space can also read this API to learn about current state.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/crash_core.h   |   5 +-
 kernel/Kconfig.kexec         |   8 +++
 kernel/Makefile              |   1 +
 kernel/crash_dump_dm_crypt.c | 113 +++++++++++++++++++++++++++++++++++
 kernel/ksysfs.c              |  22 +++++++
 5 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100644 kernel/crash_dump_dm_crypt.c

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index d33352c2e386..98825b7e0ea6 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -34,7 +34,10 @@ static inline void arch_kexec_protect_crashkres(void) { }
 static inline void arch_kexec_unprotect_crashkres(void) { }
 #endif
 
-
+#ifdef CONFIG_CRASH_DM_CRYPT
+int crash_sysfs_dm_crypt_keys_read(char *buf);
+int crash_sysfs_dm_crypt_keys_write(const char *buf, size_t count);
+#endif
 
 #ifndef arch_crash_handle_hotplug_event
 static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 6c34e63c88ff..88525ad1c80a 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -116,6 +116,14 @@ config CRASH_DUMP
 	  For s390, this option also enables zfcpdump.
 	  See also <file:Documentation/arch/s390/zfcpdump.rst>
 
+config CRASH_DM_CRYPT
+	bool "Support saving crash dump to dm-crypt encrypted volume"
+	depends on CRASH_DUMP
+	help
+	  With this option enabled, user space can intereact with
+	  /sys/kernel/crash_dm_crypt_keys to make the dm crypt keys
+	  persistent for the crash dump kernel.
+
 config CRASH_HOTPLUG
 	bool "Update the crash elfcorehdr on system configuration changes"
 	default y
diff --git a/kernel/Makefile b/kernel/Makefile
index 3c13240dfc9f..f2e5b3e86d12 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_VMCORE_INFO) += vmcore_info.o elfcorehdr.o
 obj-$(CONFIG_CRASH_RESERVE) += crash_reserve.o
 obj-$(CONFIG_KEXEC_CORE) += kexec_core.o
 obj-$(CONFIG_CRASH_DUMP) += crash_core.o
+obj-$(CONFIG_CRASH_DM_CRYPT) += crash_dump_dm_crypt.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
new file mode 100644
index 000000000000..847499cdcd42
--- /dev/null
+++ b/kernel/crash_dump_dm_crypt.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <keys/user-type.h>
+#include <linux/crash_dump.h>
+
+#define KEY_NUM_MAX 128
+#define KEY_SIZE_MAX 256
+
+// The key scription has the format: cryptsetup:UUID 11+36+1(NULL)=48
+#define KEY_DESC_LEN 48
+
+static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded"};
+enum STATE_ENUM {
+	FRESH = 0,
+	INITIALIZED,
+	RECORDED,
+	LOADED,
+} state;
+
+static unsigned int key_count;
+static size_t keys_header_size;
+
+struct dm_crypt_key {
+	unsigned int key_size;
+	char key_desc[KEY_DESC_LEN];
+	u8 data[KEY_SIZE_MAX];
+};
+
+struct keys_header {
+	unsigned int key_count;
+	struct dm_crypt_key keys[] __counted_by(key_count);
+} *keys_header;
+
+static size_t get_keys_header_size(struct keys_header *keys_header,
+				   size_t key_count)
+{
+	return struct_size(keys_header, keys, key_count);
+}
+
+static int init(const char *buf)
+{
+	unsigned int total_keys;
+	char dummy[5];
+
+	if (sscanf(buf, "%4s %u", dummy, &total_keys) != 2)
+		return -EINVAL;
+
+	if (key_count > KEY_NUM_MAX) {
+		pr_err("Exceed the maximum number of keys (KEY_NUM_MAX=%u)\n",
+		       KEY_NUM_MAX);
+		return -EINVAL;
+	}
+
+	keys_header_size = get_keys_header_size(keys_header, total_keys);
+	key_count = 0;
+
+	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
+	if (!keys_header)
+		return -ENOMEM;
+
+	keys_header->key_count = total_keys;
+	state = INITIALIZED;
+	return 0;
+}
+
+static int record_key_desc(const char *buf, struct dm_crypt_key *dm_key)
+{
+	char key_desc[KEY_DESC_LEN];
+	char dummy[7];
+
+	if (state != INITIALIZED)
+		pr_err("Please send the cmd 'init <KEY_NUM>' first\n");
+
+	if (sscanf(buf, "%6s %s", dummy, key_desc) != 2)
+		return -EINVAL;
+
+	if (key_count >= keys_header->key_count) {
+		pr_warn("Already have %u keys", key_count);
+		return -EINVAL;
+	}
+
+	strscpy(dm_key->key_desc, key_desc, KEY_DESC_LEN);
+	pr_debug("Key%d (%s) recorded\n", key_count, dm_key->key_desc);
+	key_count++;
+
+	if (key_count == keys_header->key_count)
+		state = RECORDED;
+
+	return 0;
+}
+
+static int process_cmd(const char *buf, size_t count)
+{
+	if (strncmp(buf, "init ", 5) == 0)
+		return init(buf);
+	else if (strncmp(buf, "record ", 7) == 0)
+		return record_key_desc(buf, &keys_header->keys[key_count]);
+
+	return -EINVAL;
+}
+
+int crash_sysfs_dm_crypt_keys_write(const char *buf, size_t count)
+{
+	if (!is_kdump_kernel())
+		return process_cmd(buf, count);
+	return -EINVAL;
+}
+EXPORT_SYMBOL(crash_sysfs_dm_crypt_keys_write);
+
+int crash_sysfs_dm_crypt_keys_read(char *buf)
+{
+	return sprintf(buf, "%s\n", STATE_STR[state]);
+}
+EXPORT_SYMBOL(crash_sysfs_dm_crypt_keys_read);
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 495b69a71a5d..98cc84d5510c 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -167,6 +167,25 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
 }
 KERNEL_ATTR_RO(vmcoreinfo);
 
+#ifdef CONFIG_CRASH_DM_CRYPT
+static ssize_t crash_dm_crypt_keys_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	return crash_sysfs_dm_crypt_keys_read(buf);
+}
+
+static ssize_t crash_dm_crypt_keys_store(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 const char *buf, size_t count)
+{
+	int ret;
+
+	ret = crash_sysfs_dm_crypt_keys_write(buf, count);
+	return ret < 0 ? ret : count;
+}
+KERNEL_ATTR_RW(crash_dm_crypt_keys);
+#endif /* CONFIG_CRASH_DM_CRYPT */
+
 #ifdef CONFIG_CRASH_HOTPLUG
 static ssize_t crash_elfcorehdr_size_show(struct kobject *kobj,
 			       struct kobj_attribute *attr, char *buf)
@@ -271,6 +290,9 @@ static struct attribute * kernel_attrs[] = {
 #endif
 #ifdef CONFIG_VMCORE_INFO
 	&vmcoreinfo_attr.attr,
+#ifdef CONFIG_CRASH_DM_CRYPT
+	&crash_dm_crypt_keys_attr.attr,
+#endif
 #ifdef CONFIG_CRASH_HOTPLUG
 	&crash_elfcorehdr_size_attr.attr,
 #endif
-- 
2.44.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
