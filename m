Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MbVQU-0003gq-73
	for kexec@lists.infradead.org; Thu, 13 Aug 2009 08:12:50 +0000
Message-ID: <4A83CAF5.6080004@suse.de>
Date: Thu, 13 Aug 2009 10:12:37 +0200
From: Hannes Reinecke <hare@suse.de>
MIME-Version: 1.0
Subject: Re: [PATCH] Increase kernel text size for x86_64
References: <4A827223.8090907@suse.de> <20090813004013.GB23310@verge.net.au>
In-Reply-To: <20090813004013.GB23310@verge.net.au>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec mailing list <kexec@lists.infradead.org>

Simon Horman wrote:
> On Wed, Aug 12, 2009 at 09:41:23AM +0200, Hannes Reinecke wrote:
>> Hi all,
>>
>> I cannot load a x86_64 kernel with kexec on 2.6.31; the error message is:
>>
>> Can't find kernel text map area from kcore
>> Cannot load /boot/vmlinuz
>>
>> Digging through the source I found a mismatch between the assumed
>> kernel text size; kexec has:
>>
>> #define KERNEL_TEXT_SIZE  (40UL*1024*1024)
>>
>> but on the kernel side we have:
>>
>> include/asm/page_64_types.h:
>> #define KERNEL_IMAGE_SIZE   (512 * 1024 * 1024)
>>
>> And, indeed, changing the definition in kexec-tools to the kernel one
>> fixed the problem.
>>
>> Not sure if this has been reported before, if so please ignore
>> the noise.
> =

> Hi,
> =

> I'm wondering what effect this would have when using
> kexec-tools with older kernels, which presumably have
> a smaller value for KERNEL_IMAGE_SIZE.
> =

>> diff --git a/kexec/arch/x86_64/crashdump-x86_64.h b/kexec/arch/x86_64/cr=
ashdump-x86_64.h
>> index 9f4dee9..0e83527 100644
>> --- a/kexec/arch/x86_64/crashdump-x86_64.h
>> +++ b/kexec/arch/x86_64/crashdump-x86_64.h
>> @@ -11,7 +11,7 @@ int load_crashdump_segments(struct kexec_info *info, c=
har *mod_cmdline,
>>  #define MAXMEM           0x3fffffffffffUL
>>  =

>>  /* Kernel text size */
>> -#define KERNEL_TEXT_SIZE  (40UL*1024*1024)
>> +#define KERNEL_TEXT_SIZE  (512UL*1024*1024)
>>  =

>>  #define CRASH_MAX_MEMMAP_NR	(KEXEC_MAX_SEGMENTS + 1)
>>  #define CRASH_MAX_MEMORY_RANGES	(MAX_MEMORY_RANGES + 2)
> =

Well, the actual point of failure is in kexec/arch/x86_64/crashdump-x86_64.=
c:125

			/* Look for kernel text mapping header. */
			if ((saddr >=3D __START_KERNEL_map) &&
			    (eaddr <=3D __START_KERNEL_map + KERNEL_TEXT_SIZE)) {
				saddr =3D (saddr) & (~(KERN_VADDR_ALIGN - 1));
				info->kern_vaddr_start =3D saddr;
				size =3D eaddr - saddr;

which basically should look for a ELF header into which the kernel fits. As=
 we're
effectively just moving the upper limit I fail to see any harm to older ker=
nels.

Hmm. Haven't checked for other occurrences of KERNEL_TEXT_SIZE, though.

Would be nice we could be getting these values off somewhere; rely on
some kernel defines is going to break now and then.

Cheers,

Hannes
-- =

Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Markus Rex, HRB 16746 (AG N=FCrnberg)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
