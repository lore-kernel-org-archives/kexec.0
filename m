Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IUy5R-0004yV-0n
	for kexec@lists.infradead.org; Tue, 11 Sep 2007 01:15:01 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8B5EeYe030465
	for <kexec@lists.infradead.org>; Tue, 11 Sep 2007 01:14:40 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8B5Ee66420870
	for <kexec@lists.infradead.org>; Mon, 10 Sep 2007 23:14:40 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8B5Edsh026340
	for <kexec@lists.infradead.org>; Mon, 10 Sep 2007 23:14:40 -0600
Date: Tue, 11 Sep 2007 10:44:53 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [discuss] [patch 3/5] Use extended crashkernel command line on
	x86_64
Message-ID: <20070911051453.GB5053@in.ibm.com>
References: <20070909083914.065380136@strauss.suse.de>
	<20070909083914.951336895@strauss.suse.de>
	<86802c440709091027o32a63d11w629bad87abcc19c2@mail.gmail.com>
	<20070909185257.GA10600@suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070909185257.GA10600@suse.de>
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
To: Yinghai Lu <yhlu.kernel@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-arch@vger.kernel.org, discuss@x86-64.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Bernhard Walle <bwalle@suse.de>

On Sun, Sep 09, 2007 at 08:52:58PM +0200, Bernhard Walle wrote:
> * Yinghai Lu <yhlu.kernel@gmail.com> [2007-09-09 19:27]:
> > >
> > > +#ifdef CONFIG_KEXEC
> > ...
> > 
> > CONFIG_KEXEC or CONFIG_CRASH_DUMP?
> 
> Good question. The crashkernel parameter was CONFIG_KEXEC before, and
> I also wondered why, but I didn't change this because maybe there's
> some reason I don't know.
> 
> Vivek, do you know why this was CONFIG_KEXEC?
> 
> 

Bernhard,

As Eric mentioned, CONFIG_CRASH_DUMP has been used for all dump capturing
infrastructure and rest of the kexec and kexec on panic functionality
has been put under CONFIG_KEXEC. 

Keeping memory reservation under CONFIG_KEXEC helps in a sense when
somebody is not using a relocatable kernel and uses a custom kernel for dump
capture. In that case he does not have to enable CONFIG_CRASH_DUMP in the
first kernel.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
