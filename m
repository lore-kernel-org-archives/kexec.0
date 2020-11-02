Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v2 0/4] syscalls: remove compat_alloc_user_space callers
Date: Mon,  2 Nov 2020 13:31:47 +0100
Message-Id: <20201102123151.2860165-1-arnd@kernel.org>
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
To: linux-arch@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, Borislav Petkov <bp@alien8.de>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>

From: Arnd Bergmann <arnd@arndb.de>

Going through compat_alloc_user_space() to convert indirect system call
arguments tends to add complexity compared to handling the native and
compat logic in the same code.

I have patches for all other uses of compat_alloc_user_space() as well,
and would expect that we can subsequently remove the interface itself.

Changes in v2:

- address review comments from Christoph Hellwig
- split syscall removal into a separate patch
- replace __X32_COND_SYSCALL() with individual macros for x32

Arnd Bergmann (4):
  kexec: simplify compat_sys_kexec_load
  mm: simplify compat_sys_move_pages
  mm: simplify compat numa syscalls
  compat: remove some compat entry points

 arch/arm64/include/asm/unistd32.h         |  12 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl |  12 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl |  12 +-
 arch/parisc/kernel/syscalls/syscall.tbl   |  10 +-
 arch/powerpc/kernel/syscalls/syscall.tbl  |  12 +-
 arch/s390/kernel/syscalls/syscall.tbl     |  12 +-
 arch/sparc/kernel/syscalls/syscall.tbl    |  12 +-
 arch/x86/entry/syscall_x32.c              |   2 +
 arch/x86/entry/syscalls/syscall_32.tbl    |   6 +-
 arch/x86/entry/syscalls/syscall_64.tbl    |   4 +-
 include/linux/compat.h                    |  26 ---
 include/linux/kexec.h                     |   2 -
 include/uapi/asm-generic/unistd.h         |  12 +-
 kernel/kexec.c                            |  90 ++++------
 kernel/sys_ni.c                           |   5 -
 mm/mempolicy.c                            | 195 +++++-----------------
 mm/migrate.c                              |  50 +++---
 17 files changed, 155 insertions(+), 319 deletions(-)

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: kexec@lists.infradead.org
-- 
2.27.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
