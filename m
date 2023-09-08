Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E168EEB56E
	for <kexec@archiver.kernel.org>; Fri,  8 Sep 2023 22:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A3JS1QkUNPgGCNBpD7OHuAqDv1YJ/hRrd0lRUc07/TQ=; b=E2yUqLm7eOQjOp
	/fuljj7ZkbpSUwDS3KVGfGcciAyQo24k4wKdZS+hpeIvwRs9LvXHy6wIXvKDNec5zsQxOSbISaXRZ
	fKw+t1Dvq5P8YZFqmy3I0gh5EDWoWKRk1bfOWryIOFpxDvpsyr+2tWFgQbZiqiXX13XuR/OtwC53+
	rC/Vbj/lZk5lvSKzngat8QQbKImjnv/gbp5mGoqy6156ssqqpj/MbHSe5mOqRLrVDwwGPItF6N70E
	1gzKMw6o6DAIeiJT9+vEgXp2k16iCBKIvTGf2jucW+0C0pSiXTesgMeY05/7PVoJlqBIcAQMCw5uQ
	iLR6j8xW2Tiu12VHBzDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qekLw-00Edxv-1T;
	Fri, 08 Sep 2023 22:53:28 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qekLs-00Edwu-28;
	Fri, 08 Sep 2023 22:53:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id CAEB3CE1CE3;
	Fri,  8 Sep 2023 22:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C3EC433A9;
	Fri,  8 Sep 2023 22:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694213597;
	bh=KwM170Ct57lq4vNZ7xSkyIS4SWaJogcjmhutnsYYUvg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a6zALJdvJybZVN96yoS6EZ96AEPRkZIR3J4RfcotR605O+NAX+wNKtlhCkZ7m2Znv
	 i6V/2X6pYg8E2vdc8LrkEoB0MIWoQalZNAUvZZgx+xmYcneTNW67WcPF/2ajJ7qFwi
	 nSTyEdorTmAO+3CGT756wTHvIJ17mSEY9Xosqq7i1j7WrM7VgfKCpBQeF3kXj07jwc
	 a/fA1MYPF1Zxm0UHR0htujt2KUCICJdTImw6i0KfsNo2VMYYWssP1ipoZSdLAWlQlq
	 ijTEdEIp1PjWQuUEsWufaNPGDnt3zZBiGsfrWPOjprVAWSSXuYVBIBBYCypgu9egun
	 AyVyrYTuWbNAw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4ff8f2630e3so4315135e87.1;
        Fri, 08 Sep 2023 15:53:17 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx2J8okAhObJLsYHy0J/Nvp3PI6NZ0I2lEsyN/YoIsM6oDOu95a
	bFsjKXo/UhAXalZWKxqcxkD+IPpY9zq2Fl/yyLc=
X-Google-Smtp-Source: AGHT+IFxzWHrgwn9Er+VZvUvTkc7+KPn5VFwMJdiU1jtuP4KYojqei7vjyha6oz515UbclFjbQ87OxJGnp5Vhfvbj6U=
X-Received: by 2002:ac2:4bc5:0:b0:4fe:7e1f:766a with SMTP id
 o5-20020ac24bc5000000b004fe7e1f766amr3386244lfq.24.1694213595847; Fri, 08 Sep
 2023 15:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v7-0-b05c520b7296@chromium.org>
 <CAPhsuW5_qAvV0N3o+hOiAnb1=buJ1pLzqYW9D+Bwft6hxJvAeQ@mail.gmail.com>
 <CANiDSCu2YLaXv2DkfzN0GbTF1b79HnqPG=GWqodDr4X9krGjUA@mail.gmail.com>
 <CAPhsuW5JDPk7ZEthu7cowqp6emQOXsWgSvPM+kvnERPq4RR83w@mail.gmail.com> <CANiDSCtbo1ws7hTgeha8+V8g198GN1_NAdWV+9Hi5UZgk0cfUA@mail.gmail.com>
