Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ew0-f49.google.com ([209.85.215.49])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OrdXA-0008Ra-MC
	for kexec@lists.infradead.org; Fri, 03 Sep 2010 21:10:53 +0000
Received: by ewy9 with SMTP id 9so1660409ewy.36
	for <kexec@lists.infradead.org>; Fri, 03 Sep 2010 14:10:51 -0700 (PDT)
Date: Fri, 3 Sep 2010 23:10:55 +0200
From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: fix /proc/vmcore seek
Message-ID: <20100903211052.GD5352@nowhere>
References: <289862590.1906641283428317221.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<201009021420.19914.arnd@arndb.de>
	<20100903135844.133334ee.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100903135844.133334ee.akpm@linux-foundation.org>
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
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, CAI Qian <caiqian@redhat.com>, Arnd Bergmann <arnd@arndb.de>, kexec <kexec@lists.infradead.org>, viro@zeniv.linux.org.uk, jkacur@redhat.com, tglx@linutronix.de, mingo@elte.hu, kamezawa.hiroyu@jp.fujitsu.com

On Fri, Sep 03, 2010 at 01:58:44PM -0700, Andrew Morton wrote:
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


Yeah, that's the problem, we don't know yet why it broke. I was about
to investigate and try to find the problem before applying it but
got distracted by other things.

I'll try to find the issue.

Thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
