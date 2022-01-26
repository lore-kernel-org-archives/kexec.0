From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Wed, 26 Jan 2022 18:20:52 +0800
Subject: [PATCH 2/2] kexec-tools: mips: Concatenate --reuse-cmdline and
 --append
In-Reply-To: <1643192452-4046-1-git-send-email-yangtiezhu@loongson.cn>
References: <1643192452-4046-1-git-send-email-yangtiezhu@loongson.cn>
Message-ID: <1643192452-4046-3-git-send-email-yangtiezhu@loongson.cn>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Use concat_cmdline() to concatenate the --append string and
the --reuse-cmdline string, otherwise only one of the two
options is valid.

This is similar with commit 8b42c99aa3bc ("Fix --reuse-cmdline
so it is usable.").

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 kexec/arch/mips/kexec-mips.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
index 10ae45b..d8cbea8 100644
--- a/kexec/arch/mips/kexec-mips.c
+++ b/kexec/arch/mips/kexec-mips.c
@@ -109,15 +109,17 @@ int arch_process_options(int argc, char **argv)
 	};
 	static const char short_options[] = KEXEC_ARCH_OPT_STR;
 	int opt;
+	char *cmdline = NULL;
+	const char *append = NULL;
 
 	while ((opt = getopt_long(argc, argv, short_options,
 				  options, 0)) != -1) {
 		switch (opt) {
 		case OPT_APPEND:
-			arch_options.command_line = optarg;
+			append = optarg;
 			break;
 		case OPT_REUSE_CMDLINE:
-			arch_options.command_line = get_command_line();
+			cmdline = get_command_line();
 			break;
 		case OPT_DTB:
 			arch_options.dtb_file = optarg;
@@ -130,6 +132,8 @@ int arch_process_options(int argc, char **argv)
 		}
 	}
 
+	arch_options.command_line = concat_cmdline(cmdline, append);
+
 	dbgprintf("%s:%d: command_line: %s\n", __func__, __LINE__,
 		arch_options.command_line);
 	dbgprintf("%s:%d: initrd: %s\n", __func__, __LINE__,
-- 
2.1.0


