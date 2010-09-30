Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]
	helo=TX2EHSOBE008.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1P1LcV-0006oZ-Ex
	for kexec@lists.infradead.org; Thu, 30 Sep 2010 16:04:32 +0000
Subject: Re: Can't kexec/kdump on mpc85xx
MIME-Version: 1.0 (Apple Message framework v1081)
From: Matthew McClintock <msm@freescale.com>
In-Reply-To: <4CA46477.80704@miraclelinux.com>
Date: Thu, 30 Sep 2010 11:03:36 -0500
Message-ID: <2FD3D9F4-137C-4044-B4F7-2E62254F2DC8@freescale.com>
References: <4C9FFA9E.4080705@miraclelinux.com>
	<81FA9276-7283-4106-9155-83F17327D496@freescale.com>
	<4CA163C5.1060704@miraclelinux.com>
	<F2D9449F-2C78-4051-B1A9-32BD3CEF9366@freescale.com>
	<4CA2FAE9.3010109@miraclelinux.com>
	<1880BF7C-E151-401D-B20A-EC1113B92A6F@freescale.com>
	<4CA46477.80704@miraclelinux.com>
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


On Sep 30, 2010, at 5:20 AM, Makito SHIOKAWA wrote:

> (2010/09/30 0:58), Matthew McClintock wrote:
> 
>> There are some other patches I sent upstream after 2.6.35 that fix these issues...
> 
> I've missed your recent patches. After applying below patches to linux-2.6.35, CONFIG_CRASH_DUMP, CONFIG_PROC_VMCORE were settable and second kernel booted normally on "kexec -p".
> 
> * powerpc/kexec: Adds correct calling convention for kexec purgatory
> * powerpc/85xx: kexec for SMP 85xx BookE systems
> * powerpc/crashdump: Fix issues with kexec and 36bit physical addr
> 
> And at last, I could see /proc/vmcore!
> 

What compiler were you using? One from Freescale or did you build your own?

-M



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
