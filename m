Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbzeN-0002M2-TU
 for kexec@lists.infradead.org; Wed, 26 Dec 2018 03:14:32 +0000
Date: Wed, 26 Dec 2018 11:14:09 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] Disable GCC stack protector for purgatory
Message-ID: <20181226031409.GA13556@dhcp-128-65.nay.redhat.com>
References: <167d7d9a7a0.11e500f4e120196.4787543063153295929@2krueger.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <167d7d9a7a0.11e500f4e120196.4787543063153295929@2krueger.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Marcel =?iso-8859-1?Q?Kr=FCger?= <linux@2krueger.de>
Cc: kexec <kexec@lists.infradead.org>

On 12/22/18 at 10:37pm, Marcel Kr=FCger wrote:
> Modern versions of GCC enable the stack protector by default. This causes
> Linux kernels build using such GCC versions to complain about undefined
> references to `__stack_chk_fail` in purgatory whenever `kexec_file_load`
> is used.
> =

> Fix this by building purgatory with `-fno-stack-protector`.
> =

> Signed-off-by: Marcel Kr=FCger <linux@2krueger.de>
> ---
>  arch/s390/purgatory/Makefile | 1 +
>  arch/x86/purgatory/Makefile  | 1 +
>  2 files changed, 2 insertions(+)
> =

> diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
> index ce6a3f75065b..61820af85903 100644
> --- a/arch/s390/purgatory/Makefile
> +++ b/arch/s390/purgatory/Makefile
> @@ -23,6 +23,7 @@ KBUILD_CFLAGS +=3D -Wno-pointer-sign -Wno-sign-compare
>  KBUILD_CFLAGS +=3D -fno-zero-initialized-in-bss -fno-builtin -ffreestand=
ing
>  KBUILD_CFLAGS +=3D -c -MD -Os -m64 -msoft-float -fno-common
>  KBUILD_CFLAGS +=3D $(call cc-option,-fno-PIE)
> +KBUILD_CFLAGS +=3D $(call cc-option,-fno-stack-protector)
>  KBUILD_AFLAGS :=3D $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
> =

>  $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index 3cf302b26332..f8519959a47e 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -22,6 +22,7 @@ KCOV_INSTRUMENT :=3D n
>  KBUILD_CFLAGS :=3D -fno-strict-aliasing -Wall -Wstrict-prototypes -fno-z=
ero-initialized-in-bss -fno-builtin -ffreestanding -c -Os -mcmodel=3Dlarge
>  KBUILD_CFLAGS +=3D -m$(BITS)
>  KBUILD_CFLAGS +=3D $(call cc-option,-fno-PIE)
> +KBUILD_CFLAGS +=3D $(call cc-option,-fno-stack-protector)
> =

>  $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
>                 $(call if_changed,ld)
> --
> 2.20.1
> =

> =

> =

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
