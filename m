Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqOlH-000188-QJ
 for kexec@lists.infradead.org; Sun, 03 Feb 2019 20:53:09 +0000
Date: Sun, 3 Feb 2019 21:52:52 +0100
From: Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH 1/3] selftest/ima: cleanup the kexec selftest
Message-ID: <20190203205252.GA4022@x230>
References: <1548960936-7800-1-git-send-email-zohar@linux.ibm.com>
 <1548960936-7800-2-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548960936-7800-2-git-send-email-zohar@linux.ibm.com>
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

> Remove the few bashisms in the script and use the complete option name
> for clarity.

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  tools/testing/selftests/ima/test_kexec_load.sh | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

> diff --git a/tools/testing/selftests/ima/test_kexec_load.sh b/tools/testing/selftests/ima/test_kexec_load.sh
> index 1c10093fb526..74423c4229e2 100755
> --- a/tools/testing/selftests/ima/test_kexec_load.sh
> +++ b/tools/testing/selftests/ima/test_kexec_load.sh
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0+
# SPDX-License-Identifier: GPL-2.0-or-later
According to [1] GPL-2.0+ has been deprecated (but who cares).

...
> -	if [ "$secureboot" == "1" ]; then
> +kexec --load $KERNEL_IMAGE 2>&1 /dev/null
kexec --load $KERNEL_IMAGE 2>&1 >/dev/null
missing redirection.

> +if [ $? -eq 0 ]; then
> +	kexec --unload
> +	if [ $secureboot -eq 1 ]; then
>  		echo "$TEST: kexec_load succeeded [FAIL]"
>  		rc=1
>  	else
>  		echo "$TEST: kexec_load succeeded [PASS]"
>  	fi
It'd be nice, if selftest has some main library with helpers (like LTP has [2]),
to have unified output and reduce duplicity.


Kind regards,
Petr

[1] https://spdx.org/licenses/
[2] https://github.com/linux-test-project/ltp/blob/master/testcases/lib/tst_test.sh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
