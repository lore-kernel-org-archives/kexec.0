Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ew19c-0000q3-ED
 for kexec@lists.infradead.org; Wed, 14 Mar 2018 07:48:58 +0000
Date: Wed, 14 Mar 2018 15:48:35 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 4/5] kexec: add option to fall back to KEXEC_LOAD when
 KEXEC_FILE_LOAD is not supported.
Message-ID: <20180314074835.GA23942@dhcp-128-65.nay.redhat.com>
References: <20180302091706.GA15374@dhcp-128-65.nay.redhat.com>
 <19a47e290fc03efea82af845740ae8f6b30f13b8.1520342150.git.msuchanek@suse.de>
 <20180314032240.GB4889@dhcp-128-65.nay.redhat.com>
 <20180314082303.78db2e43@naga.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180314082303.78db2e43@naga.suse.cz>
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
Cc: Tony Jones <tonyj@suse.com>, horms@verge.net.au, kexec@lists.infradead.org, Petr Tesarik <ptesarik@suse.cz>

On 03/14/18 at 08:23am, Michal Such=E1nek wrote:
> On Wed, 14 Mar 2018 11:22:40 +0800
> Dave Young <dyoung@redhat.com> wrote:
> =

> > On 03/06/18 at 02:15pm, Michal Suchanek wrote:
> > > Not all architectures implement KEXEC_FILE_LOAD. However, on some
> > > archiectures KEXEC_FILE_LOAD is required when secure boot is
> > > enabled in locked-down mode. Previously users had to select the
> > > KEXEC_FILE_LOAD syscall with undocumented -s option. However, if
> > > they did pass the option kexec would fail on architectures that do
> > > not support it.
> > > =

> > > So add an -a option that tries KEXEC_FILE_LOAD and when it is not
> > > supported tries KEXEC_LOAD.
> > > =

> > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > ---
> > > v3: instead of changing the deafult add extra option
> > > v4: actually check -ENOSYS as well
> > > ---
> > >  kexec/kexec.c | 52
> > > ++++++++++++++++++++++++++++++++++++++++++++++++---- kexec/kexec.h
> > > |  4 +++- 2 files changed, 51 insertions(+), 5 deletions(-)
> > > =

> > > diff --git a/kexec/kexec.c b/kexec/kexec.c
> > > index a95cfb473d6b..5c5aee344b41 100644
> > > --- a/kexec/kexec.c
> > > +++ b/kexec/kexec.c
> > > @@ -1243,6 +1243,7 @@ int main(int argc, char *argv[])
> > >  	int do_unload =3D 0;
> > >  	int do_reuse_initrd =3D 0;
> > >  	int do_kexec_file_syscall =3D 0;
> > > +	int do_kexec_fallback =3D 0;
> > >  	int do_status =3D 0;
> > >  	void *entry =3D 0;
> > >  	char *type =3D 0;
> > > @@ -1367,10 +1368,15 @@ int main(int argc, char *argv[])
> > >  			break;
> > >  		case OPT_KEXEC_FILE_SYSCALL:
> > >  			do_kexec_file_syscall =3D 1;
> > > +			do_kexec_fallback =3D 0;
> > >  			break;
> > >  		case OPT_KEXEC_SYSCALL:
> > >  			do_kexec_file_syscall =3D 0;
> > > +			do_kexec_fallback =3D 0;
> > >  			break;
> > > +		case OPT_KEXEC_SYSCALL_AUTO:
> > > +			do_kexec_file_syscall =3D 1;
> > > +			do_kexec_fallback =3D 1;
> > >  		case OPT_STATUS:
> > >  			do_status =3D 1;
> > >  			break;
> > > @@ -1442,16 +1448,54 @@ int main(int argc, char *argv[])
> > >  		result =3D k_status(kexec_flags);
> > >  	}
> > >  	if (do_unload) {
> > > -		if (do_kexec_file_syscall)
> > > +		if (do_kexec_file_syscall) {
> > >  			result =3D
> > > kexec_file_unload(kexec_file_flags);
> > > -		else
> > > +			if ((result =3D=3D -ENOSYS) &&
> > > do_kexec_fallback)
> > > +				do_kexec_file_syscall =3D 0;
> > > +		}
> > > +		if (!do_kexec_file_syscall)
> > >  			result =3D k_unload(kexec_flags);
> > >  	}
> > >  	if (do_load && (result =3D=3D 0)) {
> > > -		if (do_kexec_file_syscall)
> > > +		if (do_kexec_file_syscall) {
> > >  			result =3D do_kexec_file_load(fileind, argc,
> > > argv, kexec_file_flags);
> > > -		else
> > > +			if (do_kexec_fallback) switch (result) {
> > > +				/*
> > > +				 * Something failed with signature
> > > verification.
> > > +				 * Reject the image.
> > > +				 */
> > > +				case -ELIBBAD:
> > > +				case -EKEYREJECTED:
> > > +				case -ENOPKG:
> > > +				case -ENOKEY:
> > > +				case -EBADMSG:
> > > +				case -EMSGSIZE:
> > > +					/*
> > > +					 * By default reject or do
> > > nothing if
> > > +					 * succeded
> > > +					 */
> > > +				default: break;
> > > +				case -ENOSYS: /* not implemented */
> > > +					/*
> > > +					 * Parsing image or other
> > > options failed
> > > +					 * The image may be
> > > invalid or image
> > > +					 * type may not supported
> > > by kernel so
> > > +					 * retry parsing in
> > > kexec-tools.
> > > +					 */
> > > +				case -EINVAL:
> > > +				case -ENOEXEC:
> > > +					 /*
> > > +					  * ENOTSUPP can be
> > > unsupported image
> > > +					  * type or unsupported PE
> > > signature
> > > +					  * wrapper type, duh
> > > +					  */
> > > +				case -ENOTSUP:  =

> > =

> > Shouldn't this be -ENOTSUPP ?
> =

> No, ENOTSUP and EOPNOTSUPP is defined. The latter is for socket
> operations.

Your code comment "ENOTSUPP can be unsupported image", but your
code use ENOTSUP,   ENOTSUP !=3D ENOTSUPP here.

> =

> Thanks
> =

> Michal

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
