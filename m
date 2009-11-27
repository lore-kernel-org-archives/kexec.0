Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtprelay03.ispgateway.de ([80.67.31.26])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NDutF-0003JD-UE
	for kexec@lists.infradead.org; Fri, 27 Nov 2009 07:05:18 +0000
Message-ID: <4B0F7A25.8040303@bwalle.de>
Date: Fri, 27 Nov 2009 08:05:09 +0100
From: Bernhard Walle <bernhard@bwalle.de>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec.c: workaround getline and fscanf to make it *libc
	agnostic. Tested against klibc and dietlibc.
References: <1258845169-4999-1-git-send-email-andrea.adami@gmail.com>
	<4B0DBFA4.7090009@bwalle.de> <20091126001410.GA853@verge.net.au>
	<200911261334.10310.jay4mail@gmail.com>
	<4B0ED6D6.8040005@bwalle.de> <20091126214212.GA11254@verge.net.au>
In-Reply-To: <20091126214212.GA11254@verge.net.au>
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
Cc: Andrea Adami <andrea.adami@gmail.com>, kexec@lists.infradead.org, Yuri Bushmelev <jay4mail@gmail.com>

Simon Horman schrieb:
> This aside, is everyone happy with the patch?
> I'd like to merge it if possible.

No objections from my side.


Regards,
Bernhard


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
