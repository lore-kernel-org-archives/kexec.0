Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07370D5B87C
	for <kexec@archiver.kernel.org>; Tue, 29 Oct 2024 05:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GZ1ldChr+jNvifZLacqmP2RPxq48I2F4HyrfFxCYufg=; b=0nE4rym6Mwiwm4
	zfRjZ7QfZ6iQMvYmBN4NX5QTGPXBRQZJinVMAuwS9Z1/97GMp73+Zm1tGLQzLcca9brsmSJdf+s9b
	Fh1ayKxo5uoksgt+1r5pfFHnb32TM6cMG4q0//HuSbyEGB6Tp4mriA5ldla9dvIiz6142vPx4OcPo
	02as6tuuvDiWjd4ql7sJxDdIWkwiEb/aQPA67ApfX8KIkPyKoJtFrFssmJSVDdDoNX5HJVsda9ucG
	VjyzDfWU4yPYPoHx6gAWKcX9de969bmoT284w7nZQ1gXPio9jwAIOoekiaMPIijLYzlz3hEThaW/A
	YTbbSyEYv6dDdD85aw2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5f9k-0000000DI04-2yQk;
	Tue, 29 Oct 2024 05:52:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5f9h-0000000DHxO-2kzG
	for kexec@lists.infradead.org;
	Tue, 29 Oct 2024 05:52:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730181156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfQRV/dv4U0HCeNe7nsPQHTJHsNlbpGtvoqQINu/Ues=;
	b=WmJhN0MdMXelJoY0JxKr1mV56yPukADnvZlMIM3NvJ4NO7gZ5g9Bl+eVLCeI+znlED+q9r
	Rtht5gSxEqo+hnRVNTLCSAx5ZhpeRKZmmwsUYK8YEBeIEh7bIqlTWqowK0wD/hyEMu4URz
	IxdeuxC5YA31dCPyq2xO33y0SJD1eoA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-d5Ul34DJOUOG7x6QXrCVvA-1; Tue, 29 Oct 2024 01:52:35 -0400
X-MC-Unique: d5Ul34DJOUOG7x6QXrCVvA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7202dfaa53fso7136528b3a.0
        for <kexec@lists.infradead.org>; Mon, 28 Oct 2024 22:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730181153; x=1730785953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfQRV/dv4U0HCeNe7nsPQHTJHsNlbpGtvoqQINu/Ues=;
        b=Y1rdYi6e7gVtYM1L2O0nDIRgt7C+NU6vJonxp2XV+wcaXTW3UMCn4T2vBYO34nr/pE
         3d07dyJ17OXtak3B4U3oSbqTcdT31QdARWSe0SH6SXk3os4usM/SeHugsdGP0+q+Lpqe
         ynklUArAH4eo6fV6qm75ZKiPVHqlcyjUk7xHzNq+wdXlyIQxKk0bk3bXlEcTTgLQ+ijJ
         FWjLF6/G4R5CqEmlaFkt6p/3aKtkkj4eO0nkCJgzYaipOrldFWMNqqwxwUFkLZufJe5i
         Z7GZGY99Y7tQU0qO6b5wm573b3QYsZjLLwhVr2G5EUxo+4GXQgrGSqMJr2omCy1q2aqX
         Ar5A==
X-Gm-Message-State: AOJu0Yxn+WIrtsQIharE+OhbWwX4S85dhOA44ohmEs+IWk5kpIC/uyyy
	/pun753P95KLJ3AT7TaS92C4Uc+M5rINV6yQEqU4ipayUNffC9wYAnNsKw63gZIRVibdd/q5OOg
	ZBZv8GHV0dNeBfO3a8uvR77J4j5YniPlOSaP8yOE4VeQDCyvzasee98O9dqC7BlaYyTweyEyU2/
	ygzDoA3HzDouHQGYGK1BhGsDM1R63Krv8oF52AgFo8gzzs
