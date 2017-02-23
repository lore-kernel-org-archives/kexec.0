Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from vmicros1.altlinux.org ([194.107.17.57])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1cgioW-0004Oq-DV
 for kexec@lists.infradead.org; Thu, 23 Feb 2017 02:07:26 +0000
Date: Thu, 23 Feb 2017 05:07:02 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] uapi: fix linux/kexec.h userspace compilation errors
Message-ID: <20170223020702.GA16308@altlinux.org>
References: <20170222224646.GC14311@altlinux.org> <87h93l3cwl.fsf@xmission.com>
Mime-Version: 1.0
In-Reply-To: <87h93l3cwl.fsf@xmission.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5883925029126543622=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org


--===============5883925029126543622==
Content-Type: multipart/signed; micalg=x-unknown;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2017 at 02:37:46PM +1300, Eric W. Biederman wrote:
> "Dmitry V. Levin" <ldv@altlinux.org> writes:
>=20
> > Include <stddef.h> (guarded by #ifndef __KERNEL__) to fix the following
> > linux/kexec.h userspace compilation errors:
> >
> > /usr/include/linux/kexec.h:53:2: error: unknown type name 'size_t'
> >   size_t bufsz;
> > /usr/include/linux/kexec.h:55:2: error: unknown type name 'size_t'
> >   size_t memsz;
>=20
> Were these failures generated with a static checker?

Yes, with
gcc -S -o/dev/null -xc /dev/null -include /usr/include/linux/kexec.h

> What changed that you are seeing new failures in old essentially static
> headers?

Every uapi header file should be standalone, i.e. it must include,
directly or indirectly, every definition it uses, so that no user
should have to guess header dependencies.

It's not the first time I'm seeing this compilation error,
but now I've got some time to submit a fix.  Better late than never.


--=20
ldv

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYrkPGAAoJEAVFT+BVnCUI1ikP/3HrfOGL5L8nkxemcFi2WpBZ
X/8Y3Rj+SNPEC8nqFolhv/Z0ySxRjOYn31rgRRRF8zD+UmfBj3eivgk3Z6/D+aw5
FxFHr70/YY0hIsg8NOGx/Fblap7yN3wG1wKA8TfAAbkAkS2R49u/SHV3BedTLJGo
hulrQX/1lWGZqHTrRci3Ui2L+HJHhWQNDMFiTON/wiPXvtE6WcSqBPEoXlFNhmLl
4S7qxHBuPU1ysAH+1hBZnGL1KulIdo2qT7mJsc3Vdw3cFYwz0wlGOTiPRvBsGXcg
Uz3dkJq0lqlyc/rm6tuAVSHMixzuwdhO/xDrLhv0K4LJYdXcelIaaiXctHNeEt79
qWFIWw8uJyXLbiCtVvyckcD1whbuXBIW1Cq9sBF74/Pul/ejzyXqX0AZ9ms7mwqo
TXD0gTbjjk6uJYTJ/SJBRXvE53I5VMRmt/zQcuci1YBvCcCtjKoZ4ox/3YYORfCV
+7jKAON+2xFaggO93RLeFoQaV//h+/bXpZ3EYATCLWTcj68xzA4cc/uBuUJqMV9S
U1egT7R5h58HV+sLgtiB551dsi2BKmmkuU0zApnsu31hBS+J8HzB7YKrr1wAWiEq
XXaXzyviYIK6CdXaTKDQCvR4k1hYUL8KkB5P3svqzO6wtU85OZtEQhzAWSqaWQjn
/VjkH1Mx9Ou0VVV9IIjH
=E5jd
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--


--===============5883925029126543622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============5883925029126543622==--

