Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBF7C43217
	for <kexec@archiver.kernel.org>; Thu, 24 Nov 2022 22:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:MIME-Version:Subject:
	Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=rZRI9dBOZyw+SpXenY8WIiDP0Bk3yAUq2mBrhEzzX68=; b=y/JyCS6VoN3JKd
	otU314J784lfXE0bLIFflqL+6/byrgiZX768iICzvX2Z0pvvYd+BjtuKNYz4e+xYZ2f7VuhecHiBn
	gyj7O8FgNq8Jtq1sri1HH7rC7UJJYPlXHr6RqYnYei+75NHbuCLGOXtPvjR7GAG8lkj4uLelumeAl
	73oYEPST9j2PXXtJtWmyIyTCRAeQLH+/kmcdv1m/2DaFbxYpt1ZQFqi7meslCoN737yoBwBbj7hkh
	Bd+X6Q0Hu4ZPPR3mg0je883WCFmvKvSLzIZEOQk/HdRYHOUskjboF4OUUuGATgmDm6/CcMpdZxCXq
	G9Udtqb8tcnRx/Kt6vyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oyKdZ-00BhJS-NV; Thu, 24 Nov 2022 22:24:05 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oyKdV-00BhIH-Ms
	for kexec@lists.infradead.org; Thu, 24 Nov 2022 22:24:03 +0000
Received: by mail-ed1-x52c.google.com with SMTP id s12so4109108edd.5
        for <kexec@lists.infradead.org>; Thu, 24 Nov 2022 14:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RDvQaU77JBFIkQ2oUa6F+0NvAeH+qvtlzjePcszuhs4=;
        b=IPMbRodr2ND7GVEwE0GnAs0d4Zwg1lAlQB9mR56wG2dyMixyC5kqUbEKtCOgX9hML5
         ADM9Z/mMyxke38dOCd7jbEPzu1gx9PYogXZ7YDtBm2znQ4dacV7LJC7AT1eSx7ob0jcn
         8W5zJharibXpbGTy/H7BM7Mrq7V7jNibfzfLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDvQaU77JBFIkQ2oUa6F+0NvAeH+qvtlzjePcszuhs4=;
        b=BPa8R2ZGAANEj7JzESv2KYhxqgOYiKDDGk61kyDUxqrkDkp/5yUxi3FW1DMBfmaWp2
         d0jFyvEKf5kVlujdTNiuh3hi1BjieI7gFyU96ENVWXfIppQkqddyQOkGz8YVBNmtTYTL
         VramO7x0KgONLWyrtDXoTtHiB2XAq9iduRsXJ9Kidf69VOWoMefk90kVjPLcHKRYoYfI
         nz6Tiv0hCz2asUE3Q8hcn8VtMw/X+u8np7rTgqjmqe5vv8I2LUq2Qu9CBivAAIonI5JI
         9vdr3A3EiSzHCebjtqosC+PTO6u8bFah8bDp4Whhse+2NTx+vqX52gyyewdJtAZ59IAv
         kfKg==
X-Gm-Message-State: ANoB5pn2znUJsyOZaTUrFX9lx3irFpWSAsUVzagjRLx/CsR1ix1XLHUN
	7X8fTz9ZPebAjuVmgh+4zD15rdxrL1i+eAEE
X-Google-Smtp-Source: AA0mqf4TLE6cWDqkHfcC/DG5GN+MPmX+bfaoJlJgLcKB6B8BNUZ1tBsgYhi9/775qVbAfWZNOzL5dA==
X-Received: by 2002:a05:6402:1f89:b0:458:caec:8f1e with SMTP id c9-20020a0564021f8900b00458caec8f1emr31387244edc.280.1669328637894;
        Thu, 24 Nov 2022 14:23:57 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id p23-20020a17090653d700b007822196378asm871216ejo.176.2022.11.24.14.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 14:23:57 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 24 Nov 2022 23:23:36 +0100
Subject: [PATCH] kexec: Enable runtime allocation of crash_image
MIME-Version: 1.0
Message-Id: <20221124-kexec-noalloc-v1-0-d78361e99aec@chromium.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>, Philipp Rudo <prudo@redhat.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Ross Zwisler <zwisler@kernel.org>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=4832; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=4synMW5GYep28EG2om20KSl9OgW8vz6iw1zjyeYDzG4=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjf+71OVt3J96ieJdQKPp8Bd5A9iPh5yK+hHxrTqn1
 tbx1b0+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY3/u9QAKCRDRN9E+zzrEiH3gEA
 CWnsTwGWniPrhO8ejZOwYcYBSb4+RNFNGYz59X3eLIuMW0+N+lFCUfVwiLiIXrca0XcEFxu9sVoXgC
 RvXxRNTssXhBNHTtLSXCz6CeMjBSbeycEzTefvySSIk7unB2N6+WF93oitDDg6zSybsRrTTAjxtWND
 UW/LiUBd7ghu63XJZbiVqf1TZBWwMyrNIdq4+ybU838nTlmwVSII6CJdRAiePNOtDHtq2MAm+IM5X4
 9fnT6afjk1xL87jS4WLcj0u1FeCpsvRHoYTkLt5absIRcOdP5VWkaOglOwEQdemhHWp/XweGaylEAa
 cwwesUZZH0tTdaYfOE61BAzbWBOMflf8701JqvAECeW5liwMXiXoJsnKAU/s2ffVLXQrJ0rQ2w6upH
 u05RQSwi3xn0AWHT8ZxxKqYe/S3uNn9+eYzIJq+MuwdwmBTkaEjZnu7qVFLVvZQkCfPe4Rll2nSFyc
 n0lfdJT2OlhP+H7m4xeV5agNDcKb93joL8X3ckvK7rDMed5xtWD/CfxWHMZG8vUpowexeV5Zfh+piS
 HrY/ajE/FKdJqkbCMlwQJG8IEMBTwy/LgagYfKU9pmikm/bCBoS07a0EYclfXD8bws6fqWHuXmSBQU
 8ziQ1nClcCH20sCtAJ0R3a6dmG0py9UO+bgvvq7foLCKvx+GVJblfmX2S3fg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221124_142401_807442_E8A5B463 
