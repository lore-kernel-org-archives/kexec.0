Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp03.au.ibm.com ([202.81.18.172])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JBo9B-0000O5-28
	for kexec@lists.infradead.org; Mon, 07 Jan 2008 09:20:00 +0000
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id m079J2QT013977
	for <kexec@lists.infradead.org>; Mon, 7 Jan 2008 20:19:02 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m079N5HX267982
	for <kexec@lists.infradead.org>; Mon, 7 Jan 2008 20:23:05 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m079JCcR022816
	for <kexec@lists.infradead.org>; Mon, 7 Jan 2008 20:19:13 +1100
Date: Mon, 7 Jan 2008 14:48:38 +0530
From: Dhaval Giani <dhaval@linux.vnet.ibm.com>
Subject: Re: kexec refuses to boot latest -mm
Message-ID: <20080107091838.GA30865@linux.vnet.ibm.com>
References: <20071228124532.GB32643@linux.vnet.ibm.com>
	<20071231150843.GB27060@redhat.com>
	<20080103195201.GC6392@linux.vnet.ibm.com>
	<200801032242.01425.rjw@sisk.pl>
	<20080104122816.GF4514@linux.vnet.ibm.com>
	<20080104155415.GC6007@linux.vnet.ibm.com>
	<20080106133729.GB2481@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080106133729.GB2481@elte.hu>
Reply-To: Dhaval Giani <dhaval@linux.vnet.ibm.com>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: maneesh@linux.vnet.ibm.com, kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, hbabu@us.ibm.com, hpa@zytor.com, Andrew Morton <akpm@linux-foundation.org>, tglx@linutronix.de, Vivek Goyal <vgoyal@redhat.com>

On Sun, Jan 06, 2008 at 02:37:29PM +0100, Ingo Molnar wrote:
> 
> * Dhaval Giani <dhaval@linux.vnet.ibm.com> wrote:
> 
> > So I went ahead and bisected -mm, and the culprit is git-x86. It boots 
> > fine before it, but with git-x86 applied, it fails to boot.
> > 
> > Ingo/Thomas, could you please point me to the git-x86 tree so that I 
> > can bisect it? (with instructions on how to pull the -mm branch, I 
> > managed to pull the master branch, but not the -mm branch)
> 
> sure:
> 
> --------------{ x86.git instructions }---------->
> 
>  git-clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6.git
>  cd linux-2.6.git
>  git-branch x86
>  git-checkout x86
>  git-pull git://git.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-x86.git mm
>  git-log HEAD@{1}.. # see what's in #mm
> 

Thanks for the instructions. I went ahead and did the bisect, and

commit 7dd838ea7afa42a8840cf0e262d5892346ecf379
Author: H. Peter Anvin <hpa@zytor.com>
Date:   Sat Jan 5 13:27:04 2008 +0100

is the first bad commit.

git bisect log

dhaval@kernel:~/mm$ git bisect log
git-bisect start
# good: [439f61b9f9ebbf84fb7e6b3539fc3794e046bbb9] Merge
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6
git-bisect good 439f61b9f9ebbf84fb7e6b3539fc3794e046bbb9
# bad: [5c9b01f1566f4989bb732a46c9a9c86f3e7ef9ae] x86: unregister PIT
clocksource when PIT is disabled
git-bisect bad 5c9b01f1566f4989bb732a46c9a9c86f3e7ef9ae
# good: [203bcdc3d2725751e4dc0e3749edbab3c8bf9132] move switch_to macro
to system.h
git-bisect good 203bcdc3d2725751e4dc0e3749edbab3c8bf9132
# good: [81886a1b16eec7a27f3ec94f06f585685ad08bf2] x86: i387 renaming
git-bisect good 81886a1b16eec7a27f3ec94f06f585685ad08bf2
# bad: [fc0ed2251da6ef8ad3295a02b39bed9859dc0cfc] x86: unify
arch/x86/kernel/Makefile(s)
git-bisect bad fc0ed2251da6ef8ad3295a02b39bed9859dc0cfc
# good: [6fa16686ee2b0cc6b02a59671ecb9d4c85beae64] change assembly
definition of paravirt_patch_site
git-bisect good 6fa16686ee2b0cc6b02a59671ecb9d4c85beae64
# bad: [1184caa02fcc2ecd780b145f4c69cc4484a8cde4] git-x86:
arch/x86/math-emu/errors.c: fix printk warnings
git-bisect bad 1184caa02fcc2ecd780b145f4c69cc4484a8cde4
# good: [e8189d0ca1970578f4b28f92928581313633be5a] x86_64 patching
functions
git-bisect good e8189d0ca1970578f4b28f92928581313633be5a
# bad: [7dd838ea7afa42a8840cf0e262d5892346ecf379] i386: handle an initrd
in highmem
git-bisect bad 7dd838ea7afa42a8840cf0e262d5892346ecf379
# good: [8cff7d1301d37b15add1dabe6ac8a92e6c0a1c7f] i386 EFI runtime
service support: fixes in sync with x86_64 support
git-bisect good 8cff7d1301d37b15add1dabe6ac8a92e6c0a1c7f
# good: [ac3836d03c718a553634ff21c1157bb823567f4f] x86:
arch/x86/kernel/setup_32.c whitespace fixes
git-bisect good ac3836d03c718a553634ff21c1157bb823567f4f

-- 
regards,
Dhaval

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
