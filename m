Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBA7C4332F
	for <kexec@archiver.kernel.org>; Tue,  7 Nov 2023 12:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v6Y6mSdubiKrc4Az2RxpXNezUHm81yXiPH/FKEfEP+Q=; b=tIYPua6XuKzQ2A
	KRO6+keXcj7P8eF8QiXLCPfvd+Co/ir5WmcwkZrJ8ILUaC0NqlwGD8MLGmpSYMblJwImPJintn2bm
	UJMTnPeWWJIVex8sktvxyLleyrH2nuHhCeN4zEuLJ2xj8dSgAS1oCuNNn35QszhgRw5CZ/qz9eOsR
	/sHmJf1zCtJqzmuBYk1Sxv/hyhvaSTx/J4vU0czxBecoOh3qxbf1rkLKNPwlmIvNPMOszRxfcSuJL
	unqRkvJQMCA50SRLTiI++2W/5WxB2/wuneB3NCRO45HHT94MAvuuIxEOJNRfWZhSBxMtscA5brg3v
	VhEqr7eANRYqJn6jba4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0LDT-001Uov-2m;
	Tue, 07 Nov 2023 12:29:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0LDR-001Unu-19
	for kexec@lists.infradead.org;
	Tue, 07 Nov 2023 12:29:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BD992611DE;
	Tue,  7 Nov 2023 12:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E98CC433CA;
	Tue,  7 Nov 2023 12:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699360196;
	bh=D1PYTQZiTV/3FHNcwcS5n1/vZC1HqQlHbF/tyBrUkkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CPR/Y1fURlGZj6dofCV3TXi5LEmG5gQ0k8Ebp9UX6tbeb8l4UpUj/gUXBaAXoSsNi
	 sGP9vZ5TYxiduc6S5tteqxa1X/QuMWpZiYjhAMJti+ZElos1IIWm+jJRlH/qmVFxRC
	 ekl3hyuisQXdaS+AdCZPjVEOG+J566dMzKeitB1+mDqGEyb852RIhVu4dFSwqY5JA1
	 76rqFgEQSVjwY0Qdgq7RaMxnz4YX0r/ipdiWAfq7EGmcAN5sVqixNg8vJPZYRDeXqw
	 t2kMkMX6sRlzbE1B8S7UWYcDQLeVhE43yAp7woH4LdSxBcYWtQRe7yqgBAAAeWiyRi
	 W2YaMKOBbYsjA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philipp Stanner <pstanner@redhat.com>,
	David Airlie <airlied@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Zack Rusin <zackr@vmware.com>,
	Sasha Levin <sashal@kernel.org>,
	ebiederm@xmission.com,
	kexec@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 05/20] kernel: kexec: copy user-array safely
Date: Tue,  7 Nov 2023 07:28:59 -0500
Message-ID: <20231107122940.3762228-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107122940.3762228-1-sashal@kernel.org>
References: <20231107122940.3762228-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_042957_434167_C99AD147 
X-CRM114-Status: UNSURE (   9.84  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Philipp Stanner <pstanner@redhat.com>

[ Upstream commit 569c8d82f95eb5993c84fb61a649a9c4ddd208b3 ]

Currently, there is no overflow-check with memdup_user().

Use the new function memdup_array_user() instead of memdup_user() for
duplicating the user-space array safely.

Suggested-by: David Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Zack Rusin <zackr@vmware.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230920123612.16914-4-pstanner@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index cb8e6e6f983c7..5ff1dcc4acb78 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -240,7 +240,7 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
 		return -EINVAL;
 
-	ksegments = memdup_user(segments, nr_segments * sizeof(ksegments[0]));
+	ksegments = memdup_array_user(segments, nr_segments, sizeof(ksegments[0]));
 	if (IS_ERR(ksegments))
 		return PTR_ERR(ksegments);
 
-- 
2.42.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
