From: Baoquan He <bhe@redhat.com>
Date: Wed, 23 Feb 2022 11:25:11 +0800
Subject: [PATCH v4 02/10] crash hp: Introduce CRASH_HOTPLUG configuration
 options
In-Reply-To: <20220209195706.51522-3-eric.devolder@oracle.com>
References: <20220209195706.51522-1-eric.devolder@oracle.com>
 <20220209195706.51522-3-eric.devolder@oracle.com>
Message-ID: <YhWpF/Cj/V+Cx6+d@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 02/09/22 at 02:56pm, Eric DeVolder wrote:
> Support for CPU and memory hotplug for crash is controlled by the
> CRASH_HOTPLUG configuration option, introduced by this patch.
> 
> The CRASH_HOTPLUG_ELFCOREHDR_SZ related configuration option is
> also introduced with this patch.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  arch/x86/Kconfig | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index ebe8fc76949a..4e3374edab02 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2060,6 +2060,32 @@ config CRASH_DUMP
>  	  (CONFIG_RELOCATABLE=y).
>  	  For more details see Documentation/admin-guide/kdump/kdump.rst
>  
> +config CRASH_HOTPLUG
> +	bool "kernel updates of crash elfcorehdr"
> +	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG) && KEXEC_FILE
> +	help
> +	  Enable the kernel to update the crash elfcorehdr (which contains
> +	  the list of CPUs and memory regions) directly when hot plug/unplug
> +	  of CPUs or memory. Otherwise userspace must monitor these hot
> +	  plug/unplug change notifications via udev in order to
> +	  unload-then-reload the crash kernel so that the list of CPUs and
> +	  memory regions is kept up-to-date. Note that the udev CPU and
> +	  memory change notifications still occur (however, userspace is not
> +	  required to monitor for crash dump purposes).
> +
> +config CRASH_HOTPLUG_ELFCOREHDR_SZ
> +	depends on CRASH_HOTPLUG
> +	int
> +	default 131072
> +	help
> +	  Specify the maximum size of the elfcorehdr buffer/segment.
> +	  The 128KiB default is sized so that it can accommodate 2048
> +	  Elf64_Phdr, where each Phdr represents either a CPU or a
> +	  region of memory.
> +	  For example, this size can accommodate hotplugging a machine
> +	  with up to 1024 CPUs and up to 1024 memory regions (e.g. 1TiB
> +	  with 1024 1GiB memory DIMMs).

This example of memory could be a little misleading. The memory regions
may not be related to memory DIMMs. System could split them into many
smaller regions during bootup.

Otherwise, this patch looks good to me.

> +
>  config KEXEC_JUMP
>  	bool "kexec jump"
>  	depends on KEXEC && HIBERNATION
> -- 
> 2.27.0
> 


