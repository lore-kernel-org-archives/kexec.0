Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KOBKs-0001YR-Cm
	for kexec@lists.infradead.org; Wed, 30 Jul 2008 13:03:22 +0000
Date: Wed, 30 Jul 2008 09:03:21 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch] kdump: update elfcorehdr documentation to reflect
	supported architectures
Message-ID: <20080730130321.GC16373@redhat.com>
References: <20080730003026.GA22106@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080730003026.GA22106@verge.net.au>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Wed, Jul 30, 2008 at 10:30:28AM +1000, Simon Horman wrote:
> IA64, PPC and SH also support the elfcorehdr command line.
> 
> Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> Index: linux-2.6/Documentation/kernel-parameters.txt
> ===================================================================
> --- linux-2.6.orig/Documentation/kernel-parameters.txt	2008-07-30 09:48:40.000000000 +1000
> +++ linux-2.6/Documentation/kernel-parameters.txt	2008-07-30 09:48:45.000000000 +1000
> @@ -688,7 +688,7 @@ and is between 256 and 4096 characters. 
>  			See Documentation/block/as-iosched.txt and
>  			Documentation/block/deadline-iosched.txt for details.
>  
> -	elfcorehdr=	[X86-32, X86_64]
> +	elfcorehdr=	[IA64,PPC,SH,X86-32,X86_64]
>  			Specifies physical address of start of kernel core
>  			image elf header. Generally kexec loader will
>  			pass this option to capture kernel.

Thanks Simon.

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Vivek


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
