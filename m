Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17106C433FE
	for <kexec@archiver.kernel.org>; Mon, 14 Nov 2022 13:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CJnUpOI9kS5q6eumhxi5/mhZ+frHd95TlISUKjxj/9A=; b=ABq5FADwhDZl2M
	sDemYL0vZfO46kBBSzRAdXpl+e0Qu1jgWyc0+Ljl/Ar9dGhQ3hmv0jyrFSACeVIr6EineBVg3VhmK
	3P0RBKQB6dAi2v7R1nFUiypoJEi8B4OsisfIJstcsrcu08ogJQ6tRoef+gEL5kJtWnnjUFuS21JPi
	yhiqDaYq4c4wPzS+dPq1s1l/wrDMHToklFztuZmzc23X8PiLiYbGmMbQ45L++gMF//qRlqtUNOqhY
	NbzzovBZdxhHtqYeBuhcky/T3L7/eSwwVEkogpJtcwR+EEvj2OSYzLtsNDDD4YlmaOEJDiED3OnaL
	3Lk1lkPA9I2CaaAN1wUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouZar-001Fae-JG; Mon, 14 Nov 2022 13:33:45 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouZMj-0019Wj-A7
	for kexec@lists.infradead.org; Mon, 14 Nov 2022 13:19:12 +0000
Received: by mail-ej1-x636.google.com with SMTP id t25so28189857ejb.8
        for <kexec@lists.infradead.org>; Mon, 14 Nov 2022 05:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBDqrK6ZdWq2OzrZLHJQraMMoPoinvhQP0W8u+3GcTk=;
        b=l+SRhUtVZVJ0JfZqzT7bi1gWoeK5gqgOT1cfNOL0iydr9/ACO4IBVNXucMwfahDafq
         CcjyAjAzeje8N09iCbh4cC4KqMlln1mN4sbG6gBrvQZZ4jUrmqPsT0sGID2YHiZfN3pG
         CoywAWz6UY5pqFVZHhmTJBgeSD1qak/cqkiWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBDqrK6ZdWq2OzrZLHJQraMMoPoinvhQP0W8u+3GcTk=;
        b=l3egF3YNrH3wNSX9keTMKeFY51LKqE31JFX5QhnB7z0FeMJZPNjNdeSboBqJ8VrYCF
         o93XtdM2vVDEH3X26HDiiq0lmjqzPYFZ7e1ErozWjWCrt9W+I8uv4XtwY9ZH/iOU3HgA
         DFeOEnOc+N+YDe8mzB51wvDxC5lNXKQu4yYJkiyWbD1rC8Ui1mn5dhPnWSX5ea7Uq3sW
         uEoS5IsMrxZFPqMbzIpVjrHfrEMBpxT6phtx+CO1ifuGB5ICtLD6IatNyTRrazChc3X1
         cs0tbfdky3soAr+G3Nf71fis/qv1regxlh70as1rpzrcchrbnrxFTGp6jEIA7hoofmNv
         YJyw==
X-Gm-Message-State: ANoB5plR5aS5jedZYr7wVgHje07ayzfJm8u5fBstsRZa/KRfyP50/cMY
	uF6oHhUMpHsHp41ujFUfr9XZsg==
X-Google-Smtp-Source: AA0mqf5XEPlCqCerbKFCDqW7Ii2ijdR3SvE9imxd10P/fR2NMfFIZ1DEoLE/yUsvtR/op0wt/ZWzBA==
X-Received: by 2002:a17:906:f208:b0:7ae:2277:9fec with SMTP id gt8-20020a170906f20800b007ae22779fecmr9990574ejb.623.1668431947306;
        Mon, 14 Nov 2022 05:19:07 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:c205:5c4e:7456:c8cc])
        by smtp.gmail.com with ESMTPSA id g13-20020a50ec0d000000b0045b3853c4b7sm4802061edr.51.2022.11.14.05.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 05:19:06 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 14 Nov 2022 14:18:39 +0100
