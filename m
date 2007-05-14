Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hnf5M-0007s1-3Z
	for kexec@lists.infradead.org; Mon, 14 May 2007 14:15:53 -0400
Date: Mon, 14 May 2007 20:15:21 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] [makedumpfile] Implement memory regions on IA64
Message-ID: <20070514181521.GA1748@suse.de>
References: <20070426193725.GA2586@suse.de>
	<20070511155950oomichi@mail.jp.nec.com>
MIME-Version: 1.0
In-Reply-To: <20070511155950oomichi@mail.jp.nec.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1206541110=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Jay Lan <jlan@sgi.com>, Kexec Mailing List <kexec@lists.infradead.org>


--===============1206541110==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

sorry for the late reply, but I was out of office last week.

* Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp> [2007-05-11 08:59]:
> 2007/04/26 21:37:25 +0200, Bernhard Walle <bwalle@suse.de> wrote:
> >This patch fixes an error in vaddr_to_offset_ia64() which happened on
> >a SGI machine here while retrieving the utsname from the kernel dump
> >image. It implements memory region support for IA64.
>=20
> For ia64 DISCONTIGMEM support, I added the translation (virtual address
> to physical address) by using layer 3 paging into your patch.
> I created 2 attached patches for ia64 DISCONTIGMEM support.
>=20
> I confirmed makedumpfile with these patches can run on linux-2.6.18 kernel
> (made of RHEL5 kernel by changing configs from SPARSEMEM to DISCONTIGMEM).
> Could you please test them on SLES10 ?

it doesn't work here. The config file is generated, but at runtime I
get a SEGV which is caused by a endless recusion of ia64_vtop() while
resolving the utsname.

I'm looking into this ...

> BTW, the patches don't run on stock linux-2.6.20 w/DISCONTIGMEM
> (it works with stock linux-2.6.20 w/SPARSEMEM)
> I am trying to resolve the problem and if you have any idea about
> kernel changes between 2.6.18-20, please let me know.

Sorry, no.



Thanks,
   Bernhard

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFGSKc5iGU2lt2vZFQRAqLcAJ94fv7nPkG1FYSNAPGNg8xH3jSn6wCeIg7u
NU2nVAYAlc9mivDMu8ozRlE=
=movL
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--


--===============1206541110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1206541110==--

