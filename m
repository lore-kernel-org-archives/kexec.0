Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAB0C433EF
	for <kexec@archiver.kernel.org>; Mon, 25 Jul 2022 13:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CAZFt8MBwRiZ04riOTlgmGTDv5FOgNacGMW3x4GCbt4=; b=ThQ6cvBfE6NXvI
	TabWhzFamsGcBvYANzWUaJPIf2QXnh8umZDXVUYTOJvSHmI+nIERHYKldP5DPWxHqtbOYUMNAdT2A
	8T/PdZRvdwt8YhzHDhIrVcVqZ4Sbzp9fDgBvSgvsxC6WxDmM8qhtpdhkFPMC1kEW2u4+BjcYL+pAs
	0hNEocWyqPwmCxpXxpBTV4tf07ALsnc6groT/VrNM7VgVcUXUI7DI7ThaRvxqoQIGyLwpZNS5hZfm
	coJal7xoSCe2A1cHw2DNUT/U4GITOZuL20LXKzKe5Kj3hkMMWuo8Wem/+wu/UgMUNAGX5i+5XJE28
	0jHsNGtv/bqNirRz+6Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFyAj-00A1aS-KB; Mon, 25 Jul 2022 13:30:57 +0000
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFyAg-00A1Y9-At
	for kexec@lists.infradead.org; Mon, 25 Jul 2022 13:30:56 +0000
Received: by mail-il1-x135.google.com with SMTP id n13so5678461ilk.1
        for <kexec@lists.infradead.org>; Mon, 25 Jul 2022 06:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kqgRYaQ+5Ei5P1sHb0JfmZ6zpThHEKr7E+RUOHeaoYM=;
        b=jy6Ofg3IZ4r4qf3yeNRhJBzx3l0jYTUvPpUQxq9PzqtaRD5mYFBt27ndkR5BopQFDq
         PJKLlVqdlkVPeCmFpp7LFGlCrHLts4jS8J9KyCpYTEscdTQaFpSBg75OaFNOEWEKsCG1
         ekNRnLJP3HClMuPZiFlGhJCRs9Mo5mcYiCHj9W99lrh2JkzOHiVq//SorMjsnVNegZvU
         ed2eMd6CYWmY7q3zoeGDpG32aanOs7hpRCAVlH4AJ+rj0r3EWVc7flluL0scu+cVjh2o
         CHzt3i1f214fyDZgk+n7lwVjQugC8qOhB7UFJvxpyS+gHUgxj/SzyFD6hvxok626BOEq
         VZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kqgRYaQ+5Ei5P1sHb0JfmZ6zpThHEKr7E+RUOHeaoYM=;
        b=LXlxzcu/mQMZsBXvppj8/SGolwbZtMczZq5Elzgzpv2pvBoafo/nhtXBozFUpbJCRB
         EKVFHY0+menZtSUUR4Pt1gqobJGq654MNj/Pq9aLAAOZAXbMrP3pBJ/7NNHb5tIu8ATt
         XdhnYbmWkptqRLshILAjyyGvfplj/ml65PyN2bV2FiE0jvxZ3rKdyzLpCe83+NIjEM/P
         QHtg9Ip1UeNKSZSDgmi527ZeJ4YHvCd8dVHPvjoOVVMem/63PMZi6Ve+Pow0Vl5HJr2z
         ON/uqQNRrth8V7XghifDIsPS7vCvWEA4Ywnf93vvUaIpIF6+SvRm5Xo+jzCa3uWV87en
         28ww==
X-Gm-Message-State: AJIora/qtOF4fURYPBVQdiOlNH/ixRz+Fn7+DiFVTli7mZpE5JNLNuty
	oZRJqDNDk0QXgXQ9cSKJHSe1ySTPXL5V8G5q8rKl4A==
X-Google-Smtp-Source: AGRyM1svsFvJjM44MlpBpazZSBO0gFEQ3hiwRw4WeKR9Juffr2OOgH3srO5bGTVALtUNMqlqZMnZxnFr1Wuh6SmpRU8=
X-Received: by 2002:a05:6e02:5a6:b0:2dd:164c:15a2 with SMTP id
 k6-20020a056e0205a600b002dd164c15a2mr4895579ils.105.1658755852411; Mon, 25
 Jul 2022 06:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220725083904.56552-1-huangjie.albert@bytedance.com>
 <20220725083904.56552-2-huangjie.albert@bytedance.com> <Yt6GPsWcG9iWHBUg@zx2c4.com>
In-Reply-To: <Yt6GPsWcG9iWHBUg@zx2c4.com>
From: =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date: Mon, 25 Jul 2022 21:30:41 +0800
Message-ID: <CABKxMyNj7Oo3X47APa8Ro-CCK3=XFogorJ2maTCstgsrrC28kg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/4] kexec: reuse crash kernel reserved
 memory for normal kexec
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, 
	Nick Desaulniers <ndesaulniers@google.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Michael Roth <michael.roth@amd.com>, Nathan Chancellor <nathan@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Joerg Roedel <jroedel@suse.de>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Sean Christopherson <seanjc@google.com>, 
	Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-kbuild@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220725_063054_423600_30F03051 
X-CRM114-Status: GOOD (  24.55  )
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

