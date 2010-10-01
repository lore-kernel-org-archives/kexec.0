Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]
	helo=VA3EHSOBE005.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1P1WIp-00016K-19
	for kexec@lists.infradead.org; Fri, 01 Oct 2010 03:28:55 +0000
Subject: Re: Can't kexec/kdump on mpc85xx
MIME-Version: 1.0 (Apple Message framework v1081)
From: Matthew McClintock <msm@freescale.com>
In-Reply-To: <4CA55247.7050607@miraclelinux.com>
Date: Thu, 30 Sep 2010 22:28:59 -0500
Message-ID: <D6F82B2A-C284-42D4-A296-5C5F5AA2D7E2@freescale.com>
References: <4C9FFA9E.4080705@miraclelinux.com>
	<81FA9276-7283-4106-9155-83F17327D496@freescale.com>
	<4CA163C5.1060704@miraclelinux.com>
	<F2D9449F-2C78-4051-B1A9-32BD3CEF9366@freescale.com>
	<4CA2FAE9.3010109@miraclelinux.com>
	<1880BF7C-E151-401D-B20A-EC1113B92A6F@freescale.com>
	<4CA46477.80704@miraclelinux.com>
	<2FD3D9F4-137C-4044-B4F7-2E62254F2DC8@freescale.com>
	<4CA55247.7050607@miraclelinux.com>
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
To: Makito SHIOKAWA <mshiokawa@miraclelinux.com>
Cc: kexec@lists.infradead.org


On Sep 30, 2010, at 10:15 PM, Makito SHIOKAWA wrote:

> (2010/10/01 1:03), Matthew McClintock wrote:
> 
>> What compiler were you using? One from Freescale or did you build your own?
> 
> Do you mean a cross compiler I was using before "Sourcery G++ Lite 4.4-254 for Power GNU/Linux"? Then, it is a one build by my own (gcc-4.1.1, glibc-2.5), but I get compile errors building 2.6.35 so I'm not using it.
> 
> -- 
> Makito SHIOKAWA <mshiokawa@miraclelinux.com>
> 

That is what I was looking for. I was having the purgatory optimization issue with that exact same compiler.

-M

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
