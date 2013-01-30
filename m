Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U0gLr-0004O0-Tt
 for kexec@lists.infradead.org; Wed, 30 Jan 2013 22:41:57 +0000
Message-ID: <5109A1A7.1040609@zytor.com>
Date: Wed, 30 Jan 2013 14:41:43 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Cleanup kdump memmap= passing and e820 usage
References: <1358866935-18458-1-git-send-email-trenn@suse.de>
 <201301301713.43946.trenn@suse.de>
 <4dc77552-977d-4761-860e-afdec61c4317@email.android.com>
 <201301301739.52358.trenn@suse.de> <51094FD5.2070909@zytor.com>
 <87obg6sdtv.fsf@xmission.com> <510992C7.2050000@zytor.com>
 <877gmumizr.fsf@xmission.com> <51099A3E.5090705@zytor.com>
 <87ehh2l2z3.fsf@xmission.com>
In-Reply-To: <87ehh2l2z3.fsf@xmission.com>
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

On 01/30/2013 02:29 PM, Eric W. Biederman wrote:
>>
>>> I think I would prefer that to call that new type RESERVED_MEM or
>>> RESERVED_CACHABLE.  Being more specific is fine but dumpable certainly
>>> doesn't bring to mind what we are saying.  Especially since we already
>>> communicate which areas were memory to the last kernel in an
>>> architecture generic format.
>>
>> I was thinking that marking them differently might help debugging, at
>> least, but yes, we can have a RESERVED_MEM type.
>>
>> However, Thomas does have a point that the current use of fairly small
>> positive values for Linux-defined types is a bad idea.  We should use
>> negative types, or at least something north of 0x40000000 or so.
> 
> Yes.  It doesn't much matter in the kernel but when it because part of
> the ABI it is a real issue.
> 
> Since old kernels treat any value they don't understand as reserved
> passing a modified e820 map seems reasonable to me once we have reserved
> a special linux value for it.
> 

Just to prevent the possible funnies (including collisions with -errno)
that might be caused by negative numbers, I suggest we assign
Linux-specific values starting at some huge but still positive value
like 2000000000 -- that way we avoid any possible uses of negative errno
values internally in the kernel.

The bigger question is if we need a separate value from the current
E820_RESERVED_KERN.  Since it is always easier to have multiple values
with the same semantics than it is to have too few, I would still prefer
we added a new E820_RESERVED_KDUMP, which would then be 2000000001.

What do you think?

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
