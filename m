Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbzoT-0005Gq-BP
 for kexec@lists.infradead.org; Wed, 26 Dec 2018 03:24:54 +0000
Date: Wed, 26 Dec 2018 11:24:33 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 1/2 v3] kdump: add the vmcoreinfo documentation
Message-ID: <20181226032433.GB13556@dhcp-128-65.nay.redhat.com>
References: <20181216131617.2612-1-lijiang@redhat.com>
 <20181216131617.2612-2-lijiang@redhat.com>
 <20181217130024.GD12165@zn.tnic>
 <826c1a6b-41da-bc1a-f9c2-0d52e774b572@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <826c1a6b-41da-bc1a-f9c2-0d52e774b572@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: lijiang <lijiang@redhat.com>
Cc: bhe@redhat.com, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, Borislav Petkov <bp@alien8.de>, tglx@linutronix.de, akpm@linux-foundation.org

> >> +
> >> +KERNEL_IMAGE_SIZE
> >> +=================
> >> +The size of 'KERNEL_IMAGE_SIZE', currently unused.
> > 
> > So remove?
> > 
> 
> I'm not sure whether it should be removed, so i keep it.

Just remove it.  It was added by Baoquan for KASLR issues, later
makedumpfile reverted the userspace part and added other implementation.

In case old makedumpfile does not support new kernel, it has some kernel
versions support list in code, thus no worry about the compatibility
issue.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
