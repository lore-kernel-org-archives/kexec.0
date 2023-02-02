Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C48C636CC
	for <kexec@archiver.kernel.org>; Sun,  5 Feb 2023 11:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=Odk86bVTjUVKcvYIgpdeeaBh1H3hF2hq/Fc2whXAgww=; b=craO1XIUnSkIn0
	reSrKGQSo28F1S/fKUGeNIad/mpWI9QrTi8eLKOY5cgtLMJSsOHvOls5kLmebGhuhZwUsk2hkukoU
	EcxAL/OOk89QC/oSKS/ynNM3BM+BxFTbToa8n7l9UB/YqXREWw1q6kwZFo0e25vrCrxCBllN9P5r5
	XEd9MH26cTC43FH1AfdM1/UdcLTpovS/XgD5kGz7GCIXSW50++2L5WUaDnXnjMOZ6oXFJNd0dbw3i
	z3nz/GLK/MPZlQ+6yOtiM0sZH1jOkpRYQpPoZYtgcV/UPKWcpWBzgbgV8NcmiSolNm3T258L4pubV
	rSImUPTy2/PhKDVKHzKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pOdRW-006J3A-M5; Sun, 05 Feb 2023 11:44:22 +0000
Received: from [139.28.40.42] (helo=tarta.nabijaczleweli.xyz)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNiqA-00HOjV-Qp
	for kexec@lists.infradead.org; Thu, 02 Feb 2023 23:18:04 +0000
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 270C9B76;
	Fri,  3 Feb 2023 00:10:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202211; t=1675379419;
	bh=FQVAlkyCMXUqDcJJP8aCvHjOobANB8oK8qKNl39neOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=b/ncWqljVLvi2LHfT4lMDhilzJLZYb80yGnfWuNJn2vHwLSlJUGIo06RAyZvV5h9g
	 x1YB/VBZP7DVnpSCEt7DjBsPA862i5sa5ivr99busK2FI+h3W74m3l+I3ap/e0b6QY
	 LzwpCf2MV4RRJ/lbbSjdlYgPtn5+ntERsWzlI+vVdDDAaW0HhUqB5Dbmohll2PIUgt
	 wV3JgaSwHGs7dyxIfbyk08Hkc9b0X1EJMdc2QXBjjUlPoJKddTLd7IkbwgSDKO+oJI
	 EBH0DPjDIOLmwVaNWv2HNZLH75+X9z8clSy2jvhWLq+ymgTTsMl377AM5thF5K4PW8
	 qdF3lI0QAW5oA==
Date: Fri, 3 Feb 2023 00:10:18 +0100
From: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: kexec@lists.infradead.org
Cc: 1030248@bugs.debian.org
Subject: [PATCH] kexec: make -a the default
Message-ID: <20230202231018.fnyq4ech4tiivgbi@tarta.nabijaczleweli.xyz>
Mail-Followup-To: kexec@lists.infradead.org, 1030248@bugs.debian.org
MIME-Version: 1.0
In-Reply-To: <20230201151658.wvalwoz2jmjejcll@babtop.nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230202_151803_083650_9741E69A 
X-CRM114-Status: GOOD (  18.13  )
X-Mailman-Approved-At: Sun, 05 Feb 2023 03:44:17 -0800
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5760071681250635273=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


--===============5760071681250635273==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b2jixbnmiefkvht6"
Content-Disposition: inline


--b2jixbnmiefkvht6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

AFAICT, there's no downside to this, and running into this each time
I want to kexec (and, presumably, a significant chunk of the population,
since lockdown is quite popular) on some machines,
then going to the manual, then finding out I want the /auto/ flag(!)
is quite annoying:
  # kexec -l /boot/vmlinuz-6.1.0-3-amd64 --initrd /boot/initrd.img-6.1.0-3-=
amd64 --reuse-cmdline
  kexec_load failed: Operation not permitted
  entry       =3D 0x46eff7760 flags =3D 0x3e0000
  nr_segments =3D 7
  segment[0].buf   =3D 0x557cd303efa0
  segment[0].bufsz =3D 0x70
  segment[0].mem   =3D 0x100000
  segment[0].memsz =3D 0x1000
  segment[1].buf   =3D 0x557cd3046fe0
  segment[1].bufsz =3D 0x190
  segment[1].mem   =3D 0x101000
  segment[1].memsz =3D 0x1000
  segment[2].buf   =3D 0x557cd303f6e0
  segment[2].bufsz =3D 0x30
  segment[2].mem   =3D 0x102000
  segment[2].memsz =3D 0x1000
  segment[3].buf   =3D 0x7f658fa37010
  segment[3].bufsz =3D 0x12a51b5
  segment[3].mem   =3D 0x46a55a000
  segment[3].memsz =3D 0x12a6000
  segment[4].buf   =3D 0x7f6590ce1210
  segment[4].bufsz =3D 0x7e99e0
  segment[4].mem   =3D 0x46b800000
  segment[4].memsz =3D 0x377c000
  segment[5].buf   =3D 0x557cd3039350
  segment[5].bufsz =3D 0x42fa
  segment[5].mem   =3D 0x46eff2000
  segment[5].memsz =3D 0x5000
  segment[6].buf   =3D 0x557cd3032000
  segment[6].bufsz =3D 0x70e0
  segment[6].mem   =3D 0x46eff7000
  segment[6].memsz =3D 0x9000

