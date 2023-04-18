Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E027C77B75
	for <kexec@archiver.kernel.org>; Tue, 18 Apr 2023 17:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Dc5sB1w3sG2Y84Fw94tk4WaD8h+MUkpww5h2XsxToN8=; b=ha6TTZwJiP9d3k
	Y1kjAfb/QRC/1CjXXxwIkwgN1EQ4AK369ElegFdx3bevEnOKBRNtpnipw94klAoNLS2tLAtUa6XeX
	2mtyntwbw8WGApri5Iw9nqwG6U3+l+YYEPp8z1zkDkUB6usn/YgMxUKbBmi+RpIlHLXYiuw3A4TsP
	bp0m8x+x9qZ7bEQpxJbrPTG0oaNYUSz0OiN0XbbOaO1iT/Pr7YOYplS3UMrQ8Rb3ooK/L1ydeNIMC
	JEA8HcEtimyVcXZiHKMfGyoK0fwsc5l83eyh436wEQUqBxueHmIcu5EPBPlKux1tu82Jv4ImH4U6P
	GHvz7lGi064J00kCrCLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1popSZ-002zAR-1i;
	Tue, 18 Apr 2023 17:49:43 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1popSV-002z82-0x
	for kexec@lists.infradead.org;
	Tue, 18 Apr 2023 17:49:42 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-51b33c72686so1979053a12.1
        for <kexec@lists.infradead.org>; Tue, 18 Apr 2023 10:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681840174; x=1684432174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlIxeOWy4t6oNXCBK7WY5wY7Tp+89AfzXIVcFw6Esng=;
        b=F0vmAUYI6vw0QV9Xa4+wYvpq5W5eNg7Dix3wyxxY1HNfGO9Es0s54210TBtEvrS13N
         ZURx54bjmjG0rp9avMzCSj7tfEGPvqO985LuiQeCoFLHp3DsHfci92tcG3c9GeHZwvnu
         VUH2ITP4bsjdzdmAp9OtqXgYEXPpe/WrOoT50e73Sky+MZPXxnLbJYmWkj5qRN0KPCSe
         SSqGVgTGtNB+HrMTkTsvVOjh+yJvL8DiQCbBEDPJ60+07H7b8mruQNaP684n7+PNhCWw
         RqbbxRI596LCql78trh9D3Ww6cOmGUX7nO5+kCtoLKg836bgZrFHE4st/eY6AkX0SRB9
         xFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681840174; x=1684432174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlIxeOWy4t6oNXCBK7WY5wY7Tp+89AfzXIVcFw6Esng=;
        b=Rm8rxWWZsb1g1IIhKSEl6a4nFLXHVanFZoJwvfyXOuyb7hDkYfVbigwX/r6vprjPfb
         pqEfZCdya8+U0R4Uj7q4CYbSbrBX7RCU1x5h9GpssJcZDWVJOnspvUIDHTrwwXwBC78H
         Q98s7rA/730m0o0gZrjPZuPC5ut107r76RNr0XFBiPKYcC+5jcCOcw6h3jtPMZhckLZF
         rOoMp63XGIB4wWpPm031wCD/RhRwJ9pA3qYAlsPETLeDuLALh6yXLE8l0KMvZxHAbZ+r
         qo19C6oFcIoMrhcxZrOZHfNDcWQ5baRDIBO2hRImeBgu4S1xEMuxJBSni1N6dkEXtsW9
         dy2Q==
X-Gm-Message-State: AAQBX9d6Zn9Wk4kASU9fJyiwexhJmwhavJkBRqB/HaDqJ21QTqhvd35N
	4zlt66AI6cOj+bo/+tyXdGQqkVI08sx49q9vlOwxfQ==
