Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE80EFD9E3D
	for <kexec@archiver.kernel.org>; Fri, 27 Feb 2026 06:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xle5YbXN6KwFDRvCphlTjI+Jhqul262ibdvj3JnVvLE=; b=IzHdolS6dohsGXfej8m03HSPCe
	zQA3jxtz8yDbw5FLK3Qompi40xNLUmAro8rLLZ2DlPNRL12MCim5tfJ14oQ/V5PnkWjdlkVWpS1d+
	Wt60a6fN2NbwIfOPxrKP8c4/pTpUq8Pq6QKp+rykUrvnQaKGnOnyCqPvfX1haciUEtrhTSekmsbcb
	7qUlao2C6C6gCyP8UNs+SJ6HBUEk+X61nXjieFgTDBR9V1EiYOYIEDG6+gCXnfSwf10Tg1ZIhOdUC
	OVX/fGi7i52WNzHAuY5Z1MPLFoYObdg2BaiU9ttRbnrhoPFOmx4gfuG44N5NAWtocRtlSJcbPAg5R
	ORQ3NxPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvqxH-00000007kcW-3iAp;
	Fri, 27 Feb 2026 06:04:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvqxD-00000007kbi-4BeV
	for kexec@lists.infradead.org;
	Fri, 27 Feb 2026 06:04:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772172238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xle5YbXN6KwFDRvCphlTjI+Jhqul262ibdvj3JnVvLE=;
	b=CCtpPuPOemjdGFkQrnmLUGZ9Ld/JJg4TiJ/6N6ryfbF3t9O7Qe4tTCKl4dIgNFFtkphHHW
	9O3DoTavFyhenfr0sVULYg6u6ycKOBq7BP5BYnXE9BfZFjHFi9ZB1maTrrud6nKqpoxCyE
	Rhg5M/xI8Bk0zXHQ9oNOjqmT0vUUaFM=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-mRYtXvbKNwq3YTZ2S6d_OQ-1; Fri, 27 Feb 2026 01:03:55 -0500
X-MC-Unique: mRYtXvbKNwq3YTZ2S6d_OQ-1
X-Mimecast-MFC-AGG-ID: mRYtXvbKNwq3YTZ2S6d_OQ_1772172235
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so1681353eec.0
        for <kexec@lists.infradead.org>; Thu, 26 Feb 2026 22:03:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772172235; x=1772777035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xle5YbXN6KwFDRvCphlTjI+Jhqul262ibdvj3JnVvLE=;
        b=k7rWnFnSUfSGVs11rnbQKv9ctenNOiv++jvTRqgDoWydm2K5uRQNDm0sGzl8eSzdJQ
         czULgt54E27a85+NnA0pBkJCkJFR8Iv4ntSrHKmLyOec0fH9hzxtgHngRKGw2t/PEFer
         K5+iwhJZP/qU+0+KlLcRxAnDkbT5x1KCx8ygAeLzp5MOZumfAOnufd9nxe8qhRI2F/A5
         F9vng2E/ezII4BBLx7LSn6x7c6SKoULplWKqO1mz2ae8hKDrKatYMBw7DH17V6Jxrm3r
         hUnesJqeBa9Tz5tMJ5VxewHRlP1Hp582KP6XC+hiL7aXH1GTk5PZNudScH5G8Wu3ChK5
         HAGw==
X-Forwarded-Encrypted: i=1; AJvYcCUtG9va7XsiPk0v/s8jCZnlQTVEO2aEPmNTvpex9m/NSew+jzI28rm8U/oS+ehfG5hwqQy6+A==@lists.infradead.org
X-Gm-Message-State: AOJu0YxJTY4HG8ig9+1liST44bAo2pxZ7vou8Y2b1X5YI4QKxmIetO5v
	rF1j16SkszsLbiBlxbQm6MqTQguAvLUnj/HeoMBg7nBTk9KulcoKfVhToyq8/fRFypITp8DNbcc
	nPVLBNPNFoS1KesGq8Hwn69u/O3JekK0CCUrVLGHez2ZSsxN6nVe4blY5iOQNMhEMhLEYU3NJaI
	qzTYdPlHjoI8t8cyQRhYuR72o6MwqAJpmIKrlV
