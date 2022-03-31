From: Baoquan He <bhe@redhat.com>
Date: Thu, 31 Mar 2022 19:32:17 +0800
Subject: [PATCH v2 0/2] x86/kexec: fix memory leak of elf header buffer
In-Reply-To: <20220223113225.63106-1-bhe@redhat.com>
References: <20220223113225.63106-1-bhe@redhat.com>
Message-ID: <YkWRQdp7TxV22ygO@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Andrew,

On 02/23/22 at 07:32pm, Baoquan He wrote:
> The memory leak is reported by kmemleak detector, has been existing
> for very long time. It casue much memory loss on large machine
> with huge memory hotplug which will trigger kdump kernel reloading
> many times, with kexec_file_load interface.

Could you merge these two patches? Or should I ping x86 maintainers to
take them? 

Thanks
Baoquan

> 
> And in patch 2, clean up is done to remove unneeded
> arch_kexec_kernel_image_load() and rename functions.
> 
> V1 post can be found here:
> https://lore.kernel.org/all/20211029072424.9109-1-bhe at redhat.com/T/#u
> 
> v1->v2:
>  No code change. The v1 post has been acked by Dave Young but not
> merged. In v2, just merging the old patch 1 and 2 as per Dave's concern
> in v1 post.
> 
> Baoquan He (2):
>   x86/kexec: fix memory leak of elf header buffer
>   kexec_file: clean up arch_kexec_kernel_image_load
> 
>  arch/x86/kernel/machine_kexec_64.c | 23 +++++++++--------------
>  include/linux/kexec.h              |  1 -
>  kernel/kexec_file.c                |  9 ++-------
>  3 files changed, 11 insertions(+), 22 deletions(-)
> 
> -- 
> 2.31.1
> 


