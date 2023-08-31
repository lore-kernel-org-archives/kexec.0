Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15CCC83F12
	for <kexec@archiver.kernel.org>; Thu, 31 Aug 2023 13:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xQ2hOhO9goHFEkca0tjBLnIaCL23jiQGRjlTXZc8R4s=; b=Uqu5Z6Og3G5o9e
	7u30o7+zCdusc+CeiG/aZ0hNQ/w+qq8olPb8YQScRw74Hmn/tzxDgGecSyaHWfyO8y8KgEEIpZwlp
	bf6UIgeHmvfSCnLstGC8L0AoEf/8xSZVJcAba8MLdyRr/UMwz0MZEPjiH/9qiZ9r5q+pYppWe7uV8
	LliCHDzodVEIply2lRf7zMTvTynoBKzjADP/pxxK/wVsR/5wdXBeyHGr+7SjXTg1N90lrK2i/0GWi
	0C89Ff8naHa7T9a7yJOVafQlVLfujglvB9M12wz9E2yPRMkfUMBz24TW1NUHq1bej0X6C2ECdWkDO
	CZZtIpuhCC2opsgSojMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbhXj-00FLwa-2A;
	Thu, 31 Aug 2023 13:17:03 +0000
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbhXh-00FLui-0v
	for kexec@lists.infradead.org;
	Thu, 31 Aug 2023 13:17:02 +0000
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a9f87adfe1so477415b6e.1
        for <kexec@lists.infradead.org>; Thu, 31 Aug 2023 06:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693487814; x=1694092614; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvjEwhjKTzM24zTtto0X2hNb/4jBUMlTIyxRYyU31F8=;
        b=q62XRHAvTfuENG6hhJ25LJnGZ5XP9HZ1i9tpc+PK5tNbepP0K8/Pi97Gi6Kbzf7E3N
         tM/XyXNLP5N4yKcdAe6ksnTjDFVTP9SVl2JMP9rqieaqgmjELjcswzPluDZPBb/YdF2D
         nTSL+wrvp7etFoUOojx/NGJEqH0D5atr5WFFPbtz/fgOtonBRA8qJkRv4YXlcoIYXCdg
         c2yy7iVCWwwDqJsl1DDySBcDEoCqeq9zzgKS/9qUYhwt8OztViY4CWeXv9l+mGusawVA
         UWxPDgAIRQnb/Ff9Dlh5XHf8vm621HgHCxd3hmCvsj4yAG/gQ4LIAH22MqWD65LCNqbw
         mbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693487814; x=1694092614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvjEwhjKTzM24zTtto0X2hNb/4jBUMlTIyxRYyU31F8=;
        b=KOMxGG0cNZkIP5VXYrUHZaFIbDfJmHY3kJ+alrv17Wj0gOm36aR/m86xz0f6D1ir3M
         UnlspmFQrfq6J0iq+Ps1LSaDOiwB9j3ogF2LlJikV7RGDnc3HIoaNjqCpy65MvZYNGFu
         VAV/jnsW9yG8mJ0GGf/sj8J7vwun9jDwrcRgaLLHcSnBtNdrQ0J2C0v11UpEe76rB5/F
         L8Am9PikaTsUqDFlaX2NJy9mq4KyuKLQTiCu1jCNbFtX7SLZSyVU8pieynSAGnZmxcVt
         MKT+7792JnktS2n0XVeUWiDOHWVMIni78l0y0Rka4tTTj7bWOlPlKnvgAV8RFy2XAri9
         u/Mw==
X-Gm-Message-State: AOJu0YyUdXyeFl3FNmBVOZPa+rX9Rez9mvwglmuM71flD+sdx58OTMmF
	69hKsup1xKbtn2m+R7+uKU4t/narXnPLW10IZjA=
X-Google-Smtp-Source: AGHT+IE2FhmXyXLAGk+I6c1o0xIfxttEXs+4SdO383eHQBc9YsKQBViTBEroy3HH+mR8crJU8XS0nKNDFuN6ocnrv+8=
X-Received: by 2002:a05:6808:b:b0:3a3:91f8:d3da with SMTP id
 u11-20020a056808000b00b003a391f8d3damr5224234oic.13.1693487814147; Thu, 31
 Aug 2023 06:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693386602.git.pstanner@redhat.com> <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
 <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com> <94b893ef37fe0cc0bcc52e8b54c62be3853a7bbb.camel@redhat.com>
