Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from foss.arm.com ([217.140.110.172])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mt61i-00FC9g-0N
 for kexec@lists.infradead.org; Fri, 03 Dec 2021 10:42:51 +0000
From: Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [RFC PATCH 00/14] fs/proc/vmcore: Remove unnecessary user pointer
 conversions 
Date: Fri,  3 Dec 2021 16:12:17 +0530
Message-Id: <20211203104231.17597-1-amit.kachhap@arm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Vincenzo Frascino <Vincenzo.Frascino@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, kexec <kexec@lists.infradead.org>, Amit Daniel Kachhap <amit.kachhap@arm.com>

Hi,

This series aims to restructure the external interfaces as well internal
code used in fs/proc/vmcore.c by removing the interchangeable use of user
and kernel pointers. This unnecessary conversion may obstruct the tools
such as sparse in generating meaningful results. This also simplifies
the things by keeping the user and kernel pointers separate during
propagation.

The external interfaces such as copy_oldmem_page, copy_oldmem_page_encrypted
and read_from_oldmem are used across different architectures. The goal
here is to update one architecture at a time and hence there is an extra
cleanup done in the end to remove the intermediaries.

In this series, an extra user pointer is added as a parameter to all the
above functions instead of an union as there were disagreement in earlier ideas
of using universal pointer [1,2]. This series is posted as RFC so as to
find out an acceptable way of handling this use case.

This series is based on v5.16-rc3 and is compile tested for modified
architectures and boot tested in qemu for all architectures except ia64.

Note: This patch series breaks the crash dump functionality after patch
3 and is restored after each arch implements its own
copy_oldmem_page_buf() interface.

Thanks,
Amit Daniel

[1]: https://lore.kernel.org/lkml/20200624162901.1814136-2-hch@lst.de/
[2]: https://lore.kernel.org/lkml/CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com/

Amit Daniel Kachhap (14):
  fs/proc/vmcore: Update read_from_oldmem() for user pointer
  fs/proc/vmcore: Update copy_oldmem_page_encrypted() for user buffer
  fs/proc/vmcore: Update copy_oldmem_page() for user buffer
  x86/crash_dump_64: Use the new interface copy_oldmem_page_buf
  x86/crash_dump_32: Use the new interface copy_oldmem_page_buf
  arm64/crash_dump: Use the new interface copy_oldmem_page_buf
  arm/crash_dump: Use the new interface copy_oldmem_page_buf
  mips/crash_dump: Use the new interface copy_oldmem_page_buf
  sh/crash_dump: Use the new interface copy_oldmem_page_buf
  riscv/crash_dump: Use the new interface copy_oldmem_page_buf
  powerpc/crash_dump: Use the new interface copy_oldmem_page_buf
  ia64/crash_dump: Use the new interface copy_oldmem_page_buf
  s390/crash_dump: Use the new interface copy_oldmem_page_buf
  fs/proc/vmcore: Remove the unused old interface copy_oldmem_page

 arch/arm/kernel/crash_dump.c     | 21 ++++----
 arch/arm64/kernel/crash_dump.c   | 21 ++++----
 arch/ia64/kernel/crash_dump.c    | 25 +++++-----
 arch/mips/kernel/crash_dump.c    | 24 ++++-----
 arch/powerpc/kernel/crash_dump.c | 33 +++++++------
 arch/riscv/kernel/crash_dump.c   | 25 +++++-----
 arch/s390/kernel/crash_dump.c    | 12 ++---
 arch/sh/kernel/crash_dump.c      | 25 +++++-----
 arch/x86/kernel/crash_dump_32.c  | 24 ++++-----
 arch/x86/kernel/crash_dump_64.c  | 48 +++++++++---------
 fs/proc/vmcore.c                 | 85 +++++++++++++++++---------------
 include/linux/crash_dump.h       | 23 +++++----
 12 files changed, 189 insertions(+), 177 deletions(-)

-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
