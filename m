Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jiCp6-0005Hm-QE
 for kexec@lists.infradead.org; Mon, 08 Jun 2020 08:08:02 +0000
Received: by mail-qk1-f199.google.com with SMTP id w14so13706819qkb.0
 for <kexec@lists.infradead.org>; Mon, 08 Jun 2020 01:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200605194642.62278-1-pasha.tatashin@soleen.com>
In-Reply-To: <20200605194642.62278-1-pasha.tatashin@soleen.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Mon, 8 Jun 2020 13:37:42 +0530
Message-ID: <CACi5LpNvBaAVibj_XpLm1=zk8oUDXpWGZyZJ=TLBkimoUoiD8A@mail.gmail.com>
Subject: Re: [PATCH] kexec: dump kmessage before machine_kexec
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
Cc: sashal@kernel.org, pmladek@suse.com, "Luck, Tony" <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>, anton@enomsg.org, kexec mailing list <kexec@lists.infradead.org>, James Morris <jmorris@namei.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, ccross@android.com

Hi Pavel,

On Sat, Jun 6, 2020 at 1:16 AM Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
>
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
> ---
>  kernel/kexec_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index c19c0dad1ebe..50027f759a97 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -37,6 +37,7 @@
>  #include <linux/compiler.h>
>  #include <linux/hugetlb.h>
>  #include <linux/frame.h>
> +#include <linux/kmsg_dump.h>
>
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -1181,6 +1182,7 @@ int kernel_kexec(void)
>                 machine_shutdown();
>         }
>
> +       kmsg_dump(KMSG_DUMP_SHUTDOWN);
>         machine_kexec(kexec_image);
>
>  #ifdef CONFIG_KEXEC_JUMP
> --
> 2.25.1

LGTM, so:

Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>

Thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
