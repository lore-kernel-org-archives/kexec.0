Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QPzPb-0004SR-1S
	for kexec@lists.infradead.org; Fri, 27 May 2011 15:57:20 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id p4RFujKj024702
	for <kexec@lists.infradead.org>; Sat, 28 May 2011 01:56:45 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4RFulpC1069302
	for <kexec@lists.infradead.org>; Sat, 28 May 2011 01:56:47 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p4RFvDlC024741
	for <kexec@lists.infradead.org>; Sat, 28 May 2011 01:57:13 +1000
Date: Fri, 27 May 2011 21:26:56 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 1/6] XPANIC: Add extended panic interface
Message-ID: <20110527155656.GB2384@in.ibm.com>
References: <20110526170722.GB23266@in.ibm.com>
	<20110526171209.GA17988@in.ibm.com>
	<BANLkTi=ZrPkRwFSmdkAB60-MKS3fwZOjpg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BANLkTi=ZrPkRwFSmdkAB60-MKS3fwZOjpg@mail.gmail.com>
Reply-To: prasad@linux.vnet.ibm.com
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, May 26, 2011 at 07:38:19PM +0200, richard -rw- weinberger wrote:
> On Thu, May 26, 2011 at 7:12 PM, K.Prasad <prasad@linux.vnet.ibm.com> wro=
te:
> >
> > commit e668fa1aea7844ac4c7ea09030a2f3e647a4adb1
> > Author: Andi Kleen <ak@linux.intel.com>
> > Date: =A0 Fri Nov 19 18:36:44 2010 +0100
> >
> > Index: linux-2.6.slim_kdump/kernel/panic.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.slim_kdump.orig/kernel/panic.c
> > +++ linux-2.6.slim_kdump/kernel/panic.c
> > @@ -57,14 +57,37 @@ EXPORT_SYMBOL(panic_blink);
> > =A0*
> > =A0* =A0 =A0 This function never returns.
> > =A0*/
> > -NORET_TYPE void panic(const char * fmt, ...)
> > +NORET_TYPE void panic(const char *fmt, ...)
> > +{
> > + =A0 =A0 =A0 va_list ap;
> > + =A0 =A0 =A0 va_start(ap, fmt);
> > + =A0 =A0 =A0 vpanic(0, 0, fmt, ap);
> > +}
> > +EXPORT_SYMBOL(panic);
> > +
> > +NORET_TYPE void xpanic(enum panic_flags flags, int timeout,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *fmt, ...)
> > +{
> > + =A0 =A0 =A0 va_list ap;
> > + =A0 =A0 =A0 va_start(ap, fmt);
> > + =A0 =A0 =A0 xpanic(flags, timeout, fmt, ap);
> =

> Why are you calling xpanic() here again?
> I guess you meant vpanic().
>

True, this is a bug in the original patch found in the git tree
git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-mce-2.6.git, for
which I have proposed a patch here: https://lkml.org/lkml/2011/5/26/337.

Thanks,
K.Prasad
 =


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
