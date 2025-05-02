Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2ADDC3ABA9
	for <kexec@archiver.kernel.org>; Fri,  2 May 2025 01:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GBWfvLJxb5OXrN8DqbQaSB09FpR8x5OxSi6J4jIJ0dk=; b=buqqTahVM+ERoYbgxq7W3H5oos
	4ppV/mXQm+MaqX8RPLCMrLpmByyh/MAIMfbxgcBEAg2bkAul97ooCeUtNzSd795QMRMZg7mZ0kWNL
	tkfkauilrQgJLH1iHUVEMMl/92lvRTdNvJVyEP+H22TEiMdaIBN18HJWYlS3ZtefzfJ9L7IQ+vNOS
	LUzPUKgJHYNBGGrxYNdoRHQBd93hru0zSU2DfySj/jMAMYK9aQGpaKVTK3Z5vLCwDnGLb4Y7rPmls
	6YFjAUkEJXI4c7TQNbWa/K5ru4AqSV1dm+jUrtQhV5IdDBPAG9hm9DB17g0y29GeQTmKkv/DHB9WL
	AoUMdh0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAf0N-00000000UGR-1ZRP;
	Fri, 02 May 2025 01:15:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAexl-00000000Tds-19Rf
	for kexec@lists.infradead.org;
	Fri, 02 May 2025 01:13:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746148391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GBWfvLJxb5OXrN8DqbQaSB09FpR8x5OxSi6J4jIJ0dk=;
	b=QXYKJeDHcIao2YsnbT+qW6MPBM2ZkO3uxLRotdACZNKIAtmdXuuU1j/98jJvW1MTTdq+Jk
	bDbcTptIB3RWQOI3OC2/0CuIbuLmc45QE4MyzxK2uGScvC75Gd1dqMA1tqAh+atne8lpbZ
	6OjPrqatACFA3b5xiN2gUkCaIae/PRU=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-C9UmhtgqM762sIkpqVrREw-1; Thu, 01 May 2025 21:13:10 -0400
X-MC-Unique: C9UmhtgqM762sIkpqVrREw-1
X-Mimecast-MFC-AGG-ID: C9UmhtgqM762sIkpqVrREw_1746148389
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7394792f83cso1270378b3a.3
        for <kexec@lists.infradead.org>; Thu, 01 May 2025 18:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746148388; x=1746753188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBWfvLJxb5OXrN8DqbQaSB09FpR8x5OxSi6J4jIJ0dk=;
        b=TP1R4mqSuJwHmal/gVBfPGADrpWe6+HDo9o2qBIC1MQ7TTgXn0tNNhiOUECKwLuZLe
         kAd03C1wPapxdZuz2YyMVZu6YVaS7kNbNfVlF++IggMSgwzS4OeREsA6UQ+/s7kaR8cT
         1JmD36pSdV9guEX3EmAC3sfRTaKbslURmPvcd+JS9n5Y5WWUrp9L8VnUeuO51H6IsNyA
         NSZEUU3nWe9H3D8pn+25+aHnco0gxuvbA6AOLapYLPYNHuwXegjhGrsXcPxLpgmQ/VrS
         yvaSJALkz5d7iHSuRlRMrNt8hzfcORk9gcefT25nDMlwvfZqYeuU0MpdfnfBTlAGXxQf
         h4tg==
X-Gm-Message-State: AOJu0YyQ1EBCC6Mz54d+hhjgmBM8jMMz0Zzxevc610cP/UCgfnr+d2KU
	16+nWyGPLcw5lQf1fSIn6zQ8bSjsskL97S0Q0JVNCQXQxle9qpkZ5uQ9LFCb6f4VWpIc+WJo5Ou
	xiJK4d4uIBv2/l0UJIJTsU4f7GPdDsV+1Cvbc+bRAZExu5P0gumdTbfNv2QbUU4+j8HmCYFGKpc
	3PPwiGuniq/hUP0NuOe/EzLdXDid1EriWIGV+uwk6z7g==
