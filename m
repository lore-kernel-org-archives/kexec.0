Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TGXWG-00035g-03
 for kexec@lists.infradead.org; Tue, 25 Sep 2012 15:57:56 +0000
Received: by vcqp16 with SMTP id p16so8116810vcq.36
 for <kexec@lists.infradead.org>; Tue, 25 Sep 2012 08:57:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <871uhqnnoz.fsf@xmission.com>
References: <E1TGHkf-0006ZB-22@eag09.americas.sgi.com>
 <877grissof.fsf@xmission.com> <20120925141834.GA6184@sgi.com>
 <871uhqnnoz.fsf@xmission.com>
Date: Tue, 25 Sep 2012 19:57:52 +0400
Message-ID: <CAJGZr0+mobcYcCdJ8trb3Qi6g7J-d3oxVrtX6d5Q6d2ULnpGbQ@mail.gmail.com>
Subject: Re: 896MB address limit
From: Maxim Uvarov <muvarov@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, Cliff Wickman <cpw@sgi.com>

In the most cases you need to boot crash kernel with nr_cpus=1
parameter. In that case you will not allocate per cpus buffers  for
other cpus. Saving dump on more the one cpu does not give any benefit.
So it's very rare case where you need  such huge memory only for save
dump process. You might be looking to the problem from the work side.

Maxim.

2012/9/25 Eric W. Biederman <ebiederm@xmission.com>:
> Cliff Wickman <cpw@sgi.com> writes:
>
>> Hi Eric, and all,
>>
>> On Mon, Sep 24, 2012 at 08:11:12PM -0700, Eric W. Biederman wrote:
>>> Cliff Wickman <cpw@sgi.com> writes:
>>>
>>> > Gentlemen,
>>> >
>>> > In dumping very large memories we are running up against the 896MB
>>> > limit in SLES11SP2 (3.0.38 kernel).
>>>
>>> Odd.  That limit should be the maximum address in memory to load the
>>> crash kernel.  Tha limit should have nothing to do with the dump process
>>> itself.
>>>
>>> Are you saying you need more that 512MiB reserved for the crash kernel
>>> to be able to dump all of the memory in your system?
>>>
>>> Eric
>>
>> As I noted to Eric privately, yes we need to bump up to crashkernel=1G
>> or more for some very large memories.
>>
>> As an experiment I bumped
>> +++ linux/arch/x86/kernel/setup.c
>> @@ -528,7 +528,7 @@ static inline unsigned long long get_tot
>>  #ifdef CONFIG_X86_32
>>  # define CRASH_KERNEL_ADDR_MAX (512 << 20)
>>  #else
>> -# define CRASH_KERNEL_ADDR_MAX (896 << 20)
>> +# define CRASH_KERNEL_ADDR_MAX (1700 << 20)
>>
>> And that seems to work.  i.e. I'm currently dumping a system where
>> crashkernel=1G and it seems to be working.
>>
>> Am I just living dangerously?
>
> So fundamentally this should work.  However there have been a lot of
> kinks and silly limitations in the x86 boot protocol.
>
> So it used to be that the bootloader protocol variable ramdisk_max was
> set to 896M for 32bit kernels.  Because the ramdisk could not be located
> in high memory.
>
> Looking today it appears that ramdisk_max has been upped to 4G.
>
> I will let you look through the /sbin/kexec source code.
>
> As for testing I would up the limit to 4G on x86_64 and see how far
> you get.
>
> The practical question does the system still work with crashkernel=32M
> when you have raised the limit much higher.
>
> So I would test with crashkernel=1G@2G and see if that works.  If that
> works I figure that in practice all of the bugs are historical and we
> can forget them.  But a sweep through the /sbin/kexec code for the magic
> number 896 might not be out of order.
>
> Eric
>
>
>
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec



-- 
Best regards,
Maxim Uvarov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
