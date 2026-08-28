Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044F4C61DB9
	for <kexec@archiver.kernel.org>; Fri, 28 Aug 2026 08:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3ic1yrNDonznjqguqtqXp54bWq7NGxRiJhvS56iX+0A=; b=ttkMnT9gPrW3LOg1g/eMHoS2cZ
	J7Eq1VGexvt+jIMf06HwkaKNv5L3rK+KDD9aNddgn2F18pinRsUtm4mxGtNLzMuKpY5C/3UeR1Umu
	xaKT7x7UeYfc3JYMSiKjFAIAedphgfwIC49R56DqVteaZGVPktnzXeQKajoOEc9yepl8xmKT0iWAi
	b6wknqwBBHs2O3qfqk5bu9Ga7axYcXINKDZehkhJrrBkJDguKxIl33rwc/WppIOXhpk0n2dJ0eKGo
	bQk5x+pW+0KA+/ToNvh7CCs7nV41IzYAAUoTMxTCFR23GF/8uJY1flKy75H76eb701bIcuUIvfTPF
	EHSsJ4LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzsGx-00000005LRJ-47fy;
	Fri, 28 Aug 2026 08:49:15 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzsGv-00000005LOH-25TG
	for kexec@lists.infradead.org;
	Fri, 28 Aug 2026 08:49:14 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-84faf0fa17eso671463b3a.2
        for <kexec@lists.infradead.org>; Fri, 28 Aug 2026 01:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787906952; x=1788511752; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3ic1yrNDonznjqguqtqXp54bWq7NGxRiJhvS56iX+0A=;
        b=HPGNU5OzPQZBGAWO/ysLQqMY7mdktzGZ94mU6zsueATAhKCKF30MbB1p77FZRJ5poW
         t2p/3OvbGfVEgQvn4KrBab2/lT8/Lay/FH7M6c1GwsXmIUEecmeewYeCRqamq74Png04
         mI+tRAwzHFQNkZXyy0XJ7pu9KBEmbclIERI5vFYgGA78F08moNZlBHALIouoAkuh0kSD
         MOLb6ZCskysY0f60fJxdCYc0OGSFOFaQr9Vc66iCwLQ9qMXWpifSYn3K3q7lxRUIUcaz
         UGb9TlsJVOWTd+oh/K7OdsUBdJVK3LPNicIuWz0VKnSimTqxybHU/LxDhpKPKPEMDHwC
         yZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906952; x=1788511752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3ic1yrNDonznjqguqtqXp54bWq7NGxRiJhvS56iX+0A=;
        b=E3W4MD24AA//qfyZX3+O3TWF1gDaq2tMQP/vIfBnAoPLz7w3OCCvHxBZXU5f/gfvjZ
         Ja6iDlhZlrXhijyBoYgRT9cGWXBDcgokwdjJbaVoTz2JrUgPcd9s5ryk3H7aW2KdKStg
         4/iWhEBpGZ/9MbQ4kBUz5WBytqEGaabKDXm6tPEmtqIht9fTtAPR6mZln+Mcxg7+TXP4
         We/JzChrrM5ZrWSIuWLwMBBtVDvY9CbFqWZdas7UWCNuDXZF7INHycuWcQ0tiLvVvmuP
         FlR2kzeYsWc4IMhkJHOTsQ1tLxe8ZGmb0YQP5btOJ7PfVDKTbISoEK/I16u88hyJ2PRY
         zqFg==
X-Gm-Message-State: AFuF++kuicsUCvvuwMX5qRUyI/q+BH08m/M/FawHbW0oDigBz8MkqbWG
	W5L4++ziIhRRlQcLWj8c3v1TftcP5Innu3jXWhbdQzos85kFhdcknbgOJW8+BeDxoSc=
X-Gm-Gg: AR+sD138hK4GmEkWtWL/SNFEn0LiEfHE9qyHYQdlvS2UrVbbMsc4tvpCCnCy8Aid+xZ
	4hYZevEp9/r/ItuJYn6tNk6OUQeMSNWkXijnZqRelFlepw52fA3yF3wGUq/vZU7H6KGp6Y++3mU
	YmMsvzlv/cedxsMGORaTBr+hO0ZlGiZL2jFO397OfRdo7gxPzkiGAEeniNR+crKHluMwfGJt+UJ
	2xCzBp6Zg9ZZTrm3ZFX8bsxcBz44X5fDngypbCgMPW17tNCuBC+Fsjj8vg6DyMr6U9uu/QOfy4u
	vvSXf951ajS5RNgpzqh4NCw2XD5M6KlVnQxT4y17QHXU176hYElTN03Wa9q6n9i2SX6dp4BCvNJ
	0Ejt/QMKQ69W3uZkbvKZ+GxoQYxjpWNc5GJiPy7sLaY4ZO/A3jZTUARp4m5Wi9O2Z81c0oRJ29+
	v56EbeWzmitgTnmXBcXrrVbskjBjNjdR0FFtfbcIQu/QUqQyzgIaWPhkagD6A=
X-Received: by 2002:a05:6a20:6a1f:b0:3d1:4225:9bb with SMTP id adf61e73a8af0-3d265a41ee0mr9048295637.2.1787906952498;
        Fri, 28 Aug 2026 01:49:12 -0700 (PDT)
Received: from localhost ([2400:ac40:62f:a97:707e:a14f:cfbf:3e23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f7bf283sm3899310eec.8.2026.08.28.01.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:49:12 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Pratyush Yadav <pratyush@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/9] crash_dump: Disallow writing to dm-crypt configfs during kexec_file_load syscall
Date: Fri, 28 Aug 2026 16:48:48 +0800
Message-ID: <20260828084900.1496839-3-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828084900.1496839-1-coiby.xu@gmail.com>
References: <20260828084900.1496839-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260828_014913_554860_C3273473 
X-CRM114-Status: GOOD (  15.77  )
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
 kernel/crash_dump_dm_crypt.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 4335b6cb1fc4..026c7de4ad85 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -7,6 +7,7 @@
 #include <linux/configfs.h>
 #include <linux/module.h>
 #include <linux/sysfs.h>
+#include "kexec_internal.h"
 
 #define KEY_NUM_MAX 128	/* maximum dm crypt keys */
 #define KEY_SIZE_MAX 256	/* maximum dm crypt key size */
@@ -296,14 +297,20 @@ static ssize_t config_keys_reuse_store(struct config_item *item,
 	bool val;
 	int r;
 
+	if (!kexec_trylock()) {
+		r = -EBUSY;
+		goto unlock;
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
@@ -311,12 +318,15 @@ static ssize_t config_keys_reuse_store(struct config_item *item,
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
@@ -421,6 +431,8 @@ static int build_keys_header(void)
 	return 0;
 }
 
+static bool mutex_acquired;
+
 int crash_load_dm_crypt_keys(struct kimage *image)
 {
 	struct kexec_buf kbuf = {
@@ -432,6 +444,9 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 	};
 	int r = 0;
 
+	mutex_lock(&config_keys_subsys.su_mutex);
+	mutex_acquired = true;
+
 	if (key_count <= 0) {
 		kexec_dprintk("No dm-crypt keys\n");
 		return 0;
@@ -481,6 +496,11 @@ void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)
 		kfree_sensitive(keys_header);
 		keys_header = NULL;
 	}
+
+	if (mutex_acquired) {
+		mutex_unlock(&config_keys_subsys.su_mutex);
+		mutex_acquired = false;
+	}
 }
 
 static int __init configfs_dmcrypt_keys_init(void)
-- 
2.55.0


