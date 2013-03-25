Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UK2Dz-0005e1-Bd
 for kexec@lists.infradead.org; Mon, 25 Mar 2013 07:53:48 +0000
Received: by mail-wg0-f46.google.com with SMTP id fg15so392266wgb.13
 for <kexec@lists.infradead.org>; Mon, 25 Mar 2013 00:53:45 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 25 Mar 2013 15:53:44 +0800
Message-ID: <CAFNq8R6tPJXVAyE-zzYgMPw1n5CGRtrqDZUFgOFW-0Z8nEd5iw@mail.gmail.com>
Subject: [PATCH] kexec:Fix Makefile of linking kdump file
From: Li Haifeng <omycle@gmail.com>
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
To: horms@verge.net.au, kexec@lists.infradead.org

When make kdump object file, the expression of linking kdump ignores
LDFLAGS. If someone want to build kdump with static links, it won't
product object file with static attributes. So, fix it.

Signed-off-by: Haifeng Li <omycle@gmail.com>
---
 kdump/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kdump/Makefile b/kdump/Makefile
index 5dfa928..307d59d 100644
--- a/kdump/Makefile
+++ b/kdump/Makefile
@@ -18,7 +18,7 @@ clean += $(KDUMP_OBJS) $(KDUMP_DEPS) $(KDUMP) $(KDUMP_MANPAGE)
 $(KDUMP): CC=$(TARGET_CC)
 $(KDUMP): $(KDUMP_OBJS)
        @$(MKDIR) -p $(@D)
-       $(CC) $(CFLAGS) $(EXTRA_CFLAGS) -o $@ $(KDUMP_OBJS)
+       $(LINK.o) -o $@ $^ $(CFLAGS) $(LIBS)

 $(KDUMP_MANPAGE): kdump/kdump.8
        $(MKDIR) -p     $(MANDIR)/man8
--
1.7.9.5

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
