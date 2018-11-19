Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gOpf3-0004VD-La
 for kexec@lists.infradead.org; Mon, 19 Nov 2018 19:56:48 +0000
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAJJrp2N095673
 for <kexec@lists.infradead.org>; Mon, 19 Nov 2018 14:56:33 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nv2qbjdt5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 19 Nov 2018 14:56:33 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Mon, 19 Nov 2018 19:56:30 -0000
From: Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 2/3] selftests/ima: kexec_load syscall test
Date: Mon, 19 Nov 2018 14:56:10 -0500
In-Reply-To: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com>
References: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com>
Message-Id: <1542657371-7019-3-git-send-email-zohar@linux.ibm.com>
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
Cc: linux-efi@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com, seth.forshee@canonical.com, linux-security-module@vger.kernel.org, jforbes@redhat.com

The kernel CONFIG_KEXEC_VERIFY_SIG option is limited to verifying a
kernel image's signature, when loaded via the kexec_file_load syscall.
There is no method for verifying a kernel image's signature loaded
via the kexec_load syscall.

This test verifies loading the kernel image via the kexec_load syscall
fails when the kernel CONFIG_KEXEC_VERIFY_SIG option is enabled on
systems with secureboot enabled[1].

[1] Detecting secureboot enabled is architecture specific.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tools/testing/selftests/Makefile               |  1 +
 tools/testing/selftests/ima/Makefile           | 11 ++++++
 tools/testing/selftests/ima/config             |  4 ++
 tools/testing/selftests/ima/test_kexec_load.sh | 54 ++++++++++++++++++++++++++
 4 files changed, 70 insertions(+)
 create mode 100644 tools/testing/selftests/ima/Makefile
 create mode 100644 tools/testing/selftests/ima/config
 create mode 100755 tools/testing/selftests/ima/test_kexec_load.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index f1fe492c8e17..552c447af03d 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -13,6 +13,7 @@ TARGETS += firmware
 TARGETS += ftrace
 TARGETS += futex
 TARGETS += gpio
+TARGETS += ima
 TARGETS += intel_pstate
 TARGETS += ipc
 TARGETS += kcmp
diff --git a/tools/testing/selftests/ima/Makefile b/tools/testing/selftests/ima/Makefile
new file mode 100644
index 000000000000..0b3adf5444b6
--- /dev/null
+++ b/tools/testing/selftests/ima/Makefile
@@ -0,0 +1,11 @@
+# Makefile for kexec_load
+
+uname_M := $(shell uname -m 2>/dev/null || echo not)
+ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
+
+ifeq ($(ARCH),x86)
+TEST_PROGS := test_kexec_load.sh
+
+include ../lib.mk
+
+endif
diff --git a/tools/testing/selftests/ima/config b/tools/testing/selftests/ima/config
new file mode 100644
index 000000000000..6bc86d4d9bb4
--- /dev/null
+++ b/tools/testing/selftests/ima/config
@@ -0,0 +1,4 @@
+CONFIG_IMA_APPRAISE
+CONFIG_IMA_ARCH_POLICY
+CONFIG_SECURITYFS
+CONFIG_KEXEC_VERIFY_SIG
diff --git a/tools/testing/selftests/ima/test_kexec_load.sh b/tools/testing/selftests/ima/test_kexec_load.sh
new file mode 100755
index 000000000000..3aafc6f6a400
--- /dev/null
+++ b/tools/testing/selftests/ima/test_kexec_load.sh
@@ -0,0 +1,54 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Loading a kernel image via the kexec_load syscall should fail
+# when the kerne is CONFIG_KEXEC_VERIFY_SIG enabled and the system
+# is booted in secureboot mode.
+
+TEST="$0"
+EFIVARFS="/sys/firmware/efi/efivars"
+rc=0
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+# kexec requires root privileges
+if [ $UID != 0 ]; then
+	echo "$TEST: must be run as root" >&2
+	exit $ksft_skip
+fi
+
+# Make sure that efivars is mounted in the normal location
+if ! grep -q "^\S\+ $EFIVARFS efivarfs" /proc/mounts; then
+	echo "$TEST: efivars is not mounted on $EFIVARFS" >&2
+	exit $ksft_skip
+fi
+
+# Get secureboot mode
+file="$EFIVARFS/SecureBoot-*"
+if [ ! -e $file ]; then
+	echo "$TEST: unknown secureboot mode" >&2
+	exit $ksft_skip
+fi
+secureboot=`hexdump $file | awk '{print substr($4,length($4),1)}'`
+
+# kexec_load should fail in secure boot mode
+KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
+kexec -l $KERNEL_IMAGE &>> /dev/null
+if [ $? == 0 ]; then
+	kexec -u
+	if [ "$secureboot" == "1" ]; then
+		echo "$TEST: kexec_load succeeded [FAIL]"
+		rc=1
+	else
+		echo "$TEST: kexec_load succeeded [PASS]"
+	fi
+else
+	if [ "$secureboot" == "1" ]; then
+		echo "$TEST: kexec_load failed [PASS]"
+	else
+		echo "$TEST: kexec_load failed [FAIL]"
+		rc=1
+	fi
+fi
+
+exit $rc
-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
