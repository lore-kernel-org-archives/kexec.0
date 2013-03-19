Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UI4ZH-0007DP-SZ
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 21:59:40 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
 <20130316040104.15064.57180.stgit@localhost6.localdomain6>
Date: Tue, 19 Mar 2013 14:59:31 -0700
In-Reply-To: <20130316040104.15064.57180.stgit@localhost6.localdomain6>
 (HATAYAMA Daisuke's message of "Sat, 16 Mar 2013 13:01:04 +0900")
Message-ID: <87wqt3m4os.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 03/21] vmcore: rearrange program headers without
 assuming consequtive PT_NOTE entries
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, cpw@sgi.com, vgoyal@redhat.com

HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> writes:

> Current code assumes all PT_NOTE headers are placed at the beginning
> of program header table and they are consequtive. But the assumption
> could be broken by future changes on either kexec-tools or the 1st
> kernel. This patch removes the assumption and rearranges program
> headers as the following conditions are satisfied:
>
> - PT_NOTE entry is unique at the first entry,
>
> - the order of program headers are unchanged during this
>   rearrangement, only their positions are changed in positive
>   direction.
>
> - unused part that occurs in the bottom of program headers are filled
>   with 0.
>
> Also, this patch adds one exceptional case where the number of PT_NOTE
> entries is somehow 0. Then, immediately go out of the function.

This patch looks like you have really overthought this part of the code.
You are adding a fair amount of complexity for very little gain.

To clean this up I would recommend two buffers.  A temporary buffer
for the program headers read out of oldmem, and a longer lived
buffer where you generate the new headers into.  Then the scary
memmove and the assumptions about location in the PT_LOAD chain
can be removed without having to do fancy hard to follow multi-pass
code.

If the result isn't going to be clean and easy to follow we might as
well deem the requirements of the existing code an ABI and not worry
about relaxing them.

Eric



> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> ---
>
>  fs/proc/vmcore.c |   92 +++++++++++++++++++++++++++++++++++++++++++-----------
>  1 files changed, 74 insertions(+), 18 deletions(-)
>
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 94743d2..7d2dc4c 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -251,8 +251,7 @@ static u64 __init get_vmcore_size_elf32(char *elfptr)
>  static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
>  						struct list_head *vc_list)
>  {
> -	int i, nr_ptnote=0, rc=0;
> -	char *tmp;
> +	int i, j, nr_ptnote=0, i_ptnote, rc=0;
>  	Elf64_Ehdr *ehdr_ptr;
>  	Elf64_Phdr phdr, *phdr_ptr;
>  	Elf64_Nhdr *nhdr_ptr;
> @@ -301,6 +300,39 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
>  		kfree(notes_section);
>  	}
>  
> +	if (nr_ptnote == 0)
> +		goto out;
> +
> +	phdr_ptr = (Elf64_Phdr *)(elfptr + ehdr_ptr->e_phoff);
> +
> +	/* Remove unwanted PT_NOTE program headers. */
> +
> +        /* - 1st pass shifts non-PT_NOTE entries until the first
> +	     PT_NOTE entry. */
> +	i_ptnote = -1;
> +	for (i = 0; i < ehdr_ptr->e_phnum; ++i) {
> +		if (phdr_ptr[i].p_type == PT_NOTE) {
> +			i_ptnote = i;
> +			break;
> +		}
> +	}
> +	BUG_ON(i_ptnote == -1); /* impossible case since nr_ptnote > 0. */
> +	memmove(phdr_ptr + 1, phdr_ptr,	i_ptnote * sizeof(Elf64_Phdr));
> +
> +	/* - 2nd pass moves the remaining non-PT_NOTE entries under
> +	     the first PT_NOTE entry. */
> +	for (i = j = i_ptnote + 1; i < ehdr_ptr->e_phnum; i++) {
> +		if (phdr_ptr[i].p_type != PT_NOTE) {
> +			memmove(phdr_ptr + j, phdr_ptr + i,
> +				sizeof(Elf64_Phdr));
> +			j++;
> +		}
> +	}
> +
> +	/* - Finally, fill unused part with 0. */
> +	memset(phdr_ptr + ehdr_ptr->e_phnum - (nr_ptnote - 1), 0,
> +	       (nr_ptnote - 1) * sizeof(Elf64_Phdr));
> +
>  	/* Prepare merged PT_NOTE program header. */
>  	phdr.p_type    = PT_NOTE;
>  	phdr.p_flags   = 0;
> @@ -312,18 +344,14 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
>  	phdr.p_align   = 0;
>  
>  	/* Add merged PT_NOTE program header*/
> -	tmp = elfptr + ehdr_ptr->e_phoff;
> -	memcpy(tmp, &phdr, sizeof(phdr));
> -	tmp += sizeof(phdr);
> +	memcpy(phdr_ptr, &phdr, sizeof(Elf64_Phdr));
>  
> -	/* Remove unwanted PT_NOTE program headers. */
> -	i = (nr_ptnote - 1) * sizeof(Elf64_Phdr);
> -	*elfsz = *elfsz - i;
> -	memmove(tmp, tmp+i, ((*elfsz)-ehdr_ptr->e_phoff-sizeof(Elf64_Phdr)));
> +	*elfsz = *elfsz - (nr_ptnote - 1) * sizeof(Elf64_Phdr);
>  
>  	/* Modify e_phnum to reflect merged headers. */
>  	ehdr_ptr->e_phnum = ehdr_ptr->e_phnum - nr_ptnote + 1;
>  
> +out:
>  	return 0;
>  }
>  
> @@ -331,8 +359,7 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
>  static int __init merge_note_headers_elf32(char *elfptr, size_t *elfsz,
>  						struct list_head *vc_list)
>  {
> -	int i, nr_ptnote=0, rc=0;
> -	char *tmp;
> +	int i, j, nr_ptnote=0, i_ptnote, rc=0;
>  	Elf32_Ehdr *ehdr_ptr;
>  	Elf32_Phdr phdr, *phdr_ptr;
>  	Elf32_Nhdr *nhdr_ptr;
> @@ -381,6 +408,39 @@ static int __init merge_note_headers_elf32(char *elfptr, size_t *elfsz,
>  		kfree(notes_section);
>  	}
>  
> +	if (nr_ptnote == 0)
> +		goto out;
> +
> +	phdr_ptr = (Elf32_Phdr *)(elfptr + ehdr_ptr->e_phoff);
> +
> +	/* Remove unwanted PT_NOTE program headers. */
> +
> +	/* - 1st pass shifts non-PT_NOTE entries until the first
> +	     PT_NOTE entry. */
> +	i_ptnote = -1;
> +	for (i = 0; i < ehdr_ptr->e_phnum; ++i) {
> +		if (phdr_ptr[i].p_type == PT_NOTE) {
> +			i_ptnote = i;
> +			break;
> +		}
> +	}
> +	BUG_ON(i_ptnote == -1); /* impossible case since nr_ptnote > 0. */
> +	memmove(phdr_ptr + 1, phdr_ptr, i_ptnote * sizeof(Elf32_Phdr));
> +
> +	/* - 2nd pass moves the remaining non-PT_NOTE entries under
> +	     the first PT_NOTE entry. */
> +	for (i = j = i_ptnote + 1; i < ehdr_ptr->e_phnum; i++) {
> +		if (phdr_ptr[i].p_type != PT_NOTE) {
> +			memmove(phdr_ptr + j, phdr_ptr + i,
> +				sizeof(Elf32_Phdr));
> +			j++;
> +		}
> +	}
> +
> +	/* - Finally, fill unused part with 0. */
> +	memset(phdr_ptr + ehdr_ptr->e_phnum - (nr_ptnote - 1), 0,
> +	       (nr_ptnote - 1) * sizeof(Elf32_Phdr));
> +
>  	/* Prepare merged PT_NOTE program header. */
>  	phdr.p_type    = PT_NOTE;
>  	phdr.p_flags   = 0;
> @@ -392,18 +452,14 @@ static int __init merge_note_headers_elf32(char *elfptr, size_t *elfsz,
>  	phdr.p_align   = 0;
>  
>  	/* Add merged PT_NOTE program header*/
> -	tmp = elfptr + ehdr_ptr->e_phoff;
> -	memcpy(tmp, &phdr, sizeof(phdr));
> -	tmp += sizeof(phdr);
> +	memcpy(phdr_ptr, &phdr, sizeof(Elf32_Phdr));
>  
> -	/* Remove unwanted PT_NOTE program headers. */
> -	i = (nr_ptnote - 1) * sizeof(Elf32_Phdr);
> -	*elfsz = *elfsz - i;
> -	memmove(tmp, tmp+i, ((*elfsz)-ehdr_ptr->e_phoff-sizeof(Elf32_Phdr)));
> +	*elfsz = *elfsz - (nr_ptnote - 1) * sizeof(Elf32_Phdr);
>  
>  	/* Modify e_phnum to reflect merged headers. */
>  	ehdr_ptr->e_phnum = ehdr_ptr->e_phnum - nr_ptnote + 1;
>  
> +out:
>  	return 0;
>  }
>  

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
