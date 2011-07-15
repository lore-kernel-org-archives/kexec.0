Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QhbhW-0001GB-TX
	for kexec@lists.infradead.org; Fri, 15 Jul 2011 06:16:40 +0000
Date: Fri, 15 Jul 2011 14:20:41 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH v2 0/8] makedumpfile: makedumpfile enhancement to filter
	out kernel data from vmcore
Message-Id: <20110715142041.2a7aa858.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20110527065621.GA26119@in.ibm.com>
References: <20110524203542.GH3860@redhat.com>
	<1621913139.202658.1306270052667.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
	<OF341326C7.0D81F89A-ONC125789B.002DB6ED-C125789B.002FC7A0@de.ibm.com>
	<20110525195321.GD6724@redhat.com>
	<OF05104FA0.A922963A-ONC125789C.003BDAA9-C125789C.003DD130@de.ibm.com>
	<20110526133923.GA29496@redhat.com>
	<20110527065621.GA26119@in.ibm.com>
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

(I'm back to makedumpfile devel for merging this patchset,
 because Tachibana-san is busy.)

Sorry for replying an old mail.

On Fri, 27 May 2011 12:26:21 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> On 2011-05-26 09:39:23 Thu, Vivek Goyal wrote:
> > On Thu, May 26, 2011 at 01:15:14PM +0200, Reinhard Buendgen wrote:
> > > Vivek,
> > > 
> > > I/O is not restricted to disk I/O (it may be network I/O, data sent to 
> > > crtypto cards etc.) and it is not always direct, Device drivers may have 
> > > buffers to which such data is copied. 
> > > 
> > > So it is more than just keys, and it may change over time.
> > > I do not think hardwiring a filter in makedumpfile is a good idea because 
> > > you would need a new makedumpfile release for every Distribution 
> > > (release).
> > 
> > Ok, so we are worried about data being in slub/slab caches or driver's
> > kmalloced buffers etc.
> > 
> > When do I need access to debuginfo files. I am assuming that makedumpfile
> > reads them in first kernel sometime and stores relevant info in initramfs.
> > Otherwise, it is not possible to get to it in second kernel after crash.
> > 
> 
> The current approach is to re-run the makedumpfile on the crash dump
> (generated in the second kernel) when we are back into production kernel
> (1st kernel).

IIUC, there are be 2 dumpfiles on customer site by the above approach.
The one is with privacy/secret data, and another is without.

If correct, I like this approach because a customer can have two options
when the crash utility cannot read a dumpfile without privacy/secret data
on support site.

First option:
  For digging a problem, a customer sends a dumpfile with privacy/secret
  data to support site.

Second option:
  For protecting privacy/secret data, a customer gives up digging a problem.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
