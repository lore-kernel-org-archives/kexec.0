Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE12BC6FA8F
	for <kexec@archiver.kernel.org>; Wed, 30 Aug 2023 14:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pcqkg37l4ypQedHyw9/i+csijtFDmyVkUerIGufVn8Q=; b=s35UxV9px+6vAt
	nbW6WLcAmK5ReQDrD4kGzA8B+3OcVkjwnIdY54SH/9r4Pm8KdfVPXRmXJLwXJG+MT+Cp00TjBSWPk
	d/FSFUNUrLgiJy5wOcmjNbV7jjV0q+YIANIu6RoYb61rTGnMxUtCKgxNbT7+QW7KQBsDKUvVjQ6wi
	nXcZRYhkrnvIR0MYOpXRcwkb4k75k+8xpzD9C/mFzj++O47dsMO0dov/Bfj3u+7TvpwUIITTOwVOP
	STfnDCMtZf+ixjnb0JFTBXFADdc1/YNSzVk7vyoKdXDZdZwuBEns7V5jfcuqu7Cpb1WBrCBGes6i6
	lO8LxZF7j0cJVmZJw8qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbLvO-00DeZ4-2P;
	Wed, 30 Aug 2023 14:12:02 +0000
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbLvL-00DeYF-3A
	for kexec@lists.infradead.org;
	Wed, 30 Aug 2023 14:12:01 +0000
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-571194584e2so3458333eaf.3
        for <kexec@lists.infradead.org>; Wed, 30 Aug 2023 07:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693404717; x=1694009517; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkS0efXVCy8VZ5VmSKwsFXPwQqBxWGJyzZuacJMQHs0=;
        b=phEe/S9+JnbseuQzNEUcPpDF1TtxVLDxk5lSpHkkiyEnwgfkznVgzRF1IxZjKmHeWm
         +D4XmGNfdo4jvYPXjkpPXgmmsdu82YL0Mn/84jvHGxkHWxaLds4l4hfsP7TdYFVgQ3tB
         sMDCa5a1oq9haOmhuZEERmY4P5qXMVrwYVbz5O3FXkXGo13PX0ZOcqq9mVl5cHQdzqhO
         2xKB6/2zvSbgakFk2Gbbu3F+DyOWXZBMus7DXY1lMpETWZ0BQPa4F+pDM9O7/87cWNmC
         E8V1wQ69nJcjEp/QgPXuADpgTOhU1OCl9LjRNAAkiMrD6OUnmVtLLJo/RuBtYzdeEote
         80ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693404717; x=1694009517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkS0efXVCy8VZ5VmSKwsFXPwQqBxWGJyzZuacJMQHs0=;
        b=cCLKiAEzyCTImKK9VX+f7WOwho+yIqF7xNlfM9HYxwUWdEDe2AfG8h7l27+XxbF+WJ
         XgQ8WRYlYBcv0ULA21+WWnS7a1bXcNoj+vocna7Y6JHbwfHyWvUqilXp/QvDHBv+KEfi
         z4E4sZotMCvB08JI8AovkMEX5E/gsVY1uhaw52/plCdvnp257mjR4XAn6k8I5IZ+R0Mw
         ZOaTtDtBdBaBKLb70tV39MuqNOFQeZSZMV305mBOXmz7LSwt+ZKxqybKzfPxXwPJqGFQ
         LZFv5Ji2BUpwKDPcvkBID+DGyOVybMNTiV3DLQmWKde2sH9yH4d3uZgvnicTxBy4KkKg
         nTfg==
X-Gm-Message-State: AOJu0YxADrWs4lc7qrGjbxbKxAbLefnly48k3z9nC+o+Su8UIXRNSzd8
	v+uCT2QxFe49Z5WgLyl/CaxukgS3PMYWJ9f3SfM=
X-Google-Smtp-Source: AGHT+IGbT74tfz3VyfVut6ethLJwLvDm6Tl7JSJUbcDNwD+fiygq/r9pK7Rbz0oaYOoffpJo/r8wDHC3auZoXajOIhc=
X-Received: by 2002:a4a:d213:0:b0:570:be00:5e14 with SMTP id
 c19-20020a4ad213000000b00570be005e14mr2163595oos.8.1693404717504; Wed, 30 Aug
 2023 07:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693386602.git.pstanner@redhat.com> <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
In-Reply-To: <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 30 Aug 2023 17:11:21 +0300
Message-ID: <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20230830_071200_025156_29E944DA 
X-CRM114-Status: GOOD (  17.80  )
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

