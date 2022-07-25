Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92390C43334
	for <kexec@archiver.kernel.org>; Mon, 25 Jul 2022 19:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4pBciyhu3fUJmNTXF076vPSyAnxu+z4gOoiXXjHok4o=; b=Mhqrxy0Q6Gs7KX
	smW2CmBdi6rt7gGBj7KEO8blUZWN4ZfLg4eQD/2+TZoqI6EpzSHhOSzYBmDifHXFs+EDQqbUzIhho
	JrfoXhIqoUIbFTZvLdPcXQIQqcbpBnWrh3qpu4ejol3ycl4NGgFIiYVQKxxTB01rqTOIbPNkuiow2
	njMXQyUvWVMbpBDnibmrCq18+uREJHmp9uT1JZJFlj0haHOem8ruHzrlktbxdIW3XXzcZ4VkQXqrD
	PZdCQI0mkHTaE20cR01iwU+vbQ/WwhNpPEH9YUhC0LBl/5tz3FQSBY6VBEu6kEt8wARTDsuY51sqW
	0zEGUVNKhMBiqhSr0CzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oG47w-001AWr-7y; Mon, 25 Jul 2022 19:52:28 +0000
Received: from [2601:1c0:6280:3f0::a6b3]
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oG47s-001ATt-W2; Mon, 25 Jul 2022 19:52:25 +0000
Message-ID: <d146f3d6-9b2a-5b54-4ae3-733047ef210e@infradead.org>
Date: Mon, 25 Jul 2022 12:52:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] docs: Fix typo in comment
Content-Language: en-US
To: William Breathitt Gray <william.gray@linaro.org>,
 Joe Perches <joe@perches.com>
Cc: Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Slark Xiao <slark_xiao@163.com>, kafai <kafai@fb.com>,
 vgoyal <vgoyal@redhat.com>, dyoung <dyoung@redhat.com>, ast
 <ast@kernel.org>, daniel <daniel@iogearbox.net>, andrii <andrii@kernel.org>,
 "martin.lau" <martin.lau@linux.dev>, song <song@kernel.org>, yhs
 <yhs@fb.com>, "john.fastabend" <john.fastabend@gmail.com>,
 kpsingh <kpsingh@kernel.org>, sdf <sdf@google.com>,
 haoluo <haoluo@google.com>, jolsa <jolsa@kernel.org>,
 dhowells <dhowells@redhat.com>, peterz <peterz@infradead.org>,
 mingo <mingo@redhat.com>, will <will@kernel.org>,
 longman <longman@redhat.com>, "boqun.feng" <boqun.feng@gmail.com>,
 tglx <tglx@linutronix.de>, bigeasy <bigeasy@linutronix.de>,
 kexec <kexec@lists.infradead.org>, linux-doc <linux-doc@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 linux-cachefs <linux-cachefs@redhat.com>
References: <20220721015605.20651-1-slark_xiao@163.com>
 <20220721154110.fqp7n6f7ij22vayp@kafai-mbp.dhcp.thefacebook.com>
 <21cac0ea.18f.182218041f7.Coremail.slark_xiao@163.com>
 <874jzamhxe.fsf@meer.lwn.net>
 <6ca59494-cc64-d85c-98e8-e9bef2a04c15@infradead.org>
 <YtnlAg6Qhf7fwXXW@MiWiFi-R3L-srv>
 <5bd85a7241e6ccac7fe5647cb9cf7ef22b228943.camel@perches.com>
 <Yt6hMD+HIaERgrqg@fedora>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Yt6hMD+HIaERgrqg@fedora>
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 7/25/22 06:57, William Breathitt Gray wrote:
> On Mon, Jul 25, 2022 at 06:52:15AM -0700, Joe Perches wrote:
>> On Fri, 2022-07-22 at 07:45 +0800, Baoquan He wrote:
>>> On 07/21/22 at 11:40am, Randy Dunlap wrote:
>>>> On 7/21/22 11:36, Jonathan Corbet wrote:
>>>>> "Slark Xiao" <slark_xiao@163.com> writes:
>>>>>> May I know the maintainer of one subsystem could merge the changes
>>>>>> contains lots of subsystem?  I also know this could be filtered by
>>>>>> grep and sed command, but that patch would have dozens of maintainers
>>>>>> and reviewers.
>>>>>
>>>>> Certainly I don't think I can merge a patch touching 166 files across
>>>>> the tree.  This will need to be broken down by subsystem, and you may
>>>>> well find that there are some maintainers who don't want to deal with
>>>>> this type of minor fix.
>>>>
>>>> We have also seen cases where "the the" should be replaced by "then the"
>>>> or some other pair of words, so some of these changes could fall into
>>>> that category.
>>>
>>> It's possible. I searched in Documentation and went through each place,
>>> seems no typo of "then the". Below patch should clean up all the 'the the'
>>> typo under Documentation.
>> []
>>> The fix is done with below command:
>>> sed -i "s/the the /the /g" `git grep -l "the the " Documentation`
>>
>> This command misses entries at EOL:
>>
>> Documentation/trace/histogram.rst:  Here's an example where we use a compound key composed of the the
>>
>> Perhaps a better conversion would be 's/\bthe the\b/the/g'
> 
> It would be good to check for instances that cross newlines as well;
> i.e. "the" at the end of a line followed by "the" at the start of the
> next line. However, this would require some thought to properly account
> for comment blocks ("*") and other similar prefixes that should be
> ignored.

Yeah, the script that I posted last year (?) does that, but it's noisy --
results need to be hand-checked.

It's not clear how people are finding these repeated words, other than
something like
$ grep "the the" *


-- 
~Randy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
