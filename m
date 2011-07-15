Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QhcXr-0001tu-SB
	for kexec@lists.infradead.org; Fri, 15 Jul 2011 07:10:45 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id p6F79oGG023802
	for <kexec@lists.infradead.org>; Fri, 15 Jul 2011 17:09:50 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p6F7AXHF483530
	for <kexec@lists.infradead.org>; Fri, 15 Jul 2011 17:10:33 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p6F7AWTv013509
	for <kexec@lists.infradead.org>; Fri, 15 Jul 2011 17:10:33 +1000
Date: Fri, 15 Jul 2011 12:40:29 +0530
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/8] makedumpfile: makedumpfile enhancement to
	filter out kernel data from vmcore
Message-ID: <20110715071029.GA27936@in.ibm.com>
References: <20110524203542.GH3860@redhat.com>
	<1621913139.202658.1306270052667.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
	<OF341326C7.0D81F89A-ONC125789B.002DB6ED-C125789B.002FC7A0@de.ibm.com>
	<20110525195321.GD6724@redhat.com>
	<OF05104FA0.A922963A-ONC125789C.003BDAA9-C125789C.003DD130@de.ibm.com>
	<20110526133923.GA29496@redhat.com>
	<20110527065621.GA26119@in.ibm.com>
	<20110715142041.2a7aa858.oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110715142041.2a7aa858.oomichi@mxs.nes.nec.co.jp>
Reply-To: mahesh@linux.vnet.ibm.com
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Reinhard Buendgen <BUENDGEN@de.ibm.com>

Hi Ken'ichi,

On 2011-07-15 14:20:41 Fri, Ken'ichi Ohmichi wrote:
> 
> Hi Mahesh,
> 
> (I'm back to makedumpfile devel for merging this patchset,
>  because Tachibana-san is busy.)

Good to see that you are back.

> 
> Sorry for replying an old mail.
> 
> On Fri, 27 May 2011 12:26:21 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> > On 2011-05-26 09:39:23 Thu, Vivek Goyal wrote:
> > > On Thu, May 26, 2011 at 01:15:14PM +0200, Reinhard Buendgen wrote:
> > > > Vivek,
> > > > 
> > > > I/O is not restricted to disk I/O (it may be network I/O, data sent to 
> > > > crtypto cards etc.) and it is not always direct, Device drivers may have 
> > > > buffers to which such data is copied. 
> > > > 
> > > > So it is more than just keys, and it may change over time.
> > > > I do not think hardwiring a filter in makedumpfile is a good idea because 
> > > > you would need a new makedumpfile release for every Distribution 
> > > > (release).
> > > 
> > > Ok, so we are worried about data being in slub/slab caches or driver's
> > > kmalloced buffers etc.
> > > 
> > > When do I need access to debuginfo files. I am assuming that makedumpfile
> > > reads them in first kernel sometime and stores relevant info in initramfs.
> > > Otherwise, it is not possible to get to it in second kernel after crash.
> > > 
> > 
> > The current approach is to re-run the makedumpfile on the crash dump
> > (generated in the second kernel) when we are back into production kernel
> > (1st kernel).
> 
> IIUC, there are be 2 dumpfiles on customer site by the above approach.
> The one is with privacy/secret data, and another is without.

Correct.

> 
> If correct, I like this approach because a customer can have two options
> when the crash utility cannot read a dumpfile without privacy/secret data
> on support site.

The crash utility would just display a warning message early on during
invocation. Most of the time crash tool will be able to read/analyze the
dump unless someone scrubs out the data on which crash utility is dependant
on. And as I mentioned previously, this is intended just as a security filter
and not to be used as detrimental to crash's analysis of the dump.

> 
> First option:
>   For digging a problem, a customer sends a dumpfile with privacy/secret
>   data to support site.
> 
> Second option:
>   For protecting privacy/secret data, a customer gives up digging a problem.
> 
> 
> Thanks
> Ken'ichi Ohmichi

Thanks,
-Mahesh.

> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

-- 
Mahesh J Salgaonkar

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
