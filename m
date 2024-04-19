Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B68C4345F
	for <kexec@archiver.kernel.org>; Fri, 19 Apr 2024 08:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=COAfAB4gII9nOgVwoZbkqYwQm70I0DWipgU0KVtqO1o=; b=o/dYmTe6/ff5Ej
	QH10SbZ+rNsOj3iZaoAQ0C1nNk6pcJ2MjA8wUH5p0AAqlnonLShIvGe8h2nZ+9WsbIsDh+TQ3KTQy
	T8zKhLFa1GVPRhhtnV+sop02V4+qZi5Abz9FSfOS/lvkvflasfJQsMUQkOkBhOok12/fU2hTNCm3/
	OEyWjgq3wDjxlJjM6tA2olF3+qxba3+/Rslc0qwmJjSf38h97YZQtLGwuw67/WnhYwP/nQH0k/pmw
	EYzzduAkcVroHVMw5hpnqgxecA5nWvlC6XEaVclz8BcqZwQZf+E7yPr8Mhn+5Db+sU2Jnc4zfuf/A
	xJFxvU9mv8P0lK6sQHvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxjyi-00000004zgj-1eHO;
	Fri, 19 Apr 2024 08:52:16 +0000
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxjye-00000004zfn-0HRv
	for kexec@lists.infradead.org;
	Fri, 19 Apr 2024 08:52:13 +0000
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-343cfa6faf0so1620750f8f.0
        for <kexec@lists.infradead.org>; Fri, 19 Apr 2024 01:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713516729; x=1714121529; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5LGjb2F9FFTJBbYNZWOBJ7u8v0HHb3dxA+L9Lp5Uwo=;
        b=aPU+TnK58Xb6VHqrZiGqttNJ2ZW7Y9gg8NqqKL1tSnSe7zTWWKfj4bIfbAkWtVjmEq
         LzDV4VzyG64k+YH/FnMtMzjjGgH5+BzOKHW5JA7LIHFh6XE114Z1CHp4XWnqYd6BuAXa
         OdOvfC0irPQXOXIUSWD1+rseaou0JJJL9J9a//NThcpDLqkhKYAvuLfc3n50lbzE0tHx
         mDIC95gTy0wUzBTLEsjdWh3eMibey2+VAHwwlctmOdX2J/nz7YrwZ+ol4mSk2rr6sJ5m
         Km7fm4Obp+wKzWnL17Rv8dYHA0dTJmTbsakE4qXSTs5sO9U2om34JnKdeC4WK4YDTnUe
         0K/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713516729; x=1714121529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5LGjb2F9FFTJBbYNZWOBJ7u8v0HHb3dxA+L9Lp5Uwo=;
        b=FQI303aA27IgLrVA+pwwlOM1CpKGcQQpxVwBZt+Zgsgu+rbTDCZoQVHoRruH51uffq
         E/uIHwqlmEnKMISccJcvb7ehm83gmVnEO4ynR7/G/DdMzjx/jKqWE1zpBu/yWvrwkZOY
         +85/5sWFhXpF3MYnrPuTMySVakZtoO1/Vj6UEym9qzljcNlT6fWz/gzebB/WokmdLiJh
         xyoOhughgBB1y3sO8QoZ58ymHvXF70CCGlQFjtWsFo960cE+vQNxjjENr9MSSRDyp2Ue
         iH4UHu49bo4k7rgEw0/sMETn5i8TYdYHGBh6ZylqBtw7KpK7WqybQOjEcA2Ag1pFAzZD
         2w3w==
X-Forwarded-Encrypted: i=1; AJvYcCWGIrV5oidTPrmxzOYR9KPsmj7sZtpgtAXPb4L/Gjw/mrhpLQNFkyYcpFX0SkKV6cWmsqqYIiCZipbPjXcmHQUgYOuHLs7o+NRq
X-Gm-Message-State: AOJu0YyW+j8GyUAnE3jq/VXpWwwMqxCpK+eIf+Ixz50fhnENAR6PKBOr
	J10yTS6LY/y2KTS6FohK6p3rlV+nJnytAOTDa66GcJ04Oh6kmRY6
X-Google-Smtp-Source: AGHT+IFAVjENaP6mjBDpze9INfmCIbwyjNdRH9Jc2GJLrSjfn8Trae1QHtNdTtuEVFDzpvWL1+KVvw==
X-Received: by 2002:adf:f085:0:b0:348:104c:c105 with SMTP id n5-20020adff085000000b00348104cc105mr1072630wro.46.1713516728513;
        Fri, 19 Apr 2024 01:52:08 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b00418d68df226sm6373876wmq.0.2024.04.19.01.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:52:07 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crash: Fix spelling mistake: "crahskernel" -> "crashkernel"
Date: Fri, 19 Apr 2024 09:52:06 +0100
Message-Id: <20240419085206.888416-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240419_015212_125908_A33C0D5A 
X-CRM114-Status: GOOD (  11.04  )
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

There is a spelling mistake in a pr_warn message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 kernel/crash_reserve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5b2722a93a48..7c87b5efcc81 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -132,7 +132,7 @@ static int __init parse_crashkernel_mem(char *cmdline,
 			cur++;
 			*crash_base = memparse(cur, &tmp);
 			if (cur == tmp) {
-				pr_warn("crahskernel: Memory value expected after '@'\n");
+				pr_warn("crashkernel: Memory value expected after '@'\n");
 				return -EINVAL;
 			}
 		}
-- 
2.39.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
