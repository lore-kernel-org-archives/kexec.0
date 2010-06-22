Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [PATCH 0/3] makedumpfile: add support for ARM crashdumps
Date: Tue, 22 Jun 2010 09:59:09 +0300
Message-Id: <cover.1277188127.git.ext-mika.1.westerberg@nokia.com>
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
To: oomichi@mxs.nes.nec.co.jp, tachibana@mxm.nes.nec.co.jp
Cc: kexec@lists.infradead.org, "\\\"Mika Westerberg\\\"" <ext-mika.1.westerberg@nokia.com>, linux-arm-kernel@lists.infradead.org

Hello,

This series adds support for ARM kernel crashdumps to makedumpfile. Although,
kernel support is not yet in mainline, I think that it doesn't hurt to have
necessary userspace tools available when that happens.

If someone wants to try, kernel patches can be found:
	http://lists.infradead.org/pipermail/linux-arm-kernel/2010-May/014230.html

and kexec-tools already contain ARM crashdump support.

Regards,
MW

Mika Westerberg (3):
  use ARCH_PFN_OFFSET for pfn_to_paddr/paddr_to_pfn translations
  page_to_pfn(): use ULONGLONG_MAX to for invalid pfn
  add ARM crashdump support

 Makefile       |    4 +-
 arm.c          |  200 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.c |    7 +-
 makedumpfile.h |   43 ++++++++++++-
 4 files changed, 247 insertions(+), 7 deletions(-)
 create mode 100644 arm.c


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
