Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DF5C7EE23
	for <kexec@archiver.kernel.org>; Wed, 10 May 2023 11:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:CC:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IqByGOwN1zDsv4l0mI2Vh4FHwwlNkOtKQERHn5XyoD8=; b=wWYJ79hbsWXxAENA3VOQ9iYZgc
	fe2lrCyWCxgV96znU/yKmzl/VASQpDJbWwlgKLQsjNWCYRsHgRB1fTM6WEkWb2EtB8FMn0fPaxuyd
	D3HDh8h9ptb1Q5WhBXArHxw2VFlP7ERp5C1XG/mo5n3EjWUuY+OWev1o6AGUJ5ptRHYlIdjVWJMoT
	Uexhn56hBxTJEViEbua8IKSnu3O3NF5VvVvvmAkF3Wk5IoZSAErPbhX4ArEoHB34CBbbxuKViPLBM
	JyKPECDwKP5rYd5lvyX7ReEFXf5EnHi+861JrvJlC/j2Fm2/YTFPUUOu+RdzIWVlJDwkxxC4+OoEn
	FydMs21Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwiGo-0064Ir-2E;
	Wed, 10 May 2023 11:46:10 +0000
Received: from esa.microchip.iphmx.com ([68.232.154.123])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puuaO-00AssL-1t;
	Fri, 05 May 2023 12:30:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683289856; x=1714825856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XweA9V5HDK7utS7/TPunyp7LYfGFUrdjDqzcDo9MXNU=;
  b=MP/R+WuP54UX7SNtMHXuOXJ0JrHd/ilhLA4X2VJ4EpBhHAF2ebCyjaJE
   +RpQNUa1BFZnR/NX3NI/8HY5mE7HVX42bct2czjF3oMoiEwtPXasu2EOP
   z4eDWjEjQe++3oKG6UgGFI/VJNTiUeG1GzonHMCM1aw0JwR6+GlxxuC04
   ckubSU9/Rq+578m4ZnnEU1ajz9T2VFYWv3lSqM9u6GVGHXhlPp6CFSC3M
   ebuc00b0VcVxcscO7fIXlo8kYOhI46kltNACapzK8E+B52HZIRLD2SnRt
   wr0POqPSGr/nSJKnFb5dbXCFq2RSNU6o2QCdLzKy+JL2n0+kifwCQ5/k3
   A==;
X-IronPort-AV: E=Sophos;i="5.99,252,1677567600"; 
   d="asc'?scan'208";a="150539472"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 May 2023 05:30:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 5 May 2023 05:30:38 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 5 May 2023 05:30:34 -0700
Date: Fri, 5 May 2023 13:30:15 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Ricardo Ribalda <ribalda@chromium.org>
CC: Conor Dooley <conor@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
	Philipp Rudo <prudo@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>, Tom
 Rix <trix@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Baoquan He <bhe@redhat.com>, Philipp Rudo
	<prudo@redhat.com>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ross Zwisler <zwisler@google.com>, Steven
 Rostedt <rostedt@goodmis.org>, Simon Horman <horms@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, <llvm@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v6 4/4] risc/purgatory: Add linker script
Message-ID: <20230505-subsidy-shininess-46a8be31b267@wendy>
References: <20230321-kexec_clang16-v6-0-a2255e81ab45@chromium.org>
 <20230321-kexec_clang16-v6-4-a2255e81ab45@chromium.org>
 <20230501-cottage-overjoyed-1aeb9d72d309@spud>
 <CANiDSCufbm80g4AqukpiuER17OXhD-yRNmTZRz7s_x-Xi9BDCw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CANiDSCufbm80g4AqukpiuER17OXhD-yRNmTZRz7s_x-Xi9BDCw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_053056_696748_16035800 
X-CRM114-Status: GOOD (  28.15  )
X-Mailman-Approved-At: Wed, 10 May 2023 04:46:08 -0700
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
Content-Type: multipart/mixed; boundary="===============4170678932965458393=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

