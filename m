Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DF9CD6E6B
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 03:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rfxlNkzCx8TA3SebJdSu06wI/is0K0+hQNvlMemiJzs=; b=iAJu8JrX2VUVRH8PJLheXFB2HP
	1lOuv5xbPVPBShiYiccXn+JMkrvmRM1CNsdqc7s87kth0fII4FxwxEXvIGR4Rbi4TeTzp6kbTx99l
	8J9JGCzTV8uKgEEdXSIuIxus8VLlbokTQClAacXpUXrjAFYgOfVmvgSjHSUlyvrgrOYSJn9waFQO+
	kn1TFe5JOa7ZARGTNkH9oXdzOg8Y6KXkR/UkbNnxorBCbfUIJxFZucxZpKeRwJ14RmiE/TS/JsLIv
	t8kDJ54beXt52+Zcq7vXnI900X2X6F0BwkcgSawBfAMABFPmymj716BFpw62OhVmlduhwbwoegQKq
	yKgkhScA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLKE-000000002MY-2xwB;
	Fri, 05 Jun 2026 03:34:26 +0000
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLKC-000000002Lf-3Etk
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 03:34:25 +0000
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-51764768c36so20941911cf.0
        for <kexec@lists.infradead.org>; Thu, 04 Jun 2026 20:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780630463; x=1781235263; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfxlNkzCx8TA3SebJdSu06wI/is0K0+hQNvlMemiJzs=;
        b=RZA6GL6KdoeNyJlBbE3pfXDx9qK52TiECvnKXM23MwI9ywFdnrpycoGqIEOke7ArgZ
         FMW1g0Obr2hfFFLRYxlzqvzDdKjFsuCUPxpSADXNbSw5Z4xvcZ2zlrhflsnF596cPzFf
         HacHGa1o1NxGrd/JRKOm5Y5ckKQJzA4PrstCnOQnhH1u00taU2zWDO3yZ2bQOkrnZhJi
         rl57dKd2rKzzqFTqjxlK/gw1rnBa0Cp8C2bptJwiTd7sWa53PX8J5gRbtsx4JwfhTdRR
         c+8OUQm1mtVqYSDM3WI56nhzZd6XsfDKBVNmzzVjj3oVIcqoYejRy3BVadBWtRxSMKQD
         sjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780630463; x=1781235263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rfxlNkzCx8TA3SebJdSu06wI/is0K0+hQNvlMemiJzs=;
        b=WTgbMCujBnzixWOsImRt+5c58422sui+Iwlma6k+Q2ufG0u6N7ZLQqK9PexbnDDDTX
         8TGg5BYSk+Jng3dp+r+9x2sssNiRZkfCI5YfqWP5zjo4n9jdvGEZecTHPMoVz2PefAWH
         wCb8ctQnJD8GWnSpcGV9/91qjY3IVxahTbH0D3cSaBIbg1NtbrnsVOR5t9LEW5McVBek
         DJCc2Z3lTBxonoerXMuiTRVA5dAvG5XnsUrhhb8+KPEjhHtnnV8wvHof0i3JkYqsgEEk
         pGdGXkS39BCZlOwjSmbxQOQ+I0ZWU2pK6OhhfZ8T+ZYUzU1xp0MSYz6D1CK1GysyeKGZ
         xiAQ==
X-Forwarded-Encrypted: i=1; AFNElJ8gM4POADLc5Su1KyRfD6uyF8wiDeIKIeKPck6sa7wFX5TtNVTKx+g0FSVMPXINeLPNHjul4w==@lists.infradead.org
X-Gm-Message-State: AOJu0YxqY5IWqBCzzuaCUsJTsMWWeZPRftGTmzXEu1k4NbCEz6TV4IGQ
	ZWeOxCQRc2wkX+2rG1bIgBMfBXxptlVDwtG+FuVwFxujaXFKwyC2Jkd5DvZdP4OWTpc=
X-Gm-Gg: Acq92OEYzXNPXbG8FuyuQYNTOTZbb/yAS8wq1gGNV/n7x72YYJvOeWVMs/eGu6b8ZoU
	FnPhOlEKNMVssxqC+Qd+WKpaGGaf52wDVi3/j+ZY3MYme9T3Qy1V+jnlimBk+J9rRlC3UCFFJkD
	4zm04YM+SfQ9zEstT6QWYNtNhJZa8c7g2O5oxfm33p2rMl3WSbI1sgF0zZAt9V5Xs8H8I2x91A1
	pCOs5PWWF9NIyYEfyYER+ifj0TjMoSELXCksRb8dfq0pPHpz7dRLEvq1L90bsZG26+tiw9HSI6l
	xDswV9MPBY4eGTP+b2jywTBz+6p3OriauImID9YIOHqq75MnRPNYAa1DVgJp1HrpHbSjWbCRDih
	w22gApgg9/6jTcaLYajGz9Gof8MqXIhiiS8E7mVXOPKtAx6PFU3CZUk2mnxOwZumMNP5sTzQtym
	aD08nNJvTHT4Zq/Z4ZAXW1aNTpru5WzFuF3kV7y5g0mHdjDDfobf2RP0NKPsuR9g==
