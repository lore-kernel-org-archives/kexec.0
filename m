Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C91E95A91
	for <kexec@archiver.kernel.org>; Mon,  9 Oct 2023 15:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:
	In-Reply-To:Date:References:Cc:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=tYXjU/CU6MyXQT+foX3rKG+N5Ph5MtVTjEJQjFp4kaU=; b=RXbrs+yx/7+j6kCTv33EfFaV6B
	MyFiG1mPWR2Vuucz9kmy6oQ29iB2ogRLmzFQpa+JiKPt/HCCWkrASKR9TaJwzQzTmcUyUTUNLTFXn
	zxCv3aJdcJ5zZrS8Uv2Te8wuOXh9XrxMBIN626ShniVWS1BxRdrlFNKWHrTwVQRPj4KFdoYQfruzB
	E9l6Hrb3HVUeXl4dETKDV7C0KlBonacle44oYoSQjmORsMxcviKykEkKu5nG8enJxtHLA4mNiPfsX
	ANxVYjSYWyskJ6PoCOG4gx4TbOxv/5jVdFBrZEaxrRRIL1pEBfQvXFr/qrdCMkGFTx+xMvnJY/OMm
	7GHWuoTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qpsDr-00B3eS-2L;
	Mon, 09 Oct 2023 15:31:07 +0000
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qpsDp-00B3cA-0S
	for kexec@lists.infradead.org;
	Mon, 09 Oct 2023 15:31:06 +0000
Received: from in01.mta.xmission.com ([166.70.13.51]:38198)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1qpsDU-0060Yb-3i; Mon, 09 Oct 2023 09:30:44 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:38624 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1qpsDQ-007a4Q-RL; Mon, 09 Oct 2023 09:30:43 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org,  Steven Rostedt <rostedt@goodmis.org>,
  Ricardo Ribalda <ribalda@google.com>,  Ross Zwisler <zwisler@google.com>,
  Rob Clark <robdclark@gmail.com>,  Linus Torvalds
 <torvalds@linux-foundation.org>,  kexec@lists.infradead.org
References: <20230929021213.2364883-1-joel@joelfernandes.org>
	<87bkdl55qm.fsf@email.froward.int.ebiederm.org>
	<CAEXW_YQ=HGok600ARtCKBNDs1OHSc=UM4hWmBdQ=sXZvif0Z5g@mail.gmail.com>
	<CAEXW_YQ3YZExYb6FLg3fvWr9K+FGgNQx7xk3p-PngLG6rt8Ntw@mail.gmail.com>
Date: Mon, 09 Oct 2023 10:21:04 -0500
In-Reply-To: <CAEXW_YQ3YZExYb6FLg3fvWr9K+FGgNQx7xk3p-PngLG6rt8Ntw@mail.gmail.com>
	(Joel Fernandes's message of "Sat, 7 Oct 2023 21:30:42 -0400")
Message-ID: <87il7fzusf.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1qpsDQ-007a4Q-RL;;;mid=<87il7fzusf.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/05uh69me2MdpVapboGWSZ9mJiUasho74=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] kexec: Fix reboot race during device_shutdown()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231009_083105_177784_5C7A7B79 
X-CRM114-Status: GOOD (  20.47  )
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

