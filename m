Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hTlYI-0007Th-AX
 for kexec@lists.infradead.org; Thu, 23 May 2019 11:06:28 +0000
Received: by mail-qt1-f195.google.com with SMTP id f24so6125751qtk.11
 for <kexec@lists.infradead.org>; Thu, 23 May 2019 04:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190514050959.21093-1-kasong@redhat.com>
 <20190514050959.21093-3-kasong@redhat.com>
 <20190523031609.GB8174@dhcp-128-65.nay.redhat.com>
 <CACPcB9eKOGNLxBLVfX8uqWS1uxjxMFtNR8h=MqaueZ+Ymr5QJg@mail.gmail.com>
In-Reply-To: <CACPcB9eKOGNLxBLVfX8uqWS1uxjxMFtNR8h=MqaueZ+Ymr5QJg@mail.gmail.com>
From: Kairui Song <kasong@redhat.com>
Date: Thu, 23 May 2019 19:06:13 +0800
Message-ID: <CACPcB9f3RJsJsYTbjFvT_QU+6rr_xE0f=tezZ-Yf0h45ymJxEA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] x86: Introduce helpers for getting RSDP address
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
To: Dave Young <dyoung@redhat.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Lianbo Jiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>

On Thu, May 23, 2019 at 11:43 AM Kairui Song <kasong@redhat.com> wrote:
>
> On Thu, May 23, 2019 at 11:16 AM Dave Young <dyoung@redhat.com> wrote:
> >
> > On 05/14/19 at 01:09pm, Kairui Song wrote:
> > > On x86 RSDP is fundamental for booting the machine. When second kernel
> > > is incapable of parsing the RSDP address (eg. kexec next kernel on an EFI
> > > system with EFI service disabled), kexec should prepare the RSDP address
> > > for second kernel.
> > >
> > > Introduce helpers for getting RSDP from multiple sources, including boot
> > > params, cmdline and EFI firmware.
> > >
> > > For legacy BIOS interface, there is no better way to find the RSDP address
> > > rather than scanning the memory region and search for it, and this will
> > > always be done by the kernel as a fallback, so this is no need to try to
> > > get the RSDP address for that case.
> > >
> > > Signed-off-by: Kairui Song <kasong@redhat.com>
> > > ---
> > >  kexec/arch/i386/kexec-x86-common.c | 60 ++++++++++++++++++++++++++++++
> > >  kexec/arch/i386/kexec-x86.h        |  1 +
> > >  kexec/arch/i386/x86-linux-setup.c  |  3 +-
> > >  kexec/arch/i386/x86-linux-setup.h  |  1 +
> > >  4 files changed, 63 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
> > > index de99758..4b8eb26 100644
> > > --- a/kexec/arch/i386/kexec-x86-common.c
> > > +++ b/kexec/arch/i386/kexec-x86-common.c
> > > @@ -39,6 +39,7 @@
> > >  #include "../../firmware_memmap.h"
> > >  #include "../../crashdump.h"
> > >  #include "kexec-x86.h"
> > > +#include "x86-linux-setup.h"
> > >  #include "../../kexec-xen.h"
> > >
> > >  /* Used below but not present in (older?) xenctrl.h */
> > > @@ -392,4 +393,63 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
> > >       return ret;
> > >  }
> > >
> > > +static uint64_t cmdline_get_acpi_rsdp(void) {
> > > +     uint64_t acpi_rsdp = 0;
> > > +     char *tmp_cmdline, *rsdp_param;
> > >
> > > +     tmp_cmdline = get_command_line();
> > > +     rsdp_param = strstr(tmp_cmdline, "acpi_rsdp=");
> >
> > strstr will locate the first acpi_rsdp, what about multiple acpi_rsdp
> > provided?
>
> Good catch, should always use the latest acpi_rsdp provided, will fix that.
>
> >
> > BTW, if one provide a wrong adress in acpi_rsdp= cmdline then it is not
> > usable.
> >
>
> I think in that case kernel will not boot. If kexec is available then
> it means a right value is given.
>

After double check the kernel will boot even wrong acpi_rsdp is given,
so I'll drop this part. boot_params in newer kernel will be enough to
make sure kexec loop boot with EFI disabled won't fail.

-- 
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