X-Gm-Gg: ASbGnct/s3oVTFICuRoSwvtf5XU7hQ4cIe/dpmEXcBf8wdA/eMSf7MIc87yM+ZE7py/
	0+6IpDpXV5wZUjMrvwaA2xAjrFU5q4jKd/MVMxYXD4nM36sj+/qVch9M4TDyD1DYZLlitbdUTn0
	0qDQaKgR46orpiAyrSPtbZLaPKFi/FtrqpfYxcRzSBKwGlibjFsZkUXHO1YuwHaVOGSO9CRyO0V
	Z5EWGXwbcnHP7GPyb9JY3VxI1bblvzNkdIzjv8n2edhaO1Fc7v92lRbKfSNX/sBwrbTosIsgPO7
	k2I=
X-Received: by 2002:a05:6a00:ab01:b0:730:9801:d3e2 with SMTP id d2e1a72fcca58-74058a1af41mr1713874b3a.8.1746148387806;
        Thu, 01 May 2025 18:13:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWrlVfaGnH2bAuy9TSvG0bRVxSTF2k5lzCQyD8yusIUmdWs3IYHq0T9Uk0I4GD24HMDP8szQ==
X-Received: by 2002:a05:6a00:ab01:b0:730:9801:d3e2 with SMTP id d2e1a72fcca58-74058a1af41mr1713773b3a.8.1746148387017;
        Thu, 01 May 2025 18:13:07 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058d7adc9sm347612b3a.30.2025.05.01.18.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 18:13:06 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vivek Goyal <vgoyal@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH v9 3/8] crash_dump: store dm crypt keys in kdump reserved memory
Date: Fri,  2 May 2025 09:12:37 +0800
Message-ID: <20250502011246.99238-4-coxu@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502011246.99238-1-coxu@redhat.com>
References: <20250502011246.99238-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6npJw3-tqoCnvnjLJtO7XCA6FScAXAzrAM0GUQa2DNI_1746148389
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250501_181313_387322_893B397D 
X-CRM114-Status: GOOD (  18.99  )
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

When the kdump kernel image and initrd are loaded, the dm crypts keys
will be read from keyring and then stored in kdump reserved memory.

Assume a key won't exceed 256 bytes thus MAX_KEY_SIZE=256 according to
"cryptsetup benchmark".

