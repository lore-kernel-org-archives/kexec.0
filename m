Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 0/3] Convert vmcore to use an iov_iter
Date: Mon, 13 Dec 2021 00:06:33 +0000
Message-Id: <20211213000636.2932569-1-willy@infradead.org>
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
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org, Amit Daniel Kachhap <amit.kachhap@arm.com>, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org

For some reason several people have been sending bad patches to fix
compiler warnings in vmcore recently.  Here's how it should be done.
Compile-tested only on x86.  As noted in the first patch, s390 should
take this conversion a bit further, but I'm not inclined to do that
work myself.

Matthew Wilcox (Oracle) (3):
  vmcore: Convert copy_oldmem_page() to take an iov_iter
  vmcore: Convert __read_vmcore to use an iov_iter
  vmcore: Convert read_from_oldmem() to take an iov_iter

 arch/arm/kernel/crash_dump.c     |  14 +---
 arch/arm64/kernel/crash_dump.c   |  14 +---
 arch/ia64/kernel/crash_dump.c    |  12 +--
 arch/mips/kernel/crash_dump.c    |  13 +---
 arch/powerpc/kernel/crash_dump.c |  20 +----
 arch/riscv/kernel/crash_dump.c   |  13 +---
 arch/s390/kernel/crash_dump.c    |  12 +--
 arch/sh/kernel/crash_dump.c      |  15 +---
 arch/x86/kernel/crash_dump_32.c  |  13 +---
 arch/x86/kernel/crash_dump_64.c  |  31 ++++----
 fs/proc/vmcore.c                 | 130 +++++++++++++------------------
 include/linux/crash_dump.h       |  19 ++---
 12 files changed, 112 insertions(+), 194 deletions(-)

-- 
2.33.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
