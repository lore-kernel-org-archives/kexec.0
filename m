Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UKpTP-0004iR-EZ
 for kexec@lists.infradead.org; Wed, 27 Mar 2013 12:29:01 +0000
Date: Wed, 27 Mar 2013 21:28:57 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/1 v1] the recommended crash memory reservation is too
 small for x86_64.
Message-ID: <20130327122856.GK17248@verge.net.au>
References: <1364209009-11592-1-git-send-email-zhouzhouyi@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1364209009-11592-1-git-send-email-zhouzhouyi@gmail.com>
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
To: zhouzhouyi@gmail.com
Cc: yizhouzhou@ict.ac.cn, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, linux-doc@vger.kernel.org

On Mon, Mar 25, 2013 at 06:56:49PM +0800, zhouzhouyi@gmail.com wrote:
> From: root <root@zzy-Lenovo.(none)>

The above line is bogus.

>  On Documentation/kdump/kdump.txt, section Boot into  System Kernel: On x86 and x86_64, use
>  "crashkernel=64M@16M", but some OSes like ubuntu 12.10 use ram fs larger than 64M, so in these cases the
>  memory reserved for crashkernel should be at least 128M.

The above lines are way to wide. Something less than 80 columns is normal.

> Signed-off-by: Zhouyi Zhou <yizhouzhou@ict.ac.cn>
> ---
>  Documentation/kdump/kdump.txt |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
> index 13f1aa0..1e850e0 100644
> --- a/Documentation/kdump/kdump.txt
> +++ b/Documentation/kdump/kdump.txt
> @@ -290,7 +290,9 @@ Boot into System Kernel
>     "crashkernel=64M@16M" tells the system kernel to reserve 64 MB of memory
>     starting at physical address 0x01000000 (16MB) for the dump-capture kernel.
>  
> -   On x86 and x86_64, use "crashkernel=64M@16M".
> +   On x86 and x86_64, use "crashkernel=64M@16M" (some OSes use init ram fs larger
> +than 64M, for example ubuntu-12.10, use crashkernel=128M@16M instead, or dump-capture
> +kernel will out of memory).

I believe lines of kdmump.txt should also be 80 columns wide or less.

>     On ppc64, use "crashkernel=128M@32M".
>  
> -- 
> 1.7.10.4
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
