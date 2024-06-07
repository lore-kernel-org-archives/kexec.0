Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A60C27C55
	for <kexec@archiver.kernel.org>; Fri,  7 Jun 2024 12:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=74B2bwWITFlN0xWWXVFwm8qwBZxFyZKaKlSp2CWrGXo=; b=xs2ZbmahDOt4Gt
	GslSLAwdK/q3kPjAXi8IL6U+UTL7wroxRb+ZmJ9dSv+JXgZaTgd5QxGE7Nrn/A2bR6KJEc73avkN8
	midsGvxTXiQr5WKcT+7C+QuVt7ebr5h2fvUHycqEugjV4Adgi/koL7vgOnixnfITWkJjCmnRN0prU
	WekAZNA/34g/8oi2UTHIDfyQ3vrpQmiiaBvEAe3YEMfYNbkk/YUuHP4pRRn8shOwx9/4rQH1hMGMw
	gJPxI4d4408rVBgDLXMXNRje6a1NnEn2z+Uf0O51QMZBXXK8iutHy+sdKkbWh558Q0kG87owcozRA
	yyy9U96n7oqTPPNcwadw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYgD-0000000DuWB-0ALp;
	Fri, 07 Jun 2024 12:26:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYgA-0000000DuUG-3LM4
	for kexec@lists.infradead.org;
	Fri, 07 Jun 2024 12:26:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9lYCOcZIv1eEbutNfVll1yHQegSYHStXLGQ+PqX2DXc=;
	b=dnBapJqxXv9aWKx+KYBBlMdN5HLCR2ivLSkt2LxIWr1Waa7n4JqiKlzeIBZp1Nx8rsE+Uw
	YQiWnv0D5SsXoWYuIFD1eGzB31hgxGTyhkR/ZcywLX8ZyKCiC3x1bLo+OkNRFrNT3IlBhV
	0V/uKErXFe14GpYJWt8/zGwaRZH++4c=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-mfZ75ttlPiOky9UF0g_sVw-1; Fri, 07 Jun 2024 08:26:43 -0400
X-MC-Unique: mfZ75ttlPiOky9UF0g_sVw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-703f8e69279so1609243b3a.1
        for <kexec@lists.infradead.org>; Fri, 07 Jun 2024 05:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763200; x=1718368000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lYCOcZIv1eEbutNfVll1yHQegSYHStXLGQ+PqX2DXc=;
        b=jXhw7G/KBLKgfBtdwjkJqHi+C7R45AblBugXNd12FMcuVEZP4ci2d7GVycIydYheXC
         ivxDrXCxmV6ZUujGX7IdiBYslxgnGebc/w4TsGUP3IeVKqoaPJ+nGQCv6hEtNrWr66j+
         RQ6AZm5CK15r7kQAo0XGNJ2hBPLhOmYMganZQQ2/Pa1yzEYSmJlvxCLqdsyElHFQ/pNC
         em//qcWl3Q1Kc4LNn3TwHL+E8VBnuSnKft9jwGvWdNwn30g2O75EDbhE9dKSnIx7mhPh
         L4BublW51Rw9qTxDyfSUQjpG5uWG7hyBxU5LhU8F5bkS+5JV9RVRIzRp2Zr6DJ8n63q5
         HIww==
X-Gm-Message-State: AOJu0YzioU2vkrbdPwKNJXAyRJdqw9yXUcrTzw+dmrmH9BepufbQ+VtZ
	ax2Rk+fw3AizS1tYadJ94qXzi5WRaWFzFZUdKR9wN+eJLJQRc+IbuqmEHeB4gMSN5a3ZBnRkWDF
	NEpAzHF8keVntjDSGfUi0AJoWVHmpSyjIL1mde59VmJ8QF9a8WDYllA06cxOtK3U6B8Gsdh1gih
	Tq9TNwfXkaN8ZOcEzJ6+pzPew5p7hbS2QITTvitOBl8pEd
X-Received: by 2002:a05:6a00:c88:b0:6ed:cd4c:cc11 with SMTP id d2e1a72fcca58-7040c73ec1dmr2358840b3a.25.1717763199658;
        Fri, 07 Jun 2024 05:26:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnhco1D0ghdtJ+O7Sqy/OPScV+EmrGUd2pvgQQ43NKOLM+hzohcRPpHdNqjzLZX/DrU/IS0A==