SmFzb24gQS4gRG9uZW5mZWxkIDxKYXNvbkB6eDJjNC5jb20+IOS6jjIwMjLlubQ35pyIMjXml6Xl
kajkuIAgMjA6MDLlhpnpgZPvvJoKPgo+IEhpIEFsYmVydCwKPgo+IE9uIE1vbiwgSnVsIDI1LCAy
MDIyIGF0IDA0OjM4OjUzUE0gKzA4MDAsIEFsYmVydCBIdWFuZyB3cm90ZToKPiA+IFRoZSBrZXhl
YyB1c2Vyc3BhY2UgdG9vbCBhbHNvIG5lZWRzIHRvIGFkZCBwYXJhbWV0ZXIgb3B0aW9ucygtcikg
dGhhdAo+ID4gc3VwcG9ydCB0aGUgdXNlIG9mIHJlc2VydmVkIG1lbW9yeSAoc2VlIGFub3RoZXIg
cGF0Y2ggZm9yIGtleGVjKQo+ID4KPiA+IFsuLi5dCj4gPgo+ID4gLSAgICAgaWYgKGtleGVjX29u
X3BhbmljKSB7Cj4gPiArICAgICBpZiAoa2V4ZWNfb25fcGFuaWMgJiYga2V4ZWNfb25fcmVzZXJ2
ZWQpIHsKPgo+IFR3byBzbWFsbCBxdWVzdGlvbnMgcmVsYXRlZCB0byB0aGlzOgo+Cj4gLSBXaHkg
ZG9lcyBrZXhlYy10b29scyBuZWVkIGFuIG9wdGlvbiwgb3IgbW9yZSBzcGVjaWZpY2FsbHksIHdo
eSBkb2VzCj4gICB1c2Vyc3BhY2UgbmVlZCB0byBjb21tdW5pY2F0ZSBhYm91dCB0aGlzIGF0IGFs
bD8gQ2FuJ3QgdGhlIGtlcm5lbCBqdXN0Cj4gICBhdXRvbWF0aWNhbGx5IHVzZSB0aGUgYXZhaWxh
YmxlIHJlc2VydmVkIG1lbW9yeSBpbiB0aGUgY2FzZSB0aGF0J3Mgbm90Cj4gICBhbHJlYWR5IGJl
aW5nIHVzZWQgYnkgdGhlIHBhbmljIGhhbmRsZXIga2VybmVsPyBJJ20gY3VyaW91cyBhYm91dAo+
ICAgd2hldGhlciB0aGVyZSBhcmUgY2F2ZWF0cyB0aGF0IHdvdWxkIG1ha2UgdGhpcyBvY2Nhc2lv
bmFsbHkKPiAgIHVuZGVzaXJhYmxlLCBoZW5jZSBzdWdnZXN0aW5nIGFuIG9wdGlvbi4KCkJlY2F1
c2UgdGhlIGNyYXNoIGtlcm5lbCB3aWxsIGFsc28gdXNlIHRoaXMgcGFydCBvZiB0aGUgbWVtb3J5
LApzbyBkbyBub3QgdXNlIHRoaXMgbWVjaGFuaXNtIHVubGVzcyBleHBsaWNpdGx5IHNwZWNpZmll
ZC4gU28gSSB0ZW5kIHRvCmFkZCBhbiBvcHRpb24KCj4KPiAtIEkgZG9uJ3QgdG90YWxseSB1bmRl
cnN0YW5kIGhvdyB0aGlzIHdvcmtzLCBzbyBJIG1pZ2h0IGJlIGEgYml0IG9mZgo+ICAgaGVyZSwg
YnV0IGlzIHRoZXJlIGFueSBjaGFuY2UgdGhhdCB0aGlzIGNvdWxkIGJlIG1hZGUgdG8gY28tZXhp
c3Qgd2l0aAo+ICAga2V4ZWNfb25fcGFuaWM/IENhbiBhIGxhcmdlciByZWdpb24ganVzdCBiZSBy
ZXNlcnZlZCwgc3BlY2lmaWNhbGx5IGZvcgo+ICAgdGhpcywgcmF0aGVyIHRoYW4gcGlnZ3kgYmFj
a2luZyBvbiB0aGUgcGFuaWMgaGFuZGxlciByZWdpb24/Cj4KPiA+ICtzdGF0aWMgc3RydWN0IHBh
Z2UgKmtpbWFnZV9hbGxvY19yZXNlcnZlcmRfY29udHJvbF9wYWdlcyhzdHJ1Y3Qga2ltYWdlICpp
bWFnZSwKPiA+ICsgICAgIGNhc2UgS0VYRUNfVFlQRV9SRVNFUlZFRF9NRU06Cj4gPiArICAgICAg
ICAgICAgIHBhZ2VzID0ga2ltYWdlX2FsbG9jX3Jlc2VydmVyZF9jb250cm9sX3BhZ2VzKGltYWdl
LCBvcmRlcik7Cj4KPiBOaXQ6Cj4gICByZXNlcnZlcmQgLT4gcmVzZXJ2ZWQKCnRoYW5rcyBmb3Ig
dGhhdCwgSSB3aWxsIGNvcnJlY3QgaXQKCj4KPiBKYXNvbgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9rZXhlYwo=
