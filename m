Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8mEx-0004iN-TV
 for kexec@lists.infradead.org; Tue, 26 Mar 2019 13:35:52 +0000
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2QDZXaA115513
 for <kexec@lists.infradead.org>; Tue, 26 Mar 2019 09:35:41 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rfmymgdpe-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 26 Mar 2019 09:35:38 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Tue, 26 Mar 2019 13:35:18 -0000
From: Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v5 6/9] selftests/kexec: kexec_file_load syscall test
Date: Tue, 26 Mar 2019 09:34:14 -0400
In-Reply-To: <1553607257-18906-1-git-send-email-zohar@linux.ibm.com>
References: <1553607257-18906-1-git-send-email-zohar@linux.ibm.com>
Message-Id: <1553607257-18906-7-git-send-email-zohar@linux.ibm.com>
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

The kernel can be configured to verify PE signed kernel images, IMA
kernel image signatures, both types of signatures, or none.  This test
verifies only properly signed kernel images are loaded into memory,
based on the kernel configuration and runtime policies.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 tools/testing/selftests/kexec/Makefile             |   4 +-
 tools/testing/selftests/kexec/kexec_common_lib.sh  |  99 ++++++++++
 .../selftests/kexec/test_kexec_file_load.sh        | 203 +++++++++++++++++++++
 tools/testing/selftests/kexec/test_kexec_load.sh   |   1 -
 4 files changed, 304 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/kexec/test_kexec_file_load.sh

diff --git a/tools/testing/selftests/kexec/Makefile b/tools/testing/selftests/kexec/Makefile
index 1a795861040b..8e9b27a7452f 100644
--- a/tools/testing/selftests/kexec/Makefile
+++ b/tools/testing/selftests/kexec/Makefile
@@ -1,10 +1,10 @@
-# Makefile for kexec_load
+# Makefile for kexec tests
 
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 ifeq ($(ARCH),x86)
-TEST_PROGS := test_kexec_load.sh
+TEST_PROGS := test_kexec_load.sh test_kexec_file_load.sh
 TEST_FILES := kexec_common_lib.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/kexec/kexec_common_lib.sh b/tools/testing/selftests/kexec/kexec_common_lib.sh
index 1af892cee726..51ae64c79c41 100755
--- a/tools/testing/selftests/kexec/kexec_common_lib.sh
+++ b/tools/testing/selftests/kexec/kexec_common_lib.sh
@@ -4,6 +4,9 @@
 # Kselftest framework defines: ksft_pass=0, ksft_fail=1, ksft_skip=4
 
 VERBOSE="${VERBOSE:-1}"
+IKCONFIG="/tmp/config-`uname -r`"
+KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
+SECURITYFS=$(grep "securityfs" /proc/mounts | awk '{print $2}')
 
 log_info()
 {
@@ -74,3 +77,99 @@ require_root_privileges()
 		log_skip "requires root privileges"
 	fi
 }
