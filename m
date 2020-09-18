Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/4] syscalls: remove compat_alloc_user_space callers
Date: Fri, 18 Sep 2020 15:24:35 +0200
Message-Id: <20200918132439.1475479-1-arnd@arndb.de>
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
To: Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org

Going through compat_alloc_user_space() to convert indirect system call
arguments tends to add complexity compared to handling the native and
compat logic in the same code.

I have patches for all other uses of compat_alloc_user_space() as well,
and would expect that we can subsequently remove the interface itself.

      Arnd

Arnd Bergmann (4):
  x86: add __X32_COND_SYSCALL() macro
  kexec: remove compat_sys_kexec_load syscall
  mm: remove compat_sys_move_pages
  mm: remove compat numa syscalls

 arch/arm64/include/asm/unistd32.h         |  12 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl |  12 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl |  12 +-
 arch/parisc/kernel/syscalls/syscall.tbl   |  10 +-
 arch/powerpc/kernel/syscalls/syscall.tbl  |  12 +-
 arch/s390/kernel/syscalls/syscall.tbl     |  12 +-
 arch/sparc/kernel/syscalls/syscall.tbl    |  12 +-
 arch/x86/entry/syscalls/syscall_32.tbl    |   6 +-
 arch/x86/entry/syscalls/syscall_64.tbl    |   4 +-
 arch/x86/include/asm/syscall_wrapper.h    |   5 +
 include/linux/compat.h                    |  26 ---
 include/uapi/asm-generic/unistd.h         |  12 +-
 kernel/kexec.c                            |  77 +++------
 kernel/sys_ni.c                           |   5 -
 mm/mempolicy.c                            | 193 +++++-----------------
 mm/migrate.c                              |  45 +++--
 16 files changed, 143 insertions(+), 312 deletions(-)

-- 
2.27.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
