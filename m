Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1I0VvR-0003J2-HC
	for kexec@lists.infradead.org; Tue, 19 Jun 2007 01:06:47 -0400
Date: Tue, 19 Jun 2007 14:06:35 +0900
From: Horms <horms@verge.net.au>
Subject: Re: [PATCH] kexec ppc64: fix misaligned cmdline
Message-ID: <20070619050633.GA11878@verge.net.au>
References: <25445.1180941825@neuling.org>
	<8f5d8a214e9042b0c556ac7256928a52@bga.com>
	<26608.1180950136@neuling.org> <10188.1181179162@neuling.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <10188.1181179162@neuling.org>
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
To: Michael Neuling <mikey@neuling.org>
Cc: Santhosh Rao <sonny@burdell.org>, linuxppc-dev@ozlabs.org, kexec@lists.infradead.org, Milton Miller <miltonm@bga.com>

On Thu, Jun 07, 2007 at 11:19:22AM +1000, Michael Neuling wrote:
> If the cmdline changes between boots, we can get misalignment of the
> bootargs entry, which in turn corrupts our device tree blob and hence
> kills our kexec boot.  Also, if there was no /chosen/bootargs
> previously, we'd never add a new one. 
> 
> This ignores the bootargs while parsing the tree and inserts it later. 
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Thanks, applied.

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
