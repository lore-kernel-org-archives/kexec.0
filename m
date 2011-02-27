Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PtVFE-00082U-J8
	for kexec@lists.infradead.org; Sun, 27 Feb 2011 01:16:21 +0000
Message-ID: <4D69A5C6.6020906@zytor.com>
Date: Sat, 26 Feb 2011 17:15:50 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: Saveoops: Making Kexec purgatory position-independent?
References: <20110226162008.GA23879@laptop> <4D6972CE.8040401@zytor.com>
	<m14o7q5m6d.fsf@fess.ebiederm.org>
In-Reply-To: <m14o7q5m6d.fsf@fess.ebiederm.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: X86-ML <x86@kernel.org>, KEXEC-ML <kexec@lists.infradead.org>, "Ahmed S. Darwish" <darwish.07@gmail.com>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Ingo Molnar <mingo@elte.hu>, Vivek Goyal <vgoyal@redhat.com>

On 02/26/2011 04:57 PM, Eric W. Biederman wrote:
>>
>> I can't see any sane reason to *not* make kexec purgatory
>> position-independent.  It is the obvious thing to do.
> 
> This isn't a case of the code not being position independent.  This is
> case of where the relocations are applied.
> 
> I can see a couple of handling this with different tradeoffs.
> 
> 1) We teach bootloaders how to load two kernels at once.  This
>    completely avoids the purgatory, as it is replaced by code in the
>    bootloader that already exists to load the primary kernel and setup
>    it's arguments.
> 
> 2) We add minimal relocation processing to purgatory, allowing us to do
>    the setup for the second kernel extremely early and allow it to be
>    compiled into the first kernel.
> 
> 3) We come up with a scheme where we don't share code and the first
>    kernel copies the firmware information to place where the second
>    kernel can get at it, and uses it's own home grown stub and not
>    purgatory.
> 
> I think this whole thing can be prototyped easily with a getting /sbin/kexec
> to load to a fixed address and then baking that section into the primary
> kernel.  I'm not convinced that directly using /sbin/kexec is the right
> way forward to handle the general case.  This is something where the
> devil is in the details.
> 

OK... I'm clearly missing something... what code is not being
position-independent and which code needs relocations applied?

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
