Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 8 Oct 2019 17:22:24 -0400
From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 1/2] Add support for arm64 to carry ima measurement
 log in kexec_file_load
Message-ID: <20191008212224.GC1396@sasha-vm>
References: <20191007185943.1828-1-prsriva@linux.microsoft.com>
 <20191007185943.1828-2-prsriva@linux.microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191007185943.1828-2-prsriva@linux.microsoft.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Prakhar Srivastava <prsriva@linux.microsoft.com>
Cc: mark.rutland@arm.com, jean-philippe@linaro.org, arnd@arndb.de, takahiro.akashi@linaro.org, sboyd@kernel.org, catalin.marinas@arm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, zohar@linux.ibm.com, bauerman@linux.ibm.com, yamada.masahiro@socionext.com, kristina.martsenko@arm.org, duwe@lst.de, allison@lohutok.net, james.morse@arm.org, linux-integrity@vger.kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org

On Mon, Oct 07, 2019 at 11:59:42AM -0700, Prakhar Srivastava wrote:
>During kexec_file_load, carrying forward the ima measurement log allows
>a verifying party to get the entire runtime event log since the last
>full reboot since that is when PCRs were last reset.
>
>Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>---
> arch/Kconfig                           |   6 +-
> arch/arm64/include/asm/ima.h           |  24 +++
> arch/arm64/include/asm/kexec.h         |   5 +
> arch/arm64/kernel/Makefile             |   3 +-
> arch/arm64/kernel/ima_kexec.c          |  78 ++++++++++
> arch/arm64/kernel/machine_kexec_file.c |   6 +
> drivers/of/Kconfig                     |   6 +
> drivers/of/Makefile                    |   1 +
> drivers/of/of_ima.c                    | 204 +++++++++++++++++++++++++
> include/linux/of.h                     |  31 ++++
> 10 files changed, 362 insertions(+), 2 deletions(-)
> create mode 100644 arch/arm64/include/asm/ima.h
> create mode 100644 arch/arm64/kernel/ima_kexec.c
> create mode 100644 drivers/of/of_ima.c
>
>diff --git a/arch/Kconfig b/arch/Kconfig
>index a7b57dd42c26..d53e1596c5b1 100644
>--- a/arch/Kconfig
>+++ b/arch/Kconfig
>@@ -19,7 +19,11 @@ config KEXEC_CORE
> 	bool
>
> config HAVE_IMA_KEXEC
>-	bool
>+	bool "Carry over IMA measurement log during kexec_file_load() syscall"
>+	depends on KEXEC_FILE
>+	help
>+	  Select this option to carry over IMA measurement log during
>+	  kexec_file_load.

This change looks very wrong: HAVE_* config symbols are used to indicate
the availability of certain arch specific capability, rather than act as
a config option. How does this work with CONFIG_IMA_KEXEC ?

Also, please, at the very least verify that basic functionality works on
the architectures we have access to. Trying it on x86:

$ make allmodconfig
scripts/kconfig/conf  --allmodconfig Kconfig
#
# No change to .config
#
$ make
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  CC      security/integrity/ima/ima_fs.o
In file included from security/integrity/ima/ima_fs.c:26:
security/integrity/ima/ima.h:28:10: fatal error: asm/ima.h: No such file or directory
 #include <asm/ima.h>
          ^~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.build:266: security/integrity/ima/ima_fs.o] Error 1
make[2]: *** [scripts/Makefile.build:509: security/integrity/ima] Error 2
make[1]: *** [scripts/Makefile.build:509: security/integrity] Error 2
make: *** [Makefile:1649: security] Error 2

--
Thanks,
Sasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
