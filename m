Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IO3k1-0004PH-Cc
	for kexec@lists.infradead.org; Wed, 22 Aug 2007 23:52:21 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7N3qBes015776
	for <kexec@lists.infradead.org>; Wed, 22 Aug 2007 23:52:11 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7N3qATs215616
	for <kexec@lists.infradead.org>; Wed, 22 Aug 2007 21:52:10 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7N3qAl9027019
	for <kexec@lists.infradead.org>; Wed, 22 Aug 2007 21:52:10 -0600
Date: Thu, 23 Aug 2007 09:22:27 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [patch] add kdump_after_notifier
Message-ID: <20070823035227.GA365@in.ibm.com>
References: <20070802112852.GA7054@in.ibm.com>
	<31687.1186113947@kao2.melbourne.sgi.com>
	<20070805110746.GA12540@in.ibm.com>
	<46C1691E.7090708@ah.jp.nec.com> <20070814083710.GA14538@suse.de>
	<20070814132454.GA8293@in.ibm.com> <46C4184B.5030303@ah.jp.nec.com>
	<20070817105630.GA18167@in.ibm.com> <46CA97FE.90505@ah.jp.nec.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46CA97FE.90505@ah.jp.nec.com>
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
To: Takenori Nagano <t-nagano@ah.jp.nec.com>
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>

On Tue, Aug 21, 2007 at 04:45:02PM +0900, Takenori Nagano wrote:
> Vivek Goyal wrote:
> > On Thu, Aug 16, 2007 at 06:26:35PM +0900, Takenori Nagano wrote:
> >> Vivek Goyal wrote:
> >>  > So for the time being I think we can put RAS tools on die notifier list
> >>> and if it runs into issues we can always think of creating a separate list.
> >>>
> >>> Few things come to mind.
> >>>
> >>> - Why there is a separate panic_notifier_list? Can't it be merged with
> >>>   die_chain? die_val already got one of the event type as PANIC. If there
> >>>   are no specific reasons then we should merge the two lists. Registering
> >>>   RAS tools on a single list is easier.
> >> I think it is difficult, because die_chain is defined by each architecture.
> >>
> > 
> > I think die_chain is arch independent definition (kernel/die_notifier.c)? 
> > But anyway, to begin with it can be done only for panic_notifier.
> 
> I think die_val (notify_die() argument) values are arch independent.
> They are defined in include/asm-<arch>/kdebug.h.
> 
> Your idea is good, but I think it has very large impact. It is very hard to fix
> them at the same time. So, how about putting off merging two lists?
> 

I think that's fine. For the time being we can just export panic_notifier
list. die_chain is not a problem as of today as die notifiers get invoked
first and then if panic_on_oops is set, kdump is called. So all the RAS
tools registered on die_chain will get executed first.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
