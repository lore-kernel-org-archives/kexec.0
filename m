Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga03-in.huawei.com ([119.145.14.66])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wdu04-0002yv-3f
 for kexec@lists.infradead.org; Sat, 26 Apr 2014 04:14:05 +0000
From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 0/4] Replace lseek..write/read to pwrite/pread
Date: Sat, 26 Apr 2014 12:07:05 +0800
Message-ID: <1398485229-43295-1-git-send-email-wangnan0@huawei.com>
MIME-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: Wang Nan <wangnan0@huawei.com>, Liu Hua <sdu.liu@huawei.com>, Petr Tesarik <ptesarik@suse.cz>, kexec@lists.infradead.org, Geng Hui <hui.geng@huawei.com>

In original code there are many operations read from /write to specific
positions of a file. This series of patches replace such patterns to
pread/pwrite calls, reduces more than 100 lines of code.

Wang Nan (4):
  makedumpfile: redefine numerical limitaction macros.
  makedumpfile: cleanup non-standard ULONGLONG_MAX macros
  makedumpfile: add -D_GNU_SOURCE to CFLAGS
  makedumpfile: use pread/pwrite to eliminate lseek

 Makefile       |   4 +-
 common.h       |  19 ++++--
 makedumpfile.c | 198 ++++++++++++---------------------------------------------
 3 files changed, 58 insertions(+), 163 deletions(-)

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: Petr Tesarik <ptesarik@suse.cz>
Cc: kexec@lists.infradead.org
Cc: Geng Hui <hui.geng@huawei.com>
Cc: Liu Hua <sdu.liu@huawei.com>

-- 
1.8.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
