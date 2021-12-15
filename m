Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxJKE-00GJ6H-Pt
 for kexec@lists.infradead.org; Wed, 15 Dec 2021 01:43:24 +0000
Received: by mail-io1-f72.google.com with SMTP id
 o11-20020a0566022e0b00b005e95edf792dso19479384iow.14
 for <kexec@lists.infradead.org>; Tue, 14 Dec 2021 17:43:19 -0800 (PST)
MIME-Version: 1.0
References: <20211210030735.53155-1-piliu@redhat.com>
In-Reply-To: <20211210030735.53155-1-piliu@redhat.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Wed, 15 Dec 2021 09:43:06 +0800
Message-ID: <CAF+s44SwFXFbD1tKBKtFK2p43wCnYc8rfkpSyoQn7_jb-8LNUA@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: make phys_to_virt() correct
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
To: kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, horms@verge.net.au

+ AKASHI Takahiro
+ Simon Horman

Thank you guys for any suggestions.
And vmcore-dmesg just can not work for 52-bits VA arm64 now.

Thanks,
Pingfan

On Fri, Dec 10, 2021 at 11:07 AM Pingfan Liu <piliu@redhat.com> wrote:
>
> Currently phys_to_virt() does not work well on 52-bits VA arm64 kernel.
> One issue is contributed by phys_offset not signed.
> The other is contributed by wrong page_offset.
>
> This series fixes them so vmcore-dmesg can work on 52-bits VA kernel
>
> Pingfan Liu (3):
>   arm64: make phys_offset signed
>   arm64/crashdump: unify routine to get page_offset
>   arm64: read VA_BITS from kcore for 52-bits VA kernel
>
>  kexec/arch/arm64/crashdump-arm64.c | 23 +---------------
>  kexec/arch/arm64/kexec-arm64.c     | 43 +++++++++++++++++++++++-------
>  kexec/arch/arm64/kexec-arm64.h     |  4 ++-
>  util_lib/elf_info.c                |  7 ++++-
>  util_lib/include/elf_info.h        |  2 +-
>  5 files changed, 44 insertions(+), 35 deletions(-)
>
> --
> 2.31.1
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