X-CRM114-Status: GOOD (  16.20  )
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

Usually crash_image is defined statically via the crashkernel parameter
or DT.

But if the crash kernel is not used, or is smaller than then
area pre-allocated that memory is wasted.

Also, if the crash kernel was not defined at bootime, there is no way to
use the crash kernel.

Enable runtime allocation of the crash_image if the crash_image is not
defined statically. Following the same memory allocation/validation path
that for the reboot kexec kernel.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
kexec: Enable runtime allocation of crash_image

To: Eric Biederman <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org
Cc: Ross Zwisler <zwisler@kernel.org>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 include/linux/kexec.h | 1 +
 kernel/kexec.c        | 9 +++++----
 kernel/kexec_core.c   | 5 +++++
 kernel/kexec_file.c   | 7 ++++---
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 41a686996aaa..98ca9a32bc8e 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -427,6 +427,7 @@ extern int kexec_load_disabled;
 extern bool kexec_in_progress;
 
 int crash_shrink_memory(unsigned long new_size);
+bool __crash_memory_valid(void);
 ssize_t crash_get_memory_size(void);
 
 #ifndef arch_kexec_protect_crashkres
diff --git a/kernel/kexec.c b/kernel/kexec.c
index cb8e6e6f983c..b5c17db25e88 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -28,7 +28,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 	struct kimage *image;
 	bool kexec_on_panic = flags & KEXEC_ON_CRASH;
 
-	if (kexec_on_panic) {
+	if (kexec_on_panic && __crash_memory_valid()) {
 		/* Verify we have a valid entry point */
 		if ((entry < phys_to_boot_phys(crashk_res.start)) ||
 		    (entry > phys_to_boot_phys(crashk_res.end)))
@@ -44,7 +44,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 	image->nr_segments = nr_segments;
 	memcpy(image->segment, segments, nr_segments * sizeof(*segments));
 
-	if (kexec_on_panic) {
+	if (kexec_on_panic && __crash_memory_valid()) {
 		/* Enable special crash kernel control page alloc policy. */
 		image->control_page = crashk_res.start;
 		image->type = KEXEC_TYPE_CRASH;
@@ -101,7 +101,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 
 	if (flags & KEXEC_ON_CRASH) {
 		dest_image = &kexec_crash_image;
-		if (kexec_crash_image)
+		if (kexec_crash_image && __crash_memory_valid())
 			arch_kexec_unprotect_crashkres();
 	} else {
 		dest_image = &kexec_image;
@@ -157,7 +157,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	image = xchg(dest_image, image);
 
 out:
-	if ((flags & KEXEC_ON_CRASH) && kexec_crash_image)
+	if ((flags & KEXEC_ON_CRASH) && kexec_crash_image &&
+	    __crash_memory_valid())
 		arch_kexec_protect_crashkres();
 
 	kimage_free(image);
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index ca2743f9c634..77083c9760fb 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1004,6 +1004,11 @@ void crash_kexec(struct pt_regs *regs)
 	}
 }
 
+bool __crash_memory_valid(void)
+{
+	return crashk_res.end != crashk_res.start;
+}
+
 ssize_t crash_get_memory_size(void)
 {
 	ssize_t size = 0;
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 45637511e0de..0671f4f370ff 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -280,7 +280,7 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
 
 	image->file_mode = 1;
 
-	if (kexec_on_panic) {
+	if (kexec_on_panic && __crash_memory_valid()) {
 		/* Enable special crash kernel control page alloc policy. */
 		image->control_page = crashk_res.start;
 		image->type = KEXEC_TYPE_CRASH;
@@ -345,7 +345,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	dest_image = &kexec_image;
 	if (flags & KEXEC_FILE_ON_CRASH) {
 		dest_image = &kexec_crash_image;
-		if (kexec_crash_image)
+		if (kexec_crash_image && __crash_memory_valid())
 			arch_kexec_unprotect_crashkres();
 	}
 
@@ -408,7 +408,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 exchange:
 	image = xchg(dest_image, image);
 out:
-	if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image)
+	if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image &&
+	    __crash_memory_valid())
 		arch_kexec_protect_crashkres();
 
 	kexec_unlock();

---
base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
change-id: 20221124-kexec-noalloc-3cab3cbe000f

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
