Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NE9yp-000564-Ve
	for kexec@lists.infradead.org; Fri, 27 Nov 2009 23:12:04 +0000
Date: Sat, 28 Nov 2009 10:11:54 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: Architecture detection code
Message-ID: <20091127231151.GA2574@verge.net.au>
References: <1258738692-4990-1-git-send-email-mat@brain-dump.org>
	<aec7e5c30911242113y7706e9c0u2262cdd7ab8bf38d@mail.gmail.com>
	<20091125225250.GK4794@verge.net.au>
	<20091127140357.GB8722@debbook.brain-dump.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20091127140357.GB8722@debbook.brain-dump.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Marc Andre Tanner <mat@brain-dump.org>
Cc: Andrea Adami <andrea.adami@gmail.com>, kexec@lists.infradead.org, Magnus Damm <magnus.damm@gmail.com>

On Fri, Nov 27, 2009 at 03:03:57PM +0100, Marc Andre Tanner wrote:
> On Thu, Nov 26, 2009 at 09:52:52AM +1100, Simon Horman wrote:
> > On Wed, Nov 25, 2009 at 02:13:56PM +0900, Magnus Damm wrote:
> > > On Sat, Nov 21, 2009 at 2:38 AM, Marc Andre Tanner <mat@brain-dump.org> wrote:
> > > > I recently had the same problem as Magnus and came up with the
> > > > following patch. It changes the architecture detection code to
> > > > also accept partiall matches. Which means and "arm" entry in
> > > > arch_map_entry will work for all arm* versions.
> > > >
> > > > Please consider applying this patch and reverting the two from
> > > > Magnus.
> > > 
> > > Sure, I'm happy to see that the arm supports gets more attention! =)
> > 
> > Hi,
> > 
> > I'd like to apply the following patch. Let me know if I've botched things.
> 
> Looks good.

Thanks, I've applied it.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
