Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLeGH-0008Dz-6D
 for kexec@lists.infradead.org; Fri, 25 Sep 2020 03:19:06 +0000
Date: Fri, 25 Sep 2020 11:18:50 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2 1/1] kdump: append uts_namespace.name offset to
 VMCOREINFO
Message-ID: <20200925031850.GO25604@MiWiFi-R3L-srv>
References: <20200924124647.300080-1-egorenar@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200924124647.300080-1-egorenar@linux.ibm.com>
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
To: Alexander Egorenkov <egorenar@linux.ibm.com>
Cc: keescook@chromium.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ktkhai@virtuozzo.com, ebiederm@xmission.com, akpm@linux-foundation.org, dyoung@redhat.com, christian.brauner@ubuntu.com, vgoyal@redhat.com

On 09/24/20 at 02:46pm, Alexander Egorenkov wrote:
> The offset of the field 'init_uts_ns.name' has changed
> since
> 
> commit 9a56493f6942c0e2df1579986128721da96e00d8
> Author: Kirill Tkhai <ktkhai@virtuozzo.com>
> Date:   Mon Aug 3 13:16:21 2020 +0300
> 
>     uts: Use generic ns_common::count
> 
> Link: https://lore.kernel.org/r/159644978167.604812.1773586504374412107.stgit@localhost.localdomain

Seems there's some argument about the generic ns_common::count in the
thread of above link. While except of it, the adding the offset of
uts_namespace.name looks good to me.

Acked-by: Baoquan He <bhe@redhat.com>


> 
> Make the offset of the field 'uts_namespace.name' available
> in VMCOREINFO because tools like 'crash-utility' and
> 'makedumpfile' must be able to read it from crash dumps.
> 
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
>  kernel/crash_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 106e4500fd53..173fdc261882 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -447,6 +447,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	VMCOREINFO_PAGESIZE(PAGE_SIZE);
>  
>  	VMCOREINFO_SYMBOL(init_uts_ns);
> +	VMCOREINFO_OFFSET(uts_namespace, name);
>  	VMCOREINFO_SYMBOL(node_online_map);
>  #ifdef CONFIG_MMU
>  	VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
> -- 
> 2.26.2
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
