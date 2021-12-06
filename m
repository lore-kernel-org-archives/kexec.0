Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Jisheng Zhang <jszhang@kernel.org>
Subject: [PATCH v2 0/5] kexec: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of
 #ifdef
Date: Tue,  7 Dec 2021 00:05:09 +0800
Message-Id: <20211206160514.2000-1-jszhang@kernel.org>
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
To: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, hpa@zytor.com, Eric Biederman <ebiederm@xmission.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, kexec@lists.infradead.org, Alexandre ghiti <alex@ghiti.fr>

Replace the conditional compilation using "#ifdef CONFIG_KEXEC_CORE"
by a check for "IS_ENABLED(CONFIG_KEXEC_CORE)", to simplify the code
and increase compile coverage.

I only modify x86, arm, arm64 and riscv, other architectures such as
sh, powerpc and s390 are better to be kept kexec code as-is so they
are not touched.

Since v1:
 - collect Reviewed-by tag
 - fix misleading commit msg.

Jisheng Zhang (5):
  kexec: make crashk_res, crashk_low_res and crash_notes symbols always
    visible
  riscv: mm: init: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef
  x86/setup: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef
  arm64: mm: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef
  arm: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef

 arch/arm/kernel/setup.c |  7 +++----
 arch/arm64/mm/init.c    |  9 +++------
 arch/riscv/mm/init.c    |  6 ++----
 arch/x86/kernel/setup.c | 10 +++-------
 include/linux/kexec.h   | 12 ++++++------
 5 files changed, 17 insertions(+), 27 deletions(-)

-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
