Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1J50B2-0007ho-0r
	for kexec@lists.infradead.org; Wed, 19 Dec 2007 14:45:46 +0000
Date: Wed, 19 Dec 2007 09:45:33 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/8] kexec build system updates, to allow cross-kexec()ing
Message-ID: <20071219144533.GB14092@redhat.com>
References: <1197967675.854275.930419561848.0.gpush@pokey>
	<20071218232558.GA14092@redhat.com>
	<20071219143822.GA17705@nlxdcldnl2.cl.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071219143822.GA17705@nlxdcldnl2.cl.intel.com>
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
To: Jeremy Kerr <jk@ozlabs.org>, kexec@lists.infradead.org, dnlombar@ichips.intel.com

On Wed, Dec 19, 2007 at 06:38:22AM -0800, Lombard, David N wrote:
> On Tue, Dec 18, 2007 at 06:25:58PM -0500, Vivek Goyal wrote:
> > On Tue, Dec 18, 2007 at 05:47:55PM +0900, Jeremy Kerr wrote:
> > 
> > > This allows us to kexec a powerpc64 kernel from a powerpc userspace.
> > > x86{,_64} users might find this handy too, but I don't have hardware
> > > to test.
> > 
> > I think x86 it already happens. I think I can launch 64bit kernel from
> > a 32bit kexec.
> 
> You certainly can...
> 

If that's the case why should we build 64 bit purgatory for 32 bit kexec?
The only advantage I can think of is I can enter the new 64bit
kernel using 64bit entry point instead of 32bit entry point. Is that
the intention behind this work? Otherwise one should be able to launch
64bit kernel from a 32bit purgatory (Using 32bit entry point).

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
