Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D635F588DF
	for <kexec@archiver.kernel.org>; Mon, 20 Apr 2026 14:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qewxjB4gqze9ueAsfaggwvN0d9awd7MKHEueXVS3eI8=; b=tCoRYCuDrTfOHvQM3xqABmUIxZ
	tGgzp8mlbCNflZRZRQJv7lZDSSUypOJTgYGdT4PBSspr9Dl/2850igFOkk2iGPSEPP2CmRktytNNB
	6BzIyiRZVHgGGx1fD894I7usPVy8nrNpTZNj/WGKfs/P6K8ritoFkEQ1De/8Q0ka42n8in3iZPKNj
	uA19rJr7vPVN574iFiP0PLnWkWK/ffzck1X3hE9JfEHKqkJc92EQTFysegOZZLUSwOm1GI0i3eQ4l
	ausZy+3ZxKVCmihFB/GL1fjn2n4wOwCqefnP2Es961fMTcVyrFXYpfGZUBRXVIc3E1aThdZNjceQh
	/S8O620w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEpRf-000000079rQ-1Qpl;
	Mon, 20 Apr 2026 14:17:51 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEpRc-000000079q4-3GOH
	for kexec@lists.infradead.org;
	Mon, 20 Apr 2026 14:17:49 +0000
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-43d572f7437so2084935f8f.1
        for <kexec@lists.infradead.org>; Mon, 20 Apr 2026 07:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776694666; x=1777299466; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qewxjB4gqze9ueAsfaggwvN0d9awd7MKHEueXVS3eI8=;
        b=km8J5FEppKStTXzpygqAk3rbcPJTW60hPtpxtdE65hY22RVJS0WQm6nT/MzRNJtFZE
         /yYTSVN3d4g+2f2YWX0XG8//j6EhVAVbOa1dH22RGwJjk7hrsRZBLp6kk5lHI+1MonMy
         3gUKiO0+BjsHjF5qX9ABgEkLeCdpL1jvWRaKtCLE8vcTkef8NEB7AJB4sHUkfJsVdjUP
         Mnwk7hiHyZKxAt7UyEEV17sSJ2UMQdApphKHpph3hiDDTELHh1N4ZC2rd1a76gV8ksJM
         hobgylK87doBFx29K3y+M4Z4nPPYdi9iwSbWLfyp44AeRHW8Ya9uJmCys/0XCU7XN5Pj
         CsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776694666; x=1777299466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qewxjB4gqze9ueAsfaggwvN0d9awd7MKHEueXVS3eI8=;
        b=WXwALhY+6lpKvnhKFSdfn6JRp1EejZQobNPk/cQFuMlXDLJEvg7q3AT60ECy6KgfjH
         ocP0QxSONj/0UqNNp4Rd1+rkGARMbsZtPPyvSzU/UkLqAspLYGf7U1md2rs47dVH2MvA
         4lpODZN4NvUYzCnt2PA3UUBKiEO9Dhs9RovcS953FQslnrp0uUhtoASi5Z8xBq9ey0BS
         Xhk263LPDyPQmbKzrUtXhvmhP0qutbDmP9esAzIaY6HEbDDOSyb+esAmiG9uFFLWouWK
         /wX/ECdCOlFfKCMK862qHVs6nAyysN4zA0OJ+Gp5bFmGagz8HeE3BdYkczIWjMIBzvRG
         EJ+g==
X-Gm-Message-State: AOJu0Yzdb5+EPWuagU2iyx3/Un/VYVCKKKPfL6xTXyuo/gWZ8vFa12Fm
	SZ8amCkrouUXVpcrYT68I8qJl70Ie0euYoNibzv0Yp+ZcDXHGX9PfLjMmxwu/w==
X-Gm-Gg: AeBDietap836LD8uRwK3vbBwZmzlzXcQ6rQWnLZ0sBOC+GfQoOtvaKQ777Hg7Sy+oi8
	+av8jw3jFug8VJu2tUShof/i+y6VN6194sxCFeykISe35MTyz5wgdtiefaeQDBm5l0loWn1Z94W
	3Quxh6bo9rC/BULAY4q0l9jdC/d79SPaRAbXkqc44rpGlmaY2LzVZ8Rl2v55WnzowSNMzaVHeHj
	MLNsKTrP4veVbZsJNX5WO6ncDTEtLIGSUHWvobteSkhBE+eUB6ghZ2EsTCiTOY2BuFha2V+b2t9
	EXes69HzNdGlS+PtMM2t1+Xk08OB83WZybE6PEj0tRB2XmpYrru7Gl6xfanBhf2SvED9eo7csz+
	UYWXctfTCl5oO98MsiK/++JVXLvaOH6Dk6NUz0lCCbf1HCPUCrYpbdeEmZBdiJbH8XKgHLSzrim
	9v2PKyKffWQMMOdq5+dt+Cx5vPGzKwuG5fNx0iL1An+0oP2tG2Xg==
X-Received: by 2002:a05:600c:6296:b0:488:c40b:c8a4 with SMTP id 5b1f17b1804b1-488fb73d764mr194293145e9.1.1776694666131;
        Mon, 20 Apr 2026 07:17:46 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:355d:3be4:308b:c943])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fc1c0354sm269742375e9.11.2026.04.20.07.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 07:17:45 -0700 (PDT)
From: luca.boccassi@gmail.com
To: kexec@lists.infradead.org
Cc: linux-mm@kvack.org,
	graf@amazon.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>
Subject: [PATCH v9 1/6] liveupdate: reject LIVEUPDATE_IOCTL_CREATE_SESSION with invalid name length
Date: Mon, 20 Apr 2026 15:15:09 +0100
Message-ID: <20260420141741.2688371-2-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260420141741.2688371-1-luca.boccassi@gmail.com>
References: <20260420141741.2688371-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_071748_862508_AC1EB299 
X-CRM114-Status: GOOD (  10.21  )
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

From: Luca Boccassi <luca.boccassi@gmail.com>

A session name must not be an empty string, and must not exceed the
maximum size define in the uapi header, including null termination.

Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_session.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 25ae704d7787..5e316a4c5d71 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -382,9 +382,13 @@ static int luo_session_getfile(struct luo_session *session, struct file **filep)
 
 int luo_session_create(const char *name, struct file **filep)
 {
+	size_t len = strnlen(name, LIVEUPDATE_SESSION_NAME_LENGTH);
 	struct luo_session *session;
 	int err;
 
+	if (len == 0 || len > LIVEUPDATE_SESSION_NAME_LENGTH - 1)
+		return -EINVAL;
+
 	session = luo_session_alloc(name);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.47.3


