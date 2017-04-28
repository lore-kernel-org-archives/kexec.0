Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d49Zv-0000sz-VA
 for kexec@lists.infradead.org; Fri, 28 Apr 2017 17:21:12 +0000
Received: by mail-pf0-f180.google.com with SMTP id q66so7337351pfi.3
 for <kexec@lists.infradead.org>; Fri, 28 Apr 2017 10:20:51 -0700 (PDT)
Subject: Re: Kexec on ARM - memory detection
References: <CAKDfjgcvs=OQrBSXB=u9uYgo6y0vOE62+XmhObqON0z9TR3DoQ@mail.gmail.com>
 <125ffde4-2103-48b5-2c46-886436619124@redhat.com>
 <CAKDfjgeo_DNqi6=rDA6nPtjSsSOWGJXA7piQ_LL8yxqUOyg9Jg@mail.gmail.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <b7361ec4-6f26-46f3-64db-b4ef511b283f@redhat.com>
Date: Fri, 28 Apr 2017 22:50:43 +0530
MIME-Version: 1.0
In-Reply-To: <CAKDfjgeo_DNqi6=rDA6nPtjSsSOWGJXA7piQ_LL8yxqUOyg9Jg@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kristian Kielhofner <kris@kriskinc.com>
Cc: kexec@lists.infradead.org



On Wednesday 26 April 2017 10:45 PM, Kristian Kielhofner wrote:
> On Fri, Apr 21, 2017 at 6:27 AM, Pratyush Anand <panand@redhat.com> wrote:
>> Hi Kristian,
>>
>> Sorry, I missed this mail.
>> Are you still on it, or it is solved?
>
>   No problem, I'm still experiencing the issue but I haven't
> investigated it further.
>
>>
>>
>> How does kexec-tools see above memory ranges?
>> As per your /proc/iomem, it should have been
>> 42000000-5fffffff (0)
>>
>> Can you put some extra debug print in your code and check why do you have
>> above behavior?
>>
>
>   Can you point towards some examples or documentation for what you're
> looking for?

kexec-tools:kexec/arch/arm/kexec-arm.c:get_memory_ranges() is telling you that 
you have
MEMORY RANGES
00012028b6d27010-bea6aee700000004 (0)

However, you /proc/iomem is telling you:

42000000-5fffffff : System RAM

get_memory_ranges() is reading /proc/iomem and finding out the available ram 
locations. So, can you debug this kexec-tools function and see why you do not 
get the range which is coming from /proc/iomem

~Pratyush



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
