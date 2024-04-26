Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD85C4345F
	for <kexec@archiver.kernel.org>; Fri, 26 Apr 2024 22:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U9jqILe/L8Z7tUW/0vo4yW4coTI/BH76WUX4FQ51Ohg=; b=ybWC8BtcgmA7Ur
	EaFX+o74P6aIZqPepCSgP4mmSHmcFIiSc0bcSoBzxvI6vZ60SutkguTTPzxwGobbm2VijzwmcFn86
	PBVJtsIhpZ8LjbUQIVFeBhputyCSdkYxno8lpi5yls/zVKy9NAQSN1ySK9RFIr34QNKGO26ASOw/U
	VjCP7eoCjtV0RXmNPsSRFIX0TEbXBJvG+JhcyEbEnDBARXRYGb/CmBXETG+yAENRS0yPBoP2Y3h2H
	Zt69FtuLSNjC4et+egVStKwtJWIYnmdtXm1C7SVaPW0eUD+XzaBubfUBOayOQakLPqH3m+tmV4Zu5
	5fLbEm91fHRtKUF/Rrpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0Te3-0000000EAzi-1fYZ;
	Fri, 26 Apr 2024 22:02:15 +0000
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0Te0-0000000EAxW-0tXy
	for kexec@lists.infradead.org;
	Fri, 26 Apr 2024 22:02:13 +0000
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3c709e5e4f9so1663355b6e.3
        for <kexec@lists.infradead.org>; Fri, 26 Apr 2024 15:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714168929; x=1714773729; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nYqAuReYPhHyvG0oPzkahRacQ09qyjEfadJ1sZsoe0=;
        b=Ij+Chcut69n6CqHHuV+oCjxsBW3Di+43VhCD6KVqNkkgDdE3jURcdLOCqAl3Osmdha
         qlGQSShq5SKf0V8gBxtvTW3KFEwVNU4RNAL7cl/2w+MYNJDdLzMYceLl6DlyF+SiEFOT
         8gWwPYoyjjOfK7wwDj37kYeD4yVabVMO2dUDfCgsJ24lG2u3r8TgIa77Rcr/BlDHDuxe
         cd52MZ4nGnmf/doe6R00lxOcGTeGX65BdBniz/ABZv2jtvA6uwmIGhRMEocwrgDciyO3
         2dKU8iDTApqhzr6cyn2axf2HCTO+z/hKyvOSkf4+3NylhB4qWTn2i4aKWEs3/wAfVXyz
         hHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714168929; x=1714773729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nYqAuReYPhHyvG0oPzkahRacQ09qyjEfadJ1sZsoe0=;
        b=SO4bX75Vmr2ivUG1nvxqlBccNV32aXjph5sXEKwMu0jWjdv+aidBk5IKzGtHbOXxCm
         goJGvSk9Bzd3rh9cgpOZwdO0RDPaSI7JUEPhxPV/uXfAl09gRibWvgm1V0zKiFv0wWCZ
         gmsHbPd0swkT6UQGjspp2AdsQkIuGbUZjZEuwk2J7VllI6zVe21VnOJtFHlzebKcDrjQ
         1kOP6OHB1xvRcRhSReIigx8nwk+7+mMvjHtv/NE/IRN+Ybo5FuWPxz/IhEquZ8vZFJKE
         xxD7V81BSxT7J7UBGn1SeJr1hrVyBI7InnBOIrEVkskWxFSquJ211uhS06Y39bXAPEd7
         Ww4w==
X-Forwarded-Encrypted: i=1; AJvYcCULF35OIsFlWH2ao1qH68eqjOyieoizTE3ApkERfbvkNQg7nsVqpfLHBaziF3dXbQ2xI2W4ajnzjUvgl0+2LiOUDTqZNkvlvdYE
X-Gm-Message-State: AOJu0Yx5fafoW4SqrgB7IrfiXBjplepaTbkC7X+FUfRPaReifCf7dpKz
	Y5WX2QrEFOYmpKUGj+LuLhPcziIsArXdhFU9brIqzVh2FUunhgljGjVMeHk9Xhx4KUCyDvtb7uT
	hcDjPeV+sh03rxiHw9qpDWlPiPypU2+Mp4NJe
X-Google-Smtp-Source: AGHT+IEs1ykGyWpd9bWv0zuEtnDD6fLODh+Z8H3PEk3ZDG8Dsx0ZeeH/0Uf9MhgRXy6UD8+Wrar9mYVG/U5ZUTThPBM=
X-Received: by 2002:a05:6808:18e:b0:3c7:2616:554e with SMTP id
 w14-20020a056808018e00b003c72616554emr4071966oic.57.1714168929111; Fri, 26
 Apr 2024 15:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com>
 <20240424155309.1719454-13-ardb+git@google.com> <20240424182659.GA2126602@dev-arch.thelio-3990X>
 <pgsqflimo7d2ozhpmdrmscx25mxs5lypcvwq6mgjs7uixsxvsl@5papnq46mwbs> <20240426215351.GA3278657@dev-arch.thelio-3990X>
