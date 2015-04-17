Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YjFjU-0000p6-Hm
 for kexec@lists.infradead.org; Fri, 17 Apr 2015 23:31:37 +0000
Message-ID: <553197BE.7060705@redhat.com>
Date: Sat, 18 Apr 2015 05:01:10 +0530
From: Pratyush Anand <panand@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 6/6] arm64: wait for transmit completion before next
 character transmission
References: <cover.1429201849.git.panand@redhat.com>
 <6c8a63f701e98cb7cf4ddd96ab5b509115ebdc41.1429201849.git.panand@redhat.com>
 <1429291343.5479.22.camel@infradead.org>
In-Reply-To: <1429291343.5479.22.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: kexec@lists.infradead.org, kexec@lists.fedoraproject.org



On Friday 17 April 2015 10:52 PM, Geoff Levand wrote:
> On Thu, 2015-04-16 at 22:17 +0530, Pratyush Anand wrote:
>> Previous transmission must be completed before next character to be
>> transmitted, otherwise TX buffer may saturate and we will not see all
>> the characters on screen.
>>
>> @@ -34,6 +38,8 @@ static const char arm64_opts_usage[] __attribute__ ((unused)) =
>>   "     --lite                Fast reboot, no memory integrity checks.\n"
>>   "     --page-offset         Kernel page-offset for binary image load.\n"
>>   "     --port=ADDRESS        Purgatory output to port ADDRESS.\n"
>> +"     --port-lsr=ADDRESS    Purgatory output port line status ADDRESS.\n"
>> +"     --port-lsr-val=VALUE  Purgatory output port Line status expected SET value when TX empty.\n"
>>   "     --ramdisk=FILE        Use FILE as the kernel initial ramdisk.\n"
>>   "     --reuse-cmdline       Use command line arg of primary kernel.\n";
>
> We just need to put some chars to the screen, so I want to avoid a lot
> of parameters.
>

I was not able to get even two lines print without it :(

> Usually the status register is at a fixed offset from the TX port.  Is
> that not the case for the ARM uarts?
>
> Can't we just poll port-lsr until empty then start writing again?  That
> will at least eliminate port-lsr-val.
>

infact my first version was using a direct offset with port. Both are 
fixed in most of the cases as offset 0x14 and value 0x60.

OK, I will remove the param for now. if someone finds any different 
values then later on we can add it.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
