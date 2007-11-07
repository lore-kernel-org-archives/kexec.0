Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.66 #1 (Red Hat Linux))
	id 1IplRx-0007u6-IA
	for kexec@lists.infradead.org; Wed, 07 Nov 2007 09:00:16 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lA7E086L009294
	for <kexec@lists.infradead.org>; Wed, 7 Nov 2007 09:00:08 -0500
Date: Wed, 7 Nov 2007 09:00:06 -0500
From: Neil Horman <nhorman@redhat.com>
Subject: Timer interrupt lost on some x86_64 systems
Message-ID: <20071107140006.GC14371@hmsendeavour.rdu.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: nhorman@redhat.com

Hey all-
	I've been getting reports of some x86_64 systems that, on kdump kernel
boot get stuck in calibrate_delay(),  in both RHEL kernels and upstream kernels.
The current thinking is that the lapic timer interrupt is no longer getting
delivered, likely because we handle a crash condition on a cpu that isn't the
boot cpu.  One known offender is this motherboard:
http://www.supermicro.com/Aplus/motherboard/Opteron8000/MCP55/H8QM8-2.cfm
My current thought is that the TIMER_LVT entry is masked on all but the boot cpu
on this system (which is strange, as I was under the impression that the timer
interrupt was supposed to be enabled on all CPU's nominally.  At any rate, I was
going to try to read/write the TIMER_LVT on the crashing processor before we
jump to purgatory, or in purgatory itself, to see if that fixes the problem, but
I wanted to report the issue here to see if anyone had any alternate thoughts.
I know that intel ioapics had a timer related problem recently that caused the
same issue, but the fix doesn't seem to help in this case.

Thanks & Regards
Neil

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
