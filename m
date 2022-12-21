Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34239C4332F
	for <kexec@archiver.kernel.org>; Wed, 21 Dec 2022 12:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VylIgI3obkcT3RHcF3cRBT2THb+uMBNSqJjc17fyAQQ=; b=TR3Gd6zVHEEpx+
	loxbHOP0jBnp8a2nFNjewZaacnO41yA05GAoeuPGvvRX7hqr2v4hRcqpldbWRfLmqpBQZifiT3bX/
	pII7S4AyUaZnA9UnbxRMbAkKef5dHHXDEjGobwAdwidDN3jMccKj7qabvEFnR/2Yqwo1BO7aiUv9W
	8e/Q3YXd/g+zWNedbpprWObGdEvHKW2cYQrR1V4ZVC6PZP2P4Ah9m439aEnVBSiJsopXOqRuDnSzq
	kDXOJ/MV813UeO04xh0XHep2Byn2x3REkhLIFcLP15sUh5738+9quPOuVuaNO2Q6K9/6PfQqwGKvf
	bc7Kmvb8lCVKQPeN1hqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7ycc-00EqMa-20; Wed, 21 Dec 2022 12:54:58 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7yYF-00EoWw-5f
	for kexec@lists.infradead.org; Wed, 21 Dec 2022 12:50:30 +0000
Received: by mail-ej1-x62f.google.com with SMTP id tz12so36545594ejc.9
        for <kexec@lists.infradead.org>; Wed, 21 Dec 2022 04:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1DriUQWaxtAZKeveQD8Usa3n+i7++5rOgNlUWHQfXOs=;
        b=nkjhzaUfRMEi9ghebnUaQwIQlmqGl4xjc8nwG5r1nFx7RVq/OgGkh0jCBKHKK2qs+k
         14xwWg5dnU4CT86bwEQDn1LG9qERLW8ndAKUMqCy2i5xS8+uVD4T2/6gXNWJOZvu26XX
         5dGp5u+NNcjcjTS0B8/VOTKEmJclpQ9akydhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DriUQWaxtAZKeveQD8Usa3n+i7++5rOgNlUWHQfXOs=;
        b=ZNoXChjd2P4gfxIGTwKLz2Tt/Ifa5rDtSrSXRZJO4uctyqGSdJJk1kZ3U/C7jVkKt2
         fUIYQhdVGPfH278NBg/TrbPzq7pjm0WUZ/kc9PR1yBF/zWVWgzE2eVHM85p52juPMSjw
         h/yTqFE4XP5kbVwf8LeE0QB3BIVo9tYNPkcOZAnkCmcq5zG6tJg5S89Z7EYcnA9mP82F
         WQT0jqmdNc8NoNjLpKE2dEvNzmOYY9OrAQrUVe7vQdnp+hVZZqAxpvVTfu6qI92o+10P
         1efqWUUiPesdUwCamoEEIGUoxqgO2SG6mfw2MDs3Sb12C+Q0jgmq289NKvOz48EJY/Rt
         KmCA==
X-Gm-Message-State: AFqh2kqC9ynrTwo5Vr8q5N5gQuyaUC/Iu0Dnk3CnI7aL1eooeHUPJp/W
	omJzIWLm6z/fNZs+WXjv316OXXAj4H4J4KMwwZc=
X-Google-Smtp-Source: AMrXdXubmpaQkXCY/pcjrP0p4VqTboCxMP7OcqXLR+YKSG+gRNL96ggpzzXCNhVKoUUnxbzB0dhXdw==
X-Received: by 2002:a17:906:c34d:b0:78d:f455:b5de with SMTP id ci13-20020a170906c34d00b0078df455b5demr1170774ejb.30.1671627020458;
        Wed, 21 Dec 2022 04:50:20 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:4b82:b1f8:cb4f:fbbd])
        by smtp.gmail.com with ESMTPSA id w7-20020a170906b18700b007c0b28b85c5sm7039250ejy.138.2022.12.21.04.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 04:50:19 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 21 Dec 2022 13:50:03 +0100
