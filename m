Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L5Dhu-00043r-CG
	for kexec@lists.infradead.org; Wed, 26 Nov 2008 06:17:03 +0000
Date: Wed, 26 Nov 2008 15:16:54 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Fix kexec x86_64 load failed bug
Message-ID: <20081126061652.GA24221@verge.net.au>
References: <20081125134738.7075a13a@hale.suse.de>
	<1227662409.2442.11.camel@yhuang-dev.sh.intel.com>
	<492CC1AA.3010408@oracle.com>
	<1227673551.2442.12.camel@yhuang-dev.sh.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1227673551.2442.12.camel@yhuang-dev.sh.intel.com>
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
To: Huang Ying <ying.huang@intel.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Bernhard Walle <bwalle@suse.de>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Wed, Nov 26, 2008 at 12:25:51PM +0800, Huang Ying wrote:
> On Wed, 2008-11-26 at 11:25 +0800, Randy Dunlap wrote:
> > This isn't kernel code?  Where is /purgatory/ ?
> > 
> > Anyway, for kernel code, that should be:
> > char *cmdline_end = NULL;
> 
> This patch is against kexec tools, not kernel.
> 
> Best Regards,
> Huang Ying

Hi Huang,

I think that I would prefer "char *cmdline_end = NULL;" for kexec-tools
code too.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
