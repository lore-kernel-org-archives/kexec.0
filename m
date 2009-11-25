Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtprelay03.ispgateway.de ([80.67.18.15])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NDMyr-0003Tn-OW
	for kexec@lists.infradead.org; Wed, 25 Nov 2009 18:52:50 +0000
Message-ID: <4B0D7CF4.8040402@bwalle.de>
Date: Wed, 25 Nov 2009 19:52:36 +0100
From: Bernhard Walle <bernhard@bwalle.de>
MIME-Version: 1.0
Subject: Re: [PATCH] Reserve memory for kdump kernel within RMO region
References: <20091125131747.GA28857@in.ibm.com>
In-Reply-To: <20091125131747.GA28857@in.ibm.com>
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
To: mohan@in.ibm.com
Cc: michael@ellerman.id.au, benh@kernel.crashing.org, kexec@lists.infradead.org, ppcdev <linuxppc-dev@ozlabs.org>

M. Mohan Kumar schrieb:
> Reserve memory for kdump kernel within RMO region
> 
> When the kernel size exceeds 32MB(observed with some distros), memory
> for kdump kernel can not be reserved as kdump kernel base is assumed to
> be 32MB always. When the kernel has CONFIG_RELOCATABLE option enabled,
> provide the feature to reserve the memory for kdump kernel anywhere in
> the RMO region.

Correct me if I'm wrong, but: CONFIG_RELOCATABLE is for the kernel that
gets loaded as crashkernel, not for the kernel that loads the
crashkernel. So it would be perfectly fine that a kernel that has not
CONFIG_RELOCATABLE set would load another kernel that has
CONFIG_RELOCATABLE set on an address != 32 M.

So it would be part of the command line to determine whether a fixed or
a variable address is used. The system configuration (or the admin)
knows both: if the kernel that should be loaded is relocatable (can be
detected with the x86 bzImage header or with the ELF type for vmlinux)
and it can also influence the boot command line.

To sum it up: I'm not against reserving it anywhere, I'm only against
making it dependent on CONFIG_RELOCATABLE which has another function.



Regards,
Bernhard


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