+
+# Look for config option in Kconfig file.
+# Return 1 for found and 0 for not found.
+kconfig_enabled()
+{
+	local config="$1"
+	local msg="$2"
+
+	grep -E -q $config $IKCONFIG
+	if [ $? -eq 0 ]; then
+		log_info "$msg"
+		return 1
+	fi
+	return 0
+}
+
+# Attempt to get the kernel config first via proc, and then by
+# extracting it from the kernel image or the configs.ko using
+# scripts/extract-ikconfig.
+# Return 1 for found.
+get_kconfig()
+{
+	local proc_config="/proc/config.gz"
+	local module_dir="/lib/modules/`uname -r`"
+	local configs_module="$module_dir/kernel/kernel/configs.ko"
+
+	if [ ! -f $proc_config ]; then
+		modprobe configs > /dev/null 2>&1
+	fi
+	if [ -f $proc_config ]; then
+		cat $proc_config | gunzip > $IKCONFIG 2>/dev/null
+		if [ $? -eq 0 ]; then
+			return 1
+		fi
+	fi
+
+	local extract_ikconfig="$module_dir/source/scripts/extract-ikconfig"
+	if [ ! -f $extract_ikconfig ]; then
+		log_skip "extract-ikconfig not found"
+	fi
+
+	$extract_ikconfig $KERNEL_IMAGE > $IKCONFIG 2>/dev/null
+	if [ $? -eq 1 ]; then
+		if [ ! -f $configs_module ]; then
+			log_skip "CONFIG_IKCONFIG not enabled"
+		fi
+		$extract_ikconfig $configs_module > $IKCONFIG
+		if [ $? -eq 1 ]; then
+			log_skip "CONFIG_IKCONFIG not enabled"
+		fi
+	fi
+	return 1
+}
+
+# Make sure that securityfs is mounted
+mount_securityfs()
+{
+	if [ -z $SECURITYFS ]; then
+		SECURITYFS=/sys/kernel/security
+		mount -t securityfs security $SECURITYFS
+	fi
+
+	if [ ! -d "$SECURITYFS" ]; then
+		log_fail "$SECURITYFS :securityfs is not mounted"
+	fi
+}
+
+# The policy rule format is an "action" followed by key-value pairs.  This
+# function supports up to two key-value pairs, in any order.
+# For example: action func=<keyword> [appraise_type=<type>]
+# Return 1 for found and 0 for not found.
+check_ima_policy()
+{
+	local action="$1"
+	local keypair1="$2"
+	local keypair2="$3"
+	local ret=0
+
+	mount_securityfs
+
+	local ima_policy=$SECURITYFS/ima/policy
+	if [ ! -e $ima_policy ]; then
+		log_fail "$ima_policy not found"
+	fi
+
+	if [ -n $keypair2 ]; then
+		grep -e "^$action.*$keypair1" "$ima_policy" | \
+			grep -q -e "$keypair2"
+	else
+		grep -q -e "^$action.*$keypair1" "$ima_policy"
+	fi
+
+	# invert "grep -q" result, returning 1 for found.
+	[ $? -eq 0 ] && ret=1
+	return $ret
+}
diff --git a/tools/testing/selftests/kexec/test_kexec_file_load.sh b/tools/testing/selftests/kexec/test_kexec_file_load.sh
new file mode 100755
index 000000000000..4603282dd8b6
--- /dev/null
+++ b/tools/testing/selftests/kexec/test_kexec_file_load.sh
@@ -0,0 +1,203 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Loading a kernel image via the kexec_file_load syscall can verify either
+# the IMA signature stored in the security.ima xattr or the PE signature,
+# both signatures depending on the IMA policy, or none.
+#
+# To determine whether the kernel image is signed, this test depends
+# on pesign and getfattr.  This test also requires the kernel to be
+# built with CONFIG_IKCONFIG enabled and either CONFIG_IKCONFIG_PROC
+# enabled or access to the extract-ikconfig script.
+
+TEST="KEXEC_FILE_LOAD"
+. ./kexec_common_lib.sh
+
+trap "{ rm -f $IKCONFIG ; }" EXIT
+
+# Some of the IMA builtin policies may require the kexec kernel image to
+# be signed, but these policy rules may be replaced with a custom
+# policy.  Only CONFIG_IMA_APPRAISE_REQUIRE_KEXEC_SIGS persists after
+# loading a custom policy.  Check if it is enabled, before reading the
+# IMA runtime sysfs policy file.
+# Return 1 for IMA signature required and 0 for not required.
+is_ima_sig_required()
+{
+	local ret=0
+
+	kconfig_enabled "CONFIG_IMA_APPRAISE_REQUIRE_KEXEC_SIGS=y" \
+		"IMA kernel image signature required"
+	if [ $? -eq 1 ]; then
+		log_info "IMA signature required"
+		return 1
+	fi
+
+	# The architecture specific or a custom policy may require the
+	# kexec kernel image be signed.  Policy rules are walked
+	# sequentially.  As a result, a policy rule may be defined, but
+	# might not necessarily be used.  This test assumes if a policy
+	# rule is specified, that is the intent.
+	if [ $ima_read_policy -eq 1 ]; then
+		check_ima_policy "appraise" "func=KEXEC_KERNEL_CHECK" \
+			"appraise_type=imasig"
+		ret=$?
+		[ $ret -eq 1 ] && log_info "IMA signature required";
+	fi
+	return $ret
+}
+
+# The kexec_file_load_test() is complicated enough, require pesign.
+# Return 1 for PE signature found and 0 for not found.
+check_for_pesig()
+{
+	which pesign > /dev/null 2>&1 || log_skip "pesign not found"
+
+	pesign -i $KERNEL_IMAGE --show-signature | grep -q "No signatures"
+	local ret=$?
+	if [ $ret -eq 1 ]; then
+		log_info "kexec kernel image PE signed"
+	else
+		log_info "kexec kernel image not PE signed"
+	fi
+	return $ret
+}
+
+# The kexec_file_load_test() is complicated enough, require getfattr.
+# Return 1 for IMA signature found and 0 for not found.
+check_for_imasig()
+{
+	local ret=0
+
+	which getfattr > /dev/null 2>&1
+	if [ $?	-eq 1 ]; then
+		log_skip "getfattr not found"
+	fi
+
+	line=$(getfattr -n security.ima -e hex --absolute-names $KERNEL_IMAGE 2>&1)
+	echo $line | grep -q "security.ima=0x03"
+	if [ $? -eq 0 ]; then
+		ret=1
+		log_info "kexec kernel image IMA signed"
+	else
+		log_info "kexec kernel image not IMA signed"
+	fi
+	return $ret
+}
+
+kexec_file_load_test()
+{
+	local succeed_msg="kexec_file_load succeeded"
+	local failed_msg="kexec_file_load failed"
+	local key_msg="try enabling the CONFIG_INTEGRITY_PLATFORM_KEYRING"
+
+	line=$(kexec --load --kexec-file-syscall $KERNEL_IMAGE 2>&1)
+
+	if [ $? -eq 0 ]; then
+		kexec --unload --kexec-file-syscall
+
+		# In secureboot mode with an architecture  specific
+		# policy, make sure either an IMA or PE signature exists.
+		if [ $secureboot -eq 1 ] && [ $arch_policy -eq 1 ] && \
+			[ $ima_signed -eq 0 ] && [ $pe_signed -eq 0 ]; then
+			log_fail "$succeed_msg (missing sig)"
+		fi
+
+		if [ $kexec_sig_required -eq 1 -o $pe_sig_required -eq 1 ] \
+		     && [ $pe_signed -eq 0 ]; then
+			log_fail "$succeed_msg (missing PE sig)"
+		fi
+
+		if [ $ima_sig_required -eq 1 ] && [ $ima_signed -eq 0 ]; then
+			log_fail "$succeed_msg (missing IMA sig)"
+		fi
+
+		if [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 1 ] \
+		    && [ $ima_sig_required -eq 0 ] && [ $ima_signed -eq 0 ] \
+	            && [ $ima_read_policy -eq 0 ]; then
+			log_fail "$succeed_msg (possibly missing IMA sig)"
+		fi
+
+		if [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 0 ]; then
+			log_info "No signature verification required"
+		elif [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 1 ] \
+		    && [ $ima_sig_required -eq 0 ] && [ $ima_signed -eq 0 ] \
+	            && [ $ima_read_policy -eq 1 ]; then
+			log_info "No signature verification required"
+		fi
+
+		log_pass "$succeed_msg"
+	fi
+
+	# Check the reason for the kexec_file_load failure
+	echo $line | grep -q "Required key not available"
+	if [ $? -eq 0 ]; then
+		if [ $platform_keyring -eq 0 ]; then
+			log_pass "$failed_msg (-ENOKEY), $key_msg"
+		else
+			log_pass "$failed_msg (-ENOKEY)"
+		fi
+	fi
+
+	if [ $kexec_sig_required -eq 1 -o $pe_sig_required -eq 1 ] \
+	     && [ $pe_signed -eq 0 ]; then
+		log_pass "$failed_msg (missing PE sig)"
+	fi
+
+	if [ $ima_sig_required -eq 1 ] && [ $ima_signed -eq 0 ]; then
+		log_pass "$failed_msg (missing IMA sig)"
+	fi
+
+	if [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 1 ] \
+	    && [ $ima_sig_required -eq 0 ] && [ $ima_read_policy -eq 0 ] \
+	    && [ $ima_signed -eq 0 ]; then
+		log_pass "$failed_msg (possibly missing IMA sig)"
+	fi
+
+	log_pass "$failed_msg"
+	return 0
+}
+
+# kexec requires root privileges
+require_root_privileges
+
+# get the kernel config
+get_kconfig
+
+# Determine which kernel config options are enabled
+kconfig_enabled "CONFIG_IMA_APPRAISE=y" "IMA enabled"
+ima_appraise=$?
+
+kconfig_enabled "CONFIG_IMA_ARCH_POLICY=y" \
+	"architecture specific policy enabled"
+arch_policy=$?
+
+kconfig_enabled "CONFIG_INTEGRITY_PLATFORM_KEYRING=y" \
+	"platform keyring enabled"
+platform_keyring=$?
+
+kconfig_enabled "CONFIG_IMA_READ_POLICY=y" "reading IMA policy permitted"
+ima_read_policy=$?
+
+kconfig_enabled "CONFIG_KEXEC_SIG_FORCE=y" \
+	"kexec signed kernel image required"
+kexec_sig_required=$?
+
+kconfig_enabled "CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y" \
+	"PE signed kernel image required"
+pe_sig_required=$?
+
+is_ima_sig_required
+ima_sig_required=$?
+
+get_secureboot_mode
+secureboot=$?
+
+# Are there pe and ima signatures
+check_for_pesig
+pe_signed=$?
+
+check_for_imasig
+ima_signed=$?
+
+# Test loading the kernel image via kexec_file_load syscall
+kexec_file_load_test
diff --git a/tools/testing/selftests/kexec/test_kexec_load.sh b/tools/testing/selftests/kexec/test_kexec_load.sh
index 49545fcdc646..afd440ee23cb 100755
--- a/tools/testing/selftests/kexec/test_kexec_load.sh
+++ b/tools/testing/selftests/kexec/test_kexec_load.sh
@@ -14,7 +14,6 @@ get_secureboot_mode
 secureboot=$?
 
 # kexec_load should fail in secure boot mode
-KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
 kexec --load $KERNEL_IMAGE > /dev/null 2>&1
 if [ $? -eq 0 ]; then
 	kexec --unload
-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
