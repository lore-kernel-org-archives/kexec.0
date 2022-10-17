Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19593C4332F
	for <kexec@archiver.kernel.org>; Fri, 21 Oct 2022 13:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=jnWqIETrEzwitdkZ4P+fwFwdflG945gPXnjyY91Te1U=; b=T7ZR8grlGuowxLPVMtTnWQ7DGv
	+zno8yN4cvosCzzy55KYrm+VexRtv/RixhxbDhcown0Vv612E+lXr5kkInckJFqCG990FNkHZYcQQ
	8j50mUOn/PDClrY7Hyji7F+seccdCC6DrxT6MN+vVZr2kd9qkP/HkZ5XclzFUCc/t1FImYJ9W+aQs
	P0P6ZfkIGeO5IJv4+cEka36x7jQpTfAFK2NBdMuahMDYdlQ1yMcirH2RHLyAZQTqnXBoB+wHdsTdj
	pDAmOxluNExCdkIX7DxKNObvckoT9KCfZf9lwdZp+WStRlgbDHY3LEs1BZ5D5U29oG7ewxSgXG6Fw
	r9lYHQBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olsTQ-008JZA-GG; Fri, 21 Oct 2022 13:54:08 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okQpB-00CVKI-Gi; Mon, 17 Oct 2022 14:10:39 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C252561F0A8B;
	Mon, 17 Oct 2022 16:10:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 7Bqt5iK7Mhen; Mon, 17 Oct 2022 16:10:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2CC3A62EFE89;
	Mon, 17 Oct 2022 16:10:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eGcU3lunn7ZX; Mon, 17 Oct 2022 16:10:30 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id CC4CA61F0A8B;
	Mon, 17 Oct 2022 16:10:29 +0200 (CEST)
Date: Mon, 17 Oct 2022 16:10:29 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>, 
	kexec <kexec@lists.infradead.org>, bhe <bhe@redhat.com>, 
	Petr Mladek <pmladek@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-hyperv <linux-hyperv@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, x86 <x86@kernel.org>, 
	kernel-dev <kernel-dev@igalia.com>, kernel <kernel@gpiccoli.net>, 
	halves <halves@canonical.com>, fabiomirmar <fabiomirmar@gmail.com>, 
	alejandro j jimenez <alejandro.j.jimenez@oracle.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Arnd Bergmann <arnd@arndb.de>, bp <bp@alien8.de>, 
	Jonathan Corbet <corbet@lwn.net>, 
	d hatayama <d.hatayama@jp.fujitsu.com>, 
	dave hansen <dave.hansen@linux.intel.com>, 
	dyoung <dyoung@redhat.com>, feng tang <feng.tang@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	mikelley <mikelley@microsoft.com>, 
	hidehiro kawai ez <hidehiro.kawai.ez@hitachi.com>, 
	jgross <jgross@suse.com>, John Ogness <john.ogness@linutronix.de>, 
	Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>, 
	mhiramat <mhiramat@kernel.org>, mingo <mingo@redhat.com>, 
	paulmck <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, 
	senozhatsky <senozhatsky@chromium.org>, 
	stern <stern@rowland.harvard.edu>, tglx <tglx@linutronix.de>, 
	vgoyal <vgoyal@redhat.com>, vkuznets <vkuznets@redhat.com>, 
	will <will@kernel.org>, xuqiang36 <xuqiang36@huawei.com>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <422015181.40644.1666015829599.JavaMail.zimbra@nod.at>
In-Reply-To: <280ce0ae-5a50-626f-930f-2661a109fa36@igalia.com>
References: <20220819221731.480795-1-gpiccoli@igalia.com> <20220819221731.480795-5-gpiccoli@igalia.com> <1f464f3d-6668-9e05-bcb7-1b419b5373e1@igalia.com> <2087154222.237106.1663535981252.JavaMail.zimbra@nod.at> <280ce0ae-5a50-626f-930f-2661a109fa36@igalia.com>
Subject: Re: [PATCH V3 04/11] um: Improve panic notifiers consistency and
 ordering
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Improve panic notifiers consistency and ordering
Thread-Index: kqQk2RczEaY2s6Uahti6roceJKzQkQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_071037_749228_42AE3B3F 
X-CRM114-Status: UNSURE (   4.19  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Fri, 21 Oct 2022 06:53:57 -0700
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIkd1aWxoZXJtZSBHLiBQaWNj
b2xpIiA8Z3BpY2NvbGlAaWdhbGlhLmNvbT4KPiBIaSBSaWNoYXJkIC8gSm9oYW5uZXMsIGlzIHRo
ZXJlIGFueSBuZXdzIG9uIHRoaXMgb25lPwo+IFRoYW5rcyBpbiBhZHZhbmNlLAoKSXQncyB1cHN0
cmVhbToKZ2l0Lmtlcm5lbC5vcmcvbGludXMvNzU4ZGZkYjkxODVjZjk0MTYwZjIwZTg1YmJlMDU1
ODNlM2NkNGZmNAoKVGhhbmtzLAovL3JpY2hhcmQKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4
ZWMK
