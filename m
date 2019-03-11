Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h3Sdz-0000qB-GX
 for kexec@lists.infradead.org; Mon, 11 Mar 2019 21:39:37 +0000
Date: Mon, 11 Mar 2019 22:39:29 +0100
From: Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH v3 2/7] selftests/ima: define a set of common functions
Message-ID: <20190311213929.GA13024@x230>
References: <1552304473-3966-1-git-send-email-zohar@linux.ibm.com>
 <1552304473-3966-3-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1552304473-3966-3-git-send-email-zohar@linux.ibm.com>
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>, linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org, Dave Young <dyoung@redhat.com>

Hi Mimi,

> Define, update and move get_secureboot_mode() to a common file for use
> by other tests.

> Updated to check both the efivar SecureBoot-$(UUID) and
> SetupMode-$(UUID), based on Dave Young's review.

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Cc: Dave Young <dyoung@redhat.com>

Minor comment below.

...
> +++ b/tools/testing/selftests/ima/ima_common_lib.sh
> @@ -0,0 +1,36 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Check efivar SecureBoot-$(the UUID) and SetupMode-$(the UUID).
> +# The secure boot mode can be accessed either as the last integer
> +# of "od -An -t u1 /sys/firmware/efi/efivars/SecureBoot-*" or from
> +# "od -An -t u1 /sys/firmware/efi/vars/SecureBoot-*/data".  The efi
> +# SetupMode can be similarly accessed.
> +# Return 1 for SecureBoot mode enabled and SetupMode mode disabled.
> +get_secureboot_mode()
> +{
> +	local efivarfs="/sys/firmware/efi/efivars"
> +	local secure_boot_file=$efivarfs/../vars/SecureBoot-*/data
> +	local setup_mode_file=$efivarfs/../vars/SetupMode-*/data
Sorry for nitpicking, but also quote variables these two variables
containing string:
	local secure_boot_file="$efivarfs/../vars/SecureBoot-*/data"
	local setup_mode_file="$efivarfs/../vars/SetupMode-*/data"

> +	local secureboot_mode=0
> +	local setup_mode=0
> +
> +	# Make sure that efivars is mounted in the normal location
> +	if ! grep -q "^\S\+ $efivarfs efivarfs" /proc/mounts; then
> +		log_skip "efivars is not mounted on $efivarfs"
> +	fi
> +
> +	if [ ! -e $secure_boot_file ] || [ ! -e $setup_mode_file ]; then
I prefer to quote every variable in [ ] (at least for -f -e -z -n,
to prevent shell behavior on empty (I know it's not necessary here):

f=; [ -e $f ]; echo $?
0
vs.
f=; [ -e "$f" ]; echo $?
1


Kind regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
