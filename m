Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1ILbua-0005lG-Qu
	for kexec@lists.infradead.org; Thu, 16 Aug 2007 05:45:08 -0400
Date: Thu, 16 Aug 2007 11:45:11 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch] add kdump_after_notifier
Message-ID: <20070816094511.GA28545@suse.de>
References: <20070802112852.GA7054@in.ibm.com>
	<31687.1186113947@kao2.melbourne.sgi.com>
	<20070805110746.GA12540@in.ibm.com>
	<46C1691E.7090708@ah.jp.nec.com> <20070814083710.GA14538@suse.de>
	<20070814132454.GA8293@in.ibm.com> <46C4184B.5030303@ah.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46C4184B.5030303@ah.jp.nec.com>
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
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

* Takenori Nagano <t-nagano@ah.jp.nec.com> [2007-08-16 11:26]:
> Vivek Goyal wrote:
> > - Modify Kdump to register on die_chain list. 
> > - Modify Kdb to register on die_chain list.
> > - Export all the registered members of die_chain through sysfs along with
> >   their priorities. Priorities should be modifiable. Most likely one 
> >   shall have to introduce additional field in struct notifier_block. This
> >   field will be a string as an identifier of the user registerd. e.g
> >   "Kdump", "Kdb" etc.
> > 
> > Now user will be able to view all the die_chain users through sysfs and
> > be able to modify the order in which these should run by modifying their
> > priority. Hence all the RAS tools can co-exist.
> 
> This is my image of your proposal.
> 
> - Print current order
> 
> # cat /sys/class/misc/debug/panic_notifier_list
> priority   name
> 1          IPMI
> 2          watchdog
> 3          Kdb
> 4          Kdump

I think something like

/sys/class/misc/debug/panic_notifier/ipmi/priority
/sys/class/misc/debug/panic_notifier/watchdog/priority
/sys/class/misc/debug/panic_notifier/kdb/priority
/sys/class/misc/debug/panic_notifier/kdump/priority

would be better. It's more self-describing if you want to change the
order.



Thanks,
   Bernhard


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
