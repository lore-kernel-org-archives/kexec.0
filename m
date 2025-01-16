Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552E5C02183
	for <kexec@archiver.kernel.org>; Thu, 16 Jan 2025 07:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F93kQVkCsCJNL9Y5XwGO7Li96Jeb80TvMhX68lBiTYM=; b=uHSRzU7OuhNhS3eHqWJ0BQuaJY
	fmQHkgZhWsSSF4lOmbozXSIewaESZ/+Oi6KqDTxgCNjM0fSgXJklAKA96dAHG8rFVJpUP8ar0SR5P
	j9ZEm9E2rqT6RgqpCVk5qe5VuDYA0mSyHj46EB67C1hj2SAjRysqwjDmBpd9wiGiAwCSXLqu3O+ud
	9x2UAuZUzi9SdrNCmAU1ODmRF5HTItHnpQ9OTl2VyOGMQwvADcd5bOcvDL9yWsOqC1HPBptfbtwsz
	nOio1ilIDDsgYkc9rfj4Ue/QD0P5KjSq/18a5nuOnUTcypyWXSkWGKVIoez5nuRTEDn39so6/E4Vn
	xwxo+lQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYJrK-0000000DzsI-0Pae;
	Thu, 16 Jan 2025 07:00:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYJq7-0000000DzcX-3tZq
	for kexec@lists.infradead.org;
	Thu, 16 Jan 2025 06:58:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737010731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F93kQVkCsCJNL9Y5XwGO7Li96Jeb80TvMhX68lBiTYM=;
	b=eA9SaAQ5UnAJ8fmm7o4S3Ub7bSCiclFvRPVVSPjakgd3LAnZ0BqmQhHqcR14xgTalJ8Qs7
	ozdwHPF7U7L9fDUcRFQ8weqiLzhI8A3SlcHN6Z4Pde+h/BHWN6R1yVewQ+YC9bP+nFtqE9
	gZ1BbXPth4By9hNfoFTUXwFOLMDc984=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-tqADdVHxPiOYPPEQ0tnM9Q-1; Thu, 16 Jan 2025 01:58:49 -0500
X-MC-Unique: tqADdVHxPiOYPPEQ0tnM9Q-1
X-Mimecast-MFC-AGG-ID: tqADdVHxPiOYPPEQ0tnM9Q
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef775ec883so1386154a91.1
        for <kexec@lists.infradead.org>; Wed, 15 Jan 2025 22:58:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737010725; x=1737615525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F93kQVkCsCJNL9Y5XwGO7Li96Jeb80TvMhX68lBiTYM=;
        b=M9wuaQZN7V0By+XG8y9ehdbidxMX0fNa9MY3VN8OT6J242n27zkGh3QTB4wJfW31YI
         StVxpUB+8JBpr/sZWjRMipU9xeFMLmhxJTFW5oMnUh6vlHlq3NLx+P0RFXOPnf78Rfqx
         Lv/vAuHo2G3NkypFp2pR5+fxD9gCT1kMskf3IbOZbF+7KtD/a/TSQ/+znqfMsYfKFiOm
         ZlsHE1jzuKgq9LH1/FSCnsgfenostEVytZP3reFFZy+3Ls5U1Gm9G72yhD/DCeKO96jf
         V4SGa+QSa9bEn4wdt3Df5HRCoOAPn0PHsTjpVRYwYDvNLP4eQaLeSV/7ivrzkM1Orm7d
         Se+Q==
X-Gm-Message-State: AOJu0Yz0NmEmrJNYd43+lIYUVaFFeaEu8TxtxJ8B4FzUC4FQnfzVtOcK
	NnHRr9DlUBkYgGMPuqrsfPx4o6oYGMcyQsxf4dIUwA5v+MaM/F/MiRqLC7TAHpXHCRjO+VP25xC
	BBTO1WOxhG9wQBubBUzHAsbUN5kbRkPB2D+kDlmWbNTHsaIkdOWDNbME73kM0ZtyzxU+eaT1tr5
	IjrKop1P+DOmHGv2PhlujAuoZnPx0TzAo0nzNC5GRklA==
X-Gm-Gg: ASbGncsWNneEhq8m+jC1CyA7BqUai8Yj4L51fHBmEtl6dD1qfW4qW5mIKfh6xc24++Q
	MkdOmdhwyCNJ9kvWu8N6PQeCB/xzxEBLaF3SA1AEZuH4V34wpS8xfs4s4O6rMcfO0Oq12RWtdgg
	UeG02D+arlL9nStmcvk7GmNMwwGleDAzBlLWrElVYFUF950//Xgne1tnQ3Q/EkQtC/vGm+34S6n
	1mVni/eGSvI6tUU1v/SyjEa1k1GL7y1mocjcf7VB3OuGOI3
X-Received: by 2002:a17:90b:2545:b0:2ee:693e:ed7c with SMTP id 98e67ed59e1d1-2f5490edb5fmr51202230a91.33.1737010725635;
        Wed, 15 Jan 2025 22:58:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwhoEAEGa8uJD6eJLSOncFzlqkhgLCFTLeey8Y1WHbpWJxLac0mMSmPS3qjC2CepgVd/2MxQ==
X-Received: by 2002:a17:90b:2545:b0:2ee:693e:ed7c with SMTP id 98e67ed59e1d1-2f5490edb5fmr51202183a91.33.1737010725215;
        Wed, 15 Jan 2025 22:58:45 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c156b9esm2552352a91.4.2025.01.15.22.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 22:58:44 -0800 (PST)
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
	Vivek Goyal <vgoyal@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH v7 4/7] crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging
Date: Thu, 16 Jan 2025 14:58:19 +0800
Message-ID: <20250116065825.1041558-5-coxu@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116065825.1041558-1-coxu@redhat.com>
References: <20250116065825.1041558-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Wh1P10DD_jYuWUntzfEokmtCpm3yeM3-rmlezlSuJcg_1737010729
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_225852_039176_59DCA118 
X-CRM114-Status: GOOD (  17.17  )
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
index 192d6796ab94..cecfa5d34f01 100644
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
 
 3. After dump-capture kerne get booted, restore the keys to user keyring
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 8c093c743d58..328d3dd0d8f6 100644
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
2.47.1


