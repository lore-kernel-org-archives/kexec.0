Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T9v42-0006ek-0R
 for kexec@lists.infradead.org; Fri, 07 Sep 2012 09:41:27 +0000
Date: Fri, 7 Sep 2012 11:41:20 +0200
From: =?iso-8859-1?Q?Llu=EDs?= Batlle i Rossell <viric@viric.name>
Subject: Re: Getting the kexec on panic
Message-ID: <20120907094120.GL1943@vicerveza.homeunix.net>
References: <20120906094336.GJ1943@vicerveza.homeunix.net>
 <20120906220651.GB1745@cantor.Home> <5049BFA9.4090107@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5049BFA9.4090107@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org

On Fri, Sep 07, 2012 at 05:34:33PM +0800, Dave Young wrote:
> On 09/07/2012 06:06 AM, Jerry Snitselaar wrote:
> =

> > On Thu Sep 06 12, Llu=EDs Batlle i Rossell wrote:
> >> Hello,
> >>
> >> while I can load immediately a kernel using kexec, when I set it for p=
anic and
> >> crash with sysrq-c, the computer hangs.
> >>
> >> I'm using the nvidia X driver; can it be that it stops the panic handl=
ing from
> >> working? I don't understand why it would work with normal kexec though=
, if it
> >> were the case.
> >>
> >> Regards,
> >> Llu=EDs.
> > =

> > Hi Lluis,
> > =

> > =

> > What kernel are you using? The commit 722bc6b "x86/mm: Fix the size cal=
culation of mapping tables" which started showing up in 3.5-rc1 causes prob=
lems for the crash kernel. You might try this patchset[1] from Jacob Shin a=
nd see if it resolves the problem for you if you are experiencing your prob=
lem on a 3.5-rc1+ kernel.
> > =

> > [1] https://lkml.org/lkml/2012/8/24/474
> =

> =

> He has updated the v5 patch set as below:
> https://lkml.org/lkml/2012/8/29/227

I was in 3.5.2 when I tried. Ok, I see these are very recent... I may prepa=
re a
build including that.

Thank you!
Llu=EDs.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
