Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqPqx-0003lC-Hz
 for kexec@lists.infradead.org; Sun, 03 Feb 2019 22:03:05 +0000
Date: Sun, 3 Feb 2019 23:02:58 +0100
From: Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH 3/3] selftests/ima: kexec_file_load syscall test
Message-ID: <20190203220258.GC4022@x230>
References: <1548960936-7800-1-git-send-email-zohar@linux.ibm.com>
 <1548960936-7800-4-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548960936-7800-4-git-send-email-zohar@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, linux-integrity@vger.kernel.org, Dave Young <dyoung@redhat.com>

Hi Mimi,

> The kernel can be configured to verify PE signed kernel images, IMA
> kernel image signatures, both types of signatures, or none.  This test
> verifies only properly signed kernel images are loaded into memory,
> based on the kernel configuration and runtime policies.

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +++ b/tools/testing/selftests/ima/test_kexec_file_load.sh
> @@ -0,0 +1,250 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0+
# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Loading a kernel image via the kexec_file_load syscall can verify either
> +# the IMA signature stored in the security.ima xattr or the PE signature,
> +# both signatures depending on the IMA policy, or none.
> +#
> +# To determine whether the kernel image is signed, this test depends
> +# on pesign and getfattr.  This test also requires the kernel to be
> +# built with CONFIG_IKCONFIG enabled and either CONFIG_IKCONFIG_PROC
> +# enabled or access to the extract-ikconfig script.
> +
> +VERBOSE=1
Maybe allow to disable verbose without source change?
VERBOSE="${VERBOSE:-1}"

> +EXTRACT_IKCONFIG=$(ls /lib/modules/`uname -r`/source/scripts/extract-ikconfig)
> +IKCONFIG=/tmp/config-`uname -r`
> +PROC_CONFIG="/proc/config.gz"
> +KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
> +PESIGN=/usr/bin/pesign
> +GETFATTR=/usr/bin/getfattr
> +
> +TEST="$0"
> +. ./common_lib.sh
> +
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +kconfig_enabled()
> +{
> +	RC=0
> +	egrep -q $1 $IKCONFIG
> +	if [ $? -eq 0 ]; then
> +		RC=1
> +	fi
> +	return $RC
> +}
This would be enough (grep with -e returns only 0 or 1):
kconfig_enabled()
{
	grep -E -q $1 $IKCONFIG
}
> +
> +# policy rule format: action func=<keyword> [appraise_type=<type>]
> +check_ima_policy()
> +{
> +	IMA_POLICY=/sys/kernel/security/ima/policy
> +
> +	RC=0
> +	if [ $# -eq 3 ]; then
> +		grep -e $2 $IMA_POLICY | grep -e "^$1.*$3" 2>&1 >/dev/null
> +	else
> +		grep -e $2 $IMA_POLICY | grep -e "^$1" 2>&1 >/dev/null
> +	fi
> +	if [ $? -eq 0 ]; then
> +		RC=1
> +	fi
> +	return $RC
> +}
This would be enough and more descriptive:
check_ima_policy()
{
	local action="$1"
	local keyword="$2"
	local type="$3"

	[ -n "$type" ] && type="appraise_type=$type"
	grep -q "^$action.*func=$keyword.*$type" /sys/kernel/security/ima/policy
}

> +
> +check_kconfig_options()
> +{
> +	# Attempt to get the kernel config first via proc, and then by
> +	# extracting it from the kernel image using scripts/extract-ikconfig.
> +	if [ ! -f $PROC_CONFIG ]; then
> +		modprobe configs 2>/dev/null
> +	fi
> +	if [ -f $PROC_CONFIG ]; then
> +		cat $PROC_CONFIG > $IKCONFIG
> +	fi
> +
> +	if [ ! -f $IKCONFIG ]; then
> +		if [ ! -f $EXTRACT_IKCONFIG ]; then
> +			echo "$TEST: requires access to extract-ikconfig" >&2
> +			exit $ksft_skip
> +		fi
> +
> +		$EXTRACT_IKCONFIG $KERNEL_IMAGE > $IKCONFIG
> +		kconfig_enabled "CONFIG_IKCONFIG=y"
> +		if [ $? -eq 0 ]; then
> +			echo "$TEST: requires the kernel to be built with CONFIG_IKCONFIG" >&2
> +			exit $ksft_skip
> +		fi
> +	fi
> +
> +	kconfig_enabled "CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y"
> +	pe_sig_required=$?
> +	if [ $VERBOSE -ne 0 ] && [ $pe_sig_required -eq 1 ]; then
> +		echo "$TEST: [INFO] PE signed kernel image required"
> +	fi
Checks for $VERBOSE here and in other kconfig_enabled usages bellow are a bit
redundant. And you check for assigned variable now and then later on,
you use these variables as global (and reset $ima_sig_required in
check_runtime().

How about using functions instead:
log_info()
{
	echo "$TEST: [INFO] $1"
}
(Reducing some duplicity, IMHO helper functions in shell library used in all
selftest tests would be useful)

kconfig_enabled()
{
	local config="$1"
	local msg="$2"
	local ret

	grep -E -q $config $IKCONFIG
	ret=$?
	[ $VERBOSE -ne 0 ] && [ $ret -eq 1 ] && log_info "$msg"
	return $ret
}

ima_sig_enabled()
{
	kconfig_enabled "CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y" \
		"PE signed kernel image required"
}

ima_sig_enabled()
{
	kconfig_enabled "CONFIG_IMA_APPRAISE_REQUIRE_KEXEC_SIGS=y" \
		"IMA kernel image signature required"
}
Warning is printed each time, but that's deliberate.
If it's not wanted, it can be moved into setup.

...
> +check_kconfig_options
> +check_for_apps
> +check_runtime
> +check_for_sigs
> +kexec_file_load_test

> +rc=$?
> +exit $rc
These two are redundant.

Kind regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
