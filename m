Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF82EC79F82
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 00:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PrbS3BESBt65p0R6Xy9pWvWwpzxrdANSE+CV32PeomU=; b=pmXsaPmjm5Hmu+VDsSIVm+Ge+v
	jQQqvFFefVYK5bT2nlqAn+XsiWb580rUoXhXut+m/YJMKrv38fc6EKOxFlQY8o59018maUZVfN2dP
	EG8oT4Ycn0Hl555PmNDuiS+9BDeJHOYKdAKNkjQ4YDy8uvrAzkPr5aBfevpcTN736jcmWty4e/xwq
	fXdkvLHc4ZZ/5b+DYcPHpUQuIOb6oHVuEgjIKVxItGQpdpj+3Q12/FsdY5nBNLS08AIeBXD034nVV
	ucFpuSKr+OAliDBEBwDcFtvTuDBwCQUDResyP+s8+sXEYfMFaGHvhTPBIxCXJBMVbiJcpQb67jRVr
	m1+r0c4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46JR-0000000AVKG-1WMe;
	Wed, 09 Sep 2026 00:37:17 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46JO-0000000AVGR-0pDd
	for kexec@lists.infradead.org;
	Wed, 09 Sep 2026 00:37:15 +0000
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-c9aea40d799so2973542a12.0
        for <kexec@lists.infradead.org>; Tue, 08 Sep 2026 17:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788914233; x=1789519033; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PrbS3BESBt65p0R6Xy9pWvWwpzxrdANSE+CV32PeomU=;
        b=nHVq9JMyxtyRXS6jfyMwpOB8KzcZabpueaHbv5RoOEfGgQqoiNmlDEB2F/k8oTDbDW
         6gFP2F6dDQH9DuMAz842+qXREHorHKy4EsgSssnUOye65nC+Y+4a0A35HIpCvWsCKaZg
         g6o8lwnPbk39ARFge4r9n5PrfHz6lCeEAeetNiZD5eXP9g0lJtw0BrhmI3dzGbilqNIv
         EwV7wr/KZ+xpSVr53X0Te7uJDIzVmYuwTfk0cUcT8BSIyrumd26sCmJY1F1UhwoN7ZsR
         Zqx1UJknfRa5jm3uySG1l+PQe3ZnZFoehll8Bzw4n9GknbJAjvhsR8T4RNtYOm0Vlrqe
         MuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788914233; x=1789519033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PrbS3BESBt65p0R6Xy9pWvWwpzxrdANSE+CV32PeomU=;
        b=sXGPLIiJ/kNOLbv6RP7/JDumqIgEUF6IYAkPbduHXXB2PgDUXQNuqWJAhSkLnC6MhI
         iz0lIx2o2FPTKKLyeAj/X6vlIFSpxcLY81DLJATjQvqqCjeHztx6TfDcSAIp9rttRV01
         TmaCa7BV7mmvLur4YuGL/ciOXyTxSY4aTfbcEHTexiHhiMNcQs4UFKKb771uJKaSMRUs
         DXxCWQgU1VVyU14uP71RqwYIuvoOXaRFsYETo4etX7+vzdnbbJwxPbuvzwRpd5a5D6tb
         2p/mlxohir3vxE7UKwDXswYj3VqW+aXDrWtGvCVdlXP888mCd/C1UnHeOO5heI0xEnkC
         /iyQ==
X-Gm-Message-State: AFuF++lWlB4Q6KcGa7EZfNg7OVQQX25/bEo38YoGAO6cMjHVhBWxA5Xx
	yC24wbZR3fkyerSimUzOgvehFnE1Z40DdNF7WT0KdDpkcriiP+GiQKuNYrybLodmCbw=
X-Gm-Gg: AYBFou0X6N+lU+y1LyPiJFTMIro/xs4nFjDqOCTHrLalRP2a2cb0lGu4l8qhLX5BF+n
	8dbJD5Si410DUMSLCXVQXeS/7o+L0pYPb+SlOjYtGydHV73fuTN+deXgQl6L6mHj/pEMdjeM9h3
	P29FuOuq5QPz3GlfQN4EE0i2+QZuxnNd3xUayjE44ZnvCaATvSbNAqIznsFSlVEPGdGBPd0Nw0u
	x7uyIlUMQCIdL8J9H1kGZaO6RbDnDDtfKkFRD42ckfXtslQpCIAjepdxGSN78ILmMt1H3bYb6wS
	iWBSZwmFcLF30UPoZQ7Xbqn93l0Vq3uATHktIZnUwlC7VrQoiN+hIBHA9yk4GWsMn30YdGX7R6I
	88UDHaalmGoEMqXHMSqiJTZGW/kVP/LTXsTlhjXy8oYHLp31EeBMFYjYAcKp7twe9wdsnKEXvE8
	16QkGHLbXXkwLI02QMe32bNeMsnlV5pkjOclKMXltvH9999eL3aB1xCkjfVvrZ
