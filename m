Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hlDWq-0004zN-Ci
 for kexec@lists.infradead.org; Wed, 10 Jul 2019 14:25:06 +0000
Date: Wed, 10 Jul 2019 16:24:59 +0200
From: Sven Schnelle <svens@stackframe.org>
Subject: Re: [PATCH v2 1/7] kexec: add KEXEC_ELF
Message-ID: <20190710142459.GA31679@t470p.stackframe.org>
References: <20190709194328.16991-1-svens@stackframe.org>
 <20190709194328.16991-2-svens@stackframe.org>
 <64306f6c-0a0d-a6ea-537c-5e72deaba1c0@c-s.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <64306f6c-0a0d-a6ea-537c-5e72deaba1c0@c-s.fr>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org, deller@gmx.de, kexec@lists.infradead.org

Hi Christophe,

On Wed, Jul 10, 2019 at 01:19:13PM +0000, Christophe Leroy wrote:
> Hi Sven,
> 
> On 07/09/2019 07:43 PM, Sven Schnelle wrote:
> > Right now powerpc provides an implementation to read elf files
> > with the kexec_file() syscall. Make that available as a public
> > kexec interface so it can be re-used on other architectures.
> > 
> > Signed-off-by: Sven Schnelle <svens@stackframe.org>
> > ---
> >   arch/Kconfig                       |   3 +
> >   arch/powerpc/Kconfig               |   1 +
> >   arch/powerpc/kernel/kexec_elf_64.c | 551 +----------------------------
> >   include/linux/kexec.h              |  24 ++
> >   kernel/Makefile                    |   1 +
> >   kernel/kexec_elf.c                 | 537 ++++++++++++++++++++++++++++
> >   6 files changed, 576 insertions(+), 541 deletions(-)
> >   create mode 100644 kernel/kexec_elf.c
> 
> Why are you persisting at not using -C when creating your patch ? Do you
> want to hide the changes you did while copying
> arch/powerpc/kernel/kexec_elf_64.c to kernel/kexec_elf.c ?
> Or you want to make life harder for the reviewers ?

Sorry, never used -C before. I used:

git send-email --annotate -v2 -7 --to kexec@lists.infradead.org --cc deller@gmx.de,linuxppc-dev@lists.ozlabs.org -v --format-patch -C -M

However, it looks like it only works when started this way:

git send-email --format-patch -M -C --annotate -v2 -7 --to kexec@lists.infradead.org --cc deller@gmx.de,linuxppc-dev@lists.ozlabs.org -v

I'll resend v2.

Best Regards,
Sven

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
