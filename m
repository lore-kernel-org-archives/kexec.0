Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iVKWH-00013g-89
 for kexec@lists.infradead.org; Thu, 14 Nov 2019 19:11:07 +0000
Received: by mail-lf1-f71.google.com with SMTP id g143so2258690lfd.22
 for <kexec@lists.infradead.org>; Thu, 14 Nov 2019 11:11:00 -0800 (PST)
MIME-Version: 1.0
References: <1573556939-17803-1-git-send-email-bhsharma@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035950A0@BPXM09GP.gisp.nec.co.jp>
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC035950A0@BPXM09GP.gisp.nec.co.jp>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Fri, 15 Nov 2019 00:40:35 +0530
Message-ID: <CACi5LpPiRsu7-Lv9YMw4FNxP64=sXHjegZwmHD7VJvSL63gmCQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] makedumpfile/arm64: Add support for ARMv8.2
 extensions
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
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: John Donnelly <john.p.donnelly@oracle.com>, "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Kazu,

On Thu, Nov 14, 2019 at 3:31 AM Kazuhito Hagio <k-hagio@ab.jp.nec.com> wrote:
>
> Hi Bhupesh,
>
> Thanks for the updated patchset.
>
> I'm taking a look at this, but I will be out of office from tomorrow
> until Nov 29th, so please expect some (long) delays in my response..

Thanks a lot for your message. Sure, let's discuss this more when you
return from your holidays.

Regards,
Bhupesh

>
> Thanks,
> Kazu
>
> > -----Original Message-----
> > Changes since v3:
> > ----------------
> > - v3 can be seen here:
> >   http://lists.infradead.org/pipermail/kexec/2019-March/022534.html
> > - Added a new patch (via [PATCH 4/4]) which marks '--mem-usage' option as
> >   unsupported for arm64 architecture. With the newer arm64 kernels
> >   supporting 48-bit/52-bit VA address spaces and keeping a single
> >   binary for supporting the same, the address of
> >   kernel symbols like _stext, which could be earlier used to determine
> >   VA_BITS value, can no longer to determine whether VA_BITS is set to 48
> >   or 52 in the kernel space. Hence for now, it makes sense to mark
> >   '--mem-usage' option as unsupported for arm64 architecture until
> >   we have more clarity from arm64 kernel maintainers on how to manage
> >   the same in future kernel/makedumpfile versions.
> >
> > Changes since v2:
> > ----------------
> > - v2 can be seen here:
> >   http://lists.infradead.org/pipermail/kexec/2019-February/022456.html
> > - I missed some comments from Kazu sent on the LVA v1 patch when I sent
> >   out the v2. So, addressing them now in v3.
> > - Also added a patch that adds a tree-wide feature to read
> >   'MAX_PHYSMEM_BITS' from vmcoreinfo (if available).
> >
> > Changes since v1:
> > ----------------
> > - v1 was sent as two separate patches:
> >   http://lists.infradead.org/pipermail/kexec/2019-February/022424.html
> >   (ARMv8.2-LPA)
> >   http://lists.infradead.org/pipermail/kexec/2019-February/022425.html
> >   (ARMv8.2-LVA)
> > - v2 combined the two in a single patchset and also addresses Kazu's
> >   review comments.
> >
> > This patchset adds support for ARMv8.2 extensions in makedumpfile code.
> > I cover the following two cases with this patchset:
> >  - 48-bit kernel VA + 52-bit PA (LPA)
> >  - 52-bit kernel VA (LVA) + 52-bit PA (LPA)
> >  - 48-bit kernel VA + 52-bit user-space VA (LVA)
> >  - 52-bit kernel VA + 52-bit user-space VA (Full LVA)
> >
> > This has been tested for the following user-cases:
> > 1. Creating a dumpfile using /proc/vmcore,
> > 2. Creating a dumpfile using /proc/kcore, and
> > 3. Post-processing a vmcore.
> >
> > I have tested this patchset on the following platforms, with kernels
> > which support/do-not-support ARMv8.2 features:
> > 1. CPUs which don't support ARMv8.2 features, e.g. qualcomm-amberwing,
> >    ampere-osprey.
> > 2. Prototype models which support ARMv8.2 extensions (e.g. ARMv8 FVP
> >    simulation model).
> >
> > Also a preparation patch has been added in this patchset which adds a
> > common feature for archs (except arm64, for which similar support is
> > added via subsequent patch) to retrieve 'MAX_PHYSMEM_BITS' from
> > vmcoreinfo (if available).
> >
> > I recently posted two kernel patches (see [0] and [1]) which append
> > 'TCR_EL1.T1SZ' and 'MAX_PHYSMEM_BITS' to vmcoreinfo in the kernel
> > code, so that user-space code can benefit from the same.
> >
> > This patchset ensures backward compatibility for kernel versions in
> > which 'TCR_EL1.T1SZ' and 'MAX_PHYSMEM_BITS' are not available in
> > vmcoreinfo.
> >
> > [0]. http://lists.infradead.org/pipermail/kexec/2019-November/023960.html
> > [1]. http://lists.infradead.org/pipermail/kexec/2019-November/023962.html
> >
> > Cc: John Donnelly <john.p.donnelly@oracle.com>
> > Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> > Cc: kexec@lists.infradead.org
> >
> > Bhupesh Sharma (4):
> >   tree-wide: Retrieve 'MAX_PHYSMEM_BITS' from vmcoreinfo (if available)
> >   makedumpfile/arm64: Add support for ARMv8.2-LPA (52-bit PA support)
> >   makedumpfile/arm64: Add support for ARMv8.2-LVA (52-bit kernel VA
> >     support)
> >   makedumpfile: Mark --mem-usage option unsupported for arm64
> >
> >  arch/arm.c     |   8 +-
> >  arch/arm64.c   | 438 ++++++++++++++++++++++++++++++++++++++++++---------------
> >  arch/ia64.c    |   7 +-
> >  arch/ppc.c     |   8 +-
> >  arch/ppc64.c   |  49 ++++---
> >  arch/s390x.c   |  29 ++--
> >  arch/sparc64.c |   9 +-
> >  arch/x86.c     |  34 +++--
> >  arch/x86_64.c  |  27 ++--
> >  makedumpfile.c |   7 +
> >  makedumpfile.h |   3 +-
> >  11 files changed, 439 insertions(+), 180 deletions(-)
> >
> > --
> > 2.7.4
> >
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
>
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
