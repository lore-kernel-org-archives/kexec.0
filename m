Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hWdrZ-00085s-RN
 for kexec@lists.infradead.org; Fri, 31 May 2019 09:30:15 +0000
Date: Fri, 31 May 2019 11:30:10 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/2] kexec-tools/arm64: Add support to read PHYS_OFFSET
 from vmcoreinfo inside '/proc/kcore'
Message-ID: <20190531093010.rmukbreemg6te3j3@verge.net.au>
References: <1540416294-10526-1-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1540416294-10526-1-git-send-email-bhsharma@redhat.com>
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
Cc: yanjiang.jin@hxt-semitech.com, takahiro.akashi@linaro.org, Vadim.Lomovtsev@cavium.com, bhupesh.linux@gmail.com, kexec@lists.infradead.org

On Thu, Oct 25, 2018 at 02:54:52AM +0530, Bhupesh Sharma wrote:
> Since kernel version 4.19-rc5 (Commit 23c85094fe1895caefdd
> ["proc/kcore: add vmcoreinfo note to /proc/kcore"]), '/proc/kcore'
> contains a new PT_NOTE which carries the VMCOREINFO information.
> 
> If the same is available, one should prefer the same to
> retrieve 'PHYS_OFFSET' value exported by the kernel as this
> is now the standard interface exposed by kernel for sharing
> machine specific details with the user-land as per
> the arm64 kernel maintainers (see [0]).
> 
> Also on certain arm64 platforms, it has been noticed that due
> to a hole at the start of physical ram exposed to kernel
> (i.e. it doesn't start from address 0), the kernel still
> calculates the 'memstart_addr' kernel variable as 0.
> 
> Whereas the SYSTEM_RAM or IOMEM_RESERVED range in '/proc/iomem'
> would carry a first entry whose start address is non-zero
> (as the physical ram exposed to the kernel starts from a
> non-zero address).
> 
> In such cases, if we rely on '/proc/iomem' entries to
> calculate the phys_offset, then we will have mismatch
> between the user-space and kernel space 'PHYS_OFFSET'
> value. The present 'kexec-tools' code does the same
> in 'get_memory_ranges_iomem_cb()' function when it makes
> a call to 'set_phys_offset()'. This can cause the vmcore
> generated via 'kexec-tools' to miss the last few bytes as
> the first '/proc/iomem' starts from a non-zero address.
> 
> Details about the patches in this series:
> ----------------------------------------
> PATCH 1/2 ->
> 
> - Tries to move the elf read functionality from 'vmcore-dmesg.c' to
>   a new utility library named 'elf_info.c', so that subsequent patches
>   can use the same.
> - See the patch log for more details.
> 
> PATCH 2/2 ->
> - Implements the actual functionality of reading the PHYS_OFFSET for arm64
>   platforms from the vmcoreinfo inside '/proc/kcore' (if available).
> - See the patch log for more details.
> 
> Testing:
> --------
> I tested this patchset on qualcomm-amberwing and huawei-taishan arm64
> boards for non-KALSR boot mode. Both display the same PHYS_OFFSET in
> user-space as the value used by kernel after this patch.
> 
> I will send a separate followup patch to fix the KASLR boot cases
> (as the discussion on the same is in progress with the arm64
> kernel maintainers).
> 
> [0] https://www.mail-archive.com/kexec@lists.infradead.org/msg20300.html
> 
> Bhupesh Sharma (2):
>   util_lib: Add functionality to read elf notes
>   arm64: Add support to read PHYS_OFFSET from '/proc/kcore' (if
>     available)
> 
>  kexec/arch/arm64/kexec-arm64.c                     |  73 ++
>  util_lib/Makefile                                  |   4 +-
>  vmcore-dmesg/vmcore-dmesg.c => util_lib/elf_info.c | 157 +++--
>  util_lib/include/elf_info.h                        |  30 +
>  vmcore-dmesg/Makefile                              |   4 +-
>  vmcore-dmesg/vmcore-dmesg.c                        | 742 +--------------------
>  6 files changed, 219 insertions(+), 791 deletions(-)
>  copy vmcore-dmesg/vmcore-dmesg.c => util_lib/elf_info.c (88%)
>  create mode 100644 util_lib/include/elf_info.h

Sorry for letting this slip through the cracks.
Please let me know if this is still relevant.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