X-Google-Smtp-Source: AKy350YrkykFuX9C6FMngEXAngaFBdSEPN7VQptU9h4a3p/UiakXeVMbpqehZB0WAdTS0ezf8ptktEt6I8iBC9XybPg=
X-Received: by 2002:a17:90a:4594:b0:22c:59c3:8694 with SMTP id
 v20-20020a17090a459400b0022c59c38694mr342535pjg.44.1681840174174; Tue, 18 Apr
 2023 10:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v5-0-5563bf7c4173@chromium.org>
 <20230321-kexec_clang16-v5-2-5563bf7c4173@chromium.org> <20230330111523.4b98c8ce@gandalf.local.home>
 <20230330151826.GDZCWoQkQBj4BYbwWw@fat_crate.local> <20230330113127.3011e021@gandalf.local.home>
 <20230330160017.GEZCWyEXQVQZRBbYif@fat_crate.local> <CAKwvOdkULKxoifiVO4H4yomt1DHQxw0ntdO6QgMXk2BpM-urRg@mail.gmail.com>
 <CANiDSCvSDcQi2Qbwu8ddpPDAYehu2VoOB6x-v_PaMkWnwAGxYQ@mail.gmail.com>
In-Reply-To: <CANiDSCvSDcQi2Qbwu8ddpPDAYehu2VoOB6x-v_PaMkWnwAGxYQ@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 18 Apr 2023 10:49:22 -0700
Message-ID: <CAKwvOdkbB4qpjZWRb+2CnOqxNgEY-JB4JvkXSFmOLB_1C=owqQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] x86/purgatory: Add linker script
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Eric Biederman <ebiederm@xmission.com>, 
	Baoquan He <bhe@redhat.com>, Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>, 
	Simon Horman <horms@kernel.org>, "x86@kernel.org" <x86@kernel.org>, linux-toolchains@vger.kernel.org, 
	clang-built-linux <llvm@lists.linux.dev>, Borislav Petkov <bp@alien8.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_104939_332849_2F5E18C7 
X-CRM114-Status: GOOD (  38.73  )
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

