Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA251099B28
	for <kexec@archiver.kernel.org>; Fri, 20 Mar 2026 18:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qlkUSalMj9D4ZyF5iVWhe4Zr05w/l/vA3PbfqbtaeJE=; b=KLE4vGqt3QyWIYlKRTW/hxj5Z5
	AByQVzZ1eopsFHvGlH0iXRc9OlnWWRtnubvuc+/ULjpI+b54xfd0yqsCUBUXRWsoz6zqnQp6k+Yry
	iGapN6HnamjOg5WO+K31kzFx4BD22fUyNcfG6OLePkb419iksvcSEs9abHwjdQ/mkFaiSObqKTVVc
	z54m3J4SjWNWXUflFIuSoWGvC99+iOKmpWbs/Gr7jksf927drM0WLsSE7oVoSpUUpzZtIqVO2Q9Vg
	R2mrS1bCgYts228JIzb9a6j6o+na195ml/z07uRMGVa/q0s/pOG3BHuxXllo6sxGk0QBKnn9o8oMe
	a/AzGESw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3eXR-0000000DNZ1-33cb;
	Fri, 20 Mar 2026 18:25:37 +0000
Received: from [209.141.44.239] (helo=smtp3.mymangomail.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3eXM-0000000DNYJ-0CWD
	for kexec@lists.infradead.org;
	Fri, 20 Mar 2026 18:25:34 +0000
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by hillsboro.smtp.mymangomail.com (Mango Mail) with ESMTP id 037615F43E;
	Fri, 20 Mar 2026 12:44:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gerlicz.space;
	s=mango-1; t=1774025057;
	bh=LCP21uO2OPKzphq8H7bcRGLaZ+F4b8Pc7Apy117wI5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OLWx2AuEk0kG9zBBROAAKPICPPUq6/y4iYKgplAdXo2kKU5ghP/1Vq8FbbPIj5Lhl
	 ebBvCd0GELyrvFcdtjUGEPnro+SFSGOepH/O/gahw3Gs6ss7SlG8rO89oSNO0pxFSU
	 v4crwG1qDceb9CbH9uwzVkPEg7D6ruXeFi9D4kqk=
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
Received: from authenticated-user (smtp.mymangomail.com [205.185.121.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by hillsboro.smtp.mymangomail.com (Mango Mail) with ESMTPSA id D56385D9B1;
	Fri, 20 Mar 2026 12:43:16 -0400 (EDT)
From: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Baoquan He <bhe@redhat.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
Subject: [PATCH 5/5] liveupdate: guard FLB counters against underflow
Date: Fri, 20 Mar 2026 17:37:20 +0100
Message-ID: <20260320163720.100456-5-oskar@gerlicz.space>
In-Reply-To: <20260320163720.100456-1-oskar@gerlicz.space>
References: <20260320163720.100456-1-oskar@gerlicz.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_112533_076149_C757E397 
X-CRM114-Status: UNSURE (   9.48  )
X-CRM114-Notice: Please train this message.
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

The FLB lifetime counters are decremented unconditionally on
unpreserve and finish. If either path runs with a zero counter, the
value wraps and the FLB state appears to stay live forever.

Once the counter underflows, later handover operations can act on
stale FLB state or skip the real final teardown, which makes restore
and finish lifetime tracking unreliable.

Guard both counters against zero and warn once instead of
decrementing. This keeps the existing lifetime rules intact while
preventing wraparound.

Signed-off-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
---
 kernel/liveupdate/luo_flb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
index 3672cbf8e075..06501360fa3f 100644
--- a/kernel/liveupdate/luo_flb.c
+++ b/kernel/liveupdate/luo_flb.c
@@ -128,6 +128,9 @@ static void luo_flb_file_unpreserve_one(struct liveupdate_flb *flb)
 	struct luo_flb_private *private = luo_flb_get_private(flb);
 
 	scoped_guard(mutex, &private->outgoing.lock) {
+		if (WARN_ON_ONCE(!private->outgoing.count))
+			return;
+
 		private->outgoing.count--;
 		if (!private->outgoing.count) {
 			struct liveupdate_flb_op_args args = {0};
@@ -201,8 +204,12 @@ static void luo_flb_file_finish_one(struct liveupdate_flb *flb)
 	struct luo_flb_private *private = luo_flb_get_private(flb);
 	u64 count;
 
-	scoped_guard(mutex, &private->incoming.lock)
+	scoped_guard(mutex, &private->incoming.lock) {
+		if (WARN_ON_ONCE(!private->incoming.count))
+			return;
+
 		count = --private->incoming.count;
+	}
 
 	if (!count) {
 		struct liveupdate_flb_op_args args = {0};
-- 
2.53.0