In-Reply-To: <CANiDSCtbo1ws7hTgeha8+V8g198GN1_NAdWV+9Hi5UZgk0cfUA@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 8 Sep 2023 15:53:02 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7N2ZxO5KubvK4O7EganpGeFFMtx4JGE9sGO5OnzWscgg@mail.gmail.com>
Message-ID: <CAPhsuW7N2ZxO5KubvK4O7EganpGeFFMtx4JGE9sGO5OnzWscgg@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] kexec: Fix kexec_file_load for llvm16 with PGO
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Philipp Rudo <prudo@linux.vnet.ibm.com>, 
	Dave Young <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Baoquan He <bhe@redhat.com>, 
	Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ross Zwisler <zwisler@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Simon Horman <horms@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, llvm@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	stable@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_155325_061626_41B66258 
X-CRM114-Status: GOOD (  31.91  )
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

T24gRnJpLCBTZXAgOCwgMjAyMyBhdCAyOjUy4oCvUE0gUmljYXJkbyBSaWJhbGRhIDxyaWJhbGRh
QGNocm9taXVtLm9yZz4gd3JvdGU6Cj4KPiBIaSBTb25nCj4KPiBPbiBGcmksIDggU2VwdCAyMDIz
IGF0IDIzOjQ4LCBTb25nIExpdSA8c29uZ0BrZXJuZWwub3JnPiB3cm90ZToKPiA+Cj4gPiBIaSBS
aWNhcmRvLAo+ID4KPiA+IFRoYW5rcyBmb3IgeW91ciBraW5kIHJlcGx5Lgo+ID4KPiA+IE9uIEZy
aSwgU2VwIDgsIDIwMjMgYXQgMjoxOOKAr1BNIFJpY2FyZG8gUmliYWxkYSA8cmliYWxkYUBjaHJv
bWl1bS5vcmc+IHdyb3RlOgo+ID4gPgo+ID4gPiBIaSBTb25nCj4gPiA+Cj4gPiA+IE9uIEZyaSwg
OCBTZXB0IDIwMjMgYXQgMDE6MDgsIFNvbmcgTGl1IDxzb25nQGtlcm5lbC5vcmc+IHdyb3RlOgo+
ID4gPiA+Cj4gPiA+ID4gSGkgUmljYXJkbyBhbmQgZm9sa3MsCj4gPiA+ID4KPiA+ID4gPiBPbiBG
cmksIE1heSAxOSwgMjAyMyBhdCA3OjQ44oCvQU0gUmljYXJkbyBSaWJhbGRhIDxyaWJhbGRhQGNo
cm9taXVtLm9yZz4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gV2hlbiB1cHJldmluZyBsbHZt
IEkgcmVhbGlzZWQgdGhhdCBrZXhlYyBzdG9wcGVkIHdvcmtpbmcgb24gbXkgdGVzdAo+ID4gPiA+
ID4gcGxhdGZvcm0uCj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhlIHJlYXNvbiBzZWVtcyB0byBiZSB0
aGF0IGR1ZSB0byBQR08gdGhlcmUgYXJlIG11bHRpcGxlIC50ZXh0IHNlY3Rpb25zCj4gPiA+ID4g
PiBvbiB0aGUgcHVyZ2F0b3J5LCBhbmQga2V4ZWMgZG9lcyBub3Qgc3VwcG9ydHMgdGhhdC4KPiA+
ID4gPiA+Cj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIFJpYmFsZGEgPHJpYmFsZGFA
Y2hyb21pdW0ub3JnPgo+ID4gPiA+Cj4gPiA+ID4gV2UgYXJlIHNlZWluZyBXQVJOSU5HcyBsaWtl
IHRoZSBmb2xsb3dpbmcgd2hpbGUga2V4ZWMnaW5nIGEgUEdPIGFuZAo+ID4gPiA+IExUTyBlbmFi
bGVkIGtlcm5lbDoKPiA+ID4gPgo+ID4gPiA+IFdBUk5JTkc6IENQVTogMjYgUElEOiAxMTA4OTQg
YXQga2VybmVsL2tleGVjX2ZpbGUuYzo5MTkKPiA+ID4gPiBrZXhlY19sb2FkX3B1cmdhdG9yeSsw
eDM3Zi8weDM5MAo+ID4gPiA+Cj4gPiA+ID4gQUZBSUNULCB0aGUgd2FybmluZyB3YXMgYWRkZWQg
YnkgdGhpcyBzZXQsIGFuZCBpdCB3YXMgdHJpZ2dlcmVkIHdoZW4KPiA+ID4gPiB3ZSBoYXZlIG1h
bnkgLnRleHQgc2VjdGlvbnMKPiA+ID4gPiBpbiBwdXJnYXRvcnkucm8uIFRoZSBrZXhlYyB3YXMg
YWN0dWFsbHkgc3VjY2Vzc2Z1bC4gU28gSSB3b25kZXIKPiA+ID4gPiB3aGV0aGVyIHdlIHJlYWxs
eSBuZWVkIHRoZQo+ID4gPiA+IFdBUk5JTkcgaGVyZS4gSWYgd2UgZGlzYWJsZSBMVE8gKFBHTyBp
cyBzdGlsbCBlbmFibGVkKSwgd2UgZG9uJ3Qgc2VlCj4gPiA+ID4gdGhlIFdBUk5JTkcgYW55IG1v
cmUuCj4gPiA+ID4KPiA+ID4gPiBJIGFsc28gdGVzdGVkIGFuIG9sZGVyIGtlcm5lbCAoNS4xOSBi
YXNlZCksIHdoZXJlIHdlIGFsc28gc2VlIG1hbnkKPiA+ID4gPiAudGV4dCBzZWN0aW9ucyB3aXRo
IExUTy4gSXQKPiA+ID4gPiBrZXhlYygpJ2VkIGZpbmUuIChJdCBkb2Vzbid0IGhhdmUgdGhlIFdB
Uk5fT04oKSBpbgo+ID4gPiA+IGtleGVjX3B1cmdhdG9yeV9zZXR1cF9zZWNoZHJzKS4KPiA+ID4K
PiA+ID4gWW91IGhhdmUgYmVlbiAibHVja3kiIHRoYXQgdGhlIGNvZGUgaGFzIGNob3NlbiB0aGUg
Y29ycmVjdCBzdGFydAo+ID4gPiBhZGRyZXNzLCB5b3UgbmVlZCB0byBtb2RpZnkgdGhlIGxpbmtl
ciBzY3JpcHQgb2YgeW91ciBrZXJuZWwgdG8KPiA+ID4gZGlzYWJsZSBQR08uCj4gPiA+IFlvdSBu
ZWVkIHRvIGJhY2twb3J0IGEgcGF0Y2ggbGlrZSB0aGlzOgo+ID4gPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sa21sL0NBUGhzdVc1X3FBdlYwTjNvK2hPaUFuYjE9YnVKMXBMenFZVzlEK0J3ZnQ2
aHhKdkFlUUBtYWlsLmdtYWlsLmNvbS9ULyNtZDY4YjdmODMyMjE2YjBjNTZiYmVjMGM5YjA3MzMy
ZTE4MGI5YmEyYgo+ID4KPiA+IFdlIGFscmVhZHkgaGF2ZSB0aGlzIGNvbW1pdCBpbiBvdXIgYnJh
bmNoLiBBRkFJQ1QsIHRoZSBpc3N1ZSB3YXMKPiA+IHRyaWdnZXJlZCBieSBMVE8uIFNvIHNvbWV0
aGluZyBsaWtlIHRoZSBmb2xsb3dpbmcgc2VlbXMgZml4ZXMgaXQKPiA+IChJIGhhdmVuJ3QgZmlu
aXNoZWQgdGhlIGVuZC10by1lbmQgdGVzdCB5ZXQpLiBEb2VzIHRoaXMgY2hhbmdlIG1ha2UKPiA+
IHNlbnNlIHRvIHlvdT8KPgo+IGlmIHRoZSBlbmQtdG8tZW5kIHdvcmtzLCBwbGVhc2Ugc2VuZCBp
dCBhcyBhIHBhdGNoIHRvIHRoZSBtYWlsaW5nIGxpc3QuCj4KPiBUaGFua3MhIDopCgpPSywgaXQg
d29ya3MgKEFGQUlDVCkuIFNlbmRpbmcgdGhlIHBhdGNoLgoKVGhhbmtzLApTb25nCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxp
c3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
