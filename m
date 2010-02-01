Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbvAS-00058D-VE
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:14:18 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id AC0BF24653
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:01 +1100 (EST)
Message-Id: <20100201121322.063080236@vergenet.net>
Date: Mon, 01 Feb 2010 23:12:05 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 09/27] Remove some unused variables
References: <20100201121156.252909695@vergenet.net>
Content-Disposition: inline; filename=remove-unused-variables.patch
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kexec Mailing List <kexec@lists.infradead.org>

Signed-off-by: Simon Horman <horms@verge.net.au>

Index: kexec-tools/kexec/arch/ia64/crashdump-ia64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ia64/crashdump-ia64.c	2010-02-01 23:07:18.000000000 +1100
+++ kexec-tools/kexec/arch/ia64/crashdump-ia64.c	2010-02-01 23:07:18.000000000 +1100
@@ -230,7 +230,6 @@ int load_crashdump_segments(struct kexec
                             unsigned long max_addr, unsigned long min_base,
 			    const char **cmdline)
 {
-	struct memory_range *mem_range;
 	int nr_ranges;
 	unsigned long sz;
 	size_t size;
Index: kexec-tools/kexec/arch/arm/kexec-arm.c
===================================================================
--- kexec-tools.orig/kexec/arch/arm/kexec-arm.c	2010-02-01 23:07:16.000000000 +1100
+++ kexec-tools/kexec/arch/arm/kexec-arm.c	2010-02-01 23:07:18.000000000 +1100
@@ -86,9 +86,6 @@ void arch_usage(void)
 {
 }
 
-static struct {
-} arch_options = {
-};
 int arch_process_options(int argc, char **argv)
 {
 	static const struct option options[] = {


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
