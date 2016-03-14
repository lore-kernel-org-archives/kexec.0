Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <514118dc2ebf4e391fff5c1cc862daec3643c210.1457977403.git.geoff@infradead.org>
In-Reply-To: <cover.1457977401.git.geoff@infradead.org>
References: <cover.1457977401.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH v15 19/20] arm64: kdump: enable kdump in the arm64 defconfig
Date: Mon, 14 Mar 2016 17:48:01 +0000
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
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 288cbd6..16bf6dc 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -65,6 +65,7 @@ CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_CMA=y
 CONFIG_XEN=y
 CONFIG_KEXEC=y
+CONFIG_CRASH_DUMP=y
 CONFIG_CMDLINE="console=ttyAMA0"
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
-- 
2.5.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
