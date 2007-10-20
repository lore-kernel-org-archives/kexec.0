Return-path: <kexec-bounces@lists.infradead.org>
Received: from www.tglx.de ([62.245.132.106])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IjBvQ-0007wz-Bi
	for kexec@lists.infradead.org; Sat, 20 Oct 2007 11:51:26 +0100
Date: Sat, 20 Oct 2007 12:50:03 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/3] x86: unify crash_32/64.c
In-Reply-To: <47195763.1090803@ct.jp.nec.com>
Message-ID: <alpine.LFD.0.9999.0710201249050.22770@localhost.localdomain>
References: <47195763.1090803@ct.jp.nec.com>
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
Cc: hbabu@us.ibm.com, vgoyal@in.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, 19 Oct 2007, Hiroshi Shimamoto wrote:

> Hi,
> 
> I made patches to unify crash_32/64.c.
> There are three patches;
> 1. add lapic_shutdown for x86_64
> 2. add safe_smp_processor_id for x86_64
> 3. unify crash_32/64.c
> 
> I'm not sure that it's good to split to these patches.

It's fine. So the steps leading to unification are clear.

Applied. Thanks,

	 tglx


	

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
