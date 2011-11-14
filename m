Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2402:b800:7003:1:1::1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RQ4wm-0008My-5b
 for kexec@lists.infradead.org; Mon, 14 Nov 2011 22:24:13 +0000
Date: Tue, 15 Nov 2011 09:24:06 +1100
From: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/3] kexec-tools: powerpc: Fix 64bit optimize for size
 (gcc -Os) build
Message-ID: <20111115092406.31df5f9e@kryten>
In-Reply-To: <20111114221402.GJ14325@bubble.grove.modra.org>
References: <20111114185329.19ddc2b4@kryten>
 <20111114221402.GJ14325@bubble.grove.modra.org>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Alan Modra <amodra@gmail.com>
Cc: Michael Neuling <mikey@neuling.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Milton Miller <miltonm@bga.com>, Matt Evans <matt@ozlabs.org>


Hi Alan,

> > commit 46b2d0b8a719 (kexec/powerpc fix optimization for size (gcc
> > -Os) build) added out of line GPR save/restore handlers for 32bit
> > -Os builds. This patch adds the handlers for 64bit builds.
> 
> The linker is supposed to add these functions magically on final link
> for powerpc64.  Um, I suppose you're doing something horrible with
> kexec, ld -r instead of normal final link at a guess?

Yeah:

gcc -g -O2 -fno-strict-aliasing -Wall -Wstrict-prototypes
-fno-zero-initialized-in-bss -m64 -Os -fno-builtin -ffreestanding -m64
-Wl,--no-undefined -nostartfiles -nostdlib -nodefaultlibs -e
purgatory_start -r -o purgatory/purgatory.ro purgatory/purgatory.o
purgatory/printf.o purgatory/string.o purgatory/arch/ppc64/v2wrap.o
purgatory/arch/ppc64/hvCall.o purgatory/arch/ppc64/purgatory-ppc64.o
purgatory/arch/ppc64/console-ppc64.o
purgatory/arch/ppc64/crashdump_backup.o purgatory/arch/ppc64/misc.o
purgatory/sha256.o

bin/bin-to-hex purgatory < purgatory/purgatory.ro > kexec/purgatory.c

I wonder why we aren't building and linking an -fpic object, wouldn't
it make the relocation code much simpler?

Anton

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
