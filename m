Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5FDECAAD3
	for <kexec@archiver.kernel.org>; Mon, 19 Sep 2022 12:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=NDOSgXE9R3w4s80CH/jiW49d6Vv7aFysso9mptSTcZU=; b=PlueTwImsU1EljyNVrpslh3zR0
	+VWAL2Kt2Yoa5fbwtV7ghUUuTG5jkmE0Z9XUYvLaarR871S+fw3RYBaYHD3QAARUD3QIycjZJuimW
	GdaYNTy5G7asM/XJYHS68D9Ga8NfEn8rBuodYv6cAZroslLzvt1+lB1QnzHGcPds3Esa8P7o950bu
	3M2RUqH/46k/iT48fmekBOKFUpttuJCVBbDXFMi2KalrSk8IKPdw+OSqMzQ//KQSUJ7f3sawzr4NO
	3QImvC3hmrBDa2bfhiy+i5tX3Iq/vHW+KrQTaANQzPjghCVzS6/wKoUFlWr9D3JKZqMDjhkKZIn3W
	UBYHZ2ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaGMx-00Bm8x-EV; Mon, 19 Sep 2022 12:59:27 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oa1hd-003O0O-8I; Sun, 18 Sep 2022 21:19:51 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 934C363BBD2F;
	Sun, 18 Sep 2022 23:19:42 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id EXk4oDd9C-bW; Sun, 18 Sep 2022 23:19:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D20DA63BBD3E;
	Sun, 18 Sep 2022 23:19:41 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id We51_Q0FVBCB; Sun, 18 Sep 2022 23:19:41 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6825363BBD27;
	Sun, 18 Sep 2022 23:19:41 +0200 (CEST)
Date: Sun, 18 Sep 2022 23:19:41 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>, kexec@lists.infradead.org, 
	bhe@redhat.com, Petr Mladek <pmladek@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-hyperv@vger.kernel.org, netdev <netdev@vger.kernel.org>, 
	x86 <x86@kernel.org>, kernel-dev@igalia.com, kernel@gpiccoli.net, 
	halves@canonical.com, fabiomirmar@gmail.com, 
	alejandro j jimenez <alejandro.j.jimenez@oracle.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Arnd Bergmann <arnd@arndb.de>, bp <bp@alien8.de>, 
	Jonathan Corbet <corbet@lwn.net>, 
	d hatayama <d.hatayama@jp.fujitsu.com>, 
	dave hansen <dave.hansen@linux.intel.com>, dyoung@redhat.com, 
	feng tang <feng.tang@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	mikelley@microsoft.com, 
	hidehiro kawai ez <hidehiro.kawai.ez@hitachi.com>, jgross@suse.com, 
	John Ogness <john.ogness@linutronix.de>, 
	Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>, 
	mhiramat@kernel.org, mingo <mingo@redhat.com>, paulmck@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, senozhatsky@chromium.org, 
	stern@rowland.harvard.edu, tglx <tglx@linutronix.de>, 
	vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org, 
	xuqiang36@huawei.com, anton ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <2087154222.237106.1663535981252.JavaMail.zimbra@nod.at>
