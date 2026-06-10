Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F006CD98C7
	for <kexec@archiver.kernel.org>; Wed, 10 Jun 2026 23:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b0+7RpPS1OtZ4KOjVApYD0qDi4zot9K60kAK3POmulg=; b=Cv2EAV4M60jTOmMZP4lcbWBqKn
	BBsySzTfsoheNxEpBNAsaRxMU2gXr+bZ4RY1GW4KGtc6/oCtNsaoK48lcujT/M3YaJv6Q0ytRXZhf
	buTXH5u1ebi1dIA+UB7L7DWP4J7QMgCy5rhax+loloMpri4R3qj4CGr2iLkjgqksFTmwch2tZhEZV
	GSZOPcFEgMbTd4QhIGVSpGDhqBJ9uoySDnsbhqEvT3RYDWzIQuhcuwu+ot0ELuYiT1fckwE4ccaqS
	2P3gm/FhllCQCyKFjyMmNbUuDOQYeGiRGPI7AnyTRr6WWu60e2+fW6UItoA+Z8vjn1i3kSVdWtf4z
	A6suC+5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXS2y-00000008S8G-14ek;
	Wed, 10 Jun 2026 23:09:20 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXS2v-00000008S69-2Ti2
	for kexec@lists.infradead.org;
	Wed, 10 Jun 2026 23:09:19 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2bf11699875so3626615ad.1
        for <kexec@lists.infradead.org>; Wed, 10 Jun 2026 16:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781132956; x=1781737756; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b0+7RpPS1OtZ4KOjVApYD0qDi4zot9K60kAK3POmulg=;
        b=jhndOyDnZBOqYrI7Uo8tJmFmJEwcLDqKsehbTxN5cezzQAXk7FQVH2pJFDCTnJ0MU9
         asGfLEeyCbQ5ITBkkR74jN4meSXAETE9oZlkFK6HnhJWJJh/P9yBEdrQB4N6ayeNOoKr
         /cjsMgma5T6XsKSEgLJuW/HIbKCaLyDaYNgAYKObDlDjqG+s9wHufULFlx4slx7SWxLc
         /ZoSxyahYZYNST2xT24v3qALvZ0jUGOGsRmndo3MoQyuST6IbDnPDFktRvp1lQ7srI9E
         k7MsMmiKl97D3sbZFbzTL5PdhWXeg0doWd6d4zq0v80WopOjvKRjqC4kZaAOS/RWmEWh
         SZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781132956; x=1781737756;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0+7RpPS1OtZ4KOjVApYD0qDi4zot9K60kAK3POmulg=;
        b=HB+78LtTRx0uOCEVRWuTI2lENvmQzD2Bk64VvcrQZ2/wQddKADo3Ir4vfYPxRkObC/
         Y2IQzuf4UoNBvN5KTL21ugc0wpF7QN/ee7GQwDJfdRLX+61H2SHJJvQGXfE9S0PNbSma
         SbstQV8BTJUTPtn9nz7J6FUHPoFJ2fxXZtgVk/hS/qfwBK87i8C4gMo1GwgRjZWfSjKp
         +lBC2XJjqvDrzJErelV2LPMPxe0AfJ3vVtACkllPjUWSOFCzPMArmope6kcbb2W6lvJs
         fD3zBn59x3r+mTtI6Yo8gTl+OSY3/kLoJf2sCFA+f14IaWYurC+Akf6hqM/w1+3NpgRt
         cHcA==
X-Forwarded-Encrypted: i=1; AFNElJ9V/BC7ZpBiksV9ZGSdQ9s1S3HE7j5SBglB353oDQ9Ur6MojkrzDwTJm/7Igqy1q0ecdE6nYw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwW4eerqYy+Db4ujuQSOPEw8tButAVcJ0dLGb5VfQ9OWO5BFO1u
	CU1d778KPKLlBT2QqMT7wBtDlQk+es6CuoUJYubGBn7XfXOs3si1F6GJaODNfN8dinWkvHJvBxz
	NPe6boH/i5A==
X-Received: from plrf3.prod.google.com ([2002:a17:902:ab83:b0:2ba:39b8:446f])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e742:b0:2c0:dc5c:9069
 with SMTP id d9443c01a7336-2c2f57aeff0mr244655ad.2.1781132955512; Wed, 10 Jun
 2026 16:09:15 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:09:07 -0700
In-Reply-To: <20260610230909.876546-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20260610230909.876546-1-vipinsh@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610230909.876546-2-vipinsh@google.com>
Subject: [PATCH v2 1/2] selftests/liveupdate: Move luo_test_utils.* into a
 reusable library
