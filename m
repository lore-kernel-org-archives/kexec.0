Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.nokia.com ([147.243.1.48] helo=mgw-sa02.nokia.com)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PDv57-00039D-G9
	for kexec@lists.infradead.org; Thu, 04 Nov 2010 08:22:02 +0000
From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [PATCH 0/2] makedumpfile: few ARM fixes
Date: Thu,  4 Nov 2010 10:15:15 +0200
Message-Id: <cover.1288788355.git.ext-mika.1.westerberg@nokia.com>
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
To: kexec@lists.infradead.org
Cc: igawa@mxs.nes.nec.co.jp, Mika Westerberg <ext-mika.1.westerberg@nokia.com>

Hi,

While using makedumpfile on ARM I found few issues from the current
implementation. Basically the current implementation only works on
3G/1G VM split but not others.

These patches should make makedumpfile on ARM to work on other VM
split values as well. I've tested with 1G/3G, 2G/2G, 3G/1G, and
VMSPLIT_3G_OPT (2.7G/1.3G).

Regards,
MW

Mika Westerberg (2):
  ARM: determine PAGE_OFFSET from _stext
  ARM: don't depend on vmalloc_start

 arm.c          |   42 ++++++++++++++++++++----------------------
 makedumpfile.h |    1 -
 2 files changed, 20 insertions(+), 23 deletions(-)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
