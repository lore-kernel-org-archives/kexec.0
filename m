Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ey0-f177.google.com ([209.85.215.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RQfPK-0000Jg-4K
 for kexec@lists.infradead.org; Wed, 16 Nov 2011 13:20:07 +0000
Received: by eye3 with SMTP id 3so465518eye.36
 for <kexec@lists.infradead.org>; Wed, 16 Nov 2011 05:20:04 -0800 (PST)
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: [Patch] kexec: improve the debug printf in get_crash_notes_per_cpu()
Date: Wed, 16 Nov 2011 21:19:44 +0800
Message-Id: <1321449584-25551-1-git-send-email-xiyou.wangcong@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: WANG Cong <xiyou.wangcong@gmail.com>, horms@verge.net.au

Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

---
diff --git a/kexec/crashdump.c b/kexec/crashdump.c
index 945b052..e7ac42c 100644
--- a/kexec/crashdump.c
+++ b/kexec/crashdump.c
@@ -102,8 +102,8 @@ int get_crash_notes_per_cpu(int cpu, uint64_t *addr, uint64_t *len)
 		die("Cannot parse %s: %s\n", crash_notes, strerror(errno));
 	*addr = (uint64_t) temp;
 	*len = MAX_NOTE_BYTES; /* we should get this from the kernel instead */
-#if 0
-	printf("crash_notes addr = %Lx\n", *addr);
+#ifdef DEBUG
+	printf("%s: crash_notes addr = %Lx\n", __function__, *addr);
 #endif
 
 	fclose(fp);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
