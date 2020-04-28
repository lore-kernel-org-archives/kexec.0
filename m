Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTLZH-0001gD-08
 for kexec@lists.infradead.org; Tue, 28 Apr 2020 08:26:16 +0000
Received: by mail-qt1-f199.google.com with SMTP id q43so23684774qtj.11
 for <kexec@lists.infradead.org>; Tue, 28 Apr 2020 01:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <1586212300-30797-1-git-send-email-bhsharma@redhat.com>
 <20200408104655.GA92698@C02TD0UTHF1T.local>
In-Reply-To: <20200408104655.GA92698@C02TD0UTHF1T.local>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Tue, 28 Apr 2020 13:55:58 +0530
Message-ID: <CACi5LpP0WqYGxrJL6BJia-ceSR5XbjytsSY+P74xaDJZTJA8jA@mail.gmail.com>
Subject: Re: [PATCH] arm64/defconfig: Enable CONFIG_KEXEC_FILE
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, kexec mailing list <kexec@lists.infradead.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, Will Deacon <will@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Wed, Apr 8, 2020 at 4:17 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Apr 07, 2020 at 04:01:40AM +0530, Bhupesh Sharma wrote:
> > kexec_file_load() syscall interface is now supported for
> > arm64 architecture as well via commits:
> > 3751e728cef2 ("arm64: kexec_file: add crash dump support") and
> > 3ddd9992a590 ("arm64: enable KEXEC_FILE config")].
> >
> > This patch enables config KEXEC_FILE by default in the
> > arm64 defconfig, so that user-space tools like kexec-tools
> > can use the same as the default interface for kexec/kdump
> > on arm64.
> >
> > Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: James Morse <james.morse@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: kexec@lists.infradead.org
> >
> > Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>
> FWIW:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> Mark.
>
> > ---
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index 24e534d85045..fa122f4341a2 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -66,6 +66,7 @@ CONFIG_SCHED_SMT=y
> >  CONFIG_NUMA=y
> >  CONFIG_SECCOMP=y
> >  CONFIG_KEXEC=y
> > +CONFIG_KEXEC_FILE=y
> >  CONFIG_CRASH_DUMP=y
> >  CONFIG_XEN=y
> >  CONFIG_COMPAT=y
> > --
> > 2.7.4
> >

Thanks a lot  Mark.

Hi Catalin, Will,

Can you please help pick this patch in the arm tree. We have an
increasing number of user-cases from distro users
who want to use kexec_file_load() as the default interface for
kexec/kdump on arm64.

Regards,
Bhupesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
