Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UfWZe-0006rb-VN
 for kexec@lists.infradead.org; Thu, 23 May 2013 14:32:59 +0000
Date: Thu, 23 May 2013 10:32:29 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v8 7/9] vmcore: Allow user process to remap ELF note
 segment buffer
Message-ID: <20130523143229.GF2779@redhat.com>
References: <20130523052421.13864.83978.stgit@localhost6.localdomain6>
 <20130523052536.13864.67507.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130523052536.13864.67507.stgit@localhost6.localdomain6>
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
Cc: riel@redhat.com, hughd@google.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, linux-mm@kvack.org, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, kosaki.motohiro@jp.fujitsu.com, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, walken@google.com, cpw@sgi.com, jingbai.ma@hp.com

On Thu, May 23, 2013 at 02:25:36PM +0900, HATAYAMA Daisuke wrote:
> Now ELF note segment has been copied in the buffer on vmalloc
> memory. To allow user process to remap the ELF note segment buffer
> with remap_vmalloc_page, the corresponding VM area object has to have
> VM_USERMAP flag set.
> 
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>

Looks good to me.

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

> ---
> 
>  fs/proc/vmcore.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 937709d..9de4d91 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -375,6 +375,7 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
>  	Elf64_Ehdr *ehdr_ptr;
>  	Elf64_Phdr phdr;
>  	u64 phdr_sz = 0, note_off;
> +	struct vm_struct *vm;
>  
>  	ehdr_ptr = (Elf64_Ehdr *)elfptr;
>  
> @@ -391,6 +392,12 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
>  	if (!*notes_buf)
>  		return -ENOMEM;
>  
> +	/* Allow users to remap ELF note segment buffer on vmalloc
> +	 * memory using remap_vmalloc_range. */
> +	vm = find_vm_area(*notes_buf);
> +	BUG_ON(!vm);
> +	vm->flags |= VM_USERMAP;
> +
>  	rc = copy_notes_elf64(ehdr_ptr, *notes_buf);
>  	if (rc < 0)
>  		return rc;
> @@ -554,6 +561,7 @@ static int __init merge_note_headers_elf32(char *elfptr, size_t *elfsz,
>  	Elf32_Ehdr *ehdr_ptr;
>  	Elf32_Phdr phdr;
>  	u64 phdr_sz = 0, note_off;
> +	struct vm_struct *vm;
>  
>  	ehdr_ptr = (Elf32_Ehdr *)elfptr;
>  
> @@ -570,6 +578,12 @@ static int __init merge_note_headers_elf32(char *elfptr, size_t *elfsz,
>  	if (!*notes_buf)
>  		return -ENOMEM;
>  
> +	/* Allow users to remap ELF note segment buffer on vmalloc
> +	 * memory using remap_vmalloc_range. */
> +	vm = find_vm_area(*notes_buf);
> +	BUG_ON(!vm);
> +	vm->flags |= VM_USERMAP;
> +
>  	rc = copy_notes_elf32(ehdr_ptr, *notes_buf);
>  	if (rc < 0)
>  		return rc;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
