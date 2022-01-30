From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Sun, 30 Jan 2022 08:29:08 +0800
Subject: [PATCH 4/5] sched: unset panic_on_warn before calling panic()
In-Reply-To: <CANpmjNPYYAy2jy_U_c7QjTsco6f1Hk2q=HP34di4YRMgdKsa+g@mail.gmail.com>
References: <1643370145-26831-1-git-send-email-yangtiezhu@loongson.cn>
 <1643370145-26831-5-git-send-email-yangtiezhu@loongson.cn>
 <CANpmjNPYYAy2jy_U_c7QjTsco6f1Hk2q=HP34di4YRMgdKsa+g@mail.gmail.com>
Message-ID: <0e700c2c-8523-ebc3-f006-e463f1fb7d0f@loongson.cn>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



On 1/28/22 19:52, Marco Elver wrote:
> On Fri, 28 Jan 2022 at 12:42, Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> As done in the full WARN() handler, panic_on_warn needs to be cleared
>> before calling panic() to avoid recursive panics.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   kernel/sched/core.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 848eaa0..f5b0886 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -5524,8 +5524,17 @@ static noinline void __schedule_bug(struct task_struct *prev)
>>                  pr_err("Preemption disabled at:");
>>                  print_ip_sym(KERN_ERR, preempt_disable_ip);
>>          }
>> -       if (panic_on_warn)
>> +
>> +       if (panic_on_warn) {
>> +               /*
>> +                * This thread may hit another WARN() in the panic path.
>> +                * Resetting this prevents additional WARN() from panicking the
>> +                * system on this thread.  Other threads are blocked by the
>> +                * panic_mutex in panic().
>> +                */
>> +               panic_on_warn = 0;
>>                  panic("scheduling while atomic\n");
> 
> I agree this is worth fixing.
> 
> But: Why can't the "panic_on_warn = 0" just be moved inside panic(),
> instead of copy-pasting this all over the place?

OK, it looks better.

Let me wait for some days, if no more comments, I will send v2
to move "panic_on_warn = 0" inside panic() and remove it from
the other places, like this:

diff --git a/kernel/panic.c b/kernel/panic.c
index 55b50e052ec3..95ba825522dd 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -185,6 +185,16 @@ void panic(const char *fmt, ...)
         int old_cpu, this_cpu;
         bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;

+       if (panic_on_warn) {
+               /*
+                * This thread may hit another WARN() in the panic path.
+                * Resetting this prevents additional WARN() from 
panicking the
+                * system on this thread.  Other threads are blocked by the
+                * panic_mutex in panic().
+                */
+               panic_on_warn = 0;
+       }
+
         /*
          * Disable local interrupts. This will prevent panic_smp_self_stop
          * from deadlocking the first cpu that invokes the panic, since
@@ -576,16 +586,8 @@ void __warn(const char *file, int line, void 
*caller, unsigned taint,
         if (regs)
                 show_regs(regs);

-       if (panic_on_warn) {
-               /*
-                * This thread may hit another WARN() in the panic path.
-                * Resetting this prevents additional WARN() from 
panicking the
-                * system on this thread.  Other threads are blocked by the
-                * panic_mutex in panic().
-                */
-               panic_on_warn = 0;
+       if (panic_on_warn)
                 panic("panic_on_warn set ...\n");
-       }

         if (!regs)
                 dump_stack();
diff --git a/lib/ubsan.c b/lib/ubsan.c
index bdc380ff5d5c..36bd75e33426 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -154,16 +154,8 @@ static void ubsan_epilogue(void)

         current->in_ubsan--;

-       if (panic_on_warn) {
-               /*
-                * This thread may hit another WARN() in the panic path.
-                * Resetting this prevents additional WARN() from 
panicking the
-                * system on this thread.  Other threads are blocked by the
-                * panic_mutex in panic().
-                */
-               panic_on_warn = 0;
+       if (panic_on_warn)
                 panic("panic_on_warn set ...\n");
-       }
  }

  void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs)
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 3ad9624dcc56..f14146563d41 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -117,16 +117,8 @@ static void end_report(unsigned long *flags, 
unsigned long addr)
 
pr_err("==================================================================\n");
         add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
         spin_unlock_irqrestore(&report_lock, *flags);
-       if (panic_on_warn && !test_bit(KASAN_BIT_MULTI_SHOT, 
&kasan_flags)) {
-               /*
-                * This thread may hit another WARN() in the panic path.
-                * Resetting this prevents additional WARN() from 
panicking the
-                * system on this thread.  Other threads are blocked by the
-                * panic_mutex in panic().
-                */
-               panic_on_warn = 0;
+       if (panic_on_warn && !test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags))
                 panic("panic_on_warn set ...\n");
-       }
         if (kasan_arg_fault == KASAN_ARG_FAULT_PANIC)
                 panic("kasan.fault=panic set ...\n");
         kasan_enable_current();

Thanks,
Tiezhu

> 
> I may be missing something obvious why this hasn't been done before...
> 
> Thanks,
> -- Marco


