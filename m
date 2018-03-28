Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f0zM0-0006WN-5D
 for kexec@lists.infradead.org; Wed, 28 Mar 2018 00:54:17 +0000
Date: Wed, 28 Mar 2018 08:53:53 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5 4/5] kexec: Add option to fall back to KEXEC_LOAD when
 KEXEC_FILE_LOAD is not supported
Message-ID: <20180328005353.GB7227@dhcp-128-65.nay.redhat.com>
References: <20180302091706.GA15374@dhcp-128-65.nay.redhat.com>
 <9db6c165a0832796faf88b0cef8f296a896f5fa8.1521561315.git.msuchanek@suse.de>
 <20180326090832.GA24210@dhcp-128-65.nay.redhat.com>
 <20180326091210.GA4781@dhcp-128-65.nay.redhat.com>
 <20180326193810.028a94b5@kitsune.suse.cz>
 <20180327100619.GC4681@dhcp-128-65.nay.redhat.com>
 <20180327130129.413bd399@kitsune.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180327130129.413bd399@kitsune.suse.cz>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Petr Tesarik <ptesarik@suse.cz>, kexec@lists.infradead.org, hbathini@linux.vnet.ibm.com, Tony Jones <tonyj@suse.com>, horms@verge.net.au, bauerman@linux.vnet.ibm.com

On 03/27/18 at 01:01pm, Michal Such=E1nek wrote:
> On Tue, 27 Mar 2018 18:06:19 +0800
> Dave Young <dyoung@redhat.com> wrote:
> =

> > On 03/26/18 at 07:38pm, Michal Such=E1nek wrote:
> > > On Mon, 26 Mar 2018 17:12:10 +0800
> > > Dave Young <dyoung@redhat.com> wrote:
> > >   =

> > > > On 03/26/18 at 05:08pm, Dave Young wrote:  =

> > > > > On 03/20/18 at 04:56pm, Michal Suchanek wrote:    =

> =

> > > > > Hmm, this is still used in latest version.  kernel does not
> > > > > return such error number,  I might not say clearly previously.
> > > > > Please check the kernel code, the only one place I know is
> > > > > because no kdump support in power kexec_file:
> > > > > arch/powerpc/kernel/machine_kexec_file_64.c
> > > > > =

> > > > >         /* We don't support crash kernels yet. */
> > > > >         if (image->type =3D=3D KEXEC_TYPE_CRASH)
> > > > >                 return -ENOTSUPP;
> > > > > =

> > > > > So I suggest not checking this as well since -ENOTSUPP is not
> > > > > populated in userspace headers, and -ENOTSUP is not used at all.
> > > > > =

> > > > > Also as I mentioned in another reply -EINVAL and -ENOEXEC is
> > > > > also not ncessary.
> > > > > =

> > > > > For -ENOTSUP, maybe someone can submit a patch to switch to
> > > > > -ENOTSUPP so that userspace can check it.
> > > > > Ccing Thiago and Hari for the -ENOTSUPP errno issue.    =

> > > > =

> > > > Oops for the hurry reply,  I means -ENOTSUPP might be able to
> > > > replaced with -EOPNOTSUPP, a similar change like this:
> > > > https://patchwork.kernel.org/patch/8490791/  =

> > > =

> > > Thanks for catching this. In Linux ENOTSUPP with extra P is
> > > different from EOPNOTSUPP and ENOTSUP (single P). Since we are
> > > talking to the kernel and it returns the double P ENOTSUPP we need
> > > to define it in kexec as well. And we should check ENOTSUP with
> > > single P in case somebody some day thinks that returning undefined
> > > error codes to userspace is not nice like in the patch above.  =

> > =

> > I'm not sure if we can define it in kexec-tools since they are used
> > in kernel only.. =

> =

> We define the KEXEC_FILE_LOAD syscall numbers so why not ENOTSUPP?

They are different syscall number is persistent but internal errnos are
not supposed to be so.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
