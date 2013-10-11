Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VUl0K-00018X-00
 for kexec@lists.infradead.org; Fri, 11 Oct 2013 22:16:16 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20131011092837.GZ3626@debian70-amd64.local.net-space.pl>
 <877gdkce6s.fsf@tw-ebiederman.twitter.com>
 <20131011110455.GA3626@debian70-amd64.local.net-space.pl>
Date: Fri, 11 Oct 2013 15:15:38 -0700
In-Reply-To: <20131011110455.GA3626@debian70-amd64.local.net-space.pl> (Daniel
 Kiper's message of "Fri, 11 Oct 2013 13:04:55 +0200")
Message-ID: <877gdjbgj9.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: kexec: Clearing registers just before jumping into purgatory
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: keir@xen.org, keescook@chromium.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, hbabu@us.ibm.com, david.vrabel@citrix.com, jbeulich@suse.com, hpa@linux.intel.com, vgoyal@redhat.com

Daniel Kiper <daniel.kiper@oracle.com> writes:

> On Fri, Oct 11, 2013 at 03:08:43AM -0700, ebiederm@xmission.com wrote:
>> Daniel Kiper <daniel.kiper@oracle.com> writes:
>>
>> > Hi,
>> >
>> > Could you explain why do you clear all registers just before jumping
>> > into purgatory (please look into arch/x86/kernel/relocate_kernel_64.S
>> > for more details)? There is no any single word about that. I do not
>> > count comment which states what is going on. purgatory on entry does
>> > not assume any value in registers. Are you going to use that feature
>> > for something in the future (e.g. to differentiate between callers
>> > and/or Linux versions if it be needed)?
>>
>> It has been a long time now, but as I recall the reason was to just
>> have things well defined and to make certain that we were not
>> accidentially exporting anything except the stack pointer for
>> applications to depend upon.
>>
>> 0/NULL is a good choice because if you are expecting pointer for some
>> strange reason interesting things happen.
>
> This covers more or less with my expectations.
>
>> purgatory is definitely not the only target and the C version of
>> purgatory was actually written well after kexec came into existence.
>>
>> Is there any particular reason why you are asking?
>
> Yes, we (Xen guys) are discussing is it worth to do it or not in our
> kexec implementation. I think that yes because we used Linux Kernel
> kexec implementation as a base for our work and we use kexec-tools too.
> So we should be aligined to what currently is in the wild. David do not
> agree with me. You could find more here:
>
> http://lists.xen.org/archives/html/xen-devel/2013-10/msg00710.html
> http://lists.xen.org/archives/html/xen-devel/2013-10/msg00296.html
>
> What is your opinion in that case?

I can see documenting the registers other than the stack pointer
as undefined.  (A stack pointer is needed to implement PIC code).

For the implementation I recommend setting these registers to known
values.  The issue is that your implementation will not change much and
if you don't set the registers to known values someone may develop a
dependency on what you happen to have those registers set to.

It is easier to force a fixed value into a register that isn't hard to
maintain into your registers than to discover when you make a change
that there is some odd client that depends on some value that just
happened to be in your register, and that your necessary change is now
made 10x harder by a client you can't afford to break that depends on a
bug in the previous implementation.

So yes I strongly recommend setting the registers to a 0 in this case.

>> Something different is done, and all of the registers should be
>> preserved from the when the return to Linux.
>
> I expected that but purgatory does nothing with them.
> However, maybe I missed something.

Yes.  I think I am mostly in the document that you can't depend on them,
but keep them fixed to prevent problematic dependencies creeping in
because something just works...

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
