Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1baHWO-00007l-MZ
 for kexec@lists.infradead.org; Thu, 18 Aug 2016 07:14:01 +0000
Message-ID: <57B55FC3.8050302@cn.fujitsu.com>
Date: Thu, 18 Aug 2016 15:12:03 +0800
From: =?UTF-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?=
 <zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v8 1/2] Documentation: kdump: remind user of nr_cpus
References: <1471487495-22787-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <1471487495-22787-2-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <1471487809.4319.15.camel@perches.com>
 <20160818064715.GC26001@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20160818064715.GC26001@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>, Joe Perches <joe@perches.com>
Cc: bhe@redhat.com, corbet@lwn.net, xlpang@redhat.com, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, vgoyal@redhat.com

On 08/18/2016 02:47 PM, Dave Young wrote:
> On 08/17/16 at 07:36pm, Joe Perches wrote:
>> On Thu, 2016-08-18 at 10:31 +0800, Zhou Wenjian wrote:
>>> nr_cpus can help to save memory. So we should remind user of it.
>>
>> trivia:
>>> diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
>> []
>>> @@ -390,9 +390,11 @@ Notes on loading the dump-capture kernel:
>>>   * Boot parameter "1" boots the dump-capture kernel into single-user
>>>     mode without networking. If you want networking, use "3".
>>>
>>> -* We generally don' have to bring up a SMP kernel just to capture the
>>> +* We generally don' have to bring up an SMP kernel just to capture the
>>
>> don't or do not
>>
>
> Use do not is better, also need replace 'We' with 'You' to be
> consistent with other part.
>
>

I think it's better to fix it in another patch,
for it doesn't have much relevance to the patch set.
I'll post it alone later.

-- 
Thanks
Zhou



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
