Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 0/3] Bugfix for kdump on arm
Date: Wed, 22 Jan 2014 19:25:13 +0800
Message-ID: <1390389916-8711-1-git-send-email-wangnan0@huawei.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Wang Nan <wangnan0@huawei.com>, linux-kernel@vger.kernel.org, Geng Hui <hui.geng@huawei.com>, linux-mm@kvack.org, Eric Biederman <ebiederm@xmission.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org

This patch series introduce 3 bugfix for kdump (and kexec) on arm platform.

kdump for arm in fact is corrupted (at least for omap4460). With one-month hard
work and with the help of a jtag debugger, we finally make kdump works
reliablly.


Following is the patches. The first 2 patches forms a group, it allow
ioremap_nocache to be taken on reserved pages on arm platform (which is
prohibited by 309caa9cc) and then use ioremap_nocache to copy kexec required
code. The last 1 is for crash dump kernel. It allow kernel to be loaded in the
middle of kernel awared physical memory. Without it, crashdump kernel must be
carefully configured to boot.

Wang Nan (3):
  ARM: Premit ioremap() to map reserved pages
  ARM: kexec: copying code to ioremapped area
  ARM: allow kernel to be loaded in middle of phymem

 arch/arm/kernel/machine_kexec.c | 18 ++++++++++++++++--
 arch/arm/mm/init.c              | 21 ++++++++++++++++++++-
 arch/arm/mm/ioremap.c           |  2 +-
 arch/arm/mm/mmu.c               | 13 +++++++++++++
 kernel/kexec.c                  | 40 +++++++++++++++++++++++++++++++++++-----
 mm/page_alloc.c                 |  7 +++++--
 6 files changed, 90 insertions(+), 11 deletions(-)


Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Geng Hui <hui.geng@huawei.com>

-- 
1.8.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
