Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d93x6-00070q-Bz
 for kexec@lists.infradead.org; Fri, 12 May 2017 06:21:27 +0000
Received: by mail-pg0-x22e.google.com with SMTP id u187so25564976pgb.0
 for <kexec@lists.infradead.org>; Thu, 11 May 2017 23:21:03 -0700 (PDT)
Date: Fri, 12 May 2017 15:25:09 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v6 0/9] (kexec-tools) arm64: add kdump support
Message-ID: <20170512062508.GA28830@linaro.org>
References: <20170315093824.24566-1-takahiro.akashi@linaro.org>
 <147ae0e7-ebe9-e762-2c36-d4b88d4dc395@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <147ae0e7-ebe9-e762-2c36-d4b88d4dc395@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: geoff@infradead.org, horms@verge.net.au, kexec@lists.infradead.org

On Fri, May 12, 2017 at 08:21:07AM +0530, Pratyush Anand wrote:
> On Wednesday 15 March 2017 03:08 PM, AKASHI Takahiro wrote:
> >My kernel patches of kdump support on arm64 are currently under review.
> >
> >This patchset is synced with them (v33 [1]) and provides necessary changes
> >for kexec-tools. It can be applied on top of kexec-tools master branch.
> >
> >[1] T.B.D.
> >
> >Changes for v6:
> > - use get_kernel_sym() from x86, not from arm (patch #2)
> > - always take root node's "#address-cells" and "#size-cells" into account
> >   when adding "linux,usable-memory-range" and "linux,elfcorehdr"
> >   (patch #8)
> 
> 
> I think these patches can be merged now, as kernel patches are there in upstream.

Yeah, but I might want to make _cosmetic_ changes/clean-up stuff
as I'm now working on kexec_file_load() support and want to minimize
the gap between the kernel code and kexec-tools.

I'll let all of you know once I've done. Hopefully early next week.
So if anybody have comments, those will be very much appreciated.

Thanks,
-Takahiro AKASHI

> 
> For the series:
> 
> Tested-by: Pratyush Anand <panand@redhat.com>
> Reviewed-by: Pratyush Anand <panand@redhat.com>
> 
> >
> >Changes for v5:
> > - remove "linux,crashkernel-base/size" handling aligned with a change
> >   on the kernel side
> >
> >Changes for v4:
> > - rebased on the master branch (including Geoff's v6)
> > - revive "linux,usable-memory-range" DT property (from v2), dropping
> >   use of "reserved-memory" nodes introduced in v3 (patch #8)
> > - extend the semantics of kexec_iomem_for_each_line() per Pratyush
> >   (patch #1)
> >
> >Changes for v3:
> > - rebased on Geoff's v5
> > - fix a value of estimated PHYS_OFFSET
> > - add a kernel code/data segment because they now reside out of linear
> >   mapping due to KASLR introduction
> > - remove "linux,usable-memory-range" dependency, instead using
> >   "reserved-memory" node
> > - add -mem-min/-mem-max support
> >
> >Changes for v2:
> > - trim a temoprary buffer in setup_2nd_dtb()
> > - add patch#6("kexec: generalize and rename get_kernel_stext_sym()")
> > - update patch#7 from Pratyush
> >   (re-worked by akashi)
> >
> >AKASHI Takahiro (7):
> >  kexec: exntend the semantics of kexec_iomem_for_each_line
> >  arm64: identify PHYS_OFFSET correctly
> >  arm64: kdump: identify memory regions
> >  arm64: kdump: add elf core header segment
> >  arm64: kdump: set up kernel image segment
> >  arm64: kdump: set up other segments
> >  arm64: kdump: add DT properties to crash dump kernel's dtb
> >
> >Pratyush Anand (2):
> >  kexec: generalize and rename get_kernel_stext_sym()
> >  arm64: kdump: Add support for binary image files
> >
> > kexec/Makefile                       |   1 +
> > kexec/arch/arm/crashdump-arm.c       |  40 +-----
> > kexec/arch/arm64/Makefile            |   2 +
> > kexec/arch/arm64/crashdump-arm64.c   | 219 +++++++++++++++++++++++++++++++-
> > kexec/arch/arm64/crashdump-arm64.h   |  18 ++-
> > kexec/arch/arm64/iomem.h             |  10 ++
> > kexec/arch/arm64/kexec-arm64.c       | 239 +++++++++++++++++++++++++++++++++--
> > kexec/arch/arm64/kexec-elf-arm64.c   |  25 +++-
> > kexec/arch/arm64/kexec-image-arm64.c |  12 ++
> > kexec/arch/i386/crashdump-x86.c      |  29 -----
> > kexec/kexec-iomem.c                  |  15 ++-
> > kexec/kexec.h                        |   2 +
> > kexec/symbols.c                      |  34 +++++
> > 13 files changed, 551 insertions(+), 95 deletions(-)
> > create mode 100644 kexec/arch/arm64/iomem.h
> > create mode 100644 kexec/symbols.c
> >

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
