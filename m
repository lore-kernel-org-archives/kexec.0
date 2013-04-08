Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UP39y-0006p8-Sw
 for kexec@lists.infradead.org; Mon, 08 Apr 2013 03:54:23 +0000
Received: by mail-pa0-f50.google.com with SMTP id bg2so3056337pad.37
 for <kexec@lists.infradead.org>; Sun, 07 Apr 2013 20:54:20 -0700 (PDT)
Date: Mon, 8 Apr 2013 11:53:45 +0800
From: Wang YanQing <udknight@gmail.com>
Subject: Re: [PATCH] i386:kexec-bzImage: Use "\0" as command line instead of
 empty command line
Message-ID: <20130408035345.GA6651@udknight>
References: <20130403094356.GA7259@udknight> <515FB809.3020103@gmail.com>
 <20130407010103.GA2176@udknight> <51610A32.6080200@cn.fujitsu.com>
 <20130407093540.GA4046@udknight> <20130408010804.GA2241@udknight>
 <51623AFD.9000605@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51623AFD.9000605@cn.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: jbarnes@sgi.com, tjd21@cl.cam.ac.uk, khalid.aziz@hp.com, kexec@lists.infradead.org, horms@verge.net.au, ebiederm@xmission.com, hari@in.ibm.com, Zhang Yanfei <zhangyanfei.yes@gmail.com>

On Mon, Apr 08, 2013 at 11:35:25AM +0800, Zhang Yanfei wrote:
> I tried 3.8.0 kernel. Unfortunately, panicked again. For some reason, I didn't
> see the panic message.
> 
> >but if my memory don't lie me,
> > I can boot v2.6.32 without a root= parameter, we had use v2.6.32 as product kernel
> > still more than one year two years ago.
> 
> Sigh, I tried in a real box and a kvm machine. Both panicked with no root= argument
> message. I don't know why.

It maybe your CONFIG relation problem, I guess. I have booted ok more than 3 times.
Are your have CONFIG_BLK_DEV_INITRD=y in .config? And your cpio format initramfs
has init script in root directory? And your init script will auto-mount your really
device right before switch_root into it?

> Anyway, Just from the code, your patch didn't fix all the possible place.
> do_bzImage64_load may also call setup_linux_bootloader_parameters_high with
> a null commandline. So why not change the check in
> setup_linux_bootloader_parameters_high.
Your are right. But your patch is wrong too.
See below.

> 
> --------------------------
> diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
> index 454fad6..6eb2e6e 100644
> --- a/kexec/arch/i386/x86-linux-setup.c
> +++ b/kexec/arch/i386/x86-linux-setup.c
> @@ -116,7 +116,8 @@ void setup_linux_bootloader_parameters_high(
>         /* Fill in the command line */
>         if (cmdline_len > COMMAND_LINE_SIZE) {
>                 cmdline_len = COMMAND_LINE_SIZE;
> -       }
> +       } else if (cmdline_len == 0)
> +               return;
Can't just return, we must set the string termination guard like below:

+ else if (cmdline_len == 0)
+       cmdline_len = 1;

If you agreed, maybe I can resend the v2 patch.
>         cmdline_ptr = ((char *)real_mode) + cmdline_offset;
>         memcpy(cmdline_ptr, cmdline, cmdline_len);
>         cmdline_ptr[cmdline_len - 1] = '\0';
> 

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
