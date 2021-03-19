Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from linux.microsoft.com ([13.77.154.182])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lNKqf-0083aN-Ex
 for kexec@lists.infradead.org; Fri, 19 Mar 2021 19:31:56 +0000
Date: Fri, 19 Mar 2021 14:31:38 -0500
From: Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: Re: [PATCH v3 1/1] kexec: dump kmessage before machine_kexec
Message-ID: <20210319193138.GA235401@sequoia>
References: <20210319192326.146000-1-pasha.tatashin@soleen.com>
 <20210319192326.146000-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210319192326.146000-2-pasha.tatashin@soleen.com>
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
Cc: jmorris@namei.org, sashal@kernel.org, pmladek@suse.com, ebiederm@xmission.com, keescook@chromium.org, anton@enomsg.org, ccross@android.com, tony.luck@intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

On 2021-03-19 15:23:26, Pavel Tatashin wrote:
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

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>  kernel/kexec_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index a0b6780740c8..6ee4a1cf6e8e 100644
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
> @@ -1179,6 +1180,7 @@ int kernel_kexec(void)
>  		machine_shutdown();
>  	}
>  
> +	kmsg_dump(KMSG_DUMP_SHUTDOWN);
>  	machine_kexec(kexec_image);
>  
>  #ifdef CONFIG_KEXEC_JUMP
> -- 
> 2.25.1
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
