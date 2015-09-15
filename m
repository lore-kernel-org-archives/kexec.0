Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZbvGA-0000cp-PM
 for kexec@lists.infradead.org; Tue, 15 Sep 2015 18:47:19 +0000
Received: by pacfv12 with SMTP id fv12so187540991pac.2
 for <kexec@lists.infradead.org>; Tue, 15 Sep 2015 11:46:58 -0700 (PDT)
Message-ID: <55f8660b.84bd440a.620d1.ffffe1cb@mx.google.com>
Date: Tue, 15 Sep 2015 11:40:11 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 09/13] Move bp_type_idx to kernel/event/hw_breakpoint.c
In-Reply-To: <20150915080607.GW16853@twins.programming.kicks-ass.net>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: peterz@infradead.org
Cc: dave@sr71.net, linux-xtensa@linux-xtensa.org, fweisbec@gmail.com, dhowells@redhat.com, jcmvbkbc@gmail.com, hpa@zytor.com, mingo@kernel.org, ast@plumgrid.com, aarcange@redhat.com, bhe@redhat.com, x86@kernel.org, tomi.valkeinen@ti.com, 3chas3@gmail.com, paulmck@linux.vnet.ibm.com, dyoung@redhat.com, vgoyal@redhat.com, aishchuk@linux.vnet.ibm.com, linux-arch@vger.kernel.org, jikos@kernel.org, arnd@arndb.de, plagnioj@jcrosoft.com, josh@joshtriplett.org, acme@kernel.org, mathieu.desnoyers@efficios.com, viro@zeniv.linux.org.uk, luto@kernel.org, tglx@linutronix.de, drysdale@google.com, chris@zankel.net, iulia.manda21@gmail.com, geoff@infradead.org, gregkh@linuxfoundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, davem@davemloft.net

On Tue, 15 Sep 2015 01:06:07 PDT (-0700), peterz@infradead.org wrote:
> On Mon, Sep 14, 2015 at 03:50:43PM -0700, Palmer Dabbelt wrote:
>> This has a "#ifdef CONFIG_*" that used to be exposed to userspace.
>>
>> The names in here are so generic that I don't think it's a good idea
>> to expose them to userspace (or even the rest of the kernel).  Since
>> there's only one kernel user, it's been moved to that file.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>> Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
>> Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
>> ---
>>  include/uapi/linux/hw_breakpoint.h | 10 ----------
>>  kernel/events/hw_breakpoint.c      | 10 ++++++++++
>>  2 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/uapi/linux/hw_breakpoint.h b/include/uapi/linux/hw_breakpoint.h
>> index b04000a2296a..7a6a5a7f9511 100644
>> --- a/include/uapi/linux/hw_breakpoint.h
>> +++ b/include/uapi/linux/hw_breakpoint.h
>> @@ -17,14 +17,4 @@ enum {
>>  	HW_BREAKPOINT_INVALID   = HW_BREAKPOINT_RW | HW_BREAKPOINT_X,
>>  };
>>
>> -enum bp_type_idx {
>> -	TYPE_INST 	= 0,
>> -#ifdef CONFIG_HAVE_MIXED_BREAKPOINTS_REGS
>> -	TYPE_DATA	= 0,
>> -#else
>> -	TYPE_DATA	= 1,
>> -#endif
>> -	TYPE_MAX
>> -};
>
> This is rather unfortunate; you are correct that the naming is too
> generic (and I tend to agree), but I think these values are required by
> userspace to fill out:
>
>   perf_event_attr::bp_type
>
> So removing them will break things.
>
> Frederic?

perf_event_open(2) says

       bp_type (since Linux 2.6.33)
              This chooses the breakpoint type.  It is one of:

              HW_BREAKPOINT_EMPTY
                     No breakpoint.

              HW_BREAKPOINT_R
                     Count when we read the memory location.

              HW_BREAKPOINT_W
                     Count when we write the memory location.

              HW_BREAKPOINT_RW
                     Count when we read or write the memory location.

              HW_BREAKPOINT_X
                     Count when we execute code at the memory location.

              The values can be combined via a bitwise or, but the combination
              of HW_BREAKPOINT_R or HW_BREAKPOINT_W  with  HW_BREAKPOINT_X  is
              not allowed.

so I think removing this enum from userspace is OK.  Did I miss
something?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
