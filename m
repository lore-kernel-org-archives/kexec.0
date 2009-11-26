Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NDm6R-0001ET-CW
	for kexec@lists.infradead.org; Thu, 26 Nov 2009 21:42:19 +0000
Date: Fri, 27 Nov 2009 08:42:12 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec.c: workaround getline and fscanf to make it
	*libc agnostic. Tested against klibc and dietlibc.
Message-ID: <20091126214212.GA11254@verge.net.au>
References: <1258845169-4999-1-git-send-email-andrea.adami@gmail.com>
	<4B0DBFA4.7090009@bwalle.de> <20091126001410.GA853@verge.net.au>
	<200911261334.10310.jay4mail@gmail.com>
	<4B0ED6D6.8040005@bwalle.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4B0ED6D6.8040005@bwalle.de>
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
To: Bernhard Walle <bernhard@bwalle.de>
Cc: Andrea Adami <andrea.adami@gmail.com>, kexec@lists.infradead.org, Yuri Bushmelev <jay4mail@gmail.com>

On Thu, Nov 26, 2009 at 08:28:22PM +0100, Bernhard Walle wrote:
> Yuri Bushmelev schrieb:
> > 
> > That is form of 'early bug detection' of mistyped '=='.
> > E.g. you can write by mistype
> > 	if (p = NULL) {}
> > but can't
> > 	if (NULL = p) {}
> > because you will get compiler error.
> > 
> 
> I know that kind of argument. However, it makes code IMO quite
> unreadable since it's uncommon at least in the kernel code. And that's
> the coding style we follow in kexec.
> 
> BTW: gcc warns about 'if (p = NULL)' anyways ...

I agree with Bernhard, though Yuri's point is a good one.

This aside, is everyone happy with the patch?
I'd like to merge it if possible.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
