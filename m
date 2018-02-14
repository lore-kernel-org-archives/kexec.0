Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by merlin.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1elm79-0007fw-6t
 for kexec@lists.infradead.org; Wed, 14 Feb 2018 01:44:04 +0000
Date: Wed, 14 Feb 2018 09:43:29 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] Documentation: kdump: describe jumping to dump-capture
 kernel
Message-ID: <20180214014329.GA2756@dhcp-128-65.nay.redhat.com>
References: <20180213152236.31413-1-gi-oh.kim@profitbricks.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180213152236.31413-1-gi-oh.kim@profitbricks.com>
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
To: Gioh Kim <gi-oh.kim@profitbricks.com>
Cc: bhe@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org, kexec@lists.infradead.org, bhupesh.linux@gmail.com, vgoyal@redhat.com

Hi,
On 02/13/18 at 04:22pm, Gioh Kim wrote:
> Jumping between the system kernel and the dump-capture kernel
> has been supported for long time but there is no description
> how to use it. This patch adds the description how to use kexec tool
> to jump to the dump-capture kernel and jump back to the system kernel.

I do not think this should belong to kdump documentation.  There are a
lot of choices after a vmcore saving, one can reboot, halt, even go
ahead with real root filesystem init path.  We do not need to document
all these in kdump.txt.

Since it is a general use case not only for kdump, add more info in
kexec man page would be better.

> 
> Signed-off-by: Gioh Kim <gi-oh.kim@profitbricks.com>
> ---
>  Documentation/kdump/kdump.txt | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
> index 51814450a7f8..35b71fef5d88 100644
> --- a/Documentation/kdump/kdump.txt
> +++ b/Documentation/kdump/kdump.txt
> @@ -460,6 +460,44 @@ and the system will boot into the dump-capture kernel.
>  For testing purposes, you can trigger a crash by using "ALT-SysRq-c",
>  "echo c > /proc/sysrq-trigger" or write a module to force the panic.
>  
> +Jump between the System kernel and the Dump-capture kernel
> +===============================
> +
> +Without system crash, the system can jump to the dump-capture kernel.
> +
> +1) Enable "jump between system kernel and dump-capture kernel" support under
> +   "Processor type and features"
> +
> +   CONFIG_KEXEC_JUMP=y
> +
> +2) Load the dump-capture kernel with --load-preserve-context and mem-max
> +   options as following.
> +
> +   kexec -l <dump-capture-kernel-vmlinux-image> \
> +   --initrd=<initrd-for-dump-capture-kernel> --args-linux \
> +   --append="root=<root-dev> <arch-specific-options>" \
> +   --load-preserve-context \
> +   --mem-max=<the highest memory address addr to load code into>
> +
> +3) Jump to the loaded kernel
> +
> +   kexec -e
> +
> +Now the system is running with the dump-capture kernel. You can jump back
> +to the system kernel.
> +
> +1) Find kexec_jump_back_entry address in kernel booting parameters in
> +   /proc/cmdline. That is the address for kexec to jump to. For example:
> +   kexec_jump_back_entry=0x00000000000810d2
> +
> +2) Following command sets the jump-back address for kexec.
> +
> +   kexec --load-jump-back-helper --entry=0x810d2
> +
> +3) Jump to the system kernel
> +
> +   kexec -e
> +
>  Write Out the Dump File
>  =======================
>  
> -- 
> 2.11.0
> 

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
