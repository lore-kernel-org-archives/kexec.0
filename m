Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28DBC10F09
	for <kexec@archiver.kernel.org>; Mon, 11 Dec 2023 09:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0fKPxTmAjd1qTcGhl2v4JvqATxMa2/SSkQG0EuM8Ieg=; b=z5CP5AVtfz/Zcq
	t9nLF4g2qDpKc/+/wRy6Xww65XmyaoZDYiYqFD6PaDwhtR+UyH20u0jyiONMoYvXM67JweJ2oa5d7
	hxWOCOYBg+ZNOUp7F9DzyRMNK/W32KNV8thtcyDkRcnC76C1M/o3S1mRqv+PfqUc079d3P7tJ3SMG
	ddX7nP/AmYnGaMaUNDP2VarQFPh4Oe7nqwQw7SkBYHWW/0iLZe01Mdxv/8bSqCZUFqxWfkslXkmtO
	QKYpzfd3vlJQjfjgi8T5YXXCqX5UItDYqK0jmeamuKLIeciDUF8KbcyAbvshUIYAC17tP7bLuELNy
	n9OK9IAc6Ge3ysqVCosA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCcJI-004QZv-0D;
	Mon, 11 Dec 2023 09:10:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCcJD-004QYl-0M
	for kexec@lists.infradead.org;
	Mon, 11 Dec 2023 09:10:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702285838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X3H2rKzNGhPd5aG+amaV+RsXWG/q4mDryaGgazG1R5k=;
	b=ZfcDidRjrzvFfdbjheK3+ZyrTiEETSglFMtL+PLuKBSWZ1zQYv5bnd5MoSQ7pyONfA4WdY
	zav9m7De9D6jnkqzfJF7RA+6iSP3wz/PmDM3+eNVCf6x4TRMNKjzgCSFwNtwyHK+IG1ZhM
	Xwd8BOpoys+Y+wmy3LlX9otCLNUKmQQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-7k3BtasXNIGeNUyNQiTfDg-1; Mon, 11 Dec 2023 04:10:34 -0500
X-MC-Unique: 7k3BtasXNIGeNUyNQiTfDg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F258833944;
	Mon, 11 Dec 2023 09:10:33 +0000 (UTC)
Received: from localhost (unknown [10.72.112.218])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B74A11C060AF;
	Mon, 11 Dec 2023 09:10:32 +0000 (UTC)
Date: Mon, 11 Dec 2023 17:10:29 +0800
From: Baoquan He <bhe@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	loongarch@lists.linux.dev, kexec@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-sh@vger.kernel.org, x86@kernel.org, akpm@linux-foundation.org,
	eric_devolder@yahoo.com, sfr@canb.auug.org.au, ignat@cloudflare.com
Subject: Re: [PATCH 0/5] kexec: fix the incorrect ifdeffery and dependency of
 CONFIG_KEXEC
Message-ID: <ZXbSBdalhEWPtUn0@MiWiFi-R3L-srv>
References: <20231208073036.7884-1-bhe@redhat.com>
 <ZXLI748b85be459B@fedora>
 <CAMuHMdWAaM+eJtiVbXXBO0xOmpqhrOiCO5itNsNdTiOxRXVtVw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdWAaM+eJtiVbXXBO0xOmpqhrOiCO5itNsNdTiOxRXVtVw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231211_011039_239660_02CDB4F3 
X-CRM114-Status: GOOD (  19.47  )
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

