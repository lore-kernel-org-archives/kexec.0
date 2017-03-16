Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1coVby-0005TK-PY
 for kexec@lists.infradead.org; Thu, 16 Mar 2017 13:38:42 +0000
Subject: Re: [PATCH] kexec: Update vmcoreinfo after crash happened
References: <1489666587-24103-1-git-send-email-xlpang@redhat.com>
 <20170316122730.GB23625@x1> <58CA86D2.70800@redhat.com>
 <20170316131809.GC23625@x1>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <58CA95EA.1040807@redhat.com>
Date: Thu, 16 Mar 2017 21:40:58 +0800
MIME-Version: 1.0
In-Reply-To: <20170316131809.GC23625@x1>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: xlpang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>, xlpang@redhat.com
Cc: Dave Young <dyoung@redhat.com>, akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>

On 03/16/2017 at 09:18 PM, Baoquan He wrote:
> On 03/16/17 at 08:36pm, Xunlei Pang wrote:
>> On 03/16/2017 at 08:27 PM, Baoquan He wrote:
>>> Hi Xunlei,
>>>
>>> Did you really see this ever happened? Because the vmcore size estimate
>>> feature, namely --mem-usage option of makedumpfile, depends on the
>>> vmcoreinfo in 1st kernel, your change will break it.
>> Hi Baoquan,
>>
>> I can reproduce it using a kernel module which modifies the vmcoreinfo,
>> so it's a problem can actually happen.
>>
>>> If not, it could be not good to change that.
>> That's a good point, then I guess we can keep the crash_save_vmcoreinfo_init(),
>> and store again all the vmcoreinfo after crash. What do you think?
> Well, then it will make makedumpfile segfault happen too when execute
> below command in 1st kernel if it existed:
> 	makedumpfile --mem-usage /proc/kcore

Yes, if the initial vmcoreinfo data was modified before "makedumpfile --mem-usage", it might happen,
after all the system is going something wrong. And that's why we deploy kdump service at the very
beginning when the system has a low possibility of going wrong.

But we have to guarantee kdump vmcore can be generated correctly as possible as it can.

>
> So we still need to face that problem and need fix it. vmcoreinfo_note
> is in kernel data area, how does module intrude into this area? And can
> we fix the module code?
>

Bugs always exist in products, we can't know what will happen and fix all the errors,
that's why we need kdump.

I think the following update should guarantee the correct vmcoreinfo for kdump.

---
 kernel/kexec_core.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index bfe62d5..0f7b328 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1367,12 +1367,6 @@ static void update_vmcoreinfo_note(void)
     final_note(buf);
 }
 
-void crash_save_vmcoreinfo(void)
-{
-    vmcoreinfo_append_str("CRASHTIME=%ld\n", get_seconds());
-    update_vmcoreinfo_note();
-}
-
 void vmcoreinfo_append_str(const char *fmt, ...)
 {
     va_list args;
@@ -1402,7 +1396,7 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
     return __pa_symbol((unsigned long)(char *)&vmcoreinfo_note);
 }
 
-static int __init crash_save_vmcoreinfo_init(void)
+static void do_crash_save_vmcoreinfo_init(void)
 {
     VMCOREINFO_OSRELEASE(init_uts_ns.name.release);
     VMCOREINFO_PAGESIZE(PAGE_SIZE);
@@ -1474,6 +1468,20 @@ static int __init crash_save_vmcoreinfo_init(void)
 #endif
 
     arch_crash_save_vmcoreinfo();
+}
+
+void crash_save_vmcoreinfo(void)
+{
+    /* Save again to protect vmcoreinfo from being modified */
+    vmcoreinfo_size = 0;
+    do_crash_save_vmcoreinfo_init();
+    vmcoreinfo_append_str("CRASHTIME=%ld\n", get_seconds());
+    update_vmcoreinfo_note();
+}
+
+static int __init crash_save_vmcoreinfo_init(void)
+{
+    do_crash_save_vmcoreinfo_init();
     update_vmcoreinfo_note();
 
     return 0;
-- 
1.8.3.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
