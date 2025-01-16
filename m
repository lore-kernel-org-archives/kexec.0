Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6C1E77188
	for <kexec@archiver.kernel.org>; Thu, 16 Jan 2025 06:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D2+CoYcPBnmfcrz0SBgbGqcrlBUqnsAYzTPenVz1caU=; b=3S9hlVvwrczsZCEbYqBBd0NLaS
	fXR01iCJq4qdpDU0w7I+LkYsGNuPphTMxEpdJKJdifcK9UObTobrAnfOvOk4fVb3ZDjzKM+vq3Ut2
	s7mYnr3rsMSwzieQR8VvTPVyZOndizUbO39cbC58rAitdi0svpy4Ud+Xp9IIdKVrRxM0+CtrYf4bB
	Tzx8B/fbyVQhrCUjPyzYfCajszkS8owakrrsA8RkgpOghYgTsXs8p8CTZAlws4LA9zOfSRUD40WIX
	4vFfs6TSBE4s6pC6cqBFlkY8ryFZaUFw7qXyu0Gpi8WDpWiphbIhc87+0fjs1xSK50OF83JFOwnsF
	SIJQnNtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYJpu-0000000DzVO-41vo;
	Thu, 16 Jan 2025 06:58:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYJps-0000000DzUg-25qf
	for kexec@lists.infradead.org;
	Thu, 16 Jan 2025 06:58:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737010715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D2+CoYcPBnmfcrz0SBgbGqcrlBUqnsAYzTPenVz1caU=;
	b=GyLhPlvCbL7rAwxQ3X1aS9lLNqUn2DMbZXaGDbqhEQr0dbyHaQkc7XMnxn1nnjhzQl+YOg
	3zDmzVYZHpuhLWNwwToKMrZ8JUJYLwOd5FdVRT46mfFlalDNKnh7eDopDvcabdU0KmcYxS
	uRpwe15gtm0pWZLyVa+3B4tSqxnKt5s=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-Oc943fnEMO2_hLKaDcQKnA-1; Thu, 16 Jan 2025 01:58:34 -0500
X-MC-Unique: Oc943fnEMO2_hLKaDcQKnA-1
X-Mimecast-MFC-AGG-ID: Oc943fnEMO2_hLKaDcQKnA
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2eebfd6d065so2284429a91.3
        for <kexec@lists.infradead.org>; Wed, 15 Jan 2025 22:58:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737010712; x=1737615512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2+CoYcPBnmfcrz0SBgbGqcrlBUqnsAYzTPenVz1caU=;
        b=s1Tuc+pPR5O6AHj5oY9UTGzoFEZSP9x5cq4g6pdSg13GvO1rAEpitf1LnEhAyF6x4R
         aGgMJhCdC8UVcThYulmJaa+zrzmjlWWwLsiVlTmK+GG+JASKUrm1WVIDpWxqizqSQg8b
         SoAlE63f08OuBr7jdbAeXPkweDOk5wXWrNwDWvdm9exWxrQ40D8VIHgvzOM278iUAsy/
         N4X5pkXLkgyX7sBzaiYcmL6U2RzjHJ/J+ygI38M0mfVFegpzlAduoq9MXqD2bpveMNHy
         CU3TR5WWDo1ryp122OPLasAEhwofd+JSu3HWh4B81CnV/to6bC8G+YIvzkPf42NuLACr
         asOw==
X-Gm-Message-State: AOJu0YxgJWJB19WwF5yS2KpTszrMJE8zovSxSDW1FCh6XLawYpdIuOJW
	sP5HF9N8EEGY1r7xg+HT9KkLrxOMfyIlr2OsC7VryVkCX1X24GlyhcRh7jxge5BjYpCiWKDKlQ1
	LwKMYJsQkQ3dFK4pDByV45UC3jysPGaivW/16dfMJtdeRvOxtKHw1CO0ZD/ehGb0SNFAHA5fbYV
	Ue2KbaFm/98XZGfYcJjkvw/M5UWW4HsxWW/JdVUe8=
