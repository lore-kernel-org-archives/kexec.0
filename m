Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FB9C10F1B
	for <kexec@archiver.kernel.org>; Wed, 21 Dec 2022 12:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wZlu/QYw+wS92Sr1AV9oxE1XHR6wEucUgqUTUjjBXCo=; b=uZoqaGpAVE5wHM
	T87zRzlITNxyodmDKfMk8l/WmMXAmhO4VKXiw/ypS0UFFy0hm3hfYMGbcvz10YN0k1WDE67GopHh5
	Z45IZoA1+aV1oLsxCONLofIKNUcs82akW9XHTcVyBJ1WWx9Wpk9cs6x5ExkqrdflXq6aFeLnqXOA8
	XhbL33YsVP8lyZZfC6rc9Y5GdoX20VNveY1ViRWeP1q2Oaa1rBGCCCcXxrA1QNHZHNQCyAmIeLDVa
	n4UaDmuNyIjnm5+Xo7nfb9jRsoQzuvFwy/WCnKHLR3f2Ac/2ycBtaF53DJiHGE26u2HuNRfqOSaP9
	lzu14ymOeDqQTGB96ybw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7ycY-00EqLJ-6K; Wed, 21 Dec 2022 12:54:54 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7yYF-00EoWc-5R
	for kexec@lists.infradead.org; Wed, 21 Dec 2022 12:50:28 +0000
Received: by mail-ej1-x636.google.com with SMTP id m18so36549212eji.5
        for <kexec@lists.infradead.org>; Wed, 21 Dec 2022 04:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0uo7tfZaiqOin2cp8QemVMZCCRCz92hxCxC8vhk5Wl8=;
        b=R2RT15ASWFQQ+HJe+0sCo+uF2kmwezaj3G470IQ3VwrN9sGIz7hH7YtE7+LcKHt6Cj
         oJw2V0LJVsPN/SBndPAGkCuI6O+DXEN9nMef2mvpzYidC5dI2ivk5DxCDGzkMzM1FMVl
         QVCsZJW6B1pti7LEpdEOt0AR1rG8O44Pgjaag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uo7tfZaiqOin2cp8QemVMZCCRCz92hxCxC8vhk5Wl8=;
        b=2vyVzUiUus7nK79RoUxFR0Pt0miflsfPW8/EzKjZ8wQ7NMTRQqj6HLiJ0BVWF6oGFV
         wjJZxsOOQ9OFdW5jBR4yWofgLvbBAfblhq22vRiIzNKD9fGgohCQSIYTZo53yUskXYVO
         Bx5iigCU7iZH56dfFqo61Dv4cBPa+cW9YEBfMZJthwD0ngAJbvw4Jxj7mnbW4e7AwgB9
         7ecV9PpV9w390Z0EQxVXRZP0Cmnk5uUN96X0VI7+aKnwJUYZXb3bQbLlwpw3HUaQZa4p
         Y/zRnJchfx1izwjt8UgLKpWazQQd1bTT6rC2pi6TVkadh4wgnMm3mnzwzJHWYXNXoLfU
         cAzg==
X-Gm-Message-State: AFqh2kq5R5Mxj8aVizD7xwc8HsQhvqryFS5863PnKaAfSvmniHDGdll/
	EAgI+Jellfj5l5zoJter/wnnDgwCLqOHtyUKxq8=
X-Google-Smtp-Source: AMrXdXsP7f6lqej8FU5+HkqvdNOpkaOSpgva0UJJ4q1TLYkqxkisLNkbycJ2AA6LvfmifmlzW3CSdA==
X-Received: by 2002:a17:907:d10:b0:82d:e258:fa55 with SMTP id gn16-20020a1709070d1000b0082de258fa55mr1453100ejc.36.1671627018527;
        Wed, 21 Dec 2022 04:50:18 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:4b82:b1f8:cb4f:fbbd])
        by smtp.gmail.com with ESMTPSA id w7-20020a170906b18700b007c0b28b85c5sm7039250ejy.138.2022.12.21.04.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 04:50:17 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 21 Dec 2022 13:50:02 +0100
