Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JWNGM-000718-Na
	for kexec@lists.infradead.org; Tue, 04 Mar 2008 02:52:19 +0000
Date: Tue, 4 Mar 2008 11:52:13 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] ia64 kern_vaddr_start was calculated incorrectly
Message-ID: <20080304025210.GA8331@verge.net.au>
References: <47CCAB96.2030207@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47CCAB96.2030207@sgi.com>
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
To: Jay Lan <jlan@sgi.com>
Cc: kexec@lists.infradead.org, Jonathan Lim <jlim@sgi.com>

On Mon, Mar 03, 2008 at 05:53:26PM -0800, Jay Lan wrote:
> I tested in a rhel5.1 root with:
>    2.6.24 kernel
>    kexec-tools-testing-20080227
>    crash-4.0-5.1
> 
> Crash failed to initialize:
> 
> crash: read error: kernel virtual address: a0000001007f0868  type:
> "kernel_config_data"
> WARNING: cannot read kernel_config_data
> crash: read error: kernel virtual address: a000000100f370b0  type: "xtime"
> 
> It turned out that the kexec sets info->kern_vaddr_start incorrectly
> on ia64 platform.
> 
> Jonathan Lim posted a fix to the fastboot list in March 2007:
> https://lists.linux-foundation.org/pipermail/fastboot/2007-March/013645.html
> This patch derived from Jonathan's patch, but fixes the problem at
> kexec/arch/ia64/crashdump-ia64.c.
> 
> 
> Signed-off-by: Jay Lan  <jlan@sgi.com>

Thanks Jay, Thanks Jonathan.

Sorry for not picking this up earlier. I have applied it now.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
