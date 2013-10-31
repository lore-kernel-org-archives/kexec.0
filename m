Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VbvKm-0005OH-Fm
 for kexec@lists.infradead.org; Thu, 31 Oct 2013 16:43:01 +0000
Received: by mail-oa0-f42.google.com with SMTP id k14so3372424oag.15
 for <kexec@lists.infradead.org>; Thu, 31 Oct 2013 09:42:36 -0700 (PDT)
Message-ID: <52728878.2080302@linaro.org>
Date: Thu, 31 Oct 2013 09:42:32 -0700
From: Taras Kondratiuk <taras.kondratiuk@linaro.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] vmcore-dmesg: Understand >= v3.11-rc4 dmesg
References: <20130919143815.GA4487@dhcp-16-126.nay.redhat.com>
 <1379602186-13617-1-git-send-email-lkundrak@v3.sk>
 <20131030031253.GD20932@dhcp16-109.nay.redhat.com>
 <1383152798.31813.2.camel@odvarok>
 <20131031053808.GA7611@dhcp16-109.nay.redhat.com>
 <20131031062026.GX1603@verge.net.au>
In-Reply-To: <20131031062026.GX1603@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>, WANG Chao <chaowang@redhat.com>
Cc: Joe Perches <joe@perches.com>, Lubomir Rintel <lkundrak@v3.sk>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

On 10/30/2013 11:20 PM, Simon Horman wrote:
> On Thu, Oct 31, 2013 at 01:38:08PM +0800, WANG Chao wrote:
>> On 10/30/13 at 06:06pm, Lubomir Rintel wrote:
>>> Hi,
>>>
>>> On Wed, 2013-10-30 at 11:12 +0800, WANG Chao wrote:
>>>> On 09/19/13 at 04:49pm, Lubomir Rintel wrote:
>>>>> Symbol name changed with the following commit:
>>>>> 62e32ac printk: rename struct log to struct printk_log
>>> ...
>>>> vmcore-dmesg is really broken here since 3.11 kernel is released. Are
>>>> you going to send an update v3 to address the comments to v2 from Vivek,
>>>> Joe and Dave
>>>
>>> I'm not really sure. I thought the suggestions were concerning the Linux
>>> kernel tree, not kexec-tools tree. I might be wrong though, but I'd need
>>> the suggestions to be a bit more specific for me to understand.
>>
>> That wouldn't be your concern any more. I think your patch is fine.
>> Thank you for fix.
>>
>> Hi Simon,
>>
>> Will you pick up this patch? Vivek and Dave has acked this patch.
>> And also this patch works for me.
> 
> Sure. Please repost it with the Acks.

I have concerns about this patch.
There were a lot of hardcoded lenght values in the original code.
Now there are twice as much and we need to keep adding hardcoded
values if any additional parameter should be read of renamed.

Please eveluate this patch [1]. It should remove both:
hardcoded values and duplicated reading for two buffer names.

[1] http://permalink.gmane.org/gmane.linux.kernel.kexec/9522

-- 
Taras Kondratiuk

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
