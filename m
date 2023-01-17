Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F062C3DA78
	for <kexec@archiver.kernel.org>; Tue, 17 Jan 2023 03:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I2Sgl1ZQ8ibYjD6KcBRt0Tu0LP8Hxhmku2NHMmYytIk=; b=IFxkHM1mH+KVIo
	Dl8ESqBB2lWP9GtsNVXKtAZNAnJE9z5HO3Ikm3FiXYijrH3JU02L0ccfK93mksyMh99o/QMXy6piF
	fQoBsb5D4ozNScavs3z2JmvVYwbc9Owy0d05g92BgupmvXZOFmIu58CSsektptoBk9Q31h0juyVLc
	ScwTyk7BmwML0xIQXEyYB0dYU+gfe8qMNLcPq3fp9tOI3FazGxMTRSFBzWHzs4NYlVnyqsKWQi3sH
	5taSVAPXN1Ei5ngq5NMWUvTPqmHOXH6Bx4zIE/sHkJzxE/mlE4QrE+E8x8OP1p3PD+7buG4GYSRG4
	pd9iPxPGQlucUEBk+joA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHczF-00Co4r-3P; Tue, 17 Jan 2023 03:50:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHcyq-00Cnvv-L2
	for kexec@lists.infradead.org; Tue, 17 Jan 2023 03:49:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673927387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tq8BWi7KIMXK19sTfFEOHzGCHbw3j+yt4nwzlz7Cvoc=;
	b=dYKtc0ph2+IQw29dI1QR2keVO8rJAia7hkB7v10J6o+Kn7H0Z5UXzROAWVWspmeGrwU3eo
	6ZNJWw3CHy1h5jB6Auu+NqneVPBTo148oY/jlkTaA9BCRdnCWnMaWYhYHFjj+C+uzmXZLc
	sX2qQFcaJeTlqUaR4YuhfNFx7UTTrOw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-upN5m9UrNDW622U8L_BpjQ-1; Mon, 16 Jan 2023 22:49:41 -0500
X-MC-Unique: upN5m9UrNDW622U8L_BpjQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA8EA101A52E;
	Tue, 17 Jan 2023 03:49:40 +0000 (UTC)
Received: from fedora.redhat.com (ovpn-12-229.pek2.redhat.com [10.72.12.229])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D146A14171B8;
	Tue, 17 Jan 2023 03:49:35 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	thunder.leizhen@huawei.com,
	John.p.donnelly@oracle.com,
	wangkefeng.wang@huawei.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 2/2] arm64/kdump: add code comments for crashkernel reservation cases
Date: Tue, 17 Jan 2023 11:49:21 +0800
Message-Id: <20230117034921.185150-3-bhe@redhat.com>
In-Reply-To: <20230117034921.185150-1-bhe@redhat.com>
References: <20230117034921.185150-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230116_194948_773536_CDFE6CB1 
X-CRM114-Status: GOOD (  12.53  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

This will help understand codes on crashkernel reservations on arm64.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm64/mm/init.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 26a05af2bfa8..f88ad17cb20d 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -177,6 +177,10 @@ static void __init reserve_crashkernel(void)
 	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
 					       search_base, crash_max);
 	if (!crash_base) {
+		/*
+		 * For crashkernel=size[KMG]@offset[KMG], print out failure
+		 * message if can't reserve the specified region.
+		 */
 		if (fixed_base) {
 			pr_warn("cannot reserve crashkernel region [0x%llx-0x%llx]\n",
 				search_base, crash_max);
@@ -188,6 +192,11 @@ static void __init reserve_crashkernel(void)
 		 * high memory, the minimum required low memory will be
 		 * reserved later.
 		 */
+		/*
+		 * For crashkernel=size[KMG], if the first attempt was for
+		 * low memory, fall back to high memory, the minimum required
+		 * low memory will be reserved later.
+		 */
 		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
 			crash_max = CRASH_ADDR_HIGH_MAX;
 			search_base = CRASH_ADDR_LOW_MAX;
@@ -195,6 +204,10 @@ static void __init reserve_crashkernel(void)
 			goto retry;
 		}
 
+		/*
+		 * For crashkernel=size[KMG],high, if the first attempt was for
+		 * high memory, fall back to low memory.
+		 */
 		if (high && (crash_max == CRASH_ADDR_HIGH_MAX)) {
 			crash_max = CRASH_ADDR_LOW_MAX;
 			search_base = 0;
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
