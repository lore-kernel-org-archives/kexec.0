Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DD2CD8CB4
	for <kexec@archiver.kernel.org>; Tue, 10 Oct 2023 20:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9n763Aw/sqCGqOHEqlQZ2/HUZIHAXBSCc+9sp2ZXS4Q=; b=YVF8AMSuhoQdua
	X6mr1bKiutquHji97I3WVlvOx89DxtYWic0g1/YsG/RhZTlQ46ajxf/fnGARjsNAtb+UqnYJ4tO/S
	y9mW1bKBLm3xcel/QQzBxVGaLVhQnQDisvnJOh3wa1Q+bZcEwlTcm9QY3EDJ1a8+rF0rFkkJt8XuI
	bp8Gs2zZFrESxHppwRgus7pwyiOfwiBHUo+uG+p0+ogjc3SPZ1ZY+1aW3OaEuVkkwo34M+Rjjf/iP
	8TUFAwC4sD6I0hqJkbjkxW2AnWvl6MnA7aTJGQ3+rQkZHZ4OPZgEF8WpZCZe7+foyCe0EEkdMOwle
	7zkJc4SiYF/u+s2UtkFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqJUM-00E8BB-1y;
	Tue, 10 Oct 2023 20:37:58 +0000
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqJUJ-00E8A3-08
	for kexec@lists.infradead.org;
	Tue, 10 Oct 2023 20:37:57 +0000
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c1807f3400so2767261fa.1
        for <kexec@lists.infradead.org>; Tue, 10 Oct 2023 13:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1696970261; x=1697575061; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3GSefbd6ENM7iA2f/vLjLRcW91rVVOQzMA/Obez7bs=;
        b=hAepTB99bhbIJMtBJP8oqIS3pikKs3TAW52LjG+hmvl0jXUJjdx7zeP018GPsqGtXz
         DbC0EjPoMWhNWsYN5u/Y1/AHJx5RpBvJT1kjUh2p8KkcbQgdZCFEiZ1qqYWBUtSicHdJ
         pa6tg6H3edGOnmjU8CU5juJX8eIWZxSqCm0+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970261; x=1697575061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3GSefbd6ENM7iA2f/vLjLRcW91rVVOQzMA/Obez7bs=;
        b=kcLEve8w/32DfwMverVSlKmAeCMMdhqR75nFrY9/gIDMuWC8UZi7WC4Citgqbvapvv
         655UkiN8RLX5U57y2Pf78v3syaCIpvK1sM8cIIKbGj265YowCFX1Tctfizj3ms+VnLIg
         RLjrsN6YdOslq1IepYetS7LjH+uI6alaAFOz8gJw10c5063PJtDG9bHr8QZKYyOujSjF
         Ig5CW1XE19StiC4AflrrRyfW7ibqC8h2RCSVusWc14fPutopmzRx2/Jdg4/oxu2ICSBE
         FjywlYJ18xrlPp3doQjrz1npWydfOVbJoxvCUxlfj6Ng3ZYh6HYhJd6YUz4cgEitTDmM
         fW6A==
X-Gm-Message-State: AOJu0Yxj84ss7hHzmy2K3Srru0S6/9ho0mroGsLbtCa37RTxcSwHSqCM
	StWzPxzECr/QAtJ/3RIqLRXE6DYtQ/EcNClRno4rDQ==
X-Google-Smtp-Source: AGHT+IHui13Pk+tjY+AxTC5P7+ngD0nQWScasEWsguCbaOR+22w7HjXTffTWj2fFHBLPmjdeultcNbQ8mdrMVoxzpaM=
X-Received: by 2002:a2e:9347:0:b0:2c0:7d6:570b with SMTP id
 m7-20020a2e9347000000b002c007d6570bmr10671343ljh.26.1696970260872; Tue, 10
 Oct 2023 13:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230929021213.2364883-1-joel@joelfernandes.org>
 <87bkdl55qm.fsf@email.froward.int.ebiederm.org> <CAEXW_YQ=HGok600ARtCKBNDs1OHSc=UM4hWmBdQ=sXZvif0Z5g@mail.gmail.com>
 <CAEXW_YQ3YZExYb6FLg3fvWr9K+FGgNQx7xk3p-PngLG6rt8Ntw@mail.gmail.com> <87il7fzusf.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87il7fzusf.fsf@email.froward.int.ebiederm.org>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Tue, 10 Oct 2023 16:37:30 -0400
