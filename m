Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h3JJf-00045Q-P7
 for kexec@lists.infradead.org; Mon, 11 Mar 2019 11:42:01 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2BBdeRK066634
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2019 07:41:58 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2r5p61ja6b-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2019 07:41:57 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Mon, 11 Mar 2019 11:41:55 -0000
From: Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v3 2/7] selftests/ima: define a set of common functions
Date: Mon, 11 Mar 2019 07:41:08 -0400
In-Reply-To: <1552304473-3966-1-git-send-email-zohar@linux.ibm.com>
References: <1552304473-3966-1-git-send-email-zohar@linux.ibm.com>
Message-Id: <1552304473-3966-3-git-send-email-zohar@linux.ibm.com>
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

Define, update and move get_secureboot_mode() to a common file for use
by other tests.

Updated to check both the efivar SecureBoot-$(UUID) and
SetupMode-$(UUID), based on Dave Young's review.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Cc: Dave Young <dyoung@redhat.com>
---
 tools/testing/selftests/ima/Makefile           |  1 +
 tools/testing/selftests/ima/ima_common_lib.sh  | 36 ++++++++++++++++++++++++++
 tools/testing/selftests/ima/test_kexec_load.sh | 17 +++---------
 3 files changed, 40 insertions(+), 14 deletions(-)
 create mode 100755 tools/testing/selftests/ima/ima_common_lib.sh

diff --git a/tools/testing/selftests/ima/Makefile b/tools/testing/selftests/ima/Makefile
index 0b3adf5444b6..04501516831b 100644
--- a/tools/testing/selftests/ima/Makefile
+++ b/tools/testing/selftests/ima/Makefile
@@ -5,6 +5,7 @@ ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 ifeq ($(ARCH),x86)
 TEST_PROGS := test_kexec_load.sh
+TEST_FILES := ima_common_lib.sh
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/ima/ima_common_lib.sh b/tools/testing/selftests/ima/ima_common_lib.sh
new file mode 100755
index 000000000000..403666247b10
--- /dev/null
+++ b/tools/testing/selftests/ima/ima_common_lib.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+# Check efivar SecureBoot-$(the UUID) and SetupMode-$(the UUID).
+# The secure boot mode can be accessed either as the last integer
+# of "od -An -t u1 /sys/firmware/efi/efivars/SecureBoot-*" or from
+# "od -An -t u1 /sys/firmware/efi/vars/SecureBoot-*/data".  The efi
+# SetupMode can be similarly accessed.
+# Return 1 for SecureBoot mode enabled and SetupMode mode disabled.
+get_secureboot_mode()
+{
+	local efivarfs="/sys/firmware/efi/efivars"
+	local secure_boot_file=$efivarfs/../vars/SecureBoot-*/data
+	local setup_mode_file=$efivarfs/../vars/SetupMode-*/data
+	local secureboot_mode=0
+	local setup_mode=0
+
+	# Make sure that efivars is mounted in the normal location
+	if ! grep -q "^\S\+ $efivarfs efivarfs" /proc/mounts; then
+		log_skip "efivars is not mounted on $efivarfs"
+	fi
+
+	if [ ! -e $secure_boot_file ] || [ ! -e $setup_mode_file ]; then
+		log_skip "unknown secureboot/setup mode"
+	fi
+
+	secureboot_mode=`od -An -t u1 $secure_boot_file`
+	setup_mode=`od -An -t u1 $setup_mode_file`
+
+	if [ $secureboot_mode -eq 1 ] && [ $setup_mode -eq 0 ]; then
+		log_info "ima: secure boot mode enabled"
+		return 1;
+	fi
+	log_info "secure boot mode not enabled"
+	return 0;
+}
diff --git a/tools/testing/selftests/ima/test_kexec_load.sh b/tools/testing/selftests/ima/test_kexec_load.sh
index 36f3089ac225..e84139c1506b 100755
--- a/tools/testing/selftests/ima/test_kexec_load.sh
+++ b/tools/testing/selftests/ima/test_kexec_load.sh
@@ -5,7 +5,7 @@
 # is booted in secureboot mode.
 
 TEST="$0"
-EFIVARFS="/sys/firmware/efi/efivars"
+. ./ima_common_lib.sh
 rc=0
 
 # Kselftest framework requirement - SKIP code is 4.
@@ -17,19 +17,8 @@ if [ $(id -ru) -ne 0 ]; then
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
