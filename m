Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K19Dg-00061o-Pa
	for kexec@lists.infradead.org; Wed, 28 May 2008 00:08:45 +0000
Date: Wed, 28 May 2008 10:08:37 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: Fix build without cross compilation
Message-ID: <20080528000835.GC6752@verge.net.au>
References: <20080525154652.12e1dd00@kopernikus.site>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080525154652.12e1dd00@kopernikus.site>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org, Jamey Sharp <jamey@thetovacompany.com>

On Sun, May 25, 2008 at 03:46:52PM +0200, Bernhard Walle wrote:
> This patch fixes build on "normal" Linux hosts without cross compiler.
> The regression was introduced with
> 
>     commit 6f95d707544ab3417673990e6a78b27b79737856
>     Author: Jamey Sharp <jamey@thetovacompany.com>
>     Date:   Thu May 15 17:03:09 2008 -0700
> 
>     Use target CC and LD to build kdump and kexec_test.
>     
>     Signed-off-by: Jamey Sharp <jamey@thetovacompany.com>
>     Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>

Hi Bernhard,

I have to confess that I am not seeing this problem.
However the change looks sensible so I have gone ahead and applied
it anyway.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
