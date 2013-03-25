Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UK5ak-0006PR-6R
 for kexec@lists.infradead.org; Mon, 25 Mar 2013 11:29:31 +0000
Message-ID: <5150350A.5050002@redhat.com>
Date: Mon, 25 Mar 2013 19:29:14 +0800
From: WANG Chao <chaowang@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1 v1] the recommended crash memory reservation is too
 small for x86_64.
References: <1364209009-11592-1-git-send-email-zhouzhouyi@gmail.com>
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

On 03/25/2013 06:56 PM, zhouzhouyi@gmail.com wrote:
> From: root <root@zzy-Lenovo.(none)>
> 
> 
>  On Documentation/kdump/kdump.txt, section Boot into  System Kernel: On x86 and x86_64, use
>  "crashkernel=64M@16M", but some OSes like ubuntu 12.10 use ram fs larger than 64M, so in these cases the
>  memory reserved for crashkernel should be at least 128M.

People use different initramfs generators for different purpose. That means
the size of initramfs and also its memory consuming can vary very much from
each other. You just can't list all these generators and their recommended
reserved memory here. Though I have to say crashkernel=128M is good choice.

I think it would be better to leave this to user or distribution itself to
determine how much memory should be reserved for crash kernel, then export
this value to kernel in some ways.

Thanks,
WANG Chao

> 
> 
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
>  
>     On ppc64, use "crashkernel=128M@32M".
>  
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
