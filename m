Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0EECD6E55
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 03:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M0UeBGKKNpBDiXtsHx+XK9ecjuYaKOuvdeJHksP7ylQ=; b=dkMaiHnU58BC3nkZBmuEZkPGbq
	Bb8gwsx/wihaC/kHKHy9KQA2beBSAz38i8fhtZexds/f6l9K1H8opMKGmtaaH/HprH50BC0dU16YD
	kfWa8agFR4rJITJnW/LKu9cRH7lSToXcr2UCiPYBfMbWJipvyiShtdGwC4x9i7wgFQfmsuZpNzvx3
	k0tx+51fIq+b4HXt3xZ3RhQ44P2b2Lod0a+zs4E2yabIh4RqWf5b3nHmuz6eUXOyFRaSRnLrjO3HI
	IoMDVNonxq/UEky58GH8YTpCfZkFYDviFy8A14ehNX/BEySuRgV/OCZWcGaGMOl03qZbyyh1nazD2
	IZAp+FDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcIB-0000000EAyr-1NtI;
	Wed, 03 Jun 2026 03:29:19 +0000
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcI7-0000000EAux-21Rr
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 03:29:16 +0000
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-8ccd1f57b32so75280076d6.2
        for <kexec@lists.infradead.org>; Tue, 02 Jun 2026 20:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780457354; x=1781062154; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0UeBGKKNpBDiXtsHx+XK9ecjuYaKOuvdeJHksP7ylQ=;
        b=RSNKVwp61wABFgKWRQO7UebL8PFB/f8A3SAaKRFJdpl3ZDrA9WxtJ0gF+/Nj+hADvz
         XdxkNWKIp/Np/5cCHIns3ocef7vobvlM/l3ejZTuBb+2BHDbbIJWcUt0yz4N9MVFGG02
         aAHABehVs6Thwv3KKjCJa8682mKeN4WDYv5uTRTjx2UEGM/pJWQxY12Hh2npETupzxi9
         x80wjkCgkj87FCz/jTxQgMvcNkQvZyoLvzLFqkLE3QvV/i9kCEwyDLrsCqn1PxJaMxiA
         HdYs9ZNFcYKjST91WsVj9wzfhTLF4AvXkaTrYqTKrXEAu58tSlVod4J9/5+p6n0rUsYy
         CV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780457354; x=1781062154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M0UeBGKKNpBDiXtsHx+XK9ecjuYaKOuvdeJHksP7ylQ=;
        b=ZOd2Mbm6K6hNiE+nXjRFD/S8wBDlCXmCeBmIr4aP/crNxtcaTd2zfm3lqVIrFClLFa
         ERs1cAHdo6FZhYP2GTfUCONmE5YZdhHwVeTvJY8sCDkTeY5UuosCxDUDttcCBsSI6CiV
         o4mn2vs6j+KIMayyxP4txIqtZ/RdX40XdKwal2NojpG0LP1fBu59QFIRjj8DiAZYughm
         hOW/P/9rzPrBCXpV+2+iuoojVjQio+J4ky4lpHbc2bUaTSB1+K+QSDWFTDEhRXmsW8ZU
         LUWN4URwzL0/hoQbsjwhh48GD6TtRO4cWCBct4ig+HvLDb2bK2O4ukvlGqXK/O6oIi+l
         fbhg==
X-Forwarded-Encrypted: i=1; AFNElJ/1HC8p3LsBufdQjcM51LvfhpJnJcnDutNA/J6bL37WHOkuxTlilH5Sgru2xAJqdbjRVdYMtA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyDedQWKP4caB58ViNKCRM70vgSr1fNVp4FEbmiY2r2LGmxhvp9
	3OObXyLbn9MJakoq3kFLz9LVyBWDI0xiOC2SZQpHhnNB2UBpJoQFahxP015YDpcL5Gw=
X-Gm-Gg: Acq92OFH26Wt3/ZnfHdZrmCgUMMPSKI/9HqdUes2CqZa067SqunOZomnzgROGO3zSn/
	VN1Okt8lCBKzrvcJHLmCKEwVlsx041wsBK0/B/8wR1YG6i+H59jTy76PqEv4xNvLfOd1jomcm4Q
	W4ek+jgz3JYHqf+KYlOhInL22P99E8ZATmU1eJWx49Me1zQwJMbZpY0Y7GHbEpZZSa7vtqqgCEV
	6lCpws4OPneFAudb64wzroL2vWHkgqHoLxPQARW0GqXyyscPBB5FId8LeCdU3Lo+ONd97Zd49xa
	Gf7tqT6bkdYW4JSefA2V7HsMY/sN2iSyX86UrRu17OM2NgOgrQ9kbmjtcg24ICf56V4LBvEaZqK
	9yc/1Uc6K4a/yGrOC9P3QOSc0Kay9qxhtXSnKUSEe5BlsLM6o97l6LjjHc75P7kY/87MbPLhv9a
	pth9n77PGae0BQ45J+uI5cfNGueonRVH8nUar/a9dNF4gSme4RfeOh2Xv2HzXjbQ==
X-Received: by 2002:ad4:5be8:0:b0:8ac:b4d5:50ec with SMTP id 6a1803df08f44-8cecdcc5dd2mr23007136d6.38.1780457354509;
        Tue, 02 Jun 2026 20:29:14 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd26b3b9sm9244566d6.45.2026.06.02.20.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:29:14 -0700 (PDT)
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
Subject: [PATCH v6 05/13] liveupdate: Extract luo_file_deserialize_one helper
Date: Wed,  3 Jun 2026 03:28:56 +0000
Message-ID: <20260603032905.344462-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603032905.344462-1-pasha.tatashin@soleen.com>
References: <20260603032905.344462-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_202915_523468_A72A7071 
X-CRM114-Status: GOOD (  13.95  )
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


