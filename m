Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE56F99C8E
	for <kexec@archiver.kernel.org>; Sat, 18 Apr 2026 16:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TEJxdjNDjgQ6mPqk8mreYxDf7pruksf/jntCs9G0iUM=; b=QVog2O/3bMnp/Kqlzk2hAa5o9C
	u8V6GI7JUaLVfdcb6RdBolAVNVpCBGf2IOSCUu8pujQAzgFfNkWYUghhajrl/fQS51DQoDccR6JTV
	MIf/+NDHi2kaVd5rcG6gVAsHdPu3P+qvyXGLuuWlxqME3bjQt/awuObtRpjbgQOj6EDRvn0zjbbhl
	TEHMeUFECFdhd7w7npAvv8UHoa1dQiXHc08j+pxLnmN13ma1mKn4nXRAB5SB8n1k0Z5m/dIaErGdl
	ckHwe18u4cMporzYIeoG+xNGWtYTWqrTI4g/wYbYJTZUJBRX+YlpxxmHkJXbQYGgpAFH3mPJ0XTLQ
	aVC8zzZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE8ca-000000055jY-3Ob1;
	Sat, 18 Apr 2026 16:34:16 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE8cV-000000055hv-2qH8
	for kexec@lists.infradead.org;
	Sat, 18 Apr 2026 16:34:12 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so968848f8f.3
        for <kexec@lists.infradead.org>; Sat, 18 Apr 2026 09:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776530049; x=1777134849; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEJxdjNDjgQ6mPqk8mreYxDf7pruksf/jntCs9G0iUM=;
        b=YhutUAdT8tJY6CQpGpb17Lq+YKj8Ld36TBLIUNr4JBRR5WzJ1NKwjP8kIPS3dBHdUi
         FSJ7l1aJvTc/S24pPx8PAaiB8sdHpwSIRO4JwjrJT0h5i4WwC/LMBN6OfCdN7hvc7WfU
         9H6Nj/Lr8fEohyMGdfYj62qOGqZaqeRVD4iOqiiRG4Q/TrhtE6GQFYa/Hknq3k3M5vxq
         PGfbtrOAhJSod3c0aWiDSrCWCdwlTptrSuIsDVyWe7tE41hqSbsz9+Euqsm1jyMf6LHT
         8bTJRJh+7liFXw3wKx8PgSP9Bk0ZkLhqVMBHPFEXK9iPo+twY++a2Ax2BjsEoduwmGgx
         kp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776530049; x=1777134849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TEJxdjNDjgQ6mPqk8mreYxDf7pruksf/jntCs9G0iUM=;
        b=pGs6vKH+sITQ8NxcBwJK6vsAg+3qnhYIFcRRkaai0oWM2gHv7v2cLFFQzkDlab/vTs
         PDlyfKfIrfCQ972/6DndwKnSnbSmEenhXCUkm1C70FMjPclAymkfAf76qzh5IvWIent0
         3LTR9+o/E56zNsYHAauwV8rtw8kt8HI7rNzvJji5i1mAHVYHy4syN7lZB3JtiG3mlJCO
         0yI4Zid/uGzfmMlRjP3FyKH6HnWOTxumGM0XYGFA0HQj6lqfUzosp8lGZ6dsNcVpbe+9
         1INaJ3A1uGaRUnSq1nMWbSa2hn8WXeFY/ed9wdeCBXKMh87DVVM7EIpY3MHa6Dnja3u7
         WwHA==
X-Gm-Message-State: AOJu0YzFSFSJXGIpDf+dY8IcH5hJLYpSvfwKnawBmGPW3aXz7zxYzOs+
	qQ5X8XNj78MIfgt917FyOshJ+p67IaQ+nLByFQAC+Qj+shrwUm4rbDY4AOaR8A==
X-Gm-Gg: AeBDievZp3P/txq0XP84+hpOkzV4Q5OJakkx1tcTk/V5l+BRF3ock35oMAIZsoItjhc
	LAKG3xqn2/c9ybZQrbalV+a5ffcGtEWE+fm1KNZ0JjLKb2xzXtzMHAvWlqK3plXyJJwuYm+k4KN
	S4JV3Z1ycOV5X0xWlhKN6554hxt6YKLUDfdqb8VoLVA48AiXc6S54HAaHWBjJY6KwoH4QfrZGes
	QfW2eIUOAS1+vFwKcLoBQr1PoFDR+ZpQ/PdyVBEZXH6WKD0oo6cXTxK5QlyVnWVwpXLsR1jKL2Z
	X0tuW3dbe/D6Zh70Aox0GYzWP35qcj2Ac3k9u845X+OBZGfCnpMpcy22pIV3G3KcOWmTmhLB3hF
	T490V7TAY+FEixJd5wjAwtpbErTKLkjamS3+BHQmpPf/IKn49evqDRGgo6G+dhWm8NwlRM02CRP
	FjGaY12ZBogKfjRfv9b4cjpb7oI/N9tNZI6qA2kK+5VzD4VF8zFg==
X-Received: by 2002:a05:600c:c084:b0:485:39d1:b4dd with SMTP id 5b1f17b1804b1-488fb74a495mr74754135e9.10.1776530049189;
        Sat, 18 Apr 2026 09:34:09 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:e054:93f2:97bf:84c6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fb78cddcsm60829895e9.4.2026.04.18.09.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 09:34:08 -0700 (PDT)
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
Subject: [PATCH v8 1/6] liveupdate: reject LIVEUPDATE_IOCTL_CREATE_SESSION with invalid name length
Date: Sat, 18 Apr 2026 17:28:18 +0100
Message-ID: <20260418163358.2304490-2-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260418163358.2304490-1-luca.boccassi@gmail.com>
References: <20260418163358.2304490-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260418_093411_722016_F12CED73 
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Luca Boccassi <luca.boccassi@gmail.com>

A session name must not be an empty string, and must not exceed the
maximum size define in the uapi header, including null termination.

Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
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


