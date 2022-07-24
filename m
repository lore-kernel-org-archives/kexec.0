Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27891C433EF
	for <kexec@archiver.kernel.org>; Sun, 24 Jul 2022 02:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tZXS/gMiR06pU1b8K4HEJvNQ+xKBhiuyXrEz+PiNdm8=; b=YZlriUlixw2DpXxqfyx/8g/mzS
	mpYF7aDOOapVQ/+0/jf2zsulH2h2JkJppU6NQLjtg8S41jzk8MQfwElGHzhweKzL86cgUtbijq9Iv
	3+rMKzlluiKx7PxjjqJmizwwZSKkM6jyBm+j/jooCNqbqeDzjUEH7dzM5AVj/tEm3/n+Nse0Sx8Au
	uj6kyYyqj3Hc0VTSymcEt69hMFAeQTyGGpwgI/sG1+yqp+e1vnvtnEdzQmN3h9i3aj6MF5uVGEOvV
	yE+dWIdkKz9oIdcTPzoXz8rVy5lT1fT4JCFewp1+2ITQbn+R2ymmvRse/Y0ielCfLTX2Ln1RaCFBS
	I4tbItqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFRVf-00AYag-CF; Sun, 24 Jul 2022 02:38:23 +0000
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFRVY-00AYTY-2Z; Sun, 24 Jul 2022 02:38:19 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VKC1zl0_1658630286;
Received: from 192.168.1.4(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VKC1zl0_1658630286)
          by smtp.aliyun-inc.com;
          Sun, 24 Jul 2022 10:38:08 +0800
Subject: Re: [Crash-utility] [PATCH 0/5] Fixups to work with crash tool
To: Dave Young <dyoung@redhat.com>,
 "Discussion list for crash utility usage, maintenance and development"
 <crash-utility@redhat.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 anup@brainfault.org, heiko@sntech.de, guoren@kernel.org, mick@ics.forth.gr,
 alexandre.ghiti@canonical.com, huanyi.xj@alibaba-inc.com,
 hschauhan@nulltrace.org, linux-kernel@vger.kernel.org,
 heinrich.schuchardt@canonical.com, linux-riscv@lists.infradead.org,
 kexec@lists.infradead.org
References: <20220717101323.370245-1-xianting.tian@linux.alibaba.com>
 <CALu+AoTpiQh7NUJJZs+6A7MCUNWJq=NeSimoF=AVHpRptd36eA@mail.gmail.com>
From: tianxianting <xianting.tian@linux.alibaba.com>
Message-ID: <afbf1692-9942-b337-4195-a38c0cba793e@linux.alibaba.com>
Date: Sun, 24 Jul 2022 10:38:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CALu+AoTpiQh7NUJJZs+6A7MCUNWJq=NeSimoF=AVHpRptd36eA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220723_193816_312892_60B4E41A 
X-CRM114-Status: GOOD (  17.05  )
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

