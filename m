Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5033DCD6E66
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 03:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6tW8ZkJFH1s/aeCdAEiQB7eOXHeRrYqV2OpgEHHCsa8=; b=RZN67jHFqEqUm8j1zx4QWBxO/e
	WPmiQ5F1TkyH2QWeR8py+aH+VcQxUft9Zo4I+kagSrNn5CPN5CstyAL2NYS37obLpMCDWNWmw3M1L
	flFHsv9/elFnnhwPrZ/zBV9zdPxR23ySVRxGHnjCWW0eam1OkQK2jONMxRFfvHtJaGPBIbVPnbN4u
	GonAbgWWcXWwndhUCswpO/k6mtwjQF84mLyFcC0l7xYLoaAo3DVxM602rgQ8bRSOMarrD618R6g7c
	M9kXiX2shVJ76cpIXoD7d59uurqCNOzlSTyqSYhUChaa4bzF2HW4JIh50C703SXR4KF/LwrJkNhc9
	v8Uc7OlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFd7-0000000CDBJ-0Qmq;
	Tue, 02 Jun 2026 03:17:25 +0000
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFd4-0000000CDAB-3oL8
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 03:17:24 +0000
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-517654b8e28so5494591cf.3
        for <kexec@lists.infradead.org>; Mon, 01 Jun 2026 20:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780370241; x=1780975041; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6tW8ZkJFH1s/aeCdAEiQB7eOXHeRrYqV2OpgEHHCsa8=;
        b=AdaiG/nluhelQzfB8+nmRjGXxN9si/P+NPjceShcQ1U3YpsZcMt4iyXD+2kket6aFH
         l6q1Yr7OoYlBEKwkXRyo+/yyd+uZln1x1UNV8IaWYkZ5LCLSpYZ4MneRxFbD0SH/mG/f
         5EB/bI+c5EeaOTlJ59yPCoZuUji0b71R2fB6kPOXrVGX10R/KNLvAYWpapckNR6dEP1e
         yB8f8vLaG0cAYklPVvpSRNy88xzfIn64tKXnQxsB1oLxRiR99kd236Fz9l5zdTn7KySn
         R5e+B9rIA3l379Ph4psUnpr17PsHrBCgnFCLH59p6CG2YU4Re4Ca+IYtjv6hJ2wDJYGe
         D1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780370241; x=1780975041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6tW8ZkJFH1s/aeCdAEiQB7eOXHeRrYqV2OpgEHHCsa8=;
        b=q9JROFBKWAyS1aXoT8ZOhvs7KHaY4SLSuk+/FlZlRKG3gnxo5E5CX+57RLvAXjZVsr
         NcflkSUNjmLkwYH1t2vE/QGtV/raHr9Cw955C8kEuyWb4Emve5wjQNl6BZDFRz53e8BL
         21AALqsq7c8RwwtWauN8CLq68RyE0e1uzMFqj/yeDTCXRRAki/FAw7Kl/N+6DdaJZd1z
         kTzniXG+15/x78K1CTudTGLu95MMAZokzJCS8omiA4Wpd4zxZu6EA0Js5DoFQ5ILFGJo
         TYmW7ijHYy7GHVAR21FB13B1BLKVmhBSfnJQwKr4dv277C5U3cRO2zqz8gzI4FggitLB
         1vlg==
X-Forwarded-Encrypted: i=1; AFNElJ/spa6Ip4DlBpbsEDZ+thWvGrAS8siCu3lBCBU5HaHkGZB429f+ogS+Pqm19g+dPGSRMIE5Tg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzTHd2OMzjzZAbhEw+k+U18DNT65rPYWDzrCeLswa5ydX0VUIzD
	t9VVbEjmnETo56YNtDk/F4leBB3ZuubDzPhd6dBs4lZHfqYnRdmXeiFN7Mw4ecY3Cxg=
X-Gm-Gg: Acq92OFsERy0XpqPdk8WSJt/K4Cf6ZmIweoRQ1iGMjQ4zTwAZvBWyhKZTupB10YMqp9
	XKQO6eFEC0IYsdLCFdSi8p3DLK/wiB4i2GMBudQbQ1GaLE/7KJpuCbcGsLXcXFLu1tAGHL9kz5W
	m/B3Gpt6wqc7BUpztnQAsuKci8tDS9QlqCdgKdwmBZ8A7Xq3pwMLGWNYpcRI3Xr5lCr3v/SKDKQ
	WQX6TKYNLqCkJFrv7ICQnQ/dh6xMAotY1vV9DpnsRFOPW8hHB2her2PAF7cPLCajWOdSnqbRk5X
	KCrYWNmRUt1k/an8TH/VGS7sGqqXM3aAxhMpWsaqcZQ6XBJcglWU76vwUPGjhKpP6cfRXLSepCh
	aeBqU5TshnCo5Aw6WFtpS8VQQVgdJoBugm+mND+Es58ijDAtEFwRMM44JW5V//HJdpUU6s0HJ7Y
	tDJFFxOSGRareWlv7yY7O0Rdw9Q4hCDG9B/LzQAzY4ss+4vQhz4S9ZHHr9ftmSzg==
X-Received: by 2002:a05:622a:4c14:b0:50e:6377:197d with SMTP id d75a77b69052e-5173a6197f2mr192694801cf.8.1780370241637;
        Mon, 01 Jun 2026 20:17:21 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51741b29745sm71219081cf.8.2026.06.01.20.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 20:17:21 -0700 (PDT)
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
Subject: [PATCH v5 02/13] liveupdate: avoid mixing cleanup guards with goto in luo_session_retrieve_fd
Date: Tue,  2 Jun 2026 03:17:06 +0000
Message-ID: <20260602031717.197696-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602031717.197696-1-pasha.tatashin@soleen.com>
References: <20260602031717.197696-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_201722_952730_162BA6A5 
X-CRM114-Status: GOOD (  10.44  )
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

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_session.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 5c6cebc6e326..7b2f9cbabb05 100644
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


