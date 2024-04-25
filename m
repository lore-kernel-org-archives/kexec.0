Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9174DC4345F
	for <kexec@archiver.kernel.org>; Thu, 25 Apr 2024 10:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3tM97n09GOZ5B6kM1UYtdfhpxdJsyihjVZnqQm/r22o=; b=KpyTwX7fJ610tW
	bbaFzBXnVNKTfEJD/caeytsN/VGZwCGowqmcyMWBaARmsMuq1cLKWAMb8cbz7Cghuo5MupAfZqZKP
	WDF8H8j+E2w2qkC/k0Fk6Ek91RSFBP/uP48R/tvbZXXFkYE89FqScGBn8YZtFg97XmgvumDopgvkU
	KopXpU+4i/vZxrJixsPJbWR7j3pUXdpkz5CCRubmTEIPXMZaZQCkSXKyKqON1uqzO1AYFFBrLlvQQ
	PCE/NKbNjZd6wmFx184/jTyOgk05MsxeL6eK7SFrykZ/llZEzDxUDNbNXXMAEA9qr99XUGht1O48b
	96rF7rE+B2mb+g4WhPlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzvyN-00000007kip-0PcC;
	Thu, 25 Apr 2024 10:04:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzvyJ-00000007kfW-2zSM
	for kexec@lists.infradead.org;
	Thu, 25 Apr 2024 10:04:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714039494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLflBXNszRtBuRpxO//dVzBazjZLk2Gj5DkRzwtS+Dk=;
	b=UFu3XUYh2uxg2N8zSI144uKZI7ogn1j6HvldKd5Fzk0TZC0G5KUyoMVSiy9otofL8KU6uH
	hQplaV3Tc1GZvKQT/5rtjQSQgaoOrwVxQ2FIP8AmRCHPsoWq/Q0MxxlloMjHKSCC7PoAZu
	uYjKYmeP8jXAtWTYpgmT6KBeRcQuGbY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-XAcI11eQPa6ul8c_lt5tvA-1; Thu, 25 Apr 2024 06:04:53 -0400
X-MC-Unique: XAcI11eQPa6ul8c_lt5tvA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1e851c0204aso9553635ad.3
        for <kexec@lists.infradead.org>; Thu, 25 Apr 2024 03:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714039492; x=1714644292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLflBXNszRtBuRpxO//dVzBazjZLk2Gj5DkRzwtS+Dk=;
        b=fb74aGy47de1fz2MwslF9Wdgm38xBcXMJ3ZLgrtal83JzKh2U+fRsCXlVXWO1YDfIA
         +5dOkzKZELRkTrkUamF8AHqsUbf4nFxbEnWEPceNGaHvRoM7300YkL0EJ0YvPrerp/WY
         OOT5emJNXK28YPDtaR/i1J4fUYUW0d0AGKTffXIQ+zcZEiPNRMHE3tbTYycn1s1bUYu6
         rCauHGh46tGjM4anRKEEyAs53P8EQ4Ee0FzZzs7AltCI3fFwTvo/ws7uJQgPNmzL6nNi
         NChmjz2PXrcOrBP2K1GMGQ2yYBO/FHBw1ip/rc2Do9x+9IGMP4Qq6O5wMYse9NJbK+xT
         C3uQ==
X-Gm-Message-State: AOJu0YyaZLPuhfJAKM7MEE9W8Q825hcGPtlsVfOtafr/BkU8sPzcsYF4
	qJiA0Epl7aKFyM7/QRE8neJYDcdv9CiiSgQOfAmSp03KZyfNsgWKaABzlWi0ZYEUaudFj+vmH3I
	aGcKC5dzGkrKQSxeJk+IawhwqFmimKs0AzERGmnLoo/O01Zu/lea5OJGs2twgxHeKiXCJddZqIx
	27beE/SzN/0SdcZccnSgxLaB3n0wC9H+i+nVU9C6iUfttL
X-Received: by 2002:a17:903:2288:b0:1e4:49:de46 with SMTP id b8-20020a170903228800b001e40049de46mr6875518plh.47.1714039491798;
        Thu, 25 Apr 2024 03:04:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZFjoqzqm/eHvCHGiqfc9ChhdN+leiDzn4HzL+638L4OQVPvBwwbFi4eWPAqIrNcCbrUhKgA==
X-Received: by 2002:a17:903:2288:b0:1e4:49:de46 with SMTP id b8-20020a170903228800b001e40049de46mr6875447plh.47.1714039490967;
        Thu, 25 Apr 2024 03:04:50 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kp7-20020a170903280700b001e99fdbc515sm7461086plb.3.2024.04.25.03.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 03:04:50 -0700 (PDT)
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
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v3 4/7] crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging
Date: Thu, 25 Apr 2024 18:04:28 +0800
Message-ID: <20240425100434.198925-5-coxu@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425100434.198925-1-coxu@redhat.com>
References: <20240425100434.198925-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240425_030455_869839_3F62D309 
X-CRM114-Status: GOOD (  14.79  )
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

When there is CPU/memory hot-plugging, the kdump kernel image and initrd
will be reloaded. The user space can write the "reuse" command to
/sys/kernel/crash_dm_crypt_key so the stored keys can be re-saved again.

Note currently only x86 (commit ea53ad9cf73b ("x86/crash: add x86 crash
hotplug support")) and ppc (WIP) supports the new infrastructure
(commit 247262756121 ("crash: add generic infrastructure for crash
hotplug support")). If the new infrastructure get extended to all arches,
this patch can be dropped.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 kernel/crash_dump_dm_crypt.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index b9997fb53351..6ac1fabdb6cb 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -10,12 +10,13 @@
 // The key scription has the format: cryptsetup:UUID 11+36+1(NULL)=48
 #define KEY_DESC_LEN 48
 
-static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded"};
+static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded", "reuse"};
 enum STATE_ENUM {
 	FRESH = 0,
 	INITIALIZED,
 	RECORDED,
 	LOADED,
+	REUSE,
 } state;
 
 static unsigned int key_count;
@@ -90,12 +91,31 @@ static int record_key_desc(const char *buf, struct dm_crypt_key *dm_key)
 	return 0;
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
+	memcpy(keys_header, keys_header_loaded, keys_header_size);
+	kunmap_local(keys_header_loaded);
+	state = RECORDED;
+}
+
 static int process_cmd(const char *buf, size_t count)
 {
 	if (strncmp(buf, "init ", 5) == 0)
 		return init(buf);
 	else if (strncmp(buf, "record ", 7) == 0)
 		return record_key_desc(buf, &keys_header->keys[key_count]);
+	else if (!strcmp(buf, "reuse")) {
+		state = REUSE;
+		get_keys_from_kdump_reserved_memory();
+		return 0;
+	}
 
 	return -EINVAL;
 }
@@ -175,9 +195,11 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 	}
 
 	image->dm_crypt_keys_addr = 0;
-	r = build_keys_header();
-	if (r)
-		return r;
+	if (state != REUSE) {
+		r = build_keys_header();
+		if (r)
+			return r;
+	}
 
 	kbuf.buffer = keys_header;
 	kbuf.bufsz = keys_header_size;
-- 
2.44.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
