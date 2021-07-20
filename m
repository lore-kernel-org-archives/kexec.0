Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v4 0/4] compat: remove compat_alloc_user_space callers
Date: Tue, 20 Jul 2021 17:09:46 +0200
Message-Id: <20210720150950.3669610-1-arnd@kernel.org>
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
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>, Eric Biederman <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

Going through compat_alloc_user_space() to convert indirect system call
arguments tends to add complexity compared to handling the native and
compat logic in the same code.

The drivers/media portion of the longer series is already merged,
and I just resubmitted the net/core and drivers/net portions, so this
is the last main bit.

       Arnd
---

Changes in v4:

- Rebase to v5.14-rc2
- Replace the kexec patch with a version based on Eric Biederman's
  prototype

Changes in v3:

- fix whitespace as pointed out by Christoph Hellwig
- minor build fixes
- rebase to v5.13-rc1

Link: https://lore.kernel.org/lkml/20210517203343.3941777-1-arnd@kernel.org/

Changes in v2:

- address review comments from Christoph Hellwig
- split syscall removal into a separate patch
- replace __X32_COND_SYSCALL() with individual macros for x32

Link: https://lore.kernel.org/lkml/20201208150614.GA15765@infradead.org/

Arnd Bergmann (4):
  kexec: avoid compat_alloc_user_space
  mm: simplify compat_sys_move_pages
  mm: simplify compat numa syscalls
  compat: remove some compat entry points

 arch/arm64/include/asm/unistd32.h         |  10 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl |  10 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl |  10 +-
 arch/parisc/kernel/syscalls/syscall.tbl   |   8 +-
 arch/powerpc/kernel/syscalls/syscall.tbl  |  10 +-
 arch/s390/kernel/syscalls/syscall.tbl     |  10 +-
 arch/sparc/kernel/syscalls/syscall.tbl    |  10 +-
 arch/x86/entry/syscalls/syscall_32.tbl    |   4 +-
 arch/x86/entry/syscalls/syscall_64.tbl    |   2 +-
 include/linux/compat.h                    |  37 +---
 include/uapi/asm-generic/unistd.h         |  10 +-
 kernel/kexec.c                            | 116 ++++++-------
 kernel/sys_ni.c                           |   5 -
 mm/mempolicy.c                            | 196 +++++-----------------
 mm/migrate.c                              |  50 +++---
 15 files changed, 182 insertions(+), 306 deletions(-)

-- 
2.29.2

Cc: Christoph Hellwig <hch@infradead.org>
Cc: linux-arch <linux-arch@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: linux-kernel@vger.kernel.org
Cc: Linux-MM <linux-mm@kvack.org>
Cc: kexec@lists.infradead.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
