Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from am1ehsobe003.messaging.microsoft.com ([213.199.154.206]
	helo=AM1EHSOBE003.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1P0z62-0008JS-6X
	for kexec@lists.infradead.org; Wed, 29 Sep 2010 16:01:32 +0000
Subject: Re: Can't kexec/kdump on mpc85xx
MIME-Version: 1.0 (Apple Message framework v1081)
From: Matthew McClintock <msm@freescale.com>
In-Reply-To: <4CA2FAE9.3010109@miraclelinux.com>
Date: Wed, 29 Sep 2010 11:01:17 -0500
Message-ID: <EC24EA34-B565-4EBA-8D05-1539F4E1862C@freescale.com>
References: <4C9FFA9E.4080705@miraclelinux.com>
	<81FA9276-7283-4106-9155-83F17327D496@freescale.com>
	<4CA163C5.1060704@miraclelinux.com>
	<F2D9449F-2C78-4051-B1A9-32BD3CEF9366@freescale.com>
	<4CA2FAE9.3010109@miraclelinux.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Makito SHIOKAWA <mshiokawa@miraclelinux.com>, kexec@lists.infradead.org


On Sep 29, 2010, at 3:38 AM, Makito SHIOKAWA wrote:

> (2010/09/29 0:47), Matthew McClintock wrote:
> 
>> Can you try this patch below when building kexec-tools? I ran in to an issue with my cross compiler...
> 
> Second kernel has booted normally on both "kexec -l", "kexec -p" with your patch! I've been working for this long time and could never find out this issue, big thanks!

Eric,

This is related to my other thread about compiler optimizations:

http://lists.infradead.org/pipermail/kexec/2010-September/004534.html

I would like to get this working on ppc32 these commonly used cross compilers. Can we just disable optimizations for ppc32 entirely for now?

-M




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
