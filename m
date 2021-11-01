Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mhRDb-00FVhT-UH
 for kexec@lists.infradead.org; Mon, 01 Nov 2021 06:54:57 +0000
Date: Mon, 1 Nov 2021 14:54:42 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 0/3] x86/kexec: fix memory leak of elf header buffer
Message-ID: <YX+PMtj0gN458gTQ@dhcp-128-65.nay.redhat.com>
References: <20211029072424.9109-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211029072424.9109-1-bhe@redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, akpm@linux-foundation.org

Hi Baoquan,

On 10/29/21 at 03:24pm, Baoquan He wrote:
> The memory leak is reported by kmemleak detector, has been existing
> for very long time. It could casue much memory loss on large machine
> with huge memory hotplug which will trigger kdump kernel reloading
> many times, with kexec_file_load interface.
> 
> And in patch 2, 3, clean up is done to remove unnecessary elf header
> buffer freeing and unneeded arch_kexec_kernel_image_load().
> 
> Baoquan He (3):
>   x86/kexec: fix memory leak of elf header buffer
>   x86/kexec: remove incorrect elf header buffer freeing
>   kexec_file: clean up arch_kexec_kernel_image_load
> 
>  arch/x86/kernel/machine_kexec_64.c | 23 +++++++++--------------
>  include/linux/kexec.h              |  1 -
>  kernel/kexec_file.c                |  9 ++-------
>  3 files changed, 11 insertions(+), 22 deletions(-)
> 
> -- 
> 2.17.2
> 

Acked-by: Dave Young <dyoung@redhat.com>

nitpick: the first two patches can be merged togeter, but I'm also fine if
they are in two patches.

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
