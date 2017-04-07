Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cwa1S-00019H-8Y
 for kexec@lists.infradead.org; Fri, 07 Apr 2017 19:58:24 +0000
Date: Fri, 7 Apr 2017 21:57:44 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v0] Fix broken Xen support in configure.ac
Message-ID: <20170407195744.GP4372@olila.local.net-space.pl>
References: <1491574386-14764-1-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1491574386-14764-1-git-send-email-eric.devolder@oracle.com>
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

On Fri, Apr 07, 2017 at 09:13:06AM -0500, Eric DeVolder wrote:
> Commit 2cf7cb9a "kexec: implemented XEN KEXEC STATUS to determine
> if an image is loaded" added configure-time detection of the
> kexec_status() call, but in doing so had the unintended side
> effect of disabling support for Xen altogether due to the
> missing HAVE_LIBXENCTRL=1. This corrects the broken behavior
> while still maintaining the original intention of detecting
> support for kexec_status() call.

In general Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
but two nitpicks.

You do not need v0 in subject if you post first patch. Plain
"[PATCH]" (of course without quotes) is sufficient.

> ---
> Broken behavior (HAVE_LIBXENCTRL is missing altogether):
>   ...
>   checking xenctrl.h usability... yes
>   checking xenctrl.h presence... yes
>   checking for xenctrl.h... yes
>   checking for xc_kexec_load in -lxenctrl... yes
>   checking for xc_kexec_status in -lxenctrl... yes
>
>   in include/config.h:
>   /* The kexec_status call is available */
>   #define HAVE_KEXEC_CMD_STATUS 1
>
> Fixed behaviour (restores HAVE_LIBXENCTRL):
>   ...
>   checking xenctrl.h usability... yes
>   checking xenctrl.h presence... yes
>   checking for xenctrl.h... yes
>   checking for xc_kexec_load in -lxenctrl... yes
>   checking for xc_kexec_status in -lxenctrl... yes
>
>   in include/config.h:
>   /* The kexec_status call is available */
>   #define HAVE_KEXEC_CMD_STATUS 1
>   /* Define to 1 if you have the `xenctrl' library (-lxenctrl). */
>   #define HAVE_LIBXENCTRL 1
>
> Reported-and-Tested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

Reported-and-Tested-by, Signed-off-by et consortes should be just
before first "---". Otherwise "git am" will drop all of them.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
