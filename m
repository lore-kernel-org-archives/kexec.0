Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B2EC4332F
	for <kexec@archiver.kernel.org>; Mon, 14 Nov 2022 13:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+UylsNvaJSJokdXhRgYbFvyExeqjQkXWtnT4TOuoTgc=; b=e8RzLfyoq9Ll4b
	sb7vB6+KbbQqtCTv45QSsJVbX/TVD3sZgpOhVpVb/BUErggSBuGvf+foQ2B7sNQlFVlVZb1OZWadF
	VsBbI16lws8ojDjBeMtd2490+rp434IZnPFfvOm9bv+kjYbSP89BG48cEUgLfSq8OtfUMuvEspjX+
	CcxoVXgRkknq5VP49Jph7dTxols2aXLSu9Rka7pQpk/Hkj9Oq1KpDoPldr3LhFVL+7OkEAzO0Y5H8
	qcatjbuSV/GdtgT39YWTUqDJbIQ0EQ1KTtZYgTzmVtR9Cyv6ot8cVClDNRCLCS2TIzKZbK5jnjntn
	UpDCd6YrqjIpyhBlp8sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouZa1-001FIg-Bs; Mon, 14 Nov 2022 13:32:53 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouZMi-0019VW-IQ
	for kexec@lists.infradead.org; Mon, 14 Nov 2022 13:19:11 +0000
Received: by mail-ej1-x62a.google.com with SMTP id bj12so28134817ejb.13
        for <kexec@lists.infradead.org>; Mon, 14 Nov 2022 05:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xM+YcVXCVdAbnW4OE/73urNUlHdnFwO79q+gmDoDsr0=;
        b=EplnvrtGfiqw30Q7kLRL4IlET5brTvihBzdcPhwFcU52tuqzxiV8RsfpYLC6eqaRkT
         0ygTR4IJES+0HuyXNrkvaMUB4MzL5aCtMFq4qLGCD5L9OSbFTnoOgXgJY3djH9ps5yNX
         adcAmozFjGsMnYIU8phDFbXr3kRqbQSN4JnIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xM+YcVXCVdAbnW4OE/73urNUlHdnFwO79q+gmDoDsr0=;
        b=4rMzWO5VsWwYVPpB6WBkFQC4Xb8XvXOC0QsSg4nWT4pQgf6VGEgs0Xf59X90fCIyrH
         kjKLh+BD+b9a+UE/qHbQTFMBwhm/VIj7a1swavAL2KkIMidOeBmDsq6uIHj5XUiT/Aa4
         2KtagAlZd5aN4Xxvcjrxsfd1vKbqfuLpVxia9pWZ8VlfgLWt/W7C66KMwRyUkTHP4pWp
         OfgtCec2C753fqjawTTYhcolf4TBCrKf9+MuhjRNX2XgVRtAKMGcpu60mTi+ZGVO4J1T
         3wraXbetS72MgRs4YJyPola4b2eQhoD/QQiTlGP4QVRuvKSeFVuM1gIkqnDefEpN/wgx
         SVeg==
X-Gm-Message-State: ANoB5pnhI/EExuVh8mWJzrM/RI4P8AuvjRfdXlKM8A6XCXPXI6Gt7uUy
	NhHqoqGEgDKN43SuGEHD8Eucag==
X-Google-Smtp-Source: AA0mqf4Ktnl0YrpUJ/zQ2j/nhucRmcyReeUSMGK8cfPoN0Q4ChIekjUj0rl3RtmuKDuhQbti/TNdjw==
X-Received: by 2002:a17:906:cd0f:b0:78d:99ee:4e68 with SMTP id oz15-20020a170906cd0f00b0078d99ee4e68mr9829642ejb.302.1668431946244;
        Mon, 14 Nov 2022 05:19:06 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:c205:5c4e:7456:c8cc])
        by smtp.gmail.com with ESMTPSA id g13-20020a50ec0d000000b0045b3853c4b7sm4802061edr.51.2022.11.14.05.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 05:19:05 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 14 Nov 2022 14:18:38 +0100
Subject: [PATCH v1 1/2] Documentation: sysctl: Correct kexec_load_disabled
MIME-Version: 1.0
Message-Id: <20221114-disable-kexec-reset-v1-1-fb51d20cf871@chromium.org>
References: <20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org>
In-Reply-To: <20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org>
To: Eric Biederman <ebiederm@xmission.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 Ross Zwisler <zwisler@kernel.org>, linux-doc@vger.kernel.org, "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=zDOuQm9cQhkd/nA1jGZR3he7xVJj/YKQQUhyS/khFbk=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjckBEjyJCQEx200s9vD/3tqll0nVOqpN6FKcWu+uj
 NvYvTuSJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY3JARAAKCRDRN9E+zzrEiDnOD/
 9Ks9b+Ued+KyoeV7ygpZz76D9Q0XfAFOq0DMdz7krQNEYRNokkHIz2X1PLcF5UKgyWl3iu1ZY/OV4M
 YReDtofadyOBt+kFuZY1ziV9Ocyja87uU3rlZ5fcWJQfd/+8D0vBVgFL33ydaSHLhcvbrDqD2TCsuB
 kM9doysF+DrfnmS58H7WRPuNZd6ZOLnknvMvAG8vTJWx0iDkvnSfB7d5Xo0WT0bGZvIPLZE960yehp
 B9RePEIQ6nDcKNnD1azJDKCw/8XXlrYuzzLpXk4+sqUwQrbL88xnKMx39NWg3Xm4G3kIQtX3igfENS
 VomHElAGKHt3JpqVL50wJXWOHEa3Itlh+GBERvYeSsMTuH5Wa9V1JsQFLgurc3zrgWvV5c6hHrXm/4
 rS8BR1x63yULYU4nA+1CRFS3wiv1hiMa/XNC85qbpxhSiYdT75dX7zOasM3pbuOGNtxzxvZVEVOpi6
 D4uPlxgxKXvHOn69jKwVxMoSIL3+GTYT1ZCsIR65O3oIZpmyWdBEgrx+MGnagCP7ZHheb6ZHOqquHT
 m2euzpVJmeNS1Ity9c5+aVrkfHy7QPHTEcjrZ0MO5/jgsy6AFVWDT1bRqrRfO53GpsqvHWlgFwVjCK
 G7Pxt3W2v/SOThv+B7SYuaZU9foBvShbrFcw58wDACKF78S1+QVsLpFd7Feg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_051908_736849_9190BEBD 
X-CRM114-Status: UNSURE (   7.38  )
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

kexec_load_disabled affects both ``kexec_load`` and ``kexec_file_load``
syscalls. Make it explicit.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

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
b4 0.11.0-dev-d93f8

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
