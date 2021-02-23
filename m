Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEf2e-0007NY-8F
 for kexec@lists.infradead.org; Tue, 23 Feb 2021 21:16:26 +0000
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 11NL4P3n013794
 for <kexec@lists.infradead.org>; Tue, 23 Feb 2021 16:16:22 -0500
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com
 [158.85.210.119])
 by mx0a-001b2d01.pphosted.com with ESMTP id 36vwmprw5w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 23 Feb 2021 16:16:22 -0500
Received: from localhost
 by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
 for <kexec@lists.infradead.org> from <Bruce.Mitchell@ibm.com>;
 Tue, 23 Feb 2021 21:16:21 -0000
In-Reply-To: 
Subject: Issues with kdump/kexec on an ARM dual-core ARM Cortex-A7.
From: "Bruce Mitchell" <Bruce.Mitchell@ibm.com>
Date: Tue, 23 Feb 2021 21:16:19 +0000
MIME-Version: 1.0
References: 
Message-Id: <OF267FCB7E.EA06E022-ON00258685.0074D9AA-00258685.0074D9AE@notes.na.collabserv.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


I am having troubles getting kdump/kexec functioning on an
ARM dual-core ARM Cortex-A7 (a BMC by ASPEED AST2600) and QEMU.
I do have kexec -l loading the new kernel, but after kexec -e
the new kernel starts booting and the I get a watchdog BUG as shown here:
[240.343350] kexec_core: Starting new kernel
[241.639076] IRQ36: set affinity failed(-22).
[241.657868] Bye!
[ 0.000000] Booting Linux on physical CPU 0xf00
.
.
.
[ 1.640405] random: fast init done
[ 1.683871] random: crng init done
[ 28.104415] watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [swapper/0:1]
[ 28.108383] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.14-47f127c #1

This is the first time I have worked on SMP section of the kernel.
In order to get kexec to work I had to implement the SMP HOTPLUG;
I suspect I do not have it functioning properly. I am not finding
good information on implementing it. Is this something unique to
each SoC based on an ARM dual-core ARM Cortex-A7?

Looking for suggestions on how to successfully proceed.


Thank you.

--
Bruce Mitchell

PS - Sorry this is a separate post from the one
I did to linux-arm-kernel@lists.infradead.org
hadn't seen this email list at that point.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
