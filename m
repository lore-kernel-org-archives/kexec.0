Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UcHH4-0001ee-Dj
 for kexec@lists.infradead.org; Tue, 14 May 2013 15:36:23 +0000
Date: Tue, 14 May 2013 11:35:52 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v5 5/8] vmcore: allocate ELF note segment in the 2nd
 kernel vmalloc memory
Message-ID: <20130514153552.GG13674@redhat.com>
References: <20130514015622.18697.77191.stgit@localhost6.localdomain6>
 <20130514015734.18697.32447.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130514015734.18697.32447.stgit@localhost6.localdomain6>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, linux-mm@kvack.org, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, cpw@sgi.com, jingbai.ma@hp.com

On Tue, May 14, 2013 at 10:57:35AM +0900, HATAYAMA Daisuke wrote:
> The reasons why we don't allocate ELF note segment in the 1st kernel
> (old memory) on page boundary is to keep backward compatibility for
> old kernels, and that if doing so, we waste not a little memory due to
> round-up operation to fit the memory to page boundary since most of
> the buffers are in per-cpu area.
> 
> ELF notes are per-cpu, so total size of ELF note segments depends on
> number of CPUs. The current maximum number of CPUs on x86_64 is 5192,
> and there's already system with 4192 CPUs in SGI, where total size
> amounts to 1MB. This can be larger in the near future or possibly even
> now on another architecture that has larger size of note per a single
> cpu. Thus, to avoid the case where memory allocation for large block
> fails, we allocate vmcore objects on vmalloc memory.
> 
> This patch adds elfnotesegbuf and elfnotesegbuf_sz variables to keep
> pointer to the ELF note segment buffer and its size. There's no longer
> the vmcore object that corresponds to the ELF note segment in
> vmcore_list. Accordingly, read_vmcore() has new case for ELF note
> segment and set_vmcore_list_offsets_elf{64,32}() and other helper
> functions starts calculating offset from sum of size of ELF headers
> and size of ELF note segment.
> 
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> ---
> 
>  fs/proc/vmcore.c |  225 ++++++++++++++++++++++++++++++++++++++++--------------
>  1 files changed, 165 insertions(+), 60 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 48886e6..795efd2 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -34,6 +34,9 @@ static char *elfcorebuf;
>  static size_t elfcorebuf_sz;
>  static size_t elfcorebuf_sz_orig;
>  
> +static char *elfnotesegbuf;
> +static size_t elfnotesegbuf_sz;

How about calling these just elfnotes_buf and elfnotes_sz.

[..]
> +/* Merges all the PT_NOTE headers into one. */
> +static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
> +					   char **notesegptr, size_t *notesegsz,
> +					   struct list_head *vc_list)
> +{
> +	int i, nr_ptnote=0, rc=0;
> +	char *tmp;
> +	Elf64_Ehdr *ehdr_ptr;
> +	Elf64_Phdr phdr;
> +	u64 phdr_sz = 0, note_off;
> +	struct vm_struct *vm;
> +
> +	ehdr_ptr = (Elf64_Ehdr *)elfptr;
> +
> +	/* The first path calculates the number of PT_NOTE entries and
> +	 * total size of ELF note segment. */
> +	rc = process_note_headers_elf64(ehdr_ptr, &nr_ptnote, &phdr_sz, NULL);
> +	if (rc < 0)
> +		return rc;
> +
> +	*notesegsz = roundup(phdr_sz, PAGE_SIZE);
> +	*notesegptr = vzalloc(*notesegsz);
> +	if (!*notesegptr)
> +		return -ENOMEM;
> +
> +	vm = find_vm_area(*notesegptr);
> +	BUG_ON(!vm);
> +	vm->flags |= VM_USERMAP;
> +
> +	/* The second path copies the ELF note segment in the ELF note
> +	 * segment buffer. */
> +	rc = process_note_headers_elf64(ehdr_ptr, NULL, NULL, *notesegptr);

So same function process_note_headers_elf64() is doing two different
things based on parameters passed. Please create two new functions
to do two different things and name these appropriately.

Say

get_elf_note_number_and_size()
copy_elf_notes()


> +	if (rc < 0)
> +		return rc;
> +
>  	/* Prepare merged PT_NOTE program header. */
>  	phdr.p_type    = PT_NOTE;
>  	phdr.p_flags   = 0;
> @@ -304,23 +364,18 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
>  	return 0;
>  }
>  
> -/* Merges all the PT_NOTE headers into one. */
> -static int __init merge_note_headers_elf32(char *elfptr, size_t *elfsz,
> -						struct list_head *vc_list)
> +static int __init process_note_headers_elf32(const Elf32_Ehdr *ehdr_ptr,
> +					     int *nr_ptnotep, u64 *phdr_szp,
> +					     char *notesegp)

Can you please describe function parameters at the beginning of function
in a comment. Things are gettting little confusing now.

What does notesegp signify? phdr_szp could be simply *phdr_sz,
nr_ptnotesp could be *nr_notes. Please simplify the naming a bit.
Seems too twisted to me.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
