Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TaxzT-0001w0-0N
 for kexec@lists.infradead.org; Wed, 21 Nov 2012 00:16:32 +0000
Date: Wed, 21 Nov 2012 09:16:26 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec x86_64: Make purgatory relocatable anywhere in the
 64bit address space.
Message-ID: <20121121001626.GC11590@verge.net.au>
References: <87r4np4jm1.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87r4np4jm1.fsf@xmission.com>
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
Cc: Yinghai Lu <yinghai@kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>

On Mon, Nov 19, 2012 at 08:56:22AM -0800, Eric W. Biederman wrote:
> 
> Remove kexec/arch/i386/compat_x6_64.S
> purgatory/arch/i386/linux-entry16.S and purgatory/arch/i386/entry16.S
> Those were early attempts at entry32-16.S that should have been
> deleted long ago.
> 
> Strip the purgatory code of debug symbols.  There is no need to carry
> debug symbols we will never use around in /sbin/kexec.
> 
> On x86_64 use -mcmodel=large so that the code is built without
> any 32bit assumptions.  -mcmodel=medium and -mcmodel=small
> result int code that has 32bit relocations against variables
> that can live anywhere in the address space
> 
> Modify the assembly in entry64.S and setup-x86_64.S to use %rip
> relative addressing of variables so no relocates are emitted.
> 
> Modify entry64-32.S so that it does not have any relocations that can
> not be processed when purgatory is loaded above 4G.  entry64-32.S
> jumps to a 32bit entry point and can not itself be used above 4G so
> these changes merely prevent it from being a problem in the other case.
> 
> eip is modifed to be a 64bit value of which only the low 32bits are
> exported outside of entry64-32.S
> 
> The long mode exit code is modified to run with a %cs value whose
> base address is the address of the symbol entry32.  From there
> all of the 32bit code in entry64-32.S can read variables by reading
> them through %cs.  Until the final jump to the the target address
> which is made a far jump reloading %cs and the intstruction pointer.
> 
> Modify entry32-16.S and entry32-16-debug.S to be position independent
> 32bit code.  At their start make a short call to push the current value
> of %eip on the stack and pop it off.  Allowing the calculation of the
> address of entry16 which the code has always kept in %ebx.
> 
> Update the pointer to the gdt in the gdt so that lgdt will work.
> 
> Modify the instructions in entry32-16.S and entry32-16-debug.S so
> that the 32bit code uses offsets from %ebx which points at entry16.
> 
> Tested-by: Yinghai Lu <yinghai@kernel.org>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
