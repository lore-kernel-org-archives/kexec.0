Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U3E9D-0002en-HN
 for kexec@lists.infradead.org; Wed, 06 Feb 2013 23:11:24 +0000
Message-ID: <5112E30C.50707@zytor.com>
Date: Wed, 06 Feb 2013 15:11:08 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Cleanup kdump memmap= passing and e820 usage
References: <1358866935-18458-1-git-send-email-trenn@suse.de>
 <87ehh2l2z3.fsf@xmission.com> <2271353.GLUCBHDxBG@hammer82.arch.suse.de>
 <201302061623.50126.trenn@suse.de> <87ehgtcacs.fsf@xmission.com>
In-Reply-To: <87ehgtcacs.fsf@xmission.com>
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
Cc: x86@kernel.org, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, yinghai@kernel.org, Thomas Renninger <trenn@suse.de>, vgoyal@redhat.com

On 02/06/2013 03:04 PM, Eric W. Biederman wrote:
>>
>> There is another important point, why the command line approach
>> should be preferred:
>> Backward compatibility and the ability to backport the whole stuff to
>> fix mmconf in kdump which would be nice for example for SLES11.
> 
> Backward compatibility argues for editing the e820 map because we can do
> that at any time, with no dependencies on any kernel changes.  Only
> the E820_RAM type will be treated as ram.  Any unregcognized e820 type
> will be treated as reserved.  The code has always been like that.
> 
> A new reserved value would be nice to communicate to the kernel areas
> that are really ram but it isn't allowed to touch but is unnecessary at
> this point.  Even with just marking memory regions we don't use as
> E820_RESERVED we match what is currently being done.
> 
> Since a new reserved value has not been selected let me suggest.
> 0x6b646d70 aka kdmp in asii.
> 

I (somewhat) would like to keep the reserved numbers in a small(ish)
range which argue against that specific constant.  I kind of like
0x6bxxxxxx ("k") though, it has some flair to it.

> For backwards compatibility I prefer editing the e820 map in
> /sbin/kexec.
> 
> 
> My real preference would be to define a command line option that will
> work on all architectures that implement kdump, as the craskernel option
> does.  Unfortunately it looks like that ship has sailed, and there isn't
> enough desire to fix this to come up with a generic option that will
> work on more than just x86.  But if we could get past the kernel
> versioning and figure out a arch-generic solution it might be worth it.
> 

What would that option look like?

>> kexec-tools can detect the kernel version of the kernel which is loaded
>> as kdump/crash kernel. If its version is:
>> "$MAINLINE_VERSION_THE_CHANGE_GETS_INTRODUCED"
>> or newer, things are fine.
>> But if the kernel version is older, there is no way for kexec-tools to
>> find out whether the older kernel may have the feature included.
>> That's bad!
> 
> That is totally unnecessary for the e820 map because anything
> unrecognized is treated as reserved, and for the sufficiently paranoid
> we don't need to use a new memory type.

The only issue is if kdump needs the memory it is going to dump to be
mapped; we don't map reserved memory anymore unless explicitly requested
via ioremap().  Does it?

> The existing e820 handling for unknown type is much much better.  It
> just treats them as reserved and goes about it's merry way.

It sounds like this is the way to go.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
