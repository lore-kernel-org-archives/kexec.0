Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1286DC43334
	for <kexec@archiver.kernel.org>; Thu, 21 Jul 2022 18:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VglIXRxjs8c0BZ5Bkn7e/X/q+jYpw3zzNyg6YndLwn0=; b=FuPGX1OG7JGGhl
	MNSQtm03gd8uTsB0y6qpmC8fmO4cbhowTx6tTBxKy6sHJMjNGZPbL/Pvloewo6mNEIhkp6Vkvfu3P
	SRX+HOAojynFJQFjJ6RC95yM0CsdOVZU2VeoQ3M7DxGNc0QbHQkvGD+DHIlljEL7rhjy1sZm/hvzp
	IW1VpVz5KPiNO4tEqT9lPgH4bFedENBK/CUYKgVMrcyMx6vKgo7ihOa6Pt9orOR7juIxK5Dd1+HUZ
	8RzrVOOYPvUJe6r18pIYyWokYwLpFMsjD2wjuctZu0zxEmDtECzaXi2X3w8qjBJS5+pzWeVt9ap1Z
	4Tk/1zvbHlGtYMU3dAAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEb2b-00BUjj-SG; Thu, 21 Jul 2022 18:36:53 +0000
Received: from ms.lwn.net ([45.79.88.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEb2Z-00BUhq-C6
	for kexec@lists.infradead.org; Thu, 21 Jul 2022 18:36:52 +0000
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 656C86D9;
	Thu, 21 Jul 2022 18:36:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 656C86D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1658428606; bh=7dY3CR0xZUh78ghGc8dadl08SEECEhHZ6yzAw7iakfc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fVZcRjpAQRak5k0dqUgacCXtEjsRXv3AwU52ypu5M/WwkuOL0Hw/0XYiWH2lYPBKG
	 w76+EqYkDLkjJstI6nDZG4tyiHQLzG62a9TWRQu5V27igirSdBny/NVBtt2v7x+Obo
	 JR0O8wk1VZ+ulH3/Kuu1Qb0zDcqwOPvqJ/WwZ3Qs6uVaTVbhWq0Afd7oTCAl1X1tb3
	 nINa02w5Zv7EmgaxHRsRCw8EJ64g7A5FA5Uo+JsZwnDtatm7Wybw4jZ5HUKu0PVzgC
	 u0GbSQaxgBtQqqD8yD51uyZSsao1tZsIssRU7lZ6AaUkOkJRgmmlqzRw3Rt72yjUol
	 HXXAf1YDaDRSw==
From: Jonathan Corbet <corbet@lwn.net>
To: Slark Xiao <slark_xiao@163.com>, kafai <kafai@fb.com>
Cc: Baoquan He <bhe@redhat.com>, vgoyal <vgoyal@redhat.com>, dyoung
 <dyoung@redhat.com>, ast <ast@kernel.org>, daniel <daniel@iogearbox.net>,
 andrii <andrii@kernel.org>, "martin.lau" <martin.lau@linux.dev>, song
 <song@kernel.org>, yhs <yhs@fb.com>, "john.fastabend"
 <john.fastabend@gmail.com>, kpsingh <kpsingh@kernel.org>, sdf
 <sdf@google.com>, haoluo <haoluo@google.com>, jolsa <jolsa@kernel.org>,
 "william.gray" <william.gray@linaro.org>, dhowells <dhowells@redhat.com>,
 peterz <peterz@infradead.org>, mingo <mingo@redhat.com>, will
 <will@kernel.org>, longman <longman@redhat.com>, "boqun.feng"
 <boqun.feng@gmail.com>, tglx <tglx@linutronix.de>, bigeasy
 <bigeasy@linutronix.de>, kexec <kexec@lists.infradead.org>, linux-doc
 <linux-doc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, linux-cachefs <linux-cachefs@redhat.com>
Subject: Re: [PATCH v2] docs: Fix typo in comment
In-Reply-To: <21cac0ea.18f.182218041f7.Coremail.slark_xiao@163.com>
References: <20220721015605.20651-1-slark_xiao@163.com>
 <20220721154110.fqp7n6f7ij22vayp@kafai-mbp.dhcp.thefacebook.com>
 <21cac0ea.18f.182218041f7.Coremail.slark_xiao@163.com>
Date: Thu, 21 Jul 2022 12:36:45 -0600
Message-ID: <874jzamhxe.fsf@meer.lwn.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_113651_437075_4A6626D8 
X-CRM114-Status: GOOD (  10.25  )
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

"Slark Xiao" <slark_xiao@163.com> writes:

> May I know the maintainer of one subsystem could merge the changes
> contains lots of subsystem?  I also know this could be filtered by
> grep and sed command, but that patch would have dozens of maintainers
> and reviewers.

Certainly I don't think I can merge a patch touching 166 files across
the tree.  This will need to be broken down by subsystem, and you may
well find that there are some maintainers who don't want to deal with
this type of minor fix.

Thanks,

jon

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