In-Reply-To: <20240426215351.GA3278657@dev-arch.thelio-3990X>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 26 Apr 2024 15:01:56 -0700
Message-ID: <CAFhGd8pasnTTv87V3LYpzCz=DdS8dXGA8Z9qGEqw=K+C_Xvf=A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] x86/purgatory: Simplify stack handling
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Eric Biederman <ebiederm@xmission.com>, 
	kexec@lists.infradead.org, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240426_150212_292488_7846B70B 
X-CRM114-Status: GOOD (  18.69  )
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

T24gRnJpLCBBcHIgMjYsIDIwMjQgYXQgMjo1M+KAr1BNIE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRo
YW5Aa2VybmVsLm9yZz4gd3JvdGU6Cj4KPiBPbiBGcmksIEFwciAyNiwgMjAyNCBhdCAwOTozMjo1
MlBNICswMDAwLCBKdXN0aW4gU3RpdHQgd3JvdGU6Cj4gPiBIaSwKPiA+Cj4gPiBPbiBXZWQsIEFw
ciAyNCwgMjAyNCBhdCAxMToyNjo1OUFNIC0wNzAwLCBOYXRoYW4gQ2hhbmNlbGxvciB3cm90ZToK
PiA+ID4gT24gV2VkLCBBcHIgMjQsIDIwMjQgYXQgMDU6NTM6MTJQTSArMDIwMCwgQXJkIEJpZXNo
ZXV2ZWwgd3JvdGU6Cj4gPiA+ID4gIGFyY2gveDg2L3B1cmdhdG9yeS9zdGFjay5TICAgICAgICB8
IDE4IC0tLS0tLS0tLS0tLS0tLS0tLQo+ID4gPgo+ID4gPiBUaGlzIG5lZWRzIGEgc21hbGwgZml4
IHVwIHRvIGJ1aWxkLgo+ID4gPgo+ID4gPiAgIG1ha2VbNl06ICoqKiBObyBydWxlIHRvIG1ha2Ug
dGFyZ2V0ICdhcmNoL3g4Ni9wdXJnYXRvcnkvc3RhY2subycsIG5lZWRlZCBieSAnYXJjaC94ODYv
cHVyZ2F0b3J5L3B1cmdhdG9yeS5ybycuCj4gPiA+Cj4gPgo+ID4gSSB3YXMgdHJ5aW5nIHRvIHJl
cHJvZHVjZSB0aGlzIGJ1aWxkIGZhaWx1cmUsIGJ1dCB0byBubyBhdmFpbC4gSSBhbQo+ID4gY3Vy
aW91cyB3aGF0IHlvdXIgYnVpbGQgdGFyZ2V0IC8gYnVpbGQgY29tbWFuZCB3YXMuCj4gPgo+ID4g
SXQgaXMgY2xlYXIgdGhhdCBzdGFjay5TIGhhcyBiZWVuIHJlbW92ZWQgc28geW91ciBjaGFuZ2Ug
bWFrZXMgc2Vuc2UsIEkKPiA+IGRvbid0IGRvdWJ0IHRoYXQgLS0gSSBqdXN0IGNhbm5vdCBnZXQg
dGhhdCBzcGVjaWZpYyBlcnJvciBtZXNzYWdlIHlvdQo+Cj4gT2RkLCBJIHdhcyB1c2luZyBteSBk
aXN0cmlidXRpb24gY29uZmlndXJhdGlvbiBmb3IgdGhlIHRlc3QgYnV0IGl0IGlzCj4gZWFzaWx5
IHJlcHJvZHVjaWJsZSB3aXRoIGFsbG1vZGNvbmZpZzoKPgo+ICAgJCBtYWtlIC1za2oiJChucHJv
YykiIEFSQ0g9eDg2XzY0IExMVk09MSBhbGxtb2Rjb25maWcgYXJjaC94ODYvcHVyZ2F0b3J5Lwo+
ICAgbWFrZVs2XTogKioqIE5vIHJ1bGUgdG8gbWFrZSB0YXJnZXQgJ2FyY2gveDg2L3B1cmdhdG9y
eS9zdGFjay5vJywgbmVlZGVkIGJ5ICdhcmNoL3g4Ni9wdXJnYXRvcnkvcHVyZ2F0b3J5LnJvJy4K
PiAgIC4uLgoKQWdoLCBJIHdhcyBqdXN0IGRvaW5nIGEgZGVmY29uZmlnIGZvbGxvd2VkIGJ5IGEg
bWVudWNvbmZpZyB0byBtYW51YWxseQplbmFibGUgYWxsIHRoZSBrZXhlYyBhbmQgcHVyZ2F0b3J5
IHN0dWZmLiBJIHdvbmRlciB3aGljaCBvbmUgSSBtaXNzZWQuCgphbGx5ZXMvYWxsbW9kY29uZmln
IGlzIHdoYXQgSSBuZWVkZWQgaGVyZSA6dGh1bWJzX3VwOgoKPgo+ID4gZW5jb3VudGVyZWQgKHdo
YXQgaXMgYSAucm8gZmlsZSBzdXBwb3NlZCB0byBiZSwgYW55d2F5PykuCj4KPiBSZWFkIG9ubHk/
IFJlbG9jYXRhYmxlIG9iamVjdD8gKnNocnVnKgo+Cj4gQ2hlZXJzLAo+IE5hdGhhbgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBs
aXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
