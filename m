Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpTeY-001pq3-1M
 for kexec@lists.infradead.org; Tue, 23 Nov 2021 11:07:59 +0000
Date: Tue, 23 Nov 2021 19:07:43 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: update kdump maintainers
Message-ID: <20211123110743.GJ21646@MiWiFi-R3L-srv>
References: <YZyKilzKFsWJYdgn@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YZyKilzKFsWJYdgn@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, Andrew Morton <akpm@linux-foundation.org>

Hi Dave,

On 11/23/21 at 02:30pm, Dave Young wrote:
> Remove myself from kdump maintainers as I have no enough time to
> maintain it now. But I can review patches on demand though.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  MAINTAINERS |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-x86/MAINTAINERS
> ===================================================================
> --- linux-x86.orig/MAINTAINERS
> +++ linux-x86/MAINTAINERS
> @@ -10122,9 +10122,9 @@ F:	lib/Kconfig.kcsan
>  F:	scripts/Makefile.kcsan
>  
>  KDUMP
> -M:	Dave Young <dyoung@redhat.com>
>  M:	Baoquan He <bhe@redhat.com>
>  R:	Vivek Goyal <vgoyal@redhat.com>
> +R:	Dave Young <dyoung@redhat.com>

Thanks for the great work on reviewing kexec/kdump related patches, bug
fixing and improvement on kdump.

Acked-by: Baoquan He <bhe@redhat.com>

>  L:	kexec@lists.infradead.org
>  S:	Maintained
>  W:	http://lse.sourceforge.net/kdump/
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
