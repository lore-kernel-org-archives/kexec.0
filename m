Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CE5CD3430
	for <kexec@archiver.kernel.org>; Mon,  4 May 2026 10:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PLRTjFWBKckG37I6yYxV0GSOFolcA5HXN3IZ90cH5NI=; b=QDVLt3AI3ePIAZ8EWOOf655uSy
	F2GIll3C1dTcWU2odxxsTrHy4+RzVob+xSTJAI8mrz0n+MB3gQ7iUIlGQm/nW+dNm+BPJ5s3tZezF
	9RdeSKBTBzgUvDikju48h6K5vqd0VZ261i/4LA8JkxRVoycbneyVORA+PKF8UKFyJ689G27xVEDE/
	fBPKYJCFOKsZqX2LUqtWJRQ2eA5JNuFmpxomo/iTbmT+N0gbTnbkQ4GoMzppK8lJ2ZdiUabpfGlXo
	QTkoCUDCjdq8OytFcc+/2zVbTO18a2Gv64VMkceAotxsVQOLmVMMUfbLCaJ3sE1x3asxHi2LgWU9+
	t9z/5+yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJqWq-0000000CvnH-1JeK;
	Mon, 04 May 2026 10:27:56 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJqWn-0000000Cvmo-28UP
	for kexec@lists.infradead.org;
	Mon, 04 May 2026 10:27:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BD08942B1F;
	Mon,  4 May 2026 10:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFDDC2BCB8;
	Mon,  4 May 2026 10:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777890472;
	bh=Lm7HRhztFy2nXJJI8dsLt4KOHWAxV7mNAACnnwK3Ulk=;
	h=From:To:Cc:Subject:Date:From;
	b=JFUIFciUSLwWOa7NdBlXoMOUqRJnXRW3JpBH7bb0mQP5HKAnyucIXhWo36zrzUid6
	 xhxoFasBn98GpjRnkeBg+dWhXW/uUPdy8wWqoYQnyrV1FR6IMJf1xBw6bnut1ffovc
	 0a18Svg8rvBHBtEDIMTMGlkCQfT7F7hWF2zdIGVe8oGQuflhBX0vTC1evldtBn9yVA
	 2/RKkrbLLZLiavZ9bdEbjEdHd+2FOBwHg601JZHamnHDrq10naFpBsaplQNTNh/Ys0
	 CNy/poKpl2XOOlc89xa30jvq+64VR6YgLr76amDqOI2l1/gsrDRaSu8SZcuOM/d1cb
	 Gur7ELofq+kYQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Clapinski <mclapinski@google.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] memblock tests: define MIGRATE_CMA
Date: Mon,  4 May 2026 12:27:40 +0200
Message-ID: <20260504102742.3833159-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260504_032753_617377_64026C8A 
X-CRM114-Status: UNSURE (   8.93  )
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

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

kho_scratch_migratetype(), defined in include/linux/memblock.h uses enum
migratetype. This breaks build for memblock tests with:

./linux/memblock.h:634:73: error: parameter 2 (‘mt’) has incomplete type
  634 |                                                        enum migratetype mt)

Fix it by defining enum migratetype and MIGRATE_CMA. As is the case with
the other headers in tools/testing/memblock, do not bring in the whole 
thing, only what is needed.

Reported-by: Mike Rapoport <rppt@kernel.org>
Closes: https://lore.kernel.org/linux-mm/afcdDm4aAJvNaQqH@kernel.org/
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---

Notes:
    I didn't add a Fixes here since the commit hash for the deferred series
    isn't stable yet. Anyway, I think we should fold this into "kho: fix
    deferred initialization of scratch areas". So random bisects don't land
    on a broken test.

 tools/testing/memblock/linux/mmzone.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/memblock/linux/mmzone.h b/tools/testing/memblock/linux/mmzone.h
index bb682659a12d..8d934ff5b080 100644
--- a/tools/testing/memblock/linux/mmzone.h
+++ b/tools/testing/memblock/linux/mmzone.h
@@ -35,4 +35,8 @@ typedef struct pglist_data {
 
 } pg_data_t;
 
+enum migratetype {
+	MIGRATE_CMA,
+};
+
 #endif

base-commit: 74d1099bb4edfca3ce6edc61dbacbed96720034c
-- 
2.54.0.545.g6539524ca2-goog


