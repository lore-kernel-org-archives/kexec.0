Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Iae4g-000060-A9
	for kexec@lists.infradead.org; Wed, 26 Sep 2007 17:05:42 -0400
Date: Wed, 26 Sep 2007 23:05:33 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch 1/7] Extended crashkernel command line
Message-ID: <20070926210533.GA1299@suse.de>
References: <20070925182257.900701776@strauss.suse.de>
	<20070925182258.175348676@strauss.suse.de>
	<E1IaHPU-00089b-Bc@flower> <20070926161602.GA26909@suse.de>
	<20070926181843.GB24301@flower.upol.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070926181843.GB24301@flower.upol.cz>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Oleg Verych <olecom@flower.upol.cz>
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org, "Bernhard Walle (in kexec list)" <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org

* Oleg Verych <olecom@flower.upol.cz> [2007-09-26 20:18]:
> > 
> > --- a/kernel/kexec.c
> > +++ b/kernel/kexec.c
> > @@ -1172,33 +1172,50 @@ static int __init parse_crashkernel_mem(
> >  	do {
> >  		unsigned long long start = 0, end = ULLONG_MAX;
> >  		unsigned long long size = -1;
> 
> no need in assigning values here, unless you plan to use them in case
> of `return -EINVAL', but i can not see that,

What about this (and yes, I tested with some wrong strings with Qemu):

----

This patch improves error handling in parse_crashkernel_mem() by comparing
the return pointer of memparse() with the input pointer and also replaces
all printk(KERN_WARNING msg) with pr_warning(msg).


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 kernel/kexec.c |   54 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 15 deletions(-)

--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1167,44 +1167,59 @@ static int __init parse_crashkernel_mem(
 					unsigned long long	*crash_size,
 					unsigned long long	*crash_base)
 {
-	char *cur = cmdline;
+	char *cur = cmdline, *tmp;
 
 	/* for each entry of the comma-separated list */
 	do {
-		unsigned long long start = 0, end = ULLONG_MAX;
-		unsigned long long size = -1;
+		unsigned long long start, end = ULLONG_MAX, size;
 
 		/* get the start of the range */
-		start = memparse(cur, &cur);
+		start = memparse(cur, &tmp);
+		if (cur == tmp) {
+			pr_warning("crashkernel: Memory value expected\n");
+			return -EINVAL;
+		}
+		cur = tmp;
 		if (*cur != '-') {
-			printk(KERN_WARNING "crashkernel: '-' expected\n");
+			pr_warning("crashkernel: '-' expected\n");
 			return -EINVAL;
 		}
 		cur++;
 
 		/* if no ':' is here, than we read the end */
 		if (*cur != ':') {
-			end = memparse(cur, &cur);
+			end = memparse(cur, &tmp);
+			if (cur == tmp) {
+				pr_warning("crashkernel: Memory "
+						"value expected\n");
+				return -EINVAL;
+			}
+			cur = tmp;
 			if (end <= start) {
-				printk(KERN_WARNING "crashkernel: end <= start\n");
+				pr_warning("crashkernel: end <= start\n");
 				return -EINVAL;
 			}
 		}
 
 		if (*cur != ':') {
-			printk(KERN_WARNING "crashkernel: ':' expected\n");
+			pr_warning("crashkernel: ':' expected\n");
 			return -EINVAL;
 		}
 		cur++;
 
-		size = memparse(cur, &cur);
-		if (size < 0) {
-			printk(KERN_WARNING "crashkernel: invalid size\n");
+		size = memparse(cur, &tmp);
+		if (cur == tmp) {
+			pr_warning("Memory value expected\n");
+			return -EINVAL;
+		}
+		cur = tmp;
+		if (size >= system_ram) {
+			pr_warning("crashkernel: invalid size\n");
 			return -EINVAL;
 		}
 
 		/* match ? */
-		if (system_ram >= start  && system_ram <= end) {
+		if (system_ram >= start && system_ram <= end) {
 			*crash_size = size;
 			break;
 		}
@@ -1213,8 +1228,15 @@ static int __init parse_crashkernel_mem(
 	if (*crash_size > 0) {
 		while (*cur != ' ' && *cur != '@')
 			cur++;
-		if (*cur == '@')
-			*crash_base = memparse(cur+1, &cur);
+		if (*cur == '@') {
+			cur++;
+			*crash_base = memparse(cur, &tmp);
+			if (cur == tmp) {
+				pr_warning("Memory value expected "
+						"after '@'\n");
+				return -EINVAL;
+			}
+		}
 	}
 
 	return 0;
@@ -1234,8 +1256,10 @@ static int __init parse_crashkernel_simp
 	char *cur = cmdline;
 
 	*crash_size = memparse(cmdline, &cur);
-	if (cmdline == cur)
+	if (cmdline == cur) {
+		pr_warning("crashkernel: memory value expected\n");
 		return -EINVAL;
+	}
 
 	if (*cur == '@')
 		*crash_base = memparse(cur+1, &cur);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
