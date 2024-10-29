Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700B9D5B87A
	for <kexec@archiver.kernel.org>; Tue, 29 Oct 2024 05:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ar7onQpHiq07x1VuGUsgOQXk7tsACfZST11r8V71pas=; b=44OnSU+UpS80UK
	adPmwiamSKi0kI3I1Q7TchhQVE91OfNvLv+VaHG9gpnnR9IddrPNXR/8l7E35+gc2oGMYh3jMw9rg
	ZJaUMEFq2EK0gXSwg3jhCluTbdN1KP+5Oz2X6urdGkjlZFX38vSpyr1cAnWwowrh7UeiochGgI5A5
	XFH5i8x9aCmMqQYLC9iDSi1pJ6CYxw/7exrlvTz9wh3Dc4/KKpUHvNjoUpdv9vca1ywI/jC6U4ZeB
	ChVgbdgyONoDjTKZCYEZPR72JYSieVNFrG6b7b2BVeF7lwLBm24DSRqYdoY3oiO4uM7N2A94AbvN5
	fX+oKCbMj33b0VrfJd9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5fA1-0000000DIBr-0Hz7;
	Tue, 29 Oct 2024 05:52:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5f9z-0000000DIA0-0d5v
	for kexec@lists.infradead.org;
	Tue, 29 Oct 2024 05:52:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730181174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FowNBWjWbVItvQ2T5CYr3SncrK/lJISla1OHhnStC4=;
	b=biH8spjgeejRO7W4ZKXUL2SNyZwO84zNjMvy1lAWs4ZAS0fnZ8aIEq7WUG0bQJMB8MbmT8
	vbOm26yeB/R6baqtIqrGCo++8i7wLzTgK8PGYsackZzWEyXm+wqn8rqjHym1WBycmEbaqy
	fi3WfNVRKbxgPM71X0nZDQhXabD8BYY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-7axMpRWTNvKcaZvK6xjn2Q-1; Tue, 29 Oct 2024 01:52:53 -0400
X-MC-Unique: 7axMpRWTNvKcaZvK6xjn2Q-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e2bac0c38aso6331592a91.2
        for <kexec@lists.infradead.org>; Mon, 28 Oct 2024 22:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730181172; x=1730785972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FowNBWjWbVItvQ2T5CYr3SncrK/lJISla1OHhnStC4=;
        b=QwoMjI6AyXCheFheh5xZmVvjS/qs6r6hUZqmUo4kduReAHTLtrmOvRl3VIV6ioxamm
         2Qx8pVzubjUqA4V3f/JT42Xv5XuXNna85qPu3zE1amCKDJjq6Uxp/saNHEuFQ3ow/44d
         bo6UumcHu45uuuS0q8sOBN8nTSe+6vbBcIDF/HZ9fN753SoqgJ9aM+NWhYQohIM9r76+
         F6OkqNDlNajhmN0eTcCw/AjXN3evlX6PAQWQmousO+yqXhBnoqtlOV9bUhsBBzGJfmog
         EnwxLUmXKYqRnFYHbJlWeq3BDdHs5V9sulT1LceDp7lfrkHmY2LxQ4akMOl6tRtW3iMF
         K4jg==
X-Gm-Message-State: AOJu0Yz0MD+DEGuKV+IW6VK3JpDOTkjBhgG8kupvlyZYMBnhQnGD/bim
	oT8e4SN5ib8kUFl+GjHXooWKJ5HzVlgOhRFVt8lluAMi3ToT4G7x/EWDjLLCEcq+c3shO2dO5gs
	0jkIeCnR20E06L67cOMeiUEoB5u5xdHFKBmP7FdNABylyj8FZJsbUFz3J2dB3ZTJ8otffFV8mZm
	nnq0sLlPVEnNb900ZkpZ9E6ox6VpP5goPBh/KtMiOZ9fce
X-Received: by 2002:a17:90b:4c8c:b0:2e2:9522:278f with SMTP id 98e67ed59e1d1-2e8f11ab132mr12515463a91.32.1730181171908;
        Mon, 28 Oct 2024 22:52:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaZ9dQJ+Cd+rSku/B/Cyoe7dof5e0gGIxGIvrF0pzJfr4i782JDqBryN6BPGY3NXt1ZlWUyw==
X-Received: by 2002:a17:90b:4c8c:b0:2e2:9522:278f with SMTP id 98e67ed59e1d1-2e8f11ab132mr12515437a91.32.1730181171510;
        Mon, 28 Oct 2024 22:52:51 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e48bb51sm10510164a91.11.2024.10.28.22.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 22:52:49 -0700 (PDT)
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
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v6 4/7] crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging
Date: Tue, 29 Oct 2024 13:52:17 +0800
Message-ID: <20241029055223.210039-5-coxu@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029055223.210039-1-coxu@redhat.com>
References: <20241029055223.210039-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_225255_349801_AA1EDED7 
X-CRM114-Status: GOOD (  16.20  )
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
 kernel/crash_dump_dm_crypt.c | 52 +++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index ec2ec2967242..51431f93fc1e 100644
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
 
+static bool reuse;
+
+static ssize_t config_keys_reuse_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%d\n", reuse);
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
+	if (kstrtobool(page, &reuse))
+		return -EINVAL;
+
+	if (reuse)
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
 		return -EINVAL;
 	}
 
-	image->dm_crypt_keys_addr = 0;
-	r = build_keys_header();
-	if (r)
-		return r;
+	if (!reuse) {
+		image->dm_crypt_keys_addr = 0;
+		r = build_keys_header();
+		if (r)
+			return r;
+	}
 
 	kbuf.buffer = keys_header;
 	kbuf.bufsz = get_keys_header_size(key_count);
-- 
2.47.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
