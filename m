Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hldel-0006Nv-B8
	for kexec@lists.infradead.org; Wed, 09 May 2007 05:20:04 +0100
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l494GSFS021355
	for <kexec@lists.infradead.org>; Wed, 9 May 2007 00:16:28 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l494Jolu158614
	for <kexec@lists.infradead.org>; Tue, 8 May 2007 22:19:50 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l494Joem006044
	for <kexec@lists.infradead.org>; Tue, 8 May 2007 22:19:50 -0600
Date: Wed, 9 May 2007 09:49:25 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [patch 1/5] kexec debug output improvments
Message-ID: <20070509041925.GB12361@in.ibm.com>
References: <20070507235727.631477448@am.sony.com>>
	<463FBE27.4060402@am.sony.com>
	<20070508062019.GC5400@in.ibm.com> <46408AFD.10107@am.sony.com>
	<20070508160222.GA32159@in.ibm.com> <46411FDC.7040506@am.sony.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46411FDC.7040506@am.sony.com>
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
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: kexec@lists.infradead.org

On Tue, May 08, 2007 at 06:11:56PM -0700, Geoff Levand wrote:
> Vivek Goyal wrote:
> > On Tue, May 08, 2007 at 07:36:45AM -0700, Geoff Levand wrote:
> >> Vivek Goyal wrote:
> >> > On Mon, May 07, 2007 at 05:02:47PM -0700, Geoff Levand wrote:
> >> >> +#define dprintf(args...) dfprintf(stdout, args)
> >> >>  #ifdef DEBUG
> >> >> -#define dfprintf(args...)	do {fprintf(args);} while(0)
> >> >> +#define dfprintf(_f, _args...) do {fprintf(_f, _args);} while(0)
> >> > 
> >> > Should't dprintf() also be inside #ifdef DEBUG?
> >> 
> >> Then you need two identical defs for dprintf.
> >> 
> > 
> > Nope. 
> > 
> > This is a debug print and should be enabled only if DEBUG is defined.
> 
> I have that, but you cut that part of the patch which shows it
> from your reply.

Ok. You seem to be saying that because dfprintf() is under DEBUG, and
dprintf() is just a variant of dfprintf() so we don't have to put dprintf()
under debug.

I still feel that we should move dprintf() under DEBUG, in case definition
of dprintf() changes tomorrow and it is no more dependent on dfprintf().
It will not be very intitutive to the person changing the definition that
dprintf() now should be moved inside DEBUG.

#ifdef DEBUG
dprintf()   dfprintf()
dfprintf()    fprintf
#else
dprintf	    do{} while(0)
dfprintf()   do{} while(0)
#endif

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
