Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mta23.gyao.ne.jp ([125.63.38.249] helo=mx.gate01.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KYF6T-0002ni-CR
	for kexec@lists.infradead.org; Wed, 27 Aug 2008 07:06:05 +0000
Date: Wed, 27 Aug 2008 16:05:50 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 00/06] sh: Improved kexec support for SuperH
Message-ID: <20080827070550.GB18717@linux-sh.org>
References: <20080826111150.615.97501.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080826111150.615.97501.sendpatchset@rx1.opensource.se>
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
To: Magnus Damm <magnus.damm@gmail.com>
Cc: horms@verge.net.au, kexec@lists.infradead.org

On Tue, Aug 26, 2008 at 08:11:50PM +0900, Magnus Damm wrote:
> Here comes a few SuperH related patches. Trivial stuff - fixing up plain
> kexec support. Kdump is not ready yet. I also have have a few kdump changes
> in my local tree but they need more work.
> 
> [PATCH 01/06] sh: Add support for sh4al-dsp processors
> [PATCH 02/06] sh: Get system memory ranges from /proc/iomem
> [PATCH 03/06] sh: Add virtual addresses support
> [PATCH 04/06] sh: Autodetect zImage zero page address
> [PATCH 05/06] sh: Use dynamic zImage load address
> [PATCH 06/06] sh: Add vmlinux support
> 
> Tested with 2.6.27-rc on SuperH Mobile processor models sh7722/sh7723.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

FWIW:

Acked-by: Paul Mundt <lethal@linux-sh.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
