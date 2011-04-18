Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QBo1l-0002ps-0J
	for kexec@lists.infradead.org; Mon, 18 Apr 2011 12:58:09 +0000
Date: Mon, 18 Apr 2011 08:58:02 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Patch] kexec: fix the missing i386 part in commit 1100580b05e
Message-ID: <20110418125802.GD30783@redhat.com>
References: <1303028945-15298-1-git-send-email-amwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1303028945-15298-1-git-send-email-amwang@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Amerigo Wang <amwang@redhat.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On Sun, Apr 17, 2011 at 04:29:05PM +0800, Amerigo Wang wrote:
> Vivek pointed out that I missed the i386 part in this commit,
> 
> 	commit 1100580b05e3fdfe648d9be8617d962b11f4b88b
> 	Author: Amerigo Wang <amwang@redhat.com>
> 	Date:   Thu Mar 3 00:10:43 2011 +0800
> 
> 	    get the backup area dynamically
> 
> Yes. The customer who reported that bug definitely only
> tested it on x86_64. Now make it complete.

Hi Amerigo,

Have you verified the contents of backup area? I want to make sure that
everything is working and in second kernel when we read up vmcore, we
do read contents properly.

Thanks
Vivek

> 
> Signed-off-by: Amerigo Wang <amwang@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Simon Horman <horms@verge.net.au>
> 
> ---
> diff --git a/kexec/arch/i386/kexec-x86.c b/kexec/arch/i386/kexec-x86.c
> index 5c701aa..014ecd5 100644
> --- a/kexec/arch/i386/kexec-x86.c
> +++ b/kexec/arch/i386/kexec-x86.c
> @@ -184,6 +184,10 @@ void arch_update_purgatory(struct kexec_info *info)
>  		&arch_options.console_vga, sizeof(arch_options.console_vga));
>  	elf_rel_set_symbol(&info->rhdr, "console_serial",
>  		&arch_options.console_serial, sizeof(arch_options.console_serial));
> +	elf_rel_set_symbol(&info->rhdr, "backup_src_start",
> +		&info->backup_src_start, sizeof(info->backup_src_start));
> +	elf_rel_set_symbol(&info->rhdr, "backup_src_size",
> +		&info->backup_src_size, sizeof(info->backup_src_size));
>  	if (info->kexec_flags & KEXEC_ON_CRASH) {
>  		panic_kernel = 1;
>  		elf_rel_set_symbol(&info->rhdr, "backup_start",

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
