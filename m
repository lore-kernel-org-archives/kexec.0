Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58] helo=smtp.tuxdriver.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OjHLJ-0006Jp-Nn
	for kexec@lists.infradead.org; Wed, 11 Aug 2010 19:52:06 +0000
Date: Wed, 11 Aug 2010 15:47:34 -0400
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Question regardin intel64 arch and page table setup
Message-ID: <20100811194734.GD23317@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
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
Cc: ebiederm@xmission.com, hpa@zytor.com

Hey all-
	I've got a question regarding x86_64 and how linux uses the paging
hardware.  I'm tinkering with ways to get kexec to boot a new kernel on panic
without leaving long mode.  The idea being that if we can do that, then we don't
need to store the new kdump kernel below the 4G physical limit for 32 bit
systems.  In doing this though, I figured I would have to re-initalize the page
table with an identity mapped set of page tables to cover all of ram and load
that into cr3.  My question is, is it safe to do so while paging is enabled.
The docs I've read are unclear on that and if I have to disable paging that
automatically drops me out of long mode, which is bad.  I would think its safe
to do, since I imagined we had to do on context switches in the scheduler, but
the __switch_to implementation for x86_64 sems to do nothing but update the task
register.  Intel vol 3a says we need to update cr3, but I don't see where that
happens, so I'm not sure if theres some automated bit that does a cr3 update
safely when we write tr.

	Anywho, any guidance, clarification would be appreciated.  Thanks!
Neil


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