Subject: [PATCH v1 2/2] kexec: Introduce kexec_reboot_disabled
MIME-Version: 1.0
Message-Id: <20221114-disable-kexec-reset-v1-2-fb51d20cf871@chromium.org>
References: <20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org>
In-Reply-To: <20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org>
To: Eric Biederman <ebiederm@xmission.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 Ross Zwisler <zwisler@kernel.org>, linux-doc@vger.kernel.org, "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3808; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=dblSayUsSfEKi8F2aGC75NJql5jVZbhwpLBwKIyAUtI=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjckBFo6eu9Gtv5tVzghpwemmGVrmtXYcngm/W6RxM
 3Cx6NGiJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY3JARQAKCRDRN9E+zzrEiKEID/
 4te8B7uFehLdBDS2AiqR+VMunRK2lzXEeuVXblaP3r9ExwUMnGbUtAWttF2wal25J7+bvvo5sQnQWQ
 /BbODeZY+8zGMtVVZGYXtwZ9uGeX53xvh1fheLmkHVHxuKwB7TC3SsPxSIhDj+6M+9YbmEbrJe1YB5
 VcCdjYyjDHo9YFjKOXDIQ/zrsYzhCpCX1xND0zKYlIe58zE+LkT6EGs47rw9I0GUdqRvbWDIa6MrlO
 cKE8iQAOX9ihR5wGRJVBO1O8+GBbq+3x7xfeEo4qYfJv64ne4t/TUXRAajUAg8mIZRlWp0/r9vAqB4
 siXhXif6Sbr0P7D3ND5d5/e3A7vCy4jnIEAFnyoA2bMZp8lPtKa0OZ/CkIYVygBbymXYiwgMmqhs89
 01cb4w3UOj810NTpXb1nR/D5wnH1A5jtHvp+09F+Js/8q5GPEDGqdaglAlE2fnATD07PdX/GD4xsDz
 vsqnw7M4vpGHQuPPzFizXXK8vTJIcJnmVpZJG7nX+s3QHH7FgAaUFC6yKYcFw/5aKqYEtHD1rCuLBf
 xPmpZ8s6CIzKx0kfixlh9mmR+pbwFC9QqULyccreqPocelwhaHSZXUZRvABk1AAkrFWRt39ChNVEOr
 g7LSeqsxViMsBQgX/QuEcRq4LGx/aHZOplyG/1DFFpu9P86p7zYC8a3U7sdw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_051909_407597_D7D272AD 
X-CRM114-Status: GOOD (  15.53  )
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

Create a new toogle that disables LINUX_REBOOT_CMD_KEXEC, reducing the
attack surface to a system.

Without this toogle, an attacker can only reboot into a different kernel
if they can create a panic().

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 97394bd9d065..25d019682d33 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -462,6 +462,17 @@ altered.
 Generally used together with the `modules_disabled`_ sysctl.
 
 
+kexec_reboot_disabled
+=====================
+
+A toggle indicating if ``LINUX_REBOOT_CMD_KEXEC`` has been disabled.
+This value defaults to 0 (false: ``LINUX_REBOOT_CMD_KEXEC`` enabled),
+but can be set to 1 (true: ``LINUX_REBOOT_CMD_KEXEC`` disabled).
+Once true, kexec can no longer be used for reboot and the toggle
+cannot be set back to false.
+This toggle does not affect the use of kexec during a crash.
+
+
 kptr_restrict
 =============
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 41a686996aaa..15c3fad8918b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -407,6 +407,7 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
 extern struct kimage *kexec_image;
 extern struct kimage *kexec_crash_image;
 extern int kexec_load_disabled;
+extern int kexec_reboot_disabled;
 
 #ifndef kexec_flush_icache_page
 #define kexec_flush_icache_page(page)
diff --git a/kernel/kexec.c b/kernel/kexec.c
index cb8e6e6f983c..43063f803d81 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -196,6 +196,10 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
 		return -EPERM;
 
+	/* Check if the system admin has disabled kexec reboot. */
+	if (!(flags & KEXEC_ON_CRASH) && kexec_reboot_disabled)
+		return -EPERM;
+
 	/* Permit LSMs and IMA to fail the kexec */
 	result = security_kernel_load_data(LOADING_KEXEC_IMAGE, false);
 	if (result < 0)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index ca2743f9c634..fe82e2525705 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -929,6 +929,7 @@ int kimage_load_segment(struct kimage *image,
 struct kimage *kexec_image;
 struct kimage *kexec_crash_image;
 int kexec_load_disabled;
+int kexec_reboot_disabled;
 #ifdef CONFIG_SYSCTL
 static struct ctl_table kexec_core_sysctls[] = {
 	{
@@ -941,6 +942,16 @@ static struct ctl_table kexec_core_sysctls[] = {
 		.extra1		= SYSCTL_ONE,
 		.extra2		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "kexec_reboot_disabled",
+		.data		= &kexec_reboot_disabled,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		/* only handle a transition from default "0" to "1" */
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_ONE,
+	},
 	{ }
 };
 
@@ -1138,7 +1149,7 @@ int kernel_kexec(void)
 
 	if (!kexec_trylock())
 		return -EBUSY;
-	if (!kexec_image) {
+	if (!kexec_image || kexec_reboot_disabled) {
 		error = -EINVAL;
 		goto Unlock;
 	}
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 45637511e0de..583fba6de5cb 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -333,6 +333,11 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
 		return -EPERM;
 
+	/* Check if the system admin has disabled kexec reboot. */
+	if (!(flags & (KEXEC_FILE_ON_CRASH | KEXEC_FILE_UNLOAD))
+	    && kexec_reboot_disabled)
+		return -EPERM;
+
 	/* Make sure we have a legal set of flags */
 	if (flags != (flags & KEXEC_FILE_FLAGS))
 		return -EINVAL;

-- 
b4 0.11.0-dev-d93f8

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
