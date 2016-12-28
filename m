Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cM5yt-00063n-SN
 for kexec@lists.infradead.org; Wed, 28 Dec 2016 04:36:53 +0000
Received: by mail-pg0-x230.google.com with SMTP id y62so99568565pgy.1
 for <kexec@lists.infradead.org>; Tue, 27 Dec 2016 20:36:31 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v29 7/9] arm64: kdump: enable kdump in defconfig
Date: Wed, 28 Dec 2016 13:36:04 +0900
Message-Id: <20161228043605.27470-6-takahiro.akashi@linaro.org>
In-Reply-To: <20161228043347.27358-1-takahiro.akashi@linaro.org>
References: <20161228043347.27358-1-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com
Cc: mark.rutland@arm.com, geoff@infradead.org, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

Kdump is enabled by default as kexec is.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 869dded0f09f..5ce7cd00f4ea 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -79,6 +79,7 @@ CONFIG_CMA=y
 CONFIG_SECCOMP=y
 CONFIG_XEN=y
 CONFIG_KEXEC=y
+CONFIG_CRASH_DUMP=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
 CONFIG_CPU_IDLE=y
-- 
2.11.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
