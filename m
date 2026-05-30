Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD16FCD6E55
	for <kexec@archiver.kernel.org>; Sat, 30 May 2026 22:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M0UeBGKKNpBDiXtsHx+XK9ecjuYaKOuvdeJHksP7ylQ=; b=gyk3QibiSmDVpZsOw+K4d+Bla7
	HbbgL9XWbZvdQ5vcKbR3DmMSboqARMA1hLn8pcoppbFrs3WKF/2hKZ5vAIhkWN5ybexnAzRrLXh5h
	KS6fUWaW2nS+h3Vakuujg3+PkwupGEw+Unea98jNF0/h7WQ6bFveOcQgYX1+5ImrqmfvmCt9ds4Ip
	ZQH+Gx4SGhFEeChNKrfXHMcuPYiuSHHQ2TnvpjDJbhOcDmZgk3Plr8e85COVbmUiw3y/Ucg29uOAo
	uC2U+AacU6w9wyCaOTvORz69DZ/nP3OzUF0uq5Ix1sB+0zLREy0Xa7uiBcRnli4GtzT88RYmlJ9rN
	cBTjUE0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTS28-000000095oT-26Ea;
	Sat, 30 May 2026 22:19:56 +0000
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTS26-000000095mI-0bXM
	for kexec@lists.infradead.org;
	Sat, 30 May 2026 22:19:55 +0000
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-914db83362aso716862385a.1
        for <kexec@lists.infradead.org>; Sat, 30 May 2026 15:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780179593; x=1780784393; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0UeBGKKNpBDiXtsHx+XK9ecjuYaKOuvdeJHksP7ylQ=;
        b=MxPETWq2qL+UnJPjphBHnEeFBOyZjjo65ItYpACXr9uXmkWHXXulHbOP0yZmsUPvOh
         qkdLycyhEw6b7Rk6JJKSvlU3DQGnA176tFDrT9+Wsn11ymbSKgizfJ/Dw8w4nD3gvCxg
         cb+jIHoLeqL2lUlDcx+n0UL47xZsMMx+EApJKV+Dw8jWFYpScbPkbUClXQtFCSzf9vc4
         GZI93LqSZUW7mfZUkvd4nddzVurYfw+/poj7jc70Ut6+uZqvtrvhMPjtmRewPc3TtEZo
         yK1gH18cAE4/OabjBW/+wrTEIr/Ni4isQJpxV/VRk9YG1nwDUdhWZvAHhz8V1DMa1T38
         BOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780179593; x=1780784393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M0UeBGKKNpBDiXtsHx+XK9ecjuYaKOuvdeJHksP7ylQ=;
        b=hjEQy+zOVNZ2mUSqbJV5ndaGmyOgDpRYfsnbY0i8nmeRKdWf18U25lsnvBA+u//7q3
         DmWro625xfAvAclu1pIsACi3OYLVSEDXMlAej9t3gQ+OX4Z8/xd5dO3s0sVk9Jf3yMTR
         h/MlcfirzVxrgqZgyyPtSMk44DyLA4pz/RFE6wkwdwwnNF85WkNcBcvOH/yCZzEqAp0A
         RNYydKMqJmlMtG/5iZEVfGAH+Vog6JpruAxZss+tWZtsxs5tfMFNWvpO+4VVs0AbGhmv
         aXlmyRAY0WSgj/tlZNNQmrdiW8XTq1511QSfOETqgVlU+Mi3GJzhoJOUMMHaveUXz2uB
         7qXA==
X-Forwarded-Encrypted: i=1; AFNElJ89wS+I9T4f0Q9T3/qNurayXzVr+HlDwbniKl2W2pMsRTCGqVfExv330boghCKgN3SpHN3gwg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwfjNJxkzcSgolvJBO986r6nNT6lgbjW0qj3lBGz+p+RTT5lA6S
	buxUDH+gfyuNrs75o+TnVVl+NZtU66mxXFNcWeu0onshDAcF057gQ7GkmPGthP5S8m0=
X-Gm-Gg: Acq92OEWVs+x4lHxUCYaCbVH0W8YuH17JjX9PTfLTJt5pF5p6W1D7wh4azvnBJYHX8X
	klJcUFPFp2Fmfq3ZkfGmedHWojl8blfeA9bG+T101ApRITUSkhEK4fSvKpeVs++os66oYxsbzAl
	73vs9ky1iIgW9UX37WU8d7XNi+kXHFAE9iDyClzXZgML7PAogX08U1uhd8N7PHcN7o2HVjCCFfv
	w/x93r6iPgwgfB57zYkh9cr3se1ttq9EV7uFafZdPmV9KwdXLh/DAEX1WtuPrJpw9x5c+cJNWao
	lvKNt5S1sKXUIXieG9Lf5HqyIV9P58RpycePKydFldUkqeokj3wujtinnL8ol+CQsRjoOUzpnwl
	FVD8MuZGRVGvw4QHCl1K4O04BAIcD1czqSRCb58pbW9x4YCdp/1Yp5ACBllus84ut1+mYUN2pq5
	3rb6Ul867Zrwh6XwLajcWO22dE7uNGZUsVvbwLs+X743s9gtCqm1852GxMe9vjC4SFo6RqLzks
X-Received: by 2002:a05:620a:2697:b0:914:b4c3:997b with SMTP id af79cd13be357-9153decd84bmr587250885a.1.1780179593182;
        Sat, 30 May 2026 15:19:53 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915324868a0sm651790085a.18.2026.05.30.15.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 15:19:52 -0700 (PDT)
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
Subject: [PATCH v4 05/13] liveupdate: Extract luo_file_deserialize_one helper
Date: Sat, 30 May 2026 22:19:30 +0000
Message-ID: <20260530221938.115978-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530221938.115978-1-pasha.tatashin@soleen.com>
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260530_151954_181936_8412AED6 
X-CRM114-Status: GOOD (  13.87  )
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


