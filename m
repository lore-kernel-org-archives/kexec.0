Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D6FCCFA13
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 23:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x3HMy/5x+GTu/U/2MxeUBt4BoOwWC+Ga4gJ09h6qLJI=; b=gzk9vGpXiHsJ8Jj5U447qLVIYz
	yShs6Pr9c6kYGMPiA1Z5FWKIRMGUlPdoBatmYed3JzRGnds7qfRZK1ly9s3dlfgUd+/eFJOIkyxJW
	AjCABG7/0G2Nr8rLBDphsSrPhSjmT7ysFF0mGUQe9aD3riS6U+P286EBc4VXz15vt/F0v2XDqptW0
	dyl4p/yFz4QqJWjOQN46oxweMrPZ1hPi9RbURBNZNFy0cbhWRgOhkWKkJinhiW2FE+j5BnHOKLKc1
	ZBqjY9D4uLykNeUtqHblPU266AbQbQbz54ofAsMqpQQIPzzIJ4sRnT/h95sTxM7vq4QS1OGgmKVET
	sZZ6r9XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIxXi-00000007qrc-1wmY;
	Fri, 01 May 2026 23:45:10 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIxXg-00000007qqw-29j2
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 23:45:09 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-83177129e28so1037820b3a.1
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 16:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777679108; x=1778283908; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3HMy/5x+GTu/U/2MxeUBt4BoOwWC+Ga4gJ09h6qLJI=;
        b=TZ9T0AtcefL8dcxY/s+SnkRysF+ICnqi1nZGvetINN7moFDl6IvGvOL0i+XkkncJ/5
         haVFwfqzWEdJPRJpOeV2fLhxBSx2tVDiTj8QeeDkgbbJvCOS6sbb7IUGgcozskiNUbPy
         Myph/OBVuaVMLVrlE8E2+l2mL4YM2vW7TUbBoiHoX39RWM5qAyYYrNDty1Hj4aszThde
         1DQZ9Yr7bXGRAfNfYlBfhFDa20uhFSsQGfteKVZyD782Ubemb0c9Wo2uodffpPQ61ZHb
         ABC/OdXM5nBp+EYrIhqLCnGKxZ6r9rjWoHKF0l8EJbCnhjFn1O0CovU+rCKwsJ4djyIx
         NpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777679108; x=1778283908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x3HMy/5x+GTu/U/2MxeUBt4BoOwWC+Ga4gJ09h6qLJI=;
        b=G5DUmMVgJlvfml1ravrOOeOEI55s5Ai+ETrnetfXRP14X99nfiZQW1fIqe4ocgdipL
         BwF3Z4uP67LOOopDf7Ws2bXlM3PlcvLdf63+lOy/79K9Szsm/5IEvZiwLbTllPXLRWQ7
         87+CsFteTevPiqci4JOsY6uvrCChzX8oMmX4Vx0H7wQIf8mc65afLFjVTCepONZS/3YN
         W/56ZPCqgrvawXNIBEKeuHg5SmEN381PgS30++Kuczb2krlHxcuU5yjb2wc+nJbqr8vD
         O4gOfCY7zT5KZbZxZzQDf0s9YfRmgZZONGbRn8V6op3nsaqQ0cqadAYB6I+ukq0EcXbE
         yFqA==
X-Gm-Message-State: AOJu0Yypf8TIHL2J3bDxR3KGsPWvp74oFYaWebtDLCGn+08ljpoJCiD3
	scKt7Ap/YGQ+4tDPd+uugNRPrBVvEPqUFJ5XWDZ3DibO/x1AtdnfptEoZGj74OTWJUyJCg==
X-Gm-Gg: AeBDiesDq1nDjJwQAzLHYVjTSwhEV3Zg2Bcl7JD98IGQaPWfBA8WsD5rZrUWEBD5nTy
	tFbKzgtr7VXVfsGb7Gg0XrXWZWdluQabtTjdT9leAoogYC/I5N9Ahq5e98nIGqrjtYLmcM8OC3U
	fz1bMCjFlBZwxkvmbkmpQl38CnH8X4gme7finZpnhihKDTK/p8Psp9O+UwZI3HYI/FRuE0D4Jm+
	2ag7K29T5/HOGeqU84AuKYtS/4hGFgO1G81HDPAZnS0ln0KILsYYP4zBTRC3GQksgrydK2DpqLT
	1GSZyYHKc7IpVry7J/RYfP3EnLsTv0A3sL6Ig68aCAjOzE+z+3zwTdqXVKwxMAbODRCb1fv0x5Q
	pm8JODe9IT4jNvIwExvjRkYAKpzn5mReUzRPqy8+a+npsZZG4W/Ge73cgqtOZYRRGsQa4/w87wE
	Sj8I8cpmPYCyGnFyahLnNVMEZMscqQKw==
