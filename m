Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1muRFn-006rO2-70
 for kexec@lists.infradead.org; Tue, 07 Dec 2021 03:34:56 +0000
Date: Tue, 7 Dec 2021 11:34:46 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kernel/crash_core: suppress unknown crashkernel
 parameter warning
Message-ID: <20211207033446.GC5604@MiWiFi-R3L-srv>
References: <20211206111733.4602-1-prudo@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211206111733.4602-1-prudo@redhat.com>
Content-Disposition: inline
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
To: Philipp Rudo <prudo@redhat.com>
Cc: kexec@lists.infradead.org, ahalaney@redhat.com, akpm@linux-foundation.org

On 12/06/21 at 12:17pm, Philipp Rudo wrote:
> When booting with crashkernel= on the kernel command line a warning
> similar to
> 
> [    0.038294] Kernel command line: ro console=ttyS0 crashkernel=256M
> [    0.038353] Unknown kernel command line parameters "crashkernel=256M", will be passed to user space.
> 
> is printed. This originates from crashkernel= being parsed independent from
> the early_param() mechanism. So the code in init/main.c doesn't know

Not only the early_param(), __setup() also takes the same mechanism.
It's just handled in different stage. You might need to call it kernel
param handling mechanism, not sure if it's accurate.

> that crashkernel= is a valid kernel parameter and prints this incorrect
> warning. Suppress the warning by adding a dummy early_param handler for
> crashkernel=.

The fix looks good to me, thanks.

Acked-by: Baoquan He <bhe@redhat.com>

By the way, on which arch did you find this issue? Ask because I am
wondering whether there's any other similiar independent kernel cmdline
handling from __setup_param(). If have, is there a chance to take a
common method to handle them, e.g a generic function or a place to
identify them. Just wild thought, I have no idea yet. Otherwise, we may
need several this kind of dummy handler for each one.

> 
> Fixes: 86d1919a4fb0 ("init: print out unknown kernel parameters")
> Signed-off-by: Philipp Rudo <prudo@redhat.com>
> ---
>  kernel/crash_core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index eb53f5ec62c9..256cf6db573c 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -6,6 +6,7 @@
>  
>  #include <linux/buildid.h>
>  #include <linux/crash_core.h>
> +#include <linux/init.h>
>  #include <linux/utsname.h>
>  #include <linux/vmalloc.h>
>  
> @@ -295,6 +296,16 @@ int __init parse_crashkernel_low(char *cmdline,
>  				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
>  }
>  
> +/*
> + * Add a dummy early_param handler to mark crashkernel= as a known command line
> + * parameter and suppress incorrect warnings in init/main.c.
> + */
> +static int __init parse_crashkernel_dummy(char *arg)
> +{
> +	return 0;
> +}
> +early_param("crashkernel", parse_crashkernel_dummy);
> +
>  Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>  			  void *data, size_t data_len)
>  {
> -- 
> 2.31.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
