Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RY0dC-00034C-1B
 for kexec@lists.infradead.org; Tue, 06 Dec 2011 19:24:46 +0000
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 6 Dec 2011 19:10:44 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pB6JL5sq1761512
 for <kexec@lists.infradead.org>; Wed, 7 Dec 2011 06:21:05 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB6JOelx016511
 for <kexec@lists.infradead.org>; Wed, 7 Dec 2011 06:24:40 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 3/3] PM / Docs: Recommend the use of
 [un]lock_system_sleep() over mutex_[un]lock(&pm_mutex)
Date: Wed, 07 Dec 2011 00:54:35 +0530
Message-ID: <20111206192413.25854.963.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20111206192000.25854.53769.stgit@srivatsabhat.in.ibm.com>
References: <20111206192000.25854.53769.stgit@srivatsabhat.in.ibm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: rjw@sisk.pl
Cc: len.brown@intel.com, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, oleg@redhat.com, rdunlap@xenotime.net, ebiederm@xmission.com, pavel@ucw.cz, tj@kernel.org

Update the documentation to explain the perils of directly using
mutex_[un]lock(&pm_mutex) and recommend the usage of the safe
APIs [un]lock_system_sleep() instead.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 Documentation/power/freezing-of-tasks.txt |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/Documentation/power/freezing-of-tasks.txt b/Documentation/power/freezing-of-tasks.txt
index 3ab9fbd..6ccb68f 100644
--- a/Documentation/power/freezing-of-tasks.txt
+++ b/Documentation/power/freezing-of-tasks.txt
@@ -176,3 +176,28 @@ tasks, since it generally exists anyway.
 A driver must have all firmwares it may need in RAM before suspend() is called.
 If keeping them is not practical, for example due to their size, they must be
 requested early enough using the suspend notifier API described in notifiers.txt.
+
+VI. Are there any precautions to be taken to prevent freezing failures?
+
+Yes, there are.
+
+First of all, grabbing the 'pm_mutex' lock to mutually exclude a piece of code
+from system-wide sleep such as suspend/hibernation is not encouraged.
+If possible, that piece of code must instead hook onto the suspend/hibernation
+notifiers to achieve mutual exclusion. Look at the CPU-Hotplug code
+(kernel/cpu.c) for an example.
+
+However, if that is not feasible, and grabbing 'pm_mutex' is deemed necessary,
+it is strongly discouraged to directly call mutex_[un]lock(&pm_mutex) since
+that could lead to freezing failures, because if the suspend/hibernate code
+successfully acquired the 'pm_mutex' lock, and hence that other entity failed
+to acquire the lock, then that task would get blocked in TASK_UNINTERRUPTIBLE
+state. As a consequence, the freezer would not be able to freeze that task,
+leading to freezing failure.
+
+However, the [un]lock_system_sleep() APIs are safe to use in this scenario,
+since they ask the freezer to skip freezing this task, since it is anyway
+"frozen enough" as it is blocked on 'pm_mutex', which will be released
+only after the entire suspend/hibernation sequence is complete.
+So, to summarize, use [un]lock_system_sleep() instead of directly using
+mutex_[un]lock(&pm_mutex). That would prevent freezing failures.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
