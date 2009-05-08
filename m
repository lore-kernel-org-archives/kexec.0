Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1M2TSK-0001rz-29
	for kexec@lists.infradead.org; Fri, 08 May 2009 17:02:11 +0000
Message-ID: <4A0464AC.9060308@zytor.com>
Date: Fri, 08 May 2009 09:58:20 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 02/14] x86,
	boot: honor CONFIG_PHYSICAL_START when relocatable
References: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
	<1241735222-6640-3-git-send-email-hpa@linux.intel.com>
	<20090508073436.GB12808@uranus.ravnborg.org>
In-Reply-To: <20090508073436.GB12808@uranus.ravnborg.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
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
To: Sam Ravnborg <sam@ravnborg.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, ebiederm@xmission.com, ying.huang@intel.com, mingo@elte.hu, "H. Peter Anvin" <hpa@linux.intel.com>, tglx@linutronix.de, vgoyal@redhat.com

Sam Ravnborg wrote:
> 
> On the coding style side of thing...
>> +     movl %ebp, %ebx
>> +     cmpl %ebx, %eax
>> +     jbe 1f
>> +     movl %eax, %ebx
> 
> This looks messy with different idention of the operand.
> 
> Compare it to this:
>> +	movl	%ebp, %ebx
>> +	cmpl	%ebx, %eax
>> +	jbe	1f
>> +	movl	%eax, %ebx
> 
> 
> I like the latter more with vertical alignment of the operand.
> I see that you add spaces around operators (,) - good.

head_32.S was already written in the style with space (rather than tab)
between opcode and operands.  There was a total of three instructions
that didn't follow the pattern.  Re-styling the whole file is possible,
of course, but should be a separate patch entirely.

>>  	pushl %esi
>> -	leal _ebss(%ebp), %esi
>> -	leal _ebss(%ebx), %edi
>> -	movl $(_ebss - startup_32), %ecx
>> +	leal (_bss-4)(%ebp), %esi
>> +	leal (_bss-4)(%ebx), %edi
>> +	movl $(_bss - startup_32), %ecx
>> +	shrl $2, %ecx
> 
> I do not see why you mess around with _bss here?
> Do you use .bss for decompression?

This chunk of code is about moving the initialized segments into place.
 Moving the contents of the bss is a bug (and it clobbers the stack, the
setup of which I moved earlier in the code.)

However, using _edata would give an unaligned symbol, so use _bss
instead as being an aligned symbol at the beginning of the _bss; we thus
move the range from startup_32 to _bss.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
