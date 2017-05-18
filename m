Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dBEFy-0000Ii-HB
 for kexec@lists.infradead.org; Thu, 18 May 2017 05:45:52 +0000
Date: Thu, 18 May 2017 13:45:22 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kexec/kdump: Minor Documentation updates for arm64 and
 Image
Message-ID: <20170518054522.GF29117@x1>
References: <1495085600-2645-1-git-send-email-Bharat.Bhushan@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1495085600-2645-1-git-send-email-Bharat.Bhushan@nxp.com>
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
To: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Cc: linux-doc@vger.kernel.org, corbet@lwn.net, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dyoung@redhat.com, vgoyal@redhat.com

On 05/18/17 at 11:03am, Bharat Bhushan wrote:
> This patch have minor updates in Documentation for arm64i as
> relocatable kernel.
> Also this patch updates documentation for using uncompressed
> image "Image" which is used for ARM64.
> 
> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> ---
>  Documentation/kdump/kdump.txt | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
> index 615434d..522ce13 100644
> --- a/Documentation/kdump/kdump.txt
> +++ b/Documentation/kdump/kdump.txt
> @@ -112,8 +112,8 @@ There are two possible methods of using Kdump.
>  2) Or use the system kernel binary itself as dump-capture kernel and there is
>     no need to build a separate dump-capture kernel. This is possible
>     only with the architectures which support a relocatable kernel. As
> -   of today, i386, x86_64, ppc64, ia64 and arm architectures support relocatable
> -   kernel.
> +   of today, i386, x86_64, ppc64, ia64, arm and arm64 architectures support
> +   relocatable kernel.
>  
>  Building a relocatable kernel is advantageous from the point of view that
>  one does not have to build a second kernel for capturing the dump. But
> @@ -361,6 +361,12 @@ to load dump-capture kernel.
>     --dtb=<dtb-for-dump-capture-kernel> \
>     --append="root=<root-dev> <arch-specific-options>"
>  
> +If you are using a uncompressed Image, then use following command
		    ~ an
> +to load dump-capture kernel.
> +
> +   kexec -p <dump-capture-kernel-Image> \
> +   --initrd=<initrd-for-dump-capture-kernel> \
> +   --append="root=<root-dev> <arch-specific-options>"
>  
>  Please note, that --args-linux does not need to be specified for ia64.
>  It is planned to make this a no-op on that architecture, but for now
> -- 
> 1.9.3
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
