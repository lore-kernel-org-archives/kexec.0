Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JMIra-0007Tx-6p
	for kexec@lists.infradead.org; Tue, 05 Feb 2008 08:09:13 +0000
Date: Tue, 5 Feb 2008 09:09:00 +0100
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [mm] Crashkernel memory reservation fails with 2.6.24-rc8-mm1
Message-ID: <20080205080900.GB30563@suse.de>
References: <47A7391F.2020408@in.ibm.com> <20080204183810.GE16021@redhat.com>
	<20080204193524.GA11104@suse.de> <47A7F53C.8090606@in.ibm.com>
MIME-Version: 1.0
In-Reply-To: <47A7F53C.8090606@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0709787498=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Sachin P. Sant" <sachinp@in.ibm.com>
Cc: kexec@lists.infradead.org, linux-kernel <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@redhat.com>


--===============0709787498==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Sachin P. Sant <sachinp@in.ibm.com> [2008-02-05 06:33]:
> Bernhard Walle wrote:
>> * Vivek Goyal <vgoyal@redhat.com> [2008-02-04 19:38]:
>>  =20
>>> Bernahard, any idea who is the competitor here?
>>>    =20
>> Hm ..., can you boot the kernel without crashkernel=3D and provide the
>> /proc/iomem?
>>  =20
> Attached is the /proc/iomem output with and without crashkernel
> parameter.

Looks ok. In my case when I added the warning message the kernel BSS
was too large. But that doesn't seem to be the case here, BSS ends
with 9M and you use 16M as start address for the crashkernel.


        Bernhard

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQFHqBmciGU2lt2vZFQRAmWeAJ9llKxtEBcATo8q/CHr0AjvAUsfZACgnDIc
F4jkDcLlPNKMrX7yRDuXST0=
=3qDb
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--


--===============0709787498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0709787498==--

