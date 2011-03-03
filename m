Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PvGOT-0002qI-CG
	for kexec@lists.infradead.org; Thu, 03 Mar 2011 21:49:10 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 03 Mar 2011 13:48:54 -0800
Message-ID: <m1k4gfswmx.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: [PULL] x86_64 kdump fixes
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
To: Simon Horman <horms@verge.net.au>
Cc: Kexec Mailing List <kexec@lists.infradead.org>


These are bug fixes that were tested several months ago and I forgot to
ask for them to be pulled.  I have tested against the latest tree and
these changes still apply and build cleanly.

git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/kexec-tools-devel.git 


Eric W. Biederman (2):
      kexec-syscall.h: Document what the architecture default arch is.
      x86 crashdump: On x86_64 generate EM_X86_64 crashdump headers.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
