Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1FBC7EE29
	for <kexec@archiver.kernel.org>; Wed,  3 May 2023 17:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zO4LCHGhNw7IUJMTjv+v5PhojylyWtDqeNg+XiUcTkY=; b=HFzB7sM7SBVvTPQWNI5XUqo4U9
	3W0/pDy77bpOiBmrv5PvABCHkuvrP7JJ7o+xZMnEOGZhOFyW2yN5sO+S2m3BuMDMPdaMdPwuqKx6S
	SRPss+94k1fZ8XfRlL08835DoDXfBBZiXqTtErFTHMayuhA00497mBR7Xk1PkMvEWxj4ZCwFbBBEL
	EU/IcbNQvr5Ell1temC8qDV1x72qSpRYwl9F4xTzxa2iudLdBd8/G2CRcBWvCv6FfId7T8PHmhy2j
	iTqfAfcHY6kQtdT81JUTl3iijq8kpsgVOfu5okLdOeEgjW5asYTneplsd18NvAuorZ6OSLmLq+QnJ
	KS17Mlnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puGRb-005ISH-35;
	Wed, 03 May 2023 17:39:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptXWN-00GQFS-0w;
	Mon, 01 May 2023 17:41:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id F01F561E6C;
	Mon,  1 May 2023 17:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E2EC433D2;
	Mon,  1 May 2023 17:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682962864;
	bh=81z/8+VNCOs2KfOTGMvYGJr78DCfPa8M7ZOzDNUfnCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ghv0PKPSEF/qiYfWNIgVqzcxiV94CKnm+WiWCSyBxEUEJUm8nsJSuKOqtmJA871/J
	 ajyg3xFZJvtCjWeS5XL4b4A6p8W8Eh4h5g7M6hUgv55S5cuvquU2/FPaVa5zMKrCwl
	 p80tb777MSmmUOy4bAcn4YGjMwqaK97HS/0AXg1GmQZpUeeLgggQKhUGaoUJaJStfa
	 60Dn1OZ5gbzQA/kDtxoEWTYgtega7R78ZTGPMTGp8mczgGW/rre5vijVDFKcWvkkOr
	 osLrwqrSAODauKYj4W7bSX2Zm4Wj/8RL9xM/EboyvOZepXnzmaugABHmtdX2GOg6Wj
	 4b93L3bPQNt+Q==
Date: Mon, 1 May 2023 18:40:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Philipp Rudo <prudo@linux.vnet.ibm.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Baoquan He <bhe@redhat.com>,
	Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Simon Horman <horms@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>, llvm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 4/4] risc/purgatory: Add linker script
Message-ID: <20230501-cottage-overjoyed-1aeb9d72d309@spud>
References: <20230321-kexec_clang16-v6-0-a2255e81ab45@chromium.org>
 <20230321-kexec_clang16-v6-4-a2255e81ab45@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20230321-kexec_clang16-v6-4-a2255e81ab45@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_104107_421076_FD5E47B1 
X-CRM114-Status: GOOD (  21.34  )
X-Mailman-Approved-At: Wed, 03 May 2023 10:39:08 -0700
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
Content-Type: multipart/mixed; boundary="===============8130223688528627959=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


--===============8130223688528627959==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fl35W8zTCu+OA5lB"
Content-Disposition: inline


--fl35W8zTCu+OA5lB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Ricardo,

On Mon, May 01, 2023 at 02:38:22PM +0200, Ricardo Ribalda wrote:
> If PGO is enabled, the purgatory ends up with multiple .text sections.
> This is not supported by kexec and crashes the system.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 930457057abe ("kernel/kexec_file.c: split up __kexec_load_puragory=
")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  arch/riscv/purgatory/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
> index 5730797a6b40..cf3a44121a90 100644
> --- a/arch/riscv/purgatory/Makefile
> +++ b/arch/riscv/purgatory/Makefile
> @@ -35,6 +35,11 @@ CFLAGS_sha256.o :=3D -D__DISABLE_EXPORTS
>  CFLAGS_string.o :=3D -D__DISABLE_EXPORTS
>  CFLAGS_ctype.o :=3D -D__DISABLE_EXPORTS
> =20
> +# When profile optimization is enabled, llvm emits two different overlap=
ping
> +# text sections, which is not supported by kexec. Remove profile optimiz=
ation
> +# flags.
> +KBUILD_CFLAGS :=3D $(filter-out -fprofile-sample-use=3D% -fprofile-use=
=3D%,$(KBUILD_CFLAGS))

With the caveat of not being au fait with the workings of either PGO or
of purgatory, how come you modify KBUILD_CFLAGS here rather than the
purgatory specific PURGATORY_CFLAGS that are used later in the file?

Cheers,
Conor.

> +
>  # When linking purgatory.ro with -r unresolved symbols are not checked,
>  # also link a purgatory.chk binary without -r to check for unresolved sy=
mbols.
>  PURGATORY_LDFLAGS :=3D -e purgatory_start -z nodefaultlib
>=20
> --=20
> 2.40.1.495.gc816e09b53d-goog
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--fl35W8zTCu+OA5lB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZE/5qAAKCRB4tDGHoIJi
0tO7AQDCFxxBDCm6m1lRjliaYENcoYHVqFHrLwGzbHGrXVn/VQD/aKUuG6nnmBC9
4JdlDj98flb/kiL3Z25m/1+UmBAjSAk=
=uz5+
-----END PGP SIGNATURE-----

--fl35W8zTCu+OA5lB--


--===============8130223688528627959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============8130223688528627959==--

