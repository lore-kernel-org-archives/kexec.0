Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F15C4332F
	for <kexec@archiver.kernel.org>; Tue, 20 Dec 2022 22:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c3UduVoPat8X11y8DdCTS35Q9hZrYys88nbcPS/McXc=; b=ETxNQSeGcszTC5
	dexSvaqVPkX4OiZ9VynavE6HovMcltb5ArdkILWDp1FFWjrqUvSiVY7MnSm+RPta0WN3K7R3WrlWW
	9f3W8Cy93D/k8OT2/3fNUNmViymfowPtdbuPWOLTg5GbybF7CYQM8t1WuwV0M6Rcf9hJ+Oo5ZNwnt
	+fi4TohezuCT3OlGA3yTWne07wPo6Jja2dwtnZXCCJneQOD8nG/9XXS9VU1IQ9SURBSWE+kQmS7Gf
	gDHfBdmwNLvAdShndoLSeDN56ZWAyhyKWrtaMPUBgEvVLN2bKR5ez584An1rJsBTj6NQqSsNe2E8s
	T+p1Up030AhxM4jQfUjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7kkd-004qkL-Gs; Tue, 20 Dec 2022 22:06:19 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7kkV-004qas-2k
	for kexec@lists.infradead.org; Tue, 20 Dec 2022 22:06:12 +0000
Received: by mail-ej1-x629.google.com with SMTP id u19so32542210ejm.8
        for <kexec@lists.infradead.org>; Tue, 20 Dec 2022 14:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A9+UYStnTWSGjcfg6nbEHqd+1X3j3uTcNPeBDTDi2dg=;
        b=A0qO9cEF9BExaKG++8+pMbm2JwjYr+J4MRScp+7250NNGhFaRVBpZSd2wGrXaKkQJv
         92dPcds0K8JnxSa5CreUj8k6FfD1QZ7+0Bx9ilEcxK5izAYSrhJc6XJun92Zh21cuK7o
         cXbXNoBRhc3DCd39gV8gFNMDMakCJHcFOgwP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9+UYStnTWSGjcfg6nbEHqd+1X3j3uTcNPeBDTDi2dg=;
        b=M1+44POK3jzKMNJZ1JMpvI7kc2VXUIc2WagmOLrnePwFdcudggywH4FTjUzv88dMdG
         vhsDbzwpohQVk1Q8r+csz53hbKJanP7q6Djovb3ZdWA8CybMnAocM/eOl5uxoZ3vAM7i
         mghhFtAd4Xf4eoFud9X7a3c2wO2G6jo1nYr4sFOXbKQCLRrrS3wHbXl7xTuvEAS8U3NN
         Oore8FsIUs3VVAYXbnTmD7xhJPl8sgrzFFZ0xVC4ksf4WIlDLIJKghv7uTHc20C8bT1O
         fffQ+8JVXijtsNg05GiWyZyVi3I02td5giGKtAFt6gQoXcmN/tU+G6b+g+hZHaUVC4oT
         TsTw==
X-Gm-Message-State: ANoB5pmwX7x2SNvaQD+d/P4AJbpIvQyOXamuA+CyY8Nh+jCuFb0rhl1t
	UqEVGVIePcBOuqTZm8FrlaVyzw==
X-Google-Smtp-Source: AA0mqf64dw9ElnGy3FTuo16O8Q1TsFPYHKFdEDEaGFCI5s7U/hoqkQIQm/gnBiMQDp/jO6uvS/m7ZQ==
X-Received: by 2002:a17:906:f2d5:b0:7c0:ff76:dc12 with SMTP id gz21-20020a170906f2d500b007c0ff76dc12mr39257082ejb.2.1671573968178;
        Tue, 20 Dec 2022 14:06:08 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id ku13-20020a170907788d00b00837ac146a53sm1175492ejc.23.2022.12.20.14.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 14:06:07 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 20 Dec 2022 23:05:45 +0100
Subject: [PATCH v3 3/3] kexec: Introduce parameters load_limit_reboot and
 load_limit_panic
