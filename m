Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0621DC10F1D
	for <kexec@archiver.kernel.org>; Wed, 21 Dec 2022 19:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wZlu/QYw+wS92Sr1AV9oxE1XHR6wEucUgqUTUjjBXCo=; b=hLGpiQZL68eOpD
	52E4b98/IlF7MNj8YGAkhw1LADZzUd42mRmd4j31ZCQwQFSXGtpqLkGs0FG6VNIr3vBBLwiZeiQmE
	Dsk3otG0GmenquBLqh7lry879pAAsB5+PXUHgPwHFkk/GdO8RZzKT5W4QlQpQZDTiqDaOY51jYsRP
	XVV1Qtphb9rB3plDIJwf14xd7/h2nZZdaBOCGDRqg6JsGIbd4JnCb3o+C2kR7sMxtbO+7qqdK0sA5
	b0tayBhso181UlJYLYuJacOaXSTALdoRhbftcsQhR0xRdOd/mqK4OjvURa5DEijSmusG0JkyAB6jz
	DWssrlzOCrLWOO1Cq8IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p852n-001NpP-Mf; Wed, 21 Dec 2022 19:46:25 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p852b-001NWP-JI
	for kexec@lists.infradead.org; Wed, 21 Dec 2022 19:46:16 +0000
Received: by mail-ed1-x52f.google.com with SMTP id i9so14592edj.4
        for <kexec@lists.infradead.org>; Wed, 21 Dec 2022 11:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0uo7tfZaiqOin2cp8QemVMZCCRCz92hxCxC8vhk5Wl8=;
        b=WX7m0hFptzAKKxKsaaznTLCeqXMlEsjlHE0rP+ZyG0YNSw3h+7aI7mg0glILNtGFCz
         kzOlSrRMq6Oix0VtjYBFRnisX2Hn0x2yoaYyc6H5n87Xgzm59sWQtqEsetF/PRaxhxNX
         gSrN4JjE5E5W5C9pns16Llt81QhijcSi4pGHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uo7tfZaiqOin2cp8QemVMZCCRCz92hxCxC8vhk5Wl8=;
        b=nb1QnZdGLdDYcoX1Vgt/mGKt1DDA9Iwi8R0FThuaqS5VTjpW9up4EcRXvwfSbAQweT
         jVpXQYYbdW/CMXDq68sgDQADUXoRLt2m+lAr5vXA5TBJV5i7AgLN8HkU5+IZXHclO6X8
         lckfG9Cf2Ex3qJ3aSTQ56I9nL63BbKahqmHUBipz+eXptmQzBiI2z1aLpO4fzKk1tmT5
         ObwcCFV9J9t2W+qTP8jABK++Ce7qqeCQuT+z61vOUtgLqOYM0mL+MRClgxN/OCDs3lMA
         iuqL1r0A9oyOxDFPwGfE+5t8r2i2zjZkTqdukVUYNayYEammJdASISe09Zdu44QjNQZd
         95GQ==
X-Gm-Message-State: AFqh2kpDfB8na8AhZFq7eM+KWWcEowqctWjAXI7RWuudS1be36FEaBQa
	sPqJ9wY0Np4QbZEwTicL4sRyRg==
X-Google-Smtp-Source: AMrXdXtTZ4AJlQ9U0G+e+iBRcvddnW65aUk/yN9aZH2F8Alh6420BexRna4Td4t+M3AftNwqnXtCKQ==
X-Received: by 2002:a05:6402:501f:b0:460:5706:d1fa with SMTP id p31-20020a056402501f00b004605706d1famr2808261eda.18.1671651972067;
        Wed, 21 Dec 2022 11:46:12 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id f24-20020a056402005800b0046cbcc86bdesm7382008edu.7.2022.12.21.11.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 11:46:11 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 21 Dec 2022 20:45:58 +0100
Subject: [PATCH v5 2/3] kexec: Factor out kexec_load_permitted
MIME-Version: 1.0
Message-Id: <20221114-disable-kexec-reset-v5-2-1bd37caf3c75@chromium.org>
References: <20221114-disable-kexec-reset-v5-0-1bd37caf3c75@chromium.org>
In-Reply-To: <20221114-disable-kexec-reset-v5-0-1bd37caf3c75@chromium.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Eric Biederman <ebiederm@xmission.com>, Jonathan Corbet <corbet@lwn.net>,
 Philipp Rudo <prudo@redhat.com>
Cc: Ross Zwisler <zwisler@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, kexec@lists.infradead.org,
 Ricardo Ribalda <ribalda@chromium.org>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2724; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=rm7FZlNI1K3HcWDQ5vaPpIW63r8rInBklo9MHxPCtFE=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjo2J+j6VSiwnd2NWq7ZYy+eTh20kxBVZ9N+tQgsO4
 igsMiaWJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6NifgAKCRDRN9E+zzrEiGD7EA
 CYxHLKOPM0+bvFezijOnO/4euoKLtab/2RYTcKlJRXfaLDSfpGPq/yiF2XmosQXz9H1wOwxZjPq0UV
 S+/PlFVreAJhuOn9yogBEAdK9wkQu4xJUtE84othkWC84aYXOHQK6PSZCScw6dWYV3JV2v3JOrNqB3
 hRcsbyMxlyPsXIdpxlwA6ZHmdLVsivB1zoYcJl7CwUGPNcC+/OLyyVORgUI55LdUAVqeHxyaVfuGav
 gY8xZzttKJEAlpzfB5cz7yyqK1Zd5FPdV/1BDsxLEG2G1ej1IFkaoUZItbfAPHq+w/q+zJfpv76m3L
 7bw4bH8WT321wqTso6Ixppe2rUErDpNDtDWSUJJDIlRZJeWmr0opiVPxaG+i51uWHfO3d7YKV6JJ16
 ACej0FAbBCJgZgAGSWby008b6GoyJWcMoN4a6xfP6hEDqjsmSYDJ+GQNBuWg3U0t/PlFDJbQZS2Y2c
 C3QCGfQ+o+6QYZ5RTV0pv90pQZunYJ3VJlaxVD16OSM+HRroJGo1zhLgJeMbDr+00+BNw9BRUnEtQk
 KQ7E20venuQA+qKYRD+AB1egECzOpXL1bpBMNjmE8254qy60xBRjk3iM1dqnApJPFBI9qSKY4V39ZC
 kH4XZdG16Fnrhi2q3Mr4lD8J1Q5WMmGdya5RTg4lw0296MOpLuJqkhRD3+Gw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221221_114613_665590_AC963D7F 
X-CRM114-Status: GOOD (  15.33  )
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
