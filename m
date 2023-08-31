Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D70DC83F01
	for <kexec@archiver.kernel.org>; Thu, 31 Aug 2023 13:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2Q+Bbd71YpvOPJKuml7wKJlJf3Go98ese2Wlbxgqcjo=; b=twivA2HxSFnnnm
	4S6wNtwdMxdJ3N4vjBVXQC97ZYE/QIUBLUzz04YZKd+b9ZnvNSQFBFyphYYcXMKNNK1RNwdIzugxF
	SBtFra53ir9EypKJOEk6O4dUBAjxp5JiL1BlCl1BzQ2RIbJSjO5ZB5QXT9vMS8WZhCYMcMrbFsRlB
	NM+Q2eBXety+m/lFeld+XTkvqRcbxKDmWygM7ERcaeuGWh/C6AoirK6U5fP1RzBvDFvMTsqDVqxkb
	g2JvrMhnfwQPRfaDNoij+2MmLKp+m5+NPQzvZqLPVNRkLQoxQSe2sJkTYW2nJ7ZLKmft0VFgyix89
	jx1+9WhoYtgm55geg+qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbhZC-00FM9N-34;
	Thu, 31 Aug 2023 13:18:34 +0000
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbhZA-00FM8R-1s
	for kexec@lists.infradead.org;
	Thu, 31 Aug 2023 13:18:33 +0000
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-5733d431209so493412eaf.0
        for <kexec@lists.infradead.org>; Thu, 31 Aug 2023 06:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693487910; x=1694092710; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHwmmwrGfDSkCjztvNTCgRkwWwsnvAt3/1zqnbkw4UE=;
        b=XGtK3fmD7nJwaOBApPTz8t6QdmBXbd/Ls+TbbAnj398rwypSAItMgKdJvh+56bgLNq
         6FsOp6yuWo5cgd5mWca1jNGjm7e+ARo7srtKhXHIb/Da9n/HAYwWJo1HV/XChcblVSIX
         NKu9lsSAKUDugOF6V4cItMytcCMUtiGPpB5g2dHfjGuNnOgUJL0TJJ64N+RxJcwxHyCV
         15zzYLPlZchKACbCKCwA4ouKgKrfUKDf+Pkx5VAEjgBZX2VOpMp3Sy88BJJtmprykwMp
         9OaZ6qAV92+0KQdIzCm+n4VlPh1pKubwi9XtNxFegocKhHjNTptIWNWsEYGDxJptt1Ti
         S1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693487910; x=1694092710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHwmmwrGfDSkCjztvNTCgRkwWwsnvAt3/1zqnbkw4UE=;
        b=NwJvi1vWXe/sedU+6M2Gl4cKchgoxHu88ajziHLNoE68I3lnD9aEJ6WQR1tKwwhTcL
         GwmL5qEZpvPiFkV0a9LG05sbKy1AyEWZ/tMjpUSOgGR4RGO5/YGa4ZbBNY1il4eayMZ2
         NHlo8WlVFhtoPZZKqoEcx23JfQVKcRRgpJ6ATClpx8GCjEoOdgAtT5iHjRbu4Ob/Sgqa
         MxInpKI2rYYwzfv0DXVfvsiy1qWVVt+7YAzzSoV7EsrmOwFN5aG3s1Di9mjI36Rpo054
         khZmSJDTihAlRp8Bd350dJ71tDuPcKKPvd43O7zZzqI4ILtsNNFNEdoqcnlf6/N40Khy
         dV1w==
X-Gm-Message-State: AOJu0YxIa8J8lBV4GkseYeXGZn3Nt00ePKtafNJSO3zZqPRR6t9hK6vL
	XLACNKx9QrvGeBGJsaWG2ecgg8oH0mEHUwPRVdU=
X-Google-Smtp-Source: AGHT+IEKwsKaxX8FN7thNvTRv4YUKZ/hXURRhwTFIgLKkuYrezXPSfhwY/Atro+sW4IO7Vj76e+t2OY3b1M7LZ7lpJE=
X-Received: by 2002:a4a:3013:0:b0:56d:e6:21bf with SMTP id q19-20020a4a3013000000b0056d00e621bfmr5008308oof.0.1693487910302;
 Thu, 31 Aug 2023 06:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693386602.git.pstanner@redhat.com> <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
 <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com>
 <94b893ef37fe0cc0bcc52e8b54c62be3853a7bbb.camel@redhat.com> <CAHp75VcNyE9uJu8-v2eVWRdZ3-nm2r-kdxE-naQB4VN6zxPFxg@mail.gmail.com>
