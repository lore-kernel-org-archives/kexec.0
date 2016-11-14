Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c690J-00047B-1s
 for kexec@lists.infradead.org; Mon, 14 Nov 2016 04:36:24 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: vmcore cant be generated under kernel 4.7.9
Date: Mon, 14 Nov 2016 04:29:05 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E7EE5F@BPXM01GP.gisp.nec.co.jp>
References: <CAN3hGLe_ga1vE=6HhTaKcgDBqUApj9w4rtzX2EB3BoDo5iOKdw@mail.gmail.com>
In-Reply-To: <CAN3hGLe_ga1vE=6HhTaKcgDBqUApj9w4rtzX2EB3BoDo5iOKdw@mail.gmail.com>
Content-Language: ja-JP
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
To: R Sun <ulxwork@gmail.com>
Cc: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>, Daisuke Nishimura <dai-nishimura@rc.jp.nec.com>, Minoru Usui <min-usui@ti.jp.nec.com>, kexec-ml <kexec@lists.infradead.org>

Hello,

>Hello,
>
>I updated my fedora23 from 4.5.7-202 to 4.7.9-100 recently, and found out kdump
>could not generate vmcore when crashed, but its ok with
>vmcore-dmesg.txt. i traced
>it for a while and find out its because of a change in the page struct
>which _count renamed to _refcount committed as 0139aa7b7f in kernel.
>
>Below is my patch to fix this problem

Thanks for your report, this problem is going to be fixed in v1.6.1
by the patch below, it can be found in the devel branch.

https://sourceforge.net/p/makedumpfile/code/ci/devel/tree/

commit ed46b6ad90d71ca98aced9e82b67333ce1962ebf
Author: Vitaly Kuznetsov <vkuznets@redhat.com>
Date:   Fri Jun 17 18:41:26 2016 +0900

    [PATCH v2] Support _count -> _refcount rename in struct page

    * Required for kernel 4.7

    _count member was renamed to _refcount in linux commit 0139aa7b7fa12
    ("mm: rename _count, field of the struct page, to _refcount") and this
    broke makedumpfile. The reason for making the change was to find all users
    accessing it directly and not through the recommended API. I tried
    suggesting to revert the change but failed, I see no other choice than to
    start supporting both _count and _refcount in makedumpfile.

    Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>


I'll try to release the next version in this month, please wait for a while.


Thanks,
Atsushi Kumagai

>diff --git a/makedumpfile.c b/makedumpfile.c
>index 853b999..1bfafb7 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -2492,6 +2492,13 @@ read_vmcoreinfo(void)
>
>        READ_MEMBER_OFFSET("page.flags", page.flags);
>        READ_MEMBER_OFFSET("page._count", page._count);
>+       /*
>+        * _count, field of struct page, renamed to _refcount according to
>+        * commit 0139aa7b7f in kernel. so just try page._refcount if
>+        * page._count does not work
>+        */
>+       if (OFFSET(page._count) == NOT_FOUND_STRUCTURE)
>+               READ_MEMBER_OFFSET("page._refcount", page._count);
>        READ_MEMBER_OFFSET("page.mapping", page.mapping);
>        READ_MEMBER_OFFSET("page.lru", page.lru);
>        READ_MEMBER_OFFSET("page._mapcount", page._mapcount);
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