In-Reply-To: <94b893ef37fe0cc0bcc52e8b54c62be3853a7bbb.camel@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 31 Aug 2023 16:16:17 +0300
Message-ID: <CAHp75VcNyE9uJu8-v2eVWRdZ3-nm2r-kdxE-naQB4VN6zxPFxg@mail.gmail.com>
Subject: Re: [PATCH 1/5] string.h: add array-wrappers for (v)memdup_user()
To: Philipp Stanner <pstanner@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Andy Shevchenko <andy@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Christian Brauner <brauner@kernel.org>, 
	David Disseldorp <ddiss@suse.de>, Luis Chamberlain <mcgrof@kernel.org>, Siddh Raman Pant <code@siddh.me>, 
	Nick Alcock <nick.alcock@oracle.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Zack Rusin <zackr@vmware.com>, 
	VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-hardening@vger.kernel.org, David Airlie <airlied@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230831_061701_322671_8642FEC6 
X-CRM114-Status: GOOD (  19.19  )
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

T24gVGh1LCBBdWcgMzEsIDIwMjMgYXQgMzoyMuKAr1BNIFBoaWxpcHAgU3Rhbm5lciA8cHN0YW5u
ZXJAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gV2VkLCAyMDIzLTA4LTMwIGF0IDE3OjExICswMzAw
LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6Cj4gPiBPbiBXZWQsIEF1ZyAzMCwgMjAyMyBhdCA0OjQ2
4oCvUE0gUGhpbGlwcCBTdGFubmVyIDxwc3Rhbm5lckByZWRoYXQuY29tPgo+ID4gd3JvdGU6Cgou
Li4KCj4gPiBJJ20gd29uZGVyaW5nIGlmIHRoaXMgaGFzIG5vIHNpZGUtZWZmZWN0cyBhcyBzdHJp
bmcuaC9zdHJpbmcuYyBJSVJDCj4gPiBpcyB1c2VkIGFsc28gZm9yIGVhcmx5IHN0YWdlcyB3aGVy
ZSBzb21lIG9mIHRoZSBBUElzIGFyZSBub3QgYXZhaWxhYmxlLgo+Cj4gSSBmb3Jnb3QgdG8gYWRk
cmVzcyB0aGlzIHBvaW50IGluIG15IHByZXZpb3VzIHJlcGx5Lgo+Cj4gV2hvJ3MgZ29pbmcgdG8g
ZGVjaWRlIHdoZXRoZXIgdGhpcyBpcyBhIHByb2JsZW0gb3Igbm90Pwo+Cj4gTXkgcGVyc29uYWwg
Z3Vlc3MgaXMgdGhhdCB0aGlzIGlzIHVubGlrZWx5IHRvIGJlIGEgcHJvYmxlbSBiZWNhdXNlCj4K
PiAgICBBLiBlaXRoZXIgKHYpbWVtZHVwX3VzZXIoKSBpcyBhdmFpbGFibGUsIGluIHdoaWNoIGNh
c2UKPiAgICAgICAodiltZW1kdXBfYXJyYXlfdXNlcigpIHdpbGwgYWx3YXlzIHdvcmsg4oCTCj4g
ICAgQi4gb3IgKHYpbWVtZHVwX3VzZXIoKSBpcyBub3QgYXZhaWxhYmxlLCB3aGljaCB3b3VsZCBj
YXVzZSB0aGUgY29kZQo+ICAgICAgIHRoYXQgY3VycmVudGx5IHVzZXMgKHYpbWVtZHVwX3VzZXIo
KSBmb3IgY29weWluZyBhcnJheXMgdG8gZmFpbAo+ICAgICAgIGFueXdheXMuCgpJdCBhbHNvIHVz
ZXMgc29tZXRoaW5nIGZyb20gb3ZlcmZsb3cuaC4gSSBkb24ndCByZW1lbWJlciBpZiB0aGF0Cmhl
YWRlciB3YXMgZXZlciBiZWVuIHVzZWQgaW4gZWFybHkgc3RhZ2UgbW9kdWxlcyAobGlrZQpib290
L2RlY29tcHJlc3NvcikuCgotLSAKV2l0aCBCZXN0IFJlZ2FyZHMsCkFuZHkgU2hldmNoZW5rbwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFp
bGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