In-Reply-To: <1f464f3d-6668-9e05-bcb7-1b419b5373e1@igalia.com>
References: <20220819221731.480795-1-gpiccoli@igalia.com> <20220819221731.480795-5-gpiccoli@igalia.com> <1f464f3d-6668-9e05-bcb7-1b419b5373e1@igalia.com>
Subject: Re: [PATCH V3 04/11] um: Improve panic notifiers consistency and
 ordering
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Improve panic notifiers consistency and ordering
Thread-Index: fyz9HeboRp6BamGnnqGD9WoCxA8ipw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220918_141949_609047_1EA5E9E1 
X-CRM114-Status: UNSURE (   9.43  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Mon, 19 Sep 2022 05:59:24 -0700
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
b2xpIiA8Z3BpY2NvbGlAaWdhbGlhLmNvbT4KPiBPbiAxOS8wOC8yMDIyIDE5OjE3LCBHdWlsaGVy
bWUgRy4gUGljY29saSB3cm90ZToKPj4gQ3VycmVudGx5IHRoZSBwYW5pYyBub3RpZmllcnMgZnJv
bSB1c2VyIG1vZGUgbGludXggZG9uJ3QgZm9sbG93Cj4+IHRoZSBjb252ZW50aW9uIGZvciBtb3N0
IG9mIHRoZSBvdGhlciBub3RpZmllcnMgcHJlc2VudCBpbiB0aGUKPj4ga2VybmVsIChpbmRlbnRh
dGlvbiwgcHJpb3JpdHkgc2V0dGluZywgbnVtZXJpYyByZXR1cm4pLgo+PiBNb3JlIGltcG9ydGFu
dCwgdGhlIHByaW9yaXRpZXMgY291bGQgYmUgaW1wcm92ZWQsIHNpbmNlIGl0J3MgYQo+PiBzcGVj
aWFsIGNhc2UgKHVzZXJzcGFjZSksIGhlbmNlIHdlIGNvdWxkIHJ1biB0aGUgbm90aWZpZXJzIGVh
cmxpZXI7Cj4+IHVzZXIgbW9kZSBsaW51eCBzaG91bGRuJ3QgY2FyZSBtdWNoIHdpdGggb3RoZXIg
cGFuaWMgbm90aWZpZXJzIGJ1dAo+PiB0aGUgb3JkZXJpbmcgYW1vbmcgdGhlIG1jb25zb2xlIGFu
ZCBhcmNoIG5vdGlmaWVyIGlzIGltcG9ydGFudCwKPj4gZ2l2ZW4gdGhhdCB0aGUgYXJjaCBvbmUg
ZWZmZWN0aXZlbHkgdHJpZ2dlcnMgYSBjb3JlIGR1bXAuCj4+IAo+PiBGaXggdGhhdCBieSBydW5u
aW5nIHRoZSBtY29uc29sZSBub3RpZmllciBhcyB0aGUgZmlyc3QgcGFuaWMKPj4gbm90aWZpZXIs
IGZvbGxvd2VkIGJ5IHRoZSBhcmNoaXRlY3R1cmUgb25lICh0aGF0IGNvcmVkdW1wcykuCj4+IAo+
PiBDYzogQW50b24gSXZhbm92IDxhbnRvbi5pdmFub3ZAY2FtYnJpZGdlZ3JleXMuY29tPgo+PiBD
YzogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4KPj4gQ2M6IFJpY2hh
cmQgV2VpbmJlcmdlciA8cmljaGFyZEBub2QuYXQ+Cj4+IFNpZ25lZC1vZmYtYnk6IEd1aWxoZXJt
ZSBHLiBQaWNjb2xpIDxncGljY29saUBpZ2FsaWEuY29tPgo+PiAKPj4gVjM6Cj4+IC0gTm8gY2hh
bmdlcy4KPj4gWy4uLl0KPiAKPiBIaSBKb2hhbm5lcywgc29ycnkgZm9yIHRoZSBwaW5nLiBEbyB5
b3UgdGhpbmsgeW91IGNvdWxkIHBpY2sgdGhpcyBvbmU/Cj4gT3IgaWYgeW91IHByZWZlciwgSSBj
YW4gcmVzZW5kIGl0IGFsb25lIChub3QgaW4gdGhlIHNlcmllcykgLSBsZXQgbWUKPiBrbm93IHlv
dXIgcHJlZmVyZW5jZS4KClRoaXMgcGF0Y2ggaXMgb24gbXkgVE9ETyBsaXN0LgpKdXN0IGhhZCBu
byBjaGFuY2UgdG8gdGVzdCBpdC4KClRoYW5rcywKLy9yaWNoYXJkCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2tleGVjCg==
