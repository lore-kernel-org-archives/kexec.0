Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i0FA0-0005dH-2n
 for kexec@lists.infradead.org; Wed, 21 Aug 2019 01:11:37 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7L172bs018802
 for <kexec@lists.infradead.org>; Tue, 20 Aug 2019 21:11:35 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ugpemcehy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 20 Aug 2019 21:11:35 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.ibm.com>;
 Wed, 21 Aug 2019 02:11:34 +0100
References: <20190715082702.27308-1-svens@stackframe.org>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v4 0/7] kexec: add generic support for elf kernel images
In-reply-to: <20190715082702.27308-1-svens@stackframe.org>
Date: Tue, 20 Aug 2019 22:11:25 -0300
MIME-Version: 1.0
Message-Id: <87pnkzmif6.fsf@morokweng.localdomain>
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
To: kexec@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>


Sven Schnelle <svens@stackframe.org> writes:

> Changes to v3:
>  - add support for 32-bit ELF files
>
> Changes to v2:
>  - use git format-patch -C
>
> Changes to v1:
>  - split up patch into smaller pieces
>  - rebase onto powerpc/next
>  - remove unused variable in kexec_elf_load()
>
> Changes to RFC version:
>  - remove unused Elf_Rel macro
>  - remove section header parsing
>  - remove PURGATORY_STACK_SIZE
>  - change order of elf_*_to_cpu() functions
>  - remove elf_addr_to_cpu macro
>
> Sven Schnelle (7):
>   kexec: add KEXEC_ELF
>   kexec_elf: change order of elf_*_to_cpu() functions
>   kexec_elf: remove parsing of section headers
>   kexec_elf: remove PURGATORY_STACK_SIZE
>   kexec_elf: remove Elf_Rel macro
>   kexec_elf: remove unused variable in kexec_elf_load()
>   kexec_elf: support 32 bit ELF files
>
>  arch/Kconfig                       |   3 +
>  arch/powerpc/Kconfig               |   1 +
>  arch/powerpc/kernel/kexec_elf_64.c | 551 +----------------------------
>  include/linux/kexec.h              |  23 ++
>  kernel/Makefile                    |   1 +
>  kernel/kexec_elf.c                 | 418 ++++++++++++++++++++++
>  6 files changed, 456 insertions(+), 541 deletions(-)
>  create mode 100644 kernel/kexec_elf.c

The series applies on v5.1 but not newer kernels, so it needs to be
rebased.

I tested with v5.1 in ppc64le kexecing to both little-endian and
big-endian kernels, and also in ppc64 kexecing to both big-endian and
little-endian kernels so:

Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

--
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
