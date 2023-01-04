Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E89C4708E
	for <kexec@archiver.kernel.org>; Wed,  4 Jan 2023 16:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xMgjSz2zwSS9ov1srgiY4UVVx+RvmZ7BH/XNE0Gzbkw=; b=yYU63saa8I4Bou
	XfYs9sYdLKbujV4TTswZSqLWNPwcPsLXULYffqAbXWFjdjARNwRsBibJI6SLP0I149JMe1MHo+1KH
	t6n225AbGTtm9LrON+cjEHtdpv4tf3D3fVqcNHg6onmzGEGR8mIMdtnCOEivc/GZz1MWw0FEqGbvq
	9EeIaCvxzYporn+kJEU50Iw20HKK3GCBivUMkDled37rpMamYCLy6K5kA505szphLmIUFqa+Oxg+x
	yJyr63VQg7hZreMmP1w5naS6k/a1JVc0vLJlAmqss5QgBnBg2P0DUqeCFEYc8owYZZWY2UFmnUkvV
	u4X7zSFfIKZ/izlB26Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD70N-00AVd4-ES; Wed, 04 Jan 2023 16:52:43 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD4vC-009lJy-Ac
	for kexec@lists.infradead.org; Wed, 04 Jan 2023 14:39:17 +0000
Received: by mail-ej1-x62b.google.com with SMTP id ud5so83172688ejc.4
        for <kexec@lists.infradead.org>; Wed, 04 Jan 2023 06:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UgxvQK67tmMrLA74uOg//Gx6503PSr9SD0hLGo86OJA=;
        b=OsU1DngzOr4hhp/EoveJQE3TgkyHrAPpIqNakGYzicuHh+CEyyLyykYhfaAoqGFAP0
         LYbScr1P7QayvqjcETjQvA86XknilwM/8QYVJvo5EC3i5qtaTrRhxUBFdaiU4bPIhAxz
         Hbe9lGwRtmdSmOtj1sxtys51p9R+230EoGueY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgxvQK67tmMrLA74uOg//Gx6503PSr9SD0hLGo86OJA=;
        b=n+im8PO6Rqd90jkOLq4n3J4Qi/UXYrSz3FyRwlS6GPc5Mfv+vm12PeB8UrsN/jfwzh
         Cbode/Gmg13JvmhWrbPncSmKXJjuFLZM3MzwsUJHecZkPrC+5lFDhCxW5MJOjn6TPdQI
         mL5Gt6d1WaeJPzbw8OUYtXjAnpq8B3sSJAZHczDaVbvheFkEKbcA0aHGdHkNyhZLwtxf
         +fJ40k11ozXESrrdU55jBscGIlMs0PUwSWvKUNKFUF6I1+Oit6jfO6qt8juOA+5smPRw
         byJ2MqoioRjyvBp823/KSG5t99HkoZTdKtSK6XRHQdNlzsHx5DwsMthNxnYpS61AA7Y3
         ENxg==
X-Gm-Message-State: AFqh2kqYU2WLUue8v3xNBprvZFH2CgTbNXrgfcgUfq4ELUWv5YTuC5zB
	kb6l9Iw36HjXOwFkjA1SudOiuA==
X-Google-Smtp-Source: AMrXdXvnkGuCKVUdw8um3IaAa5qydCD325lajLfPnGFPmg5PN8jHu5yo2Sbj1UcOE9OWka3RWtYWTw==
X-Received: by 2002:a17:907:a643:b0:83c:7308:b2ed with SMTP id vu3-20020a170907a64300b0083c7308b2edmr41277617ejc.17.1672843150377;
        Wed, 04 Jan 2023 06:39:10 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:a438:c7da:62e0:36f4])
        by smtp.gmail.com with ESMTPSA id c8-20020a170906924800b0078de26f66b9sm15386659ejx.114.2023.01.04.06.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 06:39:09 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 04 Jan 2023 15:38:47 +0100
Subject: [PATCH v6 2/3] kexec: Factor out kexec_load_permitted
MIME-Version: 1.0
Message-Id: <20221114-disable-kexec-reset-v6-2-6a8531a09b9a@chromium.org>
References: <20221114-disable-kexec-reset-v6-0-6a8531a09b9a@chromium.org>
In-Reply-To: <20221114-disable-kexec-reset-v6-0-6a8531a09b9a@chromium.org>
To: Philipp Rudo <prudo@redhat.com>, Eric Biederman <ebiederm@xmission.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Ricardo Ribalda <ribalda@chromium.org>, linux-doc@vger.kernel.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Baoquan He <bhe@redhat.com>, Petr Tesarik <petr@tesarici.cz>,
 kexec@lists.infradead.org, Bagas Sanjaya <bagasdotme@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 Ross Zwisler <zwisler@kernel.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2784; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=k6P1smlJYbqtcVyvGezj5oVw/cqtzE+zRS/qzT0ctCc=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtY+F5BhkliZFvYK5Ym2wT15gzQ6IywHdyBQuZv9D
 Oz2Fl7SJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7WPhQAKCRDRN9E+zzrEiCV9D/
 43PHdTJ87hSQ5gRjDLnN9QhBf/0sdKtpQSIVJtwjRwJj0fKVXNwKAbxnZGaKGFbK0+D6XWur5dsPhx
 zICLrbRMjNO5zu2acdEIcX0Ixyc1goxQxCWSvLbPGI13Gu0zXck2k1aGNHQxbrHsLsoMWv1eJmz7ur
 0A1lsCo+Tm3tAmEnvQh2aD6k3XqJloCXOAzXoiwo3JjNn7aUKZmMnNEOVMiMhnEORyLIkQanA6I6pL
 XJ8jguQA6h/Bp8Xn5ykknlVGxjJvu4Nn6rvEnUKm+kp7L1k8iiUK7HcFRf4VPocxKiILNgowAGfnlR
 mTGEFPqHMTv+Ht+GLfRhqEOd31vGL8VkT0ermM6YAqLuhXIONQn4Jaewcdw90K31Teiw5Y1mdal9tj
 J1IkZa48R7TpCMYFTXf7SibBowvNWa9Vrz8vbrM7SE3cjIUTs0JvqP6Vav0a2TmgMgKdcOPkNgDP6F
 EotJDSYyCD9L+VjV54ebwcd6Tw94km8BKQtiR8AdwBHagfrBuQIYUJtBL5nWYP7hP8HiQt4P4Ubj7c
 kk5rmipLfXeDwJNM5L+L3kUi38k3o9hch06PSlNgWkhmhBSPAlLZxWZ8qTXYLWRpyfFX35Qzx6p1xD
 bjTLM5g5f84UHd42O5GYOj3SQoPP2t4muxbQhIIms/wq5G20v9tluc/GAVQQ==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230104_063914_449132_42D7048E 
X-CRM114-Status: GOOD (  16.15  )
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

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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
