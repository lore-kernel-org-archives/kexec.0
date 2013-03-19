Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UI4KX-0004qR-K2
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 21:44:26 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
 <20130316040053.15064.93652.stgit@localhost6.localdomain6>
Date: Tue, 19 Mar 2013 14:44:16 -0700
In-Reply-To: <20130316040053.15064.93652.stgit@localhost6.localdomain6>
 (HATAYAMA Daisuke's message of "Sat, 16 Mar 2013 13:00:53 +0900")
Message-ID: <87ppyvnjyn.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 01/21] vmcore: reference e_phoff member explicitly to
 get position of program header table
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

> Currently, the code assumes that position of program header table is
> next to ELF header. But future change can break the assumption on
> kexec-tools and the 1st kernel. To avoid worst case, reference e_phoff
> member explicitly to get position of program header table in
> file-offset.

In principle this looks good.  However when I read this it looks like
you are going a little too far.

You are changing not only the reading of the supplied headers, but
you are changing the generation of the new new headers that describe
the data provided by /proc/vmcore.

I get lost in following this after you mangle merge_note_headers.

In principle removing silly assumptions seems reasonable, but I think
it is completely orthogonal to the task of maping vmcore mmapable.

I think it is fine to claim that the assumptions made here in vmcore are
part of the kexec on panic ABI at this point, which would generally make
this change unnecessary.

> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> ---
>
>  fs/proc/vmcore.c |   56 +++++++++++++++++++++++++++++++++++-------------------
>  1 files changed, 36 insertions(+), 20 deletions(-)
>
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index b870f74..163281e 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -221,8 +221,8 @@ static u64 __init get_vmcore_size_elf64(char *elfptr)
>  	Elf64_Phdr *phdr_ptr;
>  
>  	ehdr_ptr = (Elf64_Ehdr *)elfptr;
> -	phdr_ptr = (Elf64_Phdr*)(elfptr + sizeof(Elf64_Ehdr));
> -	size = sizeof(Elf64_Ehdr) + ((ehdr_ptr->e_phnum) * sizeof(Elf64_Phdr));
> +	phdr_ptr = (Elf64_Phdr*)(elfptr + ehdr_ptr->e_phoff);
> +	size = ehdr_ptr->e_phoff + ((ehdr_ptr->e_phnum) * sizeof(Elf64_Phdr));
>  	for (i = 0; i < ehdr_ptr->e_phnum; i++) {
>  		size += phdr_ptr->p_memsz;
>  		phdr_ptr++;
> @@ -238,8 +238,8 @@ static u64 __init get_vmcore_size_elf32(char *elfptr)
>  	Elf32_Phdr *phdr_ptr;
>  
>  	ehdr_ptr = (Elf32_Ehdr *)elfptr;
> -	phdr_ptr = (Elf32_Phdr*)(elfptr + sizeof(Elf32_Ehdr));
> -	size = sizeof(Elf32_Ehdr) + ((ehdr_ptr->e_phnum) * sizeof(Elf32_Phdr));
> +	phdr_ptr = (Elf32_Phdr*)(elfptr + ehdr_ptr->e_phoff);
> +	size = ehdr_ptr->e_phoff + ((ehdr_ptr->e_phnum) * sizeof(Elf32_Phdr));
>  	for (i = 0; i < ehdr_ptr->e_phnum; i++) {
>  		size += phdr_ptr->p_memsz;
>  		phdr_ptr++;

> @@ -259,7 +259,7 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
>  	u64 phdr_sz = 0, note_off;
>  
>  	ehdr_ptr = (Elf64_Ehdr *)elfptr;
> -	phdr_ptr = (Elf64_Phdr*)(elfptr + sizeof(Elf64_Ehdr));
> +	phdr_ptr = (Elf64_Phdr*)(elfptr + ehdr_ptr->e_phoff);
>  	for (i = 0; i < ehdr_ptr->e_phnum; i++, phdr_ptr++) {
>  		int j;
>  		void *notes_section;

Up to here things look good.

> @@ -305,7 +305,7 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
>  	/* Prepare merged PT_NOTE program header. */
>  	phdr.p_type    = PT_NOTE;
>  	phdr.p_flags   = 0;
> -	note_off = sizeof(Elf64_Ehdr) +
> +	note_off = ehdr_ptr->e_phoff +
>  			(ehdr_ptr->e_phnum - nr_ptnote +1) * sizeof(Elf64_Phdr);

And this is is just silly.  There is no point in changing where the
regenerated headers live.

>  	phdr.p_offset  = note_off;
>  	phdr.p_vaddr   = phdr.p_paddr = 0;
> @@ -313,14 +313,14 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
>  	phdr.p_align   = 0;
>  
>  	/* Add merged PT_NOTE program header*/
> -	tmp = elfptr + sizeof(Elf64_Ehdr);
> +	tmp = elfptr + ehdr_ptr->e_phoff;
Again this looks very silly.

>  	memcpy(tmp, &phdr, sizeof(phdr));
>  	tmp += sizeof(phdr);
>  
>  	/* Remove unwanted PT_NOTE program headers. */
>  	i = (nr_ptnote - 1) * sizeof(Elf64_Phdr);
>  	*elfsz = *elfsz - i;
> -	memmove(tmp, tmp+i, ((*elfsz)-sizeof(Elf64_Ehdr)-sizeof(Elf64_Phdr)));
> +	memmove(tmp, tmp+i, ((*elfsz)-ehdr_ptr->e_phoff-sizeof(Elf64_Phdr)));

This is a regenerated header so this change is dubious.


Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
