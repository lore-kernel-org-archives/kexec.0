Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-f66.google.com ([209.85.166.66])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hl8UN-0007OW-Un
 for kexec@lists.infradead.org; Wed, 10 Jul 2019 09:02:13 +0000
Received: by mail-io1-f66.google.com with SMTP id z3so3165116iog.0
 for <kexec@lists.infradead.org>; Wed, 10 Jul 2019 02:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190703080432.28806-1-horms@verge.net.au>
 <20190710081053.qtiqskblmxcpkr6e@verge.net.au>
In-Reply-To: <20190710081053.qtiqskblmxcpkr6e@verge.net.au>
From: Kairui Song <kasong@redhat.com>
Date: Wed, 10 Jul 2019 16:55:57 +0800
Message-ID: <CACPcB9eVc1CDeNQyAr6Daq=vM3jVqyeUDmT+2p524jvH=08rAw@mail.gmail.com>
Subject: Re: [PATCH kexec-tools] x86: re-order includes to avoid duplicate
 struct e820entry
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
To: Simon Horman <horms@verge.net.au>
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Lianbo Jiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>

On Wed, Jul 10, 2019 at 4:11 PM Simon Horman <horms@verge.net.au> wrote:
>
> On Wed, Jul 03, 2019 at 10:04:32AM +0200, Simon Horman wrote:
> > xenctrl.h defines struct e820entry as:
> >
> >       if defined(__i386__) || defined(__x86_64__)
> >       ...
> >       #define E820_RAM        1
> >       ...
> >       struct e820entry {
> >               uint64_t addr;
> >               uint64_t size;
> >               uint32_t type;
> >       } __attribute__((packed));
> >       ...
> >       #endif
> >
> >  $ dpkg-query -S /usr/include/xenctrl.h
> >  libxen-dev:amd64: /usr/include/xenctrl.h
> >  $  dpkg-query -W libxen-dev:amd64
> >  libxen-dev:amd64     4.8.5+shim4.10.2+xsa282-1+deb9u11
> >
> > ./include/x86/x86-linux.h defines struct e820entry as:
> >
> >       #ifndef E820_RAM
> >       struct e820entry {
> >               uint64_t addr;  /* start of memory segment */
> >               uint64_t size;  /* size of memory segment */
> >               uint32_t type;  /* type of memory segment */
> >               #define E820_RAM    1
> >               ...
> >       } __attribute__((packed));
> >       #endif
> >
> > Since cedeee0a3007 ("x86: Introduce helpers for getting RSDP address")
> > ./kexec/arch/i386/kexec-x86-common.c includes
> >
> >       +#include "x86-linux-setup.h"
> >        #include "../../kexec-xen.h"
> >
> > When xenctrl.h is present the above results in:
> >
> >  $ gcc
> >  ...
> >  In file included from kexec/arch/i386/../../kexec-xen.h:5:0,
> >                   from kexec/arch/i386/kexec-x86-common.c:43:
> >  /usr/include/xenctrl.h:1271:8: error: redefinition of 'struct e820entry'
> >   struct e820entry {
> >          ^~~~~~~~~
> >
> >  In file included from kexec/arch/i386/x86-linux-setup.h:3:0,
> >                   from kexec/arch/i386/kexec-x86-common.c:42:
> >  ./include/x86/x86-linux.h:16:8: note: originally defined here
> >   struct e820entry {
> >          ^~~~~~~~~
> >  ...
> >  $ gcc --version | head -1
> >  gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
> >
> > To militate this this problem re-order the includes so that
> > x86-linux.h is included after xenctrl.h and thus
> > struct e820entry will only be defined once due to it
> > being devined conditionally in x86-linux.h.
> >
> > In practice the definitions are the same so it should
> > not matter which is chosen.
> >
> > It also seems rather unpleasent to me to need to play
> > with include ordering. Perhaps a better solution in the longer
> > term would be to rename the local definition of struct e820entry.
> >
> > Fixes: cedeee0a3007 ("x86: Introduce helpers for getting RSDP address")
> > Signed-off-by: Simon Horman <horms@verge.net.au>
>
> I have applied this change.
>

Thanks for the fix, it looks good, so the "move the helpers to
x86-linux-setup.c" patch should be not needed now.

-- 
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
