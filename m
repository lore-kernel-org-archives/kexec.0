Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2363BCD6E61
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 03:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M0UeBGKKNpBDiXtsHx+XK9ecjuYaKOuvdeJHksP7ylQ=; b=E38z7JZsdRnArmiNtOVjTb4V2k
	JbGIDVCk/xVSWP60y2t+TyXFowAiLfP2zgz290c3GMPdr8qRD+tzhR1n4t9OGOKsQ6z7XjBo83aeq
	jeKOzOloDp6zohdr3Xo0CLkHJqy+/zbnR50UtPUhogKdEDEKmrfTP8V2BVMgyKJtPvoIABXTJa3Dc
	wh7uxW8za6g8Sk9holiaepTVIuIvoJVHLYvL8sWs/6UHm/4rwiETIs9jqi0NDAB73hKucYIXWGkN7
	3JCrQ+WzR7BE1rqc7EFvrLZGvRPdr2h/GHfNIBejtu5xkSu6aAhHasM4jlPFw6zI4TMBRD9cIaSnz
	nCK5CEKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFdG-0000000CDHn-1CGw;
	Tue, 02 Jun 2026 03:17:34 +0000
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFd8-0000000CDBm-2VmT
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 03:17:27 +0000
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-516d634956fso125694981cf.2
        for <kexec@lists.infradead.org>; Mon, 01 Jun 2026 20:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780370245; x=1780975045; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0UeBGKKNpBDiXtsHx+XK9ecjuYaKOuvdeJHksP7ylQ=;
        b=lOljHSQg60o5NVp8IdvEBwAgge+KBuIbeBW/CV/WjUdeHuG7EQB5p+tYzIq0YtJKx2
         2UUyb5vpixvmXB+E6Ikwg7JZBqmbXwNhQbPXn6tjCCqS/vXOZbLjBGrqNLiLBfjHSZPC
         swD7CiY1Mkmh2FMF5Ns6Pp+150lE2vdV/wfnzDZ3e/SkP3QMIQVjXT/b6yvrOHGsQAk0
         4rxT992ew7WhXiI5ftu4mzfSCNI/XKh3F69w9j6b2BVpvFDGwD6MQ7ropFO6iovi1PN9
         DvqQjPYmkejwCu0OWN71U1xFTVm8+2slAZif1lWnIfPRRxJQfJnj3oOWv1dYVj1jvFJg
         iKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780370245; x=1780975045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M0UeBGKKNpBDiXtsHx+XK9ecjuYaKOuvdeJHksP7ylQ=;
        b=qpfo8/uwVo8DqpCmIO2Qn83eZDVo4wgkS76FBb/uTfswdFIJvxo5OcuJuQDKtWYwEn
         5UAsxqc7Z9Q/DlYrQR6nn9zra9LinHGbkiYJTJ1RUPDP7iVUwFWidfYBMkqlRG5Ipgy0
         /Q7Vc17flIRzn4o5Roag+wthaOkClc2F1BPV89L2kzWHyCTnloTKDQkvpVPqvps3zOD1
         QbrFPlruyftDKubJGG3k+d9Ie+eQyjiFb8277J0cMRQzsZPCubjyPufDML4wNOtpVtxL
         Aq9GxzQ4sh6rZSYAd4tAVSN8fGAjQGYiCM/oWyaoR8KwrmpucoKWL8CxySTWil0jNMK4
         PCHw==
X-Forwarded-Encrypted: i=1; AFNElJ/IA+p+nnSD/Tba82PQ5j4gZO9iibLe8ghad2RB4AE1i29sd6/Y7b3fIZuQzaL8Wh40JW1+hQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyYGkm8VCGiGi/EHB4E73FAkzW1fVRGZ7tktGhksX/B04GXXAd+
	Zss87v0i0Eytd+7SMcqa9o6N0Lf8HsOGKLTGFZMtmIEK53s8/Ccrwk2Ag0IuhL8WdVk=
X-Gm-Gg: Acq92OFhrZ+sFL+Ofa0mUfQfoJg1cuddf2Je3puUPq8A8DdF+NrN/0jsnibPC4Md+xH
	QIkQpocc8wtItQuvblCk5ScrCoh73QTJC7ajHPcmKS0DM7mTq0BnB87EBfZ79+zkvoKs5qO0nix
	iIgdF24hNOs0UV6Ezb8se4+YL9YfdeJo6+lQzwc3br7sJ+60SlrcmdG6eNJqvDL40/R3FKVUyuM
	U4EfSkqHq93ClgpPhfmY1YyNUZG1bshTim2eMWqyUZplm7e0p/hziXiT7l4d4SZ/fhLyWca1v8g
	bolWS2fD6Eo1sVBrAG5VMqEqxRvZceO8bvcD22VnYJbTlLoC3xdUGMzOVPpXJRtpZrm5pHrWb7u
	evztejrYnRJoPyDltWEZhuzQ4xjkU7a1WVaIDOPvUd0HJn0icQ7YiHhrMwrTJc+Nv44167DfYDD
	JyXobO11rFi2+5UQl7Jtu/46KW+/4gcwHC8UTPBBN87iEd3OPKAUxkrteUNp7/VQ==
X-Received: by 2002:a05:622a:5986:b0:50f:c117:1c52 with SMTP id d75a77b69052e-5173a5e7f0emr188951681cf.4.1780370245318;
        Mon, 01 Jun 2026 20:17:25 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51741b29745sm71219081cf.8.2026.06.01.20.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 20:17:24 -0700 (PDT)
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
Subject: [PATCH v5 05/13] liveupdate: Extract luo_file_deserialize_one helper
Date: Tue,  2 Jun 2026 03:17:09 +0000
Message-ID: <20260602031717.197696-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602031717.197696-1-pasha.tatashin@soleen.com>
References: <20260602031717.197696-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_201726_654938_738EF430 
X-CRM114-Status: GOOD (  13.61  )
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


