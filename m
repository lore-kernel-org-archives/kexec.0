Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OrdMG-0005ud-Ho
	for kexec@lists.infradead.org; Fri, 03 Sep 2010 20:59:37 +0000
Date: Fri, 3 Sep 2010 13:58:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: fix /proc/vmcore seek
Message-Id: <20100903135844.133334ee.akpm@linux-foundation.org>
In-Reply-To: <201009021420.19914.arnd@arndb.de>
References: <289862590.1906641283428317221.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<201009021420.19914.arnd@arndb.de>
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, CAI Qian <caiqian@redhat.com>, fweisbec@gmail.com, kexec <kexec@lists.infradead.org>, viro@zeniv.linux.org.uk, jkacur@redhat.com, tglx@linutronix.de, mingo@elte.hu, kamezawa.hiroyu@jp.fujitsu.com

On Thu, 2 Sep 2010 14:20:19 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> Commit 73296bc611 "procfs: Use generic_file_llseek in /proc/vmcore" broke
> seeking on /proc/vmcore. This changes it back to use default_llseek
> in order to restore the original behaviour.

"broke" isn't a useful description of a bug :(

A bit of list-trolling indicates that this change caused makedumpfile
to hang during kexec dumping, yes?  If so, why did this happen?  How
did the switch to generic_file_llseek() cause the /proc/vmcore seek
behaviour to change?

I'm not seeing a lot of difference between default_llseek() and
generic_file_llseek() apart from file->f_mapping->host versus
file->f_path.dentry->d_inode.  Was it that, or what?

etcetera.  Better patch descriptions, please!


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
