Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07405CD6E7F
	for <kexec@archiver.kernel.org>; Wed, 11 Oct 2023 15:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=otpXjO6gJas7jq/N/MZV8yL1aOt98+qaDfgVYONFTVU=; b=Hk1xHe4CnEVSyh
	12s+15+zhGFu0D2BTZ/Y2xsZnS6gh46BFXTHMdexmnJPI6oLTqXcRh9yzI/J7T72mDOfAsqifRUea
	+dwCGMtu+4iedcg6SIaPa9igrgLs5N/Quu0w5nsAwcZo4b7dyMbDZR42Xi9MulQTuiPm5ZplVxtHW
	WXNOnTT0EbUqWWZDBiOoGz0c/gPfGlI677KN2c6BtJ18Z3tgu07xmx7v/uxzdq+BlXU4Hhpdxnl0u
	Pfm3GIjjYS+k9/ijqckBWktGilGW2x3B82UXXb4bBicqb6tVqbQoDfT6iukU1dLwHlcJk1Dafifd5
	DVMZ3c7Xl38R6yLZoPow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqbWR-00GDfp-2K;
	Wed, 11 Oct 2023 15:53:19 +0000
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqbWP-00GDeT-0x
	for kexec@lists.infradead.org;
	Wed, 11 Oct 2023 15:53:18 +0000
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c3ca6ff5a7so60295481fa.1
        for <kexec@lists.infradead.org>; Wed, 11 Oct 2023 08:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1697039589; x=1697644389; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHhDRJtv88GUtolhSfk/M6EnhLggiBTlRi1I9TUAYxE=;
        b=viaxMCyhk5hQHKZJ2fsSIrtvWQhJvPTkJDFdu6a9lTjOWtHtkz3CcDOD+PONyglGwC
         XjNa+De4MxbkbajS+45M8ESBIuY9Guk5HG2Q7Q6SphBJJR9nbS4tr6bPE27ioZe7R550
         /bD325kx5lm+iETZkE9k/522ft4KRiyuVGdfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697039589; x=1697644389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHhDRJtv88GUtolhSfk/M6EnhLggiBTlRi1I9TUAYxE=;
        b=NqJVvSFV82+HpZB8If57c5OUllgGaotavKYxrqwIaZC7Ufd91GF6V7FcuUVmAEepjU
         BXk7v1ARDXjQ7dpldrR6sVDCxeeOasYfTeqYMxxHgLMZmaNXYRQed2NPuTjGb+Efp31A
         dTkg1dk+RIMRREJI0bp59EctYqPHPB2eKgWU6Zgk9L0Oy7ANfqzX0yOZbqUW9MlQ6YkC
         CeC9MR3iY0KC+3LScg7w8H2yYUhehH752sxXTlm1NajeAHUFVPBoq9dUYeka8iwzdVZh
         o10mbwEAxSFAv+NB5f4WPKbUkZCtV0Q+b+fWIHyy0QZ/A6qbtWutqf2Qpvle+EkCEXPt
         UM/A==
X-Gm-Message-State: AOJu0YwdRplX/ilt/mtxOHWBL7uHcFcueYL1tN8n2XBeJV2D1aQP6Ylf
	57FQrue20VGw2Qfke+iHZvZD8A7lEhHTQK17/5GYnQ==
X-Google-Smtp-Source: AGHT+IFAHZaip1J9zeajKEpAb5YV3c9gzGgz3OmrihXxQNsyJWbI2IkKeT2npiPX4t/KAAzUr0Cb58QohVGr/xX8Hbc=
X-Received: by 2002:a2e:b781:0:b0:2c2:c38b:2141 with SMTP id
 n1-20020a2eb781000000b002c2c38b2141mr17098551ljo.49.1697039588905; Wed, 11
 Oct 2023 08:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230929021213.2364883-1-joel@joelfernandes.org>
 <87bkdl55qm.fsf@email.froward.int.ebiederm.org> <CAEXW_YQ=HGok600ARtCKBNDs1OHSc=UM4hWmBdQ=sXZvif0Z5g@mail.gmail.com>
 <CAEXW_YQ3YZExYb6FLg3fvWr9K+FGgNQx7xk3p-PngLG6rt8Ntw@mail.gmail.com>
 <87il7fzusf.fsf@email.froward.int.ebiederm.org> <CAEXW_YRv4Uqfn-9cQvDTRGNbCbC9s3jg+PP1-nqYP-DNO54R-w@mail.gmail.com>
 <87fs2ii3tf.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87fs2ii3tf.fsf@email.froward.int.ebiederm.org>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Wed, 11 Oct 2023 11:52:58 -0400
Message-ID: <CAEXW_YT4JrLaVg9iXdbny9o4DrhUN21WNGDfVNbwJCa-ZvUPOQ@mail.gmail.com>
Subject: Re: [PATCH] kexec: Fix reboot race during device_shutdown()
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Ricardo Ribalda <ribalda@google.com>, Ross Zwisler <zwisler@google.com>, Rob Clark <robdclark@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231011_085317_335276_49D4170D 
X-CRM114-Status: GOOD (  24.02  )
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

