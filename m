Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gzLwj-00079W-1e
 for kexec@lists.infradead.org; Thu, 28 Feb 2019 13:41:58 +0000
Date: Thu, 28 Feb 2019 21:41:46 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 2/3] scripts/ima: define a set of common functions
Message-ID: <20190228134146.GA7528@dhcp-128-65.nay.redhat.com>
References: <1548960936-7800-1-git-send-email-zohar@linux.ibm.com>
 <1548960936-7800-3-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548960936-7800-3-git-send-email-zohar@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, linux-integrity@vger.kernel.org

Hi Mimi,
 
Sorry for jumping in late, just noticed this kexec selftests, I think we
also need a kexec load test not only for ima, but for general kexec

On 01/31/19 at 01:55pm, Mimi Zohar wrote:
> Define and move get_secureboot_mode() to a common file for use by other
> tests.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  tools/testing/selftests/ima/common_lib.sh      | 20 ++++++++++++++++++++
>  tools/testing/selftests/ima/test_kexec_load.sh | 17 +++--------------
>  2 files changed, 23 insertions(+), 14 deletions(-)
>  create mode 100755 tools/testing/selftests/ima/common_lib.sh
> 
> diff --git a/tools/testing/selftests/ima/common_lib.sh b/tools/testing/selftests/ima/common_lib.sh
> new file mode 100755
> index 000000000000..ae097a634da5
> --- /dev/null
> +++ b/tools/testing/selftests/ima/common_lib.sh
> @@ -0,0 +1,20 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +get_secureboot_mode()
> +{
> +	EFIVARFS="/sys/firmware/efi/efivars"
> +	# Make sure that efivars is mounted in the normal location
> +	if ! grep -q "^\S\+ $EFIVARFS efivarfs" /proc/mounts; then
> +		echo "$TEST: efivars is not mounted on $EFIVARFS" >&2
> +		exit $ksft_skip
> +	fi
> +
> +	# Get secureboot mode
> +	file="$EFIVARFS/SecureBoot-*"
> +	if [ ! -e $file ]; then
> +		echo "$TEST: unknown secureboot mode" >&2
> +		exit $ksft_skip
> +	fi
> +	return `hexdump $file | awk '{print substr($4,length($4),1)}'`
> +}

Do you want to get the Secureboot status here?
I got some advice from Peter Jones previously, thus we have below
in our kdump scripts:
https://src.fedoraproject.org/cgit/rpms/kexec-tools.git/tree/kdump-lib.sh
 
See the function is_secure_boot_enforced(), probably you can refer to
that function and check setup mode as well.

> diff --git a/tools/testing/selftests/ima/test_kexec_load.sh b/tools/testing/selftests/ima/test_kexec_load.sh
> index 74423c4229e2..5e3566738888 100755
> --- a/tools/testing/selftests/ima/test_kexec_load.sh
> +++ b/tools/testing/selftests/ima/test_kexec_load.sh
> @@ -5,7 +5,7 @@
>  # is booted in secureboot mode.
>  
>  TEST="$0"
> -EFIVARFS="/sys/firmware/efi/efivars"
> +. ./common_lib.sh
>  rc=0
>  
>  # Kselftest framework requirement - SKIP code is 4.
> @@ -17,19 +17,8 @@ if [ $(id -ru) != 0 ]; then
>  	exit $ksft_skip
>  fi
>  
> -# Make sure that efivars is mounted in the normal location
> -if ! grep -q "^\S\+ $EFIVARFS efivarfs" /proc/mounts; then
> -	echo "$TEST: efivars is not mounted on $EFIVARFS" >&2
> -	exit $ksft_skip
> -fi
> -
> -# Get secureboot mode
> -file="$EFIVARFS/SecureBoot-*"
> -if [ ! -e $file ]; then
> -	echo "$TEST: unknown secureboot mode" >&2
> -	exit $ksft_skip
> -fi
> -secureboot=`hexdump $file | awk '{print substr($4,length($4),1)}'`
> +get_secureboot_mode
> +secureboot=$?
>  
>  # kexec_load should fail in secure boot mode
>  KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
> -- 
> 2.7.5
> 
Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
