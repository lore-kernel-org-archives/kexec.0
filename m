Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn3nam01on0043.outbound.protection.outlook.com
 ([104.47.33.43] helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fIa3P-0007Rk-Gc
 for kexec@lists.infradead.org; Tue, 15 May 2018 13:31:50 +0000
Subject: Re: [PATCH 0/2] support kdump for AMD secure memory encryption(sme)
References: <20180515015133.4363-1-lijiang@redhat.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <55bda494-bee4-5696-03e5-fc21c9d6b631@amd.com>
Date: Tue, 15 May 2018 08:31:25 -0500
MIME-Version: 1.0
In-Reply-To: <20180515015133.4363-1-lijiang@redhat.com>
Content-Language: en-US
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
To: Lianbo Jiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org
Cc: dyoung@redhat.com, kexec@lists.infradead.org

On 5/14/2018 8:51 PM, Lianbo Jiang wrote:
> It is convenient to remap the old memory encrypted to the second kernel by
> calling ioremap_encrypted().
> 
> When sme enabled on AMD server, we also need to support kdump. Because
> the memory is encrypted in the first kernel, we will remap the old memory
> encrypted to the second kernel(crash kernel), and sme is also enabled in
> the second kernel, otherwise the old memory encrypted can not be decrypted.
> Because simply changing the value of a C-bit on a page will not
> automatically encrypt the existing contents of a page, and any data in the
> page prior to the C-bit modification will become unintelligible. A page of
> memory that is marked encrypted will be automatically decrypted when read
> from DRAM and will be automatically encrypted when written to DRAM.
> 
> For the kdump, it is necessary to distinguish whether the memory is
> encrypted. Furthermore, we should also know which part of the memory is
> encrypted or decrypted. We will appropriately remap the memory according
> to the specific situation in order to tell cpu how to deal with the
> data(encrypted or decrypted). For example, when sme enabled, if the old
> memory is encrypted, we will remap the old memory in encrypted way, which
> will automatically decrypt the old memory encrypted when we read those data
> from the remapping address.
> 
>  ----------------------------------------------
> | first-kernel | second-kernel | kdump support |
> |      (mem_encrypt=on|off)    |   (yes|no)    | 
> |--------------+---------------+---------------|
> |     on       |     on        |     yes       |
> |     off      |     off       |     yes       |
> |     on       |     off       |     no        |
> |     off      |     on        |     no        |
> |______________|_______________|_______________|
> 
> Test tools:
> makedumpfile[v1.6.3]: https://github.com/LianboJ/makedumpfile
> commit e1de103eca8f (A draft for kdump vmcore about AMD SME)
> Author: Lianbo Jiang <lijiang@redhat.com>
> Date:   Mon May 14 17:02:40 2018 +0800
> Note: This patch can only dump vmcore in the case of SME enabled.
> 
> crash-7.2.1: https://github.com/crash-utility/crash.git
> commit 1e1bd9c4c1be (Fix for the "bpf" command display on Linux 4.17-rc1)
> Author: Dave Anderson <anderson@redhat.com>
> Date:   Fri May 11 15:54:32 2018 -0400
> 
> Test environment:
> HP ProLiant DL385Gen10 AMD EPYC 7251
> 8-Core Processor
> 32768 MB memory
> 600 GB disk space
> 
> Linux 4.17-rc4:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> commit 75bc37fefc44 ("Linux 4.17-rc4")
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun May 6 16:57:38 2018 -1000
> 
> Reference:
> AMD64 Architecture Programmer's Manual
> https://support.amd.com/TechDocs/24593.pdf
> 

Have you also tested this with SEV?  It would be nice if the kdump
changes you make work with both SME and SEV.

Thanks,
Tom

> Lianbo Jiang (2):
>   add a function(ioremap_encrypted) for kdump when AMD sme enabled.
>   support kdump when AMD secure memory encryption is active
> 
>  arch/x86/include/asm/dmi.h      | 14 +++++++++++++-
>  arch/x86/include/asm/io.h       |  2 ++
>  arch/x86/kernel/acpi/boot.c     |  8 ++++++++
>  arch/x86/kernel/crash_dump_64.c | 27 +++++++++++++++++++++++++++
>  arch/x86/mm/ioremap.c           | 25 +++++++++++++++++--------
>  drivers/acpi/tables.c           | 14 +++++++++++++-
>  drivers/iommu/amd_iommu_init.c  |  9 ++++++++-
>  fs/proc/vmcore.c                | 36 +++++++++++++++++++++++++++++++-----
>  include/linux/crash_dump.h      |  4 ++++
>  kernel/kexec_core.c             | 12 ++++++++++++
>  10 files changed, 135 insertions(+), 16 deletions(-)
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
