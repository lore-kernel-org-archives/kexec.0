Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1M2TUu-0006NA-9e
	for kexec@lists.infradead.org; Fri, 08 May 2009 17:04:39 +0000
Message-ID: <4A046550.6050007@zytor.com>
Date: Fri, 08 May 2009 10:01:04 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 03/14] x86, config: change defaults PHYSICAL_START and
	PHYSICAL_ALIGN
References: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
	<1241735222-6640-4-git-send-email-hpa@linux.intel.com>
	<20090508073606.GC12808@uranus.ravnborg.org>
In-Reply-To: <20090508073606.GC12808@uranus.ravnborg.org>
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
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 039c3f0..13b3a5a 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -1455,17 +1455,20 @@ config KEXEC_JUMP
>>  
>>  config PHYSICAL_START
>>  	hex "Physical address where the kernel is loaded" if (EMBEDDED || CRASH_DUMP)
>> -	default "0x1000000" if X86_NUMAQ
>> -	default "0x200000" if X86_64
>> -	default "0x100000"
>> +	default "0x400000" if EMBEDDED
>> +	default "0x1000000"
>>  	---help---
>>  	  This gives the physical address where the kernel is loaded.
>>  
>>  	  If kernel is a not relocatable (CONFIG_RELOCATABLE=n) then
>>  	  bzImage will decompress itself to above physical address and
>> -	  run from there. Otherwise, bzImage will run from the address where
>> -	  it has been loaded by the boot loader and will ignore above physical
>> -	  address.
>> +	  run from there. Otherwise, bzImage will run from the either
>> +	  the above physical address or where it has been loaded by
>> +	  the boot loader, whichever is higher.
>> +
>> +	  For embedded machines with very small memory (less than
>> +	  about 24 MB) this may need to be adjusted downward from the
>> +	  default value of 0x1000000 (16 MB).
> 
> But in the above you say that default is "0x400000" if EMBEDDED
> That is in contradiction with the help - no?
> 

0x1000000 really should be the default value.  The "0x400000" if
EMBEDDED I put in to make the risk of throwing something surprising on
embedded people somewhat smaller; I'm not sure if it should go away
entirely.  Even if it doesn't, I do think referring to 16 MB as the
"default value" is right.

BTW, it would be nice to have Kconfig deal with:

a) numbers that must be powers of 2;
b) suffixes like "16M" instead of "0x1000000".  ;)

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
