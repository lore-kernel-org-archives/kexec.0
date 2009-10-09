Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MwA7F-000771-UT
	for kexec@lists.infradead.org; Fri, 09 Oct 2009 07:42:22 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n997gFRH009307
	for <kexec@lists.infradead.org>; Fri, 9 Oct 2009 03:42:15 -0400
Message-ID: <4ACEE9F5.2020306@redhat.com>
Date: Fri, 09 Oct 2009 15:44:53 +0800
From: Amerigo Wang <amwang@redhat.com>
MIME-Version: 1.0
Subject: Re: Kdump Failed with 2.6.31 i386
References: <20091009.120533.370613410103983527.caiqian@redhat.com>
In-Reply-To: <20091009.120533.370613410103983527.caiqian@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: CAI Qian <caiqian@redhat.com>
Cc: nhorman@redhat.com, kexec@lists.infradead.org

CAI Qian wrote:
> Hallo!
> 
> Is it a known issue that kdump failed with 2.6.31 i386 systems? The
> kdump kernel seems hang here.
> 
> ...
> Spurious LAPIC timer interrupt on cpu 0
> Console: colour VGA+ 80x25
> console handover: boot [earlyser0] -> real [ttyS0]
> Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> ... MAX_LOCKDEP_SUBCLASSES:  8
> ... MAX_LOCK_DEPTH:          48
> ... MAX_LOCKDEP_KEYS:        8191
> ... CLASSHASH_SIZE:          4096
> ... MAX_LOCKDEP_ENTRIES:     16384
> ... MAX_LOCKDEP_CHAINS:      32768
> ... CHAINHASH_SIZE:          16384
>  memory used by lock dependency info: 3743 kB
>  per task-struct memory footprint: 1920 bytes
> HPET: 3 timers in total, 0 timers will be used for per-cpu timer
> Clocksource tsc unstable (delta = 577041676100 ns)
> 


This case hangs on setup_irq(0, &irq0). We already knew this.

> or
> 
> Spurious LAPIC timer interrupt on cpu 0
> Console: colour VGA+ 80x25
> console [ttyS0] enabled
> Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> ... MAX_LOCKDEP_SUBCLASSES:  8
> ... MAX_LOCK_DEPTH:          48
> ... MAX_LOCKDEP_KEYS:        8191
> ... CLASSHASH_SIZE:          4096
> ... MAX_LOCKDEP_ENTRIES:     16384
> ... MAX_LOCKDEP_CHAINS:      32768
> ... CHAINHASH_SIZE:          16384
>  memory used by lock dependency info: 3743 kB
>  per task-struct memory footprint: 1920 bytes
> allocated 2621440 bytes of page_cgroup
> please try 'cgroup_disable=memory' option if you don't want memory cgroups
> Calibrating delay loop (skipped), value calculated using timer frequency.. 
> 5986.01 BogoMIPS (lpj=2993008)

This case hangs after calibrate_delay() which already passed 
late_time_init(), and probably before security_init()...
(since probably you have CONFIG_SECURITY=y)

Did you meet these two cases on the same machine? Or on different machines?

Thanks.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
