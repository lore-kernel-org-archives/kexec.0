Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C9DC4332F
	for <kexec@archiver.kernel.org>; Tue,  7 Nov 2023 12:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T28OdlyS2VtnQ9fz3zmefJ7eBp/03G58lYHT1HEJIYI=; b=YuHG9INoNbtzvo
	v+F7HAccw3bnaeUQaSUSGNd6l+N0GP2tWtNH38RtrbMqsrzsMxv7UPz0aGuWL+1Nti79n18OH+NKF
	HKAsm2IdvS+6XAysN+dC6OzSOGQBc+pVUmr5kze0/cbDyWWcnsVPeDFcO7XOG782no4l6N9h4AAJJ
	mazMObFHK+Kn9AVKAMhsHmrDnZ8G5tUVGb5DCHJoaxH0k3p4+Wv3VOrQ3Y3YOerhl4nC5ECOThNns
	RgdZ7DZn4I9TDG3DTmu5It64zmrM/CVCLzxDqLopD2ABF9aTG0AOXZcCsvgiRkXAl1f00gJnv4tT9
	gKlWDzHVbEFJ4WaYDGsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0L40-001SbC-2d;
	Tue, 07 Nov 2023 12:20:12 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0L3w-001SaL-2L
	for kexec@lists.infradead.org;
	Tue, 07 Nov 2023 12:20:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 2ADEAB8167C;
	Tue,  7 Nov 2023 12:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC07C433C8;
	Tue,  7 Nov 2023 12:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699359606;
	bh=p0mex8bBv1TTORPMIHzWnMsEXyAsprynyz1dfSu86+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M9n2ZLGTQF1UGoU8ZS7QCcqQITJvlXwtPIyPBNnY7y7WG2KrDA7sQAcIniwHRyYVJ
	 FHMU9crYMFcjlhjzqivQ3NVPgPl1H68gCMGYG51x95l8ss+I0l+s1m8ELI1IMCBUgP
	 DNEtKrZ11E4jYJDR9ujEcP5e9A2ItQ4xyd1vG+NSXjfk+IAoeOuv+vEZgbPXLZWWmc
	 9lYmfu9Ie4h+ntG4QXPr5kJKJUd/QF2brfoCyo0AlbpzJe8KQZ7A9P5ggo3ikTRCMN
	 jt01X5ffxBt8Z+CrTONCPvOVn4VC0OqsPZPavO0lnr2tZeLZDkhthmNJvMxf/Yrk9k
	 7osrZMaF6Kkzw==
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
Subject: [PATCH AUTOSEL 6.6 15/40] kernel: kexec: copy user-array safely
Date: Tue,  7 Nov 2023 07:16:17 -0500
Message-ID: <20231107121837.3759358-15-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121837.3759358-1-sashal@kernel.org>
References: <20231107121837.3759358-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_042008_915026_B9E4488A 
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
index 107f355eac101..8f35a5a42af85 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -247,7 +247,7 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
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
