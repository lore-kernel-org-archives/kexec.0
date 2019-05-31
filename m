Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-f194.google.com ([209.85.166.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hWdzp-0003yw-0r
 for kexec@lists.infradead.org; Fri, 31 May 2019 09:38:46 +0000
Received: by mail-it1-f194.google.com with SMTP id h20so14663143itk.4
 for <kexec@lists.infradead.org>; Fri, 31 May 2019 02:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20181123092633.16111-1-kasong@redhat.com>
 <20190531092935.sfpbxeu7uquogtd5@verge.net.au>
In-Reply-To: <20190531092935.sfpbxeu7uquogtd5@verge.net.au>
From: Kairui Song <kasong@redhat.com>
Date: Fri, 31 May 2019 17:38:32 +0800
Message-ID: <CACPcB9fCDnvB-bQ0NngStydh4UBy0cV7CYA1QPj1+Apea1sSwQ@mail.gmail.com>
Subject: Re: [PATCH] x86: Handle 64bit framebuffer memory address properly
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
To: Simon Horman <horms@verge.net.au>
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org

On Fri, May 31, 2019 at 5:29 PM Simon Horman <horms@verge.net.au> wrote:
>
> On Fri, Nov 23, 2018 at 05:26:33PM +0800, Kairui Song wrote:
> > In a EFI system, the frame buffer address is 64bit, so currently
> > if the address is beyound 4G, kexec will set wrong address due to
> > truncate.
> >
> > Linux kernel commit ae2ee627dc87 ('efifb: Add support for 64-bit
> > frame buffer addresses') added support for 64bit frame buffer
> > address, an 'ext_lfb_base' field is added as the upper 32-bits of
> > the frame buffer, and introduced a new capability flag
> > 'VIDEO_TYPE_CAPABILITY_64BIT_BASE' to indicate if the extend field is
> > used.
> >
> > This patch adopts this change, set proper extent address and capability
> > flag when the address is beyound 4G.
> >
> > Signed-off-by: Kairui Song <kasong@redhat.com>
>
> Sorry for letting this slip through the cracks.
> Please let me know if this is still relevant.

Hi Simon, I checked kexec-tools repo and this patch is merged already,
maybe you replied the wrong mail?


--
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
