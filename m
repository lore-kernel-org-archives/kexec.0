Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cWH62-0002zZ-6n
 for kexec@lists.infradead.org; Wed, 25 Jan 2017 06:30:20 +0000
Date: Wed, 25 Jan 2017 14:29:49 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] /proc/kcore: Update physical address for kcore ram and
 text
Message-ID: <20170125062949.GA3423@dhcp-128-65.nay.redhat.com>
References: <f951340d2917cdd2a329fae9837a83f2059dc3b2.1485318868.git.panand@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f951340d2917cdd2a329fae9837a83f2059dc3b2.1485318868.git.panand@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: kexec@lists.infradead.org, anderson@redhat.com, linux-kernel@vger.kernel.org, bhe@redhat.com

Hi Pratyush
On 01/25/17 at 10:14am, Pratyush Anand wrote:
> Currently all the p_paddr of PT_LOAD headers are assigned to 0, which is
> not true and could be misleading, since 0 is a valid physical address.

I do not know the history of /proc/kcore, so a question is why the
p_addr was set as 0, if there were some reasons and if this could cause
some risk or breakage.

> 
> User space tools like makedumpfile needs to know physical address for
> PT_LOAD segments of direct mapped regions. Therefore this patch updates
> paddr for such regions. It also sets an invalid paddr (-1) for other
> regions, so that user space tool can know whether a physical address
> provided in PT_LOAD is correct or not.
> 
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> ---
>  fs/proc/kcore.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 0b80ad87b4d6..ea9f3d1ae830 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -373,7 +373,10 @@ static void elf_kcore_store_hdr(char *bufp, int nphdr, int dataoff)
>  		phdr->p_flags	= PF_R|PF_W|PF_X;
>  		phdr->p_offset	= kc_vaddr_to_offset(m->addr) + dataoff;
>  		phdr->p_vaddr	= (size_t)m->addr;
> -		phdr->p_paddr	= 0;
> +		if (m->type == KCORE_RAM || m->type == KCORE_TEXT)
> +			phdr->p_paddr	= __pa(m->addr);
> +		else
> +			phdr->p_paddr	= (elf_addr_t)-1;
>  		phdr->p_filesz	= phdr->p_memsz	= m->size;
>  		phdr->p_align	= PAGE_SIZE;
>  	}
> -- 
> 2.9.3
> 

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
