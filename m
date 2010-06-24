Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 24 Jun 2010 11:19:15 +0300
From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: Re: [PATCH 3/3] add ARM crashdump support
Message-ID: <20100624081915.GF29920@esdhcp04058.research.nokia.com>
References: <cover.1277188127.git.ext-mika.1.westerberg@nokia.com>
	<b567a76e7f4502ccd56f818ebd3d6509ebd4a96d.1277188128.git.ext-mika.1.westerberg@nokia.com>
	<20100624163356.dbb849bc.igawa@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100624163356.dbb849bc.igawa@mxs.nes.nec.co.jp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ext Masayuki Igawa <igawa@mxs.nes.nec.co.jp>
Cc: "oomichi@mxs.nes.nec.co.jp" <oomichi@mxs.nes.nec.co.jp>, "tachibana@mxm.nes.nec.co.jp" <tachibana@mxm.nes.nec.co.jp>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Jun 24, 2010 at 09:33:56AM +0200, ext Masayuki Igawa wrote:
> Hi, Mika.

(...)

> > +unsigned long long
> > +vaddr_to_paddr_arm(unsigned long vaddr)
> > +{
> > +	unsigned long long paddr;
> > +
> > +	if ((paddr = vaddr_to_paddr_general(vaddr)) != NOT_PADDR)
> > +		return paddr;
> 
> Here is a checkpatche.pl's error.
> ====
> ERROR: do not use assignment in if condition
> #303: FILE: arm.c:189:
> +       if ((paddr = vaddr_to_paddr_general(vaddr)) != NOT_PADDR)
> 
> total: 1 errors, 0 warnings, 261 lines checked
> ====

Ah, didn't notice that. Thanks.

> How about is this?
> ====
> +unsigned long long
> +vaddr_to_paddr_arm(unsigned long vaddr)
> +{
> +	unsigned long long paddr = vaddr_to_paddr_general(vaddr);
> +
> +	if (paddr != NOT_PADDR)
> +		return paddr;
> ====

Yeah, looks OK to me.

Do you want me to send a revisited version of the patches or do you change that
yourself?

> BTW, I'm testing these patches for x86/x86_64 arch now.
> I'll merge these patches after my testing.

Cool, thanks.

> But I cannot test for ARM because have no test machines of ARM.

Well I can do the testing for ARM (unless someone else, who is using ARM kdump
currently, wants to test this). If the above is the only change it should still
work.

Thanks,
MW

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