T24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMjo0NuKAr1BNIFJpY2FyZG8gUmliYWxkYSA8cmliYWxk
YUBjaHJvbWl1bS5vcmc+IHdyb3RlOgo+Cj4gSGkgTmljawo+Cj4gT24gU2F0LCA4IEFwciAyMDIz
IGF0IDAxOjIyLCBOaWNrIERlc2F1bG5pZXJzIDxuZGVzYXVsbmllcnNAZ29vZ2xlLmNvbT4gd3Jv
dGU6Cj4gPgo+ID4gSGkgUmljYXJkbywKPiA+IFRoYW5rcyBmb3IgdGhlIHBhdGNoISAgUGxlYXNl
IG1ha2Ugc3VyZSB0byBjYyBvdXIgbWFpbGluZyBsaXN0Cj4gPiA8bGx2bUBsaXN0cy5saW51eC5k
ZXY+IGZvciBsbHZtIHNwZWNpZmljIGlzc3Vlcy4KPiA+IHNjcmlwdHMvZ2V0X21haW50YWluZXIu
cGwgc2hvdWxkIHJlY29tbWVuZCBpdCwgb3IgeW91IGNhbiBmaW5kIGl0IGZyb20KPiA+IGNsYW5n
YnVpbHRsaW51eC5naXRodWIuaW8uICBZb3UgY2FuIGFsc28gcGluZyBtZSBpbnRlcm5hbGx5IGZv
cgo+ID4gdG9vbGNoYWluIHJlbGF0ZWQgaXNzdWVzLgo+ID4KPiA+IFN0YXJ0IG9mIHRocmVhZC4K
PiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMzAzMjEta2V4ZWNfY2xhbmcxNi12
NS0wLTU1NjNiZjdjNDE3M0BjaHJvbWl1bS5vcmcvCj4gPgo+ID4gT24gVGh1LCBNYXIgMzAsIDIw
MjMgYXQgOTowMOKAr0FNIEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPiB3cm90ZToKPiA+
ID4KPiA+ID4gT24gVGh1LCBNYXIgMzAsIDIwMjMgYXQgMTE6MzE6MjdBTSAtMDQwMCwgU3RldmVu
IFJvc3RlZHQgd3JvdGU6Cj4gPiA+ID4gT24gVGh1LCAzMCBNYXIgMjAyMyAxNzoxODoyNiArMDIw
MAo+ID4gPiA+IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPiB3cm90ZToKPiA+ID4gPgo+
ID4gPiA+ID4gT24gVGh1LCBNYXIgMzAsIDIwMjMgYXQgMTE6MTU6MjNBTSAtMDQwMCwgU3RldmVu
IFJvc3RlZHQgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gTWFrZSBzdXJlIHRoYXQgdGhlIC50ZXh0IHNl
Y3Rpb24gaXMgbm90IGRpdmlkZWQgaW4gbXVsdGlwbGUgb3ZlcmxhcHBpbmcKPiA+ID4gPiA+ID4g
PiBzZWN0aW9ucy4gVGhpcyBpcyBub3Qgc3VwcG9ydGVkIGJ5IGtleGVjX2ZpbGUuCj4gPgo+ID4g
UGVyaGFwcyB0aGlzIGlzIHJlbGF0ZWQgdG8gQ3JPUycgdXNlIG9mIEF1dG9GRE8gY3JlYXRpbmcg
LnRleHQuaG90Pwo+ID4gSWYgc28sIGl0J3MgcHJvYmFibHkgbW9yZSBzdHJhaWdodGZvcndhcmQg
dG8gc3RyYWlnaHQgdXAgZGlzYWJsZSBQR08KPiA+IGZvciBrZXhlYy4gU2VlIGFsc286Cj4gPgo+
ID4gY29tbWl0IGJkZTk3MWE4M2JiZiAoIktWTTogYXJtNjQ6IG52aGU6IEZpeCBidWlsZCB3aXRo
IHByb2ZpbGUgb3B0aW1pemF0aW9uIikKPgo+IEl0IHdhcyBpbmRlZWQgZHVlIHRvIHRoZSBBdXRv
RkRPLCBhZGRpbmcKPgo+IEtCVUlMRF9DRkxBR1MgOj0gJChmaWx0ZXItb3V0IC1mcHJvZmlsZS1z
YW1wbGUtdXNlPSUgLWZwcm9maWxlLXVzZT0lLAo+ICQoS0JVSUxEX0NGTEFHUykpCj4KPiB0byBh
cmNoL3g4Ni9wdXJnYXRvcnkvTWFrZWZpbGUKPgo+IEl0IGlzIGRlZmluaXRlbHkgc2ltcGxlciB0
aGFuIGFkZGluZyBhIGxpbmtlciBzY3JpcHQsIGJ1dCBJIGFtIG5vdAo+IHN1cmUgaWYgaXQgaXMg
dGhlIGNvcnJlY3Qgd2F5IHRvIGZpeCB0aGlzLi4uIFNlZW1zIGxpa2Ugc3BsaXR0aW5nCj4gLnRl
eHQgaW4gbXVsdGlwbGUgc2VjdGlvbnMgaXMgYW4gaW1wbGVtZW50YXRpb24gZGV0YWlsIG9mIHRo
ZSBjb21waWxlcgo+IGFuZCB0aGUgb25seSB3YXkgdG8gZm9yY2UgaXQgaXMgd2l0aCBhIGxpbmtl
ciBzY3JpcHQuLi4gT3IgYW0gSQo+IG1pc3Npbmcgc29tZXRoaW5nPwoKSSB0aGluayB3aXRoIHRo
ZSB1c2Ugb2YgYHVubGlrZWx5YCBHQ0Mgd2lsbCBwdXQgY29kZSBpbiAudGV4dC5jb2xkLCBzbwpp
dCBpcyBwb3NzaWJsZSB0byB0cmlnZ2VyIHRoaXMgdXNpbmcgc2ltcGxlciBtZWFucywgYnV0Li4u
Cgo+Cj4gU2hhbGwgSSBzZW5kIGEgbmV3IHZlcnNpb24gd2l0aCB0aGUgS0JVSUxEX0NGTEFHUyA/
CgpJIHN0aWxsIHRoaW5rIHRoZSBjZmxhZ3MgYXBwcm9hY2ggaXMgd2F5IHNpbXBsZXIuICBJZiBz
b21lb25lIHRyaWVzIHRvCnVzZSB1bmxpa2VseSBpbiBwdXJnYXRvcnk6ICJkb24ndCBkbyB0aGF0
LiIgIFNhbWUgZm9yIFBHTy4KCj4KPiBUaGFua3MhCj4KPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4g
QW5kPwo+ID4gPiA+ID4KPiA+ID4gPiA+IFdoYXQgaXMgdGhlIGZhaWx1cmUgc2NlbmFyaW8/IFdo
eSBhcmUgeW91IGZpeGluZyBpdD8gV2h5IGRvIHdlIGNhcmU/Cj4gPiA+ID4gPgo+ID4gPiA+ID4g
VGhpcyBpcyB3YXkgdG9vIGxhY29uaWMuCj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gWWVhaCwg
SSB0aGluayB0aGUgY2hhbmdlIGxvZyBpbiBwYXRjaCAxIG5lZWRzIHRvIGJlIGluIHRoaXMgcGF0
Y2ggdG9vLAo+ID4gPiA+IHdoaWNoIGdpdmVzIGJldHRlciBjb250ZXh0Lgo+ID4gPgo+ID4gPiBK
dXN0IHJlYWQgaXQuCj4gPiA+Cj4gPiA+IFdoeSBkaWQgaXQgd29yayB3aXRoIGNsYW5nIHZlcnNp
b24gPCAxNj8KPiA+Cj4gPiBJJ2xsIGJldCBpZiB3ZSBiaXNlY3QgbGx2bSwgd2UgY2FuIHNwb3Qg
d2hhdCBtaWdodCBoYXZlIGNoYW5nZWQsIHdoaWNoCj4gPiBtYXkgZ2l2ZSB1cyBhIGNsdWUgb24g
aG93IHRvIGdldCB0aGUgb2xkIGJlaGF2aW9yIGJhY2s7IG1heWJlIHdpdGhvdXQKPiA+IHRoZSBu
ZWVkIGZvciBhIGxpbmtlciBzY3JpcHQuCj4gPgo+ID4gUmljYXJkbywgaG93IGRpZCB5b3UgdmVy
aWZ5IHRoYXQgeW91ciBmaXggd2FzIGNvcnJlY3Q/IFN1cmVseSB3ZSBjYW4KPiA+IGNoZWNrIHVz
aW5nIGNvbW1hbmQgbGluZSB1dGlsaXRpZXMgd2l0aG91dCBuZWVkaW5nIGEgZnVsbCBibG93biBr
ZXhlYwo+ID4gc2V0dXA/IElmIHlvdSBjYW4gc2hhcmUgbW9yZSBpbmZvLCBJIGNhbiBiaXNlY3Qg
bGx2bSBxdWlja2x5LiAgSWYgaXQKPiA+IHJlcXVpcmVzIHByb2ZpbGUgZGF0YSwgeW91J2xsIG5l
ZWQgdG8gc2hhcmUgaXQsIHNpbmNlIENyT1MgZW5naW5lZXJzCj4gPiBzdGlsbCBoYXZlIG5vdCBw
b3N0ZWQgcHVibGljIGRvY3VtZW50YXRpb24gb24gQXV0b0ZETyBhcyBJIGhhdmUKPiA+IHJlcGVh
dGVkbHkgYXNrZWQgZm9yLgo+Cj4gVGhlIHNpbXBsZXN0IHRlc3QgaXMgdG8gcnVuOgo+Cj4gJHJl
YWRlbGYgLVMgYXJjaC94ODYvcHVyZ2F0b3J5L3B1cmdhdG9yeS5ybyB8IGdyZXAgIl0gXC50ZXh0
Igo+IFsgM10gLnRleHQgICAgICAgICAgICAgUFJPR0JJVFMgICAgICAgICAwMDAwMDAwMDAwMDAw
MDAwICAwMDAwMDJhMAo+Cj4gSWYgdGhlcmUgaXMgb25seSBvbmUgLnRleHQgc2VjdGlvbiB0aGVu
IHRoYXQga2VybmVsIHdpbGwgYmUgbG9hZAo+IHByb3Blcmx5IHZpYSBrZXhlY19maWxlKCkuCgpH
b3QgaXQsIHByb2ZpbGUgZGF0YSB3aWxsIGJlIHJlcXVpcmVkIHRvIHJlcHJvZHVjZSB0aGVuLiBJ
ZiB5b3UgY2FuIHNoYXJlLgotLSAKVGhhbmtzLAp+TmljayBEZXNhdWxuaWVycwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0
CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9rZXhlYwo=