X-Received: by 2002:a05:6a00:4c1c:b0:82d:5da9:adbf with SMTP id d2e1a72fcca58-8352d2833ffmr978243b3a.41.1777679107458;
        Fri, 01 May 2026 16:45:07 -0700 (PDT)
Received: from localhost ([121.237.249.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b863eesm3448460b3a.60.2026.05.01.16.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 16:45:06 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Coiby Xu <coxu@redhat.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 8/9] crash_dump: Disallow configfs/crash_dm_crypt_key/reuse if CONFIG_CRASH_HOTPLUG enabled
Date: Sat,  2 May 2026 07:43:37 +0800
Message-ID: <20260501234342.2518281-9-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501234342.2518281-1-coiby.xu@gmail.com>
References: <20260501234342.2518281-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_164508_559750_C185663A 
X-CRM114-Status: GOOD (  15.47  )
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

If CONFIG_CRASH_HOTPLUG is enabled, dm-crypt keys saved to reserved
memory will be took care of automatically. Thus it doesn't make sense
to use configfs/crash_dm_crypt_key/reuse. Reserving
image->dm_crypt_keys_addr is also unnecessary. Currently x86_64 and
ppc64le have implemented CONFIG_CRASH_HOTPLUG feature.

Also update the doc accordingly. Note two doc issues are fixed as well.

Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 Documentation/admin-guide/kdump/kdump.rst |  9 ++++++---
 kernel/crash_dump_dm_crypt.c              | 14 +++++++++++---
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 7587caadbae1..73f2e9500c60 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -577,9 +577,10 @@ with /sys/kernel/config/crash_dm_crypt_keys for setup,
 
 1. Tell the first kernel what logon keys are needed to unlock the disk volumes,
     # Add key #1
-    mkdir /sys/kernel/config/crash_dm_crypt_keys/7d26b7b4-e342-4d2d-b660-7426b0996720
+    VOL1_UUID=7d26b7b4-e342-4d2d-b660-7426b0996720
+    mkdir /sys/kernel/config/crash_dm_crypt_keys/$VOL1_UUID
     # Add key #1's description
-    echo cryptsetup:7d26b7b4-e342-4d2d-b660-7426b0996720 > /sys/kernel/config/crash_dm_crypt_keys/description
+    echo cryptsetup:$VOL1_UUID > /sys/kernel/config/crash_dm_crypt_keys/$VOL1_UUID/description
 
     # how many keys do we have now?
     cat /sys/kernel/config/crash_dm_crypt_keys/count
@@ -593,7 +594,9 @@ with /sys/kernel/config/crash_dm_crypt_keys for setup,
 
     # To support CPU/memory hot-plugging, reuse keys already saved to reserved
     # memory
-    echo true > /sys/kernel/config/crash_dm_crypt_key/reuse
+    # Note if CONFIG_CRASH_HOTPLUG is enabled, this API is totally unnecessary
+    # thus will be disabled.
+    echo true > /sys/kernel/config/crash_dm_crypt_keys/reuse
 
 2. Load the dump-capture kernel
 
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 36e51807d94f..7a7cae17f578 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -304,6 +304,11 @@ static ssize_t config_keys_reuse_store(struct config_item *item,
 	bool val;
 	int r;
 
+	if (IS_ENABLED(CONFIG_CRASH_HOTPLUG)) {
+		pr_info("CONFIG_CRASH_HOTPLUG already enabled");
+		return -EINVAL;
+	}
+
 	if (!kexec_crash_image || !kexec_crash_image->dm_crypt_keys_addr) {
 		pr_info("dm-crypt keys haven't be saved to crash-reserved memory\n");
 		return -EINVAL;
@@ -486,15 +491,18 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)
 {
 	/*
-	 * For CPU/memory hot-plugging, the kdump image will be reloaded. Prevent
-	 * keys_header from being cleaned up during unloading when
-	 * is_dm_key_reused=true
+	 * For CPU/memory hot-plugging without CONFIG_CRASH_HOTPLUG, the whole kdump
+	 * image will be reloaded. Prevent keys_header from being cleaned up during
+	 * unloading when is_dm_key_reused=true
 	 */
 	if (!is_dm_key_reused) {
 		kfree_sensitive(keys_header);
 		keys_header = NULL;
 	}
 
+	if (IS_ENABLED(CONFIG_CRASH_HOTPLUG))
+		image->dm_crypt_keys_addr = 0;
+
 	if (mutex_is_locked(&config_keys_subsys.su_mutex))
 		mutex_unlock(&config_keys_subsys.su_mutex);
 }
-- 
2.54.0


