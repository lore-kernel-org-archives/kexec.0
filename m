Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c5ObB-0001GU-OU
 for kexec@lists.infradead.org; Sat, 12 Nov 2016 03:03:22 +0000
Received: by mail-lf0-x243.google.com with SMTP id o141so2449825lff.1
 for <kexec@lists.infradead.org>; Fri, 11 Nov 2016 19:02:59 -0800 (PST)
MIME-Version: 1.0
From: R Sun <ulxwork@gmail.com>
Date: Sat, 12 Nov 2016 11:02:57 +0800
Message-ID: <CAN3hGLe_ga1vE=6HhTaKcgDBqUApj9w4rtzX2EB3BoDo5iOKdw@mail.gmail.com>
Subject: vmcore cant be generated under kernel 4.7.9
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
To: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>, Minoru Usui <min-usui@ti.jp.nec.com>, Daisuke Nishimura <dai-nishimura@rc.jp.nec.com>, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, kexec-ml <kexec@lists.infradead.org>

Hello,

I updated my fedora23 from 4.5.7-202 to 4.7.9-100 recently, and found out kdump
could not generate vmcore when crashed, but its ok with
vmcore-dmesg.txt. i traced
it for a while and find out its because of a change in the page struct
which _count renamed to _refcount committed as 0139aa7b7f in kernel.

Below is my patch to fix this problem

diff --git a/makedumpfile.c b/makedumpfile.c
index 853b999..1bfafb7 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2492,6 +2492,13 @@ read_vmcoreinfo(void)

        READ_MEMBER_OFFSET("page.flags", page.flags);
        READ_MEMBER_OFFSET("page._count", page._count);
+       /*
+        * _count, field of struct page, renamed to _refcount according to
+        * commit 0139aa7b7f in kernel. so just try page._refcount if
+        * page._count does not work
+        */
+       if (OFFSET(page._count) == NOT_FOUND_STRUCTURE)
+               READ_MEMBER_OFFSET("page._refcount", page._count);
        READ_MEMBER_OFFSET("page.mapping", page.mapping);
        READ_MEMBER_OFFSET("page.lru", page.lru);
        READ_MEMBER_OFFSET("page._mapcount", page._mapcount);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
