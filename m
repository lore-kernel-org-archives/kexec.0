Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1J9MGk-0005TK-R0
	for kexec@lists.infradead.org; Mon, 31 Dec 2007 15:09:40 +0000
Date: Mon, 31 Dec 2007 10:06:58 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kexec refuses to boot latest -mm
Message-ID: <20071231150658.GA27060@redhat.com>
References: <20071228124532.GB32643@linux.vnet.ibm.com>
	<20071228142739.GA4560@redhat.com>
	<20071229054113.GB17426@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071229054113.GB17426@linux.vnet.ibm.com>
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
Cc: hbabu@us.ibm.com, kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>

On Sat, Dec 29, 2007 at 11:11:13AM +0530, Dhaval Giani wrote:
> On Fri, Dec 28, 2007 at 09:27:39AM -0500, Vivek Goyal wrote:
> > On Fri, Dec 28, 2007 at 06:15:32PM +0530, Dhaval Giani wrote:
> > > Hi Vivek,
> > > 
> > > I can't seem to get the latest -mm (2.6.24-rc6-mm1) to boot with
> > > kexec. It just gets stuck at "Starting new kernel".
> > > 
> > > It does boot normally when booted as the first kernel.
> > > 
> > > Any hints debugging? (x86 architecture)
> > 
> > I generally try few things.
> > 
> > - Specify earlyprintk= parameter for second kernel and see if control
> >   is reaching to second kernel.
> > 
> > - Otherwise specify --console-serial parameter on "kexec -l" commandline
> >   and it should display a message "I am in purgatory" on serial console.
> >   This will just mean that control has reached at least till purgatory.
> > 
> 
> Ok, so it reaches till here. I get "I'm in purgatory" on the console.
> 

Ok. So it atleast reaches till purgatory. My hunch is that it also reaches
the second kernel but dies early in that kernel before any message can
be printed on screen.

Can you put some "outb()" messages on serial console in start_kernel() in
second kernel and see up to what point do you reach.

My 2.6.24-rc6-mm1 kernel panics during boot on 32bit box. Let me try it on
64 bit box.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