Signed-off-by: Coiby Xu <coxu@redhat.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/linux/crash_core.h   |   6 +-
 include/linux/kexec.h        |   4 ++
 kernel/crash_dump_dm_crypt.c | 133 +++++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+), 1 deletion(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 44305336314e..2e6782239034 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -34,7 +34,11 @@ static inline void arch_kexec_protect_crashkres(void) { }
 static inline void arch_kexec_unprotect_crashkres(void) { }
 #endif
 
-
+#ifdef CONFIG_CRASH_DM_CRYPT
+int crash_load_dm_crypt_keys(struct kimage *image);
+#else
+static inline int crash_load_dm_crypt_keys(struct kimage *image) {return 0; }
+#endif
 
 #ifndef arch_crash_handle_hotplug_event
 static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 1871eaa95432..6e688c5d8e4d 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -405,6 +405,10 @@ struct kimage {
 	void *elf_headers;
 	unsigned long elf_headers_sz;
 	unsigned long elf_load_addr;
+
+	/* dm crypt keys buffer */
+	unsigned long dm_crypt_keys_addr;
+	unsigned long dm_crypt_keys_sz;
 };
 
 /* kexec interface functions */
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 62a3c47d8b3b..fb25f55f1512 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -1,14 +1,62 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/key.h>
+#include <linux/keyctl.h>
 #include <keys/user-type.h>
 #include <linux/crash_dump.h>
 #include <linux/configfs.h>
 #include <linux/module.h>
 
 #define KEY_NUM_MAX 128	/* maximum dm crypt keys */
+#define KEY_SIZE_MAX 256	/* maximum dm crypt key size */
 #define KEY_DESC_MAX_LEN 128	/* maximum dm crypt key description size */
 
 static unsigned int key_count;
 
+struct dm_crypt_key {
+	unsigned int key_size;
+	char key_desc[KEY_DESC_MAX_LEN];
+	u8 data[KEY_SIZE_MAX];
+};
+
+static struct keys_header {
+	unsigned int total_keys;
+	struct dm_crypt_key keys[] __counted_by(total_keys);
+} *keys_header;
+
+static size_t get_keys_header_size(size_t total_keys)
+{
+	return struct_size(keys_header, keys, total_keys);
+}
+
+static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
+{
+	const struct user_key_payload *ukp;
+	struct key *key;
+
+	kexec_dprintk("Requesting logon key %s", dm_key->key_desc);
+	key = request_key(&key_type_logon, dm_key->key_desc, NULL);
+
+	if (IS_ERR(key)) {
+		pr_warn("No such logon key %s\n", dm_key->key_desc);
+		return PTR_ERR(key);
+	}
+
+	ukp = user_key_payload_locked(key);
+	if (!ukp)
+		return -EKEYREVOKED;
+
+	if (ukp->datalen > KEY_SIZE_MAX) {
+		pr_err("Key size %u exceeds maximum (%u)\n", ukp->datalen, KEY_SIZE_MAX);
+		return -EINVAL;
+	}
+
+	memcpy(dm_key->data, ukp->data, ukp->datalen);
+	dm_key->key_size = ukp->datalen;
+	kexec_dprintk("Get dm crypt key (size=%u) %s: %8ph\n", dm_key->key_size,
+		      dm_key->key_desc, dm_key->data);
+	return 0;
+}
+
 struct config_key {
 	struct config_item item;
 	const char *description;
@@ -130,6 +178,91 @@ static struct configfs_subsystem config_keys_subsys = {
 	},
 };
 
+static int build_keys_header(void)
+{
+	struct config_item *item = NULL;
+	struct config_key *key;
+	int i, r;
+
+	if (keys_header != NULL)
+		kvfree(keys_header);
+
+	keys_header = kzalloc(get_keys_header_size(key_count), GFP_KERNEL);
+	if (!keys_header)
+		return -ENOMEM;
+
+	keys_header->total_keys = key_count;
+
+	i = 0;
+	list_for_each_entry(item, &config_keys_subsys.su_group.cg_children,
+			    ci_entry) {
+		if (item->ci_type != &config_key_type)
+			continue;
+
+		key = to_config_key(item);
+
+		if (!key->description) {
+			pr_warn("No key description for key %s\n", item->ci_name);
+			return -EINVAL;
+		}
+
+		strscpy(keys_header->keys[i].key_desc, key->description,
+			KEY_DESC_MAX_LEN);
+		r = read_key_from_user_keying(&keys_header->keys[i]);
+		if (r != 0) {
+			kexec_dprintk("Failed to read key %s\n",
+				      keys_header->keys[i].key_desc);
+			return r;
+		}
+		i++;
+		kexec_dprintk("Found key: %s\n", item->ci_name);
+	}
+
+	return 0;
+}
+
+int crash_load_dm_crypt_keys(struct kimage *image)
+{
+	struct kexec_buf kbuf = {
+		.image = image,
+		.buf_min = 0,
+		.buf_max = ULONG_MAX,
+		.top_down = false,
+		.random = true,
+	};
+	int r;
+
+
+	if (key_count <= 0) {
+		kexec_dprintk("No dm-crypt keys\n");
+		return -ENOENT;
+	}
+
+	image->dm_crypt_keys_addr = 0;
+	r = build_keys_header();
+	if (r)
+		return r;
+
+	kbuf.buffer = keys_header;
+	kbuf.bufsz = get_keys_header_size(key_count);
+
+	kbuf.memsz = kbuf.bufsz;
+	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	r = kexec_add_buffer(&kbuf);
+	if (r) {
+		kvfree((void *)kbuf.buffer);
+		return r;
+	}
+	image->dm_crypt_keys_addr = kbuf.mem;
+	image->dm_crypt_keys_sz = kbuf.bufsz;
+	kexec_dprintk(
+		"Loaded dm crypt keys to kexec_buffer bufsz=0x%lx memsz=0x%lx\n",
+		kbuf.bufsz, kbuf.memsz);
+
+	return r;
+}
+
 static int __init configfs_dmcrypt_keys_init(void)
 {
 	int ret;
-- 
2.49.0


