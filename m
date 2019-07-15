Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hmvLd-0000nq-CQ
 for kexec@lists.infradead.org; Mon, 15 Jul 2019 07:24:35 +0000
Date: Mon, 15 Jul 2019 09:24:17 +0200
From: Sven Schnelle <svens@stackframe.org>
Subject: Re: [PATCH v3 5/7] kexec_elf: remove elf_addr_to_cpu macro
Message-ID: <20190715072417.GA25659@t470p.stackframe.org>
References: <20190710142944.2774-1-svens@stackframe.org>
 <20190710142944.2774-6-svens@stackframe.org>
 <49206784-009c-391b-5f9a-11e9b1de930b@c-s.fr>
 <20190710180518.GA6343@t470p.stackframe.org>
 <871rywhlq4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <871rywhlq4.fsf@concordia.ellerman.id.au>
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
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, kexec@lists.infradead.org, deller@gmx.de, linuxppc-dev@lists.ozlabs.org

Hi Michael,

On Thu, Jul 11, 2019 at 09:08:51PM +1000, Michael Ellerman wrote:
> Sven Schnelle <svens@stackframe.org> writes:
> > On Wed, Jul 10, 2019 at 05:09:29PM +0200, Christophe Leroy wrote:
> >> Le 10/07/2019 =E0 16:29, Sven Schnelle a =E9crit=A0:
> >> > It had only one definition, so just use the function directly.
> >> =

> >> It had only one definition because it was for ppc64 only.
> >> But as far as I understand (at least from the name of the new file), y=
ou
> >> want it to be generic, don't you ? Therefore I get on 32 bits it would=
 be
> >> elf32_to_cpu().
> >
> > That brings up the question whether we need those endianess conversions=
. I would
> > assume that the ELF file has always the same endianess as the running k=
ernel. So
> > i think we could just drop them. What do you think?
> =

> We should be able to kexec from big to little endian or vice versa, so
> they are necessary.

I'll update the patch to check for a needed 32/64 bit conversion during run=
time,
so we can also kexec from 32 to 64 bit kernels and vice versa. Don't know
whether that's possible on powerpc, but at least on parisc it is.

Regards
Sven

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
