Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [139.28.40.42] (helo=tarta.nabijaczleweli.xyz)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQumQ-0000SX-3L
 for kexec@lists.infradead.org; Fri, 09 Oct 2020 15:58:04 +0000
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
 by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 67862361229
 for <kexec@lists.infradead.org>; Fri,  9 Oct 2020 17:40:08 +0200 (CEST)
Date: Fri, 9 Oct 2020 17:40:07 +0200
From: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Subject: [PATCH 5/5] x86_64: allow ELFCLASS32 for x32 support
Message-ID: <4ab72aaf08cb7784fe924cefe6ea9859fba15936.1602257696.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1602257696.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
In-Reply-To: <cover.1602257696.git.nabijaczleweli@nabijaczleweli.xyz>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7179191692412624822=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


--===============7179191692412624822==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zmu7bs2oioau72le"
Content-Disposition: inline


--zmu7bs2oioau72le
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 kexec/arch/x86_64/kexec-elf-rel-x86_64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/x86_64/kexec-elf-rel-x86_64.c b/kexec/arch/x86_64/k=
exec-elf-rel-x86_64.c
index db85b44..0d22f3b 100644
--- a/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
+++ b/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
@@ -8,7 +8,8 @@ int machine_verify_elf_rel(struct mem_ehdr *ehdr)
 	if (ehdr->ei_data !=3D ELFDATA2LSB) {
 		return 0;
 	}
-	if (ehdr->ei_class !=3D ELFCLASS64) {
+	if (ehdr->ei_class !=3D ELFCLASS64 &&
+	    ehdr->ei_class !=3D ELFCLASS32) {  /* x32 */
 		return 0;
 	}
 	if (ehdr->e_machine !=3D EM_X86_64) {
--=20
2.28.0

--zmu7bs2oioau72le
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAl+AhFYACgkQvP0LAY0m
WPGE+RAAs5pNELMBJmsvxEHc8S8C+1XTcBqayeGaIRtEzjrIqN3njFn91UvzwcFu
sL+o+JCxp970pUxWE/8+I2DGfrt0/voN1LeyPNPCBr6lgi9MUl6Uh3RHT7Ul4jv/
0MIi2Jy6XHs4/5GDh0AjF6o3WxZGZYYNsaXQBzx4iI8rk7hMIw1PWEAKaID+XwBh
cGdF/n+6FKBgTSLRfYezUxpNJhcDCBgBoSmgy4dUQP0GgoaeNDX9tBgWoO04lE6l
nNyL85r6yqlJLkZIfgskXQe3vFreOx3fB0JUzzTT7vo3m4y/KWxxE/GiO/4QcONQ
4a3yRI7rEMyA/RAGGFyVaRDVlkJ+qWo+GgF6KdzHXUCSrnmMa8utkXeTY7eufiI2
vSrgoK5BNoYP1A/Do7kEMwaaY5RrZyx7PZlHVQxgqkyypfSNX/0gyUNegLBSAitT
fzpb1gNE1kmwpy2pzYyUYCKs0usvMhd2W+4Urp8mcfmeQVaQqvxkeUo5LoBzfPJx
ypO5otnCEZpwBcwu5tZ0QS55CmobN7jHnxNSscF8KzgQsZemuZVPDkCPLl1oNDsW
jBu6diyULFbWeM9eto5MD91uoWDAd5kOWbuCCZyVEOAy0MfEghQXyaYfWa5gdxoi
usqZp/c7nARshhYFbzUgIXjptxZ1AxpTdLvyEfFuspsj1wJrUjA=
=7Msu
-----END PGP SIGNATURE-----

--zmu7bs2oioau72le--


--===============7179191692412624822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============7179191692412624822==--

