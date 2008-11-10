Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KzYbo-0003yy-N6
	for kexec@lists.infradead.org; Mon, 10 Nov 2008 15:23:21 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mAAFN3hT024711
	for <kexec@lists.infradead.org>; Mon, 10 Nov 2008 10:23:03 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mAAFN75K133954
	for <kexec@lists.infradead.org>; Mon, 10 Nov 2008 10:23:07 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mAAFN5vG004909
	for <kexec@lists.infradead.org>; Mon, 10 Nov 2008 10:23:06 -0500
Message-ID: <491851D3.3050904@in.ibm.com>
Date: Mon, 10 Nov 2008 20:52:59 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] powerpc/ppc64/kdump: better flag for running
	relocatable
References: <kexec-kern-2@bga.com> <4900952A.3090605@in.ibm.com>
	<b6c6e115495e149f24d2de5cb82a92ab@bga.com>
In-Reply-To: <b6c6e115495e149f24d2de5cb82a92ab@bga.com>
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
To: Milton Miller <miltonm@bga.com>
Cc: Ben Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org, Simon Horman <horms@verge.net.au>, Paul Mackerras <paulus@samba.org>

Milton Miller wrote:
> On Oct 23, 2008, at 10:15 AM, Mohan Kumar M wrote:
>> Hi Milton,
>> My suggestions:
>> Milton Miller wrote:
>>
>> i.e.,
>> [code snip 1]
>> 	lwz	r7,__run_at_load-_stext(r26)
>> 	cmplwi	cr0,r7,1	/* kdump kernel ? - stay where we are */
>>  	bne	1f
>>  	add	r25,r25,r26
>>
>> 	lwz	r7,__run_at_load-_stext(r26)
>> 	cmplwi	cr0,r7,1
>>  	bne	3f
>>
>> kexec-tools
>> [code snip 2]
>> 	LOADADDR(6,run_at_load)
>> 	ld	18,0(6)
>> 	cmpd	18,1
>> 	bne	skip
>> 	li	7,1
>> 	stw	7,92(4)		# mark __run_at_load flag at kernel
>> skip:
>> 	lwz	7,0(4)		# get the first instruction that we stole
>> 	stw	7,0(0)		# and put it in the slave loop at 0
>>  				# skip cache flush, do we care?
>>
>> [code snip 3]
>> 	if (info->kexec_flags & KEXEC_ON_CRASH) {
>> 		....
>> 		elf_rel_set_symbol(&info->rhdr, "run_at_load",
>>                                 &my_run_at_load, 							 
>> sizeof(my_run_at_load));
>> 	}
> 
> 
> This elf_rel_set_symbol sets the copy in purgatory,
> after we have copied the code from the kernel.  It
> is this copy that gets copied to address 0.
> 

Yes, elf_ret_symbol sets the copy in purgatory. But the following code 
in purgatory (to be introduced)

  	LOADADDR(6,run_at_load)
  	ld	18,0(6)
  	cmpd	18,1
  	bne	skip
  	li	7,1
  	stw	7,92(4)		# mark __run_at_load flag at kernel

will set the __run_at_load in the kernel image (ie where ever kernel is 
loaded + 0x5c(92). Or am I missing some thing?

> However this information is not in the code that
> is at the start of the kernel.  We don't have any
> symbols for the kernel itself, it might be stripped.
> So we can't use the elf_set_symbol api.  (The kernel
> may not be relocatable either).

Regards,
Mohan.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
