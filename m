Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UfWbE-0006yy-1N
 for kexec@lists.infradead.org; Thu, 23 May 2013 14:34:37 +0000
Date: Thu, 23 May 2013 10:34:05 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v8 8/9] vmcore: calculate vmcore file size from buffer
 size and total size of vmcore objects
Message-ID: <20130523143405.GG2779@redhat.com>
References: <20130523052421.13864.83978.stgit@localhost6.localdomain6>
 <20130523052542.13864.67902.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130523052542.13864.67902.stgit@localhost6.localdomain6>
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

On Thu, May 23, 2013 at 02:25:42PM +0900, HATAYAMA Daisuke wrote:
> The previous patches newly added holes before each chunk of memory and
> the holes need to be count in vmcore file size. There are two ways to
> count file size in such a way:
> 
> 1) supporse m as a poitner to the last vmcore object in vmcore_list.
> , then file size is (m->offset + m->size), or
> 
> 2) calculate sum of size of buffers for ELF header, program headers,
> ELF note segments and objects in vmcore_list.
> 
> Although 1) is more direct and simpler than 2), 2) seems better in
> that it reflects internal object structure of /proc/vmcore. Thus, this
> patch changes get_vmcore_size_elf{64, 32} so that it calculates size
> in the way of 2).
> 
> As a result, both get_vmcore_size_elf{64, 32} have the same
> definition. Merge them as get_vmcore_size.
> 
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>

Looks good to me.

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

> ---
> 
>  fs/proc/vmcore.c |   44 +++++++++++---------------------------------
>  1 files changed, 11 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 9de4d91..f71157d 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -210,36 +210,15 @@ static struct vmcore* __init get_new_element(void)
>  	return kzalloc(sizeof(struct vmcore), GFP_KERNEL);
>  }
>  
> -static u64 __init get_vmcore_size_elf64(char *elfptr, size_t elfsz)
> +static u64 __init get_vmcore_size(size_t elfsz, size_t elfnotesegsz,
> +				  struct list_head *vc_list)
>  {
> -	int i;
>  	u64 size;
> -	Elf64_Ehdr *ehdr_ptr;
> -	Elf64_Phdr *phdr_ptr;
> -
> -	ehdr_ptr = (Elf64_Ehdr *)elfptr;
> -	phdr_ptr = (Elf64_Phdr*)(elfptr + sizeof(Elf64_Ehdr));
> -	size = elfsz;
> -	for (i = 0; i < ehdr_ptr->e_phnum; i++) {
> -		size += phdr_ptr->p_memsz;
> -		phdr_ptr++;
> -	}
> -	return size;
> -}
> -
> -static u64 __init get_vmcore_size_elf32(char *elfptr, size_t elfsz)
> -{
> -	int i;
> -	u64 size;
> -	Elf32_Ehdr *ehdr_ptr;
> -	Elf32_Phdr *phdr_ptr;
> +	struct vmcore *m;
>  
> -	ehdr_ptr = (Elf32_Ehdr *)elfptr;
> -	phdr_ptr = (Elf32_Phdr*)(elfptr + sizeof(Elf32_Ehdr));
> -	size = elfsz;
> -	for (i = 0; i < ehdr_ptr->e_phnum; i++) {
> -		size += phdr_ptr->p_memsz;
> -		phdr_ptr++;
> +	size = elfsz + elfnotesegsz;
> +	list_for_each_entry(m, vc_list, list) {
> +		size += m->size;
>  	}
>  	return size;
>  }
> @@ -863,20 +842,19 @@ static int __init parse_crash_elf_headers(void)
>  		rc = parse_crash_elf64_headers();
>  		if (rc)
>  			return rc;
> -
> -		/* Determine vmcore size. */
> -		vmcore_size = get_vmcore_size_elf64(elfcorebuf, elfcorebuf_sz);
>  	} else if (e_ident[EI_CLASS] == ELFCLASS32) {
>  		rc = parse_crash_elf32_headers();
>  		if (rc)
>  			return rc;
> -
> -		/* Determine vmcore size. */
> -		vmcore_size = get_vmcore_size_elf32(elfcorebuf, elfcorebuf_sz);
>  	} else {
>  		pr_warn("Warning: Core image elf header is not sane\n");
>  		return -EINVAL;
>  	}
> +
> +	/* Determine vmcore size. */
> +	vmcore_size = get_vmcore_size(elfcorebuf_sz, elfnotes_sz,
> +				      &vmcore_list);
> +
>  	return 0;
>  }
>  

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