Sm9lbCBGZXJuYW5kZXMgPGpvZWxAam9lbGZlcm5hbmRlcy5vcmc+IHdyaXRlczoKCj4gT24gTW9u
LCBPY3QgMiwgMjAyMyBhdCAyOjE44oCvUE0gSm9lbCBGZXJuYW5kZXMgPGpvZWxAam9lbGZlcm5h
bmRlcy5vcmc+IHdyb3RlOgo+IFsuLl0KPj4gPiA+IFN1Y2ggZnJlZXppbmcgaXMgYWxyZWFkeSBi
ZWluZyBkb25lIGlmIGtlcm5lbCBzdXBwb3J0cyBLRVhFQ19KVU1QIGFuZAo+PiA+ID4ga2V4ZWNf
aW1hZ2UtPnByZXNlcnZlX2NvbnRleHQgaXMgdHJ1ZS4gSG93ZXZlciwgZG9pbmcgaXQgaWYgZWl0
aGVyIG9mIHRoZXNlIGFyZQo+PiA+ID4gbm90IHRydWUgcHJldmVudHMgY3Jhc2hlcy9yYWNlcy4K
Pj4gPgo+PiA+IFRoZSBLRVhFQ19KVU1QIGNhc2UgaXMgc29tZXRoaW5nIGVsc2UgZW50aXJlbHku
ICBJdCBpcyBzdXBwb3NlZCB0byB3b3JrCj4+ID4gbGlrZSBzdXNwZW5kIHRvIFJBTS4gIE1heWJl
IHJlYm9vdCBzaG91bGQgYXMgd2VsbCwgYnV0IEkgYW0KPj4gPiB1bmNvbWZvcnRhYmxlIG1ha2lu
ZyBhIGdlbmVyaWMgZGV2aWNlIGZpeCBrZXhlYyBzcGVjaWZpYy4KPj4KPj4gSSBzZWUgeW91ciBw
b2ludCBvZiB2aWV3LiBJIHRoaW5rIHJlZ3VsYXIgcmVib290IHNob3VsZCBhbHNvIGJlIGZpeGVk
Cj4+IHRvIGF2b2lkIHNpbWlsYXIgY3Jhc2ggcG9zc2liaWxpdGllcy4gSSBhbSBoYXBweSB0byBt
YWtlIGEgY2hhbmdlIGZvcgo+PiB0aGF0IHNpbWlsYXIgdG8gdGhpcyBwYXRjaCBpZiB3ZSB3YW50
IHRvIHByb2NlZWQgdGhhdCB3YXkuCj4+Cj4+IFRob3VnaHRzPwo+Cj4gSnVzdCBjaGVja2luZyBo
b3cgd2Ugd2FudCB0byBwcm9jZWVkLCBpcyB0aGUgY29uc2Vuc3VzIHRoYXQgd2Ugc2hvdWxkCj4g
cHJldmVudCBrZXJuZWwgY3Jhc2hlcyB3aXRob3V0IHJlbHlpbmcgb24gdXNlcnNwYWNlIHN0b3Bw
aW5nIGFsbAo+IHByb2Nlc3Nlcz8gU2hvdWxkIHdlIGZpeCByZWd1bGFyIHJlYm9vdCBzeXNjYWxs
IGFzIHdlbGwgYW5kIG5vdCBqdXN0Cj4ga2V4ZWMgcmVib290PwoKSXQganVzdCBvY2N1cnJlZCB0
byBtZSB0aGVyZSBpcyBzb21ldGhpbmcgdmVyeSBmaXNoeSBhYm91dCBhbGwgb2YgdGhpcy4KCldo
YXQgdXNlcnNwYWNlIGRvIHlvdSBoYXZlIHVzaW5nIGtleGVjIChub3Qga2V4ZWMgb24gcGFuaWMp
IHRoYXQgZG9lc24ndApwcmVmb3JtIHRoZSBzYW1lIHVzZXJzcGFjZSBzaHV0ZG93biBhcyBhIG5v
cm1hbCByZWJvb3Q/CgpRdWl0ZSBmcmFua2x5IHN1Y2ggYSB1c2Vyc3BhY2UgaXMgYnVnZ3ksIGFu
ZCBhcmd1YWJseSB0aGF0IGlzIHdoZXJlIHlvdQpzaG91bGQgc3RhcnQgZml4aW5nIHRoaW5ncy4g
IFRoYXQgd2F5IHlvdSBjYW4gZ2V0IHRoZSBvcmRlcmx5IHNodXRkb3duCm9mIHVzZXJzcGFjZSBk
YWVtb25zL3NlcnZpY2VzIGFsb25nIHdpdGggYW4gb3JkZXJseSBzaHV0ZG93biBvZgpldmVyeXRo
aW5nIHRoZSBrZXJuZWwgaXMgcmVzcG9uc2libGUgZm9yLgoKQXQgdGhlIGtlcm5lbCBsZXZlbCBh
IGtleGVjIHJlYm9vdCBhbmQgYSBub3JtYWwgcmVib290IGhhdmUgYmVlbgpkZWxpYmVyYXRlbHkg
a2VwdCBhcyBjbG9zZSBhcyBwb3NzaWJsZS4gIFdoaWNoIGlzIHdoeSBJIHNheSB3ZSBzaG91bGQK
Zml4IGl0IGluIHJlYm9vdC4KCkVyaWMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
