Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Chen Zhou <chenzhou10@huawei.com>
Subject: [PATCH v12 2/9] x86: kdump: make the lower bound of crash kernel
 reservation consistent
Date: Mon, 7 Sep 2020 21:47:38 +0800
Message-ID: <20200907134745.25732-3-chenzhou10@huawei.com>
In-Reply-To: <20200907134745.25732-1-chenzhou10@huawei.com>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
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
To: catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com, dyoung@redhat.com, bhe@redhat.com, corbet@lwn.net, John.P.donnelly@oracle.com, prabhakar.pkin@gmail.com, bhsharma@redhat.com
Cc: wangkefeng.wang@huawei.com, arnd@arndb.de, linux-doc@vger.kernel.org, chenzhou10@huawei.com, xiexiuqi@huawei.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, horms@verge.net.au, nsaenzjulienne@suse.de, huawei.libin@huawei.com, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org

The lower bounds of crash kernel reservation and crash kernel low
reservation are different, use the consistent value CRASH_ALIGN.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/x86/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 296294ad0dd8..d7fd90c52dae 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -451,7 +451,7 @@ static int __init reserve_crashkernel_low(void)
 			return 0;
 	}
 
-	low_base = memblock_find_in_range(0, 1ULL << 32, low_size, CRASH_ALIGN);
+	low_base = memblock_find_in_range(CRASH_ALIGN, 1ULL << 32, low_size, CRASH_ALIGN);
 	if (!low_base) {
 		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
 		       (unsigned long)(low_size >> 20));
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
