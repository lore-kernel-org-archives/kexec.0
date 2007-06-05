Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HvNNJ-0006DF-9T
	for kexec@lists.infradead.org; Mon, 04 Jun 2007 20:59:38 -0400
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] kexec ppc64: fix misaligned cmdline 
In-reply-to: <20070605001632.GA26483@localhost.localdomain> 
References: <25445.1180941825@neuling.org>
	<20070604234917.GB10877@localhost.localdomain>
	<2554.1181001397@neuling.org>
	<20070605001632.GA26483@localhost.localdomain>
Date: Tue, 05 Jun 2007 10:58:07 +1000
Message-ID: <12946.1181005087@neuling.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, horms@verge.net.au, kexec@lists.infradead.org, miltonm@bga.com

> On Tue, Jun 05, 2007 at 09:56:37AM +1000, Miichael Neuling wrote:
> > > > If the cmdline changes between boots, we can get misalignment of the
> > > > bootargs entry, which in turn corrupts our device tree blob and hence
> > > > kills our kexec boot.  
> > > > 
> > > > Specifically, if the cmdline length was >= 8 before and the new cmdline
> > > > length is < 8, we can get corruption.
> > > 
> > > Hrm.  Have you considered using dtc for this conversion, rather than
> > > this somewhat dubious looking fs2dt?
> > 
> > Numerous times.  
> > 
> > fs2dt needs to be converted to use the device tree library, but that
> > will take a lot more work than a 5 minute patch.
> 
> 
> Well, sure.. but do you need fs2dt at all.  dtc has an "fs" input
> mode..

As discussed offline, you can do this with the --devicetreeblob kexec
option.  The issue is the special cases like having to modify the kernel
cmdline options or initrd locations.

Mikey

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
