Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH 0/2] kdump: simplify code
Date: Fri, 10 Dec 2021 21:35:59 +0800
Message-Id: <1639143361-17773-1-git-send-email-yangtiezhu@loongson.cn>
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
To: Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, x86@kernel.org, linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Tiezhu Yang (2):
  kdump: vmcore: move copy_to() from vmcore.c to uaccess.h
  kdump: crashdump: use copy_to() to simplify the related code

 arch/arm/kernel/crash_dump.c     | 10 ++--------
 arch/arm64/kernel/crash_dump.c   | 10 ++--------
 arch/ia64/kernel/crash_dump.c    | 10 ++++------
 arch/mips/kernel/crash_dump.c    |  9 ++-------
 arch/powerpc/kernel/crash_dump.c |  7 ++-----
 arch/riscv/kernel/crash_dump.c   |  9 ++-------
 arch/sh/kernel/crash_dump.c      |  9 ++-------
 arch/x86/kernel/crash_dump_32.c  |  9 ++-------
 arch/x86/kernel/crash_dump_64.c  |  9 ++-------
 fs/proc/vmcore.c                 | 14 --------------
 include/linux/uaccess.h          | 14 ++++++++++++++
 11 files changed, 34 insertions(+), 76 deletions(-)

-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
