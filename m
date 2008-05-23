Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Jzete-0003qV-AW
	for kexec@lists.infradead.org; Fri, 23 May 2008 21:33:54 +0000
Date: Fri, 23 May 2008 23:33:48 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: correction to compat_sys_kexec_load
Message-ID: <20080523233348.13fe0c63@kopernikus.site>
In-Reply-To: <m1ve144w25.fsf@frodo.ebiederm.org>
References: <4836AC3C.3090005@in.ibm.com> <m1ve144w25.fsf@frodo.ebiederm.org>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1845648261=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: akpm@osdl.org, Sharyathi Nagesh <sharyath@in.ibm.com>, sachinp@in.ibm.com, mohd.omar@in.ibm.com, Kexec Mailing List <kexec@lists.infradead.org>, fastboot@lists.osdl.org, linux-kernel@vger.kernel.org, mohan@in.ibm.com, IndhuDurai@in.ibm.com

--===============1845648261==
Content-Type: multipart/signed; boundary="Sig_/UD+KsdZykL9myZF89pu6F+C";
	protocol="application/pgp-signature"; micalg=PGP-SHA1

--Sig_/UD+KsdZykL9myZF89pu6F+C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

* ebiederm@xmission.com (Eric W. Biederman) [2008-05-23 13:14]:
>
> What we need to do is fix /sbin/kexec to pass in the correct
> architecture of the kernel for unload as it does for load.

How should it know that it unloads a 32 bit kernel on a 64 bit system?
It doesn't have access to the kernel any more once it has been loaded.



	Bernhard

PS: My mail server complains that  maneesh@in.ltcfwd.linux.ibm.com is
invalid because "Recipient address rejected: Domain not found". Maybe
some of the other IBM guys in Cc can take a look at this ... I just
removed that address from Cc for now.

--Sig_/UD+KsdZykL9myZF89pu6F+C
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFINzg8iGU2lt2vZFQRAvUFAJ9tzHrmY+M1caR137Ay9d2hDFso2gCgqXc6
jAYk/290hNDvb8Ya2a/iZOo=
=8VmB
-----END PGP SIGNATURE-----

--Sig_/UD+KsdZykL9myZF89pu6F+C--


--===============1845648261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1845648261==--

