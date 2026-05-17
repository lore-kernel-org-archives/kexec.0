Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EA3CD4F3C
	for <kexec@archiver.kernel.org>; Sun, 17 May 2026 19:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=29HzJl9h48xwkBaF6APPD+FEfyf2PDWXL3k0ngsRfSI=; b=uBZM8BqljzHFhq4LZMKt/jYYhD
	3GinUCMnqcdDuakV+UdQAanfaYmkizIanXVscZI8z9E5Mndr8ZxA8F18lEc4V3ZymlNcLkgelZA+Q
	Isp0Qp2gxj1+JoEm+nvmhfT9oXL0iPOICagE0R6gz+gUATyRosrCYe3qUPv/jLQCuDbDT704LqfSs
	+jthhLsWi4QU47yYHZgYJk8z2I1ctbc/v5WjkdLwVk7q6BL4zpH2sE5qyX3FDFxW6jfMgotqANS8m
	Ix/Pc4T1U/WsqYdQskCQoAadDXfh1t4/D2F7zWSFfeCtqiVq9P1htkKZkdWv+76c5I8iS6sPZ5mxE
	L+aywkIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOh8i-0000000DKVT-0hAI;
	Sun, 17 May 2026 19:27:04 +0000
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOh8f-0000000DKST-2Hhl
	for kexec@lists.infradead.org;
	Sun, 17 May 2026 19:27:02 +0000
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-50fb1ad3734so30410471cf.1
        for <kexec@lists.infradead.org>; Sun, 17 May 2026 12:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779046020; x=1779650820; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=29HzJl9h48xwkBaF6APPD+FEfyf2PDWXL3k0ngsRfSI=;
        b=dYFJLXS6QVhWhSn9ilQ9NybRZBBbQ5zsJAfgciK3+Lb0wDTVC+FhFm5yGp9RCf9O/X
         LmX+w9R+0O+s44r6d+enDHUbxT+1P/Uiw3Bg7TuFobBPWY307GopquRnU7lQv+0V5Gqg
         RK3Sma2LCmGrBoMRdTb7lIRgZ+GPwhV0q2HyYv4x2EhOljQS4QjO3EHyY+bkdHSltfvO
         cubENfhlMbWSsrN/n6TMHjKWCJD2dPmSIXurW8eu3akV1pES0rfXn3ZZBzGYg8J1/8By
         yw7Ee575qKt7vfvd7ZBeBhO2vPV2H9v+dfotmYYNzqqNLcP8z6xoGBysWIyZH4VCNc9F
         5bAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779046020; x=1779650820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=29HzJl9h48xwkBaF6APPD+FEfyf2PDWXL3k0ngsRfSI=;
        b=D+xbenx+vImy1gvOUAeXGnj+mgDQbSdMa14Cti/UgpvccxEipO8xiIySOb75Q+TM23
         tgIJcvyLf7/hQIfjP7/0e0HBfjNsW6TB+5hSeDiRiv2w/NWuqA3IwBjHXiUcGIFEiKMx
         RX0eMhOZTO5uXIWW2sVckxK5HtWKUKfPykmSL5Trm5meNQdm4xIy0KDH3k9r9xqiorMS
         4MYHmUhXbD3VS3GLO6B8BMLSiw1E8rYDlYjmWnX3ZUcvtPw26PizDUGAXMfyhvC6Oahk
         Ot5zou0QXxdQJeFREfEOvB/SP2aNAMnSZ8E/y1HGYeDMbjF+GNzm4ow3AeoO4ogEJb1d
         yX7g==
X-Forwarded-Encrypted: i=1; AFNElJ/pGXa4+g7gNPRgPRKUAGulMx7sC2h8v9RKlSiR5BHlJHrkqrHflTlWZ5TNs+V8BVcNtA7T0g==@lists.infradead.org
X-Gm-Message-State: AOJu0YxPtWZVXFxqoRuCYaEeQmcazSbSVqDeX7VRYml7JubOqf9pBNJ1
	fxi1bUC1j7b7qE8yKkMp+7B2DmO2kPENRXRnyTiqIO25lXm5Zl6In2Swt2q0Sh4uX90=
