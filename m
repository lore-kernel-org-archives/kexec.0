Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9219CA5FA2
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 17:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bYY6SIuB38pNpvOXnuI019MieEUYiynUJJ9aqYbDrY4=; b=NSVa0mXYtaEgxl9WW6JBY8ubAW
	lsKCfV+Dkywt67JGpyL+wyjJI8WAXUQAydWtqJZQ1I2UBotx7ouASdeCHUyd+BI3JbIMsOFEwBWQK
	Q5dZ+E1a73yGsKWiEB3vvVITE16dTBsY9Hz1ldLUHNfk/8GSDdCEYAuRqiMTgbzRT3g+vV50j/xx3
	e83+8C39DjxLLYL77p0bfNms7323lnKQkuVoMcVvkPYe/hUTNdOJ+alQqbtBVIf5DMelDnnaSgdkw
	yZjpdo3BbF7fp1RtzqnLp1c880OERiwPncfCQ9kTS/y197t0p4TkYkiR9F8O9DtqrojdCY81dO++1
	u8/u/DTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBF8Z-000000019ys-48N2;
	Mon, 28 Sep 2026 17:27:35 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBF8Y-000000019yl-48CF
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 17:27:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 1B519600CB;
	Mon, 28 Sep 2026 17:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 555441F000FF;
	Mon, 28 Sep 2026 17:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790616453;
	bh=bYY6SIuB38pNpvOXnuI019MieEUYiynUJJ9aqYbDrY4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PMF4MzQQaBO1S123rLATz7lD7J/3S79MF4F1iuNOzs88eZr9hChaxqvOeeYV/q6PW
	 CUo5hRjsrTwhTnA9VFnZ/YLT1rAS/LLuWTfTi+r321ElD6RZFkwxvOrxqESVvkX2G/
	 rkXOaNGG/CUIhSvkIkBhNq/hbUZy8jgWYxVZc5ErX+du+7cruK/f9tYoyilePUgOuM
	 KTjDceMzVZVR/0cRH5EAtEZ4BIsNS5DJ6H7bv9NMP+b4dRzdsAFTzDG6a/jMebFu6R
	 K0J0VS5ArMRQARYfpVFXhnCwhQNfiF/fu+52s5O1LxcAOPLZuOzEVRHNJn2CzkyzZ0
	 ypIUc5Ir8JYuw==
From: Nicolas Schier <nsc@kernel.org>
Date: Mon, 28 Sep 2026 19:26:57 +0200
Subject: [PATCH v4 1/2] kbuild: Mark usr_gen_init_cpio as
 no-dot-config-target
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-move-gen_init_cpio-to-scripts-v4-1-f437a33c40ac@kernel.org>
References: <20260928-move-gen_init_cpio-to-scripts-v4-0-f437a33c40ac@kernel.org>
In-Reply-To: <20260928-move-gen_init_cpio-to-scripts-v4-0-f437a33c40ac@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Luis Augenstein <luis.augenstein@tngtech.com>, 
 Maximilian Huber <maximilian.huber@tngtech.com>, 
 Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Askar Safin <safinaskar@gmail.com>, linux-doc@vger.kernel.org, 
 kexec@lists.infradead.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117; i=nsc@kernel.org;
 s=20250924; h=from:subject:message-id;
 bh=DREW0pnsHVnYIRYZJD9DChr73EUt3Hcbs4tKegeuVNU=;
 b=owEBbQKS/ZANAwAKAQdSCnAWJhJpAcsmYgBquqNnSXZkN50m/3I+6jr4xgQZQchL3CmlL4kEv
 i+EigEvgyaJAjMEAAEKAB0WIQSHQTenhzckp4G+wsYHUgpwFiYSaQUCarqjZwAKCRAHUgpwFiYS
 ae2zD/9RtzfbLSq2k0CTp9fSMzaHgvIq9PoA0g6ReAplrJoADU/2bqSjWLjJPd5c9RuqfuAHgp4
 fHW7Kc6on2hwnObtpbvt7w90j83hS1KOni88O9ez2ACmdmYyz7ZuQYbtDw0TqFgP3xz8lJVorTv
 vtsXQS/7bIVX4rhIY7CX41T6yc93jsVHgMOuXgyBjM/dPRWXJpWTysvgRBrDFRO9z+a9QEOJXiB
 V9cbYfZAGpdKHphXhOlXCpZG0tftpvv6FUv/ruB0VBSJS9WccGl8dZRdCrMnCHS5Yc3iqNxhuua
 GMIwwaxiHufFAFS3BDQOHfd27k0t18Kx3VT3hsam8a2bp+3Ic8uMWB15ZbCatgalDbIufOAt59R
 kR3fSmYKau1A52n8L7ChcSV8vFhkMBkNoclyibapUbreuliExvScTFXtUHPa9IBF/yYVsd/5NT0
 gjaYUihtoKQz0jzX7KZKLPzxAVLD8C7rCcHT6Wko6YgDFUJNSdPubrLbCreF5aRTFsZsUk1Ph+P
 yqJwaam6eZX2Q18p+BLbEvYPJg6A4PK1ryUh+4HRzeRAVwvhuE5uyRugm1ihl0VSC9JNfMrYudt
 jQoY9lo8YjCTd9IgJHWtd+H1IjcMhmG8we+W5Wui3EHheGGBmvXvWQoWIYhkrAKB+ly6TwAlCdV
 Jqz/BL+0xKqSI6g==
X-Developer-Key: i=nsc@kernel.org; a=openpgp;
 fpr=18ED52DBE34F860EE9FBC82B7D97093255A0CE7F
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

Let usr/gen_init_cpio be built also if there is no kernel configuration.

Askar Safin reported that gen_init_cpio may be of use before any kernel
configuration is available.  Add usr_gen_init_cpio to list of targets
that do not require a .config file.

Reported-by: Askar Safin <safinaskar@gmail.com>
Closes: https://lore.kernel.org/all/20260220191150.244006-1-safinaskar@gmail.com
Fixes: f8e05c10631e ("kbuild: Add top-level target for building gen_init_cpio")
Signed-off-by: Nicolas Schier <nsc@kernel.org>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 751a08643bf85ccfd05060a3f574980f73b3a97f..51fada9059d68a92e6f5725e45ff9a594bfd9645 100644
--- a/Makefile
+++ b/Makefile
@@ -298,6 +298,7 @@ no-dot-config-targets := $(clean-targets) \
 			 %asm-generic kernelversion %src-pkg dt_binding_check \
 			 dt_style_selftest \
 			 outputmakefile rustavailable rustfmt rustfmtcheck \
+			 usr_gen_init_cpio \
 			 run-command
 no-sync-config-targets := $(no-dot-config-targets) %install modules_sign kernelrelease \
 			  image_name

-- 
2.47.3


