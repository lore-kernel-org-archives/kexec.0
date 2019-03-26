Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8mFj-0005Ll-8e
 for kexec@lists.infradead.org; Tue, 26 Mar 2019 13:36:32 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2QDaBPK171210
 for <kexec@lists.infradead.org>; Tue, 26 Mar 2019 09:36:29 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rfkyeudu1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 26 Mar 2019 09:36:26 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Tue, 26 Mar 2019 13:35:24 -0000
From: Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v5 9/9] selftests/kexec: make kexec_load test independent of
 IMA being enabled
Date: Tue, 26 Mar 2019 09:34:17 -0400
In-Reply-To: <1553607257-18906-1-git-send-email-zohar@linux.ibm.com>
References: <1553607257-18906-1-git-send-email-zohar@linux.ibm.com>
Message-Id: <1553607257-18906-10-git-send-email-zohar@linux.ibm.com>
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
messages.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Dave Young <dyoung@redhat.com>
---
 tools/testing/selftests/kexec/test_kexec_load.sh | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

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