Closes: https://bugs.debian.org/1030248
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 kexec/kexec.8 | 4 ++--
 kexec/kexec.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index 3ebede6..66453b8 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -151,14 +151,14 @@ Specify that the new kernel is of this
 Specify that the new KEXEC_FILE_LOAD syscall should be used exclusively.
 .TP
 .BI \-c\ (\-\-kexec-syscall)
-Specify that the old KEXEC_LOAD syscall should be used exclusively (the de=
fault).
+Specify that the old KEXEC_LOAD syscall should be used exclusively.
 .TP
 .BI \-a\ (\-\-kexec-syscall-auto)
 Try the new KEXEC_FILE_LOAD syscall first and when it is not supported or =
the
 kernel does not understand the supplied image fall back to the old KEXEC_L=
OAD
 interface.
=20
-There is no one single interface that always works.
+There is no one single interface that always works, so this is the default.
=20
 KEXEC_FILE_LOAD is required on systems that use locked-down secure boot to
 verify the kernel signature.  KEXEC_LOAD may be also disabled in the kernel
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 0e92d96..36bb2ad 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1049,11 +1049,11 @@ void usage(void)
 	       "                      to original kernel.\n"
 	       " -s, --kexec-file-syscall Use file based syscall for kexec operat=
ion\n"
 	       " -c, --kexec-syscall  Use the kexec_load syscall for for compatib=
ility\n"
-	       "                      with systems that don't support -s (default=
)\n"
+	       "                      with systems that don't support -s\n"
 	       " -a, --kexec-syscall-auto  Use file based syscall for kexec and f=
all\n"
 	       "                      back to the compatibility syscall when file=
 based\n"
 	       "                      syscall is not supported or the kernel did =
not\n"
-	       "                      understand the image\n"
+	       "                      understand the image (default)\n"
 	       " -d, --debug          Enable debugging to help spot a failure.\n"
 	       " -S, --status         Return 1 if the type (by default crash) is =
loaded,\n"
 	       "                      0 if not.\n"
@@ -1407,8 +1407,8 @@ int main(int argc, char *argv[])
 	int do_ifdown =3D 0, skip_ifdown =3D 0;
 	int do_unload =3D 0;
 	int do_reuse_initrd =3D 0;
-	int do_kexec_file_syscall =3D 0;
-	int do_kexec_fallback =3D 0;
+	int do_kexec_file_syscall =3D 1;
+	int do_kexec_fallback =3D 1;
 	int skip_checks =3D 0;
 	int do_status =3D 0;
 	void *entry =3D 0;
--=20
2.30.2

--b2jixbnmiefkvht6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmPcQtkACgkQvP0LAY0m
WPFCsw/6AsVIggwSH3LUQwPHaSIWBeDPZDNpflpnqv0tpawIO4Jsvg8A4vvy15Cv
O96zh5kE38zikkF9DhPje3iHy3TDcIWKhJFj5vbAbZHPOX7tEkfa0DWx2RboUFAn
kvDsKfGTpus6qZGZhWco6Z3Ac9W02nRkIxuqS94id3a2DC6ME8zhqF24kyH430y/
IkdFso+RHt8YLpOguKTSXMbvxVSFhrtKPTmBAgZ/f+Ac6EUXSXfbCN+0YTHmWj9j
HU1uIsH3TEDEsKs/nSA8jln5gPuempWfeOOEIRqVy33zbOvMSlVLh0UErgP1PO11
KPWV489Wx0d+MJpiuXgsJJ2ctjGIshGJ3mwr3bnr/QQw1WB3vqT4SmIcGgD9Z1vW
zzRjci/zHi1KnWww0sFrRM/ngc5Xl84zyzl6zIzRuJcShyzL5S1ES0O+gGYdIn16
ibGpB6GsejhjZJ57RyvlwGK8cjFRRRX6orG/Pi0GSiV1pEjw/mOcdv1EMzfmpE2r
q9z96hdQ0onfWP9J5EMMfUP8pkcV2q+8oSlqoRkGd03jANgFBO9T+QeZejXI6fx8
7N1ROEkGACP7a0r1Lt/m0A4b8lyRBRCSzm2ZfJVAldsNqTg+7YeCf1aYz1DjKQyw
Zszhk8sNA3R1FLfsZTNybSlnMglz3rgTI3JF/0BiKJtlpiApuiw=
=f62s
-----END PGP SIGNATURE-----

--b2jixbnmiefkvht6--


--===============5760071681250635273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============5760071681250635273==--

