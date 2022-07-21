Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63161C43334
	for <kexec@archiver.kernel.org>; Thu, 21 Jul 2022 18:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PKHCG5pFf+r7JBbw06f3/NTqTTDkmLoX4E2FAOFSg4A=; b=YJkk6r/ogHWDjk
	ApWhnzm61rl77Zc77UipYqq/NGmJg1B8Rox0SYZklfhOO0Zrtx2LJmADGPU06SOR6eeehCAjzVerW
	eQ9rk3N6G77q4GFHBxR+wzGh6PtB355C4DlH6vXaZyiOjDbL/bhPMXV/B0Pyk1vgMHVIemkTcWJtO
	N5hZ3lB+ynTgLZxzPtqOOzGQoSAwBmXhIZ5U7MpNDVFGG1/ToHU7VodQg17DAo7m2BpEslzjmH/WN
	9+5rMqMEVkdPfvEekrjsGrWklUKOuKziresIytxzxX797Od9yIIYHJuxycWLk+MF5YZQ3mXPw/uZ4
	SRYZ8ua9EEoYaiU0HYZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEb5m-00BVrK-MO; Thu, 21 Jul 2022 18:40:10 +0000
Received: from [2601:1c0:6280:3f0::a6b3]
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEb5k-00BVq1-CS; Thu, 21 Jul 2022 18:40:08 +0000
Message-ID: <6ca59494-cc64-d85c-98e8-e9bef2a04c15@infradead.org>
Date: Thu, 21 Jul 2022 11:40:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] docs: Fix typo in comment
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, Slark Xiao <slark_xiao@163.com>,
 kafai <kafai@fb.com>
Cc: Baoquan He <bhe@redhat.com>, vgoyal <vgoyal@redhat.com>,
 dyoung <dyoung@redhat.com>, ast <ast@kernel.org>,
 daniel <daniel@iogearbox.net>, andrii <andrii@kernel.org>,
 "martin.lau" <martin.lau@linux.dev>, song <song@kernel.org>, yhs
 <yhs@fb.com>, "john.fastabend" <john.fastabend@gmail.com>,
 kpsingh <kpsingh@kernel.org>, sdf <sdf@google.com>,
 haoluo <haoluo@google.com>, jolsa <jolsa@kernel.org>,
 "william.gray" <william.gray@linaro.org>, dhowells <dhowells@redhat.com>,
 peterz <peterz@infradead.org>, mingo <mingo@redhat.com>,
 will <will@kernel.org>, longman <longman@redhat.com>,
 "boqun.feng" <boqun.feng@gmail.com>, tglx <tglx@linutronix.de>,
 bigeasy <bigeasy@linutronix.de>, kexec <kexec@lists.infradead.org>,
 linux-doc <linux-doc@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 linux-cachefs <linux-cachefs@redhat.com>
References: <20220721015605.20651-1-slark_xiao@163.com>
 <20220721154110.fqp7n6f7ij22vayp@kafai-mbp.dhcp.thefacebook.com>
 <21cac0ea.18f.182218041f7.Coremail.slark_xiao@163.com>
 <874jzamhxe.fsf@meer.lwn.net>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <874jzamhxe.fsf@meer.lwn.net>
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



On 7/21/22 11:36, Jonathan Corbet wrote:
> "Slark Xiao" <slark_xiao@163.com> writes:
> 
>> May I know the maintainer of one subsystem could merge the changes
>> contains lots of subsystem?  I also know this could be filtered by
>> grep and sed command, but that patch would have dozens of maintainers
>> and reviewers.
> 
> Certainly I don't think I can merge a patch touching 166 files across
> the tree.  This will need to be broken down by subsystem, and you may
> well find that there are some maintainers who don't want to deal with
> this type of minor fix.

We have also seen cases where "the the" should be replaced by "then the"
or some other pair of words, so some of these changes could fall into
that category.

-- 
~Randy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
