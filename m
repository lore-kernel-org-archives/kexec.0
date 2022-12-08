Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BB0C3A5A7
	for <kexec@archiver.kernel.org>; Thu,  8 Dec 2022 16:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=34lEA1+CSHJPKOI2auinMk0DvmYxwtxhazahuQ4dasE=; b=hW/pldmadpTfM6
	VymjB4uR3Yq5x7J4Rs1a90BGCG9V78LgvOSybjL3waynR7QwCLF3X2LvKz4aOr8Q4ialAdVkS+MBT
	07L8Hn5m9rLsNiAEGF0fqdgUTfhTs0PTV+vHydz4OX73AKcMJA1SsfIvlmaRDFiIWjKK3oETulmSt
	tA/y8TzDCgureHQhl664ch/HTpIB9SMlHwqt4/UM/oyHlAK3NDaZEKshLXerM4sRkygyW1F1yVWV0
	/QdEFI0Cq+UOfphotNyaKs+EGQYim2TJmS5HulX0V9SOUdv5BZeSRVPVlY0FTVUmOI5x36iLrWqdV
	zV1+tfS0is7V25Qjo+Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3Jup-005NOa-Bf; Thu, 08 Dec 2022 16:38:31 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3Juh-005NBt-Mv
	for kexec@lists.infradead.org; Thu, 08 Dec 2022 16:38:25 +0000
Received: by mail-ed1-x52f.google.com with SMTP id d20so2603260edn.0
        for <kexec@lists.infradead.org>; Thu, 08 Dec 2022 08:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nXDL6kXVne0kc9TUvNDrggV3hJQmgrUq1c5voIjIIY=;
        b=PojL+2VW16cI+CcvRz8pQZWoBJ9qktlie/qAPj5ucWA5MY8xtpgOHHVDVRU5pAe7Ce
         nDMmiPUpy0eW53Q6kW23pyE7V2lP4nW7AbwoIeQfkrOqyTUr4G+BupC0g3nDqnKbB6sP
         ldvNVDRaqGjV6SEVCCxtCFgoIT/1ss5WM32c0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nXDL6kXVne0kc9TUvNDrggV3hJQmgrUq1c5voIjIIY=;
        b=DICnDZvU/Ao3YqYbFXAD0BGKD7lHxRV8R2V/yNaARIUv+YwZGCVW3/MxyLsIEE5QN1
         eYEwdfz4G7mMtiXyc+T+sWfecE8YCk2ONHqI7VXObnHIelAewoe1oxkHTGcd7wvFFUJP
         DQU8peILETzYiJFApxtxBwAl6MRtRVaQWj7MRbn/3YRBfVoHfQ4AYpRye7QaL6mSxBiH
         dEboGnmdrsBAg7CGltZfOP9j6Qo9ttj6SL0kzyl7ZtnFaVhiQhgkee2c+kFTcapR8a/b
         pmM1MsZ+UHe54uUf8B18sShDlCOuQd5DxPzrVc/pElOMgn/95kHNi+Os47WpSVSplKYO
         ec8Q==
X-Gm-Message-State: ANoB5pkp00qeVNHMmTbbUxXFWj+6aU7dGJ82FMU3yj8KLNixsNpjJ4ED
	Jbw5u4+q4DyOBeSQlQ7C7zKbLA==
X-Google-Smtp-Source: AA0mqf4CXQQmQaEo4whtEenrTv1AF48ud3Wm8rJD9/sh1MVGHJSDMD4mFmnIAgfRq63Kr0Qkr+X62A==
X-Received: by 2002:a05:6402:4284:b0:45c:835c:eab7 with SMTP id g4-20020a056402428400b0045c835ceab7mr2555836edc.37.1670517499837;
        Thu, 08 Dec 2022 08:38:19 -0800 (PST)
Received: from alco.roam.corp.google.com ([2a00:79e1:abd:5c00:8aae:c483:8219:bdba])
        by smtp.gmail.com with ESMTPSA id ck3-20020a0564021c0300b0046778ce5fdfsm3569046edb.10.2022.12.08.08.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:38:19 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 08 Dec 2022 17:38:02 +0100
