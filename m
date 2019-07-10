Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hlGy2-0005cr-Uk
 for kexec@lists.infradead.org; Wed, 10 Jul 2019 18:05:24 +0000
Date: Wed, 10 Jul 2019 20:05:18 +0200
From: Sven Schnelle <svens@stackframe.org>
Subject: Re: [PATCH v3 5/7] kexec_elf: remove elf_addr_to_cpu macro
Message-ID: <20190710180518.GA6343@t470p.stackframe.org>
References: <20190710142944.2774-1-svens@stackframe.org>
 <20190710142944.2774-6-svens@stackframe.org>
 <49206784-009c-391b-5f9a-11e9b1de930b@c-s.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <49206784-009c-391b-5f9a-11e9b1de930b@c-s.fr>
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
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org, deller@gmx.de, kexec@lists.infradead.org

Hi Christophe,

On Wed, Jul 10, 2019 at 05:09:29PM +0200, Christophe Leroy wrote:
> =

> =

> Le 10/07/2019 =E0 16:29, Sven Schnelle a =E9crit=A0:
> > It had only one definition, so just use the function directly.
> =

> It had only one definition because it was for ppc64 only.
> But as far as I understand (at least from the name of the new file), you
> want it to be generic, don't you ? Therefore I get on 32 bits it would be
> elf32_to_cpu().

That brings up the question whether we need those endianess conversions. I =
would
assume that the ELF file has always the same endianess as the running kerne=
l. So
i think we could just drop them. What do you think?

Regards
Sven

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
