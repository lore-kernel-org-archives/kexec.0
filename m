Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IAPoi-0007XO-1y
	for kexec@lists.infradead.org; Mon, 16 Jul 2007 13:36:45 +0100
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6GCaXf0015712
	for <kexec@lists.infradead.org>; Mon, 16 Jul 2007 08:36:33 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6GCaXEI132712
	for <kexec@lists.infradead.org>; Mon, 16 Jul 2007 06:36:33 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6GCaXMi009444
	for <kexec@lists.infradead.org>; Mon, 16 Jul 2007 06:36:33 -0600
Date: Mon, 16 Jul 2007 18:06:33 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070716123633.GA10920@in.ibm.com>
References: <20070710120243.GA10121@hmsendeavour.rdu.redhat.com>
	<20070713200533oomichi@mail.jp.nec.com>
	<20070713131550.GB10985@suse.de>
	<20070716041918.GA11390@in.ibm.com>
	<20070716115707.GA29923@suse.de>
	<20070716122518.GA10506@in.ibm.com>
	<20070716122854.GC32519@suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070716122854.GC32519@suse.de>
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
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Bernhard Walle <bwalle@suse.de>, Dan Aloni <da-x@monatomic.org>

On Mon, Jul 16, 2007 at 02:28:54PM +0200, Bernhard Walle wrote:
> * Vivek Goyal <vgoyal@in.ibm.com> [2007-07-16 14:25]:
> > 
> > Ok. Now there seems to be two ways for accessing such info.
> > - Through global variables
> > - Export through ELF notes.
> > 
> > Personally, I like the approach taken by Dan Aloni of exporting required
> > info through ELF notes. That seems to be more standard in the sense we 
> > are not dependent on somebody removing above variable tomorrow.
> > 
> > Dan, are you planning to put the modified patch for discussions on LKML?
> 
> You mean the proposal with the makedumpfile-compatible ELF note?
> Although I like that idea, I think Ken'ichi Ohmichi was against it.
> 

Yes, makedumpfile compatible ELF note one. Ken'ichi did not like the idea
too much, but I am not sure we discussed his objections in detail. I had
also responded with a mail with some of the advantages of ELF note based
approach. No response on that.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
