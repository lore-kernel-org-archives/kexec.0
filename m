Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1asYOY-0007tM-9L
 for kexec@lists.infradead.org; Tue, 19 Apr 2016 16:20:58 +0000
Received: by mail-io0-x243.google.com with SMTP id z133so3301200iod.1
 for <kexec@lists.infradead.org>; Tue, 19 Apr 2016 09:20:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160419090401.GA4348@dhcp-128-65.nay.redhat.com>
References: <570F6D99.6090400@gmail.com>
 <2f4d7dee6bb0e4afdc05f2b7457fcf79@abdsec.com>
 <CA+55aFwprUFh+cjB2fWmkMJ3Zgh6XSan0VO8Vr-80Qh0n0Rx+A@mail.gmail.com>
 <f80ca230bf1fab7527d355e535de305f@abdsec.com>
 <CA+55aFxtuUBBJS4xxM5OiyZs04xjrpHPif+cO4U_s4OppeN-gg@mail.gmail.com>
 <20160419090401.GA4348@dhcp-128-65.nay.redhat.com>
Date: Tue, 19 Apr 2016 09:20:37 -0700
Message-ID: <CA+55aFw96tSBMM-2qoGtRBAe0u533ww3bzT6Eb7ZFoEyGooA1g@mail.gmail.com>
Subject: Re: Removal of the kernel code/data/bss resources does break
 kexec/kdump
From: Linus Torvalds <torvalds@linux-foundation.org>
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
To: Dave Young <dyoung@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Baoquan He <bhe@redhat.com>, Freeman Zhang <freeman.zhang1992@gmail.com>, Kexec Mailing List <kexec@lists.infradead.org>, Zhengyu Zhang <zhezhang@redhat.com>, Emrah Demir <ed@abdsec.com>

On Tue, Apr 19, 2016 at 2:04 AM, Dave Young <dyoung@redhat.com> wrote:
>
> It is not clear how to handle it, maybe we can assume nobody is using it as
> non-root, leave it as is or just add |CAP_SYS_BOOT for /proc/iomem?

Pretty much nobody uses fine-grained capabilities anyway - they are
one of those bad security things that generally add more complexity
than value(*) - so I wouldn't worry about it unless you actually find
something that cares.

             Linus

(*) The one exception tends to be certain network services that can
use CAP_NET_BIND_SERVICE like things to really lower their attack
surface. But certainly not one-time things like kexec.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
