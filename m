Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD28CD4F46
	for <kexec@archiver.kernel.org>; Thu, 14 May 2026 22:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lNYZS3s0Ezy+RQHVqVYSzxTe1QiuBpPaay8EBa5d/Xw=; b=WU2QRhw/Rv7cxWhVYNJLRQfDT0
	5pn+dc3YM42+U6mDFqpBKm7hRX0U/ztWH9eys95IcvivY9Rfi3j6jl+Ooadgc9Wh9rar1hN3+shjS
	zq4nyTA6U92PN0mt5wEHoJglgzlxgf6/3k/KTk5nD8S9/zINcepF4pChBZpAvaL+LUYVhm8SIG95k
	FkELYVjkYCLVB1t+c2dpg5VlIN+uEmweUqJtMCdGzK6WpMbjIoTOFJZhJoEsVwQuMyCoXYRBVH9JR
	2bYA2bZs18a8zQXm6PdnpAAcSKsI5OueTQ8fD4NX+kD+vFfNCWvoxHmVR3jeUiMjTQPYDwg0RBtZu
	dBq5023A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNeVt-00000006iHh-1b21;
	Thu, 14 May 2026 22:26:41 +0000
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNeVo-00000006iFf-0yGe
	for kexec@lists.infradead.org;
	Thu, 14 May 2026 22:26:38 +0000
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-514ae601e01so55079301cf.1
        for <kexec@lists.infradead.org>; Thu, 14 May 2026 15:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778797595; x=1779402395; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNYZS3s0Ezy+RQHVqVYSzxTe1QiuBpPaay8EBa5d/Xw=;
        b=kWxop6A2NiJm9egv0wpgpDMxHbQI1YsMmTAqBAKH9w2JHvO1LRCTqr1ZMvPPt6p3Cx
         bRwohdnkeuLv3d1Olza+vaRUsDfkaCW75QsQ2f19Frf3hg+NbnEH+yK6qbdRsTBkdF0b
         PPJY2hc34S9QBN95teNin6+tm044jEvBEhsjZe800S+qfi2yi/OtzAMFxXoo07zhqt5i
         18dqIzQXN6Lrf8ypkXVDNT7erVgTifXVko+3R7xLpI5uLTb7ku2qvhhbYwawQFfBhcow
         kaxRrlJavBoxb/D5wy58k47sserpo6ChaCU0haPZwwc5uztPJjZWz8h84JXbn4xcDBQV
         j1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778797595; x=1779402395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lNYZS3s0Ezy+RQHVqVYSzxTe1QiuBpPaay8EBa5d/Xw=;
        b=G947aoTtw449gZl7rIng89ntp2Mv3up5gimpAhvfOqXFyInVTDm12NU7lIsTmN08rh
         pg++hGCGYbKjlChxDVJDw7UQXSn1Dl7GCPx+tS1L2HSQR56czZ42VNp5KVkvH4jo4FAC
         H6UD/GdoHavX1sgN7uRvmebEtu04qkfIFflUoBvIfKUHOe/DhjYDY169idFwPYPo2H4L
         05WD+/hl0PUjOg2Pg0BvYbtbD9bNNYawIOodHEvpjdNVL6Q3YqerWZ0kD70JCxqwqFWT
         sV7CDNW64zGhTSebdkZKlVnNZKBkjzSPV/wkB1miKWUbAyQoSYKZIJRtsifAy1UGfOdm
         z3BQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1wa4UnVG68/qQs47ZEGPDWr6IL8cVVm6jPSrJZkK4XcA3sbO0AQKmxLLFJH6v78XKg+FNig==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw6OVf6ULZjc3QyBmFFnLP6K6kPozbAdFbp9H4EtUg5I6PrCV8N
	mCmFegIpQ1Xyf40uOJvfpsWP7WnuPlg1lVBfPbxXCBs32RSwh2YU52yao8xzetSL4lc=
X-Gm-Gg: Acq92OH6W2KjXEHYbpe8AuleQJCfzpampydkUoF9Qr6zmN2Vrt3OU+vlB8nNnrFYs9O
	aAVlIenUNbCNzT6K8B3w14Dg3x7XDKBGeUUflujJmmS9xmMYl6VUkCMBWCiB/Buml8HXCWqsx6m
	z35SnAZWsqe9H+j0eW8Ir+ZiW7LVkSQLeVNSZmbchY29EoMhj6j7999kz7FlM9wITw04rSi4H6O
	DZ0lozT8Tq4IZi5cu67f2mTA4qS0INoxPi4kZBflF3GSW3P+2+j3vzHSsTCBFnjkkPk3T725Ma9
	yh7guExD1XLRcAJo0TiyfBuExo9Ywn+OuIrZmZZirAdWUSbNsJeWwGQZ48bT/ZlfKlpkEJDAAU3
	s7bR3G+FOnVcsqllMr8vJ2I1Ns4H04tfzcr0vkqIgl0P7jtEQJ//xlfWxLnAhn9y9UWzIoQT+F3
	bksStKG4L3npUT7l3gCTm0fMse7SpMn3/LXI9mApMPHwGM4R9rsOM=
