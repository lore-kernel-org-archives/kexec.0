Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rcdn-iport-2.cisco.com ([173.37.86.73])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dIevL-0001HD-AU
 for kexec@lists.infradead.org; Wed, 07 Jun 2017 17:39:17 +0000
Subject: Re: crash_kexec in oops_end() and panic()
References: <72f60925-c2a6-8811-a75a-5f443486e781@cisco.com>
 <87bmpzoie4.fsf@xmission.com>
 <f8c4c044-6b2d-d9ec-aff9-009e2a545440@cisco.com>
 <87vao7lo43.fsf@xmission.com>
From: Daniel Walker <danielwa@cisco.com>
Message-ID: <51265567-0f3b-4899-5976-8677736d36a8@cisco.com>
Date: Wed, 7 Jun 2017 10:38:50 -0700
MIME-Version: 1.0
In-Reply-To: <87vao7lo43.fsf@xmission.com>
Content-Language: en-US
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, xe-linux-external@cisco.com

On 06/07/2017 10:11 AM, Eric W. Biederman wrote:
> Daniel Walker <danielwa@cisco.com> writes:
>
>> On 06/07/2017 09:46 AM, Eric W. Biederman wrote:
>>> Daniel Walker <danielwa@cisco.com> writes:
>>>
>>>> Hi,
>>>>
>>>> These two paths seem to be duplicating each other. We have an issue
>>>> where we're using mtdoops to collect kernel logs on oops and panic, we
>>>> also have a crash kernel (which also collects these logs). mtdoops
>>>> saves logs differently for oops and panic, since oops isn't always
>>>> fatal it schedules a write to the flash. Since panic() is always fatal
>>>> is writes the logs immediately. In oops_end() the crash kernel runs
>>>> immediately while still signaling an OOPS condition to mtdoops. Since
>>>> mtdoops schedules a write to flash later, there is no later since the
>>>> crash kernel runs immediately, we end up without getting the logs
>>>>
>>>> I'm wondering what the significance is to have these two paths ?
>>>> oops_end() could just call into panic() or a modified
>>>> panic_with_regs() then we would collapse multiple paths. There is what
>>>> I would call a hack in kexec_should_crash() which checks if there are
>>>> crash_kexec_post_notifiers and it runs panic() if they exist. This
>>>> wouldn't be needed if we always called panic() . I also wonder if
>>>> there are other things in panic() which we should be running , but
>>>> don't get run because of these two paths.
>>> crash_kexec_post_notifiers is a horrible hack it is broken by design and
>>> no one should use it.
>>>
>>> Looking at the history and it still seems valid is the point of
>>> kexec_should_crash is so that crash_kexec could be called with the
>>> registers at the time of the crash.
>> This is why I mention panic_with_regs() , it's not that hard to just
>> send them into panic().
> Given your reasoning adding more useless code that is likely to
> destabalize the code path I am not particularly interested.
>
>>> The code that is run in kexec on panic path the less well it works.
>>> This has been a known fact for years.
>>>
>>> Please figure out how to depend on less code running in a broken
>>> kernel.  Trying to figure out how to run more code is not the solution
>>> to making the kernel reliable at the time of a crash.
>>>
>>> Eric
>>
>> While this may be true, your cutting short an already existing panic()
>> path which has been around and is well used. I would think if it's
>> good enough for everyone else it should be good enough for the crash
>> kernel path.
> You are talking about decisions over a decade old at this point.  So
> this isn't some new thing you are complaing about.  In fact mtdoops is
> much newer.    So if it isn't working that is the code with the bug.
>
> Furthermore we have lots of emperical evidence that doing lots of things
> in the kernel at crash time doesn't work in practice.
>
> Without kexec-on-panic there just isn't anything else the code can do,
> so it makes sense to do a lot of flaky things.
>
> I am not at all sympathetic with the notion of reorganizing the code so
> that more code can run in the kexec on panic path and reduce it's
> changes of working.  We have been there.  We have the scars.  That is
> the reason why kexec is used at all.
>
> There used to be a core dumper in the kernel it only worked in the lab
> never in the field.
>
> What I hear you asking for is to put a core dumper (or something as
> liable to failure) back in the kernel without acknowledging any of the
> reasons why that doesn't work in practice.  I am hearing you arguing for
> making the code buggier.  I am hearing that and I am saying not interested.

panic() already runs crash_kexec(). I'm not familiar with this "dumper" 
, can you explain the connection? I'm just suggesting we combine two 
similar code paths. The panic() call does minimal additional code prior 
to calling crash_kexec , but I'm not sure it's significant enough to 
cause reliability to change. Is there something specific in panic() 
which you can point to which you know would cause a problem ?

It seems your suggesting crash_kexec() inside panic() never , or rarely, 
works in the field. I think it's worked fine a Cisco more than once.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
