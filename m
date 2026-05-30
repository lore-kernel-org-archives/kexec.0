Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4772DCD6E54
	for <kexec@archiver.kernel.org>; Sat, 30 May 2026 22:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HTj0tA/bHNpv873y+awGsfoidHwlRovW0AIu32f5CU8=; b=4uUoEwkb4itmr3gfmDcfpXwoHT
	MUvBe0ZckwIqsNMBmATPDuWXY4YsDmc6pLpJeZmpjLIvogNCyufb0mMPbAOltNm9LZ9QjpGJsZOu8
	X+rREoqq3bl0+0Z90HYb9DkZKPqegJcO67mXKxmx285wiBi2MG0VGceArpBOhaai83beEiOYwwPHN
	MHpliaoq9rIz+alys5Ry3Hgrw2+zyMxbZn82bTwiMHcTZIqFKkNLzRPzc9wfFpnX78aqjGhbgRRJa
	VtmT8iirDqC/tOLMUn0SvqPo3SZbFuz7s9x+5Sk4IMw5hObOhZCiO7SZG2du1htuJKHp73l65rgnH
	4oG5CIfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTS22-000000095js-0xAJ;
	Sat, 30 May 2026 22:19:50 +0000
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTS20-000000095ik-0mdT
	for kexec@lists.infradead.org;
	Sat, 30 May 2026 22:19:49 +0000
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-914cf9248ceso635823285a.1
        for <kexec@lists.infradead.org>; Sat, 30 May 2026 15:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780179587; x=1780784387; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTj0tA/bHNpv873y+awGsfoidHwlRovW0AIu32f5CU8=;
        b=gZQ9ZJeiX+Cl8JLLsrcyeuvlavuR3Cgre+p9H132zlTOAvyzljMSHotmWZWKDkWQ65
         Ue9vDghd5hq3jPNN38keaf7GfboyLWGfoobPrr3dS0/WXvyM5vEVOgOhsba7sQkx4IZV
         a5NyBrcqMxVvdsN8tukb08Vbc0oi26//WlovTTSkyIJUjh3JcTjgb6IvMHS/7h0Qdn/Y
         N9CXnR/RS/YcO4krCoRE9xkK/AVIbXyRPk4QGYAy7qkDrYqC1JrIVpEHP3QfFfxXBfgR
         KUOzCSiqRVaB+MOYnm/TZKR406Q5bLUNy8uUztlL15f5l2O1y+nncKK1KH2RqWN8fQsi
         pJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780179587; x=1780784387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HTj0tA/bHNpv873y+awGsfoidHwlRovW0AIu32f5CU8=;
        b=L5rmpjTEHcbnmxWB/tH6Adzd6MgOX39vGNax7C0mfjMfmc932pFblhnumb1KZwci8B
         IcCCoSXASxuX1JRan3QWDn22c+Wfprxp+uhFbJ6WAXh+NcuIv51Y5g2vwCOv1EWB+hER
         x6YIclHPgdaDoFaKaS6J/EYozSZ+6lHVCWQ9Ko0GzLMuzeaCq8JOk3cklvh1DipJhaX+
         r37GRezQnAJyjJrONxT6hGJY8xUEnUgPVr8ec+Mth7f7/xNQrz18BG3fsQV9G0YslAla
         LLeGRW+DORZGvG1ZdTttLtPolyA9N7nkRU+Cwxz1Imh2zOAbbBZOx/N3AH1a8iequx1Y
         b1RQ==
X-Forwarded-Encrypted: i=1; AFNElJ9c++LSFdjAMNCc5ASRBPcLun/WwJJbahwiENxAS3NZFY5DYQ+KWXf7COh4vQMRcKYNJ6Y3cQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwLVpQoXV2EWuLBgqT96cePtZP6yloqmX0SlyhhDCxRxK9y244r
	N24I6Xm7ZjiGujnG+XE1Db+uyhR1UcA4dQE3lHAqqWTjVbi/C5UVCamIVgktu7IlZp4=
X-Gm-Gg: Acq92OEIt0i4BqRFu0LIMq07crZ2ntYFTkYtZxydKxp5jess5Hq1HZAG+UBtBhLNj3X
	Shbv79WlbUqocY/xpNcOTFWO6Q5eeFrvH9vPeKalV/+dpIzAKKKJAV0XKnektSJmqXDuRfYq8pS
	MOsLysAXbhmWMAl+YvySKSAjz3dgy96P1d4YtcQIhqZE18pttgnzRhMAqCTeKix+cllq9l14nOx
	suroK26eDZ+DPyNw87fB7qJYg/d2yDgGTFUDb9JLPmGeWb96cEde49ZuDOf33Lb/2foht9S+dK5
	JDRNmvdnmCxs7FZ5EU0LbxNKTAcYnBfvO1R30xFBo4Xkgw3ksTaDr0HNG3W0+aoSQJ0ucuyLEBU
	nsQOesK44UmkGl3tXCgf2p+eD7XWttVQUmqHUH+VBwMhQRNMe8s3Jlt7K+7xUywmGt0FWW3kOAI
	KpeKsjuqC2u8EGaMZk6MDNQIsIJwMnuzFpYNjehreEGV1CrD0Se4cNxUS0DO+6BA==
X-Received: by 2002:a05:620a:2610:b0:8f8:cdd0:df82 with SMTP id af79cd13be357-9153dcb4b99mr859487985a.58.1780179586864;
        Sat, 30 May 2026 15:19:46 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915324868a0sm651790085a.18.2026.05.30.15.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 15:19:45 -0700 (PDT)
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
Subject: [PATCH v4 02/13] liveupdate: avoid mixing cleanup guards with goto in luo_session_retrieve_fd
Date: Sat, 30 May 2026 22:19:27 +0000
Message-ID: <20260530221938.115978-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530221938.115978-1-pasha.tatashin@soleen.com>
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260530_151948_236045_3602CBBF 
X-CRM114-Status: GOOD (  10.67  )
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

Refactoring luo_session_retrieve_fd() to avoid mixing automated
cleanup-style guards with goto-based resource release, which is not
recommended under the Linux kernel coding style.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_session.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 146414933977..8d9201c25412 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -291,25 +291,24 @@ static int luo_session_retrieve_fd(struct luo_session *session,
 	if (argp->fd < 0)
 		return argp->fd;
 
-	guard(mutex)(&session->mutex);
-	err = luo_retrieve_file(&session->file_set, argp->token, &file);
-	if (err < 0)
-		goto  err_put_fd;
+	scoped_guard(mutex, &session->mutex) {
+		err = luo_retrieve_file(&session->file_set, argp->token, &file);
+		if (err < 0) {
+			put_unused_fd(argp->fd);
+			return err;
+		}
+	}
 
 	err = luo_ucmd_respond(ucmd, sizeof(*argp));
-	if (err)
-		goto err_put_file;
+	if (err) {
+		fput(file);
+		put_unused_fd(argp->fd);
+		return err;
+	}
 
 	fd_install(argp->fd, file);
 
 	return 0;
-
-err_put_file:
-	fput(file);
-err_put_fd:
-	put_unused_fd(argp->fd);
-
-	return err;
 }
 
 static int luo_session_finish(struct luo_session *session,
-- 
2.53.0