CuWcqCAyMDIyLzcvMjIg5LiL5Y2INDoxMywgRGF2ZSBZb3VuZyDlhpnpgZM6Cj4gSGksCj4KPiBP
biBTdW4sIDE3IEp1bCAyMDIyIGF0IDE4OjEzLCBYaWFudGluZyBUaWFuCj4gPHhpYW50aW5nLnRp
YW5AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+PiBJIGV2ZXIgc2VudCB0aGUgcGF0Y2ggMSwy
IGluIHRoZSBsaW5rOgo+PiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGlu
dXgtcmlzY3YvcGF0Y2gvMjAyMjA3MDgwNzMxNTAuMzUyODMwLTIteGlhbnRpbmcudGlhbkBsaW51
eC5hbGliYWJhLmNvbS8KPj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xp
bnV4LXJpc2N2L3BhdGNoLzIwMjIwNzA4MDczMTUwLjM1MjgzMC0zLXhpYW50aW5nLnRpYW5AbGlu
dXguYWxpYmFiYS5jb20vCj4+IEFuZCBwYXRjaCAzLDQgaW4gdGhlIGxpbms6Cj4+IGh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1yaXNjdi9wYXRjaC8yMDIyMDcxNDEx
MzMwMC4zNjc4NTQtMi14aWFudGluZy50aWFuQGxpbnV4LmFsaWJhYmEuY29tLwo+PiBodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtcmlzY3YvcGF0Y2gvMjAyMjA3MTQx
MTMzMDAuMzY3ODU0LTMteGlhbnRpbmcudGlhbkBsaW51eC5hbGliYWJhLmNvbS8KPj4KPj4gVGhp
cyBwYXRjaCBzZXJpZXMganVzdCBwdXQgdGhlc2UgcGF0Y2hlcyB0b2dldGhlciwgYW5kIHdpdGgg
YSBuZXcgcGF0Y2ggNS4KPj4gdGhlc2UgZml2ZSBwYXRjaGVzIGFyZSB0aGUgZml4dXBzIGZvciBr
ZXhlYywgdm1jb3JlIGFuZCBpbXByb3ZlbWVudHMKPj4gZm9yIHZtY29yZWluZm8gYW5kIG1lbW9y
eSBsYXlvdXQgZHVtcC4KPj4KPj4gVGhlIG1haW4gY2hhbmdlcyBpbiB0aGUgZml2ZSBwYXRjaHMg
YXMgYmVsb3csCj4+IFBhdGNoIDE6IEFkZCBhIGZhc3QgY2FsbCBwYXRoIG9mIGNyYXNoX2tleGVj
KCkgYXMgb3RoZXIgQXJjaCh4ODYsIGFybTY0KSBkby4KPj4gUGF0Y2ggMjogdXNlIF9fc21wX3By
b2Nlc3Nvcl9pZCgpIGluc3RlYWQgb2Ygc21wX3Byb2Nlc3Nvcl9pZCgpIHRvIGNsZWFudXAKPj4g
ICAgICAgICAgIHRoZSBjb25zb2xlIHByaW50cy4KPj4gUGF0Y2ggMzogQWRkIFZNIGxheW91dCwg
dmEgYml0cywgcmFtIGJhc2UgdG8gdm1jb3JlaW5mbywgd2hpY2ggY2FuIHNpbXBsaWZ5Cj4+ICAg
ICAgICAgICB0aGUgZGV2ZWxvcG1lbnQgb2YgY3Jhc2ggdG9vbCBhcyBBUk02NCBhbHJlYWR5IGRp
ZAo+PiAgICAgICAgICAgKGFyY2gvYXJtNjQva2VybmVsL2NyYXNoX2NvcmUuYykuCj4+IFBhdGNo
IDQ6IEFkZCBtb2R1bGVzIHRvIHZpcnR1YWwga2VybmVsIG1lbW9yeSBsYXlvdXQgZHVtcC4KPj4g
UGF0Y2ggNTogRml4dXAgdG8gZ2V0IGNvcnJlY3Qga2VybmVsIG1vZGUgUEMgZm9yIHZtY29yZQo+
Pgo+PiBXaXRoIHRoZXNlIDUgcGF0Y2hlcyhwYXRjaCAzIGlzIG11c3QpLCBjcmFzaCB0b29sIGNh
biB3b3JrIHdlbGwgdG8gYW5hbHl6ZQo+PiBhIHZtY29yZS4gVGhlIHBhdGNoZXMgZm9yIGNyYXNo
IHRvb2wgZm9yIFJJU0NWNjQgaXMgaW4gdGhlIGxpbms6Cj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LXJpc2N2LzIwMjIwNzE3MDQyOTI5LjM3MDAyMi0xLXhpYW50aW5nLnRpYW5AbGlu
dXguYWxpYmFiYS5jb20vCj4+Cj4+IFhpYW50aW5nIFRpYW4gKDUpOgo+PiAgICBSSVNDLVY6IEZp
eHVwIGZhc3QgY2FsbCBvZiBjcmFzaF9rZXhlYygpCj4+ICAgIFJJU0MtVjogdXNlIF9fc21wX3By
b2Nlc3Nvcl9pZCgpIGluc3RlYWQgb2Ygc21wX3Byb2Nlc3Nvcl9pZCgpCj4+ICAgIFJJU0MtVjog
QWRkIGFyY2hfY3Jhc2hfc2F2ZV92bWNvcmVpbmZvIHN1cHBvcnQKPiBWbWNvcmVpbmZvIGNoYW5n
ZXMgbmVlZCB0byBiZSBkb2N1bWVudGVkIGluCj4gRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9r
ZHVtcC92bWNvcmVpbmZvLnJzdAo+Cj4gT3RoZXJ3aXNlLCBJIHN1Z2dlc3QgdG8gYWx3YXlzIGNj
IGtleGVjIG1haWwgbGlzdCAoYWRkZWQgaW4gY2MpIGZvcgo+IGtleGVjIHwga2R1bXAgcGF0Y2hl
cy4KPgo+IHRoYW5rcywgSSB3aWxsIGZpeCBpdCBpbiB2My4KPj4gICAgcmlzY3Y6IEFkZCBtb2R1
bGVzIHRvIHZpcnR1YWwga2VybmVsIG1lbW9yeSBsYXlvdXQgZHVtcAo+PiAgICBSSVNDLVY6IEZp
eHVwIGdldHRpbmcgY29ycmVjdCBjdXJyZW50IHBjCj4+Cj4+ICAgYXJjaC9yaXNjdi9rZXJuZWwv
TWFrZWZpbGUgICAgICAgICAgfCAgMSArCj4+ICAgYXJjaC9yaXNjdi9rZXJuZWwvY3Jhc2hfY29y
ZS5jICAgICAgfCAyOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+PiAgIGFyY2gvcmlz
Y3Yva2VybmVsL2NyYXNoX3NhdmVfcmVncy5TIHwgIDIgKy0KPj4gICBhcmNoL3Jpc2N2L2tlcm5l
bC9tYWNoaW5lX2tleGVjLmMgICB8ICAyICstCj4+ICAgYXJjaC9yaXNjdi9rZXJuZWwvdHJhcHMu
YyAgICAgICAgICAgfCAgNCArKysrCj4+ICAgYXJjaC9yaXNjdi9tbS9pbml0LmMgICAgICAgICAg
ICAgICAgfCAgNCArKysrCj4+ICAgNiBmaWxlcyBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2tlcm5lbC9j
cmFzaF9jb3JlLmMKPj4KPj4gLS0KPj4gMi4xNy4xCj4+Cj4+IC0tCj4+IENyYXNoLXV0aWxpdHkg
bWFpbGluZyBsaXN0Cj4+IENyYXNoLXV0aWxpdHlAcmVkaGF0LmNvbQo+PiBodHRwczovL2xpc3Rt
YW4ucmVkaGF0LmNvbS9tYWlsbWFuL2xpc3RpbmZvL2NyYXNoLXV0aWxpdHkKPj4gQ29udHJpYnV0
aW9uIEd1aWRlbGluZXM6IGh0dHBzOi8vZ2l0aHViLmNvbS9jcmFzaC11dGlsaXR5L2NyYXNoL3dp
a2kKPj4KPiBUaGFua3MKPiBEYXZlCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
