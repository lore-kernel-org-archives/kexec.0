Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PCRs3-0001XO-Hi
	for kexec@lists.infradead.org; Sun, 31 Oct 2010 06:58:28 +0000
Date: Sun, 31 Oct 2010 15:58:10 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec_load manpage
Message-ID: <20101031065810.GB13793@verge.net.au>
References: <20100619132633.GA24277@basil.fritz.box>
	<m1mxuqu8yr.fsf@fess.ebiederm.org>
	<20100619194532.GQ18946@basil.fritz.box>
	<AANLkTi=eT_6UjgLsrOtQt833xeTOkjDvHXvd=xbEZ34c@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTi=eT_6UjgLsrOtQt833xeTOkjDvHXvd=xbEZ34c@mail.gmail.com>
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
To: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: linux-man@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Kexec Mailing List <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On Sun, Oct 31, 2010 at 07:19:58AM +0100, Michael Kerrisk wrote:
> On Sat, Jun 19, 2010 at 9:45 PM, Andi Kleen <andi@firstfloor.org> wrote:
> > On Sat, Jun 19, 2010 at 12:18:52PM -0700, Eric W. Biederman wrote:
> >> Andi Kleen <andi@firstfloor.org> writes:
> >>
> >> > Here are the beginnings of a kexec_load manpage.
> >> >
> >> > Probably needs some more review from Eric and may need some additional
> >> > information.
> >> >
> >> > The syscall is actually only usable with a kernel patch to export
> >> > the header I just sent separately.
> >>
> >> The syscall has been used for years with a separate non-kernel header.
> >
> > Yes but that's not a sane interface that can be documented.
> 
> Agreed. Surely the right thing to do is export the proper header?

I am in favour of that option.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
