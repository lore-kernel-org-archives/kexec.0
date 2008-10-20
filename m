Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kroya-0004FV-RG
	for kexec@lists.infradead.org; Mon, 20 Oct 2008 07:14:53 +0000
Date: Mon, 20 Oct 2008 09:14:33 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] kdump: Fix invalid access on i386 sparsemem.
Message-ID: <20081020071433.GC12131@elte.hu>
References: <48FC0E68.50902@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48FC0E68.50902@mxs.nes.nec.co.jp>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: "H. Peter Anvin" <hpa@zytor.com>, kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, Huang Ying <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Yinghai Lu <yinghai@kernel.org>, Thomas Gleixner <tglx@linutronix.de>


* Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp> wrote:

> 
> Hi,
> 
> Since linux-2.6.27, kdump has failed on i386 sparsemem kernel.
> 1st-kernel gets a panic just before switching to 2nd-kernel.
> 
> The cause is that a kernel accesses invalid mem_section by
> page_to_pfn(image->swap_page) at machine_kexec().
> image->swap_page is allocated if kexec for hibernation, but
> it is not allocated if kdump. So if kdump, a kernel should
> not access the mem_section corresponding to image->swap_page.
> The attached patch fixes this invalid access.

applied to tip/x86/urgent, thanks!

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