T24gV2VkLCBBdWcgMzAsIDIwMjMgYXQgNDo0NuKAr1BNIFBoaWxpcHAgU3Rhbm5lciA8cHN0YW5u
ZXJAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBDdXJyZW50bHksIHVzZXIgYXJyYXkgZHVwbGljYXRp
b25zIGFyZSBzb21ldGltZXMgZG9uZSB3aXRob3V0IGFuCj4gb3ZlcmZsb3cgY2hlY2suIFNvbWV0
aW1lcyB0aGUgY2hlY2tzIGFyZSBkb25lIG1hbnVhbGx5OyBzb21ldGltZXMgdGhlCj4gYXJyYXkg
c2l6ZSBpcyBjYWxjdWxhdGVkIHdpdGggYXJyYXlfc2l6ZSgpIGFuZCBzb21ldGltZXMgYnkgY2Fs
Y3VsYXRpbmcKPiBuICogc2l6ZSBkaXJlY3RseSBpbiBjb2RlLgo+Cj4gSW50cm9kdWNlIHdyYXBw
ZXJzIGZvciBhcnJheXMgZm9yIG1lbWR1cF91c2VyKCkgYW5kIHZtZW1kdXBfdXNlcigpIHRvCj4g
cHJvdmlkZSBhIHN0YW5kYXJkaXplZCBhbmQgc2FmZSB3YXkgZm9yIGR1cGxpY2F0aW5nIHVzZXIg
YXJyYXlzLgo+Cj4gVGhpcyBpcyBib3RoIGZvciBuZXcgY29kZSBhcyB3ZWxsIGFzIHJlcGxhY2lu
ZyB1c2FnZSBvZiAodiltZW1kdXBfdXNlcigpCj4gaW4gZXhpc3RpbmcgY29kZSB0aGF0IHVzZXMs
IGUuZy4sIG4gKiBzaXplIHRvIGNhbGN1bGF0ZSBhcnJheSBzaXplcy4KCi4uLgoKPiAtLS0gYS9p
bmNsdWRlL2xpbnV4L3N0cmluZy5oCj4gKysrIGIvaW5jbHVkZS9saW51eC9zdHJpbmcuaAoKSSdt
IHdvbmRlcmluZyBpZiB0aGlzIGhhcyBubyBzaWRlLWVmZmVjdHMgYXMgc3RyaW5nLmgvc3RyaW5n
LmMgSUlSQyBpcwp1c2VkIGFsc28gZm9yIGVhcmx5IHN0YWdlcyB3aGVyZSBzb21lIG9mIHRoZSBB
UElzIGFyZSBub3QgYXZhaWxhYmxlLgoKPiBAQCAtNiw2ICs2LDggQEAKPiAgI2luY2x1ZGUgPGxp
bnV4L3R5cGVzLmg+ICAgICAgIC8qIGZvciBzaXplX3QgKi8KPiAgI2luY2x1ZGUgPGxpbnV4L3N0
ZGRlZi5oPiAgICAgIC8qIGZvciBOVUxMICovCj4gICNpbmNsdWRlIDxsaW51eC9lcnJuby5oPiAg
ICAgICAvKiBmb3IgRTJCSUcgKi8KPiArI2luY2x1ZGUgPGxpbnV4L292ZXJmbG93Lmg+ICAgIC8q
IGZvciBjaGVja19tdWxfb3ZlcmZsb3coKSAqLwo+ICsjaW5jbHVkZSA8bGludXgvZXJyLmg+ICAg
ICAgICAgLyogZm9yIEVSUl9QVFIoKSAqLwoKQ2FuIHdlIHByZXNlcnZlIG9yZGVyICh0byBzb21l
IGV4dGVudCk/Cgo+ICAjaW5jbHVkZSA8bGludXgvc3RkYXJnLmg+Cj4gICNpbmNsdWRlIDx1YXBp
L2xpbnV4L3N0cmluZy5oPgoKLi4uCgo+ICsvKioKPiArICogbWVtZHVwX2FycmF5X3VzZXIgLSBk
dXBsaWNhdGUgYXJyYXkgZnJvbSB1c2VyIHNwYWNlCgo+ICsgKgoKRG8gd2UgbmVlZCB0aGlzIGJs
YW5rIGxpbmU/Cgo+ICsgKiBAc3JjOiBzb3VyY2UgYWRkcmVzcyBpbiB1c2VyIHNwYWNlCj4gKyAq
IEBuOiBudW1iZXIgb2YgYXJyYXkgbWVtYmVycyB0byBjb3B5Cj4gKyAqIEBzaXplOiBzaXplIG9m
IG9uZSBhcnJheSBtZW1iZXIKPiArICoKPiArICogUmV0dXJuOiBhbiBFUlJfUFRSKCkgb24gZmFp
bHVyZS4gIFJlc3VsdCBpcyBwaHlzaWNhbGx5Cj4gKyAqIGNvbnRpZ3VvdXMsIHRvIGJlIGZyZWVk
IGJ5IGtmcmVlKCkuCj4gKyAqLwoKLi4uCgo+ICsvKioKPiArICogdm1lbWR1cF9hcnJheV91c2Vy
IC0gZHVwbGljYXRlIGFycmF5IGZyb20gdXNlciBzcGFjZQoKPiArICoKClJlZHVuZGFudD8KCj4g
KyAqIEBzcmM6IHNvdXJjZSBhZGRyZXNzIGluIHVzZXIgc3BhY2UKPiArICogQG46IG51bWJlciBv
ZiBhcnJheSBtZW1iZXJzIHRvIGNvcHkKPiArICogQHNpemU6IHNpemUgb2Ygb25lIGFycmF5IG1l
bWJlcgo+ICsgKgo+ICsgKiBSZXR1cm46IGFuIEVSUl9QVFIoKSBvbiBmYWlsdXJlLiAgUmVzdWx0
IG1heSBiZSBub3QKPiArICogcGh5c2ljYWxseSBjb250aWd1b3VzLiAgVXNlIGt2ZnJlZSgpIHRv
IGZyZWUuCj4gKyAqLwoKLS0gCldpdGggQmVzdCBSZWdhcmRzLApBbmR5IFNoZXZjaGVua28KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxp
bmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
