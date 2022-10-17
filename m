Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F9DC4332F
	for <kexec@archiver.kernel.org>; Fri, 21 Oct 2022 13:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hHp2Utp5zHJFHfIB1SGzs7aQVPLlex1L36SkG4dizuk=; b=uobD5LJNjWt7PS
	UY7GWuWpM1eEutB+7ySvqT+pHQHcmc657eePWTSLkFHFBxBGakykgpypxsw6UN+/6LJcYds/xor9x
	v1UpSW9Xt9U+/6VJjMJp8obIrleAo5ihWI+XnvsXcuGPY65vRA49NHNjUoqTx81XOIuVk053nzREL
	jBLIdQDmRDx28In1sNR6Sr2OLT+QJ6mBm5Pev9TYzVMIAPqIJ6ZkIYffeN+qoUfKBMvNCl21DqO9i
	JXx/22phPaDMs3J63M0GjMwNyGGP3CFa3PTMnAFLK7FakngrG2LqsQ1nbkkPYy87nIl/h8FLhGTqE
	JsIZd0GTMip3h9/QJhcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olsTJ-008JA4-IC; Fri, 21 Oct 2022 13:54:01 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okQgx-00CR3b-PD; Mon, 17 Oct 2022 14:02:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iitAWGgeq0Jp56gEe7Wxdu4oO5N9LkW6N6YMxnpf7m8=; b=DuUATXpale+eQyysDRVfygAERH
	pP1m1o822phLAUpS4/I/06j0q1EyTkieF8dCBxxfJtPzjg4gexDmZqb+386TpVVLoZsScqgLh7Ioz
	G6Pz01QLfwFI4XqZeu5nnBDjUynBBgs0IpmZy17AIdztu0TLzk74GkITpER6Kwt2U7amxmTfNl5HS
	/0MffDt5IRdmV0PmC1VbkPZ/DYgZLduzJRW4iKbDnKG6bMM1pSVc39Bn61ZrF4TTf16mhMCYbXZQ+
	d4iptpEiG1qcUWbrUFL6saA88yFxoswYtPo5hdiGpUXBaE1+PQ6gcQ9BVLIb9WV+89yjbEDB6grIu
	aZPYRycQ==;
Received: from [179.113.159.85] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1okQgm-000Nyb-2n; Mon, 17 Oct 2022 16:01:56 +0200
Message-ID: <280ce0ae-5a50-626f-930f-2661a109fa36@igalia.com>
Date: Mon, 17 Oct 2022 11:01:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V3 04/11] um: Improve panic notifiers consistency and
 ordering
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>,
 linux-um <linux-um@lists.infradead.org>
Cc: kexec@lists.infradead.org, bhe@redhat.com, Petr Mladek
 <pmladek@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-hyperv@vger.kernel.org,
 netdev <netdev@vger.kernel.org>, x86 <x86@kernel.org>,
 kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com,
 fabiomirmar@gmail.com, alejandro j jimenez <alejandro.j.jimenez@oracle.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, bp <bp@alien8.de>,
 Jonathan Corbet <corbet@lwn.net>, d hatayama <d.hatayama@jp.fujitsu.com>,
 dave hansen <dave.hansen@linux.intel.com>, dyoung@redhat.com,
 feng tang <feng.tang@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mikelley@microsoft.com,
 hidehiro kawai ez <hidehiro.kawai.ez@hitachi.com>, jgross@suse.com,
 John Ogness <john.ogness@linutronix.de>, Kees Cook <keescook@chromium.org>,
 Andy Lutomirski <luto@kernel.org>, mhiramat@kernel.org,
 mingo <mingo@redhat.com>, paulmck@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 senozhatsky@chromium.org, stern@rowland.harvard.edu,
 tglx <tglx@linutronix.de>, vgoyal@redhat.com, vkuznets@redhat.com,
 will@kernel.org, xuqiang36@huawei.com,
 anton ivanov <anton.ivanov@cambridgegreys.com>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-5-gpiccoli@igalia.com>
 <1f464f3d-6668-9e05-bcb7-1b419b5373e1@igalia.com>
 <2087154222.237106.1663535981252.JavaMail.zimbra@nod.at>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <2087154222.237106.1663535981252.JavaMail.zimbra@nod.at>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_070207_835950_C7FE5A53 
X-CRM114-Status: GOOD (  13.51  )
X-Mailman-Approved-At: Fri, 21 Oct 2022 06:53:58 -0700
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

