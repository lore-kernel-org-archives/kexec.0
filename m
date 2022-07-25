Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BD8C43334
	for <kexec@archiver.kernel.org>; Mon, 25 Jul 2022 13:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZTAwEjvePwJXyuv0k5HMfWHarkyvAcbl/u0wHi3zSO4=; b=Q1LCnWkohRQfnf
	Eg6ZRIGwOMzrYaQM9iod1hbXXSwl0PgDrX9rX93rdiWGjef2VzZf48Lp7KAyJxps32XnYC7JlwIrf
	xrnL1zzAcoSzp5gG0w1z1iVMfNEmz713larmaEZu6PILtBi2dTyvqsSvItwcATm2h3sy2FTKq+xmU
	zZuhXfjB46P6cmydwxdHciXSKh53wjkqThat14pggqUPQWdqUYASBEQs9ufeo1KxVdpaozdUeJybF
	hdOX4VOaP6C68bnZvJDO8hMUbKDBdB5gCc2c8RFoEm4meHQ1CLzTEkCr8enhBp6gjGVGsbfSffZLo
	sMYh6hKvxJvn1L3croxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFyVr-00AHMn-Ky; Mon, 25 Jul 2022 13:52:47 +0000
Received: from smtprelay0017.hostedemail.com ([216.40.44.17] helo=relay.hostedemail.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFyVj-00AGjQ-UY
	for kexec@lists.infradead.org; Mon, 25 Jul 2022 13:52:46 +0000
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 9BD664105A;
	Mon, 25 Jul 2022 13:52:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 2CBFA2000E;
	Mon, 25 Jul 2022 13:52:16 +0000 (UTC)
Message-ID: <5bd85a7241e6ccac7fe5647cb9cf7ef22b228943.camel@perches.com>
Subject: Re: [PATCH v2] docs: Fix typo in comment
From: Joe Perches <joe@perches.com>
To: Baoquan He <bhe@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Jonathan Corbet
	 <corbet@lwn.net>, Slark Xiao <slark_xiao@163.com>
Cc: kafai <kafai@fb.com>, vgoyal <vgoyal@redhat.com>, dyoung
 <dyoung@redhat.com>,  ast <ast@kernel.org>, daniel <daniel@iogearbox.net>,
 andrii <andrii@kernel.org>,  "martin.lau" <martin.lau@linux.dev>, song
 <song@kernel.org>, yhs <yhs@fb.com>, "john.fastabend"
 <john.fastabend@gmail.com>, kpsingh <kpsingh@kernel.org>, sdf
 <sdf@google.com>,  haoluo <haoluo@google.com>, jolsa <jolsa@kernel.org>,
 "william.gray" <william.gray@linaro.org>,  dhowells <dhowells@redhat.com>,
 peterz <peterz@infradead.org>, mingo <mingo@redhat.com>, will
 <will@kernel.org>, longman <longman@redhat.com>, "boqun.feng"
 <boqun.feng@gmail.com>, tglx <tglx@linutronix.de>, bigeasy
 <bigeasy@linutronix.de>,  kexec <kexec@lists.infradead.org>, linux-doc
 <linux-doc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, linux-cachefs <linux-cachefs@redhat.com>
Date: Mon, 25 Jul 2022 06:52:15 -0700
In-Reply-To: <YtnlAg6Qhf7fwXXW@MiWiFi-R3L-srv>
References: <20220721015605.20651-1-slark_xiao@163.com>
	 <20220721154110.fqp7n6f7ij22vayp@kafai-mbp.dhcp.thefacebook.com>
	 <21cac0ea.18f.182218041f7.Coremail.slark_xiao@163.com>
	 <874jzamhxe.fsf@meer.lwn.net>
	 <6ca59494-cc64-d85c-98e8-e9bef2a04c15@infradead.org>
	 <YtnlAg6Qhf7fwXXW@MiWiFi-R3L-srv>
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Stat-Signature: 7gktrdtqywj6jsoc4553wwy1ksexyrp9
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 2CBFA2000E
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+L2rRg9wujM2WCCGt5WkY3LxQACR7fn/A=
X-HE-Tag: 1658757136-644642
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220725_065240_093978_DF7B7BB9 
X-CRM114-Status: GOOD (  20.28  )
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

On Fri, 2022-07-22 at 07:45 +0800, Baoquan He wrote:
> On 07/21/22 at 11:40am, Randy Dunlap wrote:
> > On 7/21/22 11:36, Jonathan Corbet wrote:
> > > "Slark Xiao" <slark_xiao@163.com> writes:
> > > > May I know the maintainer of one subsystem could merge the changes
> > > > contains lots of subsystem?  I also know this could be filtered by
> > > > grep and sed command, but that patch would have dozens of maintainers
> > > > and reviewers.
> > > 
> > > Certainly I don't think I can merge a patch touching 166 files across
> > > the tree.  This will need to be broken down by subsystem, and you may
> > > well find that there are some maintainers who don't want to deal with
> > > this type of minor fix.
> > 
> > We have also seen cases where "the the" should be replaced by "then the"
> > or some other pair of words, so some of these changes could fall into
> > that category.
> 
> It's possible. I searched in Documentation and went through each place,
> seems no typo of "then the". Below patch should clean up all the 'the the'
> typo under Documentation.
[]
> The fix is done with below command:
> sed -i "s/the the /the /g" `git grep -l "the the " Documentation`

This command misses entries at EOL:

Documentation/trace/histogram.rst:  Here's an example where we use a compound key composed of the the

Perhaps a better conversion would be 's/\bthe the\b/the/g'


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
