Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2EFCD98DA
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 21:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y63OIuewjJn4DM3LNPrZ6+3k1EeVNDYrDOZ6UJ5T9lM=; b=1mhoFULiILdhPZDIF9mHe5mNVv
	Ll+iLJ1VYYn0hgkhdh40lFk0xjf39hqVuOrdCNj6B3rvTOo1drwx+l/0ztMxFhY/M+Q/4rIotzyuJ
	M6zr3znSe3ZY+DVDS9j6eS98dZUy6iiJJpkuZ01LMnsQc+pjmONMzQSvD2spQRT2KZfZSCb4zZuXn
	Gkv9/QxqkIxgo3mJPyO7HB4YObNAJerPpxdP/gTzo8dEaWDULaNRMc3Jb17ifCra+dVyw3wV4HJsj
	G22qoaq6TcaGvujUJX7sYvL4lXvNTmpWgsh3Y5naum5O2g/hm1qGeZgyhDPPFHwD5kI8DwIXp3zq1
	dUHjadww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY9gp-0000000BcBy-3F2w;
	Fri, 12 Jun 2026 21:45:23 +0000
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY9gm-0000000BcAK-41fL
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 21:45:22 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-36bd4146cb2so1574574a91.1
        for <kexec@lists.infradead.org>; Fri, 12 Jun 2026 14:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781300720; x=1781905520; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y63OIuewjJn4DM3LNPrZ6+3k1EeVNDYrDOZ6UJ5T9lM=;
        b=A+hgRLQKCtUDWp0SuDK0tlutWnOkMdFpDP2o5XMBShljry0QYjWgPCAtvvYw5C4QHH
         uQsXNjGQk9Tr9cd6J2QccQnUToc/47pQ7VkyXp+F7Jx6DVw2mYD0C746NNcTTuKZvd0q
         TcCkVq0BoSnXt26bjG/3PzEI+6Qf5HJswYNzs7iIXcyby6+OCJntKau5SKhfBf0KILaI
         CexCvHVvEBA2T9uQeeWyxNTAUmbNIFF+VJLw1coVhEQu3QFNUsF4T9EI2IDqtBkU6gCQ
         ZAftP6+/wMYrQREw50E6JbD9XNuzU1WrYPtF8d0uQhacbkNRcEKyRmtCpS2sZSbBW3RP
         zSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781300720; x=1781905520;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y63OIuewjJn4DM3LNPrZ6+3k1EeVNDYrDOZ6UJ5T9lM=;
        b=ZnjMEl/uuSv0BRrYCIKiYQoIQr0dKfV3CF/XkI9p1PatSGCsJQdQgpWVH1t4RH3lKi
         WlT6o97YT08kyYRYjYV+VdRnKkcV80UqUgRP0jK/OvusfqqsWM6Zkcw4YEnnSohtf42N
         CGRVOdDr6TYBa0+rfM3JK7ngpt7Rf1YgXwDVNfRY5yBBzHJhuW3JcYN4ox8FQiKyH0ly
         hh0scgqPjsRuA3cSXwhJGTUofe1q4OCznaOa9Csybz/sDtX5X/wyWrSCTtY2A6mEEbtv
         Sve4uxhPjOcgAnnNzi3gNDPyt8tVaQU7oSbzYL/w5wzGEhd/yJJzZj/IZeyrBpBGey0W
         IxYw==
X-Forwarded-Encrypted: i=1; AFNElJ+vZlY0U8gySnsqKTZ5UHAda+v6DQRNpHdGdj8Ac5MFu5Q1kh3n36SN59+WIz9O02TaCEvwQg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxh5s2N4KQghmDR9JTLHK8CHfW6vbCdoNPd9HNKxyP48TwK6soD
	Pnpg0GjVzuM4H8wphWXS39cSjxaw3wpHZvR17zAchIyarmLLBV+gprZpss+DSKLL/GrQbRTYFmX
	3MRYvu2jjRQ==
X-Received: from pghc6.prod.google.com ([2002:a63:da06:0:b0:c86:253f:3d70])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ec3:b0:35f:c493:cac5
 with SMTP id 98e67ed59e1d1-379eff366b7mr4487198a91.16.1781300719329; Fri, 12
 Jun 2026 14:45:19 -0700 (PDT)
Date: Fri, 12 Jun 2026 14:45:12 -0700
In-Reply-To: <20260612214512.464146-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20260612214512.464146-1-vipinsh@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612214512.464146-3-vipinsh@google.com>
Subject: [PATCH v3 2/2] selftests/liveupdate: Move luo_test_utils.* into a
 reusable library
From: Vipin Sharma <vipinsh@google.com>
To: pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org
Cc: tarunsahu@google.com, skhawaja@google.com, shuah@kernel.org, 
	dmatlack@google.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260612_144521_005336_C8E51DE8 
X-CRM114-Status: GOOD (  14.13  )
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

Move luo_test_utils.[ch] into a lib/ directory and make libliveupdate
library. Pull the rules to build them out into a separate
libliveupdate.mk script. This will enable these utilities to be
also built by and used within other selftests (such as VFIO).

