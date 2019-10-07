Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Prakhar Srivastava <prsriva@linux.microsoft.com>
Subject: [PATCH v2 0/2] Add support to carry ima measurement log in
 kexec_file_load
Date: Mon,  7 Oct 2019 11:59:41 -0700
Message-Id: <20191007185943.1828-1-prsriva@linux.microsoft.com>
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
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: mark.rutland@arm.com, jean-philippe@linaro.org, arnd@arndb.de, takahiro.akashi@linaro.org, sboyd@kernel.org, catalin.marinas@arm.com, zohar@linux.ibm.com, yamada.masahiro@socionext.com, kristina.martsenko@arm.org, duwe@lst.de, bauerman@linux.ibm.com, james.morse@arm.org, tglx@linutronix.de, allison@lohutok.net

Add support to carry ima measurement log
to the next kexec'ed session triggered via kexec_file_load.
- Top of Linux 5.3-rc6

Currently during kexec the kernel file signatures are/can be validated
prior to actual load, the information(PE/ima signature) is not carried
to the next session. This lead to loss of information.

Carrying forward the ima measurement log to the next kexec'ed session 
allows a verifying party to get the entire runtime event log since the
last full reboot, since that is when PCRs were last reset.

Tested for arm64 qemu and real hardware.

I have not been unable to test the patch for powerpc 64bit. Any testing
is greatly appretiated.

TODO: Add support for 32 bit in the of_ima.c

Changelog:

v2:
  - move common code to drivers/of/of_ima.c.
  - point arm64 to use of_ima implementation.
  - point powerpc to use of_ima implementation

v1:
  - add new fdt porperties to mark start and end for ima measurement
    log.
  - use fdt_* functions to add/remove fdt properties and memory
    allocations.
  - remove additional check for endian-ness as they are checked
    in fdt_* functions.

v0:
  - Add support to carry ima measurement log in arm64, 
   uses same code as powerpc.
Prakhar Srivastava (2):
  Add support for arm64 to carry ima measurement log in kexec_file_load
  update powerpc implementation to call into of_ima*

 arch/Kconfig                           |   6 +-
 arch/arm64/include/asm/ima.h           |  24 +++
 arch/arm64/include/asm/kexec.h         |   5 +
 arch/arm64/kernel/Makefile             |   3 +-
 arch/arm64/kernel/ima_kexec.c          |  78 ++++++++++
 arch/arm64/kernel/machine_kexec_file.c |   6 +
 arch/powerpc/include/asm/ima.h         |   6 -
 arch/powerpc/kernel/Makefile           |   8 +-
 arch/powerpc/kernel/ima_kexec.c        | 170 ++-------------------
 drivers/of/Kconfig                     |   6 +
 drivers/of/Makefile                    |   1 +
 drivers/of/of_ima.c                    | 204 +++++++++++++++++++++++++
 include/linux/of.h                     |  31 ++++
 13 files changed, 378 insertions(+), 170 deletions(-)
 create mode 100644 arch/arm64/include/asm/ima.h
 create mode 100644 arch/arm64/kernel/ima_kexec.c
 create mode 100644 drivers/of/of_ima.c

-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
