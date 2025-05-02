Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146FEC3ABB0
	for <kexec@archiver.kernel.org>; Fri,  2 May 2025 01:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FI+GXrx5MXDfidTwssNH3+yBW/jsE3sUkCXkCFCf894=; b=JNMECFJaYZapEijFYUH+R10gKt
	xaPpfEX7brOgTWxz1KpDwppuJDFEZDzoVb2VLPTRQGX2EQiqQnxuT0EcTaJeXQLca8SQGUui2lmQS
	s6bg5YgTH03IwwxmYOLlM8C+X7my/D03FUIX9hyv1rlLVCHQL7hE6bOK0Nk9XjeSamcjH9eMRuVE4
	d9AyiXIuvfLfAs+VX1+/VBnZpGhFXztHz0Z+pktoUaoaE3jWk1loT4flJNXeGK87rAhnjfgkV6f8R
	RGrnH16Kd5/Nrc5oFUuFtMoPqAnEirzgOOjRVzEudzkGbzPs9KJsD6te6OwLnf+5kNLz//c0jDCWO
	2BdRI0Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAf0N-00000000UGy-3O9U;
	Fri, 02 May 2025 01:15:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAexm-00000000Tee-2rmx
	for kexec@lists.infradead.org;
	Fri, 02 May 2025 01:13:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746148393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FI+GXrx5MXDfidTwssNH3+yBW/jsE3sUkCXkCFCf894=;
	b=eFeEBhfWwUcJsxCCYBkVA97mUz5kS0RWzBskQrod8bjlMzJhUsMUzTAdiCO1Ft3k2Knpzy
	2CT+2oiqQ4socj5zHrKa+hL3jb3oQ2T1WT+iZHbkMRbSeRk4Q4wceG+tzFIwDmVQR6dIn9
	A3A8pIDt2u143Tdr3U1D2Fae9bt/olI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-up4I0OJSMOe3KkyBq8rSgg-1; Thu, 01 May 2025 21:13:12 -0400
X-MC-Unique: up4I0OJSMOe3KkyBq8rSgg-1
X-Mimecast-MFC-AGG-ID: up4I0OJSMOe3KkyBq8rSgg_1746148392
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b16f5365310so971163a12.1
        for <kexec@lists.infradead.org>; Thu, 01 May 2025 18:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746148391; x=1746753191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FI+GXrx5MXDfidTwssNH3+yBW/jsE3sUkCXkCFCf894=;
        b=E12L/Quqq7HmHT/9C8vhi72PuJKKpSUkGvgCKhVEvcUw9upYMYTfS5saQIr0uQ0UgD
         AS60x3wC8tuQXKjWALmCTF3AHiv0sql/l/rre3BNEqQcMd7kSsO9ju8pwxaGqkZKkwA4
         Rs54J/C0OHjb6WNVQOwQ0PJ/sSv74aDcgQmPrK3/Rwgp5VNxqpMGG76RuS/Rq9Y3c6fa
         UDLy8k2qZZAi7eeQPD6tqT9iBDQwgHvbwi47JZqPmZIrCtjwxBDWusi6Omc1f1RKS7LH
         uBbEea6TNpm8OIG31sRsuTobiDTwLr14sl7LNyiNSZe2igpkZcVczbcEFBBKQTOjLqsz
         o/9Q==
X-Gm-Message-State: AOJu0Ywesi6m4eOst1eAsu/ewjXL1mhb/R236mg0lK8HpK8brmsa1xOk
	89eVgaPYB/OFuydwaEVlrGODMe0Pv2hZRwBoUlzthZ7NP1YKQe184nDc+mxvXGbLPzEpOvJEgQp
	20EtBK8Vk9ax3dSN8AE/KAlhwNqTM0RH37auBBsosGq2wJNs5GJcxDdlLHrMx5x0TCHaL2LtERu
	AgIijWMopn0gsneYcOFPA3AWzouCsVGQvJNUzWhB8KCQ==
X-Gm-Gg: ASbGncvquVKSpurFxvIj0/kA/R+uoF3+5c/fUFgaFqeRBU3dYn6+4byqmkPlPfwK/H/
	ICHgNOykdgB7rqLxaWb6njJZicfdKKpNAQNQ1ssyHCFHyVZhZ9w1/b5KNBiyKhFrXwBkEtJBk4s
	n0htMtknr5jGBXrf0QnkCvezLt++3MsZgSEeqR31EFP3s2uiPeckDdfefhbM6OuiQJnLIQZpp6l
	JEerDEbwEV3jQRxIGOq5h8goyuTYRmQAK7g0kNnx+75JvIChoWi9q3lmzcatsy3THyHvJOmUcmN
	auM=
X-Received: by 2002:a05:6a20:d485:b0:1f5:72eb:8b3f with SMTP id adf61e73a8af0-20cdef3dd0bmr1473408637.24.1746148391520;
        Thu, 01 May 2025 18:13:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFedydzy7eFeNpzLzqKKw1fQGI2Jm/XlzKlKPwhgkEdBGZDZTrtlVKsxZROLBUauHe6nb4G+w==