No functional change intended.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Acked-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/liveupdate/.gitignore |  1 +
 tools/testing/selftests/liveupdate/Makefile   | 14 ++++---------
 .../include/libliveupdate.h}                  |  8 ++++----
 .../selftests/liveupdate/lib/libliveupdate.mk | 20 +++++++++++++++++++
 .../{luo_test_utils.c => lib/lu_utils.c}      |  2 +-
 .../testing/selftests/liveupdate/liveupdate.c |  2 +-
 .../selftests/liveupdate/luo_kexec_simple.c   |  2 +-
 .../selftests/liveupdate/luo_multi_session.c  |  2 +-
 .../selftests/liveupdate/luo_stress_files.c   |  3 ++-
 .../liveupdate/luo_stress_sessions.c          |  3 ++-
 10 files changed, 37 insertions(+), 20 deletions(-)
 rename tools/testing/selftests/liveupdate/{luo_test_utils.h => lib/include/libliveupdate.h} (89%)
 create mode 100644 tools/testing/selftests/liveupdate/lib/libliveupdate.mk
 rename tools/testing/selftests/liveupdate/{luo_test_utils.c => lib/lu_utils.c} (99%)

diff --git a/tools/testing/selftests/liveupdate/.gitignore b/tools/testing/selftests/liveupdate/.gitignore
index 661827083ab6..18a0c7036cf3 100644
--- a/tools/testing/selftests/liveupdate/.gitignore
+++ b/tools/testing/selftests/liveupdate/.gitignore
@@ -3,6 +3,7 @@
 !/**/
 !*.c
 !*.h
+!*.mk
 !*.sh
 !.gitignore
 !config
diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testing/selftests/liveupdate/Makefile
index 30689d22cb02..634211c66652 100644
--- a/tools/testing/selftests/liveupdate/Makefile
+++ b/tools/testing/selftests/liveupdate/Makefile
@@ -1,7 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-LIB_C += luo_test_utils.c
-
 TEST_GEN_PROGS += liveupdate
 
 TEST_GEN_PROGS_EXTENDED += luo_kexec_simple
@@ -12,25 +10,21 @@ TEST_GEN_PROGS_EXTENDED += luo_stress_files
 TEST_FILES += do_kexec.sh
 
 include ../lib.mk
+include lib/libliveupdate.mk
 
 CFLAGS += $(KHDR_INCLUDES)
 CFLAGS += -Wall -O2 -Wno-unused-function
 CFLAGS += -MD
 
-LIB_O := $(patsubst %.c, $(OUTPUT)/%.o, $(LIB_C))
 TEST_O := $(patsubst %, %.o, $(TEST_GEN_PROGS))
 TEST_O += $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED))
 
-TEST_DEP_FILES := $(patsubst %.o, %.d, $(LIB_O))
+TEST_DEP_FILES := $(patsubst %.o, %.d, $(LIBLIVEUPDATE_O))
 TEST_DEP_FILES += $(patsubst %.o, %.d, $(TEST_O))
 -include $(TEST_DEP_FILES)
 
-$(LIB_O): $(OUTPUT)/%.o: %.c
-	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
-
-$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(OUTPUT)/%: %.o $(LIB_O)
-	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIB_O) $(LDLIBS) -o $@
+$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(OUTPUT)/%: %.o $(LIBLIVEUPDATE_O)
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBLIVEUPDATE_O) $(LDLIBS) -o $@
 
-EXTRA_CLEAN += $(LIB_O)
 EXTRA_CLEAN += $(TEST_O)
 EXTRA_CLEAN += $(TEST_DEP_FILES)
diff --git a/tools/testing/selftests/liveupdate/luo_test_utils.h b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
similarity index 89%
rename from tools/testing/selftests/liveupdate/luo_test_utils.h
rename to tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
index 49931ab90593..fa07fed08364 100644
--- a/tools/testing/selftests/liveupdate/luo_test_utils.h
+++ b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
@@ -7,13 +7,13 @@
  * Utility functions for LUO kselftests.
  */
 
-#ifndef LUO_TEST_UTILS_H
-#define LUO_TEST_UTILS_H
+#ifndef SELFTESTS_LIVEUPDATE_LIB_LIVEUPDATE_H
+#define SELFTESTS_LIVEUPDATE_LIB_LIVEUPDATE_H
 
 #include <errno.h>
 #include <string.h>
 #include <linux/liveupdate.h>
-#include "../kselftest.h"
+#include "../../../kselftest.h"
 
 #define LUO_DEVICE "/dev/liveupdate"
 
@@ -46,4 +46,4 @@ typedef void (*luo_test_stage2_fn)(int luo_fd, int state_session_fd);
 int luo_test(int argc, char *argv[], const char *state_session_name,
 	     luo_test_stage1_fn stage1, luo_test_stage2_fn stage2);
 