Message-ID: <CAEXW_YRv4Uqfn-9cQvDTRGNbCbC9s3jg+PP1-nqYP-DNO54R-w@mail.gmail.com>
Subject: Re: [PATCH] kexec: Fix reboot race during device_shutdown()
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Ricardo Ribalda <ribalda@google.com>, Ross Zwisler <zwisler@google.com>, Rob Clark <robdclark@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231010_133755_104576_528DF742 
X-CRM114-Status: GOOD (  28.83  )
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

T24gTW9uLCBPY3QgOSwgMjAyMyBhdCAxMTozMOKAr0FNIEVyaWMgVy4gQmllZGVybWFuIDxlYmll
ZGVybUB4bWlzc2lvbi5jb20+IHdyb3RlOgo+Cj4gSm9lbCBGZXJuYW5kZXMgPGpvZWxAam9lbGZl
cm5hbmRlcy5vcmc+IHdyaXRlczoKPgo+ID4gT24gTW9uLCBPY3QgMiwgMjAyMyBhdCAyOjE44oCv
UE0gSm9lbCBGZXJuYW5kZXMgPGpvZWxAam9lbGZlcm5hbmRlcy5vcmc+IHdyb3RlOgo+ID4gWy4u
XQo+ID4+ID4gPiBTdWNoIGZyZWV6aW5nIGlzIGFscmVhZHkgYmVpbmcgZG9uZSBpZiBrZXJuZWwg
c3VwcG9ydHMgS0VYRUNfSlVNUCBhbmQKPiA+PiA+ID4ga2V4ZWNfaW1hZ2UtPnByZXNlcnZlX2Nv
bnRleHQgaXMgdHJ1ZS4gSG93ZXZlciwgZG9pbmcgaXQgaWYgZWl0aGVyIG9mIHRoZXNlIGFyZQo+
ID4+ID4gPiBub3QgdHJ1ZSBwcmV2ZW50cyBjcmFzaGVzL3JhY2VzLgo+ID4+ID4KPiA+PiA+IFRo
ZSBLRVhFQ19KVU1QIGNhc2UgaXMgc29tZXRoaW5nIGVsc2UgZW50aXJlbHkuICBJdCBpcyBzdXBw
b3NlZCB0byB3b3JrCj4gPj4gPiBsaWtlIHN1c3BlbmQgdG8gUkFNLiAgTWF5YmUgcmVib290IHNo
b3VsZCBhcyB3ZWxsLCBidXQgSSBhbQo+ID4+ID4gdW5jb21mb3J0YWJsZSBtYWtpbmcgYSBnZW5l
cmljIGRldmljZSBmaXgga2V4ZWMgc3BlY2lmaWMuCj4gPj4KPiA+PiBJIHNlZSB5b3VyIHBvaW50
IG9mIHZpZXcuIEkgdGhpbmsgcmVndWxhciByZWJvb3Qgc2hvdWxkIGFsc28gYmUgZml4ZWQKPiA+
PiB0byBhdm9pZCBzaW1pbGFyIGNyYXNoIHBvc3NpYmlsaXRpZXMuIEkgYW0gaGFwcHkgdG8gbWFr
ZSBhIGNoYW5nZSBmb3IKPiA+PiB0aGF0IHNpbWlsYXIgdG8gdGhpcyBwYXRjaCBpZiB3ZSB3YW50
IHRvIHByb2NlZWQgdGhhdCB3YXkuCj4gPj4KPiA+PiBUaG91Z2h0cz8KPiA+Cj4gPiBKdXN0IGNo
ZWNraW5nIGhvdyB3ZSB3YW50IHRvIHByb2NlZWQsIGlzIHRoZSBjb25zZW5zdXMgdGhhdCB3ZSBz
aG91bGQKPiA+IHByZXZlbnQga2VybmVsIGNyYXNoZXMgd2l0aG91dCByZWx5aW5nIG9uIHVzZXJz
cGFjZSBzdG9wcGluZyBhbGwKPiA+IHByb2Nlc3Nlcz8gU2hvdWxkIHdlIGZpeCByZWd1bGFyIHJl
Ym9vdCBzeXNjYWxsIGFzIHdlbGwgYW5kIG5vdCBqdXN0Cj4gPiBrZXhlYyByZWJvb3Q/Cj4KPiBJ
dCBqdXN0IG9jY3VycmVkIHRvIG1lIHRoZXJlIGlzIHNvbWV0aGluZyB2ZXJ5IGZpc2h5IGFib3V0
IGFsbCBvZiB0aGlzLgo+Cj4gV2hhdCB1c2Vyc3BhY2UgZG8geW91IGhhdmUgdXNpbmcga2V4ZWMg
KG5vdCBrZXhlYyBvbiBwYW5pYykgdGhhdCBkb2Vzbid0Cj4gcHJlZm9ybSB0aGUgc2FtZSB1c2Vy
c3BhY2Ugc2h1dGRvd24gYXMgYSBub3JtYWwgcmVib290Pwo+Cj4gUXVpdGUgZnJhbmtseSBzdWNo
IGEgdXNlcnNwYWNlIGlzIGJ1Z2d5LCBhbmQgYXJndWFibHkgdGhhdCBpcyB3aGVyZSB5b3UKPiBz
aG91bGQgc3RhcnQgZml4aW5nIHRoaW5ncy4KCkl0IGlzIGEgc2ltcGxlIHVuaXQgdGVzdCB0aGF0
IHRlc3RzIGtleGVjIHN1cHBvcnQgYnkga2V4ZWMtcmVib290aW5nCnRoZSBrZXJuZWwuIEkgZG9u
J3QgdGhpbmsgU0lHU1RPUC9TSUdLSUxMJ2luZyBkdXJpbmcga2V4ZWMtcmVib290IGlzCmlkZWFs
IGJlY2F1c2UgaW4gYSByZWFsIHBhbmljLW9uLWtleGVjIHR5cGUgY3Jhc2gsIHRoYXQgbWF5IG5v
dCBoYXBwZW4KYW5kIHNvIGRvZXMgbm90IGVtdWxhdGUgdGhlIHJlYWwgd29ybGQgdGhhdCB3ZWxs
LiBJIHRoaW5rIHdlIHdhbnQgdGhlCmtleGVjLXJlYm9vdCB0byBkbyBhICpyZWJvb3QqIHdpdGhv
dXQgY3Jhc2hpbmcgdGhlIGtlcm5lbCB3aGlsZSBkb2luZwpzby4gUmljYXJkby9TdGV2ZSBjYW4g
Y2hpbWUgb24gd2hhdCB0aGV5IGZlZWwgYXMgd2VsbC4KCj4gVGhhdCB3YXkgeW91IGNhbiBnZXQg
dGhlIG9yZGVybHkgc2h1dGRvd24KPiBvZiB1c2Vyc3BhY2UgZGFlbW9ucy9zZXJ2aWNlcyBhbG9u
ZyB3aXRoIGFuIG9yZGVybHkgc2h1dGRvd24gb2YKPiBldmVyeXRoaW5nIHRoZSBrZXJuZWwgaXMg
cmVzcG9uc2libGUgZm9yLgoKRml4aW5nIGluIHVzZXJzcGFjZSBpcyBhbiBvcHRpb24gYnV0IHBl
b3BsZSBhcmUgbm90IGhhcHB5IHRoYXQgdGhlCmtlcm5lbCBjYW4gY3Jhc2ggbGlrZSB0aGF0LgoK
PiBBdCB0aGUga2VybmVsIGxldmVsIGEga2V4ZWMgcmVib290IGFuZCBhIG5vcm1hbCByZWJvb3Qg
aGF2ZSBiZWVuCj4gZGVsaWJlcmF0ZWx5IGtlcHQgYXMgY2xvc2UgYXMgcG9zc2libGUuICBXaGlj
aCBpcyB3aHkgSSBzYXkgd2Ugc2hvdWxkCj4gZml4IGl0IGluIHJlYm9vdC4KCllvdSBtZWFuIGZp
eCBpdCBpbiB1c2Vyc3BhY2U/Cgp0aGFua3MsCgogLSBKb2VsCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2tleGVjCg==
