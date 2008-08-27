Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KYFYa-000572-T3
	for kexec@lists.infradead.org; Wed, 27 Aug 2008 07:35:09 +0000
Date: Wed, 27 Aug 2008 17:35:06 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 06/06] sh: Add vmlinux support
Message-ID: <20080827073503.GB30536@verge.net.au>
References: <20080826111150.615.97501.sendpatchset@rx1.opensource.se>
	<20080826111232.615.24048.sendpatchset@rx1.opensource.se>
	<20080827023905.GL19066@verge.net.au>
	<aec7e5c30808262110p8197b84ieaf38211a495daa0@mail.gmail.com>
	<20080827054043.GO19066@verge.net.au>
	<aec7e5c30808262355w73e2e6b2y47534812758a79a0@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aec7e5c30808262355w73e2e6b2y47534812758a79a0@mail.gmail.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>, kexec@lists.infradead.org

On Wed, Aug 27, 2008 at 03:55:00PM +0900, Magnus Damm wrote:
> On Wed, Aug 27, 2008 at 2:40 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Aug 27, 2008 at 01:10:30PM +0900, Magnus Damm wrote:
> >> Hi Simon,
> >>
> >> On Wed, Aug 27, 2008 at 11:39 AM, Simon Horman <horms@verge.net.au> wrote:
> >> > On Tue, Aug 26, 2008 at 08:12:32PM +0900, Magnus Damm wrote:
> >> >> From: Magnus Damm <damm@igel.co.jp>
> >> >>
> >> >> Add SuperH vmlinux support through a zero-page aware elf loader. Only for
> >> >> kexec at this point, in the future kdump support will be added.
> >> >
> >> > If these series of patches are fine by you then they are fine by me.
> >> > I just have a few minor issues with this last patch.
> >>
> >> How does the attached patch look?
> >>
> >> Thanks for your help!
> >
> > Much better :-)
> >
> > Should I just fold it into the last patch and push ?
> 
> Yes, that would be great! Thanks! =)

Great. I've pushed the patches and included Paul's ack.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
