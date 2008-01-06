Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JBVhM-00057A-Hd
	for kexec@lists.infradead.org; Sun, 06 Jan 2008 13:38:03 +0000
Date: Sun, 6 Jan 2008 14:37:29 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: kexec refuses to boot latest -mm
Message-ID: <20080106133729.GB2481@elte.hu>
References: <20071228124532.GB32643@linux.vnet.ibm.com>
	<20071231150843.GB27060@redhat.com>
	<20080103195201.GC6392@linux.vnet.ibm.com>
	<200801032242.01425.rjw@sisk.pl>
	<20080104122816.GF4514@linux.vnet.ibm.com>
	<20080104155415.GC6007@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080104155415.GC6007@linux.vnet.ibm.com>
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
To: Dhaval Giani <dhaval@linux.vnet.ibm.com>
Cc: maneesh@linux.vnet.ibm.com, kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, hbabu@us.ibm.com, Andrew Morton <akpm@linux-foundation.org>, tglx@linutronix.de, Vivek Goyal <vgoyal@redhat.com>


* Dhaval Giani <dhaval@linux.vnet.ibm.com> wrote:

> So I went ahead and bisected -mm, and the culprit is git-x86. It boots 
> fine before it, but with git-x86 applied, it fails to boot.
> 
> Ingo/Thomas, could you please point me to the git-x86 tree so that I 
> can bisect it? (with instructions on how to pull the -mm branch, I 
> managed to pull the master branch, but not the -mm branch)

sure:

--------------{ x86.git instructions }---------->

 git-clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6.git
 cd linux-2.6.git
 git-branch x86
 git-checkout x86
 git-pull git://git.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-x86.git mm
 git-log HEAD@{1}.. # see what's in #mm

(do subsequent pulls via "git-pull --force", as we frequently rebase the
git tree. NOTE: this might override your own local changes, so do this
only if you dont mind about losing thse changes in that tree.)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
