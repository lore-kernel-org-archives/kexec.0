Return-path: <kexec-bounces@lists.infradead.org>
Received: from www.tglx.de ([62.245.132.106])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IlXpm-00041h-RA
	for kexec@lists.infradead.org; Fri, 26 Oct 2007 23:39:21 +0100
Date: Sat, 27 Oct 2007 00:37:37 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/3] x86: unify crash_32/64.c
In-Reply-To: <47225F6C.5000708@ct.jp.nec.com>
Message-ID: <alpine.LFD.0.9999.0710270035110.3186@localhost.localdomain>
References: <47195763.1090803@ct.jp.nec.com> <20071024063434.GC4622@in.ibm.com>
	<471F72AD.8030902@ct.jp.nec.com> <4720D933.3080703@ct.jp.nec.com>
	<47225F6C.5000708@ct.jp.nec.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces@lists.infradead.org
To: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Cc: hbabu@us.ibm.com, vgoyal@in.ibm.com, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Venkatesch Pallipadi <venkatesh.pallipadi@intel.com>

On Fri, 26 Oct 2007, Hiroshi Shimamoto wrote:

Added Venki to CC

> > I'm now testing crash on 32bit, but there is an issue before
> > applying the patches. My machine stopped at checking 'hlt'
> > after kexec, showing below message.
> > 
> > CPU: Intel(R) Xeon(TM) CPU 3.80GHz stepping 0a
> > Checking 'hlt' instruction...
> > 
> v2.6.23.1 works fine for 1st kernel.
> > I'm investigating it..
> 
> I found that the following patch makes my machine stopped.
> bfe0c1cc6456bba1f4e3cc1fe29c0ea578ac763a
> x86: HPET force enable for ICH5
> 
> It means that after applied this patch, HPET is enabled
> automatically on 1st kernel and after crash/kexec the 2nd
> kernel stopped at checking 'hlt'.
> 
> I also tested the latest kernel(2.6.24-rc1-gec3b67c1).
> Boot parameter "nohpet" resolves this issue and kdump
> works well on 32bit.
> So I guess HPET affects this.
> But I don't know why 64bit kernel with HPET is OK.

Hmm. Does the 64 bit code shutdown HPET and restore the IRQ routing to
PIT and 32 bit is missing this ?

    tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
