Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c2UAc-00056r-SZ
 for kexec@lists.infradead.org; Fri, 04 Nov 2016 02:23:56 +0000
Received: by mail-pf0-x234.google.com with SMTP id d2so42049321pfd.0
 for <kexec@lists.infradead.org>; Thu, 03 Nov 2016 19:23:33 -0700 (PDT)
Date: Fri, 4 Nov 2016 11:31:46 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v4 0/9] (kexec-tools) arm64: add kdump support
Message-ID: <20161104023145.GB381@linaro.org>
References: <20161102044111.11779-1-takahiro.akashi@linaro.org>
 <CAMNZz5CbOo6jE5q=7VhKR5y=BfQim4vdjtZwjk--D=QZCgGEpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMNZz5CbOo6jE5q=7VhKR5y=BfQim4vdjtZwjk--D=QZCgGEpQ@mail.gmail.com>
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
To: Sandeepa Prabhu <sandeepa.prabhu@broadcom.com>
Cc: geoff@infradead.org, Pratyush Anand <panand@redhat.com>, horms@verge.net.au, kexec@lists.infradead.org

Hello, Sandeepa!

I pushed the patches into:
https://git.linaro.org/people/takahiro.akashi/linux-aarch64.git arm64/kdump
https://git.linaro.org/people/takahiro.akashi/kexec-tools.git arm64/kdump

# Those repos are not well maintained, but I will try to keep them
  updated.

Thanks,
-Takahiro AKASHI

On Wed, Nov 02, 2016 at 06:51:51PM +0530, Sandeepa Prabhu wrote:
> Akashi/Pratyush,
> 
> Is there a public git repo I can pull to test this patchset?
> 
> ~Sandeepa
> 
> On Wed, Nov 2, 2016 at 10:11 AM, AKASHI Takahiro <takahiro.akashi@linaro.org
> > wrote:
> 
> > My kernel patches of kdump suport on arm64 are currently under reviews.
> >
> > This patchset is synced with them (v27 [1]) and provides necessary changes
> > for kexec-tools. It can be applied on top of kexec-tools master branch.
> >
> > [1] T.B.D.
> >
> > Changes for v4:
> >  - rebased on the master branch (including Geoff's v6)
> >  - revive "linux,usable-memory-range" DT property (from v2), dropping
> >    use of "reserved-memory" nodes introduced in v3 (patch #8)
> >  - extend the semantics of kexec_iomem_for_each_line() per Pratyush
> >    (patch #1)
> >
> > Changes for v3:
> >  - rebased on Geoff's v5
> >  - fix a value of estimated PHYS_OFFSET
> >  - add a kernel code/data segment because they now reside out of linear
> >    mapping due to KASLR introduction
> >  - remove "linux,usable-memory-range" dependency, instead using
> >    "reserved-memory" node
> >  - add -mem-min/-mem-max support
> >
> > Changes for v2:
> >  - trim a temoprary buffer in setup_2nd_dtb()
> >  - add patch#6("kexec: generalize and rename get_kernel_stext_sym()")
> >  - update patch#7 from Pratyush
> >    (re-worked by akashi)
> >
> > AKASHI Takahiro (7):
> >   kexec: exntend the semantics of kexec_iomem_for_each_line
> >   arm64: identify PHYS_OFFSET correctly
> >   arm64: kdump: identify memory regions
> >   arm64: kdump: add elf core header segment
> >   arm64: kdump: set up kernel image segment
> >   arm64: kdump: set up other segments
> >   arm64: kdump: add DT properties to crash dump kernel's dtb
> >
> > Pratyush Anand (2):
> >   kexec: generalize and rename get_kernel_stext_sym()
> >   arm64: kdump: Add support for binary image files
> >
> >  kexec/Makefile                       |   1 +
> >  kexec/arch/arm/crashdump-arm.c       |  40 +------
> >  kexec/arch/arm64/Makefile            |   2 +
> >  kexec/arch/arm64/crashdump-arm64.c   | 219 ++++++++++++++++++++++++++++++
> > ++++-
> >  kexec/arch/arm64/crashdump-arm64.h   |  18 ++-
> >  kexec/arch/arm64/iomem.h             |  10 ++
> >  kexec/arch/arm64/kexec-arm64.c       | 118 ++++++++++++++++---
> >  kexec/arch/arm64/kexec-elf-arm64.c   |  25 +++-
> >  kexec/arch/arm64/kexec-image-arm64.c |  12 ++
> >  kexec/arch/i386/crashdump-x86.c      |  29 -----
> >  kexec/kexec-iomem.c                  |  15 ++-
> >  kexec/kexec.h                        |   2 +
> >  kexec/symbols.c                      |  41 +++++++
> >  13 files changed, 437 insertions(+), 95 deletions(-)
> >  create mode 100644 kexec/arch/arm64/iomem.h
> >  create mode 100644 kexec/symbols.c
> >
> > --
> > 2.10.0
> >
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> >

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
