Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtprelay02.ispgateway.de ([80.67.31.36])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NE5iu-0001vG-AU
	for kexec@lists.infradead.org; Fri, 27 Nov 2009 18:39:20 +0000
Message-ID: <4B101CCD.8030909@bwalle.de>
Date: Fri, 27 Nov 2009 19:39:09 +0100
From: Bernhard Walle <bernhard@bwalle.de>
MIME-Version: 1.0
Subject: Re: [PATCH] Reserve memory for kdump kernel within RMO region
References: <20091125131747.GA28857@in.ibm.com>
	<4B0D7CF4.8040402@bwalle.de>	<4B0E628A.9070009@in.ibm.com>
	<4B0ED674.6050501@bwalle.de> <4B0FCC0C.8060103@in.ibm.com>
In-Reply-To: <4B0FCC0C.8060103@in.ibm.com>
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
To: "M. Mohan Kumar" <mohan@in.ibm.com>
Cc: michael@ellerman.id.au, benh@kernel.crashing.org, kexec@lists.infradead.org, ppcdev <linuxppc-dev@ozlabs.org>

M. Mohan Kumar schrieb:
> Hi,
> 
> As of now the kdump kernel base is fixed to be 32MB. The intention of 
> this patch is to modify that behaviour (for relocatable kernels)
> 
> * Regular kernel size may exceed 32MB, in this case we can't have kdump 
> kernelbase as 32MB.
> 
> * crashkernel=auto also assumes that kdump kernelbase as 32MB, and it 
> may also fail in reserving memory for kdump kernel.

I'm not opposed to remove the 32MB restriction, but I would like to make
the behaviour independent of CONFIG_RELOCATABLE like it's on x86:

 - Use 32M if one specifies xxx@32M
 - Use preferrably 32M, but fall back to another address if one
   specifies xxx or xxx@0M.

I don't see any problem with that. But it would make behaviour equal
accross platforms.



Regards,
Bernhard



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
