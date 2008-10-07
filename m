Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp03.au.ibm.com ([202.81.18.172])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KnC2e-0001iA-6C
	for kexec@lists.infradead.org; Tue, 07 Oct 2008 12:51:56 +0000
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id m97Cocpm024080
	for <kexec@lists.infradead.org>; Tue, 7 Oct 2008 23:50:38 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m97Cpqj6292664
	for <kexec@lists.infradead.org>; Tue, 7 Oct 2008 23:51:52 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m97CpqNb030279
	for <kexec@lists.infradead.org>; Tue, 7 Oct 2008 23:51:52 +1100
Message-ID: <48EB5B68.8010401@in.ibm.com>
Date: Tue, 07 Oct 2008 18:21:52 +0530
From: Chandru <chandru@in.ibm.com>
MIME-Version: 1.0
Subject: kdump: quad core Opteron
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Vivek Goyal <vgoyal@redhat.com>

kdump on a quad core Opteron blade machine doesn't give a complete 
vmcore on the system.   All works well until we attempt to copy 
/proc/vmcore to some target place ( disk , n/w ). The system immediately 
resets without any OS messages after having copied few mb's of vmcore 
file.  Problem also occurs with 2.6.27-rc8 and latest kexec-tools.  If 
we pass 'mem=4G' as boot parameter to the first kernel, then kdump 
succeeds in copying a readable vmcore to /var/crash.

[root@abc ~]# uname -a
Linux abc 2.6.27-rc8 #2 SMP Tue Oct 7 08:05:46 EDT 2008 x86_64 x86_64 
x86_64 GNU/Linux

Chandru


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
