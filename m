Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpHVg-0000Mr-3S
 for kexec@lists.infradead.org; Thu, 31 Jan 2019 18:56:26 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0VIs6uI051394
 for <kexec@lists.infradead.org>; Thu, 31 Jan 2019 13:56:23 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qc60ka72d-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 31 Jan 2019 13:56:23 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Thu, 31 Jan 2019 18:56:20 -0000
From: Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 2/3] scripts/ima: define a set of common functions
Date: Thu, 31 Jan 2019 13:55:35 -0500
In-Reply-To: <1548960936-7800-1-git-send-email-zohar@linux.ibm.com>
References: <1548960936-7800-1-git-send-email-zohar@linux.ibm.com>
Message-Id: <1548960936-7800-3-git-send-email-zohar@linux.ibm.com>
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

Define and move get_secureboot_mode() to a common file for use by other
tests.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tools/testing/selftests/ima/common_lib.sh      | 20 ++++++++++++++++++++
 tools/testing/selftests/ima/test_kexec_load.sh | 17 +++--------------
 2 files changed, 23 insertions(+), 14 deletions(-)
 create mode 100755 tools/testing/selftests/ima/common_lib.sh

diff --git a/tools/testing/selftests/ima/common_lib.sh b/tools/testing/selftests/ima/common_lib.sh
new file mode 100755
index 000000000000..ae097a634da5
--- /dev/null
+++ b/tools/testing/selftests/ima/common_lib.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+
+get_secureboot_mode()
+{
+	EFIVARFS="/sys/firmware/efi/efivars"
+	# Make sure that efivars is mounted in the normal location
+	if ! grep -q "^\S\+ $EFIVARFS efivarfs" /proc/mounts; then
+		echo "$TEST: efivars is not mounted on $EFIVARFS" >&2
+		exit $ksft_skip
+	fi
+
+	# Get secureboot mode
+	file="$EFIVARFS/SecureBoot-*"
+	if [ ! -e $file ]; then
+		echo "$TEST: unknown secureboot mode" >&2
+		exit $ksft_skip
+	fi
+	return `hexdump $file | awk '{print substr($4,length($4),1)}'`
+}
diff --git a/tools/testing/selftests/ima/test_kexec_load.sh b/tools/testing/selftests/ima/test_kexec_load.sh
index 74423c4229e2..5e3566738888 100755
--- a/tools/testing/selftests/ima/test_kexec_load.sh
+++ b/tools/testing/selftests/ima/test_kexec_load.sh
@@ -5,7 +5,7 @@
 # is booted in secureboot mode.
 
 TEST="$0"
-EFIVARFS="/sys/firmware/efi/efivars"
+. ./common_lib.sh
 rc=0
 
 # Kselftest framework requirement - SKIP code is 4.
@@ -17,19 +17,8 @@ if [ $(id -ru) != 0 ]; then
 	exit $ksft_skip
 fi
 
-# Make sure that efivars is mounted in the normal location
-if ! grep -q "^\S\+ $EFIVARFS efivarfs" /proc/mounts; then
-	echo "$TEST: efivars is not mounted on $EFIVARFS" >&2
-	exit $ksft_skip
-fi
-
-# Get secureboot mode
-file="$EFIVARFS/SecureBoot-*"
-if [ ! -e $file ]; then
-	echo "$TEST: unknown secureboot mode" >&2
-	exit $ksft_skip
-fi
-secureboot=`hexdump $file | awk '{print substr($4,length($4),1)}'`
+get_secureboot_mode
+secureboot=$?
 
 # kexec_load should fail in secure boot mode
 KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
