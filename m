Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1It5uF-0006jS-Je
	for kexec@lists.infradead.org; Fri, 16 Nov 2007 13:27:13 -0500
Date: Fri, 16 Nov 2007 10:26:51 -0800
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/5] Rename vmcoreinfo's macros returning the size
Message-ID: <20071116182646.GA8971@verge.net.au>
References: <473CFE14.3010400@mxs.nes.nec.co.jp>
	<473D015E.4030908@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <473D015E.4030908@mxs.nes.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>

On Fri, Nov 16, 2007 at 11:33:02AM +0900, Ken'ichi Ohmichi wrote:
> 
> VMCOREINFO_SIZE() should be renamed VMCOREINFO_STRUCT_SIZE() since it's always
> returning the size of the struct with a given name. This change would allow
> VMCOREINFO_TYPEDEF_SIZE() to simply become VMCOREINFO_SIZE() since it need not
> be used exclusively for typedefs.
> 
> This discussion is the following:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0709.3/0582.html
> 
> Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
> Acked-by: David Rientjes <rientjes@google.com>

As far as name changes go, this one looks good to me.

Acked-by: Simon Horman <horms@verge.net.au>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
