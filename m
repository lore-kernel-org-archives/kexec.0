Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WYRdN-0000aY-Rw
 for kexec@lists.infradead.org; Fri, 11 Apr 2014 02:56:06 +0000
Message-ID: <5347599F.8040703@zytor.com>
Date: Thu, 10 Apr 2014 19:55:27 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v5 09/10] x86: Pass memory range via E820 for kdump
References: <1397121186-9353-1-git-send-email-chaowang@redhat.com>
 <1397121186-9353-14-git-send-email-chaowang@redhat.com>
 <20140411022831.GG5493@dhcp-16-198.nay.redhat.com>
 <5347554A.4080009@zytor.com>
 <20140411024730.GH5493@dhcp-16-198.nay.redhat.com>
In-Reply-To: <20140411024730.GH5493@dhcp-16-198.nay.redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, WANG Chao <chaowang@redhat.com>, horms@verge.net.au, linn@hp.com, trenn@suse.de, vgoyal@redhat.com, ebiederm@xmission.com

On 04/10/2014 07:47 PM, Dave Young wrote:
> On 04/10/14 at 07:36pm, H. Peter Anvin wrote:
>> On 04/10/2014 07:28 PM, Dave Young wrote:
>>>>  
>>>> +static void add_e820_map_from_mr(struct x86_linux_param_header *real_mode,
>>>> +			struct e820entry *e820, struct memory_range *range, int nr_range)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; i < nr_range; i++) {
>>>> +		e820[i].addr = range[i].start;
>>>> +		e820[i].size = range[i].end - range[i].start;
>>>
>>> I see it's same as original code but I still feel it should be end - start + 1;
>>>
>>
>> I can't see how it could possibly be +1.
>>
>> How do you encode range[].end?  If it is inclusive it should be end -
>> start - 1, if it is a semiclosed range (the normal thing in computer
>> contexts) then the code above is correct.

I obviously got the above backwards in my head.  Please ignore.

> 
> Say the first range from my /proc/iomem:
> 00000000-00000fff : reserved
> 
> Shouldn't the size be 0x1000? It looks like closed range instead of semiclosed range.

You're right.  I thought we mangled the contents for /proc/iomem, but we
actually keep the contents as a closed range.

So never mind me!  -ENOBRAINTODAY.

	-hpa





_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
