Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from bruson.ifs.umich.edu ([141.213.229.79])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NXILC-0001NC-5Z
	for kexec@lists.infradead.org; Tue, 19 Jan 2010 17:58:14 +0000
Subject: make install fails to install man pages
Date: Tue, 19 Jan 2010 12:57:59 -0500
From: Marcus Watts <mdw@umich.edu>
Message-Id: <E1NXIL1-0005tH-Ho@bruson.ifs.umich.edu>
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
To: kexec@lists.infradead.org, horms@verge.net.au
Cc: mdw@umich.edu

When building kexec-tools 2.0.1, I noticed that "make install"
failed to install any man pages.  Upon looking, I found that
what "make install" had tried to do was:

	for file in build/sbin/kexec .. kexec/kexec.8 kdump/kdump.8; do
	if test `dirname $file` =     "build/sbin" ; then
	...
	if test `dirname $file` =     "build/man/man8" ; then
		mkdir -p     /tmp/kex//usr/share/man/man8/
		/usr/bin/install -c -m 644 $file /tmp/kex//usr/share/man/man8/
	fi
	...
	done

Since the man pages don't start with "build/", they don't
match the if clause so aren't installed.

Source in the makefile looks like this:
	if test `$(DIRNAME) $$file` =     "$(MAN8DIR)" ; then \

A test that might better express what you are trying to do:
	if test `basename x/foo.8 .8` = foo
perhaps something like this:
configure.ac:
	AC_CHECK_PROG([BASENAME],  basename,  basename,  "no", [$PATH])
	if test "$BASENAME" = "no"; then AC_MSG_ERROR([ basename not found]) fi
Makefile.in:
	if test `$(BASENAME) $$file .8` =     "$$file" ; then \

				-Marcus Watts

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
