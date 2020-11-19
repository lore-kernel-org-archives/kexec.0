Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH 1/1] kernel/crash_core.c - Add crashkernel=auto for x86
 and ARM
References: <20201118232431.21832-1-saeed.mirzamohammadi@oracle.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7f9e6b63-1727-379b-55b7-9ad2bbdb2e5b@infradead.org>
Date: Wed, 18 Nov 2020 17:06:40 -0800
MIME-Version: 1.0
In-Reply-To: <20201118232431.21832-1-saeed.mirzamohammadi@oracle.com>
Content-Language: en-US
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
To: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, Anson Huang <Anson.Huang@nxp.com>, Jonathan Corbet <corbet@lwn.net>, x86@kernel.org, Michael Walle <michael@walle.cc>, Krzysztof Kozlowski <krzk@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, john.p.donnelly@oracle.com, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Li Yang <leoyang.li@nxp.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Vinod Koul <vkoul@kernel.org>, =?UTF-8?Q?Diego_Elio_Petten=c3=b2?= <flameeyes@flameeyes.com>, Olof Johansson <olof@lixom.net>, Shawn Guo <shawnguo@kernel.org>

Hi,

On 11/18/20 3:24 PM, Saeed Mirzamohammadi wrote:
> This adds crashkernel=auto feature to configure reserved memory for
> vmcore creation to both x86 and ARM platforms based on the total memory
> size.
> 
> Cc: stable@vger.kernel.org

why?

> Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
> Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
> ---
>  Documentation/admin-guide/kdump/kdump.rst |  5 +++++
>  arch/arm64/Kconfig                        | 26 ++++++++++++++++++++++-
>  arch/arm64/configs/defconfig              |  1 +
>  arch/x86/Kconfig                          | 26 ++++++++++++++++++++++-
>  arch/x86/configs/x86_64_defconfig         |  1 +
>  kernel/crash_core.c                       | 20 +++++++++++++++--
>  6 files changed, 75 insertions(+), 4 deletions(-)
> 

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1515f6f153a0..d359dcffa80e 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig

> @@ -1135,6 +1135,30 @@ config CRASH_DUMP
>  
>  	  For more details see Documentation/admin-guide/kdump/kdump.rst
>  
> +if CRASH_DUMP
> +
> +config CRASH_AUTO_STR
> +        string "Memory reserved for crash kernel"

use tab instead of spaces above.

> +	depends on CRASH_DUMP
> +        default "1G-64G:128M,64G-1T:256M,1T-:512M"

ditto.

> +	help
> +	  This configures the reserved memory dependent
> +	  on the value of System RAM. The syntax is:
> +	  crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
> +	              range=start-[end]
> +
> +	  For example:
> +	      crashkernel=512M-2G:64M,2G-:128M
> +
> +	  This would mean:
> +
> +	      1) if the RAM is smaller than 512M, then don't reserve anything
> +	         (this is the "rescue" case)
> +	      2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
> +	      3) if the RAM size is larger than 2G, then reserve 128M
> +
> +endif # CRASH_DUMP
> +
>  config XEN_DOM0
>  	def_bool y
>  	depends on XEN

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index f6946b81f74a..bacd17312bb1 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig

> @@ -2049,6 +2049,30 @@ config CRASH_DUMP
>  	  (CONFIG_RELOCATABLE=y).
>  	  For more details see Documentation/admin-guide/kdump/kdump.rst
>  
> +if CRASH_DUMP
> +
> +config CRASH_AUTO_STR
> +        string "Memory reserved for crash kernel" if X86_64

ditto.

> +	depends on CRASH_DUMP
> +        default "1G-64G:128M,64G-1T:256M,1T-:512M"

ditto.

> +	help
> +	  This configures the reserved memory dependent
> +	  on the value of System RAM. The syntax is:
> +	  crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
> +	              range=start-[end]
> +
> +	  For example:
> +	      crashkernel=512M-2G:64M,2G-:128M
> +
> +	  This would mean:
> +
> +	      1) if the RAM is smaller than 512M, then don't reserve anything
> +	         (this is the "rescue" case)
> +	      2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
> +	      3) if the RAM size is larger than 2G, then reserve 128M
> +
> +endif # CRASH_DUMP
> +
>  config KEXEC_JUMP
>  	bool "kexec jump"
>  	depends on KEXEC && HIBERNATION

> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 106e4500fd53..a44cd9cc12c4 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -7,6 +7,7 @@
>  #include <linux/crash_core.h>
>  #include <linux/utsname.h>
>  #include <linux/vmalloc.h>
> +#include <linux/kexec.h>
>  
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -41,6 +42,15 @@ static int __init parse_crashkernel_mem(char *cmdline,
>  					unsigned long long *crash_base)
>  {
>  	char *cur = cmdline, *tmp;
> +	unsigned long long total_mem = system_ram;
> +
> +	/*
> +	 * Firmware sometimes reserves some memory regions for it's own use.

	                                                       its

> +	 * so we get less than actual system memory size.
> +	 * Workaround this by round up the total size to 128M which is
> +	 * enough for most test cases.
> +	 */
> +	total_mem = roundup(total_mem, SZ_128M);


thanks.
-- 
~Randy


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
