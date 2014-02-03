Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WANjt-00034L-9c
 for kexec@lists.infradead.org; Mon, 03 Feb 2014 17:55:22 +0000
Received: by mail-qa0-f44.google.com with SMTP id w5so10679982qac.31
 for <kexec@lists.infradead.org>; Mon, 03 Feb 2014 09:54:53 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 3 Feb 2014 18:54:52 +0100
Message-ID: <CAL5wTH6B-QYbY9bcC+HuBJkk=rEEZhQsggi921YtbGNS4xUfxQ@mail.gmail.com>
Subject: [PATCH] Avoid buffer overflow on strncat usage
From: =?UTF-8?B?RGlyayBNw7xsbGVy?= <dirk@dmllr.de>
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

strncat() does not want the total size but the maximum length.

Signed-off-by: Dirk Mueller <dmueller@suse.com>
---
 kexec/fs2dt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
index 73c1fb9..65a8b66 100644
--- a/kexec/fs2dt.c
+++ b/kexec/fs2dt.c
@@ -649,8 +649,8 @@ static void putnode(void)
                        goto no_debug;
                }
                strncpy(filename, "/proc/device-tree/", MAXPATH);
-               strncat(filename, buff, MAXPATH);
-               strncat(filename, "/compatible", MAXPATH);
+               strncat(filename, buff, MAXPATH-strlen(filename)-1);
+               strncat(filename, "/compatible", MAXPATH-strlen(filename)-1);
                fd = open(filename, O_RDONLY);
                if (fd == -1) {
                        printf("Unable to find %s printing from
purgatory is diabled\n",
-- 
1.8.4.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
