Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W3HTQ-0001T3-FY
 for kexec@lists.infradead.org; Wed, 15 Jan 2014 03:49:01 +0000
Date: Wed, 15 Jan 2014 12:48:33 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: kexec-tools and multiboot breakage
Message-ID: <20140115034833.GA30883@verge.net.au>
References: <84k3e2lyde.wl%peter.chubb@nicta.com.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <84k3e2lyde.wl%peter.chubb@nicta.com.au>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Peter Chubb <peter.chubb@nicta.com.au>
Cc: kexec@lists.infradead.org

On Wed, Jan 15, 2014 at 01:25:49PM +1000, Peter Chubb wrote:
> Hi Simon,
>    When you get a moment, please check out
>    http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=735360
> 
> Quick summary:
>   If your kernel is configured to protect the first few pages of
>   physical memory, then low memory doesn't start at location 0 --- so
>   when scanning the memory ranges from /proc/iomem, the code in
>   kexec/arch/i386/kexec-multiboot-x86.c never fills in mem_lower.
> 
>   I think it's safe to assume that if a memory segment starts at 64k or
>   lower, it can be extended to location 0 because of the kernel
>   protection on a PC99-style architecture.

Hi Peter,

that approach seems reasonable to me. Could you formally post
the patch to the kexec list with me CCed? I would like a Signed-off-by
line. Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
