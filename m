Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1blrcl-0002LK-BT
 for kexec@lists.infradead.org; Mon, 19 Sep 2016 06:00:16 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v10 RESEND 1/3] docs: kernel-parameter : Improve the
 description of nr_cpus and maxcpus
Date: Mon, 19 Sep 2016 13:59:47 +0800
Message-Id: <1474264789-11705-2-git-send-email-bhe@redhat.com>
In-Reply-To: <1474264789-11705-1-git-send-email-bhe@redhat.com>
References: <1474264789-11705-1-git-send-email-bhe@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: corbet@lwn.net, akpm@linux-foundation.org
Cc: Baoquan He <bhe@redhat.com>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, xlpang@redhat.com, linux-kernel@vger.kernel.org, dyoung@redhat.com

From the old description people still can't get what's the exact
difference between nr_cpus and maxcpus. Especially in kdump kernel
nr_cpus is always suggested if it's implemented in ARCH. The reason
is nr_cpus is used to limit the max number of possible cpu in system,
the sum of already plugged cpus and hot plug cpus can't exceed its
value. However maxcpus is used to limit how many cpus are allowed to
be brought up during bootup.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/kernel-parameters.txt | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index a4f4d69..98d6406 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2161,10 +2161,13 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			than or equal to this physical address is ignored.
 
 	maxcpus=	[SMP] Maximum number of processors that	an SMP kernel
-			should make use of.  maxcpus=n : n >= 0 limits the
-			kernel to using 'n' processors.  n=0 is a special case,
-			it is equivalent to "nosmp", which also disables
-			the IO APIC.
+			will bring up during bootup.  maxcpus=n : n >= 0 limits
+			the kernel to bring up 'n' processors. Surely after
+			bootup you can bring up the other plugged cpu by executing
+			"echo 1 > /sys/devices/system/cpu/cpuX/online". So maxcpus
+			only takes effect during system bootup.
+			While n=0 is a special case, it is equivalent to "nosmp",
+			which also disables the IO APIC.
 
 	max_loop=	[LOOP] The number of loop block devices that get
 	(loop.max_loop)	unconditionally pre-created at init time. The default
@@ -2773,9 +2776,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 
 	nr_cpus=	[SMP] Maximum number of processors that	an SMP kernel
 			could support.  nr_cpus=n : n >= 1 limits the kernel to
-			supporting 'n' processors. Later in runtime you can not
-			use hotplug cpu feature to put more cpu back to online.
-			just like you compile the kernel NR_CPUS=n
+			support 'n' processors. It could be larger than the
+			number of already plugged CPU during bootup, later in
+			runtime you can physically add extra cpu until it reaches
+			n. So during boot up some boot time memory for per-cpu
+			variables need be pre-allocated for later physical cpu
+			hot plugging.
 
 	nr_uarts=	[SERIAL] maximum number of UARTs to be registered.
 
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
