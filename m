Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlSM9-0005t8-HD
 for kexec@lists.infradead.org; Wed, 17 Jun 2020 07:19:34 +0000
Received: by mail-qv1-f72.google.com with SMTP id 59so964815qvb.4
 for <kexec@lists.infradead.org>; Wed, 17 Jun 2020 00:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200616033320.2553-1-xulin.sun@windriver.com>
In-Reply-To: <20200616033320.2553-1-xulin.sun@windriver.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Wed, 17 Jun 2020 12:49:16 +0530
Message-ID: <CACi5LpOH8FvTF+iybJ-BionyRiKaz4DC80K2U0_XxEerhcHs6g@mail.gmail.com>
Subject: Re: [PATCH] arm64: continue loading even if kaslr-seed is not wiped
 to zero
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
To: Xulin Sun <xulin.sun@windriver.com>
Cc: xulinsun@gmail.com, Simon Horman <horms@verge.net.au>, kexec mailing list <kexec@lists.infradead.org>

Hi Xunlin,

On Tue, Jun 16, 2020 at 9:03 AM Xulin Sun <xulin.sun@windriver.com> wrote:
>
> The commit c3f043241a866a (arm64: Add support to supply 'kaslr-seed' to secondary kernel)
> add kaslr-seed support. And consider the primary kernel reads the 'kaslr-seed'
> and wipes it to 0. But in the situation, 'CONFIG_RANDOMIZE_BASE' was not set to
> y in the primary kernel and ATF firmware has set the 'kaslr-seed' dtb property
> with non-zero, Thus will return error.
>
> So in the above case, continue loading the segments with no kaslr
> supported situation.
>
> Signed-off-by: Xulin Sun <xulin.sun@windriver.com>
> ---
>  kexec/arch/arm64/kexec-arm64.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
> index 2992bce..540f4d7 100644
> --- a/kexec/arch/arm64/kexec-arm64.c
> +++ b/kexec/arch/arm64/kexec-arm64.c
> @@ -506,8 +506,7 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
>                 if (kaslr_seed != 0) {
>                         dbgprintf("%s: kaslr-seed is not wiped to 0.\n",
>                                         __func__);
> -                       result = -EINVAL;
> -                       goto on_error;
> +                       goto unable_kaslr;
>                 }
>
>                 /*
> @@ -550,6 +549,7 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
>                 }
>         }
>
> +unable_kaslr:
>         if (on_crash) {
>                 /* add linux,elfcorehdr */
>                 nodeoffset = fdt_path_offset(new_buf, "/chosen");
> --
> 2.17.1

Sorry, but this seems like an ATF issue which you are trying to fix in
kexec-tools.
See 'Documentation/devicetree/bindings/chosen.txt' for the details of
the 'kaslr-seed' property:

kaslr-seed
-----------

This property is used when booting with CONFIG_RANDOMIZE_BASE as the
entropy used to randomize the kernel image base address location. Since
it is used directly, this value is intended only for KASLR, and should
not be used for other purposes (as it may leak information about KASLR
offsets). It is parsed as a u64 value, e.g.

/ {
    chosen {
        kaslr-seed = <0xfeedbeef 0xc0def00d>;
    };
};

So, if CONFIG_RANDOMIZE_BASE (or kaslr) is disabled, this value should
not be available in the patched DTB read from the kernel, as otherwise
we have a possible security vulnerability as we are leaking out the
kernel text address which can be used by snooping applications to
inject malicious code in the kernel.

For example on my qualcomm arm64 platform, if CONFIG_RANDOMIZE_BASE is
set to n, user-space tools like 'dtc' are not able to find the
'kaslr-seed' property in the /chosen node (and same is the case with
kexec-tools):

# dtc -I dtb -O dts /sys/firmware/fdt | grep -A 10 -i chosen
    chosen {
   ... no 'kaslr-seed' node
}

Also confirm that the kernel symbol base address is not randomized on
successive reboots (in this case) via:
# cat /proc/kallsyms

Whereas, if I boot the kernel with CONFIG_RANDOMIZE_BASE (or kaslr)
enabled, I can see that the 'kaslr-seed' property is wiped to '0' (as
expected by the kernel') and can be seen in the output of:

# dtc -I dtb -O dts /sys/firmware/fdt | grep -A 10 -i chosen
    chosen {
    kaslr-seed = <0x0 0x0>
}

Thanks,
Bhupesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
