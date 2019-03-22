Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h7Py4-0001YH-7M
 for kexec@lists.infradead.org; Fri, 22 Mar 2019 19:36:42 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2MJYsfR029190
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2019 15:36:36 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rd4tbu501-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2019 15:36:35 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Fri, 22 Mar 2019 19:36:25 -0000
From: Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v4a 1/2] selftests/kexec: make tests independent of IMA being
 enabled
Date: Fri, 22 Mar 2019 15:35:50 -0400
Message-Id: <1553283351-6310-1-git-send-email-zohar@linux.ibm.com>
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

Verify IMA is enabled before failing tests or emitting irrelevant
messages.  Also, don't skip the test if signatures are not required.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
Dave, if this patch resolves the outstanding issues, I can fold these
changes into the original patches. (Reminder, these patches will need to
be updated to support the "lockdown" patch set.)

 .../selftests/kexec/test_kexec_file_load.sh        | 27 ++++++++++++++--------
 tools/testing/selftests/kexec/test_kexec_load.sh   | 24 ++++++++++++-------
 2 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/kexec/test_kexec_file_load.sh b/tools/testing/selftests/kexec/test_kexec_file_load.sh
index 1d2e5e799523..57b636792086 100755
--- a/tools/testing/selftests/kexec/test_kexec_file_load.sh
+++ b/tools/testing/selftests/kexec/test_kexec_file_load.sh
@@ -110,11 +110,20 @@ kexec_file_load_test()
 			log_fail "$succeed_msg (missing IMA sig)"
 		fi
 
-		if [ $pe_sig_required -eq 0 ] && [ $ima_sig_required -eq 0 ] \
-		    && [ $ima_read_policy -eq 0 ] && [ $ima_signed -eq 0 ]; then
+		if [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 1 ] \
+		    && [ $ima_sig_required -eq 0 ] && [ $ima_signed -eq 0 ] \
+	            && [ $ima_read_policy -eq 0 ]; then
 			log_fail "$succeed_msg (possibly missing IMA sig)"
 		fi
 
+		if [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 0 ]; then
+			log_info "No signature verification required"
+		elif [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 1 ] \
+		    && [ $ima_sig_required -eq 0 ] && [ $ima_signed -eq 0 ] \
+	            && [ $ima_read_policy -eq 1 ]; then
+			log_info "No signature verification required"
+		fi
+
 		log_pass "$succeed_msg"
 	fi
 
@@ -136,8 +145,9 @@ kexec_file_load_test()
 		log_pass "$failed_msg (missing IMA sig)"
 	fi
 
-	if [ $pe_sig_required -eq 0 ] && [ $ima_sig_required -eq 0 ] \
-	    && [ $ima_read_policy -eq 0 ] && [ $ima_signed -eq 0 ]; then
+	if [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 1 ] \
+	    && [ $ima_sig_required -eq 0 ] && [ $ima_read_policy -eq 0 ] \
+	    && [ $ima_signed -eq 0 ]; then
 		log_pass "$failed_msg (possibly missing IMA sig)"
 	fi
 
@@ -157,6 +167,9 @@ if [ $? -eq 0 ]; then
 fi
 
 # Determine which kernel config options are enabled
+kconfig_enabled "CONFIG_IMA_APPRAISE=y" "IMA enabled"
+ima_appraise=$?
+
 kconfig_enabled "CONFIG_IMA_ARCH_POLICY=y" \
 	"architecture specific policy enabled"
 arch_policy=$?
@@ -178,12 +191,6 @@ ima_sig_required=$?
 get_secureboot_mode
 secureboot=$?
 
-if [ $secureboot -eq 0 ] && [ $arch_policy -eq 0 ] && \
-   [ $pe_sig_required -eq 0 ] && [ $ima_sig_required -eq 0 ] && \
-   [ $ima_read_policy -eq 1 ]; then
-	log_skip "No signature verification required"
-fi
-
 # Are there pe and ima signatures
 check_for_pesig
 pe_signed=$?
diff --git a/tools/testing/selftests/kexec/test_kexec_load.sh b/tools/testing/selftests/kexec/test_kexec_load.sh
index 2a66c8897f55..49c6aa929137 100755
--- a/tools/testing/selftests/kexec/test_kexec_load.sh
+++ b/tools/testing/selftests/kexec/test_kexec_load.sh
@@ -1,8 +1,8 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
-# Loading a kernel image via the kexec_load syscall should fail
-# when the kernel is CONFIG_KEXEC_VERIFY_SIG enabled and the system
-# is booted in secureboot mode.
+#
+# Prevent loading a kernel image via the kexec_load syscall when
+# signatures are required.  (Dependent on CONFIG_IMA_ARCH_POLICY.)
 
 TEST="$0"
 . ./kexec_common_lib.sh
@@ -18,20 +18,28 @@ if [ $? -eq 0 ]; then
 	log_skip "kexec_load is not enabled"
 fi
 
+kconfig_enabled "CONFIG_IMA_APPRAISE=y" "IMA enabled"
+ima_appraise=$?
+
+kconfig_enabled "CONFIG_IMA_ARCH_POLICY=y" \
+	"IMA architecture specific policy enabled"
+arch_policy=$?
+
 get_secureboot_mode
 secureboot=$?
 
-# kexec_load should fail in secure boot mode
+# kexec_load should fail in secure boot mode and CONFIG_IMA_ARCH_POLICY enabled
 kexec --load $KERNEL_IMAGE > /dev/null 2>&1
 if [ $? -eq 0 ]; then
 	kexec --unload
-	if [ $secureboot -eq 1 ]; then
+	if [ $secureboot -eq 1 ] && [ $arch_policy -eq 1 ]; then
 		log_fail "kexec_load succeeded"
-	else
-		log_pass "kexec_load succeeded"
+	elif [ $ima_appraise -eq 0 -o $arch_policy -eq 0 ]; then
+		log_info "Either IMA or the IMA arch policy is not enabled"
 	fi
+	log_pass "kexec_load succeeded"
 else
-	if [ $secureboot -eq 1 ]; then
+	if [ $secureboot -eq 1 ] && [ $arch_policy -eq 1 ] ; then
 		log_pass "kexec_load failed"
 	else
 		log_fail "kexec_load failed"
-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
