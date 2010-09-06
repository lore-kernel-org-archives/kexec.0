Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OsQJE-0004ou-Rm
	for kexec@lists.infradead.org; Mon, 06 Sep 2010 01:15:46 +0000
Received: from m1.gw.fujitsu.co.jp ([10.0.50.71])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o861FeDX007415 for <kexec@lists.infradead.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Mon, 6 Sep 2010 10:15:40 +0900
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 23F1345DE4E
	for <kexec@lists.infradead.org>; Mon,  6 Sep 2010 10:15:40 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id EF40545DE4D
	for <kexec@lists.infradead.org>; Mon,  6 Sep 2010 10:15:39 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id C84211DB8048
	for <kexec@lists.infradead.org>; Mon,  6 Sep 2010 10:15:39 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.249.87.107])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 763201DB8046
	for <kexec@lists.infradead.org>; Mon,  6 Sep 2010 10:15:39 +0900 (JST)
Date: Mon, 6 Sep 2010 10:10:37 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: [PATCH][mmotm] unsigned offset llseek support (Was Re: fix
	/proc/vmcore seek
Message-Id: <20100906101037.4a69d03c.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20100903135844.133334ee.akpm@linux-foundation.org>
References: <289862590.1906641283428317221.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<201009021420.19914.arnd@arndb.de>
	<20100903135844.133334ee.akpm@linux-foundation.org>
Mime-Version: 1.0
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, CAI Qian <caiqian@redhat.com>, Arnd Bergmann <arnd@arndb.de>, fweisbec@gmail.com, kexec <kexec@lists.infradead.org>, viro@zeniv.linux.org.uk, jkacur@redhat.com, tglx@linutronix.de, mingo@elte.hu

On Fri, 3 Sep 2010 13:58:44 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu, 2 Sep 2010 14:20:19 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > Commit 73296bc611 "procfs: Use generic_file_llseek in /proc/vmcore" broke
> > seeking on /proc/vmcore. This changes it back to use default_llseek
> > in order to restore the original behaviour.
> 
> "broke" isn't a useful description of a bug :(
> 
> A bit of list-trolling indicates that this change caused makedumpfile
> to hang during kexec dumping, yes?  If so, why did this happen?  How
> did the switch to generic_file_llseek() cause the /proc/vmcore seek
> behaviour to change?
> 
> I'm not seeing a lot of difference between default_llseek() and
> generic_file_llseek() apart from file->f_mapping->host versus
> file->f_path.dentry->d_inode.  Was it that, or what?
> 
> etcetera.  Better patch descriptions, please!
> 
> 

Ah...not related to this issue itself..but...
This is a patch for mmotm, which supports "unsigned file offset".

Now, mmotm, only /dev/mem support
==
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

vfs-introduce-fmode_neg_offset-for-allowing-negative-f_pos.patch
adds "UNSIGINED" fpos support. But it dones't handle llseek.
Fix it.

Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
---
 fs/read_write.c |   33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

Index: mmotm-0827/fs/read_write.c
===================================================================
--- mmotm-0827.orig/fs/read_write.c
+++ mmotm-0827/fs/read_write.c
@@ -31,6 +31,20 @@ const struct file_operations generic_ro_
 
 EXPORT_SYMBOL(generic_ro_fops);
 
+static int
+__negative_fpos_check(struct file *file, loff_t pos, size_t count)
+{
+	/*
+	 * pos or pos+count is negative here, check overflow.
+	 * too big "count" will be caught in rw_verify_area().
+	 */
+	if ((pos < 0) && (pos + count < pos))
+		return -EOVERFLOW;
+	if (file->f_mode & FMODE_UNSIGNED_OFFSET)
+		return 0;
+	return -EINVAL;
+}
+
 /**
  * generic_file_llseek_unlocked - lockless generic llseek implementation
  * @file:	file structure to seek on
@@ -62,7 +76,9 @@ generic_file_llseek_unlocked(struct file
 		break;
 	}
 
-	if (offset < 0 || offset > inode->i_sb->s_maxbytes)
+	if (offset < 0 && __negative_fpos_check(file, offset, 0))
+		return -EINVAL;
+	if (offset > inode->i_sb->s_maxbytes)
 		return -EINVAL;
 
 	/* Special lock needed here? */
@@ -137,7 +153,7 @@ loff_t default_llseek(struct file *file,
 			offset += file->f_pos;
 	}
 	retval = -EINVAL;
-	if (offset >= 0) {
+	if (offset >= 0 || !__negative_fpos_check(file, offset, 0)) {
 		if (offset != file->f_pos) {
 			file->f_pos = offset;
 			file->f_version = 0;
@@ -222,19 +238,6 @@ bad:
 }
 #endif
 
-static int
-__negative_fpos_check(struct file *file, loff_t pos, size_t count)
-{
-	/*
-	 * pos or pos+count is negative here, check overflow.
-	 * too big "count" will be caught in rw_verify_area().
-	 */
-	if ((pos < 0) && (pos + count < pos))
-		return -EOVERFLOW;
-	if (file->f_mode & FMODE_UNSIGNED_OFFSET)
-		return 0;
-	return -EINVAL;
-}
 
 /*
  * rw_verify_area doesn't like huge counts. We limit



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