X-Received: by 2002:a17:90b:2749:b0:398:d292:e6d5 with SMTP id 98e67ed59e1d1-39b26304385mr49122061a91.24.1788914233189;
        Tue, 08 Sep 2026 17:37:13 -0700 (PDT)
Received: from localhost ([2400:ac40:62f:1b67:ddd8:990d:9d6f:13b8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm34284184a91.1.2026.09.08.17.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 17:37:12 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Pratyush Yadav <pratyush@kernel.org>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 3/9] crash_dump: Disallow writing to dm-crypt configfs during kexec_file_load syscall
Date: Wed,  9 Sep 2026 08:36:45 +0800
Message-ID: <20260909003657.1570544-4-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909003657.1570544-1-coiby.xu@gmail.com>
References: <20260909003657.1570544-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260908_173714_232150_49131344 
X-CRM114-Status: GOOD (  16.04  )
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

If writing to the configfs group happens concurrently during
kexec_file_load syscall, it may lead to the following issues,
  - buffer overflow if dm-crypt keys are added after allocation
  - stale total_keys if dm-crypt keys are removed during iteration
  - keys_header will not be freed if config/crash_dm_crypt_key/reuse is
    set true

So hold config_keys_subsys.su_mutex for the entire sequence during the
kexec_file_load syscall to ensure a consistent snapshot. To have serial
access to config/crash_dm_crypt_key/reuse, use the kexec lock as we also
need to access kexec_crash_image serially.

Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 kernel/crash_dump_dm_crypt.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 3a416933979f..580534d43b66 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -7,6 +7,7 @@
 #include <linux/configfs.h>
 #include <linux/module.h>
 #include <linux/sysfs.h>
+#include "kexec_internal.h"
 
 #define KEY_NUM_MAX 128	/* maximum dm crypt keys */
 #define KEY_SIZE_MAX 256	/* maximum dm crypt key size */
@@ -306,14 +307,20 @@ static ssize_t config_keys_reuse_store(struct config_item *item,
 	bool val;
 	int r;
 
+	if (!kexec_trylock()) {
+		pr_warn("Failed to acquire the kexec lock\n");
+		return -EBUSY;
+	}
+
+	r = -EINVAL;
 	if (!kexec_crash_image || !kexec_crash_image->dm_crypt_keys_addr) {
 		kexec_dprintk(
 			"dm-crypt keys haven't be saved to crash-reserved memory\n");
-		return -EINVAL;
+		goto unlock;
 	}
 
 	if (kstrtobool(page, &val) || !val)
-		return -EINVAL;
+		goto unlock;
 
 	if (is_dm_key_reused) {
 		pr_info("Already got dm-crypt keys, please continue with kexec_file_load syscall\n");
@@ -321,12 +328,15 @@ static ssize_t config_keys_reuse_store(struct config_item *item,
 		r = get_keys_from_kdump_reserved_memory();
 		if (r) {
 			pr_warn("Failed to get dm-crypt keys from reserved memory\n");
-			return r;
+			goto unlock;
 		}
 		is_dm_key_reused = true;
 	}
 
-	return count;
+	r = count;
+unlock:
+	kexec_unlock();
+	return r;
 }
 
 CONFIGFS_ATTR(config_keys_, reuse);
@@ -443,15 +453,17 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 	int r = 0;
 
 	if (!is_dm_key_reused) {
+		mutex_lock(&config_keys_subsys.su_mutex);
+
 		if (key_count <= 0) {
 			kexec_dprintk("No dm-crypt keys\n");
 			r = 0;
-			goto out;
+			goto unlock;
 		}
 
 		r = build_keys_header();
 		if (r)
-			goto out;
+			goto unlock;
 	}
 
 	/*
@@ -478,6 +490,9 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 		"Loaded dm crypt keys to kexec_buffer bufsz=0x%lx memsz=0x%lx\n",
 		kbuf.bufsz, kbuf.memsz);
 
+unlock:
+	mutex_unlock(&config_keys_subsys.su_mutex);
+
 out:
 	is_dm_key_reused = false;
 	return r;
-- 
2.55.0


