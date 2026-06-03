Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7362ACD6E56
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 03:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EeknQ7K2aMvDWr+2KhWa4BnSPX1nCQezxpcXmui2530=; b=0gZlIdO0Tbg+lo0DF41fE04ZJ9
	5ITIz8onzN7fvwSA02zbqTo2D74N3gaha6fxPX3sK11HA5qligHYcdDNfWgEf4nSH/dhC0Tnp6EtR
	2+zqo3IVedwndQS57p6RYym66NoG8N5owXxreA8+ZcxO8cQI8ggdfEz+ivvtNFumB/9Q9+CrudO17
	cMrx1UTII5LGAPd7uc4gFeV4GOoBF5rdpS/ZwKzXbRT9/kEr+osJzMtQKzRB0q5Tnnn49Ro37W1Hm
	Epb+qH83jTRaEdfgpSmpyb5l8fUcBLXHbBouO1e+Hc77ub1iXEuRMB0Dy3nRm5j4wba+JGVqpFys5
	7qTE7uyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcI5-0000000EAuA-4BxU;
	Wed, 03 Jun 2026 03:29:14 +0000
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcI3-0000000EAsI-16Pc
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 03:29:12 +0000
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-8ccef25789fso31532576d6.3
        for <kexec@lists.infradead.org>; Tue, 02 Jun 2026 20:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780457350; x=1781062150; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EeknQ7K2aMvDWr+2KhWa4BnSPX1nCQezxpcXmui2530=;
        b=Og2AUFerXoQi50HorQkcGw+VyM+Tn2TkVgeHw1STjYSJVf0SaYMR55BzABnFTVVueL
         PlMQV5TWB+X6KNkefR4oMkf6t8JWvPOkMC34GAyLDjH8ASwo4488XigwEcdGK+JxH7Cu
         a9y6itktBiEXqTkw2MMn3FCjoCPG53EHDfX3jIW/gNb6lGQrb51HUb5HB6CaxKZdlJww
         5dT7dOtv6T4rKPknYGe2rtpHvey3SMAUbxmjhuGJBK7S+zn8Tr1GunHrR6Kjl3LqujvV
         uxLn0jdybUplXNkFUE1LDOTRt+l+FCc2wmBLutf5TU9+GeGVAKBixcu+jD7znD7NTFQo
         4qOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780457350; x=1781062150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EeknQ7K2aMvDWr+2KhWa4BnSPX1nCQezxpcXmui2530=;
        b=ccObFSzMzVH2KCFpk/nQmnNiLVsUgPu04Lx+Fkoq5sBjEGbXiNA+1eR2IupwId+ma/
         Y/sQ0K5qwuRp2/KuvQhqEhvbMI6OhN2/xP3oWpqR9ZihBPbsFe7h0raSw7PkvYfoebop
         WJheIoERSnZaCmalZEQEWfOFnMemXqOwOgMkoCfccERw9+UHkRwNeWuNeuOoVvmUDOvz
         fG82z7tNEFoXzct/+YylinMFJR4x9quhZ/rS3/3JUzpujJLF1wr/ch93Nf9Ce9uydrqV
         vR7bUIlh9+B/uM7uQMNC8Q39QPPcMK+UBqMYkKWRJl3SlQk9ooqwDM4QacO+y26S0uo9
         b4LQ==
X-Forwarded-Encrypted: i=1; AFNElJ/jBjl1lJfaANGKWg0ehW0Ntq6LSqA4ieZNesll+Rai1kMTf/KTnX8a+6mgpx3bQuQj878tCQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwxZLAGd6vBcFsumDmzOsrD+7Wd0JgEVJ8s9NTi5ZlKDRk7jwnV
	mKTiAPViiaXhwQey2tRGZk5m5rziOTynzjMMwm3+Q4aYU5x5iF8QLL+TzM5aAzYNiuw=
X-Gm-Gg: Acq92OHCoOvabxXTveRJ2LyvUqyg+YA7l0689EakbY+2g60zqd6OQ90nIZjDGhIh/I9
	ZdXd4usXYz/pqT4rsi2Qvowu+nkwwSe38JP8bLfXQMAFf59ehi14QQjuRBKVHw6tzV+wInBLinM
	InPvzZnqGvY6FTKcueqK5/CEHmb4i0nzkk6TC3txO5N6edVSLqiNHzz6Ssz8aOhrP5haLzUqOSS
	yuHh0Ie24sXzriReQXkr2cEmy8Q6E/bxBMXyXJTxlYiyICt5QO4ZFOB5yEeg/fhrSUOLyj0A7Ym
	p6itUtgVQjiMaIw6x0XVUfccIdlWOU5BFFkQRWLcpqTq8y3c+IN4FnpH0+kJ8bOU0b4sycgeUQe
	bTlMiXtWnxcaGzka2ou18JsEbjsFMIokoRWtmFYPm9pVbGAwALouCUS+C+650p3BZVIlD0ao9fx
	vXjDU1/jWzoDP19Vkfbz25p6n9Uk8dsw05gvWqbN7WP8CEjRUja4lMZnP7Pln3lA==
X-Received: by 2002:a0c:e086:0:b0:8ce:ade5:e8fd with SMTP id 6a1803df08f44-8cecdf0cdfdmr18753906d6.25.1780457349833;
        Tue, 02 Jun 2026 20:29:09 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd26b3b9sm9244566d6.45.2026.06.02.20.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:29:09 -0700 (PDT)
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
Subject: [PATCH v6 02/13] liveupdate: avoid mixing cleanup guards with goto in luo_session_retrieve_fd
Date: Wed,  3 Jun 2026 03:28:53 +0000
Message-ID: <20260603032905.344462-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603032905.344462-1-pasha.tatashin@soleen.com>
References: <20260603032905.344462-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_202911_324953_3C2B0C7B 
X-CRM114-Status: GOOD (  10.10  )
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
 kernel/liveupdate/luo_session.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 5c6cebc6e326..47566db64598 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -291,10 +291,11 @@ static int luo_session_retrieve_fd(struct luo_session *session,
 	if (argp->fd < 0)
 		return argp->fd;
 
-	guard(mutex)(&session->mutex);
+	mutex_lock(&session->mutex);
 	err = luo_retrieve_file(&session->file_set, argp->token, &file);
+	mutex_unlock(&session->mutex);
 	if (err < 0)
-		goto  err_put_fd;
+		goto err_put_fd;
 
 	err = luo_ucmd_respond(ucmd, sizeof(*argp));
 	if (err)
-- 
2.53.0