X-Received: by 2002:a05:622a:4106:b0:517:6665:2a9a with SMTP id d75a77b69052e-51795c920f2mr28080531cf.50.1780630463488;
        Thu, 04 Jun 2026 20:34:23 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775df4dd6sm67871381cf.27.2026.06.04.20.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 20:34:23 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	jasonmiu@google.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	ran.xiaokai@zte.com.cn,
	pasha.tatashin@soleen.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	graf@amazon.com
Subject: [RFC v1 9/9] liveupdate: add KUnit test to verify alphabetical order of compatibility strings
Date: Fri,  5 Jun 2026 03:32:35 +0000
Message-ID: <20260605033235.717351-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605033235.717351-1-pasha.tatashin@soleen.com>
References: <20260605033235.717351-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_203424_843891_3F5A2016 
X-CRM114-Status: GOOD (  14.48  )
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

Introduce a KUnit test suite to verify that composite compatibility
strings are formatted correctly, specifically ensuring that all KHO
sub-component compatibility strings are unique and strictly sorted
in alphabetical order.

Maintaining alphabetical order in composite compatibility strings
is required to guarantee consistent, predictable, and reproducible
compatibility string representation across different system configurations.

The test suite validates:
- KHO_FDT_COMPATIBLE (the root composite compatibility string)
- LUO_ABI_COMPATIBLE (the LUO composite compatibility string)
- MEMFD_LUO_FH_COMPATIBLE (the memfd file handler composite compatibility string)

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/Kconfig                 | 15 ++++++
 kernel/liveupdate/Makefile                |  2 +
 kernel/liveupdate/liveupdate_test.c       | 56 +++++++++++++++++++++++
 tools/testing/selftests/liveupdate/config |  1 +
 4 files changed, 74 insertions(+)
 create mode 100644 kernel/liveupdate/liveupdate_test.c

diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index c13af38ba23a..617a31dcee73 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -86,4 +86,19 @@ config LIVEUPDATE_MEMFD
 
 	  If unsure, say N.
 
+config LIVEUPDATE_KUNIT_TEST
+	tristate "KUnit tests for LUO and KHO" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	depends on LIVEUPDATE
+	default KUNIT_ALL_TESTS
+	help
+	  Enable KUnit tests for LUO and KHO. These tests verify that the
+	  composite KHO, LUO, and memfd compatibility strings remain unique
+	  and sorted alphabetically.
+
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index b481e21a311a..5e0deb85e1b1 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -17,3 +17,5 @@ obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)	+= kexec_handover_debug.o
 obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS)	+= kexec_handover_debugfs.o
 
 obj-$(CONFIG_LIVEUPDATE)		+= luo.o
+obj-$(CONFIG_LIVEUPDATE_KUNIT_TEST)		+= liveupdate_test.o
+
diff --git a/kernel/liveupdate/liveupdate_test.c b/kernel/liveupdate/liveupdate_test.c
new file mode 100644
index 000000000000..15688d69735e
--- /dev/null
+++ b/kernel/liveupdate/liveupdate_test.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit test for Live Update compatibility strings.
+ */
+#include <kunit/test.h>
+#include <linux/string.h>
+#include <linux/kho/abi/kexec_handover.h>
+#include <linux/kho/abi/luo.h>
+#include <linux/kho/abi/memfd.h>
+
+/* Verify that compatibility sub-components are unique and sorted alphabetically */
+static bool is_alphabetical_unique(const char *compat)
+{
+	char buf[1024];
+	char *string = buf;
+	char *token;
+	char *prev = NULL;
+	char *sub;
+
+	strscpy(buf, compat, sizeof(buf));
+
+	sub = strchr(string, ';');
+	if (!sub)
+		return true;
+
+	sub++;
+
+	while ((token = strsep(&sub, ";")) != NULL) {
+		if (prev && strcmp(prev, token) >= 0)
+			return false;
+		prev = token;
+	}
+
+	return true;
+}
+
+static void test_compatibility_alphabetical(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, is_alphabetical_unique(KHO_FDT_COMPATIBLE));
+	KUNIT_EXPECT_TRUE(test, is_alphabetical_unique(LUO_ABI_COMPATIBLE));
+	KUNIT_EXPECT_TRUE(test, is_alphabetical_unique(MEMFD_LUO_FH_COMPATIBLE));
+}
+
+static struct kunit_case liveupdate_test_cases[] = {
+	KUNIT_CASE(test_compatibility_alphabetical),
+	{}
+};
+
+static struct kunit_suite liveupdate_test_suite = {
+	.name = "liveupdate-compatibility",
+	.test_cases = liveupdate_test_cases,
+};
+
+kunit_test_suite(liveupdate_test_suite);
+
+MODULE_LICENSE("GPL");
diff --git a/tools/testing/selftests/liveupdate/config b/tools/testing/selftests/liveupdate/config
index 91d03f9a6a39..28c54bb473b8 100644
--- a/tools/testing/selftests/liveupdate/config
+++ b/tools/testing/selftests/liveupdate/config
@@ -6,6 +6,7 @@ CONFIG_KEXEC_HANDOVER_DEBUGFS=y
 CONFIG_KEXEC_HANDOVER_DEBUG=y
 CONFIG_LIVEUPDATE=y
 CONFIG_LIVEUPDATE_TEST=y
+CONFIG_LIVEUPDATE_KUNIT_TEST=y
 CONFIG_MEMFD_CREATE=y
 CONFIG_TMPFS=y
 CONFIG_SHMEM=y
-- 
2.53.0


