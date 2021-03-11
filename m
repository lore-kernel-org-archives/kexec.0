Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKCfY-008Kiz-9m
 for kexec@lists.infradead.org; Thu, 11 Mar 2021 04:11:31 +0000
Date: Thu, 11 Mar 2021 12:09:49 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kexec: Add kexec reboot string
Message-ID: <20210311040949.GG2962@MiWiFi-R3L-srv>
References: <20210304124626.13927-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210304124626.13927-1-pmenzel@molgen.mpg.de>
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
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Guohan Lu <lguohan@gmail.com>, Joe LeVeque <jolevequ@microsoft.com>, akpm@linux-foundation.org

On 03/04/21 at 01:46pm, Paul Menzel wrote:
> From: Joe LeVeque <jolevequ@microsoft.com>
> 
> The purpose is to notify the kernel module for fast reboot.

Checked several modules which registered with reboot_notifier_list, the
passed string is not cared. Just curious, could you tell how you have
used or plan to use this string in your code?

No objection to this even though it's trivial if no real use case.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Upstream a patch from the SONiC network operating system [1].
> 
> [1]: https://github.com/Azure/sonic-linux-kernel/pull/46
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  kernel/kexec_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index a0b6780740c8..f04d04d1b855 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1165,7 +1165,7 @@ int kernel_kexec(void)
>  #endif
>  	{
>  		kexec_in_progress = true;
> -		kernel_restart_prepare(NULL);
> +		kernel_restart_prepare("kexec reboot");
>  		migrate_to_reboot_cpu();
>  
>  		/*
> -- 
> 2.30.1
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
