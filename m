Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D65C4332F
	for <kexec@archiver.kernel.org>; Wed,  4 Jan 2023 16:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xbzUeNJQ2JK+09Psovji/hICh6XHYfYb6IOS8417iRg=; b=pkT5lLMoZfPsCy
	9WCHOnaEY/sslUY37KWphRGMpXxhdiGIzR/p7AJzDg083k2uxUC67dGymU5IQQe38NhxOBmC5R4sn
	2I/zPo445EzftZ67/x73cr6umasjjZOtw7Mvd8SPMubP0u+x8ZGZEX1wEQbIgcgOzR1FxaruGNpl0
	FuWDsnRdn6cCNXPmOD+I0kVCEN+8w3fFdtpxhI8QQ6AQnVTw5MmA645Nnl3SsXdf7WLEj5otZFsrZ
	0rdAX6KexrR3J1CD+IoyOWXJ2hjJoPQZFjYTjhzAkwL/n53sZJPmEuFIkrb/ZuuuWqfu4DijBAa3g
	ZKOMa3ElUza9tQUOc4Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD70L-00AVcZ-Ez; Wed, 04 Jan 2023 16:52:41 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD4vB-009lJ4-JI
	for kexec@lists.infradead.org; Wed, 04 Jan 2023 14:39:16 +0000
Received: by mail-ej1-x632.google.com with SMTP id kw15so82952618ejc.10
        for <kexec@lists.infradead.org>; Wed, 04 Jan 2023 06:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CYYQgh/lv3T9poZ9Kbn1xfKKla/OcUPaY2NVZr8/1wI=;
        b=TPhzP6VDMUU3QtDkGKBz2ODkHY5IHPZJLk2AHghZRhDppkwIzHLh+ClSZSi7dOkdEO
         djNbFLbX/qbVhko5HtmYgh+KwUPHIj6YbIq8IfqKDrqPxZwEVo1ZnOcnm84WOikjUIXN
         84Nn49z3bmZGZyGjFWM0g31CC5lEjul+7e7vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYYQgh/lv3T9poZ9Kbn1xfKKla/OcUPaY2NVZr8/1wI=;
        b=qoT44BxzRVQ0zDvRVKw/ca9TW+bSL9/Lsh5QGHiRcup1sz+XOcezuVvRQgri3i0Id7
         faChNOSpxv3Cl55N6nWT8e5uEKvtwkato0dXVm8knEjHUf3sKJ1s6MDSTLritiWNb4Bh
         /CTfEWNWhhxYg1fl4AuvMRRRJIUYv9Q9M7K+alz/0//9t7EVcysRV6rjI9ET2nvQ/P55
         9FYK3GqxTYrualG/crHVaDbb/Klkx9A29a6kdFquESc951AMs4KXW74ytGKVZaV2hVAI
         umJb0TIgAy7jwUM1lOFbKsr80LVO1ECxA8ozMGEPdUBgyYKsv/ytdyG5Phu+sBacMky8
         TU3A==
X-Gm-Message-State: AFqh2krpLAh4A5/3NlCXTEwOuZFYd0yDzjMYXfPRn8CMlm/hbjCLevD8
	rvJ8gbOJuga9arhmTPtPoSqJvQ==
X-Google-Smtp-Source: AMrXdXtBlcdrPW/OtLMuhlJIa8ITHBl4FnGqRj+b7buGekdJ2R0dm4D0Mgxm/adGoMtGVV+TmZF0UA==
X-Received: by 2002:a17:906:5dd2:b0:7c1:7010:f413 with SMTP id p18-20020a1709065dd200b007c17010f413mr44805532ejv.19.1672843148794;
        Wed, 04 Jan 2023 06:39:08 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:a438:c7da:62e0:36f4])
        by smtp.gmail.com with ESMTPSA id c8-20020a170906924800b0078de26f66b9sm15386659ejx.114.2023.01.04.06.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 06:39:08 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 04 Jan 2023 15:38:46 +0100
