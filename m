Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BB5CD6E45
	for <kexec@archiver.kernel.org>; Thu, 28 May 2026 17:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zI6/R1kae2LnDj1mKhlFVbr6Z6bSt4LSCoOlMnq3wXg=; b=piJuG7ednis98ZLj+ReLI3am5w
	A/32q+hvn4UbCHUkvKrlSx0/M52OStfxT8aB1c3I1UM6uFG6Wz6CvRTVIzC7Sa/8zopieHrC7rhTP
	Msbz5lXpkWyc2QtvClsm8+z7gEcFqa70nTHR4dVyIhrD77uhG8VEMLhz8s1WFIvlGoJ8aqLC5Zmmg
	n60qaB+GZrUax7MOiW3TCIQLplqdp2XhzBtFWUikS8ESC9ezrIL40X5GtAZQU82pqpIIjp9SmHrbe
	WaLZ98UKl5/pvoy/GPhwWKvinE8wi3ycArK4QgeKKt6VUY6SJRT0OV5dui1YnJlLOewuC5uTVgqzg
	H90Vdo1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSejw-000000067Sp-1jVi;
	Thu, 28 May 2026 17:41:52 +0000
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSeju-000000067RZ-38bl
	for kexec@lists.infradead.org;
	Thu, 28 May 2026 17:41:52 +0000
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-c827adbf00cso5969663a12.2
        for <kexec@lists.infradead.org>; Thu, 28 May 2026 10:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779990109; x=1780594909; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zI6/R1kae2LnDj1mKhlFVbr6Z6bSt4LSCoOlMnq3wXg=;
        b=snz8n2ARB64gOA+no428b9lEDJFpr/tI9yJBdkjYFqrJ7vpKIgs4XjNSepv91a4zXA
         9u8Kj/FcpoDlnSLR4PWMhDeAguosMAfKao8gXYZJ80A/SuHoKsImia99I8gTGYvxidkW
         AuXPMSSLAQo1ctTv/WMiUBHn2tdN+9S3JYty4HmAUmt+XtGWCvB8iHiRG/5SRPs/2nAi
         1xbUt33DsBSLSnDXrIz7Lzz25JAqqcIA+BBi+XuoU1zQ6Ui1xy4XrXI4IKx3exmWvSBb
         qagGkqFLsC8vHFb2LJK2GvjV9roKDDVlr95fRfLoUtTrdYpmb7oGu14OJFi8ZvDlfPq1
         wDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779990109; x=1780594909;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zI6/R1kae2LnDj1mKhlFVbr6Z6bSt4LSCoOlMnq3wXg=;
        b=MJR0EOwXKqWyBw10i27dZl4OYXVpEPb73UTp6GPVYW2isTGuAelm1hWKqzSglYPmjY
         tcrFxiAm7V3HYfssviFLBRFYTF/AvuXHaP9PqvUXpU1/zE918uFefHQ2zJE5GkEig3zI
         fBJ1rGNnsMUe5MBUImYS7tlLwQliYZo0AYGBUzfPz1Myp9FOgS9/kiCM/SqJN/SFRo8n
         reI/2dIvjZPBn62BCIE6k7zUfUy/bK36/MkVRn8hiSAVAtiwUtCa4FsnA7OYRM/6UsON
         7IX2ZK14dkRbBe2HzW3kf3N3q3b5dyVv43M9HUmBoBbTXin5vYk08yIjtTwl9OtBHnQY
         428Q==
X-Gm-Message-State: AOJu0YywqD3h3jxbYa9e6RbcM22UqxP5J+XNe57WrW7k8zsuZVPoaqEO
	3PTg7XIlmpC44VeQTLfxtzCMzplMSET2N+7ZsTtU2HJ5G00oDRU6IFyPgh4pi4rwsNG8Jw/k6B9
	1JkVN/OeTAeLiZNLtpG3KHwrK7a2Ktl/4Niv+XM5BKqwTa9/XpQhZvL7oZHODu9wTse3fSI2O3c
	Un1OqJ76ou/HfiMitChrtAadqHY7Vd+OCest56qcyRtYfhpNXm2z4=
X-Received: from pgli34.prod.google.com ([2002:a63:1322:0:b0:c82:3bf0:91df])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:394c:b0:3a3:33bd:319b with SMTP id adf61e73a8af0-3b328f3b012mr30313814637.39.1779990109127;
 Thu, 28 May 2026 10:41:49 -0700 (PDT)
