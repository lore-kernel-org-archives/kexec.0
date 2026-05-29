Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED52ECD6E50
	for <kexec@archiver.kernel.org>; Fri, 29 May 2026 03:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M0UeBGKKNpBDiXtsHx+XK9ecjuYaKOuvdeJHksP7ylQ=; b=eIqLQAyni4a9JxMieE7G1MbVyf
	m4Trn1qzYxVtY6bwsTs4SankZdBXj914pZWtx0AbmDdjxo/I965G6eW2PZe5Xvj3bqBSuT3Wa0Ml0
	3WjMd0kWaHQ13/aaXoVw5eFJ6p0nQ7Fv1ziVSeJilnNJ7O4xwF6vm89TWMx/G5QRNbIi9bEskWnLZ
	e/UN9nK+BdetcYj+S/YLo+HS+IfDIEPhbLxleVSiGXv7WxHsZzJNL8fT3fU5hn7gPmZQkuVnW4UOF
	h9s8UhDllthJiZCjyl2/JunoTCvcMflXyUOIttTmpEeZZ7dQpoQcVtQRP77LGAGX3ax15uowg9qx8
	ltic1KSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSnmi-00000006gVA-2wNj;
	Fri, 29 May 2026 03:21:20 +0000
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSnmb-00000006gQM-1Of2
	for kexec@lists.infradead.org;
	Fri, 29 May 2026 03:21:14 +0000
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-5171a8d3a1aso16955201cf.0
        for <kexec@lists.infradead.org>; Thu, 28 May 2026 20:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780024872; x=1780629672; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0UeBGKKNpBDiXtsHx+XK9ecjuYaKOuvdeJHksP7ylQ=;
        b=aizTfbXLI+LctZtOBvA7cv4tqOMZ6FXd+RuCNiJ20APbXyVkAIaU/y8PJQVjpdsrfQ
         xQqWaNOxZFF1S0xy/p/dC29l8jZG0H1qwYzIPlEr+JBgN9ID/aFSNYysne8xlZe1CXLP
         4n4MZPYp3xR3YDbBCYmLn2U5L+8ZcerPZ+FJc3zCyWusycxavu3VgDIX0rYrn7BJ3Hjb
         25Tw4X1wrGenIm/ZA26PkV8IRPoivSzEdIGmUd3mOkScOMsLHDiAoZ/mlRDH8uckT4Ch
         GtTJQY0MNw1Za1MlLAFEQWSzVPoemkjqygYdT+zEab2ium7wFB6cJRPt/3FAyTj+PmX3
         XFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780024872; x=1780629672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M0UeBGKKNpBDiXtsHx+XK9ecjuYaKOuvdeJHksP7ylQ=;
        b=cLkSazq05KOPKOM2l5PQRVX+nH9ke7AdTDNrLQloMiGPG1waLEFL7D434noupjnpDS
         gI9cfM21/FFkBAYvTGlGPdAvGHVeUfmlAh9VSzovN/zTiBnkxYwyaPSFdyicuP2Efly5
         pjo7J0u6XhUGDQSALBQM1T7L1t7/auHoKBq1qz+jnynsWD9da0R+QrKla4jdRvijLZSI
         xBNBQbQ1DvMktnavsEYphf3BHWnT++inGy+Vm55a8OyicWQkbkEn7tKwkIkYpWmLXePk
         D/0IzC9Jouy83JtteDC+eEWD1YFgKJDgDXCPN2wkm0eTa2IHAnr970zFnVcvDJ5x+Iuh
         eCVA==
X-Forwarded-Encrypted: i=1; AFNElJ+DpM2fjApEQ1kF0UjH/6vzo290UfGEQlTRFT0LNYPec12pq5A4mO8Y9ssnO+2o0tL88Rz02A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz94TRj4voCoJjh1H4inmg2LRQOwL+O8UltQ5jVf5cEhUcCkIlr
	muxuwjS6fhqOvklP/wp1SOcDh14I9G7QdJDXB9zgNYmGiws76Z3YaaOPL47zxgunaEo=
X-Gm-Gg: Acq92OHEUKS8lxq/ox1JFLaAhBg6QSxaBdaFvZ4Evlu8s7VBOLf3oa4Prn3DItYkzFH
	DL/neMOQyEngmiu32nUJbxnBzFCR8PRCCBbRLPrI5HOW8Mc8oE2QfKN5CNtugAwxXycQP7kSvTh
	/wVTrKkm0BY9JaxtBvHVzLD2MV+r6esWmSOFhpTGXTjdsAub9YABDiZK9r5iY4EbQkkmxpxLwTX
	ldT7bMH8wXxhKki0jf/xMcrSRpHBK0zKO2Grs4y0XlVoabGCDiXhS8aKZsyBRK4gN5LB1izfSum
	kwZlSUEuyOIoZASCJHbgpqXTh7w5VhWaJiaBJGTW0cyzCD9pfsWiGTilxCxDwZi9Cg/accCZ7Wq
	Aql8owqGRAgred3qFO4ULyg1sXJuJe7ZCldqzahzGokSigW8w/7gXrRVIrGo0pSmluNJYuAPD0A
	3gIQi7q4diIMZcRwIan6C9Gxg1OpE2/reUEygMsrhZQe6Fp+uj35spRFBObNk+WEtcvPPJLY9m
X-Received: by 2002:a05:622a:1b9f:b0:516:9b30:f025 with SMTP id d75a77b69052e-5172dbbc5e5mr13902181cf.15.1780024871947;
        Thu, 28 May 2026 20:21:11 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea26d286sm1179476d6.48.2026.05.28.20.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 20:21:11 -0700 (PDT)
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
Subject: [PATCH v3 03/11] liveupdate: Extract luo_file_deserialize_one helper
Date: Fri, 29 May 2026 03:20:58 +0000
Message-ID: <20260529032106.1505796-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529032106.1505796-1-pasha.tatashin@soleen.com>
References: <20260529032106.1505796-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_202113_401657_D05BFE9B 
X-CRM114-Status: GOOD (  13.80  )
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

This is a pure code movement, no other changes intended.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_file.c | 77 ++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 33 deletions(-)

diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index 208987502f73..9eec07a9e9fc 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -753,6 +753,46 @@ int luo_file_finish(struct luo_file_set *file_set)
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
@@ -782,6 +822,7 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 			 struct luo_file_set_ser *file_set_ser)
 {
 	struct luo_file_ser *file_ser;
+	int err;
 	u64 i;
 
 	if (!file_set_ser->files) {
@@ -809,39 +850,9 @@ int luo_file_deserialize(struct luo_file_set *file_set,
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


