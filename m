Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate7.uk.ibm.com ([194.196.100.167])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qrs6r-0001vD-O9
	for kexec@lists.infradead.org; Fri, 12 Aug 2011 13:49:15 +0000
Received: from d06nrmr1307.portsmouth.uk.ibm.com
	(d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate7.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p7CDn8gf021242
	for <kexec@lists.infradead.org>; Fri, 12 Aug 2011 13:49:08 GMT
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
	[9.149.37.250])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p7CDn7J11994768
	for <kexec@lists.infradead.org>; Fri, 12 Aug 2011 14:49:07 +0100
Received: from d06av09.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p7CDn7qK027778
	for <kexec@lists.infradead.org>; Fri, 12 Aug 2011 07:49:07 -0600
Message-Id: <20110812134849.748973593@linux.vnet.ibm.com>
Date: Fri, 12 Aug 2011 15:48:49 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch v3 0/8] kdump: Patch series for s390 support (version 3)
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: vgoyal@redhat.com
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

Hello Vivek,

I updated the patch series according to our last discussions. As you requested,
I removed the "#if !defined(CONFIG_S390)" in the panic function.

The semantics is now as follows:

If kdump is loaded, kdump is always triggered for panic and PSW restart
(s390 NMI). If kdump is not loaded, the s390 shutdown actions defined
under /sys/firmware are executed as we are doing it already today.

I also added again patches for stand-alone dump integration:

For s390 we add a parameter to the purgatory entry point. When "0" is passed,
purgatory only returns the result of the checksum test. When "1" is passed,
purgatory triggers kdump. So we call purgatory twice. First for checking and
second time for execution. You can argue that it would be better to call
purgatory only once and it returns only, if checksums are invalid.
Unfortunately this would be very hard to implement for us, because we
switch to the boot CPU before kdump is finally triggered and after that
currently it is not possible to return from the called function.

panic --------+
              +--- crash_kexec()
              |    call_s390_shutdown_actions() -> stand-alone dump
PSW restart --+

crash_kexec +--> kdump loaded? --> machine_kexec()
            |
            +--> kdump not loaded --> return

machine_kexec +-> purgatory(0)==0 -> switch to IPL cpu -> purgatory(1) -> kdump
              |
              +-> purgatory(0)!=0 -> return

See patches [6] and [8] for details.

Does that sound ok for you?

Michael

Patch overview:
---------------
[1-3] common code changes (could you please ACC patches [1] and [3]?)
[4]   s390 kdump preparation patch
[5]   s390 kdump backend
[6]   s390 stand-alone dump/shutdown actions integration
[7]   kexec-tools: s390 kdump backend for kexec-tools
[8]   kexec-tools: s390 stand-alone dump/shutdown actions integration

History: v1->v2:
----------------
Main changes compared to version 1:
1. We use purgatory code
2. We use pre-allocated ELF core header
3. Registers are saved in old kernel
4. Removed meminfo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
