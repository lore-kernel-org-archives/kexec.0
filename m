Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U0atx-000808-HL
 for kexec@lists.infradead.org; Wed, 30 Jan 2013 16:52:46 +0000
Message-ID: <51094FD5.2070909@zytor.com>
Date: Wed, 30 Jan 2013 08:52:37 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Cleanup kdump memmap= passing and e820 usage
References: <1358866935-18458-1-git-send-email-trenn@suse.de>
 <201301301713.43946.trenn@suse.de>
 <4dc77552-977d-4761-860e-afdec61c4317@email.android.com>
 <201301301739.52358.trenn@suse.de>
In-Reply-To: <201301301739.52358.trenn@suse.de>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Thomas Renninger <trenn@suse.de>
Cc: x86@kernel.org, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, yinghai@kernel.org, vgoyal@redhat.com

On 01/30/2013 08:39 AM, Thomas Renninger wrote:
>
>>> This:
>>> - heavily cleans up the unnecesary reserved memory passing via memmap=
>>> - still provides a clean way of passing a valid e820 table through
>>>    boot structures (no Linux kernel made up e820 type passing)
>>> - Keeps complexity as low as possible and at one place and does not
>>>    involve kexec-tools as another error source (passing a badly
>>>    mangled e820 table or not being able to consider stuff the kernel
>>>    can when mangeling).
>
> If for some reason the e820 table in kdump case needs to be
> touched again, I am pretty sure you do not want to look up
> kexec-tools code.
> Also you won't be able to fix/workaround things in kexec-tools
> the way you can in the kernel.
>

Say what?  The kernel is an open source tool, so is kexec, and a *lot* 
of people have dependencies on specific kernel versions which does not

> I also do not think it's a good idea to pass an unspecified,
> Linux kernel made up e820 type through the public boot interface.

It's our interface.  We specify it.  On the other hand, we may want to 
make these negative numbers rather than starting at 128 to avoid future 
collisions with real memory types (not that they are growing very fast.)

> So looking from the other side, passing a modified e820 table
> only has disadvantages. The only advantage I can see that
> memmap=..,X@Y,W@Z needs not to be passed. But this is rather
> short and static now and not huge depending on the e820 reserved
> entries from the BIOS (and still obvious where it comes from and why
> it gets passed. Passing things hidden in a modified e820 boot structure
> is not a good idea).

The command line is fundamentally a human-oriented interface and its 
semantics change over time (considering the built-in command line stuff, 
for example.)  It is thus fragile.

The e820 map is fundamentally what you care about, and it has to be 
passed correctly anyway -- or your changes are utterly broken.  The 
modifications that have to be performed (from RAM to KDUMP) is trivial.

I have to admit to being rather confused as to the separation of various 
bits of kdump between the host kernel and various user-space components, 
but the whole use of the command line to pass the memory map seems just 
broken in light of everything that can go wrong.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
