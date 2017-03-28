Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cskwh-0005ZY-MA
 for kexec@lists.infradead.org; Tue, 28 Mar 2017 06:49:37 +0000
Received: by mail-pg0-x22a.google.com with SMTP id g2so63100434pge.3
 for <kexec@lists.infradead.org>; Mon, 27 Mar 2017 23:49:14 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v34 11/14] arm64: kdump: enable kdump in defconfig
Date: Tue, 28 Mar 2017 15:51:29 +0900
Message-Id: <20170328065130.16019-9-takahiro.akashi@linaro.org>
In-Reply-To: <20170328064831.15894-1-takahiro.akashi@linaro.org>
References: <20170328064831.15894-1-takahiro.akashi@linaro.org>
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
Cc: mark.rutland@arm.com, panand@redhat.com, ard.biesheuvel@linaro.org, geoff@infradead.org, dwmw2@infradead.org, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, bauerman@linux.vnet.ibm.com, sgoel@codeaurora.org, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

Kdump is enabled by default as kexec is.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7c48028ec64a..927ee18bbdf2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -82,6 +82,7 @@ CONFIG_CMA=y
 CONFIG_SECCOMP=y
 CONFIG_XEN=y
 CONFIG_KEXEC=y
+CONFIG_CRASH_DUMP=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
 CONFIG_CPU_IDLE=y
-- 
2.11.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
