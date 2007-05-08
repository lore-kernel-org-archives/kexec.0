Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HlS9I-0006Mo-Rt
	for kexec@lists.infradead.org; Tue, 08 May 2007 12:02:50 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l48G2goK019406
	for <kexec@lists.infradead.org>; Tue, 8 May 2007 12:02:42 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l48G2gx1199894
	for <kexec@lists.infradead.org>; Tue, 8 May 2007 10:02:42 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l48G2g8Z026628
	for <kexec@lists.infradead.org>; Tue, 8 May 2007 10:02:42 -0600
Date: Tue, 8 May 2007 21:32:22 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [patch 1/5] kexec debug output improvments
Message-ID: <20070508160222.GA32159@in.ibm.com>
References: <20070507235727.631477448@am.sony.com>>
	<463FBE27.4060402@am.sony.com>
	<20070508062019.GC5400@in.ibm.com> <46408AFD.10107@am.sony.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46408AFD.10107@am.sony.com>
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

On Tue, May 08, 2007 at 07:36:45AM -0700, Geoff Levand wrote:
> Vivek Goyal wrote:
> > On Mon, May 07, 2007 at 05:02:47PM -0700, Geoff Levand wrote:
> >> +#define dprintf(args...) dfprintf(stdout, args)
> >>  #ifdef DEBUG
> >> -#define dfprintf(args...)	do {fprintf(args);} while(0)
> >> +#define dfprintf(_f, _args...) do {fprintf(_f, _args);} while(0)
> > 
> > Should't dprintf() also be inside #ifdef DEBUG?
> 
> Then you need two identical defs for dprintf.
> 

Nope. 

#ifdef DEBUG
#define dprintf()  fprintf()
#else
#define dprintf()  do{}while(0)
#endif

This is a debug print and should be enabled only if DEBUG is defined.

Thanks
Vivek


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