Subject: [PATCH v4 2/3] kexec: Factor out kexec_load_permitted
MIME-Version: 1.0
Message-Id: <20221114-disable-kexec-reset-v4-2-ab809c8d988c@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2724; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=rm7FZlNI1K3HcWDQ5vaPpIW63r8rInBklo9MHxPCtFE=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjowECkFe21vSuqwF6tn2p8L+BKJ7tkuaiu4yiHveG
 nMtEFu+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6MBAgAKCRDRN9E+zzrEiO7dD/
 0XCbh5Qt8a1g8a4Ymj0sdar9KtUlQmWiFta0b5GfuPwcKQF19M9Med6ybxz+sbYW42P4SmN9A2XNec
 hNqPXR722Yi+HMUx4Qd/B+ioG5bVXLpahjFybWh0OzFejOEsoFCdP+ZIGKqe7i6jIfWWayud7NCbIL
 6CXuHhCyrTGg8tpp3wsxfnogoFnEi6Q252E+w1Jgmlyyd/u1tMQbVSJ5XRnOpVTOPWFLecrDwZLRkm
 vJrOhRDdEnRjGh8q0E12ff/RTZ9giik6eekXfuPzJP6cI9mynKpzBzk8lxlqJzv/c1AdGr1eBvidU7
 SwH9z8VvgHgK6vuN/A2DcxIC2Nce4PgvCzE6HLf6N1SaFL1iLZgB1GfFvYRxKf3cstzH9PVF2aYtlm
 r+QOw7ZwzrUnuYCZ+oULXDrpN9BNvxXwiG8Z2XdLWWqApjvxbZg72DlSXqkoiXK1k67Lj60HEehYyc
 jW+mz5MmMhqWT9rPRTbOMYdx+ppB4Szq4LEWarobPro9UZ8hhekXyXhYqgdncIvlR707JCUDjuEfpa
 Y2/uGgzDL2NaIOghN2/Y6X29qA6cfq4aR5wEEKHh8YhUEJBL/lHtsVN//Na8/DHod2e95JHXdO1EFQ
 JCZkKRC/0AcMQmLyUH832g1pR/uqXtS1FKqQfFmUTzN8WRH+qZmdP3k0Psng==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221221_045027_284441_83F4D25D 
X-CRM114-Status: GOOD (  15.29  )
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

Both syscalls (kexec and kexec_file) do the same check, lets factor it
out.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/linux/kexec.h |  3 ++-
 kernel/kexec.c        |  2 +-
 kernel/kexec_core.c   | 11 ++++++++++-
 kernel/kexec_file.c   |  2 +-
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 41a686996aaa..182e0c11b87b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -406,7 +406,8 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
 
 extern struct kimage *kexec_image;
 extern struct kimage *kexec_crash_image;
-extern int kexec_load_disabled;
+
+bool kexec_load_permitted(void);
 
 #ifndef kexec_flush_icache_page
 #define kexec_flush_icache_page(page)
diff --git a/kernel/kexec.c b/kernel/kexec.c
index cb8e6e6f983c..ce1bca874a8d 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -193,7 +193,7 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	int result;
 
 	/* We only trust the superuser with rebooting the system. */
-	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
+	if (!kexec_load_permitted())
 		return -EPERM;
 
 	/* Permit LSMs and IMA to fail the kexec */
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index ca2743f9c634..a1efc70f4158 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -928,7 +928,7 @@ int kimage_load_segment(struct kimage *image,
 
 struct kimage *kexec_image;
 struct kimage *kexec_crash_image;
-int kexec_load_disabled;
+static int kexec_load_disabled;
 #ifdef CONFIG_SYSCTL
 static struct ctl_table kexec_core_sysctls[] = {
 	{
@@ -952,6 +952,15 @@ static int __init kexec_core_sysctl_init(void)
 late_initcall(kexec_core_sysctl_init);
 #endif
 
+bool kexec_load_permitted(void)
+{
+	/*
+	 * Only the superuser can use the kexec syscall and if it has not
+	 * been disabled.
+	 */
+	return capable(CAP_SYS_BOOT) && !kexec_load_disabled;
+}
+
 /*
  * No panic_cpu check version of crash_kexec().  This function is called
  * only when panic_cpu holds the current CPU number; this is the only CPU
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 45637511e0de..29efa43ea951 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -330,7 +330,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	struct kimage **dest_image, *image;
 
 	/* We only trust the superuser with rebooting the system. */
-	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
+	if (!kexec_load_permitted())
 		return -EPERM;
 
 	/* Make sure we have a legal set of flags */

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