X-Gm-Gg: Acq92OHYZJuVGRjc3Y5fyWvNpmXdd1EZyJMtF581Ae/1NaQIqtMaWc45cwAufaqd9kY
	fV3ICFkpOW4btjUEEfMWADuKM8/hitnXPRZYefRKK+lKRKnphvFPmT8N1S+mMmZbQZmqw7+ANSN
	lnyUseYqJ487btB/u880aDlYp7C21pn99zqzMsEf4H+70Oa87xSf2evlGJ2yce1eDZ/RJ2BbYfv
	JAuwWg9v6g0k80jwfVHK/P5UKDnJR1dE30/WpziZQV3MxNncVKt0EMQyrrx9/pj0ne/DCOUxfVJ
	s/r1SMgCP1axQ8XRBph34xJali5t3fG0f2UoOvs/1MP8CcofwAFdCD0pKe5TYG+hh1ZYNdo+4pk
	qSPrASi+ykJaJe7fCvnwWxx5QoFi0KFo6pd9jMcs054QtfvRjLzmVgfXfieEWZngJv3oetefncu
	+dwvS+5/WXIkb0FVT4nr9fOzx0pUvjc3gX/XHHhYgzISqb1S5JLz4=
X-Received: by 2002:ac8:5913:0:b0:50d:a8bd:dc07 with SMTP id d75a77b69052e-5164193a473mr218531351cf.35.1779046020429;
        Sun, 17 May 2026 12:27:00 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456d5c4dsm108828621cf.12.2026.05.17.12.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 12:26:59 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: rppt@kernel.org,
	sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	liaoyuanhong@vivo.com,
	pasha.tatashin@soleen.com,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com,
	mario.limonciello@amd.com
Subject: [PATCH v4 4/5] liveupdate: fix u-a-f in luo_file_unpreserve_files() and luo_file_finish()
Date: Sun, 17 May 2026 19:26:49 +0000
Message-ID: <20260517192650.1019314-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260517192650.1019314-1-pasha.tatashin@soleen.com>
References: <20260517192650.1019314-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260517_122701_584899_2216B2B0 
X-CRM114-Status: UNSURE (   9.45  )
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

In luo_file_unpreserve_files() and luo_file_finish(), reorder
module_put() and xa_erase() to ensure the file handler module remains
pinned while its operations are being accessed.

Specifically, luo_get_id() dereferences fh->ops->get_id, so the module
reference must be held until after xa_erase() (which calls luo_get_id)
completes.

For luo_file_finish(), this requires moving the module_put() call out of
the luo_file_finish_one() helper and into the main loop of
luo_file_finish() itself.

Fixes: 00d0b372374f ("liveupdate: prevent double management of files")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index a0a419085e28..208987502f73 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -385,10 +385,11 @@ void luo_file_unpreserve_files(struct luo_file_set *file_set)
 		args.private_data = luo_file->private_data;
 		luo_file->fh->ops->unpreserve(&args);
 		luo_flb_file_unpreserve(luo_file->fh);
-		module_put(luo_file->fh->ops->owner);
 
 		xa_erase(&luo_preserved_files,
 			 luo_get_id(luo_file->fh, luo_file->file));
+		module_put(luo_file->fh->ops->owner);
+
 		list_del(&luo_file->list);
 		file_set->count--;
 
@@ -677,7 +678,6 @@ static void luo_file_finish_one(struct luo_file_set *file_set,
 
 	luo_file->fh->ops->finish(&args);
 	luo_flb_file_finish(luo_file->fh);
-	module_put(luo_file->fh->ops->owner);
 }
 
 /**
@@ -738,6 +738,7 @@ int luo_file_finish(struct luo_file_set *file_set)
 				 luo_get_id(luo_file->fh, luo_file->file));
 			fput(luo_file->file);
 		}
+		module_put(luo_file->fh->ops->owner);
 		list_del(&luo_file->list);
 		file_set->count--;
 		mutex_destroy(&luo_file->mutex);
-- 
2.53.0