-#endif /* LUO_TEST_UTILS_H */
+#endif /* SELFTESTS_LIVEUPDATE_LIB_LIVEUPDATE_H */
diff --git a/tools/testing/selftests/liveupdate/lib/libliveupdate.mk b/tools/testing/selftests/liveupdate/lib/libliveupdate.mk
new file mode 100644
index 000000000000..634cd4c16c47
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/lib/libliveupdate.mk
@@ -0,0 +1,20 @@
+include $(top_srcdir)/scripts/subarch.include
+ARCH ?= $(SUBARCH)
+
+LIBLIVEUPDATE_SRCDIR := $(selfdir)/liveupdate/lib
+
+LIBLIVEUPDATE_C := lu_utils.c
+
+LIBLIVEUPDATE_OUTPUT := $(OUTPUT)/libliveupdate
+
+LIBLIVEUPDATE_O := $(patsubst %.c, $(LIBLIVEUPDATE_OUTPUT)/%.o, $(LIBLIVEUPDATE_C))
+
+CFLAGS += -I$(LIBLIVEUPDATE_SRCDIR)/include
+
+$(LIBLIVEUPDATE_OUTPUT):
+	$(Q)mkdir -p $@
+
+$(LIBLIVEUPDATE_O): $(LIBLIVEUPDATE_OUTPUT)/%.o : $(LIBLIVEUPDATE_SRCDIR)/%.c | $(LIBLIVEUPDATE_OUTPUT)
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
+
+EXTRA_CLEAN += $(LIBLIVEUPDATE_OUTPUT)
diff --git a/tools/testing/selftests/liveupdate/luo_test_utils.c b/tools/testing/selftests/liveupdate/lib/lu_utils.c
similarity index 99%
rename from tools/testing/selftests/liveupdate/luo_test_utils.c
rename to tools/testing/selftests/liveupdate/lib/lu_utils.c
index ddb4123f5107..1f92daf3b372 100644
--- a/tools/testing/selftests/liveupdate/luo_test_utils.c
+++ b/tools/testing/selftests/liveupdate/lib/lu_utils.c
@@ -22,7 +22,7 @@
 #include <errno.h>
 #include <stdarg.h>
 
-#include "luo_test_utils.h"
+#include <libliveupdate.h>
 
 int luo_open_device(void)
 {
diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index 5c7ed2512710..2dedd5fc2534 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -24,9 +24,9 @@
 #include <sys/ioctl.h>
 #include <unistd.h>
 
+#include <libliveupdate.h>
 #include <linux/liveupdate.h>
 
-#include "luo_test_utils.h"
 #include "../kselftest.h"
 #include "../kselftest_harness.h"
 
diff --git a/tools/testing/selftests/liveupdate/luo_kexec_simple.c b/tools/testing/selftests/liveupdate/luo_kexec_simple.c
index d7ac1f3dc4cb..786ac93b9ae3 100644
--- a/tools/testing/selftests/liveupdate/luo_kexec_simple.c
+++ b/tools/testing/selftests/liveupdate/luo_kexec_simple.c
@@ -8,7 +8,7 @@
  * across a single kexec reboot.
  */
 
-#include "luo_test_utils.h"
+#include <libliveupdate.h>
 
 #define TEST_SESSION_NAME "test-session"
 #define TEST_MEMFD_TOKEN 0x1A
diff --git a/tools/testing/selftests/liveupdate/luo_multi_session.c b/tools/testing/selftests/liveupdate/luo_multi_session.c
index 0ee2d795beef..aac24a5f5ce3 100644
--- a/tools/testing/selftests/liveupdate/luo_multi_session.c
+++ b/tools/testing/selftests/liveupdate/luo_multi_session.c
@@ -9,7 +9,7 @@
  * files.
  */
 
-#include "luo_test_utils.h"
+#include <libliveupdate.h>
 
 #define SESSION_EMPTY_1 "multi-test-empty-1"
 #define SESSION_EMPTY_2 "multi-test-empty-2"
diff --git a/tools/testing/selftests/liveupdate/luo_stress_files.c b/tools/testing/selftests/liveupdate/luo_stress_files.c
index 0cdf9cd4bac7..a0d48490f4ed 100644
--- a/tools/testing/selftests/liveupdate/luo_stress_files.c
+++ b/tools/testing/selftests/liveupdate/luo_stress_files.c
@@ -10,7 +10,8 @@
 
 #include <stdio.h>
 #include <unistd.h>
-#include "luo_test_utils.h"
+
+#include <libliveupdate.h>
 
 #define NUM_FILES 500
 #define STATE_SESSION_NAME "kexec_many_files_state"
diff --git a/tools/testing/selftests/liveupdate/luo_stress_sessions.c b/tools/testing/selftests/liveupdate/luo_stress_sessions.c
index f201b1839d1d..278aebabe0e9 100644
--- a/tools/testing/selftests/liveupdate/luo_stress_sessions.c
+++ b/tools/testing/selftests/liveupdate/luo_stress_sessions.c
@@ -10,7 +10,8 @@
 
 #include <stdio.h>
 #include <unistd.h>
-#include "luo_test_utils.h"
+
+#include <libliveupdate.h>
 
 #define NUM_SESSIONS 2000
 #define STATE_SESSION_NAME "kexec_many_state"
-- 
2.54.0.1136.gdb2ca164c4-goog