Subject: [PATCH v2 3/3] kexec: Introduce paramters load_limit_reboot and
 load_limit_panic
MIME-Version: 1.0
Message-Id: <20221114-disable-kexec-reset-v2-3-c498313c1bb5@chromium.org>
References: <20221114-disable-kexec-reset-v2-0-c498313c1bb5@chromium.org>
In-Reply-To: <20221114-disable-kexec-reset-v2-0-c498313c1bb5@chromium.org>
To: Philipp Rudo <prudo@redhat.com>, Eric Biederman <ebiederm@xmission.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>, kexec@lists.infradead.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Ross Zwisler <zwisler@kernel.org>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=5820; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=ufAC+5YemcJmz894l6PORczSfr2QBpgPQ5bjY5F1p5U=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjkhL1d+L3xiTqMUfLNsBi+qtGpD5Qyq+yPRk8XU3C
 qeZYpfGJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY5IS9QAKCRDRN9E+zzrEiOw9EA
 Ci4347jIGvkhhvZj0crcvK5gwVYFGy86RP/xrwiw1eNsD4O5aYVg/imd6Nc49cl04xIhEeTj/hv1W/
 hkARCp318XqH7yNDOpH5IAE3TKoKalTtEKGbrWCsaD4pCUf4oYuRKqNq2Zu+WFw3/vnGoUXSX9SBRw
 A6HYl93KHYPcrFL0QqE+StFWwWYqBwmkxsM+1boorjoLIV3hL0xZDfMH/o4KY2YK0uAPXPm1WPNc/o
 WZgslC6WHQhWKRowkutP4MCINeOIbd5SCP1jIuukVb4q8xsGzKNlcQ1Hz0vW3YFYWaOY/hsjGzAIFZ
 sUwO7jou4m9QOjkXzctFUIQKWjyTwbwGLHlzxPqWKKvnQ+W+U3yY2a5I7Q3fLpvIFrJoJt505mshGc
 bhBJBXKGorGs4F0nP5F5Evh90AUQsAaNcQgwgnqvqytM+TAzLXSXr57DZHZ/PRRnUEqEOb0J4eZXJt
 IPM9sjrhAmU+Y1/nhOAEN84BmowIsyz8QMjpZkTlALIc29owcmvKAi8DrM/wPCxJJOypZlSY7Lx24G
 FE7KiVsqpaR5KDpx5kK9C3ompKCNYN7PMoySslSGsnpNfWzjC96bSFRJqB2Qy6JR5tBaIIz6Dh0GTh
 b0lX3nfY+sVZ6nbUulNMptRcET51QU4x3Fori81S1zjoUm6JjXW3cuyF86RA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221208_083823_814168_6777D3F8 
X-CRM114-Status: GOOD (  22.41  )
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

Add two parameter to specify how many times a kexec kernel can be loaded.

The sysadmin can set different limits for kexec panic and kexec reboot
kernels.

The value can be modified at runtime via sysfs, but only with a value
smaller than the current one (except -1).

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 14 ++++
 include/linux/kexec.h                           |  2 +-
 kernel/kexec.c                                  |  2 +-
 kernel/kexec_core.c                             | 91 ++++++++++++++++++++++++-
 kernel/kexec_file.c                             |  2 +-
 5 files changed, 106 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 42af9ca0127e..2b37d6a20747 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2374,6 +2374,20 @@
 			for Movable pages.  "nn[KMGTPE]", "nn%", and "mirror"
 			are exclusive, so you cannot specify multiple forms.
 
+	kexec_core.load_limit_reboot=
+	kexec_core.load_limit_panic=
+			[KNL]
+			This parameter specifies a limit to the number of times
+			a kexec kernel can be loaded.
+			Format: <int>
+			-1  = Unlimited.
+			int = Number of times kexec can be called.
+
+			During runtime, this parameter can be modified with a
+			value smaller than the current one (but not -1).
+
+			Default: -1
+
 	kgdbdbgp=	[KGDB,HW] kgdb over EHCI usb debug port.
 			Format: <Controller#>[,poll interval]
 			The controller # is the number of the ehci usb debug
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index e9e1ab5e8006..3d7d10f7187a 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -407,7 +407,7 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
 extern struct kimage *kexec_image;
 extern struct kimage *kexec_crash_image;
 
