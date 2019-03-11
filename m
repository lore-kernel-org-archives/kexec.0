Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h3JJk-00047r-4i
 for kexec@lists.infradead.org; Mon, 11 Mar 2019 11:42:06 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2BBexix007070
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2019 07:42:03 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2r5ngcm1yx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2019 07:42:02 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Mon, 11 Mar 2019 11:41:57 -0000
From: Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v3 3/7] selftests/ima: define common logging functions
Date: Mon, 11 Mar 2019 07:41:09 -0400
In-Reply-To: <1552304473-3966-1-git-send-email-zohar@linux.ibm.com>
References: <1552304473-3966-1-git-send-email-zohar@linux.ibm.com>
Message-Id: <1552304473-3966-4-git-send-email-zohar@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-integrity@vger.kernel.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>, Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>, linux-kselftest@vger.kernel.org, Dave Young <dyoung@redhat.com>

Define log_info, log_pass, log_fail, and log_skip functions.

Suggested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 tools/testing/selftests/ima/ima_common_lib.sh  | 31 ++++++++++++++++++++++++++
 tools/testing/selftests/ima/test_kexec_load.sh | 19 +++++-----------
 2 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/ima/ima_common_lib.sh b/tools/testing/selftests/ima/ima_common_lib.sh
index 403666247b10..59482914ac19 100755
--- a/tools/testing/selftests/ima/ima_common_lib.sh
+++ b/tools/testing/selftests/ima/ima_common_lib.sh
@@ -1,5 +1,36 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
+#
+# Kselftest framework defines: ksft_pass=0, ksft_fail=1, ksft_skip=4
+
+VERBOSE="${VERBOSE:-1}"
+
+log_info()
+{
+	[ $VERBOSE -ne 0 ] && echo "[INFO] $1"
+}
+
+# The ksefltest framework requirement returns 0 for PASS.
+log_pass()
+{
+
+	[ $VERBOSE -ne 0 ] && echo "$1 [PASS]"
+	exit 0
+}
+
+# The ksefltest framework requirement returns 1 for FAIL.
+log_fail()
+{
+	[ $VERBOSE -ne 0 ] && echo "$1 [FAIL]"
+	exit 1
+}
+
+# The ksefltest framework requirement returns 4 for SKIP.
+log_skip()
+{
+	[ $VERBOSE -ne 0 ] && echo "$1"
+	exit 4
+}
 
 # Check efivar SecureBoot-$(the UUID) and SetupMode-$(the UUID).
 # The secure boot mode can be accessed either as the last integer
diff --git a/tools/testing/selftests/ima/test_kexec_load.sh b/tools/testing/selftests/ima/test_kexec_load.sh
index e84139c1506b..99ab87b6c681 100755
--- a/tools/testing/selftests/ima/test_kexec_load.sh
+++ b/tools/testing/selftests/ima/test_kexec_load.sh
@@ -6,15 +6,10 @@
 
 TEST="$0"
 . ./ima_common_lib.sh
-rc=0
-
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
 
 # kexec requires root privileges
 if [ $(id -ru) -ne 0 ]; then
-	echo "$TEST: requires root privileges" >&2
-	exit $ksft_skip
+	log_skip "requires root privileges"
 fi
 
 get_secureboot_mode
@@ -26,18 +21,14 @@ kexec --load $KERNEL_IMAGE 2>&1 > /dev/null
 if [ $? -eq 0 ]; then
 	kexec --unload
 	if [ $secureboot -eq 1 ]; then
-		echo "$TEST: kexec_load succeeded [FAIL]"
-		rc=1
+		log_fail "kexec_load succeeded"
 	else
-		echo "$TEST: kexec_load succeeded [PASS]"
+		log_pass "kexec_load succeeded"
 	fi
 else
 	if [ $secureboot -eq 1 ]; then
-		echo "$TEST: kexec_load failed [PASS]"
+		log_pass "kexec_load failed"
 	else
-		echo "$TEST: kexec_load failed [FAIL]"
-		rc=1
+		log_fail "kexec_load failed"
 	fi
 fi
-
-exit $rc
-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
