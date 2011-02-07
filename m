Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx2.parallels.com ([64.131.90.16])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PmGn9-0004hr-4q
	for kexec@lists.infradead.org; Mon, 07 Feb 2011 02:25:27 +0000
Message-ID: <4D4F5810.3070300@parallels.com>
Date: Sun, 6 Feb 2011 20:25:20 -0600
From: Rob Landley <rlandley@parallels.com>
MIME-Version: 1.0
Subject: Re: [PATCH -next] Documentation: Improve crashkernel= description
References: <20110206154108.GA16542@laptop>
	<20110206215733.GB26233@verge.net.au>
In-Reply-To: <20110206215733.GB26233@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: linux-doc@vger.kernel.org, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, "Ahmed S. Darwish" <darwish.07@gmail.com>, Haren Myneni <hbabu@us.ibm.com>, Randy Dunlap <rdunlap@xenotime.net>, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On 02/06/2011 03:57 PM, Simon Horman wrote:
> On Sun, Feb 06, 2011 at 05:41:08PM +0200, Ahmed S. Darwish wrote:
>> (Also applicable over 2.6.38-rc3)
>>
>> Had to explore two C code files to make sense of the 'crashkernel='
>> kernel parameter values.  Improve the situation.
>>
>> Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
>> ---
>>
>> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
>> index 89835a4..8f26b42 100644
>> --- a/Documentation/kernel-parameters.txt
>> +++ b/Documentation/kernel-parameters.txt
>> @@ -545,9 +545,12 @@ and is between 256 and 4096 characters. It is defined in the file
>>  			Format:
>>  			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
>>  
>> -	crashkernel=nn[KMG]@ss[KMG]
>> -			[KNL] Reserve a chunk of physical memory to
>> -			hold a kernel to switch to with kexec on panic.
>> +	crashkernel=size[KMG][@offset[KMG]]
>> +			[KNL] Using kexec, Linux can switch to a 'crash kernel'
>> +			upon panic. This parameter reserves the physical
>> +			memory region [offset, offset + size] for that kernel
>> +			image. If the '@offset' part was ignored, Linux finds
>> +			a suitable crash image start address automatically.
> 
> I think this would be further improved as:
> 
> 			... If '@offset' is omitted then a suitable
> 			offset is selected automatically.

Suitable offset as in parses a known image type (ELF, bzImage, etc) to
find the start address?  Or just assumes the entry point and load
address are the same?

Is this the size for just the kernel image, or also for the physical
memory it uses so it won't overwrite the existing kernel's stuff on the
way up?  (If a compressed kernel wants to decompress itself or extract
an initramfs for itself, what happens?)

Rob

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
