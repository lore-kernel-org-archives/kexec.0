Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ee37L-00080F-31
 for kexec@lists.infradead.org; Tue, 23 Jan 2018 18:16:20 +0000
Date: Tue, 23 Jan 2018 19:15:55 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v1] kexec-tools: Tweak run-time handling of libxenctrl.so
Message-ID: <20180123181555.GN4675@olila.local.net-space.pl>
References: <1516729169-11871-1-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1516729169-11871-1-git-send-email-eric.devolder@oracle.com>
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

Hi Eric,

On Tue, Jan 23, 2018 at 11:39:29AM -0600, Eric DeVolder wrote:
> This patch is a follow-on to commit 43d3932e "kexec-tools: Perform
> run-time linking of libxenctrl.so". This patch addresses feedback
> from Daniel Kiper concerning the lack of a dlclose() and the desire
> to make xc_dlhandle static, rather than extern.
>
> In the original patch, the call to dlclose() was omitted, in contrast
> to the description in the commit message. This patch inserts the call.
> Note that this dynamic linking feature is dependent upon the proper
> operation of the RTLD_NODELETE flag to dlopen(), which does work as
> advertised on Linux (otherwise the call to dlclose() should be omitted).
>
> This patch also implements Daniel's suggestion to make the
> xc_dlhandle variable static.
>
> This patch has been re-tested per scenarios outlined in the original
> patch commit message.

Please split this patch into two separate patches. One for dlclose() change
and one for static xc_dlhandle change. This will help people who will be
doing git bisect in the future. In general it is much appreciated to
provide one logical change per patch.

> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
> v1: 23jan2018
>  - Implemented feedback from Daniel Kiper
> ---
>  kexec/kexec-xen.c | 13 ++++++++++++-
>  kexec/kexec-xen.h |  9 ++++-----
>  2 files changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
> index d42a45a..03ea4a8 100644
> --- a/kexec/kexec-xen.c
> +++ b/kexec/kexec-xen.c
> @@ -15,8 +15,18 @@
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
> +	if (xc_dlhandle)
> +		return dlsym(xc_dlhandle, symbol);
> +	else
> +		return NULL;

I am not sure why you need this "if (xc_dlhandle)...". I think that
"return dlsym(xc_dlhandle, symbol);" alone is sufficient here.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