X-Gm-Gg: ASbGncvRc/P6XuU2oHPS1cXZTJRq90ukAOK6qFg2pOOd0okYpSvj5otWR3CLEmdcOQj
	4lSJp8pOW1oBr3TpueBvelvd/HkwRtU1WUmxANBBJbeJDM4oDorDZd6R3peBNG15vYFNbxYU8oI
	PFUML0i71Ajra8rk8lqPBSiALOpHAhDPRUtqN4ujB5P6jAY0kTlLmskba6sR9MCfW8kYJzgz9Rp
	5tWWhvu8wSBLIJk9c/WnHhGadS5ulM2bvgMiPkxyfVf70Ce
X-Received: by 2002:a17:90b:51c8:b0:2f4:4003:f3d4 with SMTP id 98e67ed59e1d1-2f548f5f883mr45301054a91.30.1737010712422;
        Wed, 15 Jan 2025 22:58:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZwFoiLlhavnDUatbgb2kTU1Y2y/dIgU8v9im+rqhrRya3h6VZuF6F+cRCzUWzSL0lLNhCmw==
X-Received: by 2002:a17:90b:51c8:b0:2f4:4003:f3d4 with SMTP id 98e67ed59e1d1-2f548f5f883mr45301018a91.30.1737010712075;
        Wed, 15 Jan 2025 22:58:32 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c2bae59sm2754048a91.30.2025.01.15.22.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 22:58:31 -0800 (PST)
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
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v7 1/7] kexec_file: allow to place kexec_buf randomly
Date: Thu, 16 Jan 2025 14:58:16 +0800
Message-ID: <20250116065825.1041558-2-coxu@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116065825.1041558-1-coxu@redhat.com>
References: <20250116065825.1041558-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xSdc0WjjZyYihz7skXVtf3RxbfrUVih4Ew2NNGyeFS8_1737010713
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_225836_609843_B179F4FD 
X-CRM114-Status: GOOD (  15.97  )
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

Currently, kexec_buf is placed in order which means for the same
machine, the info in the kexec_buf is always located at the same
position each time the machine is booted. This may cause a risk for
sensitive information like LUKS volume key. Now struct kexec_buf has a
new field random which indicates it's supposed to be placed in a random
position.

Note this feature is enabled only when CONFIG_CRASH_DUMP is enabled. So
it only takes effect for kdump and won't impact kexec reboot.

Suggested-by: Jan Pazdziora <jpazdziora@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/kexec.h | 30 ++++++++++++++++++++++++++++++
 kernel/kexec_file.c   |  3 +++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f0e9f8eda7a3..61269e97502a 100644
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
@@ -182,8 +187,33 @@ struct kexec_buf {
 	unsigned long buf_min;
 	unsigned long buf_max;
 	bool top_down;
+#ifdef CONFIG_CRASH_DUMP
+	bool random;
+#endif
 };
 
+
+#ifdef CONFIG_CRASH_DUMP
+static inline void kexec_random_range_start(unsigned long start,
+					    unsigned long end,
+					    struct kexec_buf *kbuf,
+					    unsigned long *temp_start)
+{
+	unsigned short i;
+
+	if (kbuf->random) {
+		get_random_bytes(&i, sizeof(unsigned short));
+		*temp_start = start + (end - start) / USHRT_MAX * i;
+	}
+}
+#else
+static inline void kexec_random_range_start(unsigned long start,
+					    unsigned long end,
+					    struct kexec_buf *kbuf,
+					    unsigned long *temp_start)
+{}
+#endif
+
 int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
 int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 				   void *buf, unsigned int size,
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3eedb8c226ad..875fe108cc83 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -445,6 +445,7 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 
 	temp_end = min(end, kbuf->buf_max);
 	temp_start = temp_end - kbuf->memsz + 1;
+	kexec_random_range_start(temp_start, temp_end, kbuf, &temp_start);
 
 	do {
 		/* align down start */
@@ -483,6 +484,8 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 
 	temp_start = max(start, kbuf->buf_min);
 
+	kexec_random_range_start(temp_start, end, kbuf, &temp_start);
+
 	do {
 		temp_start = ALIGN(temp_start, kbuf->buf_align);
 		temp_end = temp_start + kbuf->memsz - 1;
-- 
2.47.1


