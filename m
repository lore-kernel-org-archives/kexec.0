Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dChU1-0002Iq-Il
 for kexec@lists.infradead.org; Mon, 22 May 2017 07:10:27 +0000
Received: by mail-pf0-f169.google.com with SMTP id 9so73376925pfj.1
 for <kexec@lists.infradead.org>; Mon, 22 May 2017 00:10:05 -0700 (PDT)
Subject: Re: [PATCH v2] kexec/kdump: Minor Documentation updates for arm64 and
 Image
References: <1495104793-6563-1-git-send-email-Bharat.Bhushan@nxp.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <2eab1d0a-c147-8364-8fb8-4efbea879992@redhat.com>
Date: Mon, 22 May 2017 12:39:59 +0530
MIME-Version: 1.0
In-Reply-To: <1495104793-6563-1-git-send-email-Bharat.Bhushan@nxp.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bharat Bhushan <Bharat.Bhushan@nxp.com>, dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com, corbet@lwn.net, takahiro.akashi@linaro.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org



On Thursday 18 May 2017 04:23 PM, Bharat Bhushan wrote:
> This patch have minor updates in Documentation for arm64i as
                                                     arm64
> relocatable kernel.
> Also this patch updates documentation for using uncompressed
> image "Image" which is used for ARM64.
>
> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> ---
> v1->v2
>   - "a uncompressed" replaced with "an uncompressed"

Reviewed-by: Pratyush Anand <panand@redhat.com>

>
>  Documentation/kdump/kdump.txt | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
> index 615434d..5181445 100644
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
> @@ -339,7 +339,7 @@ For arm:
>  For arm64:
>  	- Use vmlinux or Image
>
> -If you are using a uncompressed vmlinux image then use following command
> +If you are using an uncompressed vmlinux image then use following command
>  to load dump-capture kernel.
>
>     kexec -p <dump-capture-kernel-vmlinux-image> \
> @@ -361,6 +361,12 @@ to load dump-capture kernel.
>     --dtb=<dtb-for-dump-capture-kernel> \
>     --append="root=<root-dev> <arch-specific-options>"
>
> +If you are using an uncompressed Image, then use following command
> +to load dump-capture kernel.
> +
> +   kexec -p <dump-capture-kernel-Image> \
> +   --initrd=<initrd-for-dump-capture-kernel> \
> +   --append="root=<root-dev> <arch-specific-options>"
>
>  Please note, that --args-linux does not need to be specified for ia64.
>  It is planned to make this a no-op on that architecture, but for now
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
