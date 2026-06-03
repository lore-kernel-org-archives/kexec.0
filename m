Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2B4CD6E57
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 15:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M0UeBGKKNpBDiXtsHx+XK9ecjuYaKOuvdeJHksP7ylQ=; b=2z2W4BBEd/xTYpwyvjV2/Ee9Jd
	9vcEiU1XwH8V/aeXzy1/t4PqUTPAGzD3B1Dr5xxMPr6rZ2gEPqesdVKH48DExu21s5vENAJ7N9K/0
	idhahzMQb4HytrfM5ku6XOtHD4WPt3r7XRtGwr3FBQ2TtBKp+an6nnN8Fwlyr5/fLldVO/r3iOgrF
	/Huhwa59pvAYX62FpxuSrzFupgVz/WgXGtW/lXksYk5LbhdmV8yVvoRv6rBa05BO6Vk95wJ2t8Lzf
	K/XfheyZc5zR16AQSLzhGmMuvegN9ydW6r3mTc+BVjrgP3Zvb2zMXzHi1S5MzItzbvW52bHkz8OiY
	TpJ4RmKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUnmE-0000000FRvU-3Te3;
	Wed, 03 Jun 2026 15:45:06 +0000
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUnmC-0000000FRuh-2Q2g
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 15:45:05 +0000
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-9159477c893so60199685a.0
        for <kexec@lists.infradead.org>; Wed, 03 Jun 2026 08:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780501503; x=1781106303; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0UeBGKKNpBDiXtsHx+XK9ecjuYaKOuvdeJHksP7ylQ=;
        b=GFZs1fcWEm/GnfPnTvFw2dSKdiWev2vvq88ljX46rVMvkuqZZ6ak747jZMiW0SVcHC
         2qtEOdVJpcr14UUvJd7w+OrY/20TcD6cf1Pc8cPAT4TpHhL5yvzBXNMcU+9jQP/ba8P+
         ciSkUavVojnGWKN11d49dK95KmTsuzYYU6gxyBEjNOCcWRPXb48u0KuxCiD4dYeQ1RxQ
         HlhtTaa4TMGkx9aDvUeQn3FwJWy4BJS0Dt/TzIVpJL06CipCDUg5TeAEYFIr8UqJ4uLq
         OVtzEFnU64/goyZKBofBl7Q/tczgeVdOeFz+fY78e5pqIYUnfm4d3iyIvuuWIIgOC/Rf
         mlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780501503; x=1781106303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M0UeBGKKNpBDiXtsHx+XK9ecjuYaKOuvdeJHksP7ylQ=;
        b=aNHTpuiDFqBxGRP0ij/yapVO5MDXy2/jG6LFGdxxZcMDBf/PKQ8X5nYPdxUxOiMAmi
         OOaS3sqzTEKv0fAP7I0NjvSzD3bmBAm0Bk3rpRWYfc418FVyR83/2I5YnvmNmcY6PmT1
         gTKCmSrlcKgQnETU37SufAu8gmMbxEa/bbkNF4hiO0lQmh4HD+l0LXqfxzbojXApTZk/
         uOer30zWDiKnxQX9P0DaQLXa2rtxeD6sL+cKag76onGWac0+4UmwnaEZgAMMbc0iEWEr
         VIDHFYGNkABxKd6ShnRAq4HHxbeXx+d2olg26kJkV+tSsLN1NS5Fpv4AffSwjX158434
         gHTA==
X-Forwarded-Encrypted: i=1; AFNElJ8bbP4Owbjyy8fGKPyBuC8sXIc5VUZ+RyO/T4+SM40ujHEkkFoI4P6/zWV1kjb/cMmOfYkkxA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyiEmaQTI1Q0N/9YnUhgkMCPsddCMT+lLGcdhVONElV5a8ERp+N
	Gvt3AmAPUfxB0fH1nAs0CXdd9kNUxahrGMLyrk99qzMGC/yPe0khWav9wkFI0UnGcFE=
X-Gm-Gg: Acq92OEZWhcwfGrERqzID9DZbyRs23XUyQ7z/6uO18wYnru6SwkRkO8olIfFvpTRZCQ
	HXg38dXnDt+5Lf7IZdGgrJUFLmDA9Ea3cz2cgrwhemjRzpGFRix8yUg8poQQb64L62A0fzmtKbk
	ZOBvsxOEetGGItpNIUlMMV3KyfCcjImgmB/XjiaDb3N0VJD/HzOnqisd0ofZOOWErSzFcVGkAu3
	rPdIBC9YeV3/fUSKOcTfkfYLRLmAQhEZBHQEApJGLvGtn7mFa58mMDUcJbNjSbLV6i9LZkjpBCx
	oSBpssfU49TBx1Lv2LH6NILYtEPAkSCgWI/Qf/0V5ffjj5iGoOAdjozeg4bboaPdlppgf8YCY8o
	/VsWLtvvObbwZF0L48+tZRwtgHgB/qHuzUG3fey/U5Zm2PKxHlW2WTvq6pXb29tx/mQqOq+XL3j
	CSacnJOcgS8HVVpI/0R109xpENVLe6l6c3bbhW1PeoVb6fYg6du4CKirrlNf83KA==
X-Received: by 2002:a05:620a:1a09:b0:915:4212:c483 with SMTP id af79cd13be357-9158a7dfdb2mr674935885a.45.1780501503068;
        Wed, 03 Jun 2026 08:45:03 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a259428sm273352585a.21.2026.06.03.08.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:45:02 -0700 (PDT)
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
Subject: [PATCH v7 05/13] liveupdate: Extract luo_file_deserialize_one helper
Date: Wed,  3 Jun 2026 15:43:54 +0000
Message-ID: <20260603154402.468928-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603154402.468928-1-pasha.tatashin@soleen.com>
References: <20260603154402.468928-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_084504_755142_0E88545D 
X-CRM114-Status: GOOD (  13.65  )
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


