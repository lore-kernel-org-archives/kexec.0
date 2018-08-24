Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ft5vi-0001cQ-4U
 for kexec@lists.infradead.org; Fri, 24 Aug 2018 06:53:17 +0000
Date: Fri, 24 Aug 2018 14:49:38 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] x86, kdump: Fix efi=noruntime NULL pointer dereference
Message-ID: <20180824064938.GA5316@dhcp-128-65.nay.redhat.com>
References: <1533737025.4936.3.camel@gmx.de>
 <20180809042153.GA4377@dhcp-128-65.nay.redhat.com>
 <1533800010.5087.71.camel@gmx.de>
 <20180809091333.GA8008@dhcp-128-65.nay.redhat.com>
 <CAKv+Gu8KKwNkUdx7tSxEosRvydxmQ2yaasHRJn_LcHPs7p2UYQ@mail.gmail.com>
 <20180822102310.GA19827@dhcp-128-65.nay.redhat.com>
 <20180823035705.GA5743@dhcp-128-65.nay.redhat.com>
 <1535086138.4661.9.camel@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1535086138.4661.9.camel@gmx.de>
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
To: Mike Galbraith <efault@gmx.de>
Cc: linux-efi <linux-efi@vger.kernel.org>, Baoquan He <bhe@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Kexec Mailing List <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>

On 08/24/18 at 06:48am, Mike Galbraith wrote:
> On Thu, 2018-08-23 at 11:57 +0800, Dave Young wrote:
> > 
> > Mike, since we are going this way, I'm working on a kexec code cleanup,
> > but it needs careful testing so still need some time.
> > 
> > Can you help test below efi fix and provide you tested-by if it works?
> 
> While it averts the efi=noruntime oops on kdump kernel load, the kernel
> does not boot when kdump is triggered.  Bailing in setup_efi_state() in
> addition restores functionality.

Yes, that is expected.  Kexec code need fix and cleanup in other
patches.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
