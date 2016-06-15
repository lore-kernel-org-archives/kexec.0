Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1bDJi9-0000x9-67
 for kexec@lists.infradead.org; Wed, 15 Jun 2016 22:55:02 +0000
Received: by mail-wm0-x230.google.com with SMTP id a66so32908164wme.0
 for <kexec@lists.infradead.org>; Wed, 15 Jun 2016 15:54:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160615224228.GK1041@n2100.armlinux.org.uk>
References: <20160614175920.GD1041@n2100.armlinux.org.uk>
 <CAGXu5j+5j32HO0rQtF2hcqMUBaa8cyxgLT4JvaZ6LL2WPj_zjw@mail.gmail.com>
 <20160615211359.GJ1041@n2100.armlinux.org.uk>
 <CAGXu5jKRBA9b6gos+FG7iV2ppxtAERstNPschxA0z=aDL_y1YA@mail.gmail.com>
 <20160615224228.GK1041@n2100.armlinux.org.uk>
From: Kees Cook <keescook@google.com>
Date: Wed, 15 Jun 2016 15:54:38 -0700
Message-ID: <CAGXu5jLqNeYe_=7a5XC6UW4G3WiRQrrBvgernmugw_r2y0Nshg@mail.gmail.com>
Subject: Re: kexec failures with DEBUG_RODATA
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
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Pratyush Anand <panand@redhat.com>, Simon Horman <horms@verge.net.au>, Kexec Mailing List <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Baoquan He <bhe@redhat.com>

On Wed, Jun 15, 2016 at 3:42 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> In fact, the apparent confusion over this reinforces my belief that we
> should _not_ give the size of the uncompressed image at all.
>
> The boot environment must be setup such that there is room for the
> uncompressed image (aligned currently to 256 bytes) followed by the
> size of the compressed image, with any appended DTBs included.
> Anything which is located below that is likely to get trampled by
> the decompressor.

Okay, sounds reasonable to me. :)

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
