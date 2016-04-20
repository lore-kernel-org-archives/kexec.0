Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1asghx-0004Wu-LT
 for kexec@lists.infradead.org; Wed, 20 Apr 2016 01:13:34 +0000
Date: Wed, 20 Apr 2016 09:13:07 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: Removal of the kernel code/data/bss resources does break
 kexec/kdump
Message-ID: <20160420011307.GA3693@dhcp-128-65.nay.redhat.com>
References: <570F6D99.6090400@gmail.com>
 <2f4d7dee6bb0e4afdc05f2b7457fcf79@abdsec.com>
 <CA+55aFwprUFh+cjB2fWmkMJ3Zgh6XSan0VO8Vr-80Qh0n0Rx+A@mail.gmail.com>
 <f80ca230bf1fab7527d355e535de305f@abdsec.com>
 <CA+55aFxtuUBBJS4xxM5OiyZs04xjrpHPif+cO4U_s4OppeN-gg@mail.gmail.com>
 <20160419090401.GA4348@dhcp-128-65.nay.redhat.com>
 <CA+55aFw96tSBMM-2qoGtRBAe0u533ww3bzT6Eb7ZFoEyGooA1g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+55aFw96tSBMM-2qoGtRBAe0u533ww3bzT6Eb7ZFoEyGooA1g@mail.gmail.com>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Baoquan He <bhe@redhat.com>, Freeman Zhang <freeman.zhang1992@gmail.com>, Kexec Mailing List <kexec@lists.infradead.org>, Zhengyu Zhang <zhezhang@redhat.com>, Emrah Demir <ed@abdsec.com>

On 04/19/16 at 09:20am, Linus Torvalds wrote:
> On Tue, Apr 19, 2016 at 2:04 AM, Dave Young <dyoung@redhat.com> wrote:
> >
> > It is not clear how to handle it, maybe we can assume nobody is using it as
> > non-root, leave it as is or just add |CAP_SYS_BOOT for /proc/iomem?
> 
> Pretty much nobody uses fine-grained capabilities anyway - they are
> one of those bad security things that generally add more complexity
> than value(*) - so I wouldn't worry about it unless you actually find
> something that cares.

Agreed that leaving it as is should be fine according to you said about
fine-grained capabilities usage.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