Subject: [PATCH v4 3/3] kexec: Introduce sysctl parameters kexec_load_limit_*
MIME-Version: 1.0
Message-Id: <20221114-disable-kexec-reset-v4-3-ab809c8d988c@chromium.org>
References: <20221114-disable-kexec-reset-v4-0-ab809c8d988c@chromium.org>
In-Reply-To: <20221114-disable-kexec-reset-v4-0-ab809c8d988c@chromium.org>
To: Jonathan Corbet <corbet@lwn.net>, Philipp Rudo <prudo@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: kexec@lists.infradead.org, Ricardo Ribalda <ribalda@chromium.org>,
 Ross Zwisler <zwisler@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=7163; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=HKgbfk2XXsC7dJWJ3vDw8GvYO5iTUMrHx/g5v9F5/qk=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjowEEp60hS8E28LMGFXbn1WFwG5VJGxaNqKNdEtHF
 /FGZVS2JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6MBBAAKCRDRN9E+zzrEiBgvD/
 4lyll/4tYvAwnei65g8L6jBQb8tXxk3e6u/bUNXDOj7Haf8vDdahHU+mlGE+PpOyPBNd0fGuGj95NO
 d6sAqgfWFINsn+VaqcKkVxjaxauoTEOBmijP2gLSXw9c8582/1W3GGNj35Al0Iuodxz2j3iGyWKjyT
 Z+EOPPHWLTRl7cZ2BZ3jk+3MXFX56jB1CUYfdZsv9VO0P/TZcTDcMYqj9qgNpW6Vwfh/4DFKy/9fvl
 K+k95b02TFli3A21fC1naUP4qd422sPux5aeyvnOgWFOU6+NThTvkwTOZbHGMP57H/NAYIaiGnGt01
 wzkOebsrXbxtVrQKAsfXDlCcVmPb4Xd/0ekTfYvbgpRZLwUUNiqqywGi1JCLGtwcy2Id+Oqdj33WZc
 5dpCialG9rhSxDWOD+MmQfII/oHsQOVFn5RqM9KBQqzpBTCMnNnaXNdQ+786Ru/V1Su+nILm2hnewD
 /R+SRr5FRBfuQFXeRvR+8gXM5U8vS5zywPMFsKfPfG+8Sif+E+e7FjsMEFmjAqYINso2TW/gzus2b8
 loLzadi08rgs5Jz+F2GnykptWff4/WkgWDtXa1B3HfpyVzrpZaDWpTX7lr+J1E3ZqgufLxZxRd3r4e
 JhsrlXmriA5H/FysOlTnhQtCD5ibQAakqRd7IOwlCyYiMGLdzyHYogkucGKw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221221_045027_301054_F7DABF23 
X-CRM114-Status: GOOD (  27.76  )
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

Add two parameters to specify how many times a kexec kernel can be loaded.

The sysadmin can set different limits for kexec panic and kexec reboot
kernels.

The value can be modified at runtime via sysctl, but only with a value
smaller than the current one (except -1).

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 Documentation/admin-guide/sysctl/kernel.rst | 18 ++++++
 include/linux/kexec.h                       |  2 +-
 kernel/kexec.c                              |  4 +-
 kernel/kexec_core.c                         | 89 ++++++++++++++++++++++++++++-
 kernel/kexec_file.c                         | 11 ++--
 5 files changed, 116 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 97394bd9d065..a3922dffbd47 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -461,6 +461,24 @@ allowing a system to set up (and later use) an image without it being
 altered.
 Generally used together with the `modules_disabled`_ sysctl.
 
+kexec_load_limit_panic
+======================
+
+This parameter specifies a limit to the number of times the syscalls
+``kexec_load`` and ``kexec_file_load`` can be called with a crash
+image. It can only be set with a more restrictive value than the
+current one.
+
+=  =============================================================
+-1 Unlimited calls to kexec. This is the default setting.
+N  Number of calls left.
+=  =============================================================
+
+kexec_load_limit_reboot
+======================
+
+Similar functionality as ``kexec_load_limit_panic``, but for a crash
+image.
 
 kptr_restrict
 =============
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 182e0c11b87b..791e65829f86 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -407,7 +407,7 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
 extern struct kimage *kexec_image;
 extern struct kimage *kexec_crash_image;
 
-bool kexec_load_permitted(void);
+bool kexec_load_permitted(int kexec_image_type);
 
 #ifndef kexec_flush_icache_page
 #define kexec_flush_icache_page(page)
