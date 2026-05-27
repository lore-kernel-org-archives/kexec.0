Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78FACD6E43
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 20:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yM8dMZ14jd8XfzqLrOXjgKwSIjFfEWKpVFgfL5nrU6g=; b=CoJafMkZIukzo3XOL/9+3PwVV0
	LnOdF1kfsCCIfAp5R53CmLyqpndjEyBME7cUo/hrkSKQOGCHCb59pwjWxzGHuEstC31O8aT93NIRA
	FaUcKmK3b6btO8NoxSS93ORGP6hmpZMP7sZ1M/KhHxW7y7gJMwtwk5P1RPSsya8e2ef1EXzg7Ax1b
	mGc7BoV96FkDRK0Lv8IkgP6XyQGtDWnV7rMLKd9NNsxuYwRL2xwm0bM2rknGmnahHzsxFQo7pm3yI
	u2tMC1g4L49LRWS1PdunmArk310kA1wV9OsYIkF/gR1pk1X/2W7cr2bgvApCX1GUBzWmBiOE2OMNa
	Oq6rI5FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSKqz-00000004idi-2pVv;
	Wed, 27 May 2026 20:27:49 +0000
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSKqx-00000004ib4-0K2R
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 20:27:48 +0000
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-516e1525aa3so51539001cf.3
        for <kexec@lists.infradead.org>; Wed, 27 May 2026 13:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779913666; x=1780518466; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yM8dMZ14jd8XfzqLrOXjgKwSIjFfEWKpVFgfL5nrU6g=;
        b=AdJF5Zapz19ypZYRox9wAYbciGDlRb6Y+S3TrGFauhV2ZiBZBmvd3a9VGLRT4+ShAS
         pXHhsyOnzVsSqGBsZvHYq26t/TdKlquTIZTn0fueNK6HK85QK9819tV8SPYM4dzAmmbx
         Fi6VHyqCmzNwaC7H84QhPTVL6V7Uf+717LA2lkywn3RkA+mSOdWEV796pq2o5+/gYTBb
         +sEetScPmw8On8iCb76FVv23lcNPXaicYnd96JGVc7ZDHWoMKrF2niN3AxWxJmzVKV6p
         YAw+vVwXHuqFR9P3uA4w146+03gXhPmYZ6ZZT+UTu0Eae6EOkDQgLht4StjqhqvkcO2/
         izNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779913666; x=1780518466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yM8dMZ14jd8XfzqLrOXjgKwSIjFfEWKpVFgfL5nrU6g=;
        b=lPcjdlKETeUgA4i8zpw9pgo4Pk4jZ32Gi3uX/ldch+DEi7gLLEl4FCMYbiu0iCFcNO
         iAAhzzsWD3UFTdUNijaYnt+vGF833WVRpcQpBtYPF3219/cCjhCBYHpdKer48h6vQHd4
         VRsRWPrD1dV+YGIiLO1U9hAUM9Biz09cPyHIg9rUnH3IvDnwbfCYBu7iKHmssMScUsKC
         Pv+Uto9fd8UXJCvm3FlaIiBfqice/aEU7k53V4GeBkOzYPDVWlXaeecELRGGF40xyJiz
         VzLOAgvDGdtkfVEeMYun+ApB8IsCCZxAlFCCLtfaSxRE1KhEPsUni4zIXLKzpTmFI5vh
         fX/A==
X-Forwarded-Encrypted: i=1; AFNElJ/vhmKCAxzrz9KDQg7Tzw1zv/KGxS+w37YFF01eeu0v/9wDwxeWxnYd1S73qPrUqA4Rv/RcMg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwqcZjWmxYqHRzFArPP/YRY7yDnFQXW2VMP+/Stro4vJGYmmzy+
	nAU4PgN+2Br5/50luinFrZbpJ6agNUkzq177IEdcchWPQVHemOKTfZcekoubx7a9Uuo=
X-Gm-Gg: Acq92OHdlCprOf1E6bcQ15nm1+zFt7tkEg7qJLk0ua9t4ZJgbtBGXSWPac5WS6fOdDL
	Se1eAyTJZoILhzU3t+j9h2yPSXaRwbWZvI6lAOgNLXgSOdKbjb6RKFcT58gAvDQcNDbmuE0e2te
	XAa7bHM0lWeG9ubd3pB0Z5aqA8W7sYQAiBdkCy1Dr9KDf8hkuHlqm5fH71OGPaNEmoJvuIxXEJI
	AkDyuTUIcF6qt8R4yv889QAhn/JwUd/V0EBJZ7c4ia/J58K//a8ysZa9UqPUowyiynpC5w2OjBc
	w9LX3mLKp15kl2+iGiI12tGwWDYv1uGIKVfYJUpPH2IOIY/sjOltkAilw9gJ2sjElYrGMOhzFWe
	GRaJsA+9nwnfXYpN5oQnYUbTE7BJXH/rbPgijKusNV1Mydd4cFNYFx7IMRTuq6g7xhP5R1v8ivV
	He1vCRTGKwVBblhq0E6fyyDkNjEWepoW5+lpPQqbn41A3BeKpOl/h3QsywPGcRRg==
X-Received: by 2002:a05:622a:1b27:b0:516:ef49:f6f5 with SMTP id d75a77b69052e-516ef49fc35mr220633931cf.39.1779913666151;
        Wed, 27 May 2026 13:27:46 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517069ecb93sm58632971cf.4.2026.05.27.13.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 13:27:45 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: rppt@kernel.org,
	sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	error27@gmail.com,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	pasha.tatashin@soleen.com,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com,
	mario.limonciello@amd.com
Subject: [PATCH v6 4/5] liveupdate: fix u-a-f in luo_file_unpreserve_files() and luo_file_finish()
Date: Wed, 27 May 2026 20:27:36 +0000
Message-ID: <20260527202737.1345192-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527202737.1345192-1-pasha.tatashin@soleen.com>
References: <20260527202737.1345192-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_132747_122425_43146409 
X-CRM114-Status: GOOD (  10.23  )
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
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
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


