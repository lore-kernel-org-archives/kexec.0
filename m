Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqPBK-0000Y1-1R
 for kexec@lists.infradead.org; Sun, 03 Feb 2019 21:20:03 +0000
Date: Sun, 3 Feb 2019 22:19:58 +0100
From: Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH 2/3] scripts/ima: define a set of common functions
Message-ID: <20190203211958.GB4022@x230>
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, linux-integrity@vger.kernel.org, Dave Young <dyoung@redhat.com>

Hi Mimi,

> Define and move get_secureboot_mode() to a common file for use by other
> tests.

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  tools/testing/selftests/ima/common_lib.sh      | 20 ++++++++++++++++++++
>  tools/testing/selftests/ima/test_kexec_load.sh | 17 +++--------------
>  2 files changed, 23 insertions(+), 14 deletions(-)
>  create mode 100755 tools/testing/selftests/ima/common_lib.sh

> diff --git a/tools/testing/selftests/ima/common_lib.sh b/tools/testing/selftests/ima/common_lib.sh
> new file mode 100755
> index 000000000000..ae097a634da5
> --- /dev/null
> +++ b/tools/testing/selftests/ima/common_lib.sh
> @@ -0,0 +1,20 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0+
# SPDX-License-Identifier: GPL-2.0-or-later

> +
> +get_secureboot_mode()
> +{
> +	EFIVARFS="/sys/firmware/efi/efivars"
	local efivarfs="/sys/firmware/efi/efivars"
	local file
It's a good practise to use local keyword and lower case the name of the
variable for variables used only locally (if you treat $EFIVARFS as constant,
I'd move it outside of get_secureboot_mode()).
I personally try to avoid using global variables (except constant like).

> +	# Make sure that efivars is mounted in the normal location
> +	if ! grep -q "^\S\+ $EFIVARFS efivarfs" /proc/mounts; then
> +		echo "$TEST: efivars is not mounted on $EFIVARFS" >&2
> +		exit $ksft_skip
> +	fi
There could be helper function printing error and exit in selftest library.

> +	# Get secureboot mode
> +	file="$EFIVARFS/SecureBoot-*"
	file="$efivarfs/SecureBoot-*"

...
>  KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
Another candidate for helper for potential selftest library.

Kind regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
