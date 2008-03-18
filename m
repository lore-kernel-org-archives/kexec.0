Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JbS6n-0001t1-CO
	for kexec@lists.infradead.org; Tue, 18 Mar 2008 03:03:25 +0000
Date: Tue, 18 Mar 2008 12:03:19 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] x86_64 purgatory Makefile typo fix.
Message-ID: <20080318030317.GA12309@verge.net.au>
References: <47DA428C.3040608@in.ibm.com> <20080317004922.GC1433@verge.net.au>
	<frlcco$7u5$1@ger.gmane.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <frlcco$7u5$1@ger.gmane.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

On Mon, Mar 17, 2008 at 10:07:36AM +0100, Bernhard Walle wrote:
> Hi Simon,
> =

> * Simon Horman [2008-03-17 01:49]:
> > =

> > Ooops, sorry about that.
> > =

> > Perhaps this is worthy of a fresh release?
> =

> IMO yes since the current release is unusable on x86_64. But please make
> sure to also include the
> =

> =A01. The distribution missed the files
> =

> =A0 =A0 =A0 =A0 purgatory/arch/x86_64/entry64-32.S,
> =A0 =A0 =A0 =A0 purgatory/arch/x86_64/entry64.S,
> =A0 =A0 =A0 =A0 purgatory/arch/x86_64/setup-x86_64.S,
> =A0 =A0 =A0 =A0 purgatory/arch/x86_64/stack.S,
> =A0 =A0 =A0 =A0 purgatory/arch/x86_64/purgatory-x86_64.c
> =

> =A0 =A0 The problem was that variable expansion in a Makefile is a bit   =

>     different from the expectation, i.e. the final value is used even if
>     the variable is used in the middle.
> =

> part of my fix.

Thanks, I wasn't aware that was how make variables work.
I've merged your change.

-- =

Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
