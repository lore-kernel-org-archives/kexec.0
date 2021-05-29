Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmwke-0052Hq-AQ
 for kexec@lists.infradead.org; Sat, 29 May 2021 11:03:34 +0000
From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/4] kprobes: Fix spelling mistakes
Date: Sat, 29 May 2021 19:03:02 +0800
Message-ID: <20210529110305.9446-2-thunder.leizhen@huawei.com>
In-Reply-To: <20210529110305.9446-1-thunder.leizhen@huawei.com>
References: <20210529110305.9446-1-thunder.leizhen@huawei.com>
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
To: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Balbir Singh <bsingharora@gmail.com>, Barry Song <song.bao.hua@hisilicon.com>, Christoph Hellwig <hch@lst.de>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Eric Biederman <ebiederm@xmission.com>, "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Masami Hiramatsu <mhiramat@kernel.org>, Jessica Yu <jeyu@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, Oleg Nesterov <oleg@redhat.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, kgdb-bugreport <kgdb-bugreport@lists.sourceforge.net>, kexec <kexec@lists.infradead.org>, linux-crypto <linux-crypto@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>

Fix some spelling mistakes in comments:
decrese ==> decrease
immmediately ==> immediately

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/freelist.h | 2 +-
 kernel/kprobes.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/freelist.h b/include/linux/freelist.h
index fc1842b96469..1811c1f3f8cb 100644
--- a/include/linux/freelist.h
+++ b/include/linux/freelist.h
@@ -39,7 +39,7 @@ static inline void __freelist_add(struct freelist_node *node, struct freelist_he
 	 * and a refcount increment of a node in try_get, then back up to
 	 * something non-zero, then the refcount increment is done by the other
 	 * thread) -- so if the CAS to add the node to the actual list fails,
-	 * decrese the refcount and leave the add operation to the next thread
+	 * decrease the refcount and leave the add operation to the next thread
 	 * who puts the refcount back to zero (which could be us, hence the
 	 * loop).
 	 */
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 8c0a6fdef771..d4156082d5a5 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -641,7 +641,7 @@ void wait_for_kprobe_optimizer(void)
 	while (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list)) {
 		mutex_unlock(&kprobe_mutex);
 
-		/* this will also make optimizing_work execute immmediately */
+		/* this will also make optimizing_work execute immediately */
 		flush_delayed_work(&optimizing_work);
 		/* @optimizing_work might not have been queued yet, relax */
 		cpu_relax();
-- 
2.25.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
