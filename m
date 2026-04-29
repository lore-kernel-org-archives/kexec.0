Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B40CCFA13
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 21:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pxqYhYsj7HU7oN1/TsDhDPzLzeP41V18doSZqNDu2iE=; b=OaCKLwyeYvrE93X6CfI767xIEW
	K7UKBrAyrj4tGLpO30uLP2LjDiDP+5J0WjLL/ArlHU8bI/w+ddedYpGimoopc5nF/8P1YAmQxoLHc
	AGxM9SkaqKpHRMXJ4YDMbEFJAnpgslJDtkEf7xKsZHTc7PZC69QYntCn4wmyJOtiuYip17PdXJSGN
	KqmACYEigE84xX5arOyLJdXj7DoUo7k3cWpAbpvtcaVdBEVVX1x/qTAo2dZzj4NFgwk+PPD5wdn2V
	uw+MoZwY+mFYrIvV3lUJVNpwrBvo0b5l9hQN0uPL1wT55c1ASxV+6rcs3WvKm5QEJ1R4pydIvgxN7
	mX8BOoUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wICMY-00000004EMX-3YM7;
	Wed, 29 Apr 2026 21:22:30 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wICMW-00000004ELe-3aDA
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 21:22:29 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso2028035e9.2
        for <kexec@lists.infradead.org>; Wed, 29 Apr 2026 14:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777497747; x=1778102547; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxqYhYsj7HU7oN1/TsDhDPzLzeP41V18doSZqNDu2iE=;
        b=P5Sx7UE7xEebnHrnmZMy0VrJyaWSswhxrLofnaCsmhktARdhZQp3usyxmmmCqfH/aX
         Kdp6S9DI5A7K0BIkJHnI8IQU/Lp5H17fTEJGxPHxvQmheWbtOUQlN7uh3w01m5a0NoqZ
         oIs0jFytPcOX2AisFNd/mXYIUc3pNud12u2wE+6OkCPqgK7ixkymGK4cSS5hlLkJMPJK
         aRpnMwXoxwwPfmPWU6al5MrnTjcUoYq3UCp25HQECQQM2l6Lo6BFmvZzak9lPPRf/AiB
         K5foq3uDysCcuP5ld1mXycnFNTjxokibVU3eM9zAMgyrzBWLrVuyMIFEeB7x060L4gG7
         YhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777497747; x=1778102547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pxqYhYsj7HU7oN1/TsDhDPzLzeP41V18doSZqNDu2iE=;
        b=S+M9cE6pi4xtaXI89hWA5dP1NFjGZQEXcJNc4PlHKPU1WyJAjk5Xz4oNuv3Pldi5au
         YlzcRv7j+6HZVPUh+9mH1zw2NZF6LDYMHOzkOpMz77xkPuxpW3GDs8GjBB0Jka5gxPC7
         ws33/6g7MumY1XdeXagzvQ76FP78gLSti3UGH+AogCOUsXiuqPvTnCebiPEqW/d+Gb0d
         riCzsD1syH+FxyKkgu1NJmPwWxFDOYg2Tro0zJ5pRZcXAOEv+XA5H6D0oIW7yFOsEeq9
         gcqmZB+s7KEmJHDHkN4uI4Z2ivLbXSuVBfC+yKWL/g7T0RnVB4zf8bEKtFg9bodhnIng
         Axyw==
X-Gm-Message-State: AOJu0YyDHf3Frpu6VC/ZtVYNRsbDKtXGCf8K5K8K1ZUbhYfSCyhUGXWz
	VT25Ad+BTVntUMCu/qU+eOGfSWIYvEVWRpqttpme8jsvrydmJiQLRNih0l6Jkw==
X-Gm-Gg: AeBDietNxcF4f7q0vHvPsx0193Ew/D6nWai8JQSxyY/367p/zyL4zEGfZ12QtZmurXn
	/PowARdSDR8d0pf5cEBdMz4ElR0FaDqf9i6jFG0TU24aTPjqt2XdwEq8HnpxWEHU9JJAIsebKgv
	QBoq3uH7EKSDX4Nuq+BgQf4L9jWCy0rZ7jhanGLo6w3tvgLQS32ZEOI6k7Rqx9mAn+ICQoHG+YI
	BJycUyBYussm81xqfob18Gty1L5nd53I3WR1I6GI0X8auLb1h9mH44eL5XW5QaMEpo7rbORkvs6
	pjV0XYPe6V+eVgxtdsRV44cFWoe15Oc7uD2XCqRLQTjf6wedmTujUyhGUmu9G+mFM+UO/C5npwn
	b9VcLyTQndjVMKRnC+9nTcfphCN0U9w1mI3e0uNR2dqN88LsFWtBEYArd689C+YnZuGUA8G8XsV
	DN0T1TPn9VbMIeJFV+CEQHLHGYU9lqSYHS0acd9mo=
X-Received: by 2002:a05:600c:1f8e:b0:488:a824:fe04 with SMTP id 5b1f17b1804b1-48a8447f466mr3197815e9.26.1777497746519;
        Wed, 29 Apr 2026 14:22:26 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:8fc7:44bf:8aca:ebae])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48a822d4b57sm45356905e9.15.2026.04.29.14.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 14:22:26 -0700 (PDT)
From: luca.boccassi@gmail.com
To: kexec@lists.infradead.org
Cc: linux-mm@kvack.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v11 1/4] liveupdate: reject LIVEUPDATE_IOCTL_CREATE_SESSION with invalid name length
Date: Wed, 29 Apr 2026 22:21:14 +0100
Message-ID: <20260429212221.814107-2-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429212221.814107-1-luca.boccassi@gmail.com>
References: <20260429212221.814107-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_142228_896125_BD7F4E33 
X-CRM114-Status: GOOD (  10.27  )
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
Cc: stable@vger.kernel.org

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/liveupdate/luo_session.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index a3327a28fc1f..24b4f381d3c8 100644
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


