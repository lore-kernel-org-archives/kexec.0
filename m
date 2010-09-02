Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from moutng.kundenserver.de ([212.227.126.187])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Or8mN-0000r5-91
	for kexec@lists.infradead.org; Thu, 02 Sep 2010 12:20:32 +0000
From: Arnd Bergmann <arnd@arndb.de>
Subject: fix /proc/vmcore seek
Date: Thu, 2 Sep 2010 14:20:19 +0200
References: <289862590.1906641283428317221.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <289862590.1906641283428317221.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Message-Id: <201009021420.19914.arnd@arndb.de>
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
To: CAI Qian <caiqian@redhat.com>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, akpm@linux-foundation.org, fweisbec@gmail.com, kexec <kexec@lists.infradead.org>, viro@zeniv.linux.org.uk, jkacur@redhat.com, tglx@linutronix.de, mingo@elte.hu, kamezawa.hiroyu@jp.fujitsu.com

Commit 73296bc611 "procfs: Use generic_file_llseek in /proc/vmcore" broke
seeking on /proc/vmcore. This changes it back to use default_llseek
in order to restore the original behaviour.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: stable@kernel.org

---
On Thursday 02 September 2010, CAI Qian wrote:
> 
> Ken'ichi, it turned out this kernel patch caused makedumpfile failure below.
> I am not sure if this is a kernel bug or makedumpfile needs to catch up with
> the change.

It doesn't matter who is correct here. A user program regressed because of a
kernel change, so we need to fix the kernel. Thanks for the report!

Please try this patch.

--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -163,7 +163,7 @@ static ssize_t read_vmcore(struct file *file, char __user *buffer,
 
 static const struct file_operations proc_vmcore_operations = {
 	.read		= read_vmcore,
-	.llseek		= generic_file_llseek,
+	.llseek		= default_llseek,
 };
 
 static struct vmcore* __init get_new_element(void)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
