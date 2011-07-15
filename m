Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QheI7-0003Vg-0a
	for kexec@lists.infradead.org; Fri, 15 Jul 2011 09:02:36 +0000
Date: Fri, 15 Jul 2011 16:38:07 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH v2 0/8] makedumpfile: makedumpfile enhancement to filter
	out kernel data from vmcore
Message-Id: <20110715163807.f303257c.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20110715071029.GA27936@in.ibm.com>
References: <20110524203542.GH3860@redhat.com>
	<1621913139.202658.1306270052667.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
	<OF341326C7.0D81F89A-ONC125789B.002DB6ED-C125789B.002FC7A0@de.ibm.com>
	<20110525195321.GD6724@redhat.com>
	<OF05104FA0.A922963A-ONC125789C.003BDAA9-C125789C.003DD130@de.ibm.com>
	<20110526133923.GA29496@redhat.com>
	<20110527065621.GA26119@in.ibm.com>
	<20110715142041.2a7aa858.oomichi@mxs.nes.nec.co.jp>
	<20110715071029.GA27936@in.ibm.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: mahesh@linux.vnet.ibm.com
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Reinhard Buendgen <BUENDGEN@de.ibm.com>


Hi Mahesh,

Thank you for quick response.

On Fri, 15 Jul 2011 12:40:29 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> > > 
> > > The current approach is to re-run the makedumpfile on the crash dump
> > > (generated in the second kernel) when we are back into production kernel
> > > (1st kernel).
> > 
> > IIUC, there are be 2 dumpfiles on customer site by the above approach.
> > The one is with privacy/secret data, and another is without.
> 
> Correct.
> 
> > 
> > If correct, I like this approach because a customer can have two options
> > when the crash utility cannot read a dumpfile without privacy/secret data
> > on support site.
> 
> The crash utility would just display a warning message early on during
> invocation. Most of the time crash tool will be able to read/analyze the
> dump unless someone scrubs out the data on which crash utility is dependant
> on. And as I mentioned previously, this is intended just as a security filter
> and not to be used as detrimental to crash's analysis of the dump.

I see, this feature will not be a problem in most cases.
However a customer can create unreadable dumpfile by using this feature,
and current makedumpfile does not have such feature.

Of course unreadable dumpfile is due to wrong makedumpfile.conf,
and I like this feature anyway because a customer has options.


Thanks
Ken'ichi Ohmichi

> > First option:
> >   For digging a problem, a customer sends a dumpfile with privacy/secret
> >   data to support site.
> > 
> > Second option:
> >   For protecting privacy/secret data, a customer gives up digging a problem.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
