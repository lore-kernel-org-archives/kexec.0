Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bNJ9D-0004ER-Kr
 for kexec@lists.infradead.org; Wed, 13 Jul 2016 12:20:16 +0000
Subject: [PATCH 0/2] Allow crash dumps with crash_kexec_post_notifiers
From: Petr Tesarik <ptesarik@suse.com>
Date: Wed, 13 Jul 2016 14:19:50 +0200
Message-ID: <20160713121950.14969.78606.stgit@hananiah.suse.cz>
MIME-Version: 1.0
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
To: Juergen Gross <jgross@suse.com>, Josh Triplett <josh@joshtriplett.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, David Vrabel <david.vrabel@citrix.com>
Cc: "moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>, "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>, "open list:KEXEC" <kexec@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>

Hello all,

this patch series makes it possible to save a kernel crash dump when the
kernel command line includes "crash_kexec_post_notifiers". There might
be other approaches, but mine has the advantage that no new sysctl is
required, and the behaviour is the same whether panic notifiers are run
or not: If you load a crash kernel with kexec, it will be used, otherwise
the hypervisor facility is used (using a hypercall).

Feedback welcome!

Petr T

---

Petr Tesarik (2):
      Add a kexec_crash_loaded() function
      Allow kdump with crash_kexec_post_notifiers


 arch/x86/xen/enlighten.c |    3 ++-
 include/linux/kexec.h    |    2 ++
 kernel/kexec_core.c      |    5 +++++
 kernel/ksysfs.c          |    2 +-
 4 files changed, 10 insertions(+), 2 deletions(-)

--
Signature

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
