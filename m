Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtprelay04.ispgateway.de ([80.67.18.16])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NDRQD-0001Yu-Dl
	for kexec@lists.infradead.org; Wed, 25 Nov 2009 23:37:21 +0000
Message-ID: <4B0DBFA4.7090009@bwalle.de>
Date: Thu, 26 Nov 2009 00:37:08 +0100
From: Bernhard Walle <bernhard@bwalle.de>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec.c: workaround getline and fscanf to make it *libc
	agnostic. Tested against klibc and dietlibc.
References: <1258845169-4999-1-git-send-email-andrea.adami@gmail.com>
	<20091122050350.GF2728@verge.net.au> <4B09034E.40309@bwalle.de>
	<20091125231752.GL4794@verge.net.au>
In-Reply-To: <20091125231752.GL4794@verge.net.au>
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
Cc: Andrea Adami <andrea.adami@gmail.com>, Yuri Bushmelev <jay4mail@gmail.com>, kexec@lists.infradead.org

Simon Horman schrieb:
>  
> +
> +	if ( NULL == p)
> +		return -1;

Wouldn't that be better 'p == NULL'?

> +	ret = strtol(line, &p, 10);
> +
> +	/* Too long */
> +	if (ret > INT_MAX)
> +		return -1;

An integer that can be represented in 2 (strlen("__\0")==3) cannot be
larger than INT_MAX on any platform I can imagine. ;-)




Regards,
Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
