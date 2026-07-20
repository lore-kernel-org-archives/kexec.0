Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E37C4452E
	for <kexec@archiver.kernel.org>; Mon, 20 Jul 2026 20:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D0u/ZsKaJ4sWO+EwXyup1tCC2bG9yJvlOEOLZr8wnIo=; b=axLFLYevY3yl+Ly7l/Mdl9usQV
	ZpMIZ5ogeLAagNsaq/8Pp1iXFl3S9mdDw0jP5uFA/p+l0BgO8eMqdhYHLhhZWHr/Lioj4jXz5jEz+
	g9kaJSRUiAhx4++A4lYTPpcZPSyI3o6TtTCQFMDK/Q8xr63TTIIqg9TpQsbB1X9tW4ZH58LLL5g2S
	u8lvUfh47RSXX2cVDZFUh+WsbVsL3DqcUu3GWz4H83lOrdGVFjkiHoYmTcgotCG0L1FOul3+qQPrE
	V7PABLeqmtuTqGuBiNI6e5SAWAnVf3bC3isCxLgYuWAH5g/fFXJK0gHt2JiwW/De2hvmQlWxYiMFH
	cqFTIKWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wluer-00000007sLR-1FfC;
	Mon, 20 Jul 2026 20:32:13 +0000
Received: from mail-pf1-x445.google.com ([2607:f8b0:4864:20::445])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlueo-00000007sKI-0hEx
	for kexec@lists.infradead.org;
	Mon, 20 Jul 2026 20:32:11 +0000
Received: by mail-pf1-x445.google.com with SMTP id d2e1a72fcca58-84870e7f498so10999289b3a.3
        for <kexec@lists.infradead.org>; Mon, 20 Jul 2026 13:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784579528; x=1785184328; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D0u/ZsKaJ4sWO+EwXyup1tCC2bG9yJvlOEOLZr8wnIo=;
        b=MpTRj8Ijjfpfy4OnPi4303kS5+RWh4Nbhaczah3DYpjtyueufwOuJYlvSPuMGb5nFQ
         kOSBf95BHaEF78t3COusLq//S9NxdpXapwqai5IthrP3ouoDVVmMJd6O5nI0qJdOHtXn
         379BoIrlS93CTIX67+qi1lcDv4BpYeN6YBv7gau5r8RsDsjmn98Y1Qz6mHAkpvitdtJr
         mayfGVRyVarX+0aZxGWLMVybfNacrOCwd/SZdoIlvGdI9K59+98SGk7beOWjhpEk+mDM
         OdW/qSrQJsPtSt5cxgdoO48yQt52NTvxiRh1sUrC3oecP/fz8lrAlYTQNXCjAHK+QFom
         33cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784579528; x=1785184328;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D0u/ZsKaJ4sWO+EwXyup1tCC2bG9yJvlOEOLZr8wnIo=;
        b=B6CJvUVv6Of0SxojkR5mJuL1OOKU5FgVbkl+xUHcEc1oXurJb6uWdWyp+Q5OVPlrwA
         S8ZjZmwYZ0lwd00GbRdVAqofc7cGnNmqu22LNOoTix5s+p+WYjb0auKbFbSNP0zYHcVb
         WEQTfI5H63RhAhMBVyOHCv5CqKbzBA6bGaAkF8ZZZWyBKsVbuKKeTkIqnA1RANPbTtDt
         B23Q/FxYiA1PNmSZQw6jP2+iVeKFEnjkGD3VnaUP0zfPW3N3xDsv4qbtT44ptok7psGK
         XiQQ3Ta84o6mnUAgLNpK37OkM1g0w/gVBpJwN1rVZXa04e9a8NyzHZTgf7OhPWpzclWv
         5Eww==
X-Forwarded-Encrypted: i=1; AHgh+Rouw4EYQWDIF8ZwBZZlpCtOMletB+utaOVSz+gGqdKgH4uO+XZC16kVpDMpTizOpQPDX9s1Gg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzE8JDFDrQBeXwoQ39DjoS2oCK6Jgm8gXyx68cyG2PZXfD4V9st
	GEqaO38o6HdqjfpZm0v2VZmZ1+LNo9EUK/II2Y2bsZ3p9wmafRXKZUyef8jkcrdCw5V22CN+V7J
	cfSvZJ3JZSw==
X-Received: from pfbjo7.prod.google.com ([2002:a05:6a00:9087:b0:845:b941:bc97])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8c2:b0:848:54e0:96c1
 with SMTP id d2e1a72fcca58-84c29590547mr16031465b3a.77.1784579527756; Mon, 20
 Jul 2026 13:32:07 -0700 (PDT)
Date: Mon, 20 Jul 2026 13:32:02 -0700
In-Reply-To: <20260720203202.1964557-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20260720203202.1964557-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260720203202.1964557-3-vipinsh@google.com>
Subject: [PATCH v4 2/2] selftests/liveupdate: Move luo_test_utils.* into a
 reusable library
From: Vipin Sharma <vipinsh@google.com>
To: pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org
Cc: tarunsahu@google.com, skhawaja@google.com, shuah@kernel.org, 
	dmatlack@google.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_133210_216907_BC8984ED 
X-CRM114-Status: GOOD (  16.73  )
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

Update path in vmtest.sh as that one uses hardcoded path for util.

No functional change intended.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Acked-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
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
 tools/testing/selftests/liveupdate/vmtest.sh  |  4 ++--
 11 files changed, 39 insertions(+), 22 deletions(-)
 rename tools/testing/selftests/liveupdate/{luo_test_utils.h => lib/include/libliveupdate.h} (89%)
 create mode 100644 tools/testing/selftests/liveupdate/lib/libliveupdate.mk
 rename tools/testing/selftests/liveupdate/{luo_test_utils.c => lib/lu_utils.c} (99%)

diff --git a/tools/testing/selftests/liveupdate/.gitignore b/tools/testing/selftests/liveupdate/.gitignore
index cb08ddb0dfee..47c670bf532b 100644
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
index 885712a65075..74d41115c281 100644
--- a/tools/testing/selftests/liveupdate/luo_test_utils.c
+++ b/tools/testing/selftests/liveupdate/lib/lu_utils.c
@@ -23,7 +23,7 @@
 #include <stdarg.h>
 #include <linux/unistd.h>
 
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
diff --git a/tools/testing/selftests/liveupdate/vmtest.sh b/tools/testing/selftests/liveupdate/vmtest.sh
index b0000fae1461..64fd2ab55b76 100755
--- a/tools/testing/selftests/liveupdate/vmtest.sh
+++ b/tools/testing/selftests/liveupdate/vmtest.sh
@@ -131,9 +131,9 @@ function mkinitrd() {
 	"$CROSS_COMPILE"gcc -static -O2 -nostdinc -nostdlib \
 		-I "$headers_dir/include" \
 		-I "$kernel_dir/tools/include/nolibc" \
-		-I "$test_dir" \
+		-I "$test_dir/lib/include" \
 		-o "$workspace_dir/test_binary" \
-		"$test_dir/$test_name.c" "$test_dir/luo_test_utils.c"
+		"$test_dir/$test_name.c" "$test_dir/lib/lu_utils.c"
 
 	"$CROSS_COMPILE"gcc -s -static -Os -nostdinc -nostdlib		\
 			-fno-asynchronous-unwind-tables -fno-ident	\
-- 
2.55.0.229.g6434b31f56-goog


