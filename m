Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4F5C61DD4
	for <kexec@archiver.kernel.org>; Fri, 28 Aug 2026 08:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=98FM7OwEdWtbjVwbuDejaA8Ps6Cp5ON7omxkAeCAgdk=; b=b55EkGsa8e060YIYIaE9aWPGG/
	/xlWXQ9z8wh6QIIxm0oHDL/UJrR7dz5itC8329ZN/A7YFOJUvg1vokIU8dd2cVq5ROcOuo5BI4G8l
	+IrozsfT2/8pfzOmVUIbccEiAGDKFsZr8fcGIvvcsJ2fqjFHyCsxtFcNw56MMZjjYM5MzfYrLK+WP
	DdRIV7tJ01DBJDlDUQiEByEhDCaGv1HHdbQxVmyKvwQ/joiiklSXZzlPqAEBzEsA97Px1FmPCJxMb
	b4cGLskGqcNHtPN+9r+E2xut1HfaVPrx+u14mvYu+afkSag7/gBxK4yzX1wbSj3lnsqG80j0W9E8r
	x3Rq1MCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzsHJ-00000005Lty-3C3s;
	Fri, 28 Aug 2026 08:49:37 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzsHH-00000005Lpk-2mtL
	for kexec@lists.infradead.org;
	Fri, 28 Aug 2026 08:49:37 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2d71e253c90so7248225ad.0
        for <kexec@lists.infradead.org>; Fri, 28 Aug 2026 01:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787906975; x=1788511775; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=98FM7OwEdWtbjVwbuDejaA8Ps6Cp5ON7omxkAeCAgdk=;
        b=omd75nryNdR7LV/gV4qSQ1NS1sti0yfVT/o10dqyeURYLNaJUXum85H4ZoaXeJbOkt
         vWAtskr4Hhme+dGTp8kYKi2Qt6bfdUhf+Lvigw4+VTO0UvYkZNqeL+Cul5wtC6UuyceC
         t587L54k05aDaMJ+8xHGwc0dZyC847f5AhfUKBHlBPRz4svVfStP5Wgg4ThrUr6SQHgJ
         P33cVSvoGETjzst6bwusaSY6L1dE7OmVUZeo0QHnoqdBRV69O1Kc4MSY1p3iavjHyzb8
         R4Uyo6lFe8pwGtCP9vfjl8HpOLyAvQPNJ7F866eL+CJofLYKDqCiA3+Ul3BIuRezakyQ
         FcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906975; x=1788511775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=98FM7OwEdWtbjVwbuDejaA8Ps6Cp5ON7omxkAeCAgdk=;
        b=BBJMSCZdwUCAGUjBcyK+wyx8TxM9fATjmf4cQn5qZvIz7fR1qqAIdtTVge3q7aQbfY
         v/5oSCmz4xz+r2Ldp93WLVheL0YfKyQZR3VbnocESPB45WaErBjgWXfNfrcc8/eRmzPA
         SBJ1E2vXtDft8Y7aHHMjY0wfyeUDWrqwdMjC7xF2H1+ZVcFhSO3FOn9KDf3Z0XW6xe5+
         6P7N73WPv0F2/57NtOg6UrKWnLkQdxCPmlE2SSUR8+n6mWTk73Ft/KheS73KX9exyEnm
         VciUTX19AuoH2lw/OwakqiS63m2wcDk0NyZwzguZnDx3nATV7apxW63WxADHN5OnJqHl
         PGgg==
X-Gm-Message-State: AFuF++k2AxGEKEp2zbo6rl3jNFKlqj1ct0lL3z6BXU9SEBBIn0Ef650y
	379u163UxRNeRpZK2AD3DDRw2TYEjuLndQPIdPMzOnqnTBDVYzrEyXDeuUgj0hUYkUaUzw==