Date: Thu, 28 May 2026 17:41:40 +0000
In-Reply-To: <20260528174140.1921129-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260528174140.1921129-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260528174140.1921129-3-dmatlack@google.com>
Subject: [PATCH 2/2] liveupdate: Remember FLB retrieve() status
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_104150_786883_B60AA0F1 
X-CRM114-Status: GOOD (  22.16  )
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

LUO keeps track of successful retrieve attempts on an FLB. It does so
to avoid multiple retrievals of the same FLB. Multiple retrievals cause
problems because once the FLB is retrieved, the serialized data
structures are likely freed and the FLB is likely in a very different
state from what the code expects.

All this works well when retrieve succeeds. When it fails,
luo_flb_retrieve_one() returns the error immediately, without ever
storing anywhere that a retrieve was attempted or what its error code
was. If the user attempts to retrieve another file registered with the
same FLB, LUO will attempt to call the FLB's retrieve() callback again.

The retry is problematic for much of the same reasons listed above. The
FLB is likely in a very different state than what the retrieve logic
normally expects (e.g. some KHO pages may have already been restored and
freed).

There is no sane way of attempting the retrieve again. Remember the
error retrieve returned and directly return it on a retry.

This is done by changing the retrieved bool to a retrieve_status
integer. A value of 0 means retrieve was never attempted, a positive
value means it succeeded, and a negative value means it failed and the
error code is the value.

This is similar to commit f85b1c6af5bc ("liveupdate: luo_file: remember
retrieve() status") which did the same for LUO files.

Fixes: cab056f2aae7 ("liveupdate: luo_flb: introduce File-Lifecycle-Bound global state")
Assisted-by: Gemini:gemini-3-pro-preview
Signed-off-by: David Matlack <dmatlack@google.com>
---
 include/linux/liveupdate.h  |  6 ++++--
 kernel/liveupdate/luo_flb.c | 10 +++++++---
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index c344bf987b63..63ea5417de84 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -173,7 +173,9 @@ struct liveupdate_flb_ops {
  * @lock:      A mutex that protects all fields within this structure, providing
  *             the synchronization service for the FLB's ops.
  * @finished:  True once the FLB's finish() callback has run.
- * @retrieved: True once the FLB's retrieve() callback has run.
+ * @retrieve_status: Status code indicating whether retrieve() has been
+ *                   attempted. 0 means not attempted, 1 means successful,
+ *                   and negative value means it failed with that error code.
  */
 struct luo_flb_private_state {
 	refcount_t count;
@@ -181,7 +183,7 @@ struct luo_flb_private_state {
 	void *obj;
 	struct mutex lock;
 	bool finished;
-	bool retrieved;
+	int retrieve_status;
 };
 
 /*
diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
index 7ddef552ff6b..f8852f7e62e5 100644
--- a/kernel/liveupdate/luo_flb.c
+++ b/kernel/liveupdate/luo_flb.c
@@ -170,7 +170,10 @@ static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
 	if (private->incoming.finished)
 		return -ENODATA;
 
-	if (private->incoming.retrieved)
+	if (private->incoming.retrieve_status < 0)
+		return private->incoming.retrieve_status;
+
+	if (private->incoming.retrieve_status > 0)
 		return 0;
 
 	if (!fh->active)
@@ -196,12 +199,13 @@ static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
 
 	err = flb->ops->retrieve(&args);
 	if (err) {
+		private->incoming.retrieve_status = err;
 		module_put(flb->ops->owner);
 		return err;
 	}
 
 	private->incoming.obj = args.obj;
-	private->incoming.retrieved = true;
+	private->incoming.retrieve_status = 1;
 
 	return 0;
 }
@@ -215,7 +219,7 @@ void liveupdate_flb_put_incoming(struct liveupdate_flb *flb)
 		if (!refcount_dec_and_test(&private->incoming.count))
 			return;
 
-		if (!private->incoming.retrieved) {
+		if (private->incoming.retrieve_status <= 0) {
 			int err = luo_flb_retrieve_one(flb);
 
 			if (WARN_ON(err))
-- 
2.54.0.823.g6e5bcc1fc9-goog