From: Vipin Sharma <vipinsh@google.com>
To: pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org
Cc: tarunsahu@google.com, skhawaja@google.com, shuah@kernel.org, 
	dmatlack@google.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_160917_641693_0DE53753 
X-CRM114-Status: GOOD (  15.43  )
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

Move luo_test_utils.[ch] into a lib/ directory and pull the rules to
build them out into a separate make script. This will enable these
utilities to be also built by and used within other selftests (such as
VFIO).

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
 .../{luo_test_utils.c => lib/liveupdate.c}    |  2 +-
 .../testing/selftests/liveupdate/liveupdate.c |  2 +-
 .../selftests/liveupdate/luo_kexec_simple.c   |  2 +-
 .../selftests/liveupdate/luo_multi_session.c  |  2 +-
 .../selftests/liveupdate/luo_stress_files.c   |  2 +-
 .../liveupdate/luo_stress_sessions.c          |  2 +-
 10 files changed, 35 insertions(+), 20 deletions(-)
 rename tools/testing/selftests/liveupdate/{luo_test_utils.h => lib/include/libliveupdate.h} (87%)
 create mode 100644 tools/testing/selftests/liveupdate/lib/libliveupdate.mk
 rename tools/testing/selftests/liveupdate/{luo_test_utils.c => lib/liveupdate.c} (99%)

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
similarity index 87%
rename from tools/testing/selftests/liveupdate/luo_test_utils.h
rename to tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
index 6a0d85386613..6ff71d7c3d9c 100644
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
 
@@ -43,4 +43,4 @@ typedef void (*luo_test_stage2_fn)(int luo_fd, int state_session_fd);
 int luo_test(int argc, char *argv[], const char *state_session_name,
 	     luo_test_stage1_fn stage1, luo_test_stage2_fn stage2);
 
-#endif /* LUO_TEST_UTILS_H */
+#endif /* SELFTESTS_LIVEUPDATE_LIB_LIVEUPDATE_H */
diff --git a/tools/testing/selftests/liveupdate/lib/libliveupdate.mk b/tools/testing/selftests/liveupdate/lib/libliveupdate.mk
new file mode 100644
index 000000000000..0fb738c02330
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/lib/libliveupdate.mk
@@ -0,0 +1,20 @@
+include $(top_srcdir)/scripts/subarch.include
+ARCH ?= $(SUBARCH)
+
+LIBLIVEUPDATE_SRCDIR := $(selfdir)/liveupdate/lib
+
+LIBLIVEUPDATE_C := liveupdate.c
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
diff --git a/tools/testing/selftests/liveupdate/luo_test_utils.c b/tools/testing/selftests/liveupdate/lib/liveupdate.c
similarity index 99%
rename from tools/testing/selftests/liveupdate/luo_test_utils.c
rename to tools/testing/selftests/liveupdate/lib/liveupdate.c
index 333a3530051b..897c200f3845 100644
--- a/tools/testing/selftests/liveupdate/luo_test_utils.c
+++ b/tools/testing/selftests/liveupdate/lib/liveupdate.c
@@ -22,7 +22,7 @@
 #include <errno.h>
 #include <stdarg.h>
 
-#include "luo_test_utils.h"
+#include <libliveupdate.h>
 
 int luo_open_device(void)
 {
diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index 502fb3567e38..6bfd4e53528c 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -25,8 +25,8 @@
 #include <unistd.h>
 
 #include <linux/liveupdate.h>
+#include <libliveupdate.h>
 
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
index 0cdf9cd4bac7..c0f15c892950 100644
--- a/tools/testing/selftests/liveupdate/luo_stress_files.c
+++ b/tools/testing/selftests/liveupdate/luo_stress_files.c
@@ -10,7 +10,7 @@
 
 #include <stdio.h>
 #include <unistd.h>
-#include "luo_test_utils.h"
+#include <libliveupdate.h>
 
 #define NUM_FILES 500
 #define STATE_SESSION_NAME "kexec_many_files_state"
diff --git a/tools/testing/selftests/liveupdate/luo_stress_sessions.c b/tools/testing/selftests/liveupdate/luo_stress_sessions.c
index f201b1839d1d..8af19259ced3 100644
--- a/tools/testing/selftests/liveupdate/luo_stress_sessions.c
+++ b/tools/testing/selftests/liveupdate/luo_stress_sessions.c
@@ -10,7 +10,7 @@
 
 #include <stdio.h>
 #include <unistd.h>
-#include "luo_test_utils.h"
+#include <libliveupdate.h>
 
 #define NUM_SESSIONS 2000
 #define STATE_SESSION_NAME "kexec_many_state"
-- 
2.54.0.1099.g489fc7bff1-goog


