Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1U6NFa-0001PP-AI
 for kexec@lists.infradead.org; Fri, 15 Feb 2013 15:30:59 +0000
Date: Fri, 15 Feb 2013 10:30:48 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 05/13] vmcore: modify ELF32 code according to new type
Message-ID: <20130215153048.GD27784@redhat.com>
References: <20130214100945.22466.4172.stgit@localhost6.localdomain6>
 <20130214101210.22466.36330.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130214101210.22466.36330.stgit@localhost6.localdomain6>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, cpw@sgi.com

On Thu, Feb 14, 2013 at 07:12:10PM +0900, HATAYAMA Daisuke wrote:
> On elf32 mmap() is not supported. All vmcore objects are in old
> memory.

This is odd. Why can't we support mmap() when 32bit headers have been
prepared?

Thanks
Vivek

> 
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> ---
> 
>  fs/proc/vmcore.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 43d338a..7e3f922 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -389,6 +389,7 @@ static int __init merge_note_headers_elf32(char *elfptr, size_t *elfsz,
>  			kfree(notes_section);
>  			return -ENOMEM;
>  		}
> +		new->type = VMCORE_OLD_MEMORY;
>  		new->paddr = phdr_ptr->p_offset;
>  		new->size = real_sz;
>  		list_add_tail(&new->list, vc_list);
> @@ -486,6 +487,7 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
>  		new = get_new_element();
>  		if (!new)
>  			return -ENOMEM;
> +		new->type = VMCORE_OLD_MEMORY;
>  		new->paddr = phdr_ptr->p_offset;
>  		new->size = phdr_ptr->p_memsz;
>  		list_add_tail(&new->list, vc_list);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