X-Gm-Gg: ATEYQzz4bc6HvRZEIgk4jnQdf4Di5OiNOfZgUAsLZNDsElAv5n3kyo/1nMNXUq3w5Gq
	cuD377lfayU+C6nHNGLx2nU95EiXgha3u+uZ7MvNDC0VQNFgMnWX9gFpapUgyNOzU3UldL/5YvS
	ZomB3tH+4pdtX5y3zu1Xp8AOHFg8GlRbiE6yBdBPnsUupoqIRd6IXm2qqbqs5QQe+f+2A2jt9lH
	oSWNoA=
X-Received: by 2002:a05:7301:1008:b0:2b7:fdb6:ccfe with SMTP id 5a478bee46e88-2bde1efb928mr871920eec.19.1772172234099;
        Thu, 26 Feb 2026 22:03:54 -0800 (PST)
X-Received: by 2002:a05:7301:1008:b0:2b7:fdb6:ccfe with SMTP id
 5a478bee46e88-2bde1efb928mr871892eec.19.1772172233542; Thu, 26 Feb 2026
 22:03:53 -0800 (PST)
MIME-Version: 1.0
References: <20260119032424.10781-1-piliu@redhat.com> <20260226143628.7c6db69d@rotkaeppchen>
In-Reply-To: <20260226143628.7c6db69d@rotkaeppchen>
From: Pingfan Liu <piliu@redhat.com>
Date: Fri, 27 Feb 2026 14:03:42 +0800
X-Gm-Features: AaiRm50HkXbMe-2Di-B7yH2Mu4n1COUPjaSX1wmFLDO_bYZeCTwE8vWLE0-IyWY
Message-ID: <CAF+s44QC+u8Lx91DmuDsE3AwAne0eouRKfFZ4CjWBCpE2W_Q5A@mail.gmail.com>
Subject: Re: [PATCHv6 00/13] kexec: Use BPF lskel to enable kexec to load PE
 format boot image
