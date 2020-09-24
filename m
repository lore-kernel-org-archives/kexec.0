Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1400050.outbound.protection.outlook.com
 ([40.107.140.50] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLJjV-0005IX-NH
 for kexec@lists.infradead.org; Thu, 24 Sep 2020 05:23:54 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH v5 0/3] makedumpfile/arm64: Add support for ARMv8.2
 extensions
Date: Thu, 24 Sep 2020 05:23:48 +0000
Message-ID: <OSBPR01MB199105291C7EE3FB3837538BDD390@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <20200910053305.323365-1-bhsharma@redhat.com>
In-Reply-To: <20200910053305.323365-1-bhsharma@redhat.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: Bhupesh Sharma <bhsharma@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: John Donnelly <john.p.donnelly@oracle.com>, "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>

Hi Bhupesh,

sorry for my scattered comments.

As for 1/3 and 2/3, I think we can merge them separately with 3/3, right?
so if you can ack the updated 1/3 I sent, I will merge them first.
Could you check it?

As for 3/3, you introduced a couple of new ways, so I'd like to discuss
whether there is no better way a little more.

Thanks,
Kazu

-----Original Message-----
> Changes since v4:
> ----------------
> - v4 can be seen here:
>   https://www.spinics.net/lists/kexec/msg23850.html
> - Removed the patch (via [PATCH 4/4] in v3) which marked '--mem-usage'
>   option as unsupported for arm64 architecture, as we now have a mechanism
>   to read the 'vabits_actual' value from 'id_aa64mmfr2_el1' arm64 system
>   architecture register. As per discussions with arm64 and gcc/binutils
>   maintainers it turns out there is no standard ABI available between
>   the kernel and user-space to export this value early enough to be used
>   for page_offset calculation in the --mem-usage case. So, the next best
>   option is to have the user-space read the system register to determine
>   underlying hardware support for larger (52-bit) addressing support.
> 
>   This allows us to keep supporting '--mem-usage' option on arm64 even
>   on newer kernels (with flipped VA space).
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
> I cover the following cases with this patchset:
> - Both old (<5.4) and new kernels (>= 5.4) work well.
> - All VA and PA bit combinations currently supported via the kernel
>   CONFIG options work well, including:
>  - 48-bit kernel VA + 52-bit PA (LPA)
>  - 52-bit kernel VA (LVA) + 52-bit PA (LPA)
> 
> This has been tested for the following user-cases:
> 1. Analysing page information via '--mem-usage' option.
> 2. Creating a dumpfile using /proc/vmcore,
> 3. Creating a dumpfile using /proc/kcore, and
> 4. Post-processing a vmcore.
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
> This patchset ensures backward compatibility for kernel versions in
> which 'TCR_EL1.T1SZ' and 'MAX_PHYSMEM_BITS' are not available in
> vmcoreinfo.
> 
> In the newer kernels (>= 5.4.0) the following patches export these
> variables in the vmcoreinfo:
>  - 1d50e5d0c505 ("crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo")
>  - bbdbc11804ff ("arm64/crash_core: Export TCR_EL1.T1SZ in vmcoreinfo")
> 
> Cc: John Donnelly <john.p.donnelly@oracle.com>
> Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> Cc: kexec@lists.infradead.org
> 
> Bhupesh Sharma (3):
>   tree-wide: Retrieve 'MAX_PHYSMEM_BITS' from vmcoreinfo (if available)
>   makedumpfile/arm64: Add support for ARMv8.2-LPA (52-bit PA support)
>   makedumpfile/arm64: Add support for ARMv8.2-LVA (52-bit kernel VA
>     support)
> 
>  arch/arm.c     |   8 +-
>  arch/arm64.c   | 520 ++++++++++++++++++++++++++++++++++++++-----------
>  arch/ia64.c    |   7 +-
>  arch/ppc.c     |   8 +-
>  arch/ppc64.c   |  49 +++--
>  arch/s390x.c   |  29 +--
>  arch/sparc64.c |   9 +-
>  arch/x86.c     |  34 ++--
>  arch/x86_64.c  |  27 +--
>  common.h       |  10 +
>  makedumpfile.c |   4 +-
>  makedumpfile.h |   6 +-
>  12 files changed, 529 insertions(+), 182 deletions(-)
> 
> --
> 2.26.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
