Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtprelay04.ispgateway.de ([80.67.18.16])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NDk0w-0001WR-T9
	for kexec@lists.infradead.org; Thu, 26 Nov 2009 19:28:31 +0000
Message-ID: <4B0ED6D6.8040005@bwalle.de>
Date: Thu, 26 Nov 2009 20:28:22 +0100
From: Bernhard Walle <bernhard@bwalle.de>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec.c: workaround getline and fscanf to make it *libc
	agnostic. Tested against klibc and dietlibc.
References: <1258845169-4999-1-git-send-email-andrea.adami@gmail.com>	<4B0DBFA4.7090009@bwalle.de>
	<20091126001410.GA853@verge.net.au>
	<200911261334.10310.jay4mail@gmail.com>
In-Reply-To: <200911261334.10310.jay4mail@gmail.com>
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
To: Yuri Bushmelev <jay4mail@gmail.com>
Cc: Andrea Adami <andrea.adami@gmail.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

Yuri Bushmelev schrieb:
> 
> That is form of 'early bug detection' of mistyped '=='.
> E.g. you can write by mistype
> 	if (p = NULL) {}
> but can't
> 	if (NULL = p) {}
> because you will get compiler error.
> 

I know that kind of argument. However, it makes code IMO quite
unreadable since it's uncommon at least in the kernel code. And that's
the coding style we follow in kexec.

BTW: gcc warns about 'if (p = NULL)' anyways ...


Regards,
Bernhard


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
