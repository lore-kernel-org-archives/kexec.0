Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VEnuh-0002Az-P4
 for kexec@lists.infradead.org; Wed, 28 Aug 2013 22:08:35 +0000
Subject: [PATCH] makedumpfile: reverse -c and -p if using snappy compression
Message-Id: <E1VEnuJ-0000Js-Gl@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Wed, 28 Aug 2013 17:08:07 -0500
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

From: Cliff Wickman <cpw@sgi.com>

Reverse the meanings of -c (compression) and -p (snappy compression) if
USESNAPPY is defined.

The distro kdump scripts seem to only support -c for compression.
So make -c mean snappy compression if it is supported.

Diffed against makedumpfile-1.5.4
Signed-off-by: Cliff Wickman <cpw@sgi.com>
---
 makedumpfile.c |   10 ++++++++++
 print_info.c   |   13 +++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

Index: makedumpfile-1.5.4/makedumpfile.c
===================================================================
--- makedumpfile-1.5.4.orig/makedumpfile.c
+++ makedumpfile-1.5.4/makedumpfile.c
@@ -8607,7 +8607,12 @@ main(int argc, char *argv[])
 			info->name_filterconfig = optarg;
 			break;
 		case 'c':
+#ifdef USESNAPPY
+			/* if snappy is available make it the default */
+			info->flag_compress = DUMP_DH_COMPRESSED_SNAPPY;
+#else
 			info->flag_compress = DUMP_DH_COMPRESSED_ZLIB;
+#endif
 			break;
 		case 'D':
 			flag_debug = TRUE;
@@ -8656,7 +8661,12 @@ main(int argc, char *argv[])
 			info->flag_dmesg = 1;
 			break;
 		case 'p':
+#ifdef USESNAPPY
+			/* is snappy is available only use zlib with -p */
+			info->flag_compress = DUMP_DH_COMPRESSED_ZLIB;
+#else
 			info->flag_compress = DUMP_DH_COMPRESSED_SNAPPY;
+#endif
 			break;
 		case 'P':
 			info->xen_phys_start = strtoul(optarg, NULL, 0);
Index: makedumpfile-1.5.4/print_info.c
===================================================================
--- makedumpfile-1.5.4.orig/print_info.c
+++ makedumpfile-1.5.4/print_info.c
@@ -41,9 +41,9 @@ print_usage(void)
 #endif
 	MSG("snappy support:\n");
 #ifdef USESNAPPY
-	MSG("  enabled\n");
+	MSG("  enabled using -c\n");
 #else
-	MSG("  disabled ('-p' option will be ignored.)\n");
+	MSG("  disabled\n");
 #endif
 	MSG("\n");
 	MSG("Usage:\n");
@@ -90,8 +90,13 @@ print_usage(void)
 	MSG("\n");
 	MSG("Available options:\n");
 	MSG("  [-c|-l|-p]:\n");
-	MSG("      Compress dump data by each page using zlib for -c option, lzo for -l option\n");
-	MSG("      or snappy for -p option. A user cannot specify either of these options with\n");
+#ifdef USESNAPPY
+	MSG("      Compress dump data by each page using zlib for -p option, lzo for -l option\n");
+	MSG("      or snappy for -c option. A user cannot specify any of these options with\n");
+#else
+	MSG("      Compress dump data by each page using zlib for -c option or lzo for -l option\n");
+	MSG("      A user cannot specify either of these options with\n");
+#endif
 	MSG("      -E option, because the ELF format does not support compressed data.\n");
 	MSG("      THIS IS ONLY FOR THE CRASH UTILITY.\n");
 	MSG("\n");

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
