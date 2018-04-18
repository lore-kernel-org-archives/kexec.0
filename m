Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f8gO3-00010J-Ui
 for kexec@lists.infradead.org; Wed, 18 Apr 2018 06:16:16 +0000
Date: Wed, 18 Apr 2018 14:15:46 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH net-next v4 0/3] kernel: add support to collect hardware
 logs in crash recovery kernel
Message-ID: <20180418061546.GA4551@dhcp-128-65.nay.redhat.com>
References: <cover.1523950321.git.rahul.lakkireddy@chelsio.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1523950321.git.rahul.lakkireddy@chelsio.com>
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
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: indranil@chelsio.com, netdev@vger.kernel.org, nirranjan@chelsio.com, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, davem@davemloft.net, stephen@networkplumber.org, ganeshgr@chelsio.com, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, kexec@lists.infradead.org, ebiederm@xmission.com

Hi Rahul,
On 04/17/18 at 01:14pm, Rahul Lakkireddy wrote:
> On production servers running variety of workloads over time, kernel
> panic can happen sporadically after days or even months. It is
> important to collect as much debug logs as possible to root cause
> and fix the problem, that may not be easy to reproduce. Snapshot of
> underlying hardware/firmware state (like register dump, firmware
> logs, adapter memory, etc.), at the time of kernel panic will be very
> helpful while debugging the culprit device driver.
> 
> This series of patches add new generic framework that enable device
> drivers to collect device specific snapshot of the hardware/firmware
> state of the underlying device in the crash recovery kernel. In crash
> recovery kernel, the collected logs are added as elf notes to
> /proc/vmcore, which is copied by user space scripts for post-analysis.
> 
> The sequence of actions done by device drivers to append their device
> specific hardware/firmware logs to /proc/vmcore are as follows:
> 
> 1. During probe (before hardware is initialized), device drivers
> register to the vmcore module (via vmcore_add_device_dump()), with
> callback function, along with buffer size and log name needed for
> firmware/hardware log collection.

I assumed the elf notes info should be prepared while kexec_[file_]load
phase. But I did not read the old comment, not sure if it has been discussed
or not.

If do this in 2nd kernel a question is driver can be loaded later than vmcore init.
How to guarantee the function works if vmcore reading happens before
the driver is loaded?

Also it is possible that kdump initramfs does not contains the driver
module.

Am I missing something?

> 
> 2. vmcore module allocates the buffer with requested size. It adds
> an elf note and invokes the device driver's registered callback
> function.
> 
> 3. Device driver collects all hardware/firmware logs into the buffer
> and returns control back to vmcore module.
> 
> The device specific hardware/firmware logs can be seen as elf notes:
> 
> # readelf -n /proc/vmcore
> 
> Displaying notes found at file offset 0x00001000 with length 0x04003288:
>   Owner                 Data size	Description
>   VMCOREDD_cxgb4_0000:02:00.4 0x02000fd8	Unknown note type: (0x00000700)
>   VMCOREDD_cxgb4_0000:04:00.4 0x02000fd8	Unknown note type: (0x00000700)
>   CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
>   CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
>   CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
>   CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
>   CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
>   CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
>   CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
>   CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
>   VMCOREINFO           0x0000074f	Unknown note type: (0x00000000)
> 
> Patch 1 adds API to vmcore module to allow drivers to register callback
> to collect the device specific hardware/firmware logs.  The logs will
> be added to /proc/vmcore as elf notes.
> 
> Patch 2 updates read and mmap logic to append device specific hardware/
> firmware logs as elf notes.
> 
> Patch 3 shows a cxgb4 driver example using the API to collect
> hardware/firmware logs in crash recovery kernel, before hardware is
> initialized.
> 
> Thanks,
> Rahul
> 
> RFC v1: https://lkml.org/lkml/2018/3/2/542
> RFC v2: https://lkml.org/lkml/2018/3/16/326
> 
> ---
> v4:
> - Made __vmcore_add_device_dump() static.
> - Moved compile check to define vmcore_add_device_dump() to
>   crash_dump.h to fix compilation when vmcore.c is not compiled in.
> - Convert ---help--- to help in Kconfig as indicated by checkpatch.
> - Rebased to tip.
> 
> v3:
> - Dropped sysfs crashdd module.
> - Exported dumps as elf notes. Suggested by Eric Biederman
>   <ebiederm@xmission.com>.  Added as patch 2 in this version.
> - Added CONFIG_PROC_VMCORE_DEVICE_DUMP to allow configuring device
>   dump support.
> - Moved logic related to adding dumps from crashdd to vmcore module.
> - Rename all crashdd* to vmcoredd*.
> - Updated comments.
> 
> v2:
> - Added ABI Documentation for crashdd.
> - Directly use octal permission instead of macro.
> 
> Changes since rfc v2:
> - Moved exporting crashdd from procfs to sysfs. Suggested by
>   Stephen Hemminger <stephen@networkplumber.org>
> - Moved code from fs/proc/crashdd.c to fs/crashdd/ directory.
> - Replaced all proc API with sysfs API and updated comments.
> - Calling driver callback before creating the binary file under
>   crashdd sysfs.
> - Changed binary dump file permission from S_IRUSR to S_IRUGO.
> - Changed module name from CRASH_DRIVER_DUMP to CRASH_DEVICE_DUMP.
> 
> rfc v2:
> - Collecting logs in 2nd kernel instead of during kernel panic.
>   Suggested by Eric Biederman <ebiederm@xmission.com>.
> - Added new crashdd module that exports /proc/crashdd/ containing
>   driver's registered hardware/firmware logs in patch 1.
> - Replaced the API to allow drivers to register their hardware/firmware
>   log collect routine in crash recovery kernel in patch 1.
> - Updated patch 2 to use the new API in patch 1.
> 
> Rahul Lakkireddy (3):
>   vmcore: add API to collect hardware dump in second kernel
>   vmcore: append device dumps to vmcore as elf notes
>   cxgb4: collect hardware dump in second kernel
> 
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4.h       |   4 +
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c |  25 ++
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.h |   3 +
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c  |  10 +
>  fs/proc/Kconfig                                  |  10 +
>  fs/proc/vmcore.c                                 | 399 ++++++++++++++++++++++-
>  include/linux/crash_core.h                       |   4 +
>  include/linux/crash_dump.h                       |  17 +
>  include/linux/kcore.h                            |   6 +
>  include/uapi/linux/elf.h                         |   1 +
>  10 files changed, 466 insertions(+), 13 deletions(-)
> 
> -- 
> 2.14.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
