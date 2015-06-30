Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z9k01-0005zs-45
 for kexec@lists.infradead.org; Tue, 30 Jun 2015 01:06:09 +0000
Message-ID: <5591EA8C.4040000@cn.fujitsu.com>
Date: Tue, 30 Jun 2015 09:02:04 +0800
From: =?UTF-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?=
 <zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] makedumpfile: Add description of pages lost by
 ENOSPACE in IMPLEMENTATION
References: <1435220576-32595-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701DCA526@BPXM01GP.gisp.nec.co.jp>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701DCA526@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 06/29/2015 04:33 PM, Atsushi Kumagai wrote:
> Hello Zhou,
>
>> Currently, there is no obvious description in IMPLEMENTATION for
>> distinguishing the lost pages resulted by ENOSPACE errors or others.
>> So, it is added.
>>
>> Signed-off-by: Zhou Wenjian<zhouwj-fnst@cn.fujitsu.com>
>> ---
>> IMPLEMENTATION |    2 ++
>> 1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/IMPLEMENTATION b/IMPLEMENTATION
>> index 72df5d5..70a3f7c 100644
>> --- a/IMPLEMENTATION
>> +++ b/IMPLEMENTATION
>> @@ -240,6 +240,8 @@
>>      The page header and page data are written in pairs. When writing page data
>>      (pfn N+1), if ENOSPACE error happens, the page headers after N won't be
>>      written either.
>> +    When reading page from incomplete core, only the page lost by ENOSPACE errors
>> +    has 0 in its corresponding page descriptor's member offset.
>
> I'm not sure this is correct.
> Could you point me where is the code which sets 0 to the page_desc->offset
> of the lost page ?
>

There is no code to set it. Since the data lost is filled with zero when it is read,
the page_desc->offset will also be zero.
And zero page has its own offset not equal 0. So we can distinguish them with their
member offset.

-- 
Thanks
Zhou Wenjian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
