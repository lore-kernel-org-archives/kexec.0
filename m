Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yk2Tb-0006My-N6
 for kexec@lists.infradead.org; Mon, 20 Apr 2015 03:34:28 +0000
Message-ID: <553473A9.7060303@redhat.com>
Date: Mon, 20 Apr 2015 09:04:01 +0530
From: Pratyush Anand <panand@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 6/6] arm64: wait for transmit completion before next
 character transmission
References: <cover.1429201849.git.panand@redhat.com>
 <6c8a63f701e98cb7cf4ddd96ab5b509115ebdc41.1429201849.git.panand@redhat.com>
 <20150417053621.GA8658@dhcp-128-1.nay.redhat.com>
 <55309C29.5050702@redhat.com>
 <20150420025828.GD15033@dhcp-16-116.nay.redhat.com>
In-Reply-To: <20150420025828.GD15033@dhcp-16-116.nay.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: Minfei Huang <mhuang@redhat.com>, kexec@lists.infradead.org, kexec@lists.fedoraproject.org



On Monday 20 April 2015 08:28 AM, Baoquan He wrote:
> On 04/17/15 at 11:07am, Pratyush Anand wrote:
>>
>>
>> On Friday 17 April 2015 11:06 AM, Minfei Huang wrote:
>>>>   	.quad	0
>>>>>   size arm64_dtb_addr
>>>>> +
>>>>> +.globl arm64_sink_lsr_val
>>>>> +arm64_sink_lsr_val:
>>>>> +	.word	0
>>> Since arm64_sink_lsr_val is declared as uint32_t, it is better to keep
>>> the same format here.
>
> ".word" only stores 16bit, doesn't it? Should it be ".int" or ".long"?

I see that .word, .int and .long all reserve 4 bytes for ARM64. But may 
be using .int could be better.

However, as Geoff suggested to remove port-lsr and port-lsr-val, so we 
will not need these.

~Pratyush

> You can check gnu as manual for reference.
>
> Thanks
> Baoquan
>
>>>
>>
>> I thought .word will do the same. But may be I am wrong. What is the
>> good syntax for uint32_t.
>>
>> ~Pratyush
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
