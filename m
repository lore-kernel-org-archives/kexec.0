Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88FDC433EF
	for <kexec@archiver.kernel.org>; Tue, 26 Jul 2022 08:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6PE3kMAAzWRRvdT2THgnBfnSFxMxjTGYEGhBlzxhWHQ=; b=Mu0ytdfSzSgHTStYhJ+fnL1+IF
	tD/X9kAzGm9DNcHvK3wk7K57XFBT9gw2CddOLbcEGWwAsSkQj+bOlVXFg+jkEnpIsCpewjSGd0ytJ
	qDOaCvgST/bl/XGxU7zcRA6NPVBRVR+7pgzmXxWmqiPTmYSmsT5XiUH6BOIYWUq+3SftD4WDKWvFh
	tdKuo+kpR8kiVZuDhDqb5LpEP3qEaR8hHAdD/fGcZR/sT5riUJ3QOLN6Y42j6UybcbzciVG8BunY7
	LfsKwfJRfIlOL1ybm4VPRFPIaL69ZR60AYwxEVfyZEMrcuR0HpDeXmebaRT21wHi6trjAe14eN0pH
	LvTcsNrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGFjp-00A1Cc-Uj; Tue, 26 Jul 2022 08:16:21 +0000
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGFjl-00A16G-Ct; Tue, 26 Jul 2022 08:16:19 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VKUXwnf_1658823370;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VKUXwnf_1658823370)
          by smtp.aliyun-inc.com;
          Tue, 26 Jul 2022 16:16:12 +0800
Subject: Re: [RESEND PATCH V2 0/5] Fixups to work with crash tool
To: Conor.Dooley@microchip.com
Cc: alexandre.ghiti@canonical.com, heiko@sntech.de, palmer@dabbelt.com,
 mick@ics.forth.gr, guoren@kernel.org, kexec@lists.infradead.org,
 bhe@redhat.com, linux-doc@vger.kernel.org, vgoyal@redhat.com,
 linux-riscv@lists.infradead.org, dyoung@redhat.com,
 linux-kernel@vger.kernel.org, crash-utility@redhat.com,
 huanyi.xj@alibaba-inc.com, heinrich.schuchardt@canonical.com,
 anup@brainfault.org, corbet@lwn.net, k-hagio-ab@nec.com,
 hschauhan@nulltrace.org, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
References: <20220725014539.1037627-1-xianting.tian@linux.alibaba.com>
 <51c97da7-422f-1b5b-03d3-dc36c9132c2a@microchip.com>
 <7a395f64-8ec7-e07f-e763-afc1f2611c75@linux.alibaba.com>
 <2301681f-361d-b85b-e255-3bf449ceeaa9@microchip.com>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <cf00c1f6-b043-a11e-f7a5-bed1e829cb73@linux.alibaba.com>
Date: Tue, 26 Jul 2022 16:16:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <2301681f-361d-b85b-e255-3bf449ceeaa9@microchip.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220726_011617_674111_C2F090D5 
X-CRM114-Status: UNSURE (   7.40  )
X-CRM114-Notice: Please train this message.
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

