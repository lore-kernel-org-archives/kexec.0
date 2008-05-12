Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by pentafluge.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Jvyj8-0008KW-3b
	for kexec@lists.infradead.org; Tue, 13 May 2008 17:55:51 +0000
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] Add --reuse-cmdline 
In-reply-to: <20080512153849.74753e71@kopernikus.site> 
References: <20080508204943.GA24160@suse.de> <19164.1210353205@neuling.org>
	<20080512153849.74753e71@kopernikus.site>
Date: Mon, 12 May 2008 14:43:57 -0500
Message-ID: <17602.1210621437@neuling.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org



In message <20080512153849.74753e71@kopernikus.site> you wrote:
> --Sig_/XVYJV.ZkU.f5R3y3b_UR6.k
> Content-Type: text/plain; charset=US-ASCII
> Content-Transfer-Encoding: quoted-printable
> 
> Hi,
> 
> at first thanks for looking at the patch.
> 
> * Michael Neuling <mikey@neuling.org> [2008-05-09 12:13]:
> >=20
> > In message <20080508204943.GA24160@suse.de> you wrote:
> > > This patch adds an option "--reuse-cmdline" for people that are lazy in=
>  typin
> > g
> > > --append=3D"$(cat /proc/cmdline)". The advantage of "--reuse-cmdline" i=
> s also t
> > hat
> > > it strips off BOOT_IMAGE (since it may not be correct any more) from li=
> lo and
> > > other boot loaders, and, more important, the crashkernel option in case=
>  a
> > > panic kernel is loaded.
> > >=20
> > > If you like the option I can also add it for really all architectures. =
> Tested
> >  only
> > > with x86-bzImage both the kexec and kdump case.
> >=20
> > For ppc64, the default is to reuse the command line.  We should probably
> > merge functionality.
> 
> Where is that functionality implemented? I couldn't find it. Does the
> kernel that automatically on PPC64? I know too litte about that
> architecture.

Sorry, I think I was mistaken.  ppc64 only takes the "root=<blah>" from
the first kernel, provided it's not specified on the kexec command line
for the next kernel.

Anyway, the code is in kexec/arch/ppc64/fs2dt.c (search for "root=")

> > Either way, this should probably be a generic option, not x86 specific.
> 
> Well, I thought first of it. But since the '--append' parameter is not
> generic, this makes no sense.
> 
> Maybe it would make sense to change the command line handling in
> general to be global and not image specific, but first I need to
> understand how that works on PPC64 ... (and probably others).

Yeah, the cmdline should be generically and consistently handled rather
than what we have now.

Mikey

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
