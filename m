Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fbKUX-0008Il-Q4
 for kexec@lists.infradead.org; Fri, 06 Jul 2018 06:45:19 +0000
Received: by mail-lf0-f68.google.com with SMTP id l16-v6so8917760lfc.13
 for <kexec@lists.infradead.org>; Thu, 05 Jul 2018 23:45:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1530795335-20867-1-git-send-email-arnaud.ferraris.external@sigfox.com>
References: <1530795335-20867-1-git-send-email-arnaud.ferraris.external@sigfox.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Fri, 6 Jul 2018 12:07:37 +0530
Message-ID: <CACi5LpP=aGG-aPe47e_xwqir_zhMpbQ+e7aTuB_Nn3CMDkEn2Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: add support for loading kernel from FITimage
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
To: Arnaud Ferraris <arnaud.ferraris.external@sigfox.com>
Cc: Simon Horman <horms@verge.net.au>, kexec mailing list <kexec@lists.infradead.org>

Hello Arnaud,

Thanks for the patch.

On Thu, Jul 5, 2018 at 6:25 PM, Arnaud Ferraris
<arnaud.ferraris.external@sigfox.com> wrote:
> Hi all,
>
> FITimages are an image format used by U-boot, allowing to embed a kernel with
> the associated device tree and initramfs into a single file, using the device
> tree file format.
> Unfortunately, for now kexec doesn't recognize the FITimage format.

Hmm, I think I mentioned this earlier, but why do we need kexec to
support the FIT image format? See the FIT image (or the .itb file)
will be parsed by the u-boot bootloader and the respective components
will be loaded by it at the appropriate load addresses (for the kernel
Image it would be the load address mentioned in the 'loadaddr' u-boot
environment variable and for the dtb it would be as per the arm64
architecture dtb offset placement constraints). Something like (which
I copied from logs on my arm32 board):

<..snip..>
kernel loaded at 0x80008000, end = 0x802bddd0
Loading Device Tree to 8fe44000, end 8fe49947 ... OK

Starting kernel ...

<..snip..>

So, the images are already placed at appropriate addresses by u-boot
and we simply do the following at the u-boot prompt:

<u-boot> bootm ${loadaddr}

So, I am trying to understand the use-case behind FIT image support in
kexec. Do we need kexec-tools to be aware of the FIT format when the
kernel itself it loaded in an uncompressed format (e.g. Image or
vmlinux).

If you can share your .its file and explain the use case better (may
be with the u-boot logs) it would help in the review.

I have other comments on the individual patches, but I will hold them
till the problem we are trying to solve here is clearer to me.

Thanks,
Bhupesh


> This patchset adds a generic FITimage loader & parser, and implements loading
> a kernel/dtb/initrd for the ARM64 architecture.
>
> Arnaud Ferraris (3):
>   kexec: Move zlib buffer decompression function
>   kexec: fitImage: Add fitImage parser and loader
>   kexec: arm64: Add fitImage support
>
>  include/Makefile                        |   1 +
>  include/kexec-fitImage.h                |  18 +++
>  kexec/Makefile                          |   4 +
>  kexec/arch/arm64/Makefile               |   2 +
>  kexec/arch/arm64/kexec-arm64.c          |  15 ++-
>  kexec/arch/arm64/kexec-arm64.h          |   4 +
>  kexec/arch/arm64/kexec-fitImage-arm64.c |  40 ++++++
>  kexec/kexec-fitImage.c                  | 223 ++++++++++++++++++++++++++++++++
>  kexec/kexec-uImage.c                    | 100 +-------------
>  kexec/kexec-zlib.h                      |   1 +
>  kexec/kexec.h                           |   4 +
>  kexec/zlib.c                            | 100 ++++++++++++++
>  12 files changed, 413 insertions(+), 99 deletions(-)
>  create mode 100644 include/kexec-fitImage.h
>  create mode 100644 kexec/arch/arm64/kexec-fitImage-arm64.c
>  create mode 100644 kexec/kexec-fitImage.c
>
> --
> 2.7.4
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
