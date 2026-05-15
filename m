Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7575FCD4F25
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 00:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=29HzJl9h48xwkBaF6APPD+FEfyf2PDWXL3k0ngsRfSI=; b=BVVwyz6SRdJKVxoD3AdlxWDfXu
	xyWOn4R4OzwNV8OFwu9ckJz+s8mfVjBTmVvgodr+o2s9gFJVAJRes43iMsOLJwh4mFgFLajQu6zx4
	Tdd301u5UuRUf39px77HMkC876o8rJMXeSJnG93B/P0eBqFpqN4g+umiekJ7T0gjXYeDdqf6K8bFB
	EO2Aq3GYoNFADzehI7zh0+VuVSs90ciosKOSLCoIWEZ+BAiM08XfE0vTgh/NAM1vYaVc7q4crF2sD
	3uH6N5O0eRjUFqUz1UOV0AU4jY+qcKBJSAT1Pj1zkXhRYXK/FJQ0ql/CltqclMZwITsOzbvmIQssz
	Yw4As5tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNgYW-00000006voT-2Q0I;
	Fri, 15 May 2026 00:37:32 +0000
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNgYT-00000006vmL-3ZOK
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 00:37:30 +0000
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-8b8e98fd885so71991656d6.0
        for <kexec@lists.infradead.org>; Thu, 14 May 2026 17:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778805449; x=1779410249; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=29HzJl9h48xwkBaF6APPD+FEfyf2PDWXL3k0ngsRfSI=;
        b=Zg/BFpzTT6r7zfWlGFwhI+ioC+7/FA8JRlDxHhVxXqZPrWj8wQSDShSKt9LBMnY6aq
         mfSBV5wrHxLDJ5cJy2kdy+Y3pmMdwRUDrF5zTabvoXodhYa35rObuGNNLEOarHpJKZj1
         pEFCa40J17wQJcqBT0AQXym/Gya+m68/h/e6KR26DqH0KJPbP0k6nWiXetPek+CiUWZ8
         sHR9rzIFdw6ZVCqY7N/q4SAH1UJyk6ktf969NzwZe+oSaUeqmaQPf/QFvxXcT8bY3CRy
         EYXYFctbg7hfpekNIn3MeSCM09ENQ5AH6jMQXBqxMN/yvf+Y6wsbT8E15GelfueC5T+M
         boNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778805449; x=1779410249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=29HzJl9h48xwkBaF6APPD+FEfyf2PDWXL3k0ngsRfSI=;
        b=kH3DkpiDu+YFBINUfZY2UrGZ+/m6I0SLIiHWr7RqxKgLNKzM6KhvCWxfBZNpI5Z9z8
         FXxRMFrk7VkWh/0da/YL5V/D8HAP3kxGtG1tiC9nykxto6lEp1PeupR9pfrELib6tpzl
         tYQoyOK/IZZ2USDv6v+rnzl8aFAMR3aUbxJ2wFpCbvYNBgSfKrpIgJd+xOvVByQdrGM0
         Fzr76Yhqecy/Y0RcEbC87iJGCmTtq2++7aUNyopLsjkpOEh1XDcEmqEZ7qxfh2yFvgYV
         nxBdAbKfS/um0A/ZRx3/Nsy6Caqqd68i9e/+Q3tIA5axHRYbo5B0+h+e4x3/RgJ920qM
         PL2g==
X-Forwarded-Encrypted: i=1; AFNElJ9yQHO4lhpsvOXNhCqqMyn4KTvVgLNaSf3vlh0/N6qkPXjNpy+WlkhCPtkQj3KP5kNkA3uyiQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxxmemp7A352Ju4gth7V7C0ZZnjnrKjWTEnXj/cb30djbJ44MvG
	Tr/3H3nsKjabrjxZ9XrR8PQHyCG280/TVREWrzt/bv6Bxd34Bt7CCjk+y58wbZhNCwM=
X-Gm-Gg: Acq92OFbJRWHlJKvdMXMS8BDc7YuALnf8s0658VwPtuq6ttgU1lPgBkK/vbMD9VJsHi
	4vU7kgrC8jxrCb6EL6bYp36DAPZSYea2X8KhoiqB2Dqma3nePE333wxE4BWEdcNQiukIYgIcSDv
	XN6u4evc+OKvh105FAc3kFj/WXgwToP6szcgQee75Gl+NXBCO+2NB8xTgsKlHuQYftr2yYIK0Ux
	7j3vb+u9TqRytEstXf89KCSeKKIXOW6JGAZY3zdA7L+Br3v/uu3z20+/yTj6wSsx5pVJufi3H/0
	YhvaYjOUWnAS+4i5+l4a1zm2MAXqRugXM3Qs1p43OOpS619DuapIhVp2YHiDGHuHp4bRcI3ThBA
	cGJMaUBINm6tzFD+fhRzapj+uuuguJY4oCMq2/Zf6eiZlTwk811bAoFAb+ZK5q0RC4CbAeiz4+5
	UBYUC45MS7mpZX6ycfGpi0bn9VU9Rny09JT/4Pmr6sh5QuZZ7BZTM=
X-Received: by 2002:a0c:f08f:0:b0:8ac:a5bc:a6b4 with SMTP id 6a1803df08f44-8ca0f6f9a59mr28605486d6.36.1778805448958;
        Thu, 14 May 2026 17:37:28 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90c16366csm36918236d6.40.2026.05.14.17.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 17:37:28 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: kees@kernel.org,
	rppt@kernel.org,
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
Subject: [PATCH v3 3/5] liveupdate: fix u-a-f in luo_file_unpreserve_files() and luo_file_finish()
Date: Fri, 15 May 2026 00:37:20 +0000
Message-ID: <20260515003722.938123-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515003722.938123-1-pasha.tatashin@soleen.com>
References: <20260515003722.938123-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_173729_894624_3CB00546 
X-CRM114-Status: UNSURE (   9.75  )
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


