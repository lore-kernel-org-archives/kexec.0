Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB85C433EF
	for <kexec@archiver.kernel.org>; Mon, 25 Jul 2022 23:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5QJCwIkYQxSqpBxwcm9QkPzaEHSgqHFEZTCit+/aErg=; b=UfWCgicgF/CiMb
	9tN7KiOuR+rblo17p4BSgPQNJXdF1F9CdtXvXIgE5jfUBVcidFOO+AnKnI8CuQeNIi68WBiR4xDCU
	KPbYIaLzMnDkSu2JLFQ5WrNMI3HejhUB2CnK6Pd25zftZYj0pwqMRtlwZXkZwIvj5XDuF0cbnxzGO
	/klaN5zYd3uqkkILUZrCIXgcKKFVAaVw9HYlt46Spu77ATZAArvX8RLBBvdWTBt45u9g2+378Pj8B
	P7RsbbWlQnWzYQP1K3R5VUyHe5ifgfNU66iqBnvom3u+SHNk+uwPTMUG+/FD5PBjmwsfskUBU3Xbq
	vWVj2ur1XcVs+qN38qGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oG7GI-003yuL-ES; Mon, 25 Jul 2022 23:13:18 +0000
Received: from smtprelay0017.hostedemail.com ([216.40.44.17] helo=relay.hostedemail.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oG7GF-003ypS-P6
	for kexec@lists.infradead.org; Mon, 25 Jul 2022 23:13:17 +0000
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id C2E71C071E;
	Mon, 25 Jul 2022 23:13:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 697EA1E;
	Mon, 25 Jul 2022 23:12:52 +0000 (UTC)
Message-ID: <c9340a12783beccac426d75f1df5b004c807ceb6.camel@perches.com>
Subject: Re: [PATCH v2] docs: Fix typo in comment
From: Joe Perches <joe@perches.com>
To: William Breathitt Gray <william.gray@linaro.org>
Cc: Baoquan He <bhe@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, 
 Jonathan Corbet <corbet@lwn.net>, Slark Xiao <slark_xiao@163.com>, kafai
 <kafai@fb.com>, vgoyal <vgoyal@redhat.com>, dyoung <dyoung@redhat.com>, ast
 <ast@kernel.org>, daniel <daniel@iogearbox.net>, andrii
 <andrii@kernel.org>, "martin.lau" <martin.lau@linux.dev>, song
 <song@kernel.org>, yhs <yhs@fb.com>,  "john.fastabend"
 <john.fastabend@gmail.com>, kpsingh <kpsingh@kernel.org>, sdf
 <sdf@google.com>, haoluo <haoluo@google.com>, jolsa <jolsa@kernel.org>,
 dhowells <dhowells@redhat.com>,  peterz <peterz@infradead.org>, mingo
 <mingo@redhat.com>, will <will@kernel.org>, longman <longman@redhat.com>,
 "boqun.feng" <boqun.feng@gmail.com>, tglx <tglx@linutronix.de>, bigeasy
 <bigeasy@linutronix.de>, kexec <kexec@lists.infradead.org>, linux-doc
 <linux-doc@vger.kernel.org>,  linux-kernel <linux-kernel@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, linux-cachefs <linux-cachefs@redhat.com>
Date: Mon, 25 Jul 2022 16:12:51 -0700
In-Reply-To: <Yt6hMD+HIaERgrqg@fedora>
References: <20220721015605.20651-1-slark_xiao@163.com>
	 <20220721154110.fqp7n6f7ij22vayp@kafai-mbp.dhcp.thefacebook.com>
	 <21cac0ea.18f.182218041f7.Coremail.slark_xiao@163.com>
	 <874jzamhxe.fsf@meer.lwn.net>
	 <6ca59494-cc64-d85c-98e8-e9bef2a04c15@infradead.org>
	 <YtnlAg6Qhf7fwXXW@MiWiFi-R3L-srv>
	 <5bd85a7241e6ccac7fe5647cb9cf7ef22b228943.camel@perches.com>
	 <Yt6hMD+HIaERgrqg@fedora>
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Stat-Signature: scxpfj6ognbxy16i47zhaoc7nn8mhr7p
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 697EA1E
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18oibnQ1mEZciO6tvJNDDYSZCjv6uxPeLM=
X-HE-Tag: 1658790772-439912
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220725_161315_880046_EEB6AC97 
X-CRM114-Status: GOOD (  15.24  )
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

On Mon, 2022-07-25 at 09:57 -0400, William Breathitt Gray wrote:
> On Mon, Jul 25, 2022 at 06:52:15AM -0700, Joe Perches wrote:
> > On Fri, 2022-07-22 at 07:45 +0800, Baoquan He wrote:
> > > The fix is done with below command:
> > > sed -i "s/the the /the /g" `git grep -l "the the " Documentation`
> > 
> > This command misses entries at EOL:
> > 
> > Documentation/trace/histogram.rst:  Here's an example where we use a compound key composed of the the
> > 
> > Perhaps a better conversion would be 's/\bthe the\b/the/g'
> 
> It would be good to check for instances that cross newlines as well;
> i.e. "the" at the end of a line followed by "the" at the start of the
> next line. However, this would require some thought to properly account
> for comment blocks ("*") and other similar prefixes that should be
> ignored.

checkpatch already attempts that duplicated word across a newline test.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