X-Received: by 2002:a05:6a00:cca:b0:71e:64fe:965f with SMTP id d2e1a72fcca58-72063072a39mr16213223b3a.20.1730181153571;
        Mon, 28 Oct 2024 22:52:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLxIlu9DkjWvKRHGMJ0mqkMLya+w2yF4n0UBh5fuzAHKNAUx2a3Ph3LsR4pd+vmQ0zxRU0oQ==
X-Received: by 2002:a05:6a00:cca:b0:71e:64fe:965f with SMTP id d2e1a72fcca58-72063072a39mr16213193b3a.20.1730181153128;
        Mon, 28 Oct 2024 22:52:33 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a21b79sm6906605b3a.176.2024.10.28.22.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 22:52:32 -0700 (PDT)
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
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v6 1/7] kexec_file: allow to place kexec_buf randomly
Date: Tue, 29 Oct 2024 13:52:14 +0800
Message-ID: <20241029055223.210039-2-coxu@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029055223.210039-1-coxu@redhat.com>
References: <20241029055223.210039-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_225237_794767_2AD8CD70 
X-CRM114-Status: GOOD (  16.00  )
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

Currently, kexec_buf is placed in order which means for the same
machine, the info in the kexec_buf is always located at the same
position each time the machine is booted. This may cause a risk for
sensitive information like LUKS volume key. Now struct kexec_buf has a
new field random which indicates it's supposed to be placed in a random
position.

Suggested-by: Jan Pazdziora <jpazdziora@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/kexec.h | 28 ++++++++++++++++++++++++++++
 kernel/kexec_file.c   |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f0e9f8eda7a3..0dc66ca2506a 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -25,6 +25,10 @@
 
 extern note_buf_t __percpu *crash_notes;
 
+#ifdef CONFIG_CRASH_DUMP
+#include <linux/prandom.h>
+#endif
+
 #ifdef CONFIG_KEXEC_CORE
 #include <linux/list.h>
 #include <linux/compat.h>
@@ -171,6 +175,7 @@ int kexec_image_post_load_cleanup_default(struct kimage *image);
  * @buf_min:	The buffer can't be placed below this address.
  * @buf_max:	The buffer can't be placed above this address.
  * @top_down:	Allocate from top of memory.
+ * @random:	Place the buffer at a random position.
  */
 struct kexec_buf {
 	struct kimage *image;
@@ -182,8 +187,31 @@ struct kexec_buf {
 	unsigned long buf_min;
 	unsigned long buf_max;
 	bool top_down;
+#ifdef CONFIG_CRASH_DUMP
+	bool random;
+#endif
 };
 
+
+#ifdef CONFIG_CRASH_DUMP
+static inline void kexec_random_start(unsigned long start, unsigned long end,
+				      struct kexec_buf *kbuf,
+				      unsigned long *temp_start)
+{
+	unsigned short i;
+
+	if (kbuf->random) {
+		get_random_bytes(&i, sizeof(unsigned short));
+		*temp_start = start + (end - start) / USHRT_MAX * i;
+	}
+}
+#else
+static inline void kexec_random_start(unsigned long start, unsigned long end,
+				      struct kexec_buf *kbuf,
+				      unsigned long *temp_start)
+{}
+#endif
+
 int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
 int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 				   void *buf, unsigned int size,
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3eedb8c226ad..06565d867b69 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -445,6 +445,7 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 
 	temp_end = min(end, kbuf->buf_max);
 	temp_start = temp_end - kbuf->memsz + 1;
+	kexec_random_start(temp_start, temp_end, kbuf, &temp_start);
 
 	do {
 		/* align down start */
@@ -483,6 +484,8 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 
 	temp_start = max(start, kbuf->buf_min);
 
+	kexec_random_start(temp_start, end, kbuf, &temp_start);
+
 	do {
 		temp_start = ALIGN(temp_start, kbuf->buf_align);
 		temp_end = temp_start + kbuf->memsz - 1;
-- 
2.47.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