T24gMTIvMTEvMjMgYXQgMDk6MjVhbSwgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOgo+IEhpIEJh
b3F1YW4sCj4gCj4gT24gRnJpLCBEZWMgOCwgMjAyMyBhdCA4OjQz4oCvQU0gQmFvcXVhbiBIZSA8
YmhlQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gRm9yZ290IGFkZGluZyBrZXhlYyB0byBDQywgYWRk
IGl0IG5vdy4KPiA+Cj4gPiBPbiAxMi8wOC8yMyBhdCAwMzozMHBtLCBCYW9xdWFuIEhlIHdyb3Rl
Ogo+ID4gPiBUaGUgc2VsZWN0IG9mIEtFWEVDIGZvciBDUkFTSF9EVU1QIGluIGtlcm5lbC9LY29u
ZmlnLmtleGVjIHdpbGwgYmUKPiA+ID4gZHJvcHBlZCwgdGhlbiBjb21waWxpbmcgZXJyb3JzIHdp
bGwgYmUgdHJpZ2dlcmVkIGlmIGJlbG93IGNvbmZpZwo+ID4gPiBpdGVtcyBhcmUgc2V0Ogo+ID4g
Pgo+ID4gPiA9PT0KPiA+ID4gQ09ORklHX0NSQVNIX0NPUkU9eQo+ID4gPiBDT05GSUdfS0VYRUNf
Q09SRT15Cj4gPiA+IENPTkZJR19DUkFTSF9EVU1QPXkKPiA+ID4gPT09Cj4gPiA+Cj4gPiA+IEUu
ZyBvbiBtaXBzLCBiZWxvdyBsaW5rIGVycm9yIGFyZSBzZWVuOgo+ID4gPiAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+
ID4gPiBtaXBzZWwtbGludXgtbGQ6IGtlcm5lbC9rZXhlY19jb3JlLm86IGluIGZ1bmN0aW9uIGBr
aW1hZ2VfZnJlZSc6Cj4gPiA+IGtlcm5lbC9rZXhlY19jb3JlLmM6KC50ZXh0KzB4MjIwMCk6IHVu
ZGVmaW5lZCByZWZlcmVuY2UgdG8gYG1hY2hpbmVfa2V4ZWNfY2xlYW51cCcKPiA+ID4gbWlwc2Vs
LWxpbnV4LWxkOiBrZXJuZWwva2V4ZWNfY29yZS5vOiBpbiBmdW5jdGlvbiBgX19jcmFzaF9rZXhl
Yyc6Cj4gPiA+IGtlcm5lbC9rZXhlY19jb3JlLmM6KC50ZXh0KzB4MjQ4MCk6IHVuZGVmaW5lZCBy
ZWZlcmVuY2UgdG8gYG1hY2hpbmVfY3Jhc2hfc2h1dGRvd24nCj4gPiA+IG1pcHNlbC1saW51eC1s
ZDoga2VybmVsL2tleGVjX2NvcmUuYzooLnRleHQrMHgyNDg4KTogdW5kZWZpbmVkIHJlZmVyZW5j
ZSB0byBgbWFjaGluZV9rZXhlYycKPiA+ID4gbWlwc2VsLWxpbnV4LWxkOiBrZXJuZWwva2V4ZWNf
Y29yZS5vOiBpbiBmdW5jdGlvbiBga2VybmVsX2tleGVjJzoKPiA+ID4ga2VybmVsL2tleGVjX2Nv
cmUuYzooLnRleHQrMHgyOWI4KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgbWFjaGluZV9zaHV0
ZG93bicKPiA+ID4gbWlwc2VsLWxpbnV4LWxkOiBrZXJuZWwva2V4ZWNfY29yZS5jOigudGV4dCsw
eDI5YzApOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBtYWNoaW5lX2tleGVjJwo+ID4gPiAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQo+ID4gPgo+ID4gPiBIZXJlLCBjaGFuZ2UgdGhlIGluY29ycmVjdCBkZXBlbmRlbmN5
IG9mIGJ1aWxkaW5nIGtleGVjX2NvcmUgcmVsYXRlZCBvYmplY3QKPiA+ID4gZmlsZXMsIGFuZCB0
aGUgaWZkZWZmZXJ5IG9uIGFyY2hpdGVjdHVyZXMgZnJvbSBDT05GSUdfS0VYRUMgdG8KPiA+ID4g
Q09ORklHX0tFWEVDX0NPUkUuCj4gPiA+Cj4gPiA+IFRlc3Rpbmc6Cj4gPiA+ID09PT09PT09Cj4g
PiA+IFBhc3NlZCBvbiBtaXBzIGFuZCBsb29nbmFyY2ggd2l0aCB0aGUgTEtQIHJlcHJvZHVjZXIu
Cj4gPiA+Cj4gPiA+IEJhb3F1YW4gSGUgKDUpOgo+ID4gPiAgIGxvb25nYXJjaCwga2V4ZWM6IGNo
YW5nZSBkZXBlbmRlbmN5IG9mIG9iamVjdCBmaWxlcwo+ID4gPiAgIG02OGssIGtleGVjOiBmaXgg
dGhlIGluY29ycmVjdCBpZmRlZmZlcnkgYW5kIGJ1aWxkIGRlcGVuZGVuY3kgb2YKPiA+ID4gICAg
IENPTkZJR19LRVhFQwo+ID4gPiAgIG1pcHMsIGtleGVjOiBmaXggdGhlIGluY29ycmVjdCBpZmRl
ZmZlcnkgYW5kIGRlcGVuZGVuY3kgb2YKPiA+ID4gICAgIENPTkZJR19LRVhFQwo+ID4gPiAgIHNo
LCBrZXhlYzogZml4IHRoZSBpbmNvcnJlY3QgaWZkZWZmZXJ5IGFuZCBkZXBlbmRlbmN5IG9mIENP
TkZJR19LRVhFQwo+ID4gPiAgIHg4Niwga2V4ZWM6IGZpeCB0aGUgd3JvbmcgaWZkZWZmZXJ5IENP
TkZJR19LRVhFQwo+IAo+IEkgdW5kZXJzdGFuZCB0aGlzIHNlcmllcyBpcyB2MyBvZiAiW1BBVENI
IHYyXSBrZXhlY19jb3JlOiBjaGFuZ2UKPiBkZXBlbmRlbmN5IG9mIG9iamVjdCBmaWxlcyI/IEFz
IHRoaXMgc2VyaWVzIGRvZXMgbm90IGNvbnRhaW4gYQo+IGNoYW5nZWxvZywgY2FuIHlvdSBwbGVh
c2Ugc3VtbWFyaXplIHdoYXQgd2FzIGNoYW5nZWQ/Cj4gVGhhbmtzIQoKT2gsIHNvcnJ5IGZvciB0
aGUgY29uZnVzaW9uLgoKWW91IGFyZSByaWdodCwgSSBzaG91bGQgaGF2ZSB0YWtlbiB0aGlzIGFz
IHYzIGFuZCBwb3N0ZWQgdG8gYXZvaWQKY29uZnVzaW9uLgoKSSBhZGQgYmVsb3cgY2hhbmdlIGxv
ZyBmb3IgdGhpcyBzZXJpZXMsIG5vdCBzdXJlIGlmIGl0J3MgY2xlYXJlciB0aGFuCmJlZm9yZS4g
RS5nIGZvciBtNjhrLCB0aGUgPGFzbS9rZXhlYy5oPiBpcyBpbmNsdWRlZCBpbiA8bGludXgva2V4
ZWMuaD4uClRoZSBvbGQgaWZkZWZmZXJ5IENPTkZJR19LRVhFQyB3aWxsIGNhdXNlIHRob3NlIGRl
ZmluaXRpb25zIGluCmFzbS9rZXhlYy5oIHVuc2VlbiBpZiBDT05GSUdfS0VYRUMgaXMgdW5zZXQu
IFNlZQpLRVhFQ19TT1VSQ0VfTUVNT1JZX0xJTUlULCBpdCdzIG5lZWRlZCBpbiBrZXJuZWwva2V4
ZWNfY29yZS5jLgoKQ2hhbmdlbG9nOgotLS0tLS0tLS0tLS0KdjItPnYzOgotIENoYW5nZSB0aGUg
aW5jb3JyZWN0IGlmZGVmZmVyeSBDT05GSUdfS0VYRUMgaW4gYXJjaC4gU2luY2Ugc2VsZWN0IG9m
CiAgS0VYRUMgZm9yIENSQVNIX0RVTVAgaW4ga2VybmVsL0tjb25maWcua2V4ZWMgaXMgZHJvcHBl
ZCwgcGVvcGxlIGNhbgogIHNldCBiZWxvdyBjb25maWcgaXRlbXMgZGVwZW5kZW50bHkgb2YgQ09O
RklHX0tFWEVDLiBUaGVuIHRob3NlCiAgS0VYRUNfQ09SRSBvciBDUkFTSF9DT1JFIHJlbGF0ZWQg
Y29kZXMgY29tcGlsaW5nIHdpbGwgcmVwb3J0IGVycm9yLgoKICA9PT0KICBDT05GSUdfQ1JBU0hf
Q09SRT15CiAgQ09ORklHX0tFWEVDX0NPUkU9eQogIENPTkZJR19DUkFTSF9EVU1QPXkKICA9PT0K
LSBDaGFuZ2UgdGhlIGluY29ycmVjdCBpZmRlZmZlcnkgQ09ORklHX0tFWEVDIGluIGdldF9jbWRs
aW5lX2FjcGlfcnNkcCgpCiAgb2YgeDg2IGJlY2F1c2Uga2V4ZWNfZmlsZV9sb2FkIG5lZWRzIHRo
YXQgdG9vLgoKdjEtPnYyOgotIFYxIG9ubHkgaW5jbHVkZXMgZml4IG9uIGxvb25nYXJjaC4gQWRk
IG02OGssIG1pcHMsIHNoIGZpeCBpbiB2MiB0b28uCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9r
ZXhlYwo=
