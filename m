Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f0lOp-0005K4-88
 for kexec@lists.infradead.org; Tue, 27 Mar 2018 10:00:17 +0000
Date: Tue, 27 Mar 2018 17:59:55 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5 4/5] kexec: Add option to fall back to KEXEC_LOAD when
 KEXEC_FILE_LOAD is not supported
Message-ID: <20180327095955.GB4681@dhcp-128-65.nay.redhat.com>
References: <20180302091706.GA15374@dhcp-128-65.nay.redhat.com>
 <9db6c165a0832796faf88b0cef8f296a896f5fa8.1521561315.git.msuchanek@suse.de>
 <20180326090832.GA24210@dhcp-128-65.nay.redhat.com>
 <20180326091210.GA4781@dhcp-128-65.nay.redhat.com>
 <20180326193810.028a94b5@kitsune.suse.cz>
 <87in9i3c08.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87in9i3c08.fsf@morokweng.localdomain>
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Petr Tesarik <ptesarik@suse.cz>, kexec@lists.infradead.org, Tony Jones <tonyj@suse.com>, horms@verge.net.au, hbathini@linux.vnet.ibm.com, Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>

On 03/26/18 at 03:52pm, Thiago Jung Bauermann wrote:
> =

> Michal Such=E1nek <msuchanek@suse.de> writes:
> =

> > On Mon, 26 Mar 2018 17:12:10 +0800
> > Dave Young <dyoung@redhat.com> wrote:
> >
> >> On 03/26/18 at 05:08pm, Dave Young wrote:
> >> > On 03/20/18 at 04:56pm, Michal Suchanek wrote:  =

> >> > > Not all architectures implement KEXEC_FILE_LOAD. However, on some
> >> > > archiectures KEXEC_FILE_LOAD is required when secure boot is
> >> > > enabled in locked-down mode. Previously users had to select the
> >> > > KEXEC_FILE_LOAD syscall with undocumented -s option. However, if
> >> > > they did pass the option kexec would fail on architectures that
> >> > > do not support it.
> >> > > =

> >> > > So add an -a option that tries KEXEC_FILE_LOAD and when it is not
> >> > > supported tries KEXEC_LOAD.
> >> > > =

> >> > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> >> > > ---
> >> > > v3: instead of changing the deafult add extra option
> >> > > v4: actually check -ENOSYS as well
> >> > > v5: add missing break
> >> > > ---
> >> > >  kexec/kexec.c | 58
> >> > > +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
> >> > > kexec/kexec.h |  6 +++++- 2 files changed, 58 insertions(+), 6
> >> > > deletions(-)
> >> > > =

