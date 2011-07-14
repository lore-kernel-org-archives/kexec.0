Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2001:470:1f0b:1c35:abcd:42:0:1])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QhO25-0008NR-OQ
	for kexec@lists.infradead.org; Thu, 14 Jul 2011 15:40:58 +0000
Date: Thu, 14 Jul 2011 17:40:42 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] powerpc32: Kexec support for PPC440X chipsets
Message-ID: <20110714154042.GA14975@linutronix.de>
References: <20110712064356.28567.48722.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110712064356.28567.48722.stgit@suzukikp.in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Cc: Benjammin Herrenschmidt <benh@kernel.crashing.org>, kexec <kexec@lists.infradead.org>, Kumar Gala <galak@kernel.crashing.org>, lkml <linux-kernel@vger.kernel.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, linux ppc dev <linuxppc-dev@lists.ozlabs.org>, Vivek Goyal <vgoyal@redhat.com>

* Suzuki K. Poulose | 2011-07-12 12:14:16 [+0530]:

>Changes from V1: Uses a tmp mapping in the other address space to setup
>		 the 1:1 mapping (suggested by Sebastian Andrzej Siewior).
>
>Note: Should we do the same for kernel entry code for PPC44x ?

You have one the kernel mapping. Then you make your temporary mapping
which might be just the one valid TLB entry (after you invalidated the
others). After that you setup multiple mappings to cover 0..2GiB address
space. Since the kernel runs at 0xC.... and you need 0x0.. for the same
memory you end up at some point with two mappings for the same memory.
The reference manual says one should not have two active mappings for
piece of memory. That is why the "other address space" is should be
used.
So I think using this "other address space" for the entry code isn't a
bad idea.

However, I'm fine with this patch.

Sebastian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
