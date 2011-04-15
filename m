Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1QApdr-0001YH-Cx
	for kexec@lists.infradead.org; Fri, 15 Apr 2011 20:29:27 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3FKDCRS021036
	for <kexec@lists.infradead.org>; Fri, 15 Apr 2011 14:13:12 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p3FKTHRh120906
	for <kexec@lists.infradead.org>; Fri, 15 Apr 2011 14:29:17 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p3FKTHIK015554
	for <kexec@lists.infradead.org>; Fri, 15 Apr 2011 14:29:17 -0600
Date: Fri, 15 Apr 2011 13:29:16 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: Fix kexec-related UP build error
Message-ID: <20110415202916.GA6758@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Reply-To: paulmck@linux.vnet.ibm.com
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
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, ebiederm@xmission.com, paulus@samba.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org

Hello!

The following patch fixes a UP build problem for kexec() on powerpc.
When the crash_kexec_wait_realmode() function was added, it was
placed in only two of the three required locations.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

The function crash_kexec_wait_realmode() is defined only if SMP, but is
called in UP builds.  Create an empty function to keep the compiler happy
in UP builds.

Signed-off-by: Paul E. McKenney <paul.mckenney@linaro.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index 3d3d416..6f964ef 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -251,6 +251,10 @@ static void crash_kexec_prepare_cpus(int cpu)
 #endif
 }
 
+static void crash_kexec_wait_realmode(int cpu)
+{
+}
+
 void crash_kexec_secondary(struct pt_regs *regs)
 {
 	cpus_in_sr = CPU_MASK_NONE;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
