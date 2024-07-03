Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52600C2BD09
	for <kexec@archiver.kernel.org>; Wed,  3 Jul 2024 09:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=B2BCaQGf5+UZwGKz+pRXAYS109/DhA+wNOLcqdCxwHg=; b=ybwnfpqanxunV8
	asoVQ/7IJcIbSnAeMsHx3Jm2mUJNkE2w2nZa79eK7Zy5qgMGVdaA0bsSX4kPAdDt/kv9bPVb6MNou
	F+eXamY1I54R6yhrmleYBx2rFM9UbX2B9oQIXaQxaE9s633JKM41s/05GX867Xn/XNJs5aomYX7cC
	P9Y69G90eoC5NmDODx4cvrAjliKqfur7qeJ3KG/N3hu7QaLZBqUGh1l4HfwSpQ7JAyfMNjtR/G+zQ
	6cF/zIIxsloUON39cjPYZmAALib3FvxU0gjKxCeDFDG4JwmI1N1jZ1bss2qlJIg8FYMk6ZcLXqPKD
	yFcHU0eFyWIYTIKHNjeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOwP4-00000009ZvC-3xX9;
	Wed, 03 Jul 2024 09:35:54 +0000
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOwP0-00000009ZtY-3nMB
	for kexec@lists.infradead.org;
	Wed, 03 Jul 2024 09:35:53 +0000
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-24c9f892aeaso2500023fac.2
        for <kexec@lists.infradead.org>; Wed, 03 Jul 2024 02:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719999349; x=1720604149; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ewOTsQs7Dh/s9g0htpLiAZ9Zrvk13brvrgRs5kRd2wY=;
        b=XQMwh85qtSG1CYc4Jb4TQeN1R4v0+bG5QXZqrVXxwXX0cRQRu4gRPbrkGCNNo8lej6
         rqpcx8VjyVb/78CYVX5VXuHD9FGto/RSWOVjFYAkTdw+B8yQWvT9S+Pcb2i9ukuPVJUV
         hhLu+PEXM4tdY9vBSGrwdQYAgmahcEd1HMdm/uqjchmg7n/RvBmRglPhjmvBGg3j6g3O
         61cN6IFTcchfSTVI991nW84MQPTiGX5DGVwaO1yGYO+S4mOifQfqaQTWWrvAjmJWIL4F
         xwhvwEDkWDItHrjD68tSbw7C/p28nVHCHgfrg3ePjO0JzvyH1zjknqo3ZYwiUo5A+J8I
         aQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719999349; x=1720604149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewOTsQs7Dh/s9g0htpLiAZ9Zrvk13brvrgRs5kRd2wY=;
        b=VXL3EOKL8CikWBye02mO2+0Sn35nj82QAFfJygYpeakge5LyeVMx3F5SSFXZGJlKLm
         4MHJYeuHC0c6tCL9JzO8ZPp8AEI42wYKNuhPp64BiyAvBKLeg3kbwcLFGue4kj8ERAOk
         PH6duY2ux0eJCZrezdBPt1Y5PdaeFycX3QlIQNjHpFgUoK+ML29E4PYNnhJXNrU8u/8/
         /AJFfJ5DAH/KcRm/AahQRzvJgu5I0hWYLRYVnIK54iuvIxji76p18RVdXLAyv++cpEbP
         wFZXUId8K2UhH/AhMHKnEGmUsKfb/yjOi77SXPPOSBDM6G59YkvvkKmcmJe4pMEqSe/E
         r2QA==
X-Gm-Message-State: AOJu0Yx4hHThkQJvqfXRqsdN6/Fsfm8Tn6vYj+AnA7ACbMfjAxfIBvGL
	TwOxNWGn+XR83YE1GZKFlFlBdGITBxwl6me5EDwsEXKJU/y9oRk9SrnwfOjEWN4=
X-Google-Smtp-Source: AGHT+IG7Fek5s1ebX2jhJYVxA6ULWO/NpR9m/JOExyTrTDK0hgepXZermmGQVehiH1plFKSVh5C/Zg==
X-Received: by 2002:a05:6870:b250:b0:25e:101c:28cf with SMTP id 586e51a60fabf-25e101d419dmr947169fac.51.1719999349407;
        Wed, 03 Jul 2024 02:35:49 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044b1112sm9963220b3a.182.2024.07.03.02.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 02:35:49 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] crash: Remove duplicate included header
Date: Wed,  3 Jul 2024 11:35:18 +0200
Message-ID: <20240703093517.730559-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_023551_090554_61D1DA8D 
X-CRM114-Status: UNSURE (   7.90  )
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

Remove duplicate included header file linux/kexec.h

Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/crash_reserve.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5b2722a93a48..d3b4cd12bdd1 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -13,7 +13,6 @@
 #include <linux/memory.h>
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
-#include <linux/kexec.h>
 #include <linux/kmemleak.h>
 
 #include <asm/page.h>
-- 
2.45.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
