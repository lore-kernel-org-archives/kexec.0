Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1O54YN-0004tG-Ai
	for kexec@lists.infradead.org; Thu, 22 Apr 2010 22:07:24 +0000
Subject: Re: [PATCH 0/5] Add second memory region for crash kernel
References: <1271953392-6324-1-git-send-email-v.mayatskih@gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 22 Apr 2010 15:07:11 -0700
In-Reply-To: <1271953392-6324-1-git-send-email-v.mayatskih@gmail.com> (Vitaly
	Mayatskikh's message of "Thu\, 22 Apr 2010 18\:23\:07 +0200")
Message-ID: <m1aasvkupc.fsf@fess.ebiederm.org>
MIME-Version: 1.0
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
To: Vitaly Mayatskikh <v.mayatskih@gmail.com>
Cc: Cong Wang <amwang@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Haren Myneni <hbabu@us.ibm.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>

Vitaly Mayatskikh <v.mayatskih@gmail.com> writes:

> Patch applies to 2.6.34-rc5
>
> On x86 platform, even if hardware is 64-bit capable, kernel starts
> execution in 32-bit mode. When system is kdump-enabled, crashed kernel
> switches to 32 bit mode and jumps into new kernel. This automatically
> limits location of dump-capture kernel image and it's initrd by first
> 4Gb of memory. Switching to 32 bit mode is performed by purgatory
> code, which has relocations of type R_X86_64_32S (32-bit signed), and
> this cuts "good" address space for crash kernel down to 2 Gb. I/O
> regions may cut down this space further.
>
> When system has a lot of memory (hundreds of gigabytes), dump-capture
> kernel also needs relatively a lot of memory to account old kernel's
> pages. It may be impossible to reserve enough memory below 2 or even 4
> Gb. Simplest solution is it break dump-capture kernel's reserved
> memory region into two pieces: first (small) region for kernel and
> initrd images may be easily placed in "good" address space in the
> beginning of physical memory, and second region may be located
> anywhere.
>
> This serie of patches realizes this approach. It requires also changes
> in kexec utility to make this feature work, but is
> backward-compatible: old versions of kexec will work with new
> kernel. I will post patch to kexec-tools upstream separately.

Have you tried loading a 64bit vmlinux directly into a higher address
range?  There may be a bit or two missing but you should be able to
load a linux kernel above 4GB.  I tested the basics of that mechanism
when I made the 64bit relocatable kernel.

I don't buy the argument that there is a direct connection between
the amount of memory you have and how much memory it takes to dump it.
Even an indirect connections seems suspicious.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
