Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCDDC25B75
	for <kexec@archiver.kernel.org>; Thu, 23 May 2024 05:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SILsgYEZGdo5MV55IK740ZzDEsqu1b+wams9DaAHnRo=; b=rN3Kv8VAmTcO5e
	Fwkivrbx+cqaL6s5ppD8h6fJHI6jjTCOAPVz3Jq/qOqXD5lQepN/qEjqFsB00f7nNcDq1r4xx7nzQ
	O92WsS8qlh92oXmDuJl+Daj7l7pxPN8K3kOlEe84LJwWUx7iNFSMdHJRwEACeq37ZGfOTlTK964jf
	KmkctY0vKMyp/1R0GK45o2AdV8NpfmrjzmIVgaiZONMMBF4ebji5MFjF1qya6p7Wxu9+7cV9YoIPw
	OUX5eq44dML3RNcErBybag/kZuDvYHS5YAE3VSYXH5mvZnO9Y6YB5qL1HEzNdDEiEjWvDuA4m00jt
	3xlO2en3ELlTHPnbDyhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA0dm-000000053uu-1q9W;
	Thu, 23 May 2024 05:05:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA0dg-000000053py-100D
	for kexec@lists.infradead.org;
	Thu, 23 May 2024 05:05:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716440715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwcExXXLPYnBFndSXcLNg5IgaO4KxZIIlwgUQB+aV8U=;
	b=hL8a0y96z3f6qw/htTZ0bT18lIeONGc3PXYtJo5lme7LLsbgKpI96G4BOJQ93449YgvH0r
	WET+WjqjAUhPRxIsf4rXWgbD6QGwZWmlV3U9qC38HE22IZM+PY+McUKGXpSzvqx4Pc7csO
	aME0p7M9+Mhh8sCiS9X2Gyyi1UA8eqc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-7m2E6vP9PLKxaoGWFAkjZQ-1; Thu, 23 May 2024 01:05:13 -0400
X-MC-Unique: 7m2E6vP9PLKxaoGWFAkjZQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2b38e234a96so854044a91.0
        for <kexec@lists.infradead.org>; Wed, 22 May 2024 22:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716440712; x=1717045512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwcExXXLPYnBFndSXcLNg5IgaO4KxZIIlwgUQB+aV8U=;
        b=P01fFyHFb9FiP2Kja9qWYjZxOKw9UItuSJgAqYczxddcVg1tEOZ6pUbZy509s9a+Az
         B3BIroARU+Kvmx8wCoCM8k4GWlEQJwW2AC8/XIqfr7LTnGRF6XCNmKgB3/aQbxeIOEbM
         0gcy1iB/F0IcvK9bNAiRLIp+8fivzbWPa2+5e2/Fsg4lghStSEDcew5k7usIFxQqf2xN
         vy4phBTMPBcyV/50i6mF+4QIZy1Ff+EW70RXTtZ4PPnpaBaDfvljJeJqTjrsnGk9WPYQ
         a5M+D3o75G7dpiKFcQPBNd507ZsjuuskGaa1Y4OGnvlGE3betBAdI/w3b3BNUUyava4Y
         MvFQ==
X-Gm-Message-State: AOJu0Yy/M/0MeZK+z8Pqssj9WY5BIiNelwutKyV3NlIO4FZZT8mvqsrD
	0jhLlW8ZHhiKeLHFC3s4DSch84oW7hzZ//dBX3etuKJWSqy7KPF6rMjNWlk9U1ngphTYNEQvYu9
	O8SYENugLjqUJf/qp+DY3e1kXQVWS8XQk+tVZClGVi0oVINPiHgBt/SIwOCYikuyuys7RpScuXP
	fZO292j4J423tFKDr6ZNTRS55rsru2MBPaFY8CgyQTZQ==
X-Received: by 2002:a17:90b:3002:b0:2bd:ec55:9f38 with SMTP id 98e67ed59e1d1-2bdec559fbfmr284164a91.29.1716440711955;
        Wed, 22 May 2024 22:05:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRR+6oMpSEO77P0mkaAygN4BkX2R/W8hIA3+G2zdrDxCovM2XxnoMXOUOMXl6NUFojPYs4MQ==
X-Received: by 2002:a17:90b:3002:b0:2bd:ec55:9f38 with SMTP id 98e67ed59e1d1-2bdec559fbfmr284127a91.29.1716440711222;
        Wed, 22 May 2024 22:05:11 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdd9ee2460sm681073a91.1.2024.05.22.22.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 22:05:10 -0700 (PDT)
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
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v4 4/7] crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging
Date: Thu, 23 May 2024 13:04:45 +0800
Message-ID: <20240523050451.788754-5-coxu@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240523050451.788754-1-coxu@redhat.com>
References: <20240523050451.788754-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_220516_475829_C62197E2 
X-CRM114-Status: GOOD (  14.72  )
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
index 89fec768fba8..b4dc881cc867 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -10,12 +10,13 @@
 // The key scription has the format: cryptsetup:UUID 11+36+1(NULL)=48
 #define KEY_DESC_LEN 48
 
-static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded"};
+static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded", "reuse"};
 static enum STATE_ENUM {
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
2.45.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
