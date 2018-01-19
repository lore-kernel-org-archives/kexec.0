Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ecV7m-0006n7-5L
 for kexec@lists.infradead.org; Fri, 19 Jan 2018 11:46:23 +0000
From: Petr Tesarik <ptesarik@suse.com>
Subject: [makedumpfile PATCH 0/2] Fix calculations in exclude_segment()
Date: Fri, 19 Jan 2018 12:45:22 +0100
Message-Id: <cover.1516354241.git.ptesarik@suse.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: Baoquan He <bhe@redhat.com>, Petr Tesarik <ptesarik@suse.com>

I have observed that makedumpfile --mem-usage shows bogus numbers
on a kaslr-enabled kernel. This boils down to incorrect calculations
in exclude_segment(). Consequently, data beyond a split LOAD segment
are read from the wrong file offset.

Petr Tesarik (2):
  Fix off-by-one errors in exclude_segment()
  Fix physical-to-virtual conversion in exclude_segment()

 elf_info.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

-- 
2.13.6



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