X-Gm-Gg: AR+sD11mxI2rTIwU2d0X+kqSn3UbnWmyZpSDaRSq1AXflKSV3U67a2cu4QQpvqH0eWB
	pqT/xVUjK3zpDphzr7k9DXfTzlCqoIX+v9lWrw/zidT6CMxs/X7Q77EjY2hQ9sDm/ns4liUoEKf
	FwjKnp0Ycd3c5OYxeiIrNBNrcUOcd1FemU5OD5G2U6ZzW/PHpwSJpoKcBgpPmUoKXMrqMHdGKc9
	Ch7ttInF13EJhsuapu4ZWyR0VO+o+5lRFMBDb0FA69gIpd3ljzpHTnOzlBeEj8fy7fwReBbTVQ4
	owN8Vk5rF0NOMa0ywaUqd1KK7icn2V/YETjjdQHqDl5pbBDtaWJvxur+jeojpEZ1dqM1ztwwV0F
	BWgDMhin6HdV5KBKTc7BqNqlTSCX+Sbr18/p3o70HItXC5iK8QfUsUCxwR/R0Qrs5TGbJTyTkhu
	3nSV+JYZof9bXrie3sFx+cheqzrBTF+tR8c1LX0Qqmo2naLzBLRJw1cODAiXI=
X-Received: by 2002:a17:903:42cc:b0:2bf:27b2:4b80 with SMTP id d9443c01a7336-2d74e1386bcmr66616585ad.14.1787906974620;
        Fri, 28 Aug 2026 01:49:34 -0700 (PDT)
Received: from localhost ([2400:ac40:62f:a97:707e:a14f:cfbf:3e23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9ecaa9sm3763938eec.26.2026.08.28.01.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:49:34 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Pratyush Yadav <pratyush@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 8/9] crash_dump: Disallow configfs/crash_dm_crypt_key/reuse if crash hotplug supported
Date: Fri, 28 Aug 2026 16:48:54 +0800
Message-ID: <20260828084900.1496839-9-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828084900.1496839-1-coiby.xu@gmail.com>
References: <20260828084900.1496839-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260828_014935_723788_FC0E8E79 
X-CRM114-Status: GOOD (  15.51  )
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

If crash hotplug is supported, dm-crypt keys saved to reserved memory
will be taken care of automatically. Thus it doesn't make sense to use
configfs/crash_dm_crypt_key/reuse. Not reserving
image->dm_crypt_keys_addr makes it implicitly to disallow using this
API. Currently x86_64 and ppc64le have implemented crash hotplug
feature.

Also update the doc accordingly. Note two doc issues are fixed as well.

Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 Documentation/admin-guide/kdump/kdump.rst | 16 ++++++++++------
 kernel/crash_dump_dm_crypt.c              | 13 +++++++++----
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 7587caadbae1..0bf2eb100a05 100644
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
@@ -591,15 +592,18 @@ with /sys/kernel/config/crash_dm_crypt_keys for setup,
     cat /sys/kernel/config/crash_dm_crypt_keys/count
     2
 
-    # To support CPU/memory hot-plugging, reuse keys already saved to reserved
-    # memory
-    echo true > /sys/kernel/config/crash_dm_crypt_key/reuse
-
 2. Load the dump-capture kernel
 
 3. After the dump-capture kerne get booted, restore the keys to user keyring
    echo yes > /sys/kernel/crash_dm_crypt_keys/restore
 
+For CPU/memory hot-plugging, you can reuse keys already saved to reserved
+memory before reloading the kdump image,
+    echo true > /sys/kernel/config/crash_dm_crypt_keys/reuse
+
+Note if crash hotplug is supported, this API is totally unnecessary thus will
+be disabled automatically.
+
 Contact
 =======
 
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index b7629174e4db..3aaa0f9c3117 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -324,7 +324,7 @@ static ssize_t config_keys_reuse_store(struct config_item *item,
 
 	r = -EINVAL;
 	if (!kexec_crash_image || !kexec_crash_image->dm_crypt_keys_addr) {
-		pr_debug("dm-crypt keys haven't be saved to crash-reserved memory\n");
+		pr_debug("dm-crypt keys haven't be saved to crash-reserved memory or crash hotplug supported\n");
 		goto unlock;
 	}
 
@@ -519,9 +519,9 @@ int crash_load_dm_crypt_keys(struct kimage *image)
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
@@ -532,6 +532,11 @@ void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)
 		mutex_unlock(&config_keys_subsys.su_mutex);
 		mutex_acquired = false;
 	}
+
+#ifdef CONFIG_CRASH_HOTPLUG
+	if (image->hotplug_support)
+		image->dm_crypt_keys_addr = 0;
+#endif
 }
 
 static int __init configfs_dmcrypt_keys_init(void)
-- 
2.55.0