X-Received: by 2002:a05:6a00:c88:b0:6ed:cd4c:cc11 with SMTP id d2e1a72fcca58-7040c73ec1dmr2358784b3a.25.1717763198596;
        Fri, 07 Jun 2024 05:26:38 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd4d94acsm2485189b3a.157.2024.06.07.05.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:26:38 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Vivek Goyal <vgoyal@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by\b)
Subject: [PATCH v5 2/7] crash_dump: make dm crypt keys persist for the kdump kernel
Date: Fri,  7 Jun 2024 20:26:12 +0800
Message-ID: <20240607122622.167228-3-coxu@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240607122622.167228-1-coxu@redhat.com>
References: <20240607122622.167228-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_052647_011474_8B61934A 
X-CRM114-Status: GOOD (  32.04  )
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

A sysfs /sys/kernel/crash_dm_crypt_keys is provided for user space to
make the dm crypt keys persist for the kdump kernel. Take the case of
dumping to a LUKS-encrypted target as an example, here is the life cycle
of this kdump copy of LUKS volume keys,

 1. After the 1st kernel loads the initramfs during boot, systemd
    use an user-input passphrase or TPM-sealed key to de-crypt the LUKS
    volume keys and then save the volume keys to specified keyring
    (using the --link-vk-to-keyring API) and the key will expire within
    specified time.

 2. A user space tool (kdump initramfs builder) writes a key description to
    /sys/kernel/crash_dm_crypt_keys to inform the 1st kernel to record the
    key while building the kdump initramfs

 3. The kexec_file_load syscall read the volume keys by recorded key
    descriptions and then save them key to kdump reserved memory and wipe the
    copy.

 4. When the 1st kernel crashes and the kdump initramfs is booted, the kdump
    initramfs asks the kdump kernel to create a user key using the key stored in
    kdump reserved memory by writing to to /sys/kernel/crash_dm_crypt_keys. Then
    the LUKS encrypted devide is unlocked with libcryptsetup's
    --volume-key-keyring API.

 5. The system gets rebooted to the 1st kernel after dumping vmcore to
    the LUKS encrypted device is finished

I assume 1) there are 128 LUKS devices at maximum to be unlocked thus
MAX_KEY_NUM=128 2) and a key won't exceed 256 bytes thus
MAX_KEY_SIZE=256 according to "cryptsetup benchmark".

For details on usage of the API, please check the new doc file
Documentation/ABI/testing/crash_dm_crypt_keys.

Cc: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 Documentation/ABI/testing/crash_dm_crypt_keys |  30 ++++
 include/linux/crash_core.h                    |   5 +-
 kernel/Kconfig.kexec                          |   9 ++
 kernel/Makefile                               |   1 +
 kernel/crash_dump_dm_crypt.c                  | 130 ++++++++++++++++++
 kernel/ksysfs.c                               |  24 ++++
 6 files changed, 198 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/crash_dm_crypt_keys
 create mode 100644 kernel/crash_dump_dm_crypt.c

diff --git a/Documentation/ABI/testing/crash_dm_crypt_keys b/Documentation/ABI/testing/crash_dm_crypt_keys
new file mode 100644
index 000000000000..e6a6f6be5a9e
--- /dev/null
+++ b/Documentation/ABI/testing/crash_dm_crypt_keys
@@ -0,0 +1,30 @@
+What:		/sys/kernel/crash_dm_crypt_keys
+Date:		Jun 2024
+KernelVersion:	6.11
+Contact:	kexec@lists.infradead.org
+Description:	read/write
+    Make dm crypt keys persistent for the kdump kernel.
+
+    Assume the key size won't exceed 256 bytes and the maximum number of keys is 128.
+
+    You can write the following commands before kexec'ing the kdump kernel,
+      - "init KEY_NUM"
+        Let the kernel know the number of dm crypt keys so it will initialize
+        needed structures. KEY_NUM=128 dm crypt keys at maximum.
+        - "record KEY_DESC"
+        Record a key description. For security reason, the key must be a logon
+        key whose payload can't be read by user space. For details, please refer
+        to security/keys/core.rst.
+
+    And you can also read this API to know the command eructation status,
+      - fresh
+        Waiting for a command
+      - initialized
+        The "init KEY_NUM" command has been executed successfully
+      - recorded
+        Specified number of keys have been recorded
+      - loaded
+        the kdump kernel has been loaded with the dm crypt keys stored to kdump
+        reserved memory
+
+User:		Kdump service
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 44305336314e..6bff1c24efa3 100644
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
 static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 6c34e63c88ff..d067ba252163 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -116,6 +116,15 @@ config CRASH_DUMP
 	  For s390, this option also enables zfcpdump.
 	  See also <file:Documentation/arch/s390/zfcpdump.rst>
 