Subject: [PATCH v6 1/3] Documentation: sysctl: Correct kexec_load_disabled
MIME-Version: 1.0
Message-Id: <20221114-disable-kexec-reset-v6-1-6a8531a09b9a@chromium.org>
References: <20221114-disable-kexec-reset-v6-0-6a8531a09b9a@chromium.org>
In-Reply-To: <20221114-disable-kexec-reset-v6-0-6a8531a09b9a@chromium.org>
To: Philipp Rudo <prudo@redhat.com>, Eric Biederman <ebiederm@xmission.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Ricardo Ribalda <ribalda@chromium.org>, linux-doc@vger.kernel.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Baoquan He <bhe@redhat.com>, Petr Tesarik <petr@tesarici.cz>,
 kexec@lists.infradead.org, Bagas Sanjaya <bagasdotme@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 Ross Zwisler <zwisler@kernel.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=2pZFS+1BHtUlFuNmvm1mTYxkgU9yharonO0OzNd1vYM=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtY+EP67lwRrCO5L5k4Dp6xvXVoYkuhFXhgRbt/kG
 8bQ+rx2JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7WPhAAKCRDRN9E+zzrEiEwYD/
 4usIWKfOuuGi8xYMQsTa952RC/Gqq3NLfoSqb13IPaxmQxqWWUjQ9uDtxl6QD90QnBoAjD/tSFebtK
 EapNZosQxrdc+t7axxND9uY17FhOJIKscuu90wrCExbOXav9p2pBlZVk1U8k/WwDAJrH5qMpt7pUvw
 pGRdxVE80sFSCeFSJCcuNrY0XeAYjO2cxzIuLxLSx7O9za8wFCZF4BMRohyc7tsSyl2EVdZYcemr0R
 4z2XLsWYVQRXjtccMgFRkfCGOOmNW/hXVuV11qDDGyf5CSjfO9R7+6laH01SA3fF0Uk/E8Q+3LCu59
 6F5RMHfOoXh38K58UOC8w/U2l5RjiRF2XC4yfmrobAdgnYqmutRHi+Lug8kNkWndLNlewOVKt3Cd63
 wlBc/bMdd6ccRlzZ1pU8IMBsdVp1LCIUWq+IttQU61DODNb9Eatwj6wxBX8Qnhg0PvGrK8Cvsaamfp
 bYOMgQZU49QK2hsbc/aWhMe4mAt26NsDxp87ifiQjgWtpCkBYvj6Su8gg8VEAehX3Nl/1FxQA05HsT
 xSHhehNI5G5pHHslJ5HupPSSbvcOEZO5knYX2C0pCmWn3Gji43SAmKZSHJ3DE3zeUe5bJZlTJLZHBw
 XTSGECyozGv6ERamTopSA8x3YabJeqxtU79aXb9q9mYqfk5MxwYuXUKki4aw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230104_063913_711028_5DDD2C97 
X-CRM114-Status: GOOD (  10.33  )
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

kexec_load_disabled affects both ``kexec_load`` and ``kexec_file_load``
syscalls. Make it explicit.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 Documentation/admin-guide/sysctl/kernel.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 98d1b198b2b4..97394bd9d065 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -450,9 +450,10 @@ this allows system administrators to override the
 kexec_load_disabled
 ===================
 
-A toggle indicating if the ``kexec_load`` syscall has been disabled.
-This value defaults to 0 (false: ``kexec_load`` enabled), but can be
-set to 1 (true: ``kexec_load`` disabled).
+A toggle indicating if the syscalls ``kexec_load`` and
+``kexec_file_load`` have been disabled.
+This value defaults to 0 (false: ``kexec_*load`` enabled), but can be
+set to 1 (true: ``kexec_*load`` disabled).
 Once true, kexec can no longer be used, and the toggle cannot be set
 back to false.
 This allows a kexec image to be loaded before disabling the syscall,

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