--===============4170678932965458393==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HCjo7mmLcFsfwCMI"
Content-Disposition: inline

--HCjo7mmLcFsfwCMI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 01, 2023 at 09:54:43PM +0200, Ricardo Ribalda wrote:
> On Mon, 1 May 2023 at 19:41, Conor Dooley <conor@kernel.org> wrote:
> > On Mon, May 01, 2023 at 02:38:22PM +0200, Ricardo Ribalda wrote:
> > > If PGO is enabled, the purgatory ends up with multiple .text sections.
> > > This is not supported by kexec and crashes the system.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 930457057abe ("kernel/kexec_file.c: split up __kexec_load_pura=
gory")
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  arch/riscv/purgatory/Makefile | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Mak=
efile
> > > index 5730797a6b40..cf3a44121a90 100644
> > > --- a/arch/riscv/purgatory/Makefile
> > > +++ b/arch/riscv/purgatory/Makefile
> > > @@ -35,6 +35,11 @@ CFLAGS_sha256.o :=3D -D__DISABLE_EXPORTS
> > >  CFLAGS_string.o :=3D -D__DISABLE_EXPORTS
> > >  CFLAGS_ctype.o :=3D -D__DISABLE_EXPORTS
> > >
> > > +# When profile optimization is enabled, llvm emits two different ove=
rlapping
> > > +# text sections, which is not supported by kexec. Remove profile opt=
imization
> > > +# flags.
> > > +KBUILD_CFLAGS :=3D $(filter-out -fprofile-sample-use=3D% -fprofile-u=
se=3D%,$(KBUILD_CFLAGS))
> >
> > With the caveat of not being au fait with the workings of either PGO or
> > of purgatory, how come you modify KBUILD_CFLAGS here rather than the
> > purgatory specific PURGATORY_CFLAGS that are used later in the file?
>=20
> Definitely, not a Makefile expert here, but when I tried this:
>=20
> @@ -35,6 +40,7 @@ PURGATORY_CFLAGS_REMOVE :=3D -mcmodel=3Dkernel
>  PURGATORY_CFLAGS :=3D -mcmodel=3Dlarge -ffreestanding
> -fno-zero-initialized-in-bss -g0
>  PURGATORY_CFLAGS +=3D $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFI=
LING
>  PURGATORY_CFLAGS +=3D -fno-stack-protector
> +PURGATORY_CFLAGS :=3D $(filter-out -fprofile-sample-use=3D%
> -fprofile-use=3D%,$(KBUILD_CFLAGS))
>=20
> It did not work.

Unfortunately I am oh-so-far from an expert on this kind of thing, but I
had thought that PURGATORY_CFLAGS_REMOVE was intended for this sort of
purpose.

> Fixes: bde971a83bbf ("KVM: arm64: nvhe: Fix build with profile optimizati=
on")
>=20
> does this approach, so this is what I tried and worked.

That doesn't have a specific CFLAGS though afaict.
Perhaps Nick etc have a more informed opinion here than I do, sorry.

Thanks,
Conor.

> > > +
> > >  # When linking purgatory.ro with -r unresolved symbols are not check=
ed,
> > >  # also link a purgatory.chk binary without -r to check for unresolve=
d symbols.
> > >  PURGATORY_LDFLAGS :=3D -e purgatory_start -z nodefaultlib
> > >
> > > --
> > > 2.40.1.495.gc816e09b53d-goog
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
>=20
>=20
>=20
> --=20
> Ricardo Ribalda

--HCjo7mmLcFsfwCMI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFT21wAKCRB4tDGHoIJi
0vY1AP9RxvKzAScY63Nnz9Vp/3U8917fwYnV71pbtJgtzZt3WAEA8S2SNODAX7Qy
Vn7vxaBudJDiNoZ4dz80u4gzoYd3SwE=
=X4se
-----END PGP SIGNATURE-----

--HCjo7mmLcFsfwCMI--


--===============4170678932965458393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============4170678932965458393==--

