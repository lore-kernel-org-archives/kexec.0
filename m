Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp06.in.ibm.com ([59.145.155.6] helo=e28esmtp06.in.ibm.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JAlfY-00079z-Uv
	for kexec@lists.infradead.org; Fri, 04 Jan 2008 12:29:20 +0000
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28esmtp06.in.ibm.com (8.13.1/8.13.1) with ESMTP id m04CSMmO009234
	for <kexec@lists.infradead.org>; Fri, 4 Jan 2008 17:58:22 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m04CSLT81105972
	for <kexec@lists.infradead.org>; Fri, 4 Jan 2008 17:58:21 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id m04CSNqd027214
	for <kexec@lists.infradead.org>; Fri, 4 Jan 2008 12:28:23 GMT
Date: Fri, 4 Jan 2008 17:58:16 +0530
From: Dhaval Giani <dhaval@linux.vnet.ibm.com>
Subject: Re: kexec refuses to boot latest -mm
Message-ID: <20080104122816.GF4514@linux.vnet.ibm.com>
References: <20071228124532.GB32643@linux.vnet.ibm.com>
	<20071231150843.GB27060@redhat.com>
	<20080103195201.GC6392@linux.vnet.ibm.com>
	<200801032242.01425.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200801032242.01425.rjw@sisk.pl>
Reply-To: Dhaval Giani <dhaval@linux.vnet.ibm.com>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: hbabu@us.ibm.com, kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Jan 03, 2008 at 10:42:00PM +0100, Rafael J. Wysocki wrote:
> On Thursday, 3 of January 2008, Dhaval Giani wrote:
> > On Mon, Dec 31, 2007 at 10:08:43AM -0500, Vivek Goyal wrote:
> > > On Sat, Dec 29, 2007 at 11:11:13AM +0530, Dhaval Giani wrote:
> > > > On Fri, Dec 28, 2007 at 09:27:39AM -0500, Vivek Goyal wrote:
> > > > > On Fri, Dec 28, 2007 at 06:15:32PM +0530, Dhaval Giani wrote:
> > > > > > Hi Vivek,
> > > > > > 
> > > > > > I can't seem to get the latest -mm (2.6.24-rc6-mm1) to boot with
> > > > > > kexec. It just gets stuck at "Starting new kernel".
> > > > > > 
> > > > > > It does boot normally when booted as the first kernel.
> > > > > > 
> > > > > > Any hints debugging? (x86 architecture)
> > > > > 
> > > > > I generally try few things.
> > > > > 
> > > > > - Specify earlyprintk= parameter for second kernel and see if control
> > > > >   is reaching to second kernel.
> > > > > 
> > > > > - Otherwise specify --console-serial parameter on "kexec -l" commandline
> > > > >   and it should display a message "I am in purgatory" on serial console.
> > > > >   This will just mean that control has reached at least till purgatory.
> > > > > 
> > > > 
> > > > Ok, so it reaches till here. I get "I'm in purgatory" on the console.
> > > 
> > > One more thing. Is 2.6.24-rc6 working properly?
> > > 
> > 
> > 2.6.24-rc5 boots, so does 2.6.24-rc5-mm1. 2.6.24-rc6 does not boot, nor
> > does 2.6.24-rc6-mm1. Its a regression.
> 
> Added to the list of reported regressions as:
> http://bugzilla.kernel.org/show_bug.cgi?id=9682
> 

I've no clue what I managed to do wrong last night, probably tried to boot
2.6.24-rc6-mm1 thinking it was 2.6.24-rc6. 2.6.24-rc6 boots, but -mm
does not. Sorry for the noise.

With the help of the outbs I have figured out that it is dying somewhere
in setup_memory(). Will look deeper into it.

-- 
regards,
Dhaval

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
