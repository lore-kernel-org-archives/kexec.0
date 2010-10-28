Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from one.firstfloor.org ([213.235.205.2])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PBRYB-0007g2-Mf
	for kexec@lists.infradead.org; Thu, 28 Oct 2010 12:25:48 +0000
Date: Thu, 28 Oct 2010 14:25:40 +0200
From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] kexec_load manpage
Message-ID: <20101028122540.GA29759@basil.fritz.box>
References: <20100619132633.GA24277@basil.fritz.box>
	<m1mxuqu8yr.fsf@fess.ebiederm.org>
	<AANLkTillNx5owgU4O71izNz9FEL06MiI-FquTZ3ofktP@mail.gmail.com>
	<AANLkTi=HKMce2UojSRmqVdoLO3H4v+6Xtp-bgFuHwH+D@mail.gmail.com>
	<AANLkTinHP0Z-sQOgtETQsQ_5ZV1UbT+tGDJ47B23E4=0@mail.gmail.com>
	<20101024213802.GB9922@basil.fritz.box>
	<20101028121417.GD16206@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20101028121417.GD16206@verge.net.au>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-man@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Kexec Mailing List <kexec@lists.infradead.org>, Michael Kerrisk <mtk.manpages@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>

On Thu, Oct 28, 2010 at 09:14:17PM +0900, Simon Horman wrote:
> On Sun, Oct 24, 2010 at 11:38:02PM +0200, Andi Kleen wrote:
> > On Sun, Oct 24, 2010 at 04:56:24PM +0200, Michael Kerrisk wrote:
> > > Hey Andi,
> > > 
> > > I'd like to push this page out the door, but I'm blocked doing so
> > > until I hear back from you regarding the question below (plus a new
> > > version of the page, if needed please).
> > 
> > Probably. Eric should know.
> > 
> > Frankly without an header the syscall is pretty much unusable
> > for normal programs anyways, so I gave up on this.
> 
> I'm not sure that I ever understood the impasse over the header.

It's basically: should kexec_load only be used from kexec(8)
or is it a generally available syscall.

If the former is true no header or manpage is needed.
For the later both are.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
