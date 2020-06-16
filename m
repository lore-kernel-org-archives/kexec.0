Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from linux.microsoft.com ([13.77.154.182])
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlFIG-0002Yx-Fa
 for kexec@lists.infradead.org; Tue, 16 Jun 2020 17:22:42 +0000
Date: Tue, 16 Jun 2020 12:22:35 -0500
From: Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: Re: [PATCH v2][RFC] kdump: append kernel build-id string to VMCOREINFO
Message-ID: <20200616172235.GB1409697@sequoia>
References: <1591849672-34104-1-git-send-email-vijayb@linux.microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1591849672-34104-1-git-send-email-vijayb@linux.microsoft.com>
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
To: Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On 2020-06-10 21:27:52, Vijay Balakrishna wrote:
> Make kernel GNU build-id available in VMCOREINFO.  Having
> build-id in VMCOREINFO facilitates presenting appropriate kernel
> namelist image with debug information file to kernel crash dump
> analysis tools.  Currently VMCOREINFO lacks uniquely identifiable
> key for crash analysis automation.
> 
> Regarding if this patch is necessary or matching of linux_banner
> and OSRELEASE in VMCOREINFO employed by crash(8) meets the
> need -- IMO, build-id approach more foolproof, in most instances it
> is a cryptographic hash generated using internal code/ELF bits unlike
> kernel version string upon which linux_banner is based that is
> external to the code.  I feel each is intended for a different purpose.
> Also OSRELEASE is not suitable when two different kernel builds
> from same version with different features enabled.
> 
> Currently for most linux (and non-linux) systems build-id can be
> extracted using standard methods for file types such as user mode crash
> dumps, shared libraries, loadable kernel modules etc.,  This is an
> exception for linux kernel dump.  Having build-id in VMCOREINFO brings
> some uniformity for automation tools.
> 
> Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>

I think this is a nice improvement over today's linux_banner approach
for correlating vmlinux to a kernel dump.

The elf notes parsing in this patch lines up with what is described in
in the "Notes (Nhdr)" section of the elf(5) man page.

BUILD_ID_MAX is sufficient to hold a sha1 build-id, which is the default
build-id type today in GNU ld(2). It is also sufficient to hold the
"fast" build-id, which is the default build-id type today in LLVM
lld(2).

Therefore,

 Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Thanks!

Tyler

> ---
> Changes since v2:
> -----------------
> - v1 was sent out as a single patch which can be seen here:
>   http://lists.infradead.org/pipermail/kexec/2020-June/025202.html
> - moved justification to commit commit log
> - renamed 'g_build_id' to 'note_sec'
> - fixed format specifier in pr_warn() from '%lu' to '%u' (failed to
>   catch warning in v1)
> 
>  include/linux/crash_core.h |  6 +++++
>  kernel/crash_core.c        | 50 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 525510a9f965..6594dbc34a37 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -38,6 +38,8 @@ phys_addr_t paddr_vmcoreinfo_note(void);
>  
>  #define VMCOREINFO_OSRELEASE(value) \
>  	vmcoreinfo_append_str("OSRELEASE=%s\n", value)
> +#define VMCOREINFO_BUILD_ID(value) \
> +	vmcoreinfo_append_str("BUILD-ID=%s\n", value)
>  #define VMCOREINFO_PAGESIZE(value) \
>  	vmcoreinfo_append_str("PAGESIZE=%ld\n", value)
>  #define VMCOREINFO_SYMBOL(name) \
> @@ -64,6 +66,10 @@ extern unsigned char *vmcoreinfo_data;
>  extern size_t vmcoreinfo_size;
>  extern u32 *vmcoreinfo_note;
>  
> +/* raw contents of kernel .notes section */
> +extern const void __start_notes __weak;
> +extern const void __stop_notes __weak;
> +
>  Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>  			  void *data, size_t data_len);
>  void final_note(Elf_Word *buf);
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 9f1557b98468..64ac359cd17e 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -11,6 +11,8 @@
>  #include <asm/page.h>
>  #include <asm/sections.h>
>  
> +#include <crypto/sha.h>
> +
>  /* vmcoreinfo stuff */
>  unsigned char *vmcoreinfo_data;
>  size_t vmcoreinfo_size;
> @@ -376,6 +378,53 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
>  }
>  EXPORT_SYMBOL(paddr_vmcoreinfo_note);
>  
> +#define NOTES_SIZE (&__stop_notes - &__start_notes)
> +#define BUILD_ID_MAX SHA1_DIGEST_SIZE
> +#define NT_GNU_BUILD_ID 3
> +
> +struct elf_note_section {
> +	struct elf_note	n_hdr;
> +	u8 n_data[];
> +};
> +
> +/*
> + * Add build ID from .notes section as generated by the GNU ld(1)
> + * or LLVM lld(1) --build-id option.
> + */
> +static void add_build_id_vmcoreinfo(void)
> +{
> +	char build_id[BUILD_ID_MAX * 2 + 1];
> +	int n_remain = NOTES_SIZE;
> +
> +	while (n_remain >= sizeof(struct elf_note)) {
> +		const struct elf_note_section *note_sec =
> +			&__start_notes + NOTES_SIZE - n_remain;
> +		const u32 n_namesz = note_sec->n_hdr.n_namesz;
> +
> +		if (note_sec->n_hdr.n_type == NT_GNU_BUILD_ID &&
> +		    n_namesz != 0 &&
> +		    !strcmp((char *)&note_sec->n_data[0], "GNU")) {
> +			if (note_sec->n_hdr.n_descsz <= BUILD_ID_MAX) {
> +				const u32 n_descsz = note_sec->n_hdr.n_descsz;
> +				const u8 *s = &note_sec->n_data[n_namesz];
> +
> +				s = PTR_ALIGN(s, 4);
> +				bin2hex(build_id, s, n_descsz);
> +				build_id[2 * n_descsz] = '\0';
> +				VMCOREINFO_BUILD_ID(build_id);
> +				return;
> +			}
> +			pr_warn("Build ID is too large to include in vmcoreinfo: %u > %u\n",
> +				note_sec->n_hdr.n_descsz,
> +				BUILD_ID_MAX);
> +			return;
> +		}
> +		n_remain -= sizeof(struct elf_note) +
> +			ALIGN(note_sec->n_hdr.n_namesz, 4) +
> +			ALIGN(note_sec->n_hdr.n_descsz, 4);
> +	}
> +}
> +
>  static int __init crash_save_vmcoreinfo_init(void)
>  {
>  	vmcoreinfo_data = (unsigned char *)get_zeroed_page(GFP_KERNEL);
> @@ -394,6 +443,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	}
>  
>  	VMCOREINFO_OSRELEASE(init_uts_ns.name.release);
> +	add_build_id_vmcoreinfo();
>  	VMCOREINFO_PAGESIZE(PAGE_SIZE);
>  
>  	VMCOREINFO_SYMBOL(init_uts_ns);
> -- 
> 2.26.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
