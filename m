Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IE5KV-0006Hk-B9
	for kexec@lists.infradead.org; Thu, 26 Jul 2007 11:32:45 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6QFWZ1G014590
	for <kexec@lists.infradead.org>; Thu, 26 Jul 2007 11:32:35 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6QFWY6G529166
	for <kexec@lists.infradead.org>; Thu, 26 Jul 2007 11:32:35 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6QFWYPj002499
	for <kexec@lists.infradead.org>; Thu, 26 Jul 2007 11:32:34 -0400
Date: Thu, 26 Jul 2007 21:02:40 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [patch] add kdump_after_notifier
Message-ID: <20070726153240.GA15969@in.ibm.com>
References: <469F55D0.4050203@ah.jp.nec.com> <20070726140702.GA8949@suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070726140702.GA8949@suse.de>
Reply-To: vgoyal@in.ibm.com
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
To: Takenori Nagano <t-nagano@ah.jp.nec.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, k-miyoshi@cb.jp.nec.com, Andrew Morton <akpm@linux-foundation.org>
Cc: Bernhard Walle <bwalle@suse.de>

On Thu, Jul 26, 2007 at 04:07:02PM +0200, Bernhard Walle wrote:
> * Takenori Nagano <t-nagano@ah.jp.nec.com> [2007-07-19 14:15]:
> > 
> > In latest kernel, we can't use panic_notifier_list if kdump is enabled.
> > panic_notifier_list is very useful function for debug, failover, etc...
> > 
> > So this patch adds a control file /proc/sys/kernel/dump_after_notifier
> > and resolves a problem users can not use both kdump and panic_notifier_list
> > at the same time.
> > 
> > kdump_after_notifier = 0
> >  -> panic()
> >     -> crash_kexec(NULL)
> > 
> > kdump_after_notifier = 1
> >  -> panic()
> >     -> atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> >     -> crash_kexec(NULL)
> 
> What's problematic about this patch? I also would like to see that
> feature.

I would like to see the code which will get executed after panic and 
before crash_kexec(). This potentially makes crash dump feature unreliable
in the sense one can now register on panic_notifier_list and try to
do whole lot of things and might get stuck there. After the system
has crashed, one is not supposed to do a whole lot.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
