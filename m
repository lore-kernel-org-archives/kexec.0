From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Wed, 26 Jan 2022 18:20:51 +0800
Subject: [PATCH 1/2] kexec-tools: mips: Add some debug info
In-Reply-To: <1643192452-4046-1-git-send-email-yangtiezhu@loongson.cn>
References: <1643192452-4046-1-git-send-email-yangtiezhu@loongson.cn>
Message-ID: <1643192452-4046-2-git-send-email-yangtiezhu@loongson.cn>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Use dbgprintf() to print command_line, initrd and dtb
in arch_process_options() for debugging.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 kexec/arch/mips/kexec-mips.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
index 5866e24..10ae45b 100644
--- a/kexec/arch/mips/kexec-mips.c
+++ b/kexec/arch/mips/kexec-mips.c
@@ -130,6 +130,13 @@ int arch_process_options(int argc, char **argv)
 		}
 	}
 
+	dbgprintf("%s:%d: command_line: %s\n", __func__, __LINE__,
+		arch_options.command_line);
+	dbgprintf("%s:%d: initrd: %s\n", __func__, __LINE__,
+		arch_options.initrd_file);
+	dbgprintf("%s:%d: dtb: %s\n", __func__, __LINE__,
+		arch_options.dtb_file);
+
 	return 0;
 }
 
-- 
2.1.0


