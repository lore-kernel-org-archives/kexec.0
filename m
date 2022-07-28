Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15C5C04A68
	for <kexec@archiver.kernel.org>; Thu, 28 Jul 2022 01:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tUT5pUD8aInC6dV1yoYzGaci+8/utTke3JCCMtiXm5o=; b=jl4kiT51BPLa5A
	bbOz46Ov3cTYaa1Ga0VXP8Fc7fSntPq7VNrji0RL6JXlT1KDDp9UX1R1FD6KCaRheoCDn+AtkTGPf
	OnLKyrNMCmlp/GIt0tsSRP6tcqx3d5kbQuFwgyJd/YBnkBodNRijBKkA0NKiYU2Bb9f/Y4fSiZBw/
	ezNjd0aU55m1iCBQEaA8p38t4HpZ44PK0vbH2slGsBSUdLXKs5LU/pdFSBjrb0+MI4GiMZyvWMAZJ
	iR6vxwU+taoa7xI86QDP9LwJvoMqguqCtNMp1XAscsvBP0NefrrPejkka4K5WF7sLtyURioi6TYDE
	JCcS3zaDYEPueo+2U/zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGsmv-002Z3o-Qc; Thu, 28 Jul 2022 01:58:09 +0000
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGsms-002Z0j-R2
	for kexec@lists.infradead.org; Thu, 28 Jul 2022 01:58:08 +0000
Received: by mail-io1-xd34.google.com with SMTP id e69so463507iof.5
        for <kexec@lists.infradead.org>; Wed, 27 Jul 2022 18:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7OcGNq5n7OL7NCeH32T6WffwDtTAaQWjccCnv1aDnY8=;
        b=d5wLp6zq9wwXGe/75isEFHSDc58FlS8/OHPOjVktA1LCPSaJb30DStjNod1lQM6A2w
         gHz97PZavsAG6MmdzQLpRyCzseyQrMZG/LhG7yo/2UBjZwVb1Y3e5JL81LPeGo/EiMbv
         ifpJkZLkd0d+HxkuM6LP0oA7dfZVc5riWdj8WM9A+LBcQW7uX1sNUnwZrhozuwGwWC4H
         hB6kDoeWk8c18Ql28NSjkpFAqcoBL8YXzQodckUWVA4pWkTlEemC4pwG+AAWSZbYhShv
         gxqq/ju8DJEzdufEFfKK6yOBMY4t+AW67rUMpG67W9Pm22pQEYss1lDOSw4olRT6z2Pk
         6i+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7OcGNq5n7OL7NCeH32T6WffwDtTAaQWjccCnv1aDnY8=;
        b=iskoQYTeU5PRfUPv1QfyIHfgji6h7BJMiGaGwr4ynWzd4yV6rzgOKGtceDeEO++O4f
         1cLsGEIQwVWUfsRdScqitlaEsE8YSrf9c6566zIrgY+KpmDwBUEhJI0zG/Dawqdiw3H4
         iIdejqVxaDg4WCDOGlEnT1Y69SOwxjzfbIRBg6ygGlzOUhqhh8ql9LsEb3q1iIR3451v
         minDa/n907ExLR/B2eKQo7YL+mmVbxN+tNtRHDGUg7pZSAdw3Ar9fdfFN6x4dvJwok24
         nYW3hk8yHSiuNiidr9P9IHUlEm6Xh7Llm+em4529Vfx+zv9o9/2pkCG1B8KjvIJgFDTV
         h7Bg==
X-Gm-Message-State: AJIora9T8Qj83iKVeOUZ3K/eeMifMCkw7c3hzgplLx1zhm1+ZW9BCjuX
	Ho/3lmdLSF2XLBJL7XWttLpYQrhQZwS0sMtN6FdTgg==
X-Google-Smtp-Source: AGRyM1vd2+VTOuirM6qNLzHH+tMAqMjBD/U8hapM6G4FiL1Gph9O7L4H/mnvEFv3FMrQ/hr4Aaou2XRjzil5EFw2Jg8=
X-Received: by 2002:a05:6638:138f:b0:341:4711:4c2c with SMTP id
 w15-20020a056638138f00b0034147114c2cmr10183257jad.178.1658973484043; Wed, 27
 Jul 2022 18:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220725083904.56552-1-huangjie.albert@bytedance.com>
 <20220725083904.56552-3-huangjie.albert@bytedance.com> <Yt6JRBToqY5ts6OU@zx2c4.com>
 <CABKxMyOcePkvAvMyrG2r08yRuxx=gK2SnMBFbKzKW6hBAdmRFw@mail.gmail.com>
In-Reply-To: <CABKxMyOcePkvAvMyrG2r08yRuxx=gK2SnMBFbKzKW6hBAdmRFw@mail.gmail.com>
From: =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date: Thu, 28 Jul 2022 09:57:53 +0800
Message-ID: <CABKxMyNjHVryZ4zuTkyPcsS=WVN-vVb4YFzzq3LKgVWgf01dyw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 2/4] kexec: add CONFING_KEXEC_PURGATORY_SKIP_SIG
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, 
	Nick Desaulniers <ndesaulniers@google.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Nathan Chancellor <nathan@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sean Christopherson <seanjc@google.com>, Joerg Roedel <jroedel@suse.de>, Mark Rutland <mark.rutland@arm.com>, 
	Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-kbuild@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_185806_897556_D7E58F18 
X-CRM114-Status: GOOD (  23.71  )
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

