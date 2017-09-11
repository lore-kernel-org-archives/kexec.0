Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1drDdg-0000tW-2u
 for kexec@lists.infradead.org; Mon, 11 Sep 2017 01:35:54 +0000
Date: Mon, 11 Sep 2017 09:35:22 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [Makedumpfile PATCH] book3s/ppc64: Lower the max real address to
 53 bits for kernels >= v4.11
Message-ID: <20170911013522.GA2704@dhcp-128-65.nay.redhat.com>
References: <1504845625-27408-1-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1504845625-27408-1-git-send-email-bhsharma@redhat.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: bhe@redhat.com, piliu@redhat.com, ats-kumagai@wm.jp.nec.com, kexec@lists.infradead.org, hbathini@linux.vnet.ibm.com

Cc more people.

On 09/08/17 at 10:10am, Bhupesh Sharma wrote:
> Kernel commit 2f18d533757da3899f4bedab0b2c051b080079dc lowered the
> max real address on ppc64 to 53 bits.
> 
> Make similar changes in makedumpfile (on basis of the underlying kernel
> version), without which the makedumpfile will fail to create a dumpfile
> and instead throw a SEGV fault as shown below on kernels >= v4.11:
> 
>  # makedumpfile --split -d 31 -x vmlinux vmcore dumpfile_{1,2,3} 2>&1
> 
>  The kernel version is not supported.
>  The makedumpfile operation may be incomplete.
>  [ 1196.252094] makedumpfile[2367]: unhandled signal 11 at
>  00000100f7011ca8 nip 000000001001eecc lr 000000001001f3c0 code 30001
>  Segmentation fault
> 
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> ---
>  makedumpfile.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 7d81bbcf2234..142753d84e8d 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -684,8 +684,9 @@ unsigned long get_kvbase_arm64(void);
>  #define PMD_MASKED_BITS_64K_4_6  0xc0000000000000ffUL
>  
>  #define PTE_RPN_MASK_DEFAULT  0xffffffffffffffffUL
> -#define PTE_RPN_SIZE_L4_4_6   (info->page_size == 65536 ? 41 : 45)
> -#define PTE_RPN_MASK_L4_4_6   (((1UL << PTE_RPN_SIZE_L4_4_6) - 1) << info->page_shift)
> +#define PAGE_PA_MAX_L4_4_6    (info->kernel_version >= KERNEL_VERSION(4,11,0) ? 53 : 57)
> +#define PTE_RPN_MASK_L4_4_6   \
> +	(((1UL << PAGE_PA_MAX_L4_4_6) - 1) & ~((1UL << info->page_shift) - 1))
>  #define PTE_RPN_SHIFT_L4_4_6  info->page_shift
>  
>  #define PGD_MASKED_BITS_4_7  0xc0000000000000ffUL
> -- 
> 2.7.4
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
