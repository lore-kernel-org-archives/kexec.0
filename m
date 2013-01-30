Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U0ffM-0000Gq-Oi
 for kexec@lists.infradead.org; Wed, 30 Jan 2013 21:58:01 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1358866935-18458-1-git-send-email-trenn@suse.de>
 <201301301713.43946.trenn@suse.de>
 <4dc77552-977d-4761-860e-afdec61c4317@email.android.com>
 <201301301739.52358.trenn@suse.de> <51094FD5.2070909@zytor.com>
 <87obg6sdtv.fsf@xmission.com> <510992C7.2050000@zytor.com>
Date: Wed, 30 Jan 2013 13:57:44 -0800
In-Reply-To: <510992C7.2050000@zytor.com> (H. Peter Anvin's message of "Wed,
 30 Jan 2013 13:38:15 -0800")
Message-ID: <877gmumizr.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Cleanup kdump memmap= passing and e820 usage
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, yinghai@kernel.org, Thomas Renninger <trenn@suse.de>, vgoyal@redhat.com

"H. Peter Anvin" <hpa@zytor.com> writes:

> On 01/30/2013 10:52 AM, Eric W. Biederman wrote:
>> "H. Peter Anvin" <hpa@zytor.com> writes:
>> 
>>> I have to admit to being rather confused as to the separation of various bits of
>>> kdump between the host kernel and various user-space components, but the whole
>>> use of the command line to pass the memory map seems just broken in light of
>>> everything that can go wrong.
>> 
>> It certainly seems time to look at this design decision and see if it
>> still makes sense.
>> 
>> The original idea was to pass the e820 map in the e820 variables, and to
>> slightly override that map to report which memory it was safe for the
>> kdump kernel to run in.  Leaving the kernel with the knowledge that
>> of where everything actually is, and that we just don't happen to be
>> using all of the memory.
>> 
>> Now something seems to have gone wrong with that strategy as we wound
>> up needing to play games with acpi and gart addresses.
>> 
>> I see one of two very basic options going forward.
>> - Pass a kernel command line option that just changes the kernels idea
>>   of which memory it can touch (and we can remove all of the other options).
>> - Modify the e820 map we pass to the kdump kernel and don't bother to
>>   pass anything on the command line.
>> 
>
> Yes, those seem to be the options, and we're currently discussing which one.
>
> The second seems to make more sense to me.  The kexec tools build the
> memory map anyway, and it makes sense to me at least to just build a
> memory map with the appropriate regions marked as a dumpable type.

This dumpable type doesn't make sense to me.  Are you suggesting making
regions that are memory but that we should not use a special memory
type?

I think I would prefer that to call that new type RESERVED_MEM or
RESERVED_CACHABLE.  Being more specific is fine but dumpable certainly
doesn't bring to mind what we are saying.  Especially since we already
communicate which areas were memory to the last kernel in an
architecture generic format.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
