Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ogre.sisk.pl ([217.79.144.158])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JAXnP-0001Mj-VD
	for kexec@lists.infradead.org; Thu, 03 Jan 2008 21:40:19 +0000
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: kexec refuses to boot latest -mm
Date: Thu, 3 Jan 2008 22:42:00 +0100
References: <20071228124532.GB32643@linux.vnet.ibm.com>
	<20071231150843.GB27060@redhat.com>
	<20080103195201.GC6392@linux.vnet.ibm.com>
In-Reply-To: <20080103195201.GC6392@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200801032242.01425.rjw@sisk.pl>
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
To: Dhaval Giani <dhaval@linux.vnet.ibm.com>
Cc: hbabu@us.ibm.com, kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Thursday, 3 of January 2008, Dhaval Giani wrote:
> On Mon, Dec 31, 2007 at 10:08:43AM -0500, Vivek Goyal wrote:
> > On Sat, Dec 29, 2007 at 11:11:13AM +0530, Dhaval Giani wrote:
> > > On Fri, Dec 28, 2007 at 09:27:39AM -0500, Vivek Goyal wrote:
> > > > On Fri, Dec 28, 2007 at 06:15:32PM +0530, Dhaval Giani wrote:
> > > > > Hi Vivek,
> > > > > 
> > > > > I can't seem to get the latest -mm (2.6.24-rc6-mm1) to boot with
> > > > > kexec. It just gets stuck at "Starting new kernel".
> > > > > 
> > > > > It does boot normally when booted as the first kernel.
> > > > > 
> > > > > Any hints debugging? (x86 architecture)
> > > > 
> > > > I generally try few things.
> > > > 
> > > > - Specify earlyprintk= parameter for second kernel and see if control
> > > >   is reaching to second kernel.
> > > > 
> > > > - Otherwise specify --console-serial parameter on "kexec -l" commandline
> > > >   and it should display a message "I am in purgatory" on serial console.
> > > >   This will just mean that control has reached at least till purgatory.
> > > > 
> > > 
> > > Ok, so it reaches till here. I get "I'm in purgatory" on the console.
> > 
> > One more thing. Is 2.6.24-rc6 working properly?
> > 
> 
> 2.6.24-rc5 boots, so does 2.6.24-rc5-mm1. 2.6.24-rc6 does not boot, nor
> does 2.6.24-rc6-mm1. Its a regression.

Added to the list of reported regressions as:
http://bugzilla.kernel.org/show_bug.cgi?id=9682

Thanks,
Rafael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