diff --git a/kernel/kexec.c b/kernel/kexec.c
index ce1bca874a8d..92d301f98776 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -190,10 +190,12 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 static inline int kexec_load_check(unsigned long nr_segments,
 				   unsigned long flags)
 {
+	int image_type = (flags & KEXEC_ON_CRASH) ?
+			 KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
 	int result;
 
 	/* We only trust the superuser with rebooting the system. */
-	if (!kexec_load_permitted())
+	if (!kexec_load_permitted(image_type))
 		return -EPERM;
 
 	/* Permit LSMs and IMA to fail the kexec */
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index a1efc70f4158..6131b1aee165 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -926,10 +926,64 @@ int kimage_load_segment(struct kimage *image,
 	return result;
 }
 
+struct kexec_load_limit {
+	/* Mutex protects the limit count. */
+	struct mutex mutex;
+	int limit;
+};
+
+static struct kexec_load_limit load_limit_reboot = {
+	.mutex = __MUTEX_INITIALIZER(load_limit_reboot.mutex),
+	.limit = -1,
+};
+
+static struct kexec_load_limit load_limit_panic = {
+	.mutex = __MUTEX_INITIALIZER(load_limit_panic.mutex),
+	.limit = -1,
+};
+
 struct kimage *kexec_image;
 struct kimage *kexec_crash_image;
 static int kexec_load_disabled;
+
 #ifdef CONFIG_SYSCTL
+static int kexec_limit_handler(struct ctl_table *table, int write,
+			       void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct kexec_load_limit *limit = table->data;
+	int val;
+	struct ctl_table tmp = {
+		.data = &val,
+		.maxlen = sizeof(val),
+		.mode = table->mode,
+	};
+	int ret;
+
+	if (write) {
+		ret = proc_dointvec(&tmp, write, buffer, lenp, ppos);
+		if (ret)
+			return ret;
+
+		if (val < 0)
+			return -EINVAL;
+
+		mutex_lock(&limit->mutex);
+		if (limit->limit != -1 && val >= limit->limit)
+			ret = -EINVAL;
+		else
+			limit->limit = val;
+		mutex_unlock(&limit->mutex);
+
+		return ret;
+	}
+
+	mutex_lock(&limit->mutex);
+	val = limit->limit;
+	mutex_unlock(&limit->mutex);
+
+	return proc_dointvec(&tmp, write, buffer, lenp, ppos);
+}
+
 static struct ctl_table kexec_core_sysctls[] = {
 	{
 		.procname	= "kexec_load_disabled",
@@ -941,6 +995,20 @@ static struct ctl_table kexec_core_sysctls[] = {
 		.extra1		= SYSCTL_ONE,
 		.extra2		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "kexec_load_limit_panic",
+		.data		= &load_limit_panic,
+		.maxlen		= sizeof(load_limit_panic),
+		.mode		= 0644,
+		.proc_handler	= kexec_limit_handler,
+	},
+	{
+		.procname	= "kexec_load_limit_reboot",
+		.data		= &load_limit_reboot,
+		.maxlen		= sizeof(load_limit_reboot),
+		.mode		= 0644,
+		.proc_handler	= kexec_limit_handler,
+	},
 	{ }
 };
 
@@ -952,13 +1020,30 @@ static int __init kexec_core_sysctl_init(void)
 late_initcall(kexec_core_sysctl_init);
 #endif
 
-bool kexec_load_permitted(void)
+bool kexec_load_permitted(int kexec_image_type)
 {
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
+	limit = (kexec_image_type == KEXEC_TYPE_CRASH) ?
+		&load_limit_panic : &load_limit_reboot;
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
index 29efa43ea951..da9cfbbb0cbd 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -326,11 +326,13 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 		unsigned long, cmdline_len, const char __user *, cmdline_ptr,
 		unsigned long, flags)
 {
-	int ret = 0, i;
+	int image_type = (flags & KEXEC_FILE_ON_CRASH) ?
+			 KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
 	struct kimage **dest_image, *image;
+	int ret = 0, i;
 
 	/* We only trust the superuser with rebooting the system. */
-	if (!kexec_load_permitted())
+	if (!kexec_load_permitted(flags & KEXEC_FILE_ON_CRASH))
 		return -EPERM;
 
 	/* Make sure we have a legal set of flags */
@@ -342,11 +344,12 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	if (!kexec_trylock())
 		return -EBUSY;
 
-	dest_image = &kexec_image;
-	if (flags & KEXEC_FILE_ON_CRASH) {
+	if (image_type == KEXEC_TYPE_CRASH) {
 		dest_image = &kexec_crash_image;
 		if (kexec_crash_image)
 			arch_kexec_unprotect_crashkres();
+	} else {
+		dest_image = &kexec_image;
 	}
 
 	if (flags & KEXEC_FILE_UNLOAD)

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
