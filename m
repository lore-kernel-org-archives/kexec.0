Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RT8Qf-0004we-Gc
 for kexec@lists.infradead.org; Wed, 23 Nov 2011 08:43:43 +0000
Date: Wed, 23 Nov 2011 16:45:43 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH] percpu: add comment to per_cpu_ptr_to_phys
Message-ID: <20111123084543.GA2923@darkstar.nay.redhat.com>
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
To: tj@kernel.org, xiyou.wangcong@gmail.com, kexec@lists.infradead.org, tim@edgecast.com, linux-kernel@vger.kernel.org

add comments about current per_cpu_ptr_to_phys implementation
to explain why the logic is more complicated than necessary.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 mm/percpu.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- linux-2.6.orig/mm/percpu.c	2011-11-22 10:18:46.000000000 +0800
+++ linux-2.6/mm/percpu.c	2011-11-23 16:27:01.667562973 +0800
@@ -988,6 +988,19 @@ phys_addr_t per_cpu_ptr_to_phys(void *ad
 	unsigned int cpu;
 
 	/*
+	 * percpu allocator has special setup for the first chunk,
+	 * which currently supports either embedding in linear address space
+	 * or vmalloc mapping, and, from the second one, the backing
+	 * allocator (currently either vm or km) provides translation.
+	 *
+	 * The addr can be tranlated simply without checking if it falls
+	 * into the first chunk. But the current code reflects better
+	 * how percpu allocator actually works, and the verification can
+	 * discover both bugs in percpu allocator itself and
+	 * per_cpu_ptr_to_phys() callers. So we keep current code.
+	 */
+
+	/*
 	 * The following test on first_start/end isn't strictly
 	 * necessary but will speed up lookups of addresses which
 	 * aren't in the first chunk.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