To: Philipp Rudo <prudo@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Viktor Malik <vmalik@redhat.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, bpf@vger.kernel.org, 
	systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LzTwloSDlrguo6cPOvGCSkM_Cnq9mP_egc5H_JGMBCc_1772172235
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_220400_255744_6F0A3B28 
X-CRM114-Status: GOOD (  49.64  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Philipp,

Thank you for taking the time to look into this.

On Thu, Feb 26, 2026 at 9:36=E2=80=AFPM Philipp Rudo <prudo@redhat.com> wro=
te:
>
> Hi Pingfan,
>
> please excuse my late reply. I've looked through the series and all in
> all it looks fine to me. I've got two comments/questions in addition to
> what the bpf-bot found. In general the findings from the bpf-bot look
> valid to me. But fixing them should be rather straight forward. Only
> for the first finding, where it "complains" that ctx->buf is NULL, I
> don't understand what it is wants to tell us.
>

A race condition exists: when bpf_buffer_parser() is called multiple
times on ctx, later calls overwrite the previous ctx->buf without
releasing it. While re-entrancy is uncommon in this design, it still
needs to be addressed.

> In my opinion the next step we should take is to implement an example
> bpf-prog for UKIs. I expect it to be much more complex compared to the
> zboot one. So having a example bpf-prog will show us if we run into any
> limitations with bpf or need to adjust the interfaces.
>

Yeah, it's a little challenge. The traditional kexec_file_load syscall
interface was tailored for the kernel boot protocol. However, with the
emergence of Zboot and UKI images, it fails to automatically
accommodate these new formats.

Now, with the introduction of decompose_kexec_kimage() to
kexec_file_load, the design takes a different approach. It decomposes
these complex modern images and then reassembles them into the kernel
boot protocol. Consequently, the fds parameter in kexec_file_load()
can have more flexible meanings, no longer limited to kernel or initrd
file descriptors.

I'm considering two alternative approaches. The first is to introduce
an fd array to pass the file descriptors for UKI and cmdline add-ons.
The second option is to reuse the current interface but reinterpret
the meaning of fds. The first approach requires not just an fd array
but also metadata describing the purpose of each file descriptor. In
contrast, the second option avoids this complexity.
In the second option, the first fd in kexec_file_load can be used to
ship the bpf parsers. the second fd can be used to ship a temporary
file, which holds UKI and all addons. Inside the kernel, the bpf
parser can extract the PE files embeded inside the temporary file,
verify their signature, decide their role and reassemble them. So all
details are kept inside the bpf parser without changing the kernel
API.

To implement this, the design in this series requires some
adjustments. Rather than embedding BPF parsers in PE-based formats
like Zboot or UKI, this approach improves the design by keeping the
kernel image unmodified.


What is your opinion?


Thanks,

Pingfan




> Thanks
> Philipp
>
> On Mon, 19 Jan 2026 11:24:11 +0800
> Pingfan Liu <piliu@redhat.com> wrote:
>
> > *** The history ***
> >
> > Nowadays, UEFI PE bootable images are becoming increasingly popular
> > among distributions. Currently, we have several kinds of image format
> > parsers in user space (kexec-tools). However, this approach breaks the
> > integrity protection of the images. To address this integrity protectio=
n
> > concern, several approaches have been proposed to resolve this issue,
> > but none of them have been accepted upstream yet.
> >
> > The summary of those approaches:
> >   -1. UEFI service emulator for UEFI stub
> >   -2. PE format parser in kernel
> >   -3. Signing the arm64/boot/Image
> >
> >
> > For the first approach, I tried a purgatory-style emulator [1], but it
> > encounters hardware scaling issues. For the second approach, both
> > zboot-format [2] and UKI-format [3] parsers were rejected due to
> > concerns that variant format parsers would bloat the kernel code.
> > Additionally, for example in arm64, both UKI and zboot format parsers
> > would need to be introduced and chained together to handle image
> > loading. For the third approach, I attempted [4], but since zboot or UK=
I
> > images already have signatures, upstream maintainers dislike the
> > additional signature on the Image. Moreover, for secure boot UKI, this
> > method cannot use signatures to protect the initramfs.
> >
> >
> > *** The approach in this series ***
> >
> > This series introduces an approach that allows image formats to be
> > parsed by BPF programs. As a result, the kexec kernel code can remain
> > relatively stable without introducing new parsers for different
> > architectures.  This approach introduces a dedicated '.bpf' section in
> > the PE file, which stores BPF bytecode. The integrity of all
> > components -- kernel, initramfs, cmdline, and even the BPF bytecode
> > itself is protected by the PE file's signature.  After signature
> > verification, the BPF bytecode is loaded and executed from within the
> > kernel using BPF lskel. Therefore, the bytecode itself is protected fro=
m
> > malicious attacks on the BPF loader in user space.
> >
> > When a .bpf section is extracted from the current image file, its
> > bytecode is attached to the kexec kernel function
> > kexec_image_parser_anchor(). After the bytecode parses the image, the
> > next-stage image is prepared, and the bytecode in the new .bpf section
> > can be attached to kexec_image_parser_anchor(). In this way, nested
> > image format issues (e.g., zboot image within UKI on arm64) can be
> > resolved.  (Theoretically not yet tested.)
> >
> >
> > *** Thanks ***
> > I would like to thank Philipp Rudo, whose insights inspired this
> > approach and who dedicated significant time to evaluating its
> > practicality. I am also grateful to Viktor Malik for his guidance on
> > using BPF light skeleton to prevent malicious attacks from user space.
> >
> >
> > *** Test approach ***
> > -1. compile kernel
> > -2. get the zboot image with bpf-prog by 'make -C tools/kexec zboot'
> > -3. compile kexec-tools from https://github.com/pfliu/kexec-tools/tree/=
pe_bpf
> >
> > The rest test process is the common convention to use kexec.
> >
> >
> > [1]: https://lore.kernel.org/lkml/20240819145417.23367-1-piliu@redhat.c=
om/T/
> > [2]: https://lore.kernel.org/kexec/20230306030305.15595-1-kernelfans@gm=
ail.com/
> > [3]: https://lore.kernel.org/lkml/20230911052535.335770-1-kernel@jfarr.=
cc/
> > [4]: https://lore.kernel.org/linux-efi/20230921133703.39042-1-kernelfan=
s@gmail.com/
> >
> >
> > *** Changes ***
> > v5 -> v6
> >   - Re-organize the layers in kexec_file_load into two layers: format-p=
arsing and kernel boot protocol handling.
> >   - Simplify the bpf kfunc interface.
> >   - rebased onto Linux 6.19-rc2
> >
> > v4 -> v5
> >   - rebased onto Linux 6.17-rc2
> >   - [1/12], use a separate CONFIG_KEEP_COMPRESSOR to decide the section
> >     of decompressor method
> >   - [10/12], add Catalin's acked-by (Thanks Catalin!)
> >
> > v3 -> v4
> >   - Use dynamic allocator in decompression ([4/12])
> >   - Fix issue caused by Identical Code Folding ([5/12])
> >   - Integrate the image generator tool in the kernel tree ([11,12/12])
> >   - Address the issue according to Philipp's comments in v3 reviewing.
> >     Thanks Philipp!
> >
> > RFCv2 -> v3
> >   - move the introduced bpf kfuncs to kernel/bpf/* and mark them sleepa=
ble
> >   - use listener and publisher model to implement bpf_copy_to_kernel()
> >   - keep each introduced kfunc under the control of memcg
> >
> > RFCv1 -> RFCv2
> >   - Use bpf kfunc instead of helper
> >   - Use C source code to generate the light skeleton file
> >
> >
> > ---
> > Pingfan Liu (13):
> >   bpf: Introduce kfuncs to parser buffer content
> >   kexec_file: Move signature validation ahead
> >   kexec_file: Introduce routines to parse PE file
> >   kexec_file: Use bpf-prog to decompose image
> >   lib/decompress: Keep decompressor when CONFIG_KEEP_DECOMPRESSOR
> >   kexec_file: Implement decompress method for parser
> >   kexec_file: Implement copy method for parser
> >   kexec_file: Introduce a bpf-prog lskel to parse PE file
> >   kexec_file: Factor out routine to find a symbol in ELF
> >   kexec_file: Integrate bpf light skeleton to load image with bpf-prog
> >   arm64/kexec: Select KEXEC_BPF to support UEFI-style kernel image
> >   tools/kexec: Introduce a bpf-prog to parse zboot image format
> >   tools/kexec: Add a zboot image building tool
> >
> >  arch/arm64/Kconfig                           |   1 +
> >  include/linux/bpf.h                          |  19 +
> >  include/linux/decompress/mm.h                |   8 +
> >  kernel/Kconfig.kexec                         |   8 +
> >  kernel/Makefile                              |   2 +
> >  kernel/bpf/Makefile                          |   3 +
> >  kernel/bpf/bpf_buffer_parser.c               | 170 +++++++
> >  kernel/kexec_bpf/Makefile                    |  70 +++
> >  kernel/kexec_bpf/kexec_pe_parser_bpf.c       |  12 +
> >  kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h | 130 ++++++
> >  kernel/kexec_bpf/template.c                  |  68 +++
> >  kernel/kexec_bpf_loader.c                    | 439 +++++++++++++++++++
> >  kernel/kexec_file.c                          | 106 +++--
> >  kernel/kexec_internal.h                      |   5 +
> >  kernel/kexec_uefi_app.c                      |  81 ++++
> >  lib/Kconfig                                  |   6 +
> >  lib/decompress.c                             |   6 +-
> >  tools/kexec/Makefile                         |  91 ++++
> >  tools/kexec/pe.h                             | 177 ++++++++
> >  tools/kexec/template.c                       |  68 +++
> >  tools/kexec/zboot_image_builder.c            | 278 ++++++++++++
> >  tools/kexec/zboot_parser_bpf.c               | 114 +++++
> >  22 files changed, 1813 insertions(+), 49 deletions(-)
> >  create mode 100644 kernel/bpf/bpf_buffer_parser.c
> >  create mode 100644 kernel/kexec_bpf/Makefile
> >  create mode 100644 kernel/kexec_bpf/kexec_pe_parser_bpf.c
> >  create mode 100644 kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h
> >  create mode 100644 kernel/kexec_bpf/template.c
> >  create mode 100644 kernel/kexec_bpf_loader.c
> >  create mode 100644 kernel/kexec_uefi_app.c
> >  create mode 100644 tools/kexec/Makefile
> >  create mode 100644 tools/kexec/pe.h
> >  create mode 100644 tools/kexec/template.c
> >  create mode 100644 tools/kexec/zboot_image_builder.c
> >  create mode 100644 tools/kexec/zboot_parser_bpf.c
> >
>


