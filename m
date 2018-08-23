Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mout.gmx.net ([212.227.17.22])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fsgv7-0005Xw-1c
 for kexec@lists.infradead.org; Thu, 23 Aug 2018 04:08:30 +0000
Message-ID: <1534997281.5153.3.camel@gmx.de>
Subject: Re: [PATCH] x86, kdump: Fix efi=noruntime NULL pointer dereference
From: Mike Galbraith <efault@gmx.de>
Date: Thu, 23 Aug 2018 06:08:01 +0200
In-Reply-To: <20180823035705.GA5743@dhcp-128-65.nay.redhat.com>
References: <1533737025.4936.3.camel@gmx.de>
 <20180809042153.GA4377@dhcp-128-65.nay.redhat.com>
 <1533800010.5087.71.camel@gmx.de>
 <20180809091333.GA8008@dhcp-128-65.nay.redhat.com>
 <CAKv+Gu8KKwNkUdx7tSxEosRvydxmQ2yaasHRJn_LcHPs7p2UYQ@mail.gmail.com>
 <20180822102310.GA19827@dhcp-128-65.nay.redhat.com>
 <20180823035705.GA5743@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
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
To: Dave Young <dyoung@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-efi <linux-efi@vger.kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>

On Thu, 2018-08-23 at 11:57 +0800, Dave Young wrote:
> 
> Mike, since we are going this way, I'm working on a kexec code cleanup,
> but it needs careful testing so still need some time.
> 
> Can you help test below efi fix and provide you tested-by if it works?

Sure.  I'm buried to the eyebrows atm (why no patchlet has appeared in
your inbox), but I'll get to it.

	-Mike

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
