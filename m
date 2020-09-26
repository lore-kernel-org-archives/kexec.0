Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <20200918132439.1475479-1-arnd@arndb.de>
 <20200918132439.1475479-4-arnd@arndb.de>
 <20200919053807.GK30063@infradead.org>
In-Reply-To: <20200919053807.GK30063@infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 26 Sep 2020 17:21:29 +0200
Message-ID: <CAK8P3a15GEGL8AnxTYZxD_EeGb7__v=iy6rTfCTNq2jmsQe9fQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: remove compat_sys_move_pages
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
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Eric Biederman <ebiederm@xmission.com>

On Sat, Sep 19, 2020 at 7:38 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> I'd just keep the native version inline and have the compat one in
> a helper, but that is just a minor detail.

Folded in this change:

diff --git a/mm/migrate.c b/mm/migrate.c
index e9dfbde5f12c..d3fa3f4bf653 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1835,18 +1835,14 @@ static void do_pages_stat_array(struct
mm_struct *mm, unsigned long nr_pages,
        mmap_read_unlock(mm);
 }

-static int put_pages_array(const void __user *chunk_pages[],
-                          const void __user * __user *pages,
-                          unsigned long chunk_nr)
+static int put_compat_pages_array(const void __user *chunk_pages[],
+                                 const void __user * __user *pages,
+                                 unsigned long chunk_nr)
 {
        compat_uptr_t __user *pages32 = (compat_uptr_t __user *)pages;
        compat_uptr_t p;
        int i;

-       if (!in_compat_syscall())
-               return copy_from_user(chunk_pages, pages,
-                                     chunk_nr * sizeof(*chunk_pages));
-
        for (i = 0; i < chunk_nr; i++) {
                if (get_user(p, pages32 + i))
                        return -EFAULT;
@@ -1875,8 +1871,15 @@ static int do_pages_stat(struct mm_struct *mm,
unsigned long nr_pages,
                if (chunk_nr > DO_PAGES_STAT_CHUNK_NR)
                        chunk_nr = DO_PAGES_STAT_CHUNK_NR;

-               if (put_pages_array(chunk_pages, pages, chunk_nr))
-                       break;
+               if (in_compat_syscall()) {
+                       if (put_compat_pages_array(chunk_pages, pages,
+                                                  chunk_nr))
+                               break;
+               } else {
+                       if (copy_from_user(chunk_pages, pages,
+                                     chunk_nr * sizeof(*chunk_pages)))
+                               break;
+               }

                do_pages_stat_array(mm, chunk_nr, chunk_pages, chunk_status);

It does make the separation cleaner but it's also more code, which is
why I had it in the combined function before.

      Arnd

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