RG9lcyBhbnlvbmUga25vdyB3aHkgdGhpcyBzaGEyNTYgY2hlY2tzdW0gaXMgcHV0IGhlcmU/IEkg
ZmVlbCB0aGF0IGl0CmlzIGJldHRlciB0byBwdXQgaXQgaW4gdGhlIHN5c3RlbSBjYWxsIG9mIGtl
eGVjIC1lLgpJZiB0aGUgdmVyaWZpY2F0aW9uIGlzIG5vdCBwYXNzZWQsIHRoZSBzZWNvbmQga2Vy
bmVsIHdpbGwgbm90IGJlCnN0YXJ0ZWQsIGFuZCBzb21lIHByb21wdCBpbmZvcm1hdGlvbiB3aWxs
IGJlIHByaW50ZWQgYXQgdGhlCnNhbWUgdGltZSwgd2hpY2ggc2VlbXMgdG8gYmUgYmV0dGVyIHRo
YW4gd2hlbiB0aGUgc2Vjb25kIGtlcm5lbCBpcwpzdGFydGVkLiBEb2luZyB0aGUgdmVyaWZpY2F0
aW9uIG9wZXJhdGlvbiB3aWxsIGJlIG1vcmUgZnJpZW5kbHksCiBhbmQgaXQgY2FuIGFsc28gcmVk
dWNlIGRvd250aW1lLgoK6buE5p2wIDxodWFuZ2ppZS5hbGJlcnRAYnl0ZWRhbmNlLmNvbT4g5LqO
MjAyMuW5tDfmnIgyNeaXpeWRqOS4gCAyMTozMuWGmemBk++8mgo+Cj4gbWF5YmUgYSBib290IHBh
cmFtZXRlciA/Cj4KPiBKYXNvbiBBLiBEb25lbmZlbGQgPEphc29uQHp4MmM0LmNvbT4g5LqOMjAy
MuW5tDfmnIgyNeaXpeWRqOS4gCAyMDoxNeWGmemBk++8mgo+ID4KPiA+IEhpIEFsYmVydCwKPiA+
Cj4gPiBPbiBNb24sIEp1bCAyNSwgMjAyMiBhdCAwNDozODo1NFBNICswODAwLCBBbGJlcnQgSHVh
bmcgd3JvdGU6Cj4gPiA+ICtjb25maWcgS0VYRUNfUFVSR0FUT1JZX1NLSVBfU0lHCj4gPiA+ICsg
ICAgIGJvb2wgInNraXAga2V4ZWMgcHVyZ2F0b3J5IHNpZ25hdHVyZSB2ZXJpZmljYXRpb24iCj4g
PiA+ICsgICAgIGRlcGVuZHMgb24gQVJDSF9IQVNfS0VYRUNfUFVSR0FUT1JZCj4gPiA+ICsgICAg
IGhlbHAKPiA+ID4gKyAgICAgICB0aGlzIG9wdGlvbnMgbWFrZXMgdGhlIGtleGVjIHB1cmdhdG9y
eSBkbyAgbm90IHNpZ25hdHVyZSB2ZXJpZmljYXRpb24KPiA+ID4gKyAgICAgICB3aGljaCB3b3Vs
ZCBnZXQgaHVuZHJlZHMgb2YgbWlsbGlzZWNvbmRzIHNhdmVkIGR1cmluZyBrZXhlYyBib290LiBJ
ZiB3ZSBjYW4KPiA+ID4gKyAgICAgICBjb25maXJtIHRoYXQgdGhlIGRhdGEgb2YgZWFjaCBzZWdt
ZW50IGxvYWRlZCBieSBrZXhlYyB3aWxsIG5vdCBjaGFuZ2Ugd2UgbWF5Cj4gPiA+ICsgICAgICAg
ZW5hYmxlIHRoaXMgb3B0aW9uCj4gPiA+ICsKPiA+Cj4gPiBTb21lIGdyYW1tYXIgbml0cyBoZXJl
LCBidXQgYWN0dWFsbHksIHdvdWxkbid0IGl0IGJlIGJldHRlciB0byBtYWtlIHRoaXMKPiA+IGRl
cGVuZCBvbiBzb21lIG90aGVyIHNpZ25hdHVyZSB0aGluZ3MgaW5zdGVhZD8gTGlrZSBpZiB0aGUg
cGFyZW50IGtlcm5lbAo+ID4gYWN0dWFsbHkgZGlkIGEgYmlnIHNpZ25hdHVyZSBjb21wdXRhdGlv
biwgdGhlbiBtYXliZSB0aGUgcHVyZ2F0b3J5IHN0ZXAKPiA+IGlzIG5lZWRlZCwgYnV0IGlmIGl0
IGRpZG4ndCBib3RoZXIsIHRoZW4gbWF5YmUgeW91IGNhbiBza2lwIGl0LiBUaGlzCj4gPiB3YXks
IHlvdSBkb24ndCBuZWVkIGEgY29tcGlsZS10aW1lIG9wdGlvbiB0aGF0IG1pZ2h0IGNoYW5nZSBz
b21lIGFzcGVjdAo+ID4gb2Ygc2lnbmF0dXJlIHZlcmlmaWNhdGlvbiBwZW9wbGUgbWlnaHQgb3Ro
ZXJ3aXNlIGJlIHJlbHlpbmcgb24uCj4gPgo+ID4gSmFzb24KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8va2V4ZWMK
