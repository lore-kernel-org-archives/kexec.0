Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yksh8-0006zl-18
 for kexec@lists.infradead.org; Wed, 22 Apr 2015 11:19:54 +0000
Message-ID: <553783B8.1040304@redhat.com>
Date: Wed, 22 Apr 2015 16:49:20 +0530
From: Pratyush Anand <panand@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 5/6] arm64: Add support for binary image
References: <cover.1429201849.git.panand@redhat.com>
 <0a15f2079e6c378996dceda1d509df77d2f43899.1429201849.git.panand@redhat.com>
 <20150420072402.GG15033@dhcp-16-116.nay.redhat.com>
 <5535D522.3080806@redhat.com>
 <20150422025305.GB4458@dhcp-16-116.nay.redhat.com>
In-Reply-To: <20150422025305.GB4458@dhcp-16-116.nay.redhat.com>
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
To: Baoquan He <bhe@redhat.com>, Geoff Levand <geoff@infradead.org>
Cc: kexec@lists.infradead.org, kexec@lists.fedoraproject.org



On Wednesday 22 April 2015 08:23 AM, Baoquan He wrote:
> On 04/21/15 at 10:12am, Pratyush Anand wrote:
>>
>>
>> On Monday 20 April 2015 12:54 PM, Baoquan He wrote:
>>> On 04/16/15 at 10:17pm, Pratyush Anand wrote:
>>>>> This patch adds support to use binary image ie arch/arm64/boot/Image.
>>>>>
>>>>> Binary image does not have sufficient knowledge to extract page offset
>>>>> information, which is needed by kexec tool. Use a new command parameter
>>>>> --page-offset, so that user can provide page offset information for
>>>>> liner mapping.
>>>>>
>>>>> Signed-off-by: Pratyush Anand<panand@redhat.com>
>>>>> ---
>>> Seems there's a function get_kernel_page_offset used to get page_offset
>>> automatically in arm. arm64 should have it either.
>>>
>>>
>>
>> ARM still takes user option for --page-offset in user_page_offset
>> variable and then cross check that value with one found in
>> /proc/kallsyms.
>
> Well, this looks good. Try --page-offset and then fetch it in
> /proc/kallsysms if not specificed by user. ARM64 should have this too.
>
>>

OK... Will do that.

@Geoff: I will send this patch in two parts. First will apply on top of 
your patches. Second will apply after Takahiro's patch.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
