Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TZwna-0007xq-Nx
 for kexec@lists.infradead.org; Sun, 18 Nov 2012 04:48:04 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
 <1353107067-14564-4-git-send-email-yinghai@kernel.org>
 <87haoo21mw.fsf@xmission.com>
 <CAE9FiQU=tW51h_NL+_AGQMDhNRM1dBCTW1FJVe6vpQYVQEzY=Q@mail.gmail.com>
 <87fw48zldz.fsf@xmission.com>
 <CAE9FiQVX8xnAGGkPtR0BA1iYbQi5fXY2+P3pW=d-tX8fpWibnw@mail.gmail.com>
 <CAE9FiQXNDEPw6WhfgYspqZsy+VVrPoA7M4kKo+5N95=22WBpkQ@mail.gmail.com>
 <50A86563.30303@zytor.com>
Date: Sat, 17 Nov 2012 20:47:38 -0800
In-Reply-To: <50A86563.30303@zytor.com> (H. Peter Anvin's message of "Sat, 17
 Nov 2012 20:34:43 -0800")
Message-ID: <876253sej9.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/8] add mem64_min/max control
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
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

"H. Peter Anvin" <hpa@zytor.com> writes:

> On 11/17/2012 04:44 PM, Yinghai Lu wrote:
>> On Sat, Nov 17, 2012 at 12:04 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> On Sat, Nov 17, 2012 at 12:25 AM, Eric W. Biederman
>>> <ebiederm@xmission.com> wrote:
>>>
>>> then for setup data (boot param) and command line, we have to set extra ident
>>> mapping for them in kernel arch/x86/kernel/head_64.S
>>>
>>
>> find the solution for this one:
>> We don't need to set ident map for boot_param and command line in head_64.S
>>
>> as we already get arch/x86/kernel/head64.c, and could use
>> early_ioremap to access
>> and copy them out.
>>
>
> I don't think that is feasible; we need access to this structure
> extremely early.  I think if you're using the 64-bit entry point it
> has to be an entry condition that those structures are mapped.  It
> simply becomes a precondition for using the 64-bit entry point.

64bit purgatory coming from kexec should be running with a page table
that identity maps everything loaded by kexec and in practice all of
memory.

We should still be using that page table when we enter the new kernel.

However then the 64bit kernel switches to it's own page tables.

So after that point we potentially need early_ioremap, because the
kernel's page tables may not have covered the boot_params.  Certainly we
need to do something to ensure the kernels page table covers boot_params.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