-bool kexec_load_permited(void);
+bool kexec_load_permited(bool crash_image);
 
 #ifndef kexec_flush_icache_page
 #define kexec_flush_icache_page(page)
diff --git a/kernel/kexec.c b/kernel/kexec.c
index d83fc9093aff..2b0856e83fe1 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -193,7 +193,7 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	int result;
 
 	/* We only trust the superuser with rebooting the system. */
-	if (!kexec_load_permited())
+	if (!kexec_load_permited(flags & KEXEC_ON_CRASH))
 		return -EPERM;
 
 	/* Permit LSMs and IMA to fail the kexec */
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 18bd90ca9c99..7f9d5288b24b 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -952,13 +952,100 @@ static int __init kexec_core_sysctl_init(void)
 late_initcall(kexec_core_sysctl_init);
 #endif
 
-bool kexec_load_permited(void)
+struct kexec_load_limit {
+	/* Mutex protects the limit count. */
+	struct mutex mutex;
+	int limit;
+};
+
+struct kexec_load_limit load_limit_reboot = {
+	.mutex = __MUTEX_INITIALIZER(load_limit_reboot.mutex),
+	.limit = -1,
+};
+
+struct kexec_load_limit load_limit_panic = {
+	.mutex = __MUTEX_INITIALIZER(load_limit_panic.mutex),
+	.limit = -1,
+};
+
+static int param_get_limit(char *buffer, const struct kernel_param *kp)
 {
+	int ret;
+	struct kexec_load_limit *limit = kp->arg;
+
+	mutex_lock(&limit->mutex);
+	ret = scnprintf(buffer, PAGE_SIZE, "%i\n", limit->limit);
+	mutex_unlock(&limit->mutex);
+
+	return ret;
+}
+
+static int param_set_limit(const char *buffer, const struct kernel_param *kp)
+{
+	int ret;
+	struct kexec_load_limit *limit = kp->arg;
+	int new_val;
+
+	ret = kstrtoint(buffer, 0, &new_val);
+	if (ret)
+		return ret;
+
+	new_val = max(-1, new_val);
+
+	mutex_lock(&limit->mutex);
+
+	if (new_val == -1 && limit->limit != -1) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	if (limit->limit != -1 && new_val > limit->limit) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	limit->limit = new_val;
+
+done:
+	mutex_unlock(&limit->mutex);
+
+	return ret;
+}
+
+static const struct kernel_param_ops load_limit_ops = {
+	.get = param_get_limit,
+	.set = param_set_limit,
+};
+
+module_param_cb(load_limit_reboot, &load_limit_ops, &load_limit_reboot, 0644);
+MODULE_PARM_DESC(load_limit_reboot, "Maximum attempts to load a kexec reboot kernel");
+
+module_param_cb(load_limit_panic, &load_limit_ops, &load_limit_panic, 0644);
+MODULE_PARM_DESC(load_limit_reboot, "Maximum attempts to load a kexec panic kernel");
+
+bool kexec_load_permited(bool crash_image)
+{
+	struct kexec_load_limit *limit;
+
 	/*
 	 * Only the superuser can use the kexec syscall and if it has not
 	 * been disabled.
 	 */
-	return capable(CAP_SYS_BOOT) && !kexec_load_disabled;
+	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
+		return false;
+
+	/* Check limit counter and decrease it.*/
+	limit = crash_image ? &load_limit_panic : &load_limit_reboot;
+	mutex_lock(&limit->mutex);
+	if (!limit->limit) {
+		mutex_unlock(&limit->mutex);
+		return false;
+	}
+	if (limit->limit != -1)
+		limit->limit--;
+	mutex_unlock(&limit->mutex);
+
+	return true;
 }
 
 /*
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 701147c118d4..61212a9252a6 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -330,7 +330,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	struct kimage **dest_image, *image;
 
 	/* We only trust the superuser with rebooting the system. */
-	if (!kexec_load_permited())
+	if (!kexec_load_permited(flags & KEXEC_FILE_FLAGS))
 		return -EPERM;
 
 	/* Make sure we have a legal set of flags */

-- 
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
