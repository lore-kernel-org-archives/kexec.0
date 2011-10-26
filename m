Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate1.uk.ibm.com ([194.196.100.161])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RJ61s-0003Ly-VA
	for kexec@lists.infradead.org; Wed, 26 Oct 2011 16:08:37 +0000
Received: from d06nrmr1307.portsmouth.uk.ibm.com
	(d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p9QG8DOD001578
	for <kexec@lists.infradead.org>; Wed, 26 Oct 2011 16:08:13 GMT
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
	[9.149.37.250])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p9QG8D4j2359352
	for <kexec@lists.infradead.org>; Wed, 26 Oct 2011 17:08:13 +0100
Received: from d06av09.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p9QG8C5l006986
	for <kexec@lists.infradead.org>; Wed, 26 Oct 2011 10:08:13 -0600
Message-ID: <1319645292.3321.24.camel@br98xy6r>
Subject: kdump: No udev events for memory hotplug?
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Wed, 26 Oct 2011 18:08:12 +0200
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: schwidefsky@de.ibm.com, kexec@lists.infradead.org, heiko.carstens@de.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org

Hello Vivek and Eric,

I noticed that on my system kernel 3.1 *no* udev events for memory
hotplug are generated. Same on my RHEL6.1.

# udevadm monitor
# echo offline > /sys/devices/system/memory/memory4/state

-> No event

But we need the udev events in order to do a kdump reload for setting up
the ELF loads correctly.

In my /etc/udev/rules.d/98-kexec.rules there are rules for memory
hotplug:

SUBSYSTEM=="memory", ACTION=="add", PROGRAM="/etc/init.d/kdump restart"
SUBSYSTEM=="memory", ACTION=="remove", PROGRAM="/etc/init.d/kdump
restart"

Perhaps/probably I am missing something?

Michael



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
