Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IUIK4-0006Ef-No
	for kexec@lists.infradead.org; Sun, 09 Sep 2007 04:39:21 -0400
Message-Id: <20070909083914.065380136@strauss.suse.de>
Date: Sun, 09 Sep 2007 10:39:14 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: [patch 0/5] Add extended crashkernel command line syntax
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

This patch adds a extended crashkernel syntax that makes the value of reserved
system RAM dependent on the system RAM itself:

    crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
    range=start-[end]

For example:

    crashkernel=512M-2G:64M,2G-:128M

The motivation comes from distributors that configure their crashkernel command
line automatically with some configuration tool (YaST, you know ;)). Of course
that tool knows the value of System RAM, but if the user removes RAM, then
the system becomes unbootable or at least unusable and error handling
is very difficult.

This series implements this change for i386, x86_64 and IA64. However, if
the patch is accepted, I can also add all other architectures that support
Kdump (when my grepping was correct, this is only PPC64 and SH in addition).
The "simple" syntax is of course still supported.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

-- 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
