Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from py-out-1112.google.com ([64.233.166.181])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JoRt4-0006Vj-SN
	for kexec@lists.infradead.org; Tue, 22 Apr 2008 23:26:59 +0000
Received: by py-out-1112.google.com with SMTP id a73so3540559pye.2
	for <kexec@lists.infradead.org>; Tue, 22 Apr 2008 16:26:58 -0700 (PDT)
From: Jamey Sharp <jamey@thetovacompany.com>
Subject: [PATCH 0/9] kexec userspace and purgatory cleanups
Date: Tue, 22 Apr 2008 16:21:03 -0700
Message-Id: <1208906472-18465-1-git-send-email-jamey@thetovacompany.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

GIT: Please enter your email below.
GIT: Lines beginning in "GIT: " will be removed.
GIT: Consider including an overall diffstat or table of contents
GIT: for the patch you are writing.

This patch series fixes issues I encountered while porting kexec to run
on Windows. (I'll be happy to say more about that insane, but
surprisingly successful, plan on another occasion.) These patches,
however, are only the ones that affect the kexec userspace tools on
Linux. They fall into three categories.

Bug fixes, primarily in the i386 purgatory source:
- [1/9] Fix undefined symbol errors on readw/writew.
- [2/9] Fix copy-paste bug: entry16 does not start at entry16_debug.
- [3/9] Conform more closely to Documentation/i386/boot.txt.
- [9/9] Die on early EOF in slurp_file, instead of infinite-looping.

Compiler and assembler warning fixes:
- [4/9] Fix "Warning: indirect jmp without `*'".
- [5/9] Fix all gcc warnings for ARCH=i386 builds.

Cleanups or simplifications:
- [6/9] <sys/mman.h> is not needed by any i386 kexec/ source.
- [7/9] Replace weak definitions with source filename overriding.
- [8/9] Simplify initialization of argument list for `shutdown`.

I believe each of these patches stands pretty well on its own, both in
independence from each other, and in being fairly self-explanatory.

These patches are against 9e959db12a671a71934a765d15aaf082f0a4f886 in
git://git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools-testing.
Although, as they touch only code that hasn't seen much change recently,
they should apply cleanly to other versions.

I hope you'll consider including these patches in your next release of
the kexec userspace tools. If you would have preferred the patches in
some other form, please let me know, since I'll have some more patches
for your consideration later.

Thanks,
Jamey Sharp

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
