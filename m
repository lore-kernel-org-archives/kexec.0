Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137D1CD4F3C
	for <kexec@archiver.kernel.org>; Mon, 18 May 2026 12:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FzXio5kQHzeVIOhB/pKbYB/Pwfwt4Oy892xKhUGnkRQ=; b=Iy9PHRsF1oI7PZgpRskRsfkqES
	06opuwbTjjRqAanbfdaEYT7DqmpHlwfq3v26dWak8qDeB/cpl7Tt+bzjl14x3BM0ab07i+PLeY4z3
	zvmR9OZU5DmQTuJ2ra1yBI5OxUBvejBT4cV85NG/ZANl5Q79mPHYB3qG+tn+BZ4zBH4I6ZoWT0QEl
	IMg7XBc6jeaXa9g/+GVidVYsYVG2dqKGdtAbid1rJmC7V7AGTODB6PadYE2mCNuvgKvPbVARzCI0M
	15In+6Ofv0Iac3v1eZH924M7DH7P4996ljg5t7Ki8vqPaBHHU6fGQOMXVhh04kwI20NTqG29mig1T
	c3K0E/Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOxV1-0000000FiLZ-0GR3;
	Mon, 18 May 2026 12:55:11 +0000
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOxUy-0000000FiIe-2NwP
	for kexec@lists.infradead.org;
	Mon, 18 May 2026 12:55:09 +0000
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-8bc3ef10cc4so34365986d6.1
        for <kexec@lists.infradead.org>; Mon, 18 May 2026 05:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779108907; x=1779713707; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzXio5kQHzeVIOhB/pKbYB/Pwfwt4Oy892xKhUGnkRQ=;
        b=bG586xN7q0p8fzJVvOo6ZptPZqFfypL1QCA1lfThfPWZyL9ImS4J2+kDPbi8xX7QMc
         RvKhwc+8sxrevYnUhdQ1cX0tKm7H0ZZOc+aH2Rl3hEWa76/fMNUsGVEMMxyNfI2jnO8M
         XqHSAuETcGh7OQEyJCVHVyZSWGWbL34uhXmfTrUWiwUIVvdrImsPAYJ1JOMgjeLwYYwM
         mI30LJZ5m7e0ICWp8y/LoZoihevUF5EU50ZL+OorXft9jdIl3utAbti3l6v6xtL+1F22
         HRkyXkHHvrel1ZyJfuA2MvsmY8AR+xNh0XCjhPZlVYVpTzDo53Z+5kzy4KqgHY4OsDi7
         pxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779108907; x=1779713707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FzXio5kQHzeVIOhB/pKbYB/Pwfwt4Oy892xKhUGnkRQ=;
        b=WERdT0QBXGrSfMmhmY1KfAMiAqREUAURXWUMwlZhBRYFWnh27SWS/1g+BNPCEZGjeG
         tif3+c40zh6Uunw3RB67yBl6USUG1bCpIboZmk3DkEoqGiOM9PWPCgsf7MF4Ei/g4Q8F
         dx7ydEmgwugWF5CLxtVU8V0417yzNzWKfPSIvF4hvXrD44B1PdJfa3zEZ18AnYOAg4PT
         bFo8UIEhA6RjnnYqlzDkwO0IjDifTdLkE86vt1pdrkPVDGL7c36v3fDB5CbB+z/PvdoB
         yzo3MYR1knqjF9r+Mwv5/vvPN2m9nWIsEkR/IVnwOXa3+vRA6Egjwt7obAOen9IJuy47
         /dAQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xb6L9QptfsMeo/JcwzUl2j01oJh5xFOnGXeG1aCQZaMgJqOx0VncS4+K+QMlBmWbnnC30OA==@lists.infradead.org
X-Gm-Message-State: AOJu0YysOI6AyOgGfEBUIlFpfDa19eAURZgYndpsrqkHXRjqhKgxUZvp
	lw7O/8trtawWf/TZIu4w9ZgM4w8rnqMH3fdoKWf5VGs3QykovbFQo30o9bvgge/f57o=
X-Gm-Gg: Acq92OHVW8wpGcXR7kzMv6v56OUAsVh9D/6oDnyN8YEqEjcJgthbNwcKGBqMq7jJXj3
	EsAbgGWjQca+nvbuE0Z1YWfZoxpHCet5S/ptkhF2wFKYDu+u/+G+mxd4X68bGC95jj6f1zLNuBn
	BLAds1tVKjylLz8gsOZkZ4nWg8hw/UZz9qL7/xPvkVSGtQ9UWs1k1sEsmsnbihmDLotoU3XBBqR
	7ZsWknHSM1u7IQzUQ00GWfuhrCEJ7Kvob676PVdCBsEXu8BGvjZphTLa6qE3ANub287B4fJgb5Y
	IEx0S38EXJthfzyDVbizWtnPBL03qvKlbzOxvf3tw5u3rNnKix+I+vHfxRq+scVsZq1YObDuIl0
	13jzc3qzH5WqdqcN4quuPchM+YuGdkOgAf5mJVGhXVbBFapvhEjWgYMdKgxRSzRp1NId7zlAOLL
	yYwBcR2O4X9Oc8veQ2DLdpa+d9S64bZIbBCcKzMyluUiKvl4zaoLU=
X-Received: by 2002:a05:6214:3a83:b0:8ca:ee3:6ea9 with SMTP id 6a1803df08f44-8ca0f6285cemr250260446d6.20.1779108907114;
        Mon, 18 May 2026 05:55:07 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca3608c1desm54511756d6.2.2026.05.18.05.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 05:55:06 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: rppt@kernel.org,
	sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	pasha.tatashin@soleen.com,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com,
	mario.limonciello@amd.com
Subject: [PATCH v5 4/5] liveupdate: fix u-a-f in luo_file_unpreserve_files() and luo_file_finish()
Date: Mon, 18 May 2026 12:54:58 +0000
Message-ID: <20260518125459.1092373-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518125459.1092373-1-pasha.tatashin@soleen.com>
References: <20260518125459.1092373-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_055508_633184_AB9430C1 
X-CRM114-Status: GOOD (  10.08  )
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