MIME-Version: 1.0
Message-Id: <20221114-disable-kexec-reset-v3-3-4ef4e929adf6@chromium.org>
References: <20221114-disable-kexec-reset-v3-0-4ef4e929adf6@chromium.org>
In-Reply-To: <20221114-disable-kexec-reset-v3-0-4ef4e929adf6@chromium.org>
To: Philipp Rudo <prudo@redhat.com>, Eric Biederman <ebiederm@xmission.com>,
 Jonathan Corbet <corbet@lwn.net>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-doc@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Ricardo Ribalda <ribalda@chromium.org>, Ross Zwisler <zwisler@kernel.org>,
 kexec@lists.infradead.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=5825; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=Zc/gSka8wOP3G6tsawZGIGKxFRGZrCiyiT4x6FixMW4=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjojHLZcxNi1sPouIXr6mT+V5x5mHvydbMJzCO3YWh
 gn4sbiSJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6IxywAKCRDRN9E+zzrEiDODD/
 0Q4Zvqb8s24SEseZLeUDz32F3wm0l0IZPp1VqYeoxcynPygcG2mdR2kznnMVhzeSL1CU+XTF6+dSY8
 1Fj/VpOcrWHhbaa0RvHl0XLZR63nY9Dhz6vBPjv5fM6jrCT3wpxQEtJPNXQ4PT7CMbWuqYi5JATa7p
 bYpgWNkqliE0ZAMZhxQ/NKaGOPKevRKyVH67KCW/PNn8Kr2f2nupjb5shNblfAOB4GXLUiYQS4s0TQ
 W2qbEzfyepWmZ9lzh77NnjJ4Qz2kxvKgdpzg4vBnz5BxBJBSNRvczvKOm6ayK1G2/rkrklptquK507
 tegnKH4juIa71ObyjuOSQrNf2Vq+waCmtLICjoHuTLxghgmMB/Gow/CD8Nocxx7NgLKkZ8SydPCvLJ
 Ekv/0p0Z/HpMpRWZhpWRDLvQZW6aye8njLrZHZmrLl4WamlcV9wR9ZtcDzGkXhkdyZNpqTiGtSz7kp
 +sUOQkebMUvG27zoDDQ6yRBNFsMVI9UQ471SeRGNrT8JE/JbdjZxCFIBsAKW3XhZBMEjC4HfYd+9Ig
 JEyWhkC8Snqx7AoYJv9E8qcSk9u4TyikYWPeV+Tppef3ZL7FeHki8xlpnHnFbtFL2XJS8I/Ttn1Va8
 yH72bJY+zqsfJ+d/dqdNwU15BYpCt0jFZltT2mb7t10hAYLaLwIsYQLq33hQ==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221220_140611_205301_0F6821F1 
X-CRM114-Status: GOOD (  22.83  )
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
index 182e0c11b87b..5daf9990d5b8 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -407,7 +407,7 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
 extern struct kimage *kexec_image;
 extern struct kimage *kexec_crash_image;
 
-bool kexec_load_permitted(void);
+bool kexec_load_permitted(bool crash_image);
 
 #ifndef kexec_flush_icache_page
 #define kexec_flush_icache_page(page)
diff --git a/kernel/kexec.c b/kernel/kexec.c
index ce1bca874a8d..7aefd134e319 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -193,7 +193,7 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	int result;
 
 	/* We only trust the superuser with rebooting the system. */
-	if (!kexec_load_permitted())
+	if (!kexec_load_permitted(flags & KEXEC_ON_CRASH))
 		return -EPERM;
 
 	/* Permit LSMs and IMA to fail the kexec */
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index a1efc70f4158..adf71f2be3ff 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -952,13 +952,100 @@ static int __init kexec_core_sysctl_init(void)
 late_initcall(kexec_core_sysctl_init);
 #endif
 
-bool kexec_load_permitted(void)
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
+bool kexec_load_permitted(bool crash_image)
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
index 29efa43ea951..6a1d4b07635e 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -330,7 +330,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	struct kimage **dest_image, *image;
 
 	/* We only trust the superuser with rebooting the system. */
-	if (!kexec_load_permitted())
+	if (!kexec_load_permitted(flags & KEXEC_FILE_FLAGS))
 		return -EPERM;
 
 	/* Make sure we have a legal set of flags */

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
