Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailgw.miraclelinux.com ([122.212.45.247])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1P1W5Z-0006iO-AE
	for kexec@lists.infradead.org; Fri, 01 Oct 2010 03:15:14 +0000
Message-ID: <4CA55247.7050607@miraclelinux.com>
Date: Fri, 01 Oct 2010 12:15:19 +0900
From: Makito SHIOKAWA <mshiokawa@miraclelinux.com>
MIME-Version: 1.0
Subject: Re: Can't kexec/kdump on mpc85xx
References: <4C9FFA9E.4080705@miraclelinux.com>
	<81FA9276-7283-4106-9155-83F17327D496@freescale.com>
	<4CA163C5.1060704@miraclelinux.com>
	<F2D9449F-2C78-4051-B1A9-32BD3CEF9366@freescale.com>
	<4CA2FAE9.3010109@miraclelinux.com>
	<1880BF7C-E151-401D-B20A-EC1113B92A6F@freescale.com>
	<4CA46477.80704@miraclelinux.com>
	<2FD3D9F4-137C-4044-B4F7-2E62254F2DC8@freescale.com>
In-Reply-To: <2FD3D9F4-137C-4044-B4F7-2E62254F2DC8@freescale.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Matthew McClintock <msm@freescale.com>
Cc: kexec@lists.infradead.org

(2010/10/01 1:03), Matthew McClintock wrote:

> What compiler were you using? One from Freescale or did you build your own?

Do you mean a cross compiler I was using before "Sourcery G++ Lite 4.4-254 for 
Power GNU/Linux"? Then, it is a one build by my own (gcc-4.1.1, glibc-2.5), 
but I get compile errors building 2.6.35 so I'm not using it.

-- 
Makito SHIOKAWA <mshiokawa@miraclelinux.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
