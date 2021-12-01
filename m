Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1msPxh-008sm6-Mw
 for kexec@lists.infradead.org; Wed, 01 Dec 2021 13:47:56 +0000
Received: by mail-ed1-x533.google.com with SMTP id x15so101739225edv.1
 for <kexec@lists.infradead.org>; Wed, 01 Dec 2021 05:47:53 -0800 (PST)
From: Ivan Khoronzhuk <ivan.khoronzhuk@gmail.com>
Subject: [RFC makedumpfile: add userinfo elf section 1/4] makedumpfile: rename
 check_dump_file() on check_file_is_writable()
Date: Wed,  1 Dec 2021 15:47:27 +0200
Message-Id: <20211201134730.15943-2-ikhoronz@cisco.com>
In-Reply-To: <20211201134730.15943-1-ikhoronz@cisco.com>
References: <20211201134730.15943-1-ikhoronz@cisco.com>
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
To: k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: Ivan Khoronzhuk <ikhoronz@cisco.com>

Make function for checking the file can be written to be more flex
by renaming check_dump_file() on check_file_is_writable().

Signed-off-by: Ivan Khoronzhuk <ikhoronz@cisco.com>
---
 makedumpfile.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 3d1d412..6b62b92 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1397,7 +1397,7 @@ open_dump_file(void)
 }
 
 int
-check_dump_file(const char *path)
+check_file_is_writable(const char *path)
 {
 	char *err_str;
 
@@ -1410,7 +1410,7 @@ check_dump_file(const char *path)
 	} else {
 		err_str = strerror(EEXIST);
 	}
-	ERRMSG("Can't open the dump file (%s). %s\n", path, err_str);
+	ERRMSG("Can't open the file (%s). %s\n", path, err_str);
 	return FALSE;
 }
 
@@ -11954,7 +11954,7 @@ main(int argc, char *argv[])
 		if (info->flag_check_params)
 			goto check_ok;
 
-		if (!check_dump_file(info->name_dumpfile))
+		if (!check_file_is_writable(info->name_dumpfile))
 			goto out;
 
 		if (!open_files_for_rearranging_dumpdata())
@@ -11977,7 +11977,7 @@ main(int argc, char *argv[])
 		if (info->flag_check_params)
 			goto check_ok;
 
-		if (!check_dump_file(info->name_dumpfile))
+		if (!check_file_is_writable(info->name_dumpfile))
 			goto out;
 
 		if (!reassemble_dumpfile())
@@ -11993,7 +11993,7 @@ main(int argc, char *argv[])
 		if (info->flag_check_params)
 			goto check_ok;
 
-		if (!check_dump_file(info->name_dumpfile))
+		if (!check_file_is_writable(info->name_dumpfile))
 			goto out;
 		if (!dump_dmesg())
 			goto out;
@@ -12033,11 +12033,11 @@ main(int argc, char *argv[])
 		if (info->flag_split) {
 			for (i = 0; i < info->num_dumpfile; i++) {
 				SPLITTING_FD_BITMAP(i) = -1;
-				if (!check_dump_file(SPLITTING_DUMPFILE(i)))
+				if (!check_file_is_writable(SPLITTING_DUMPFILE(i)))
 					goto out;
 			}
 		} else {
-			if (!check_dump_file(info->name_dumpfile))
+			if (!check_file_is_writable(info->name_dumpfile))
 				goto out;
 		}
 
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
