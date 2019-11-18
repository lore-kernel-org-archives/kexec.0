Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iWZKn-00051Z-2T
 for kexec@lists.infradead.org; Mon, 18 Nov 2019 05:12:22 +0000
Received: by mail-il1-x141.google.com with SMTP id q1so14791087ile.13
 for <kexec@lists.infradead.org>; Sun, 17 Nov 2019 21:12:17 -0800 (PST)
MIME-Version: 1.0
References: <1573556939-17803-1-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1573556939-17803-1-git-send-email-bhsharma@redhat.com>
From: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date: Mon, 18 Nov 2019 10:42:05 +0530
Message-ID: <CAJ2QiJJ6DdxFheRo78+n1=ZuqMQnHeuLVWchK8SApt3w9wBKLQ@mail.gmail.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: John Donnelly <john.p.donnelly@oracle.com>, Prabhakar Kushwaha <pkushwaha@marvell.com>, Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>, kexec mailing list <kexec@lists.infradead.org>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, bhupesh.linux@gmail.com

Re-sending in plain text mode.

On Tue, Nov 12, 2019 at 4:39 PM Bhupesh Sharma <bhsharma@redhat.com> wrote:
>
> Changes since v3:
> ----------------
> - v3 can be seen here:
>   http://lists.infradead.org/pipermail/kexec/2019-March/022534.html
> - Added a new patch (via [PATCH 4/4]) which marks '--mem-usage' option as
>   unsupported for arm64 architecture. With the newer arm64 kernels
>   supporting 48-bit/52-bit VA address spaces and keeping a single
>   binary for supporting the same, the address of
>   kernel symbols like _stext, which could be earlier used to determine
>   VA_BITS value, can no longer to determine whether VA_BITS is set to 48
>   or 52 in the kernel space. Hence for now, it makes sense to mark
>   '--mem-usage' option as unsupported for arm64 architecture until
>   we have more clarity from arm64 kernel maintainers on how to manage
>   the same in future kernel/makedumpfile versions.
>
> Changes since v2:
> ----------------
> - v2 can be seen here:
>   http://lists.infradead.org/pipermail/kexec/2019-February/022456.html
> - I missed some comments from Kazu sent on the LVA v1 patch when I sent
>   out the v2. So, addressing them now in v3.
> - Also added a patch that adds a tree-wide feature to read
>   'MAX_PHYSMEM_BITS' from vmcoreinfo (if available).
>
> Changes since v1:
> ----------------
> - v1 was sent as two separate patches:
>   http://lists.infradead.org/pipermail/kexec/2019-February/022424.html
>   (ARMv8.2-LPA)
>   http://lists.infradead.org/pipermail/kexec/2019-February/022425.html
>   (ARMv8.2-LVA)
> - v2 combined the two in a single patchset and also addresses Kazu's
>   review comments.
>
> This patchset adds support for ARMv8.2 extensions in makedumpfile code.
> I cover the following two cases with this patchset:
>  - 48-bit kernel VA + 52-bit PA (LPA)
>  - 52-bit kernel VA (LVA) + 52-bit PA (LPA)
>  - 48-bit kernel VA + 52-bit user-space VA (LVA)
>  - 52-bit kernel VA + 52-bit user-space VA (Full LVA)
>
> This has been tested for the following user-cases:
> 1. Creating a dumpfile using /proc/vmcore,
> 2. Creating a dumpfile using /proc/kcore, and
> 3. Post-processing a vmcore.
>
> I have tested this patchset on the following platforms, with kernels
> which support/do-not-support ARMv8.2 features:
> 1. CPUs which don't support ARMv8.2 features, e.g. qualcomm-amberwing,
>    ampere-osprey.
> 2. Prototype models which support ARMv8.2 extensions (e.g. ARMv8 FVP
>    simulation model).
>
> Also a preparation patch has been added in this patchset which adds a
> common feature for archs (except arm64, for which similar support is
> added via subsequent patch) to retrieve 'MAX_PHYSMEM_BITS' from
> vmcoreinfo (if available).
>
> I recently posted two kernel patches (see [0] and [1]) which append
> 'TCR_EL1.T1SZ' and 'MAX_PHYSMEM_BITS' to vmcoreinfo in the kernel
> code, so that user-space code can benefit from the same.
>
> This patchset ensures backward compatibility for kernel versions in
> which 'TCR_EL1.T1SZ' and 'MAX_PHYSMEM_BITS' are not available in
> vmcoreinfo.
>
> [0]. http://lists.infradead.org/pipermail/kexec/2019-November/023960.html
> [1]. http://lists.infradead.org/pipermail/kexec/2019-November/023962.html
>
> Cc: John Donnelly <john.p.donnelly@oracle.com>
> Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> Cc: kexec@lists.infradead.org
>
> Bhupesh Sharma (4):
>   tree-wide: Retrieve 'MAX_PHYSMEM_BITS' from vmcoreinfo (if available)
>   makedumpfile/arm64: Add support for ARMv8.2-LPA (52-bit PA support)
>   makedumpfile/arm64: Add support for ARMv8.2-LVA (52-bit kernel VA
>     support)
>   makedumpfile: Mark --mem-usage option unsupported for arm64
>
>  arch/arm.c     |   8 +-
>  arch/arm64.c   | 438 ++++++++++++++++++++++++++++++++++++++++++---------------
>  arch/ia64.c    |   7 +-
>  arch/ppc.c     |   8 +-
>  arch/ppc64.c   |  49 ++++---
>  arch/s390x.c   |  29 ++--
>  arch/sparc64.c |   9 +-
>  arch/x86.c     |  34 +++--
>  arch/x86_64.c  |  27 ++--
>  makedumpfile.c |   7 +
>  makedumpfile.h |   3 +-
>  11 files changed, 439 insertions(+), 180 deletions(-)
>
> --

Tested this patch-set on Marvell's TX2 platform on top
commit(82e6cce2219a) of https://git.code.sf.net/p/makedumpfile/code
(devel branch)

Tested-by: Prabhakar Kushwaha <pkushwaha@marvell.com>

--pk

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
