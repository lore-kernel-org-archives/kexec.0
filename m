Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4zl9-00063p-Ee
 for kexec@lists.infradead.org; Thu, 28 Jan 2021 05:22:24 +0000
Date: Thu, 28 Jan 2021 13:22:08 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2 1/1] kexec: dump kmessage before machine_kexec
Message-ID: <20210128052208.GB2339@MiWiFi-R3L-srv>
References: <20210126204125.313820-1-pasha.tatashin@soleen.com>
 <20210126204125.313820-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210126204125.313820-2-pasha.tatashin@soleen.com>
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: sashal@kernel.org, pmladek@suse.com, tony.luck@intel.com, keescook@chromium.org, anton@enomsg.org, kexec@lists.infradead.org, jmorris@namei.org, linux-kernel@vger.kernel.org, tyhicks@linux.microsoft.com, ebiederm@xmission.com, ccross@android.com, akpm@linux-foundation.org

On 01/26/21 at 03:41pm, Pavel Tatashin wrote:
> kmsg_dump(KMSG_DUMP_SHUTDOWN) is called before
> machine_restart(), machine_halt(), machine_power_off(), the only one that
> is missing is  machine_kexec().
> 
> The dmesg output that it contains can be used to study the shutdown
> performance of both kernel and systemd during kexec reboot.
> 
> Here is example of dmesg data collected after kexec:
> 
> root@dplat-cp22:~# cat /sys/fs/pstore/dmesg-ramoops-0 | tail
> ...
> <6>[   70.914592] psci: CPU3 killed (polled 0 ms)
> <5>[   70.915705] CPU4: shutdown
> <6>[   70.916643] psci: CPU4 killed (polled 4 ms)
> <5>[   70.917715] CPU5: shutdown
> <6>[   70.918725] psci: CPU5 killed (polled 0 ms)
> <5>[   70.919704] CPU6: shutdown
> <6>[   70.920726] psci: CPU6 killed (polled 4 ms)
> <5>[   70.921642] CPU7: shutdown
> <6>[   70.922650] psci: CPU7 killed (polled 0 ms)
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>
> ---
>  kernel/kexec_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 4f8efc278aa7..e253c8b59145 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -37,6 +37,7 @@
>  #include <linux/compiler.h>
>  #include <linux/hugetlb.h>
>  #include <linux/objtool.h>
> +#include <linux/kmsg_dump.h>
>  
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -1180,6 +1181,7 @@ int kernel_kexec(void)
>  		machine_shutdown();
>  	}
>  
> +	kmsg_dump(KMSG_DUMP_SHUTDOWN);
>  	machine_kexec(kexec_image);

Looks good to me, thx.

Acked-by: Baoquan He <bhe@redhat.com>

>  
>  #ifdef CONFIG_KEXEC_JUMP
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