X-Received: by 2002:a05:6a20:d485:b0:1f5:72eb:8b3f with SMTP id adf61e73a8af0-20cdef3dd0bmr1473355637.24.1746148391066;
        Thu, 01 May 2025 18:13:11 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fa82b68c1sm222557a12.37.2025.05.01.18.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 18:13:10 -0700 (PDT)
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
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH v9 4/8] crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging
Date: Fri,  2 May 2025 09:12:38 +0800
Message-ID: <20250502011246.99238-5-coxu@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502011246.99238-1-coxu@redhat.com>
References: <20250502011246.99238-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: re0WkYMfraYj3tDPN67VT2e3G133b-85KpkIVK26tpU_1746148392
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250501_181314_792681_87AA503E 
X-CRM114-Status: GOOD (  16.69  )
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

When there are CPU and memory hot un/plugs, the dm crypt keys may need
to be reloaded again depending on the solution for crash hotplug
support. Currently, there are two solutions. One is to utilizes udev to
instruct user space to reload the kdump kernel image and initrd,
elfcorehdr and etc again. The other is to only update the elfcorehdr
segment introduced in commit 247262756121 ("crash:
add generic infrastructure for crash hotplug support").

For the 1st solution, the dm crypt keys need to be reloaded again. The
user space can write true to
/sys/kernel/config/crash_dm_crypt_key/reuse so the stored keys can be
re-used.

For the 2nd solution, the dm crypt keys don't need to be reloaded.
Currently, only x86 supports the 2nd solution. If the 2nd solution
gets extended to all arches, this patch can be dropped.

Signed-off-by: Coiby Xu <coxu@redhat.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 Documentation/admin-guide/kdump/kdump.rst |  4 ++
 kernel/crash_dump_dm_crypt.c              | 52 +++++++++++++++++++++--
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index b74d3bed8fff..e25edaa8e533 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -570,6 +570,10 @@ encrypted disk volume. User space can interact with
     cat /sys/kernel/config/crash_dm_crypt_keys/count
     2
 
+    # To support CPU/memory hot-plugging, re-use keys already saved to reserved
+    # memory
+    echo true > /sys/kernel/config/crash_dm_crypt_key/reuse
+
 2. Load the dump-capture kernel
 
 3. After the dump-capture kerne get booted, restore the keys to user keyring
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index fb25f55f1512..5f4a62389150 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -28,6 +28,20 @@ static size_t get_keys_header_size(size_t total_keys)
 	return struct_size(keys_header, keys, total_keys);
 }
 
+static void get_keys_from_kdump_reserved_memory(void)
+{
+	struct keys_header *keys_header_loaded;
+
+	arch_kexec_unprotect_crashkres();
+
+	keys_header_loaded = kmap_local_page(pfn_to_page(
+		kexec_crash_image->dm_crypt_keys_addr >> PAGE_SHIFT));
+
+	memcpy(keys_header, keys_header_loaded, get_keys_header_size(key_count));
+	kunmap_local(keys_header_loaded);
+	arch_kexec_protect_crashkres();
+}
+
 static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
 {
 	const struct user_key_payload *ukp;
@@ -150,8 +164,36 @@ static ssize_t config_keys_count_show(struct config_item *item, char *page)
 
 CONFIGFS_ATTR_RO(config_keys_, count);
 
+static bool is_dm_key_reused;
+
+static ssize_t config_keys_reuse_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%d\n", is_dm_key_reused);
+}
+
+static ssize_t config_keys_reuse_store(struct config_item *item,
+					   const char *page, size_t count)
+{
+	if (!kexec_crash_image || !kexec_crash_image->dm_crypt_keys_addr) {
+		kexec_dprintk(
+			"dm-crypt keys haven't be saved to crash-reserved memory\n");
+		return -EINVAL;
+	}
+
+	if (kstrtobool(page, &is_dm_key_reused))
+		return -EINVAL;
+
+	if (is_dm_key_reused)
+		get_keys_from_kdump_reserved_memory();
+
+	return count;
+}
+
+CONFIGFS_ATTR(config_keys_, reuse);
+
 static struct configfs_attribute *config_keys_attrs[] = {
 	&config_keys_attr_count,
+	&config_keys_attr_reuse,
 	NULL,
 };
 
@@ -238,10 +280,12 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 		return -ENOENT;
 	}
 
-	image->dm_crypt_keys_addr = 0;
-	r = build_keys_header();
-	if (r)
-		return r;
+	if (!is_dm_key_reused) {
+		image->dm_crypt_keys_addr = 0;
+		r = build_keys_header();
+		if (r)
+			return r;
+	}
 
 	kbuf.buffer = keys_header;
 	kbuf.bufsz = get_keys_header_size(key_count);
-- 
2.49.0


