Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-f194.google.com ([209.85.166.194])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1haFO6-0003Eq-BN
 for kexec@lists.infradead.org; Mon, 10 Jun 2019 08:10:43 +0000
Received: by mail-it1-f194.google.com with SMTP id n189so11827206itd.0
 for <kexec@lists.infradead.org>; Mon, 10 Jun 2019 01:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190524062321.24126-1-kasong@redhat.com>
 <20190531092743.qgwku2ob4trduadr@verge.net.au>
In-Reply-To: <20190531092743.qgwku2ob4trduadr@verge.net.au>
From: Kairui Song <kasong@redhat.com>
Date: Mon, 10 Jun 2019 16:10:30 +0800
Message-ID: <CACPcB9dOSwe1s2Z5W3ccwXSR_h_Y33cqnt2d=TPZ4hX+fpqdrA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] x86: Always try to fill acpi_rsdp_addr in boot
 params
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

On Fri, May 31, 2019 at 5:27 PM Simon Horman <horms@verge.net.au> wrote:
>
> On Fri, May 24, 2019 at 02:23:17PM +0800, Kairui Song wrote:
> > This patch sync the behavior of user space kexec and kexec_file_load,
> > they will both fill the boot_params.acpi_rsdp_addr with a valid RSDP
> > value, to make sure second kernel can always get the RSDP consistently.
> >
> > This will make it effortless to boot newer version of kernel (5.0+)
> > without specifying acpi_rsdp= cmdline on EFI system even with EFI
> > service disabled. Should not change any behavior with older kernels.
> >
> > Update from V2:
> >   - Drop unneeded 'packed' attribute for boot parameters structure
> >   - Don't trust kernel cmdline as a reliable acpi rsdp source
> >
> > Update from V1:
> >   - Split into multiple patches for a cleaner structure, content is not
> >     changed.
>
> Thanks Kairui,
>
> applied.

Hi Simon,

I still haven't see this series get merged yet in the git repo, any update?

--
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
