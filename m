Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PtRqe-0007TQ-9I
	for kexec@lists.infradead.org; Sat, 26 Feb 2011 21:38:45 +0000
Message-ID: <4D6972CE.8040401@zytor.com>
Date: Sat, 26 Feb 2011 13:38:22 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: Saveoops: Making Kexec purgatory position-independent?
References: <20110226162008.GA23879@laptop>
In-Reply-To: <20110226162008.GA23879@laptop>
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
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: X86-ML <x86@kernel.org>, KEXEC-ML <kexec@lists.infradead.org>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Vivek Goyal <vgoyal@redhat.com>

On 02/26/2011 08:20 AM, Ahmed S. Darwish wrote:
> Hi,
> 
> I'm continuing work on 'Saveoops', saving both early and normal Linux
> oops log to disk upon panic [*], using Kexec and bootloaders this time.
> 
> Purgatory, the transitional mini-kernel used by kexec, is a relocatable
> ELF file. Userspace kexec-tools finds the final load address of such
> code (by parsing /proc/iomem, etc) and then applies the relocations
> itself before passing the now-ready executable image to kernel.
> 
> Since capturing early oopses is the major goal, doing such relocation
> in userspace won't fit my purposes. Two options remain:
>    - relocate purgatory entries in the kernel early boot path
>    - or compile purgatory as position-independent, thus simplifying
>      the kernel load logic
> 
> The former will add extra logic in a sensitive path (early boot), while
> the latter will require changes inside the purgatory code itself,
> especially i386 assembly files.
> 
> Any preferable option from our kexec and x86 maintainers?
> 
> thanks!
> 
> [*] http://news.gmane.org/find-root.php?message_id=<20110125134748.GA10051@laptop>
>     http://news.gmane.org/find-root.php?message_id=<20110126124954.GC24527@laptop>
> 

I can't see any sane reason to *not* make kexec purgatory
position-independent.  It is the obvious thing to do.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
