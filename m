Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IE5MS-0006Jl-Nf
	for kexec@lists.infradead.org; Thu, 26 Jul 2007 11:34:50 -0400
Date: Thu, 26 Jul 2007 17:34:40 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch] add kdump_after_notifier
Message-ID: <20070726153440.GA19095@suse.de>
References: <469F55D0.4050203@ah.jp.nec.com> <20070726140702.GA8949@suse.de>
	<20070726153240.GA15969@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070726153240.GA15969@in.ibm.com>
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
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, k-miyoshi@cb.jp.nec.com, kexec@lists.infradead.org, Takenori Nagano <t-nagano@ah.jp.nec.com>, linux-kernel@vger.kernel.org

* Vivek Goyal <vgoyal@in.ibm.com> [2007-07-26 17:32]:
> On Thu, Jul 26, 2007 at 04:07:02PM +0200, Bernhard Walle wrote:
> > * Takenori Nagano <t-nagano@ah.jp.nec.com> [2007-07-19 14:15]:
> > > 
> > > In latest kernel, we can't use panic_notifier_list if kdump is enabled.
> > > panic_notifier_list is very useful function for debug, failover, etc...
> > > 
> > > So this patch adds a control file /proc/sys/kernel/dump_after_notifier
> > > and resolves a problem users can not use both kdump and panic_notifier_list
> > > at the same time.
> > > 
> > > kdump_after_notifier = 0
> > >  -> panic()
> > >     -> crash_kexec(NULL)
> > > 
> > > kdump_after_notifier = 1
> > >  -> panic()
> > >     -> atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> > >     -> crash_kexec(NULL)
> > 
> > What's problematic about this patch? I also would like to see that
> > feature.
> 
> I would like to see the code which will get executed after panic and 
> before crash_kexec(). This potentially makes crash dump feature unreliable
> in the sense one can now register on panic_notifier_list and try to
> do whole lot of things and might get stuck there. After the system
> has crashed, one is not supposed to do a whole lot.

Of course, but that's why the patch doesn't change this by default but
gives the user the choice.


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
