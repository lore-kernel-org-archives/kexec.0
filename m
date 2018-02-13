Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1elfoN-0007zP-Cm
 for kexec@lists.infradead.org; Tue, 13 Feb 2018 19:00:17 +0000
Received: by mail-qt0-x242.google.com with SMTP id c19so4798817qtm.7
 for <kexec@lists.infradead.org>; Tue, 13 Feb 2018 11:00:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180213152236.31413-1-gi-oh.kim@profitbricks.com>
References: <20180213152236.31413-1-gi-oh.kim@profitbricks.com>
From: Bhupesh SHARMA <bhupesh.linux@gmail.com>
Date: Wed, 14 Feb 2018 00:30:02 +0530
Message-ID: <CAFTCetRHj1_veFJqnoGif_ts26rdQfiXUDquc2F9uZFwcao_ww@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kdump: describe jumping to dump-capture
 kernel
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
Cc: Baoquan He <bhe@redhat.com>, corbet@lwn.net, linux-doc@vger.kernel.org, kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

On Tue, Feb 13, 2018 at 8:52 PM, Gioh Kim <gi-oh.kim@profitbricks.com> wrote:
> Jumping between the system kernel and the dump-capture kernel
> has been supported for long time but there is no description
> how to use it. This patch adds the description how to use kexec tool
> to jump to the dump-capture kernel and jump back to the system kernel.
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

This is essentially the 'kexec -l' use case, i.e we are loading
another kernel and not the kexec -p (or the conventional kdump) use
case and description.

I remember not being able to use the kexec -p (kdump feature) with the
jump/preserve primary kernel attributes case previously, but that was
some time back and haven't tried the same recently. So I am not sure
if the kexec -p case works well with the jump feature currently, but I
can try to setup an environment at my end.

So I don't think that the kdump kernel documentation is the right
place for this addition (as in this kernel document we essentially
capture the 'kexec -p' or kdump case and not the 'kexec -l'). Rather
we should add it the kexec man page (inside kexec-tools). See
<git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git> for
the man page.

And I agree that this is a useful piece of documentation as I have
burnt my hands while experimenting with the jump feature previously
and I think it would be great to have this included somewhere in the
kexec man page for ready reference.

Regards,
Bhupesh


>  Write Out the Dump File
>  =======================
>
> --
> 2.11.0
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
