Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HlK2t-0004DR-GJ
	for kexec@lists.infradead.org; Tue, 08 May 2007 03:24:53 -0400
Date: Tue, 8 May 2007 16:23:25 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: kexec/kdump: Use generic elf code on ia64
Message-ID: <20070508072323.GB31881@verge.net.au>
References: <20070425090903.GA26412@verge.net.au>
	<20070508063239.GA31881@verge.net.au>
	<1178607344.2613.9.camel@linux-znh>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1178607344.2613.9.camel@linux-znh>
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
To: Zou Nan hai <nanhai.zou@intel.com>
Cc: kexec@lists.infradead.org, Linux-IA64 <linux-ia64@vger.kernel.org>, Vivek Goyal <vgoyal@in.ibm.com>, fastboot <fastboot@lists.osdl.org>, "Luck,
	Tony" <tony.luck@intel.com>

On Tue, May 08, 2007 at 02:55:44PM +0800, Zou Nan hai wrote:
> Hi, 
> 	The patch looks ok to me.  
> However split the patch in 2 parts, 
> 1. Put pr_status to percpu data to save stack usage.
> 2. IA64 specific part.
>    may help others to review the patches.

Sure, will do.

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