> >> > > diff --git a/kexec/kexec.c b/kexec/kexec.c
> >> > > index 68ae0594d4a7..44042345a16e 100644
> >> > > --- a/kexec/kexec.c
> >> > > +++ b/kexec/kexec.c
> >> > > @@ -1243,6 +1243,7 @@ int main(int argc, char *argv[])
> >> > >  	int do_unload =3D 0;
> >> > >  	int do_reuse_initrd =3D 0;
> >> > >  	int do_kexec_file_syscall =3D 0;
> >> > > +	int do_kexec_fallback =3D 0;
> >> > >  	int do_status =3D 0;
> >> > >  	void *entry =3D 0;
> >> > >  	char *type =3D 0;
> >> > > @@ -1367,6 +1368,15 @@ int main(int argc, char *argv[])
> >> > >  			break;
> >> > >  		case OPT_KEXEC_FILE_SYSCALL:
> >> > >  			do_kexec_file_syscall =3D 1;
> >> > > +			do_kexec_fallback =3D 0;
> >> > > +			break;
> >> > > +		case OPT_KEXEC_SYSCALL:
> >> > > +			do_kexec_file_syscall =3D 0;
> >> > > +			do_kexec_fallback =3D 0;
> >> > > +			break;
> >> > > +		case OPT_KEXEC_SYSCALL_AUTO:
> >> > > +			do_kexec_file_syscall =3D 1;
> >> > > +			do_kexec_fallback =3D 1;
> >> > >  			break;
> >> > >  		case OPT_STATUS:
> >> > >  			do_status =3D 1;
> >> > > @@ -1433,7 +1443,7 @@ int main(int argc, char *argv[])
> >> > >  		}
> >> > >  	}
> >> > >  	if (do_kexec_file_syscall) {
> >> > > -		if (do_load_jump_back_helper)
> >> > > +		if (do_load_jump_back_helper
> >> > > && !do_kexec_fallback) die("--load-jump-back-helper not supported
> >> > > with kexec_file_load\n"); if (kexec_flags &
> >> > > KEXEC_PRESERVE_CONTEXT) die("--load-preserve-context not
> >> > > supported with kexec_file_load\n"); @@ -1447,16 +1457,54 @@ int
> >> > > main(int argc, char *argv[]) result =3D k_status(kexec_flags);
> >> > >  	}
> >> > >  	if (do_unload) {
> >> > > -		if (do_kexec_file_syscall)
> >> > > +		if (do_kexec_file_syscall) {
> >> > >  			result =3D
> >> > > kexec_file_unload(kexec_file_flags);
> >> > > -		else
> >> > > +			if ((result =3D=3D -ENOSYS) &&
> >> > > do_kexec_fallback)
> >> > > +				do_kexec_file_syscall =3D 0;
> >> > > +		}
> >> > > +		if (!do_kexec_file_syscall)
> >> > >  			result =3D k_unload(kexec_flags);
> >> > >  	}
> >> > >  	if (do_load && (result =3D=3D 0)) {
> >> > > -		if (do_kexec_file_syscall)
> >> > > +		if (do_kexec_file_syscall) {
> >> > >  			result =3D do_kexec_file_load(fileind,
> >> > > argc, argv, kexec_file_flags);
> >> > > -		else
> >> > > +			if (do_kexec_fallback) switch (result) {
> >> > > +				/*
> >> > > +				 * Something failed with
> >> > > signature verification.
> >> > > +				 * Reject the image.
> >> > > +				 */
> >> > > +				case -ELIBBAD:
> >> > > +				case -EKEYREJECTED:
> >> > > +				case -ENOPKG:
> >> > > +				case -ENOKEY:
> >> > > +				case -EBADMSG:
> >> > > +				case -EMSGSIZE:
> >> > > +					/*
> >> > > +					 * By default reject or
> >> > > do nothing if
> >> > > +					 * succeded
> >> > > +					 */
> >> > > +				default: break;
> >> > > +				case -ENOSYS: /* not implemented
> >> > > */
> >> > > +					/*
> >> > > +					 * Parsing image or
> >> > > other options failed
> >> > > +					 * The image may be
> >> > > invalid or image
> >> > > +					 * type may not
> >> > > supported by kernel so
> >> > > +					 * retry parsing in
> >> > > kexec-tools.
> >> > > +					 */
> >> > > +				case -EINVAL:
> >> > > +				case -ENOEXEC:
> >> > > +					 /*
> >> > > +					  * ENOTSUPP can be
> >> > > unsupported image
> >> > > +					  * type or unsupported
> >> > > PE signature
> >> > > +					  * wrapper type, duh
> >> > > +					  */
> >> > > +				case -ENOTSUP:  =

> >> > =

> >> > Hmm, this is still used in latest version.  kernel does not return
> >> > such error number,  I might not say clearly previously.  Please
> >> > check the kernel code, the only one place I know is because no
> >> > kdump support in power kexec_file:
> >> > arch/powerpc/kernel/machine_kexec_file_64.c
> >> > =

> >> >         /* We don't support crash kernels yet. */
> >> >         if (image->type =3D=3D KEXEC_TYPE_CRASH)
> >> >                 return -ENOTSUPP;
> >> > =

> >> > So I suggest not checking this as well since -ENOTSUPP is not
> >> > populated in userspace headers, and -ENOTSUP is not used at all.
> >> > =

> >> > Also as I mentioned in another reply -EINVAL and -ENOEXEC is also
> >> > not ncessary.
> >> > =

> >> > For -ENOTSUP, maybe someone can submit a patch to switch to
> >> > -ENOTSUPP so that userspace can check it.
> >> > Ccing Thiago and Hari for the -ENOTSUPP errno issue.  =

> >> =

> >> Oops for the hurry reply,  I means -ENOTSUPP might be able to replaced
> >> with -EOPNOTSUPP, a similar change like this:
> >> https://patchwork.kernel.org/patch/8490791/
> >
> > Thanks for catching this. In Linux ENOTSUPP with extra P is different
> > from EOPNOTSUPP and ENOTSUP (single P). Since we are talking to the
> > kernel and it returns the double P ENOTSUPP we need to define it in
> > kexec as well. And we should check ENOTSUP with single P in case
> > somebody some day thinks that returning undefined error codes to
> > userspace is not nice like in the patch above.
> =

> I wasn't aware that ENOTSUPP was an in-kernel only errno. Should I
> submit a patch for the kernel so that powerpc returns -EOPNOTSUPP in
> case of trying to load kdump kernel with kexec_file_load()?

This should be the easiest way and worth a try since userspace check it
now. =


> =

> -- =

> Thiago Jung Bauermann
> IBM Linux Technology Center
> =


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
