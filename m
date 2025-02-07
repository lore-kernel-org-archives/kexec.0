Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860D3C0219E
	for <kexec@archiver.kernel.org>; Fri,  7 Feb 2025 08:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vs/fEt8187919W7bAsJ6ILZH4C6hECupt8Iw6rDvcR8=; b=albZxoJfwcFuZ1//lrl1bxTphG
	WAmbmOOMHQq6uYXwNnKV3+4AKGnzkPNgf9JqaxD04Q4TKmUNRdPsRVgq6aF7iEOUxjuW8iRBdj96O
	+3puECT6RW04cAjizaAd8JnUSjZjXDNVCSj3epmSGBD/x7zLeS6kFcUV2BZcMKSW8ASZ+lIk/icTi
	bQELhAHiHQSZwOSV86CA5kIbWLxzp+SI8hIldpzBJCyd8UVaBR3IlH+e7/FOl3M4bfoBCANCWY2kx
	ByxbhYx0v4jvnYFH8yBxR/++iLNzibkgl4KMQV+FeKCq9py2CxOsW7ZM6ezbUi4qw4+FGDv/ba3QD
	KfVK59kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgJQy-00000008lAv-0i2d;
	Fri, 07 Feb 2025 08:09:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgJPo-00000008kjy-1vPZ
	for kexec@lists.infradead.org;
	Fri, 07 Feb 2025 08:08:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738915723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vs/fEt8187919W7bAsJ6ILZH4C6hECupt8Iw6rDvcR8=;
	b=EGYjAlMTlHunsXKoICJcVmgzsAbCvHCZQ2mb1nQ3PCysr6IlD/6XzmxFqfa8Z031vswxvT
	XWdCnRqnmVa2ECA45gP3fP0Eq6Cd9RRDEfnEHOzc3eSFkSEKL3Tqq0ErG0bN1pcP38ldaU
	k+6gU1wWeDf6CJNprF1pguGrfxRxwko=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-P5y_ooWKNruunI_94AYMGA-1; Fri, 07 Feb 2025 03:08:40 -0500
X-MC-Unique: P5y_ooWKNruunI_94AYMGA-1
X-Mimecast-MFC-AGG-ID: P5y_ooWKNruunI_94AYMGA
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21f40f40788so33081585ad.3
        for <kexec@lists.infradead.org>; Fri, 07 Feb 2025 00:08:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738915719; x=1739520519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vs/fEt8187919W7bAsJ6ILZH4C6hECupt8Iw6rDvcR8=;
        b=ZL5zwezLxhMOI41lrEpVjop7sn+lV8iC2/VTHkuPY0x4Rvg7riiqyxAqWoSRiOZxNt
         AROC48jLXOSC9KeQEfgirx5v0lvMvbOQpr4xeRWmhx6yuuo1G1UMfhR3I66cvlqnO0iy
         tLUrq9mLc2fyplIotF7mSJIGNDs2Xb0/gpDxrHITzJNnQICW6oax62ImCpnMB1IxZfO7
         /byJLJnyRoo3uduNEDwLc95IpWS1hcuDSY2iRxqeEVsLJ5NNQCE+jv6y8JrcOD2AxugE
         z1ljrbZMU6L25pVYuTv8JtHTLoBKwUSFiJcBjOYmtgZ9Pa7If08HpfKig738ssHoJrDY
         z8mw==
X-Gm-Message-State: AOJu0YxtLQUdSGP7wSw9L41hxweGFcXaKtpYzXOsyP1x3dRFOyb33gJr
	T3mohwNdpLKGlqCR9KAIRIqA29ThvkSGwjgnaF5YyYB8IveY7GTb8UoK3DtJjyDlh2Su9EZqdlu
	JWo1pdUx5k+zUkDHdOSe42BQrdxIIsnKjkOOEgomcjlB2vMZqK+3PpPc8YDv1Wz9BwPi37OF1Wa
	AaH5RYRK8bfOw+NglIe6Z6uJ0nMlTQrsgdi+1yCUVN2Q==
X-Gm-Gg: ASbGnctpFn5giK/BDarLoiYKqDh4jTmURMydSuzyhkzmzSYhWrq0/jfprGATzUQYd61
	m8yXM4cy2/Ap0kUEXH31fF+rzOwT7GzDR7lAvfSVPupbTlWMZ71kUeHkLD4VNUSY4j1pEAnVWwn
	3Z7lMy12wEUsLfYikEFIbtb6/ymPYCN7jKn6Njiva2TLw9/18H5UECaKUd1D79SdU71j0gMW1w2
	ZyY1IxSfEPjbz1uXHB7t8h5hjal/nPKgW8ISE3vMZUAHiP5YKjfcXupUwCbJYUuaeYFXbbh
X-Received: by 2002:a17:902:f542:b0:21e:ff31:526 with SMTP id d9443c01a7336-21f4e77b902mr43522205ad.43.1738915719296;
        Fri, 07 Feb 2025 00:08:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDtGAWMniDa7kdL3sNgA7bh1GCtIrQ4jLjUrxyTT7Lx6LA9FXZwINkgBT1U4ESkAYbK9t2sg==
X-Received: by 2002:a17:902:f542:b0:21e:ff31:526 with SMTP id d9443c01a7336-21f4e77b902mr43521655ad.43.1738915718900;
        Fri, 07 Feb 2025 00:08:38 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f365616ecsm24825295ad.100.2025.02.07.00.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 00:08:37 -0800 (PST)
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
	Vivek Goyal <vgoyal@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH v8 4/7] crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging
Date: Fri,  7 Feb 2025 16:08:12 +0800
Message-ID: <20250207080818.129165-5-coxu@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207080818.129165-1-coxu@redhat.com>
References: <20250207080818.129165-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WtIIwRYifBPVpDFlOwfV8MIgw5-crh5DY6058xPG13A_1738915719
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_000844_585195_0479815D 
X-CRM114-Status: GOOD (  16.47  )
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
---
 Documentation/admin-guide/kdump/kdump.rst |  4 ++
 kernel/crash_dump_dm_crypt.c              | 52 +++++++++++++++++++++--
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 83d422d761b6..1283f0244614 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -574,6 +574,10 @@ encrypted disk volume. User space can interact with
     cat /sys/kernel/config/crash_dm_crypt_keys/count
     2
 
+    # To support CPU/memory hot-plugging, re-use keys already saved to reserved
+    # memory
+    echo true > /sys/kernel/config/crash_dm_crypt_key/reuse
+
 2. Load the dump-capture kernel
 
 3. After the dump-capture kerne get booted, restore the keys to user keyring
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 00dc6a3f71ca..e4e0cc1c3399 100644
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
 
@@ -233,10 +275,12 @@ int crash_load_dm_crypt_keys(struct kimage *image)
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
2.48.1


