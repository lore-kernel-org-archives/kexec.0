From: Mimi Zohar <zohar@linux.ibm.com>
Date: Sun, 13 Feb 2022 21:59:57 -0500
Subject: [PATCH v5 2/6] powerpc/kexec_file: Add KEXEC_SIG support.
In-Reply-To: <d95f7c6865bcad5ee37dcbec240e79aa742f5e1d.1641900831.git.msuchanek@suse.de>
References: <cover.1641900831.git.msuchanek@suse.de>
 <d95f7c6865bcad5ee37dcbec240e79aa742f5e1d.1641900831.git.msuchanek@suse.de>
Message-ID: <cff97dbe262919ff709a5ad2c4af6a702cc72a95.camel@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Michal,

On Tue, 2022-01-11 at 12:37 +0100, Michal Suchanek wrote:
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index dea74d7717c0..1cde9b6c5987 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -560,6 +560,22 @@ config KEXEC_FILE
>  config ARCH_HAS_KEXEC_PURGATORY
>         def_bool KEXEC_FILE
>  
> +config KEXEC_SIG
> +       bool "Verify kernel signature during kexec_file_load() syscall"
> +       depends on KEXEC_FILE && MODULE_SIG_FORMAT
> +       help
> +         This option makes kernel signature verification mandatory for
> +         the kexec_file_load() syscall.

When KEXEC_SIG is enabled on other architectures, IMA does not define a
kexec 'appraise' policy rule.  Refer to the policy rules in
security/ima/ima_efi.c.  Similarly the kexec 'appraise' policy rule in
arch/powerpc/kernel/ima_policy.c should not be defined.

-- 
thanks,

Mimi


