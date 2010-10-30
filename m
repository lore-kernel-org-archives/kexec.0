Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PC1JZ-0000tR-OG
	for kexec@lists.infradead.org; Sat, 30 Oct 2010 02:37:06 +0000
Date: Sat, 30 Oct 2010 11:36:44 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec_load manpage
Message-ID: <20101030023644.GC12842@verge.net.au>
References: <20100619132633.GA24277@basil.fritz.box>
	<m1mxuqu8yr.fsf@fess.ebiederm.org>
	<AANLkTillNx5owgU4O71izNz9FEL06MiI-FquTZ3ofktP@mail.gmail.com>
	<AANLkTi=HKMce2UojSRmqVdoLO3H4v+6Xtp-bgFuHwH+D@mail.gmail.com>
	<AANLkTinHP0Z-sQOgtETQsQ_5ZV1UbT+tGDJ47B23E4=0@mail.gmail.com>
	<20101024213802.GB9922@basil.fritz.box>
	<20101028121417.GD16206@verge.net.au>
	<20101028122540.GA29759@basil.fritz.box>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20101028122540.GA29759@basil.fritz.box>
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
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-man@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Kexec Mailing List <kexec@lists.infradead.org>, Michael Kerrisk <mtk.manpages@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>

On Thu, Oct 28, 2010 at 02:25:40PM +0200, Andi Kleen wrote:
> On Thu, Oct 28, 2010 at 09:14:17PM +0900, Simon Horman wrote:
> > On Sun, Oct 24, 2010 at 11:38:02PM +0200, Andi Kleen wrote:
> > > On Sun, Oct 24, 2010 at 04:56:24PM +0200, Michael Kerrisk wrote:
> > > > Hey Andi,
> > > > 
> > > > I'd like to push this page out the door, but I'm blocked doing so
> > > > until I hear back from you regarding the question below (plus a new
> > > > version of the page, if needed please).
> > > 
> > > Probably. Eric should know.
> > > 
> > > Frankly without an header the syscall is pretty much unusable
> > > for normal programs anyways, so I gave up on this.
> > 
> > I'm not sure that I ever understood the impasse over the header.
> 
> It's basically: should kexec_load only be used from kexec(8)
> or is it a generally available syscall.
> 
> If the former is true no header or manpage is needed.
> For the later both are.

Magnus Damm is interested in having a kexec-tools module for busybox [1].
And I suspect that would be somewhat less tedious to implement
if kexec was a generally available syscall.

[1] http://tree.celinuxforum.org/pipermail/celinux-dev/2010-October/002057.html


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
