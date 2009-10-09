Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Mw6iR-0002Qr-My
	for kexec@lists.infradead.org; Fri, 09 Oct 2009 04:04:32 +0000
Received: from int-mx08.intmail.prod.int.phx2.redhat.com
	(int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n9944PL6018499
	for <kexec@lists.infradead.org>; Fri, 9 Oct 2009 00:04:25 -0400
Date: Fri, 09 Oct 2009 12:05:33 +0800 (CST)
Message-Id: <20091009.120533.370613410103983527.caiqian@redhat.com>
Subject: Kdump Failed with 2.6.31 i386
From: CAI Qian <caiqian@redhat.com>
Mime-Version: 1.0
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
To: kexec@lists.infradead.org
Cc: nhorman@redhat.com, amwang@redhat.com, caiqian@redhat.com

Hallo!

Is it a known issue that kdump failed with 2.6.31 i386 systems? The
kdump kernel seems hang here.

...
Spurious LAPIC timer interrupt on cpu 0
Console: colour VGA+ 80x25
console handover: boot [earlyser0] -> real [ttyS0]
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8191
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     16384
... MAX_LOCKDEP_CHAINS:      32768
... CHAINHASH_SIZE:          16384
 memory used by lock dependency info: 3743 kB
 per task-struct memory footprint: 1920 bytes
HPET: 3 timers in total, 0 timers will be used for per-cpu timer
Clocksource tsc unstable (delta = 577041676100 ns)

or

Spurious LAPIC timer interrupt on cpu 0
Console: colour VGA+ 80x25
console [ttyS0] enabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8191
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     16384
... MAX_LOCKDEP_CHAINS:      32768
... CHAINHASH_SIZE:          16384
 memory used by lock dependency info: 3743 kB
 per task-struct memory footprint: 1920 bytes
allocated 2621440 bytes of page_cgroup
please try 'cgroup_disable=memory' option if you don't want memory cgroups
Calibrating delay loop (skipped), value calculated using timer frequency.. 
5986.01 BogoMIPS (lpj=2993008)

Thanks!
CAI Qian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
