Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpHVe-0000LE-HF
 for kexec@lists.infradead.org; Thu, 31 Jan 2019 18:56:24 +0000
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0VIs7Ou037175
 for <kexec@lists.infradead.org>; Thu, 31 Jan 2019 13:56:21 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qc67c9k6a-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 31 Jan 2019 13:56:21 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Thu, 31 Jan 2019 18:56:19 -0000
From: Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 1/3] selftest/ima: cleanup the kexec selftest
Date: Thu, 31 Jan 2019 13:55:34 -0500
In-Reply-To: <1548960936-7800-1-git-send-email-zohar@linux.ibm.com>
References: <1548960936-7800-1-git-send-email-zohar@linux.ibm.com>
Message-Id: <1548960936-7800-2-git-send-email-zohar@linux.ibm.com>
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>

Remove the few bashisms in the script and use the complete option name
for clarity.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tools/testing/selftests/ima/test_kexec_load.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/ima/test_kexec_load.sh b/tools/testing/selftests/ima/test_kexec_load.sh
index 1c10093fb526..74423c4229e2 100755
--- a/tools/testing/selftests/ima/test_kexec_load.sh
+++ b/tools/testing/selftests/ima/test_kexec_load.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0+
 # Loading a kernel image via the kexec_load syscall should fail
-# when the kerne is CONFIG_KEXEC_VERIFY_SIG enabled and the system
+# when the kernel is CONFIG_KEXEC_VERIFY_SIG enabled and the system
 # is booted in secureboot mode.
 
 TEST="$0"
@@ -12,7 +12,7 @@ rc=0
 ksft_skip=4
 
 # kexec requires root privileges
-if [ $UID != 0 ]; then
+if [ $(id -ru) != 0 ]; then
 	echo "$TEST: must be run as root" >&2
 	exit $ksft_skip
 fi
@@ -33,17 +33,17 @@ secureboot=`hexdump $file | awk '{print substr($4,length($4),1)}'`
 
 # kexec_load should fail in secure boot mode
 KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
-kexec -l $KERNEL_IMAGE &>> /dev/null
-if [ $? == 0 ]; then
-	kexec -u
-	if [ "$secureboot" == "1" ]; then
+kexec --load $KERNEL_IMAGE 2>&1 /dev/null
+if [ $? -eq 0 ]; then
+	kexec --unload
+	if [ $secureboot -eq 1 ]; then
 		echo "$TEST: kexec_load succeeded [FAIL]"
 		rc=1
 	else
 		echo "$TEST: kexec_load succeeded [PASS]"
 	fi
 else
-	if [ "$secureboot" == "1" ]; then
+	if [ $secureboot -eq 1 ]; then
 		echo "$TEST: kexec_load failed [PASS]"
 	else
 		echo "$TEST: kexec_load failed [FAIL]"
-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
