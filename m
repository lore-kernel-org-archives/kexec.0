Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fDt4c-0008F5-Vi
 for kexec@lists.infradead.org; Wed, 02 May 2018 14:49:40 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1523572911-16363-3-git-send-email-zohar@linux.vnet.ibm.com>
Date: Wed, 02 May 2018 09:45:30 -0500
In-Reply-To: <1523572911-16363-3-git-send-email-zohar@linux.vnet.ibm.com>
 (Mimi Zohar's message of "Thu, 12 Apr 2018 18:41:50 -0400")
Message-ID: <87h8nqglpx.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] kexec: call LSM hook for kexec_load syscall
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> Allow LSMs and IMA to differentiate between the kexec_load and
> kexec_file_load syscalls by adding an "unnecessary" call to
> security_kernel_read_file() in kexec_load.  This would be similar to the
> existing init_module syscall calling security_kernel_read_file().

Given the reasonable desire to load a policy that ensures everything
has a signature I don't have fundamental objections.

security_kernel_read_file as a hook seems an odd choice.  At the very
least it has a bad name because there is no file reading going on here.

I am concerned that I don't see CONFIG_KEXEC_VERIFY_SIG being tested
anywhere.  Which means I could have a kernel compiled without that and I
would be allowed to use kexec_file_load without signature checking.
While kexec_load would be denied.

Am I missing something here?

Eric



> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  kernel/kexec.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index aed8fb2564b3..d1386cfc6796 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -11,6 +11,7 @@
>  #include <linux/capability.h>
>  #include <linux/mm.h>
>  #include <linux/file.h>
> +#include <linux/security.h>
>  #include <linux/kexec.h>
>  #include <linux/mutex.h>
>  #include <linux/list.h>
> @@ -195,11 +196,21 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>  static inline int kexec_load_check(unsigned long nr_segments,
>  				   unsigned long flags)
>  {
> +	int result;
> +
>  	/* We only trust the superuser with rebooting the system. */
>  	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
>  		return -EPERM;
>  
>  	/*
> +	 * Allow LSMs and IMA to differentiate between kexec_load and
> +	 * kexec_file_load syscalls.
> +	 */
> +	result = security_kernel_read_file(NULL, READING_KEXEC_IMAGE);
> +	if (result < 0)
> +		return result;
> +
> +	/*
>  	 * Verify we have a legal set of flags
>  	 * This leaves us room for future extensions.
>  	 */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
