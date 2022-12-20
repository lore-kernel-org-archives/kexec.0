Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936D1C4167B
	for <kexec@archiver.kernel.org>; Tue, 20 Dec 2022 22:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wZlu/QYw+wS92Sr1AV9oxE1XHR6wEucUgqUTUjjBXCo=; b=Ol4DoqfV5ta9ei
	VndmkgJKLsVVsEUpKlk7Q6AoOftCT9TWGEwshznXNU2utKAhnF7cVBE4myfFx2DX6D5bUC+AtCvYt
	/vis5i+oLoW0YXCHeBNoJT5quHVw3vGnWQCMAkHb8BdrK9R1z9LiRxYHRRjk/QnYolRzPX43I52PW
	MEx38jj3N9OuPifNhAtfLwGeOqbM5GqM3SHMJTSaqKwffX1n6BZ16qfrxqDt++JtCpZtGVPp8Ijke
	fYXEoNxRQvnu6969RtC45qVmTjQ9xDiSOjiIlXOASAurxrUCZXiwvVQ85nfKOMCuyJxEphwCCLh/Z
	zqfV+9kGYhBjNe8An0aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7kkX-004qfN-Cy; Tue, 20 Dec 2022 22:06:13 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7kkT-004qaZ-7j
	for kexec@lists.infradead.org; Tue, 20 Dec 2022 22:06:10 +0000
Received: by mail-ej1-x633.google.com with SMTP id t17so32617302eju.1
        for <kexec@lists.infradead.org>; Tue, 20 Dec 2022 14:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0uo7tfZaiqOin2cp8QemVMZCCRCz92hxCxC8vhk5Wl8=;
        b=c0EpSka2OkXl5W+Dl7hPwpEaeN+NdBH3EzU6HhKZkH8+2XWo9puTrQBfluMS1O4U6F
         YWa3b1blPJNLpgLgQjnd18NGYt3GWxhceXP0cKvEom172VwR9onTJMp2QKx5azS5/+xO
         kUBszu1d60MZJ0JPNqcHy1Hofql+nmBofgUFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uo7tfZaiqOin2cp8QemVMZCCRCz92hxCxC8vhk5Wl8=;
        b=247/4Wpfv/VOssQtGkP1YqSpvg4Hfg/C9hi9lcULy9X/v8dhPzXzbcjM1TEl9NxUPz
         D2aUNb+eJ+UTpwTSst9kPHf0QmczyfUdcSaQymIn/XL8tJihTD8A4IwrhGQWeT12aW71
         pOkakADIkgsEsfHf+d4xuvNcf7TyqZObeF+vjjYHBIBUWX0yr51MZaN+r5T5TP/sp8pf
         lgHXo74DBHnSqKQd6Ny964IY3BBowslta0bfN8xIa8IgaW56QmPpM4HSseDS6LWGON+C
         IIXUcn+dOUIfW48bsc8BGI9qV6FX60BeXYfC7Fl4Lo/wnHsCvjGqQObeFS+lwdjvtAjn
         ZIQg==
X-Gm-Message-State: ANoB5pl8FhPI7YXUzb9cUr71/9EJIs51fd3DbV2hGzfdCoO7dWPFZFtQ
	oGQ/Nni1NYZsqYKrL3NEWc5gYw==
X-Google-Smtp-Source: AA0mqf4Xdnh+ldvePnRa6rbW2ZtD81RRgUSqnVw6sp+F6Q8bp2kOJntcSfdbXzeevYTHIOVAnX8QBQ==
X-Received: by 2002:a17:907:1110:b0:7c0:fd1a:79ef with SMTP id qu16-20020a170907111000b007c0fd1a79efmr38892271ejb.48.1671573967232;
        Tue, 20 Dec 2022 14:06:07 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id ku13-20020a170907788d00b00837ac146a53sm1175492ejc.23.2022.12.20.14.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 14:06:06 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 20 Dec 2022 23:05:44 +0100
Subject: [PATCH v3 2/3] kexec: Factor out kexec_load_permitted
MIME-Version: 1.0
Message-Id: <20221114-disable-kexec-reset-v3-2-4ef4e929adf6@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2724; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=rm7FZlNI1K3HcWDQ5vaPpIW63r8rInBklo9MHxPCtFE=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjojHJBckCkaRQr+TYZrF3kjpd1KCko1R5cEm6gufq
 +jL/ctqJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6IxyQAKCRDRN9E+zzrEiMSUD/
 9f/BnyydzLUgxCB/+6MPK5x85yrh4BQzpJFvUHfpUcS4bvaQxOKcu42CXvd7TlWapp3anOCskcmg42
 XTOJ6jxFo2Zdjd+HB+gQc8AzBwAsTS7lk5/GG5HkOXdqE7oRGXSpyVzd7daWjm0ZAD/e40xju8QvwS
 yCZM5hT9nhnEwG9RFkNm3p/5yeJngpYqubIHxexqLNz8P6HyUUGskiE6epSpx0A8l1gK5CjJdcJ2QD
 TAcAv3+NxhErfOIe28YkMiuiHBibNKLw7kolvHnOoLqgUsbGkAgsTJsXayRaN+aQ+UeCiaEIny4inY
 IsXan5vCvqjJi6Y59k4ojkdtblxbbHoC6438DfPpfOdJfhPPYkBBsc7GQuMU02H38ig942i8nSLHP3
 1h96Q+D3M2QiXyOMsdHuMMrM6xgWpICODgLT0avXHXY9zlK+998nN1iWUJEFzcgDuzD9goVzcGPHTa
 eriwadLeYeSXIrrpHzkNDincaSpNoxHP1jXLEkQzcvsOX5HNXAWiDBgHVwtGjtRWaMjtuOkmQDZNkB
 h9hbV7C4XbZLQ8WWhkHcSTxK6sNEhY3V2xWDcGfPKhoMQXZNuRAPy81AEeNwO5djhddq/ldkmJio7C
 6cCvL9mR9mST3ODQ0BZSE1QACA5mrPVAR0W95BJ5eAUXM/3nnQs4+askGnFw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221220_140609_367153_A29E7DD7 
X-CRM114-Status: GOOD (  15.74  )
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