CuWcqCAyMDIyLzcvMjYg5LiL5Y2INDowMSwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20g5YaZ
6YGTOgo+IE9uIDI2LzA3LzIwMjIgMDg6NTQsIHRpYW54aWFudGluZyB3cm90ZToKPj4g5ZyoIDIw
MjIvNy8yNiDkuIrljYgxOjEzLCBDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSDlhpnpgZM6Cj4+
PiBUaGF0IHNhaWQsIHRoaXMgZG9lcyBub3QgYXBwbHkgdG8gcmlzY3YvZm9yLW5leHQ6Cj4+PiBi
NCBzaGF6YW0gMjAyMjA3MjUwMTQ1MzkuMTAzNzYyNy0xLXhpYW50aW5nLnRpYW5AbGludXguYWxp
YmFiYS5jb20KPj4+IEdyYWJiaW5nIHRocmVhZCBmcm9tIGxvcmUua2VybmVsLm9yZy9hbGwvMjAy
MjA3MjUwMTQ1MzkuMTAzNzYyNy0xLXhpYW50aW5nLnRpYW4lNDBsaW51eC5hbGliYWJhLmNvbS90
Lm1ib3guZ3oKPj4+IENoZWNraW5nIGZvciBuZXdlciByZXZpc2lvbnMgb24gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLwo+Pj4gQW5hbHl6aW5nIDYgbWVzc2FnZXMgaW4gdGhlIHRocmVhZAo+
Pj4gQ2hlY2tpbmcgYXR0ZXN0YXRpb24gb24gYWxsIG1lc3NhZ2VzLCBtYXkgdGFrZSBhIG1vbWVu
dC4uLgo+Pj4gLS0tCj4+PiAgwqDCoCBbUEFUQ0ggdjIgMS81XSBSSVNDLVY6IHVzZSBfX3NtcF9w
cm9jZXNzb3JfaWQoKSBpbnN0ZWFkIG9mIHNtcF9wcm9jZXNzb3JfaWQoKQo+Pj4gIMKgwqAgW1BB
VENIIHYyIDIvNV0gUklTQy1WOiBBZGQgYXJjaF9jcmFzaF9zYXZlX3ZtY29yZWluZm8gc3VwcG9y
dAo+Pj4gIMKgwqAgW1BBVENIIHYyIDMvNV0gcmlzY3Y6IEFkZCBtb2R1bGVzIHRvIHZpcnR1YWwg
a2VybmVsIG1lbW9yeSBsYXlvdXQgZHVtcAo+Pj4gIMKgwqAgW1BBVENIIHYyIDQvNV0gUklTQy1W
OiBGaXh1cCBnZXR0aW5nIGNvcnJlY3QgY3VycmVudCBwYwo+Pj4gIMKgwqAgW1BBVENIIHYyIDUv
NV0gcmlzY3Y6IGNyYXNoX2NvcmU6IEV4cG9ydCBrZXJuZWwgdm0gbGF5b3V0LCBwaHlzX3JhbV9i
YXNlCj4+PiAtLS0KPj4+IFRvdGFsIHBhdGNoZXM6IDUKPj4+IC0tLQo+Pj4gQXBwbHlpbmc6IFJJ
U0MtVjogdXNlIF9fc21wX3Byb2Nlc3Nvcl9pZCgpIGluc3RlYWQgb2Ygc21wX3Byb2Nlc3Nvcl9p
ZCgpCj4+PiBBcHBseWluZzogUklTQy1WOiBBZGQgYXJjaF9jcmFzaF9zYXZlX3ZtY29yZWluZm8g
c3VwcG9ydAo+Pj4gUGF0Y2ggZmFpbGVkIGF0IDAwMDIgUklTQy1WOiBBZGQgYXJjaF9jcmFzaF9z
YXZlX3ZtY29yZWluZm8gc3VwcG9ydAo+PiBwYXRjaCAyIGFwcGx5IGlzIE9LIGZvciBtZSwgSSBk
b24ndCBrbm93IHdoeSB5b3UgZmFpbGVkIDooCj4+IERvIHlvdSBoYXZlIG1vcmUgZGV0YWxzIGZv
ciB0aGlzPwo+Pgo+IFdoYXQgZGlkIHlvdSBhcHBseSBpdCB0bz8gSXQgZG9lcyBub3QgYXBwbHkg
Zm9yIG1lIHRvIHJpc2N2L2Zvci1uZXh0Ogo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L3Jpc2N2L2xpbnV4LmdpdC9sb2cvP2g9Zm9yLW5leHQKClRoaXMg
NSBwYXRjaGVzIGFyZSBiYXNlZCBvbiB0aGUgbWFzdGVyIGJyYW5jaCBvZiBiZWxvdyBnaXQ6Cgpo
dHRwczovL2tlcm5lbC5nb29nbGVzb3VyY2UuY29tL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90
b3J2YWxkcy9saW51eC5naXQKCiJnaXQgYW0gMDAwMi1SSVNDLVYtQWRkLWFyY2hfY3Jhc2hfc2F2
ZV92bWNvcmVpbmZvLXN1cHBvcnQucGF0Y2giIHRvIAp0aGlzIGdpdCBpcyBvayBmb3IgbWUuCgpB
bGwgaXMgY29ycmVjdD8KCj4KPiBUaGFua3MsCj4gQ29ub3IuCj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0Bs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8va2V4ZWMK
