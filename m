Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ew1BQ-0002Mt-2j
 for kexec@lists.infradead.org; Wed, 14 Mar 2018 07:50:50 +0000
Date: Wed, 14 Mar 2018 15:50:31 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 5/5] kexec: document -s, -c and -a options.
Message-ID: <20180314075031.GB23942@dhcp-128-65.nay.redhat.com>
References: <20180302091706.GA15374@dhcp-128-65.nay.redhat.com>
 <6a8aa85dbaa781348890362aa2d8589c91b8b458.1520342150.git.msuchanek@suse.de>
 <20180314034130.GA2039@dhcp-128-65.nay.redhat.com>
 <20180314082519.0fcca316@naga.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180314082519.0fcca316@naga.suse.cz>
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
Cc: Petr Tesarik <ptesarik@suse.cz>, horms@verge.net.au, kexec@lists.infradead.org, Tony Jones <tonyj@suse.com>

On 03/14/18 at 08:25am, Michal Such=E1nek wrote:
> On Wed, 14 Mar 2018 11:41:30 +0800
> Dave Young <dyoung@redhat.com> wrote:
> =

> > On 03/06/18 at 02:15pm, Michal Suchanek wrote:
> > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > ---
> > >  kexec/kexec.8 | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > > =

> > > diff --git a/kexec/kexec.8 b/kexec/kexec.8
> > > index e0131b4ea827..b3543db3f413 100644
> > > --- a/kexec/kexec.8
> > > +++ b/kexec/kexec.8
> > > @@ -144,6 +144,21 @@ Load the new kernel for use on panic.
> > >  Specify that the new kernel is of this
> > >  .I type.
> > >  .TP
> > > +.BI \-s\ (\-\-kexec-file-syscall)
> > > +Specify that the new KEXEC_FILE_LOAD syscall should be used
> > > exclusively.  =

> > =

> > Maybe better to be simple like below:
> > "Use kexec_file_load syscall to load the new kernel."
> > =

> > =

> > > +.TP
> > > +.BI \-c\ (\-\-kexec-syscall)
> > > +Specify that the old KEXEC_LOAD syscall should be used exclusively
> > > (the default).  =

> > =

> > similarly:
> > "Use kexec_load syscall to load the new kernel."
> > =

> > > +.TP
> > > +.BI \-a\ (\-\-kexec-syscall-auto)
> > > +Try the new simpler KEXEC_FILE_LOAD syscall first and if it is not
> > > supported +fall back to the old KEXEC_LOAD interface.
> > > +
> > > +There is no one single interface that always works.
> > > KEXEC_FILE_LOAD is required +on systems that use locked-down secure
> > > boot to verify the kernel signature. +KEXEC_LOAD is required for
> > > some kernel image formats and on architectures that +do not support
> > > KEXEC_FILE_LOAD.  =

> > =

> > It seems not good to say kexec_file_load is simpler and newer.  Also
> > it is not a must for Secure Boot and locked down kernel only. So it
> > would be better to just simplify and use the first paragraph:
> > =

> > "Try kexec_file_load syscall first and if it is not supported fall
> > back to the kexec_load syscall"
> =

> There was a request for explanation so just the first paragraph will
> not do. What is it required for other than secure boot?

People can use kexec -s to load a signed kernel but not necessary to
boot with Secure Boot enabled.

There is no Secure Boot in powerpc, arm64 now.

> =

> Thanks
> =

> Michal

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