In-Reply-To: <CAHp75VcNyE9uJu8-v2eVWRdZ3-nm2r-kdxE-naQB4VN6zxPFxg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 31 Aug 2023 16:17:54 +0300
Message-ID: <CAHp75Vc6Bj87V5HVZeNXJRmN1qBYP8_eDDSj5tLnfL7d81o9+w@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20230831_061832_622777_BBD6AF04 
X-CRM114-Status: GOOD (  23.23  )
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

T24gVGh1LCBBdWcgMzEsIDIwMjMgYXQgNDoxNuKAr1BNIEFuZHkgU2hldmNoZW5rbwo8YW5keS5z
aGV2Y2hlbmtvQGdtYWlsLmNvbT4gd3JvdGU6Cj4gT24gVGh1LCBBdWcgMzEsIDIwMjMgYXQgMzoy
MuKAr1BNIFBoaWxpcHAgU3Rhbm5lciA8cHN0YW5uZXJAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiBP
biBXZWQsIDIwMjMtMDgtMzAgYXQgMTc6MTEgKzAzMDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToK
PiA+ID4gT24gV2VkLCBBdWcgMzAsIDIwMjMgYXQgNDo0NuKAr1BNIFBoaWxpcHAgU3Rhbm5lciA8
cHN0YW5uZXJAcmVkaGF0LmNvbT4KPiA+ID4gd3JvdGU6CgouLi4KCj4gPiA+IEknbSB3b25kZXJp
bmcgaWYgdGhpcyBoYXMgbm8gc2lkZS1lZmZlY3RzIGFzIHN0cmluZy5oL3N0cmluZy5jIElJUkMK
PiA+ID4gaXMgdXNlZCBhbHNvIGZvciBlYXJseSBzdGFnZXMgd2hlcmUgc29tZSBvZiB0aGUgQVBJ
cyBhcmUgbm90IGF2YWlsYWJsZS4KPiA+Cj4gPiBJIGZvcmdvdCB0byBhZGRyZXNzIHRoaXMgcG9p
bnQgaW4gbXkgcHJldmlvdXMgcmVwbHkuCj4gPgo+ID4gV2hvJ3MgZ29pbmcgdG8gZGVjaWRlIHdo
ZXRoZXIgdGhpcyBpcyBhIHByb2JsZW0gb3Igbm90Pwo+ID4KPiA+IE15IHBlcnNvbmFsIGd1ZXNz
IGlzIHRoYXQgdGhpcyBpcyB1bmxpa2VseSB0byBiZSBhIHByb2JsZW0gYmVjYXVzZQo+ID4KPiA+
ICAgIEEuIGVpdGhlciAodiltZW1kdXBfdXNlcigpIGlzIGF2YWlsYWJsZSwgaW4gd2hpY2ggY2Fz
ZQo+ID4gICAgICAgKHYpbWVtZHVwX2FycmF5X3VzZXIoKSB3aWxsIGFsd2F5cyB3b3JrIOKAkwo+
ID4gICAgQi4gb3IgKHYpbWVtZHVwX3VzZXIoKSBpcyBub3QgYXZhaWxhYmxlLCB3aGljaCB3b3Vs
ZCBjYXVzZSB0aGUgY29kZQo+ID4gICAgICAgdGhhdCBjdXJyZW50bHkgdXNlcyAodiltZW1kdXBf
dXNlcigpIGZvciBjb3B5aW5nIGFycmF5cyB0byBmYWlsCj4gPiAgICAgICBhbnl3YXlzLgo+Cj4g
SXQgYWxzbyB1c2VzIHNvbWV0aGluZyBmcm9tIG92ZXJmbG93LmguIEkgZG9uJ3QgcmVtZW1iZXIg
aWYgdGhhdAo+IGhlYWRlciB3YXMgZXZlciBiZWVuIHVzZWQgaW4gZWFybHkgc3RhZ2UgbW9kdWxl
cyAobGlrZQo+IGJvb3QvZGVjb21wcmVzc29yKS4KCkFsc28gd2UgbmVlZCB0byBiZSBzdXJlIFVN
TCBpcyBzdGlsbCBidWlsZGFibGUuIER1bm5vIGlmIHRoZXkgYXJlCnVzaW5nIGFueXRoaW5nIGZy
b20gdGhpcywgYnV0IGl0IGFwcGVhcmVkIHRvIG1lIHJlY2VudGx5IHRoYXQgc29tZW9uZQp0cmll
ZCB0byBvcHRpbWl6ZSBzb21ldGhpbmcgdXNpbmcgKGludGVybmFsKSBrZXJuZWwgaGVhZGVycyBh
bmQgYnJva2UKdGhlIGJ1aWxkIGluIHNvbWUgY2FzZXMuCgotLSAKV2l0aCBCZXN0IFJlZ2FyZHMs
CkFuZHkgU2hldmNoZW5rbwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
