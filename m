Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FEFCD98CF
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 13:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8KgmRpZ89lCyw7TnUs9IavIMjs9smvt+SzytEeojGlY=; b=CQwYvjtMRUqqLnUOAf1FSc3htl
	ctR444/r/bTPQfwSKBDwFQYeomQDkA5yiYKGooGRQYWiH8srI7i5fc5xMqQSbP04Shv7yecDmEVte
	BD9jFYKEDi36fMolpMvpWJRTrHofA7p9H1b969W1X9AhgAcPeNflY7YHpGM0et+LKlHo+rcynMAa2
	Jp29a01m1OETAxsjXxKU+BCo9zfiD0Wu241nWvCK9svkO4JNWl3fiQwYho5aeAQVF2whVoqHtLu+s
	XqbcAs4B7JLuAtvwA4h/qFQ+TQ+KDxi8L8q+RZNHMiAEtz5ZFsmjpLXUmh30fl79flo5fv0MNkxJP
	RKSYiXVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ705-0000000EG33-1UmQ;
	Mon, 15 Jun 2026 13:05:13 +0000
Received: from mail-ed1-x54a.google.com ([2a00:1450:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ702-0000000EG24-46qt
	for kexec@lists.infradead.org;
	Mon, 15 Jun 2026 13:05:12 +0000
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-68d2340cb67so3761301a12.2
        for <kexec@lists.infradead.org>; Mon, 15 Jun 2026 06:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781528709; x=1782133509; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8KgmRpZ89lCyw7TnUs9IavIMjs9smvt+SzytEeojGlY=;
        b=ZQfd+unYN8Awc7xKKwbhtSHdw8Mr+GTbEOm199NF8idVJTewccD1SNe/ujkMwAgI43
         tNwHA8A2wiD8Wdgs1BTtc5I0jHS1fW/6/DEkW/o8Z3qlleTvKthX5oENnckYfYJP9RSV
         Ac7t5ACNSSXpRfK6C2Xq4lNQx4zUp5iE8mSNR0qBz79uwT/IRbX/S433Us8wIT5CI8BQ
         ANnj3636BOlCoNiw5aTF6EnMX6fVWeCbykzeXJBRz/LPWxo1N9ZkbUxuZfK3MMVRpO0E
         shDebQ0VrKRyb3b+alSoKcpZbpBEBlZ2eqgboCq+R95VN59xCVY0HZNVXFnoIr0ECffX
         RvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781528709; x=1782133509;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8KgmRpZ89lCyw7TnUs9IavIMjs9smvt+SzytEeojGlY=;
        b=B46N9K3btwBI7K1d9z5lHN7BBeaOIojewy83CqhLN0kmdiB2Cf7cJF40gKNg3SMItx
         OuRHwFdt/UM2Y/L/9itNahoJko0t1112/HtNBvDcMtS0cMDNmhrf65iOslyiRayQqmTv
         caTVqhJGu6exGsnlvncoezovFi6KdigooGBzLeoylucLD5YaCb5JwW4hQCecgJsDMcho
         jGewHUw7+QLNMuZ3dSRHyWgYIa+2czhLbgrzw1Te9i83esHVLLCBGDyT0Vd3Ik2OOpNT
         VQvwRZP7JLybUlE4LFOJlfOAYhRyOLlIAA+Q951QWQuG2nCknSGYpAauHGwGFe6VIENh
         6R4A==
X-Forwarded-Encrypted: i=1; AFNElJ90YuCtGEyhd6NKnC+PimuqfEGxTeoTCWuBidU3x3G6uyGHnF1D89yCApiONeJZnTmwTqrNYw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw8gDVOj3WzkBAGJ6w3yITJS2F9fOtchFB689FaUQDH0i1TOSCJ
	+0E0tyswMlWSskXSWivZA8C2Yc1K9kXFFArTWBYcPRv0EuJa5NJVoAfc7tXzn4KpJtd/et4VkWV
	Z+xp86gt1Cp4MlDIdBA==
X-Received: from edi25.prod.google.com ([2002:a05:6402:3059:b0:676:2118:1564])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:40d5:b0:66e:56a2:b67b with SMTP id 4fb4d7f45d1cf-69378a457f8mr6300301a12.20.1781528708577;
 Mon, 15 Jun 2026 06:05:08 -0700 (PDT)
Date: Mon, 15 Jun 2026 13:05:05 +0000
In-Reply-To: <cover.1781528022.git.tarunsahu@google.com>
Mime-Version: 1.0
References: <cover.1781528022.git.tarunsahu@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <9fe93604bac096dd3edfa48a0d2e2ce6e2683f56.1781528022.git.tarunsahu@google.com>
Subject: [PATCH 1/1] mm/memfd_luo: use KHOSER_PTR for serialized_data checks
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260615_060511_078212_71273A3B 
X-CRM114-Status: GOOD (  13.43  )
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

In all callbacks (freeze, unpreserve, finish, retrieve), use the
standard KHOSER_LOAD_PTR() and KHOSER_STORE_PTR() macros to safely load
and store the serialized structure pointer.

This resolves the issue where phys_to_virt() was previously called
before checking if the physical address is valid, since KHOSER_LOAD_PTR()
automatically handles translation and returns NULL if the physical
address is 0.

Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 mm/memfd_luo.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 59de210bee5f..ec37693841a6 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -257,6 +257,7 @@ static void memfd_luo_unpreserve_folios(struct kho_vmalloc *kho_vmalloc,
 
 static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 {
+	DECLARE_KHOSER_PTR(sd, struct memfd_luo_ser *);
 	struct inode *inode = file_inode(args->file);
 	struct memfd_luo_folio_ser *folios_ser;
 	struct memfd_luo_ser *ser;
@@ -309,7 +310,8 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 	inode_unlock(inode);
 
 	args->private_data = folios_ser;
-	args->serialized_data = virt_to_phys(ser);
+	KHOSER_STORE_PTR(sd, ser);
+	args->serialized_data = sd.phys;
 
 	return 0;
 
@@ -323,13 +325,15 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 
 static int memfd_luo_freeze(struct liveupdate_file_op_args *args)
 {
+	DECLARE_KHOSER_PTR(sd, struct memfd_luo_ser *) = {
+		.phys = args->serialized_data
+	};
 	struct memfd_luo_ser *ser;
 
-	if (WARN_ON_ONCE(!args->serialized_data))
+	ser = KHOSER_LOAD_PTR(sd);
+	if (WARN_ON_ONCE(!ser))
 		return -EINVAL;
 
-	ser = phys_to_virt(args->serialized_data);
-
 	/*
 	 * The pos might have changed since prepare. Everything else stays the
 	 * same.
@@ -341,17 +345,19 @@ static int memfd_luo_freeze(struct liveupdate_file_op_args *args)
 
 static void memfd_luo_unpreserve(struct liveupdate_file_op_args *args)
 {
+	DECLARE_KHOSER_PTR(sd, struct memfd_luo_ser *) = {
+		.phys = args->serialized_data
+	};
 	struct inode *inode = file_inode(args->file);
 	struct memfd_luo_ser *ser;
 
-	if (WARN_ON_ONCE(!args->serialized_data))
+	ser = KHOSER_LOAD_PTR(sd);
+	if (WARN_ON_ONCE(!ser))
 		return;
 
 	inode_lock(inode);
 	shmem_freeze(inode, false);
 
-	ser = phys_to_virt(args->serialized_data);
-
 	memfd_luo_unpreserve_folios(&ser->folios, args->private_data,
 				    ser->nr_folios);
 
@@ -386,6 +392,9 @@ static void memfd_luo_discard_folios(const struct memfd_luo_folio_ser *folios_se
 
 static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 {
+	DECLARE_KHOSER_PTR(sd, struct memfd_luo_ser *) = {
+		.phys = args->serialized_data
+	};
 	struct memfd_luo_folio_ser *folios_ser;
 	struct memfd_luo_ser *ser;
 
@@ -397,7 +406,7 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 	if (args->retrieve_status)
 		return;
 
-	ser = phys_to_virt(args->serialized_data);
+	ser = KHOSER_LOAD_PTR(sd);
 	if (!ser)
 		return;
 
@@ -517,12 +526,15 @@ static int memfd_luo_retrieve_folios(struct file *file,
 
 static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 {
+	DECLARE_KHOSER_PTR(sd, struct memfd_luo_ser *) = {
+		.phys = args->serialized_data
+	};
 	struct memfd_luo_folio_ser *folios_ser;
 	struct memfd_luo_ser *ser;
 	struct file *file;
 	int err;
 
-	ser = phys_to_virt(args->serialized_data);
+	ser = KHOSER_LOAD_PTR(sd);
 	if (!ser)
 		return -EINVAL;
 
-- 
2.54.0.1136.gdb2ca164c4-goog


