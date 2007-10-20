Return-path: <kexec-bounces@lists.infradead.org>
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Ij2zY-0007Jv-Hw
	for kexec@lists.infradead.org; Sat, 20 Oct 2007 02:19:06 +0100
Message-ID: <47195763.1090803@ct.jp.nec.com>
Date: Fri, 19 Oct 2007 18:18:27 -0700
From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
MIME-Version: 1.0
Subject: [PATCH 0/3] x86: unify crash_32/64.c
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
To: vgoyal@in.ibm.com, hbabu@us.ibm.com, tglx@linutronix.de
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Hi,

I made patches to unify crash_32/64.c.
There are three patches;
1. add lapic_shutdown for x86_64
2. add safe_smp_processor_id for x86_64
3. unify crash_32/64.c

I'm not sure that it's good to split to these patches.

I've compiled on both of 32bit and 64bit, and tested
kdump on 64bit.

Thanks
Hiroshi Shimamoto

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
