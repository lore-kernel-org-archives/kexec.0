Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RsRfu-0001bk-4G
 for kexec@lists.infradead.org; Wed, 01 Feb 2012 04:20:04 +0000
Date: Wed, 1 Feb 2012 13:15:18 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] Fix segmentation fault for makedumpfile -x/--split
Message-Id: <20120201131518.7764c710.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120131102456.17966.37854.stgit@aruna-ThinkPad-T420>
References: <20120131102456.17966.37854.stgit@aruna-ThinkPad-T420>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: aruna@linux.vnet.ibm.com
Cc: tachibana@mxm.nes.nec.co.jp, kexec@lists.infradead.org

Hi Aruna,

On Tue, 31 Jan 2012 15:56:33 +0530
Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com> wrote:

> 
> The patch fixes the segmentation fault issue of makedumpfile when a
> user specifies an invalid file name with -x/--split option.
> The patch takes care of such a scenario by setting .find_debuginfo to
> a function pointer which returns -1 and throws error messages against
> invalid vmlinux file input. With a valid vmlinux file .find_debuginfo
> was never invoked since the absolute path of debuginfo was known by the
> time we call init_dwarf_info.
> 
> Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
> ---
>  dwarf_info.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)

Thank you for your patch.
I will review it.

Thanks
Atsushi Kumagai

> diff --git a/dwarf_info.c b/dwarf_info.c
> index 46dcd8e..515455d 100644
> --- a/dwarf_info.c
> +++ b/dwarf_info.c
> @@ -204,6 +204,16 @@ search_module_debuginfo(char *os_release)
>  	return FALSE;
>  }
>  
> +static int
> +dwarf_no_debuginfo_found(Dwfl_Module *mod, void **userdata,
> +			const char *modname, Dwarf_Addr base,
> +			const char *file_name,
> +			const char *debuglink_file, GElf_Word debuglink_crc,
> +			char **debuginfo_file_name)
> +{
> +	return -1;
> +}
> +
>  /*
>   * Initialize the dwarf info.
>   * Linux kernel module debuginfo are of ET_REL (relocatable) type.
> @@ -219,6 +229,21 @@ init_dwarf_info(void)
>  	int dwfl_fd = -1;
>  	static const Dwfl_Callbacks callbacks = {
>  		.section_address = dwfl_offline_section_address,
> +	/*
> +	 * By the time init_dwarf_info() function is called, we already
> +	 * know absolute path of debuginfo either resolved through
> +	 * search_module_debuginfo() call OR user specified vmlinux
> +	 * debuginfo through '-x' option. In which case .find_debuginfo
> +	 * callback is never invoked.
> +	 * But we can not deny a situation where user may pass invalid
> +	 * file name through '-x' option, where .find_debuginfo gets
> +	 * invoked to find a valid vmlinux debuginfo and hence we run
> +	 * into seg fault issue. Hence, set .find_debuginfo to a
> +	 * funtion pointer that returns -1 to avoid seg fault and let
> +	 * the makedumpfile throw error messages against the invalid
> +	 * vmlinux file input.
> +	 */
> +		.find_debuginfo  = dwarf_no_debuginfo_found
>  	};
>  
>  	dwarf_info.elfd = NULL;
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
