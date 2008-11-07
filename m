Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mercury.realtime.net ([205.238.132.86])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KyRo0-0005h4-9r
	for kexec@lists.infradead.org; Fri, 07 Nov 2008 13:55:20 +0000
In-Reply-To: <4900952A.3090605@in.ibm.com>
References: <kexec-kern-2@bga.com> <4900952A.3090605@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v624)
Message-Id: <b6c6e115495e149f24d2de5cb82a92ab@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 3/3] powerpc/ppc64/kdump: better flag for running
	relocatable
Date: Fri, 7 Nov 2008 07:59:26 -0600
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mohan Kumar M <mohan@in.ibm.com>
Cc: Ben Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org, Simon Horman <horms@verge.net.au>, Paul Mackerras <paulus@samba.org>

On Oct 23, 2008, at 10:15 AM, Mohan Kumar M wrote:
> Hi Milton,
> My suggestions:
> Milton Miller wrote:
>> The __kdump_flag ABI is overly constraining for future development.
...
>> Now that we have eliminated the use of __kdump_flag in favor of
>> the standard is_kdump_kernel(), this flag only controls run without
>> relocating the kernel to PHYSICAL_START (0), so rename it 
>> __run_at_load.
>>
> We could try both of our approaches. Instead of passing the 
> information that next kernel should be relocatable from kexec_sequence 
> to purgatory code, we will do it from kexec-tools path (following your 
> approach). But instead of setting the __run_at_load value in the 
> purgatory code (ie at physical address 0x5c), we will set the variable 
> __run_at_load at kernel  image itself.
>
> i.e.,
> [code snip 1]
> 	lwz	r7,__run_at_load-_stext(r26)
> 	cmplwi	cr0,r7,1	/* kdump kernel ? - stay where we are */
>  	bne	1f
>  	add	r25,r25,r26
>
> 	lwz	r7,__run_at_load-_stext(r26)
> 	cmplwi	cr0,r7,1
>  	bne	3f
>
> kexec-tools
> [code snip 2]
> 	LOADADDR(6,run_at_load)
> 	ld	18,0(6)
> 	cmpd	18,1
> 	bne	skip
> 	li	7,1
> 	stw	7,92(4)		# mark __run_at_load flag at kernel
> skip:
> 	lwz	7,0(4)		# get the first instruction that we stole
> 	stw	7,0(0)		# and put it in the slave loop at 0
>  				# skip cache flush, do we care?
>
> [code snip 3]
> 	if (info->kexec_flags & KEXEC_ON_CRASH) {
> 		....
> 		elf_rel_set_symbol(&info->rhdr, "run_at_load",
>                                 &my_run_at_load, 							 
> sizeof(my_run_at_load));
> 	}


This elf_rel_set_symbol sets the copy in purgatory,
after we have copied the code from the kernel.  It
is this copy that gets copied to address 0.

However this information is not in the code that
is at the start of the kernel.  We don't have any
symbols for the kernel itself, it might be stripped.
So we can't use the elf_set_symbol api.  (The kernel
may not be relocatable either).

> Using this approach we are not breaking the kexec_sequence
> ABI and we directly modifying the flag in kernel image.
>
> Regards,
> Mohan.

I'll prepare a patch, but it might be a few days
while I catch up from my 2 week vacation.

milton


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
