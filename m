Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Ot7vR-0002Wi-CQ
	for kexec@lists.infradead.org; Tue, 07 Sep 2010 23:50:07 +0000
From: Michael Neuling <mikey@neuling.org>
Subject: Re: kexec on ppc64
In-reply-to: <0D324CAF-2A5D-4363-9000-7EB48179C11C@freescale.com>
References: <0D324CAF-2A5D-4363-9000-7EB48179C11C@freescale.com>
Date: Wed, 08 Sep 2010 09:49:59 +1000
Message-ID: <19803.1283903399@neuling.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Matthew McClintock <msm@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org

> I'm trying to determine how kexec'ing works on 64 bit powerpc. When
> allocating a region for the kexec'ed kernel is it ever the same as the
> currently running kernel or do you always boot the kexec'ed kernel
> from a different memory region? I understand that a crash kernel will
> be in a different region, however I was hoping to confirm the behavior
> for a normal "kexec -e".

The kernel will be loaded at a non zero address, but it will copy itself
to zero before it starts running.

Mikey

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
