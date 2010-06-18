Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OPP6u-0002QT-CC
	for kexec@lists.infradead.org; Fri, 18 Jun 2010 00:07:05 +0000
Date: Fri, 18 Jun 2010 09:06:55 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: Unusable memory range type
Message-ID: <20100618000654.GJ16825@verge.net.au>
References: <E1OPI5S-0007ip-Iq@eag09.americas.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1OPI5S-0007ip-Iq@eag09.americas.sgi.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Cliff Wickman <cpw@sgi.com>
Cc: kexec@lists.infradead.org

On Thu, Jun 17, 2010 at 11:37:06AM -0500, Cliff Wickman wrote:
> 
> On SGI UV (x86_64) kexec grumbles about 'Unusable memory' ranges:
>    Unknown type (%s) while parsing %s. Please "
>    "report this as bug. Using RANGE_RESERVED now.
> 
> uv44-sys:~ # cat /proc/iomem
> 00000000-00000fff : System RAM
> 00001000-00005fff : reserved
> 00006000-0008efff : System RAM
> 0008f000-0008ffff : ACPI Non-volatile Storage
> 00090000-0009ffff : System RAM
> 00100000-75ffcfff : System RAM
>   01000000-0139dcaf : Kernel code
>   0139dcb0-0192c12f : Kernel data
>   01a28000-01cd7777 : Kernel bss
>   02000000-09ffffff : Crash kernel
> 75ffd000-76013fff : Unusable memory
> 76014000-766a6fff : System RAM
> 766a7000-766d6fff : Unusable memory
> ...
> 
> This patch keeps Unusable memory as another RANGE_RESERVED area, but
> without the warning message.
> 
> Diffed against git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools.git
> 
> Signed-off-by: Cliff Wickman <cpw@sgi.com>

Thanks, applied.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
