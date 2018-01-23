Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ee5fN-0000yI-LB
 for kexec@lists.infradead.org; Tue, 23 Jan 2018 20:59:39 +0000
Date: Tue, 23 Jan 2018 21:59:14 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v2 2/2] kexec-tools: Make xc_dlhandle static
Message-ID: <20180123205914.GQ4675@olila.local.net-space.pl>
References: <1516734771-14795-1-git-send-email-eric.devolder@oracle.com>
 <1516734771-14795-3-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1516734771-14795-3-git-send-email-eric.devolder@oracle.com>
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
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: andrew.cooper3@citrix.com, horms@verge.net.au, kexec@lists.infradead.org, konrad.wilk@oracle.com

On Tue, Jan 23, 2018 at 01:12:51PM -0600, Eric DeVolder wrote:
> This patch is a follow-on to commit 43d3932e "kexec-tools: Perform
> run-time linking of libxenctrl.so". This patch addresses feedback
> from Daniel Kiper.
>
> This patch implements Daniel's suggestion to make the
> xc_dlhandle variable static.
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

Just two nitpicks... Otherwise you can add

Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>

> ---
> v1: 23jan2018
>  - Implemented feedback from Daniel Kiper
>
> v2: 23jan2018
>  - Implemented feedback from Daniel Kiper
>  - Broke patch into two
> ---
>  kexec/kexec-xen.c | 9 ++++++++-
>  kexec/kexec-xen.h | 9 ++++-----
>  2 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
> index 75f8758..960fa16 100644
> --- a/kexec/kexec-xen.c
> +++ b/kexec/kexec-xen.c
> @@ -15,8 +15,15 @@
>  #include "crashdump.h"
>
>  #ifdef CONFIG_LIBXENCTRL_DL
> -void *xc_dlhandle;
> +/* The handle from dlopen(), needed by dlsym(), dlclose() */
> +static void *xc_dlhandle;
>  xc_hypercall_buffer_t XC__HYPERCALL_BUFFER_NAME(HYPERCALL_BUFFER_NULL);
> +
> +void *__xc_dlsym(const char *symbol)
> +{
> +	return dlsym(xc_dlhandle, symbol);
> +}
> +
>  xc_interface *__xc_interface_open(xentoollog_logger *logger,
>  				  xentoollog_logger *dombuild_logger,
>  				  unsigned open_flags)
> diff --git a/kexec/kexec-xen.h b/kexec/kexec-xen.h
> index ffb8743..8955334 100644
> --- a/kexec/kexec-xen.h
> +++ b/kexec/kexec-xen.h
> @@ -6,9 +6,8 @@
>
>  #ifdef CONFIG_LIBXENCTRL_DL
>  #include <dlfcn.h>

I think that you can drop this include too.

> -
> -/* The handle from dlopen(), needed by dlsym(), dlclose() */
> -extern void *xc_dlhandle;
> +/* Lookup symbols in libxenctrl.so */
> +void *__xc_dlsym(const char *symbol);

extern void *__xc_dlsym(const char *symbol);?

But then, IMO, you should put extern for __xc_interface_open()
and __xc_interface_close() below too. You can do it in separate
patch with Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