T24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgNTowOOKAr1BNIEVyaWMgVy4gQmllZGVybWFuIDxlYmll
ZGVybUB4bWlzc2lvbi5jb20+IHdyb3RlOgo+Cj4gSm9lbCBGZXJuYW5kZXMgPGpvZWxAam9lbGZl
cm5hbmRlcy5vcmc+IHdyaXRlczoKWy4uLl0KPiA+PiBUaGF0IHdheSB5b3UgY2FuIGdldCB0aGUg
b3JkZXJseSBzaHV0ZG93bgo+ID4+IG9mIHVzZXJzcGFjZSBkYWVtb25zL3NlcnZpY2VzIGFsb25n
IHdpdGggYW4gb3JkZXJseSBzaHV0ZG93biBvZgo+ID4+IGV2ZXJ5dGhpbmcgdGhlIGtlcm5lbCBp
cyByZXNwb25zaWJsZSBmb3IuCj4gPgo+ID4gRml4aW5nIGluIHVzZXJzcGFjZSBpcyBhbiBvcHRp
b24gYnV0IHBlb3BsZSBhcmUgbm90IGhhcHB5IHRoYXQgdGhlCj4gPiBrZXJuZWwgY2FuIGNyYXNo
IGxpa2UgdGhhdC4KPgo+IEluIGEga2V4ZWMgb24gcGFuaWMgc2NlbmFyaW8gdGhlIGtlcm5lbCBu
ZWVkcyB0byBwZXJmb3JtIHRoYXQgYWJzb2x1dGUKPiBiYXJlIGVzc2VudGlhbCBzaHV0ZG93biBi
ZWZvcmUgY2FsbGluZyBrZXhlYyAoYmFzaWNhbGx5IG5vdGhpbmcpLgo+IER1cmluZyBrZXhlYy1v
bi1wYW5pYyBub3RoaW5nIGNhbiBiZSByZWxpZWQgdXBvbiBiZWNhdXNlIHdlIGRvbid0IGtub3cK
PiB3aGF0IGlzIGJyb2tlbi4gIElmIHRoYXQgaXMgd2hhdCB5b3UgY2FyZSBhYm91dCAoYXMgc3Vn
Z2VzdGVkIGJ5IHRoZQo+IHVuaXQgdGVzdCkgeW91IG5lZWQgdG8gZml4IHRoZSBkZXZpY2UgaW5p
dGlhbGl6YXRpb24uCj4KPiBJbiBhIG5vcm1hbCBrZXhlYyBzY2VuYXJpbyB0aGUgd2hvbGUgbm9y
bWFsIHJlYm9vdCBwcm9jZXNzIGlzIGV4cGVjdGVkLgo+IEkgaGF2ZSBubyBwcm9ibGVtcyB3aXRo
IGZpeGluZyB0aGUga2VybmVsIHRvIGhhbmRsZSB0aGF0IHNjZW5hcmlvLAo+IGJ1dCBpbiB0aGUg
cmVhbCB3b3JsZCB0aGUgZW50aXJlIG9yZGVybHkgc2h1dGRvd24gYm90aCwga2VybmVsCj4gYW5k
IHVzZXJzcGFjZSBzaG91bGQgYmUgcGVyZm9ybWVkLgoKU291bmRzIGdvb2QuIFNpbmNlIHlvdSBt
ZW50aW9uZWQgeW91IGhhdmUgbm8gcHJvYmxlbSB3aXRoIGZpeGluZwpyZWd1bGFyIHJlYm9vdCBp
biB0aGUga2VybmVsLCB3ZSB3aWxsIHdvcmsgb24gcmVwcm9kdWNpbmcgdGhlIGlzc3VlCndpdGgg
cmVndWxhciByZWJvb3QgYXMgd2VsbCBhbmQgZml4IHRoYXQuCgpJIHRoaW5rIGEgc3lzY2FsbCBj
YXVzaW5nIHRoZSBrZXJuZWwgdG8gY3Jhc2ggaW5zdGVhZCBvZiBvcGVyYXRlCm5vcm1hbGx5IGlz
IGEgY2F1c2Ugb2YgY29uY2Vybiwgc28gbGV0IHVzIGZpeCB0aGUga2VybmVsIGFzIHdlbGwKKG90
aGVyIHRoYW4gaW1wcm92aW5nIHRoZSB0ZXN0IGNhc2UgYXMgeW91IG1lbnRpb25lZCkuCgo+ID4+
IEF0IHRoZSBrZXJuZWwgbGV2ZWwgYSBrZXhlYyByZWJvb3QgYW5kIGEgbm9ybWFsIHJlYm9vdCBo
YXZlIGJlZW4KPiA+PiBkZWxpYmVyYXRlbHkga2VwdCBhcyBjbG9zZSBhcyBwb3NzaWJsZS4gIFdo
aWNoIGlzIHdoeSBJIHNheSB3ZSBzaG91bGQKPiA+PiBmaXggaXQgaW4gcmVib290Lgo+ID4KPiA+
IFlvdSBtZWFuIGZpeCBpdCBpbiB1c2Vyc3BhY2U/Cj4KPiBOby4gIEkgbWVhbiBpbiB0aGUga2Vy
bmVsIHRoZSBvcmRlcmx5IHNodXRkb3duIGZvciBhIGtleGVjIHJlYm9vdCBhbmQgYW4KPiBvcmRp
bmFyeSByZWJvb3QgYXJlIGtlcHQgYXMgY2xvc2UgdG8gdGhlIHNhbWUgYXMgcG9zc2libGUuCj4K
PiBJdCBzaG91bGQgYmUgdGhlIGNhc2UgdGhhdCB0aGUgb25seSBkaWZmZXJlbmNlcyBiZXR3ZWVu
IHRoZSB0d28gaXMgdGhhdAo+IGluIG9uY2UgY2FzZSBzeXN0ZW0gZmlybXdhcmUgdGFrZXMgb3Zl
ciBhZnRlciB0aGUgb3JkZXJseSBzaHV0ZG93biwKPiBhbmQgaW4gdGhlIG90aGVyIGNhc2UgYSBu
ZXcga2VybmVsIHRha2VzIG92ZXIgYWZ0ZXIgdGhlIG9yZGVybHkgc2h1dGRvd24uCgpBZ3JlZWQu
Cgp0aGFua3MsCgogLSBKb2VsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
