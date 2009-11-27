Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ew0-f211.google.com ([209.85.219.211])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NDx8h-0004W6-IC
	for kexec@lists.infradead.org; Fri, 27 Nov 2009 09:29:24 +0000
Received: by ewy3 with SMTP id 3so1836473ewy.2
	for <kexec@lists.infradead.org>; Fri, 27 Nov 2009 01:29:18 -0800 (PST)
From: Yuri Bushmelev <jay4mail@gmail.com>
Subject: Re: [PATCH] kexec.c: workaround getline and fscanf to make it *libc
	agnostic. Tested against klibc and dietlibc.
Date: Fri, 27 Nov 2009 12:26:40 +0300
References: <1258845169-4999-1-git-send-email-andrea.adami@gmail.com>
	<4B0ED6D6.8040005@bwalle.de> <20091126214212.GA11254@verge.net.au>
In-Reply-To: <20091126214212.GA11254@verge.net.au>
MIME-Version: 1.0
Message-Id: <200911271226.40338.jay4mail@gmail.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: Bernhard Walle <bernhard@bwalle.de>, Andrea Adami <andrea.adami@gmail.com>, kexec@lists.infradead.org

Hello!
> On Thu, Nov 26, 2009 at 08:28:22PM +0100, Bernhard Walle wrote:
> > Yuri Bushmelev schrieb:
> > > That is form of 'early bug detection' of mistyped '=='.
> > > E.g. you can write by mistype
> > > 	if (p = NULL) {}
> > > but can't
> > > 	if (NULL = p) {}
> > > because you will get compiler error.
> >
> > I know that kind of argument. However, it makes code IMO quite
> > unreadable since it's uncommon at least in the kernel code. And that's
> > the coding style we follow in kexec.
> >
> > BTW: gcc warns about 'if (p = NULL)' anyways ...

Ok, np :)

> I agree with Bernhard, though Yuri's point is a good one.
> 
> This aside, is everyone happy with the patch?
> I'd like to merge it if possible.

Merge it please!

-- 
Yuri Bushmelev

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