X-Received: by 2002:ac8:7dcd:0:b0:50e:6055:274e with SMTP id d75a77b69052e-5165a025376mr20219891cf.17.1778797595002;
        Thu, 14 May 2026 15:26:35 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456ba92fsm28671901cf.9.2026.05.14.15.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 15:26:34 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com
Subject: [PATCH v2 02/10] liveupdate: Extract luo_file_deserialize_one helper
Date: Thu, 14 May 2026 22:26:20 +0000
Message-ID: <20260514222628.931312-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514222628.931312-1-pasha.tatashin@soleen.com>
References: <20260514222628.931312-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_152636_275357_0E147A10 
X-CRM114-Status: GOOD (  13.72  )
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

Extract the logic for deserializing single entries for files into
separate helper functions. In preparation to a linked-block
serialization for files.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_file.c | 77 ++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 33 deletions(-)

diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index a0a419085e28..a2510563469a 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -752,6 +752,46 @@ int luo_file_finish(struct luo_file_set *file_set)
 	return 0;
 }
 
+static int luo_file_deserialize_one(struct luo_file_set *file_set,
+				    struct luo_file_ser *ser)
+{
+	struct liveupdate_file_handler *fh;
+	bool handler_found = false;
+	struct luo_file *luo_file;
+
+	down_read(&luo_register_rwlock);
+	list_private_for_each_entry(fh, &luo_file_handler_list, list) {
+		if (!strcmp(fh->compatible, ser->compatible)) {
+			if (try_module_get(fh->ops->owner))
+				handler_found = true;
+			break;
+		}
+	}
+	up_read(&luo_register_rwlock);
+
+	if (!handler_found) {
+		pr_warn("No registered handler for compatible '%.*s'\n",
+			(int)sizeof(ser->compatible),
+			ser->compatible);
+		return -ENOENT;
+	}
+
+	luo_file = kzalloc_obj(*luo_file);
+	if (!luo_file) {
+		module_put(fh->ops->owner);
+		return -ENOMEM;
+	}
+
+	luo_file->fh = fh;
+	luo_file->file = NULL;
+	luo_file->serialized_data = ser->data;
+	luo_file->token = ser->token;
+	mutex_init(&luo_file->mutex);
+	list_add_tail(&luo_file->list, &file_set->files_list);
+
+	return 0;
+}
+
 /**
  * luo_file_deserialize - Reconstructs the list of preserved files in the new kernel.
  * @file_set:     The incoming file_set to fill with deserialized data.
@@ -781,6 +821,7 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 			 struct luo_file_set_ser *file_set_ser)
 {
 	struct luo_file_ser *file_ser;
+	int err;
 	u64 i;
 
 	if (!file_set_ser->files) {
@@ -808,39 +849,9 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 	 */
 	file_ser = file_set->files;
 	for (i = 0; i < file_set->count; i++) {
-		struct liveupdate_file_handler *fh;
-		bool handler_found = false;
-		struct luo_file *luo_file;
-
-		down_read(&luo_register_rwlock);
-		list_private_for_each_entry(fh, &luo_file_handler_list, list) {
-			if (!strcmp(fh->compatible, file_ser[i].compatible)) {
-				if (try_module_get(fh->ops->owner))
-					handler_found = true;
-				break;
-			}
-		}
-		up_read(&luo_register_rwlock);
-
-		if (!handler_found) {
-			pr_warn("No registered handler for compatible '%.*s'\n",
-				(int)sizeof(file_ser[i].compatible),
-				file_ser[i].compatible);
-			return -ENOENT;
-		}
-
-		luo_file = kzalloc_obj(*luo_file);
-		if (!luo_file) {
-			module_put(fh->ops->owner);
-			return -ENOMEM;
-		}
-
-		luo_file->fh = fh;
-		luo_file->file = NULL;
-		luo_file->serialized_data = file_ser[i].data;
-		luo_file->token = file_ser[i].token;
-		mutex_init(&luo_file->mutex);
-		list_add_tail(&luo_file->list, &file_set->files_list);
+		err = luo_file_deserialize_one(file_set, &file_ser[i]);
+		if (err)
+			return err;
 	}
 
 	return 0;
-- 
2.53.0