T24gMTgvMDkvMjAyMiAxODoxOSwgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOgo+IC0tLS0tIFVy
c3Byw7xuZ2xpY2hlIE1haWwgLS0tLS0KPj4gVm9uOiAiR3VpbGhlcm1lIEcuIFBpY2NvbGkiIDxn
cGljY29saUBpZ2FsaWEuY29tPgo+PiBPbiAxOS8wOC8yMDIyIDE5OjE3LCBHdWlsaGVybWUgRy4g
UGljY29saSB3cm90ZToKPj4+IEN1cnJlbnRseSB0aGUgcGFuaWMgbm90aWZpZXJzIGZyb20gdXNl
ciBtb2RlIGxpbnV4IGRvbid0IGZvbGxvdwo+Pj4gdGhlIGNvbnZlbnRpb24gZm9yIG1vc3Qgb2Yg
dGhlIG90aGVyIG5vdGlmaWVycyBwcmVzZW50IGluIHRoZQo+Pj4ga2VybmVsIChpbmRlbnRhdGlv
biwgcHJpb3JpdHkgc2V0dGluZywgbnVtZXJpYyByZXR1cm4pLgo+Pj4gTW9yZSBpbXBvcnRhbnQs
IHRoZSBwcmlvcml0aWVzIGNvdWxkIGJlIGltcHJvdmVkLCBzaW5jZSBpdCdzIGEKPj4+IHNwZWNp
YWwgY2FzZSAodXNlcnNwYWNlKSwgaGVuY2Ugd2UgY291bGQgcnVuIHRoZSBub3RpZmllcnMgZWFy
bGllcjsKPj4+IHVzZXIgbW9kZSBsaW51eCBzaG91bGRuJ3QgY2FyZSBtdWNoIHdpdGggb3RoZXIg
cGFuaWMgbm90aWZpZXJzIGJ1dAo+Pj4gdGhlIG9yZGVyaW5nIGFtb25nIHRoZSBtY29uc29sZSBh
bmQgYXJjaCBub3RpZmllciBpcyBpbXBvcnRhbnQsCj4+PiBnaXZlbiB0aGF0IHRoZSBhcmNoIG9u
ZSBlZmZlY3RpdmVseSB0cmlnZ2VycyBhIGNvcmUgZHVtcC4KPj4+Cj4+PiBGaXggdGhhdCBieSBy
dW5uaW5nIHRoZSBtY29uc29sZSBub3RpZmllciBhcyB0aGUgZmlyc3QgcGFuaWMKPj4+IG5vdGlm
aWVyLCBmb2xsb3dlZCBieSB0aGUgYXJjaGl0ZWN0dXJlIG9uZSAodGhhdCBjb3JlZHVtcHMpLgo+
Pj4KPj4+IENjOiBBbnRvbiBJdmFub3YgPGFudG9uLml2YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+
Cj4+PiBDYzogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4KPj4+IENj
OiBSaWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0Pgo+Pj4gU2lnbmVkLW9mZi1ieTog
R3VpbGhlcm1lIEcuIFBpY2NvbGkgPGdwaWNjb2xpQGlnYWxpYS5jb20+Cj4+Pgo+Pj4gVjM6Cj4+
PiAtIE5vIGNoYW5nZXMuCj4+PiBbLi4uXQo+Pgo+PiBIaSBKb2hhbm5lcywgc29ycnkgZm9yIHRo
ZSBwaW5nLiBEbyB5b3UgdGhpbmsgeW91IGNvdWxkIHBpY2sgdGhpcyBvbmU/Cj4+IE9yIGlmIHlv
dSBwcmVmZXIsIEkgY2FuIHJlc2VuZCBpdCBhbG9uZSAobm90IGluIHRoZSBzZXJpZXMpIC0gbGV0
IG1lCj4+IGtub3cgeW91ciBwcmVmZXJlbmNlLgo+IAo+IFRoaXMgcGF0Y2ggaXMgb24gbXkgVE9E
TyBsaXN0Lgo+IEp1c3QgaGFkIG5vIGNoYW5jZSB0byB0ZXN0IGl0Lgo+IAo+IFRoYW5rcywKPiAv
L3JpY2hhcmQKCkhpIFJpY2hhcmQgLyBKb2hhbm5lcywgaXMgdGhlcmUgYW55IG5ld3Mgb24gdGhp
cyBvbmU/ClRoYW5rcyBpbiBhZHZhbmNlLAoKCkd1aWxoZXJtZQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9rZXhlYwo=
