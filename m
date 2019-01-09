Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghCyu-0003DJ-Gc
 for kexec@lists.infradead.org; Wed, 09 Jan 2019 12:29:14 +0000
Date: Wed, 9 Jan 2019 13:29:09 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 0/2] kexec-tools/arm64: Add support to read
 PHYS_OFFSET from kcore
Message-ID: <20190109122909.2ev4skeyrbre433m@verge.net.au>
References: <1545304972-32333-1-git-send-email-bhsharma@redhat.com>
 <CACi5LpMQirN+QwWWxxvWq3eFhzy-C3TT+gS3v=r_Hbba4Lsitw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACi5LpMQirN+QwWWxxvWq3eFhzy-C3TT+gS3v=r_Hbba4Lsitw@mail.gmail.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Yanjiang Jin <yanjiang.jin@hxt-semitech.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Vadim.Lomovtsev@cavium.com, Bhupesh SHARMA <bhupesh.linux@gmail.com>, kexec mailing list <kexec@lists.infradead.org>

On Mon, Jan 07, 2019 at 04:22:49PM +0530, Bhupesh Sharma wrote:
> Hi Simon,
> 
> On Thu, Dec 20, 2018 at 4:52 PM Bhupesh Sharma <bhsharma@redhat.com> wrote:
> >
> > Changes from v1:
> > ---------------
> >  - Added the support for older kernels, where we determine the
> >    PHYS_OFFSET value from PT_LOAD segments inside 'kcore'.
> >  - Improved commit logs since v1.
> >
> > On certain arm64 platforms, it has been noticed that due
> > to a hole at the start of physical ram exposed to kernel
> > (i.e. it doesn't start from address 0), the kernel still
> > calculates the 'memstart_addr' kernel variable as 0.
> >
> > Whereas the SYSTEM_RAM or IOMEM_RESERVED range in '/proc/iomem'
> > would carry a first entry whose start address is non-zero
> > (as the physical ram exposed to the kernel starts from a
> > non-zero address).
> >
> > In such cases, if we rely on '/proc/iomem' entries to
> > calculate the phys_offset, then we will have mismatch
> > between the user-space and kernel space 'PHYS_OFFSET'
> > value. The present 'kexec-tools' code does the same
> > in 'get_memory_ranges_iomem_cb()' function when it makes
> > a call to 'set_phys_offset()'. This can cause the vmcore
> > generated via 'kexec-tools' to miss the last few bytes as
> > the first '/proc/iomem' starts from a non-zero address.
> >
> > Please see [0] for the original bug-report from Yanjiang Jin.
> >
> > This patchset tries to fix the same.
> >
> > Details about the patches in this series:
> > ----------------------------------------
> > PATCH 1/2 ->
> >
> > - Tries to move the elf read functionality from 'vmcore-dmesg.c' to
> >   a new utility library named 'elf_info.c', so that subsequent patches
> >   can use the same.
> > - See the patch log for more details.
> >
> > PATCH 2/2 ->
> > - Implements the actual functionality of reading the PHYS_OFFSET for arm64
> >   platforms from the kcore (either VMCOREINFO PT_NOTE inside 'kcore'
> >   or from the PT_LOAD segments inside 'kcore').
> > - See the patch log for more details.
> >
> > [0] https://www.spinics.net/lists/kexec/msg20618.html
> >
> > Bhupesh Sharma (2):
> >   util_lib: Add functionality to read elf notes
> >   arm64: Add support to read PHYS_OFFSET from 'kcore' - pt_note or
> >     pt_load (if available)
> >
> >  kexec/arch/arm64/kexec-arm64.c                     | 194 +++++-
> >  kexec/arch/arm64/kexec-arm64.h                     |  15 +-
> >  util_lib/Makefile                                  |   4 +-
> >  vmcore-dmesg/vmcore-dmesg.c => util_lib/elf_info.c | 193 ++++--
> >  util_lib/include/elf_info.h                        |  35 +
> >  vmcore-dmesg/Makefile                              |   4 +-
> >  vmcore-dmesg/vmcore-dmesg.c                        | 742 +--------------------
> >  7 files changed, 386 insertions(+), 801 deletions(-)
> >  copy vmcore-dmesg/vmcore-dmesg.c => util_lib/elf_info.c (86%)
> >  create mode 100644 util_lib/include/elf_info.h
> >
> > --
> > 2.7.4
> 
> Ping. Since this fixes a pending known issue on arm64 boards (both for
> KASLR and non-KASLR boot cases) can we please pick this patch-set for
> upstream kexec-tools.

Thanks, and sorry for the delay.

I have applied this series.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