+config CRASH_DM_CRYPT
+	bool "Support saving crash dump to dm-crypt encrypted volume"
+	depends on CRASH_DUMP
+	depends on DM_CRYPT
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
index 000000000000..608bde3aaa8e
--- /dev/null
+++ b/kernel/crash_dump_dm_crypt.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <keys/user-type.h>
+#include <linux/crash_dump.h>
+
+#define KEY_NUM_MAX 128   /* maximum dm crypt keys */
+#define KEY_SIZE_MAX 256  /* maximum dm crypt key size */
+
+// The key scription has the format: cryptsetup:UUID 11+36+1(NULL)=48
+#define KEY_DESC_LEN 48
+
+static enum STATE_ENUM {
+	FRESH = 0,
+	INITIALIZED,
+	RECORDED,
+	LOADED,
+} state;
+
+static const char * const STATE_STR[] = {
+	[FRESH] = "fresh",
+	[INITIALIZED] = "initialized",
+	[RECORDED] = "recorded",
+	[LOADED] = "loaded"
+};
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
+static struct keys_header {
+	unsigned int total_keys;
+	struct dm_crypt_key keys[] __counted_by(total_keys);
+} *keys_header;
+
+static size_t get_keys_header_size(struct keys_header *keys_header,
+				   size_t total_keys)
+{
+	return struct_size(keys_header, keys, total_keys);
+}
+
+/*
+ * Let the kernel know the number of dm crypt keys and allocate memory to
+ * initialize related structures.
+ */
+static int init(const char *buf)
+{
+	unsigned int total_keys;
+
+	if (sscanf(buf, "init %u", &total_keys) != 1)
+		return -EINVAL;
+
+	if (total_keys > KEY_NUM_MAX) {
+		kexec_dprintk(
+			"Exceed the maximum number of keys (KEY_NUM_MAX=%u)\n",
+			KEY_NUM_MAX);
+		return -EINVAL;
+	}
+
+	keys_header_size = get_keys_header_size(keys_header, total_keys);
+	key_count = 0;
+
+	if (keys_header != NULL)
+		kvfree(keys_header);
+
+	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
+	if (!keys_header)
+		return -ENOMEM;
+
+	keys_header->total_keys = total_keys;
+	state = INITIALIZED;
+	return 0;
+}
+
+/*
+ * Record the key description of a dm crypt key.
+ */
+static int record_key_desc(const char *buf, struct dm_crypt_key *dm_key)
+{
+	char key_desc[KEY_DESC_LEN];
+
+	if (state != INITIALIZED) {
+		kexec_dprintk("Please send the cmd 'init <KEY_NUM>' first\n");
+		return -EINVAL;
+	}
+
+	if (sscanf(buf, "record %s", key_desc) != 1)
+		return -EINVAL;
+
+	if (key_count >= keys_header->total_keys) {
+		kexec_dprintk("Already have %u keys", key_count);
+		return -EINVAL;
+	}
+
+	strscpy(dm_key->key_desc, key_desc, KEY_DESC_LEN);
+	kexec_dprintk("Key%d (%s) recorded\n", key_count, dm_key->key_desc);
+	key_count++;
+
+	if (key_count == keys_header->total_keys)
+		state = RECORDED;
+
+	return 0;
+}
+
+static int process_cmd(const char *buf, size_t count)
+{
+	if (strncmp(buf, "init ", 5) == 0)
+		return init(buf);
+	else if (strncmp(buf, "record ", 7) == 0 && count == KEY_DESC_LEN + 6)
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
+EXPORT_SYMBOL_GPL(crash_sysfs_dm_crypt_keys_write);
+
+int crash_sysfs_dm_crypt_keys_read(char *buf)
+{
+	return sysfs_emit(buf, "%s\n", STATE_STR[state]);
+}
+EXPORT_SYMBOL_GPL(crash_sysfs_dm_crypt_keys_read);
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 07fb5987b42b..ff7caef30f51 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -167,6 +167,27 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
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
+	if (ret < 0)
+		return ret;
+	return count;
+}
+KERNEL_ATTR_RW(crash_dm_crypt_keys);
+#endif /* CONFIG_CRASH_DM_CRYPT */
+
 #ifdef CONFIG_CRASH_HOTPLUG
 static ssize_t crash_elfcorehdr_size_show(struct kobject *kobj,
 			       struct kobj_attribute *attr, char *buf)
@@ -271,6 +292,9 @@ static struct attribute * kernel_attrs[] = {
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
2.45.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
