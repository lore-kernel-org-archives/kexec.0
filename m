Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FF0C3DA59
	for <kexec@archiver.kernel.org>; Mon, 22 Jul 2024 08:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jzug323eMUuTd82LXYBQ6y7yDs3IAnlMsvb1af/SQrE=; b=AebAF8PexNAK0E
	sJIlbEQQuLE0/8trVIwLTizAwlQVs0M5G5AJhXNLpbaC/Urs0wSapWu/jSR2r9c7aWYhHdGJC3vpt
	6tQbV8RXmPbL/3K5D2MQU/A9QbTkNp8HIhJ5baOrp6NzAu/cAZne9rcaLdBZUiwHYvyanXAmpTHOL
	r6W9r8fmVhRfIbNMVQCHdjoXbXM/rE/M+Q2LRgSi6v7vl1Siq+3uiLYSf8P791MbMWX05/NF0jkWj
	8awHAjzEjwhXfhI6Sfrk6VBhf0qf+St8RE47ePXVG6cCqSFcBz0irY4dS5+S7OdkNMBUeigzN8f3i
	N2RXv4C/he0R24osQnHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVonz-00000008x3h-0eVr;
	Mon, 22 Jul 2024 08:54:03 +0000
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVonv-00000008x2u-35oY
	for kexec@lists.infradead.org;
	Mon, 22 Jul 2024 08:54:01 +0000
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2ef2fbf1d14so5780091fa.1
        for <kexec@lists.infradead.org>; Mon, 22 Jul 2024 01:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721638438; x=1722243238; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xq4xW/tykOZSeJbzRCXFWoX/A8ocYj2aSyw2mhp2VvU=;
        b=MEEYGm+yb6APapKBjUfMd/zVWRFQV5zDdTH21dTHm7YtVDdlziNtYX6iuK6538Gqka
         r5cnoKhh78ySNmAByqZlrg3K1ouPVtyUxnyaywKlGnr2sNl6DDCXIyjDsJA0TGUqIah5
         ajk4WhPP4oRM+In5iP6jGnm7qebXF/0R3jHg3j1EEAFRC+ZbAw4l1lwiTktLPA42v6T3
         xsl3jAb62/pPCVYTz71mP79SH52zjnAeaM/UjrIrce83MjOMNGyK0fglwkx4BLATHElq
         OKB68iGkBT+K3Cv/xoqP/+nBKfu7PzFGAU43OIio8+HGqsXb8lQKyaMV8hSNWUt81ruW
         EOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721638438; x=1722243238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xq4xW/tykOZSeJbzRCXFWoX/A8ocYj2aSyw2mhp2VvU=;
        b=hGXHsYaYOxKwxbdDpxG5tw/IDhYAxKot8G0A3NQ0/p8ah5s8JskErEDx0TVFyaNU5X
         C/QU/O+cdrDK88x4l3NeljE0aHIiYpb8a1HXAw8x8JTn82OwDSdNGfkJ+mKKW2UndwVl
         Sz+lTW4Gk0x6abyioo7PmtvncP7xhUu9Nz51+hRuKW+RJ12TbDAvRmSGMnMmcl50MlCW
         WXzJOeJ8IorFI9xcrzEiPrhrovAndqcFA5nzh/fRG6vgHhTFyW+xKYs3VnI5N73nn0me
         WcxbMX7kUrIH4qtKsloisrGouiBhRFsHHjW/d5zwtMIpU4I4t263r+q77oCQ7T2dVSLZ
         EtBA==
X-Forwarded-Encrypted: i=1; AJvYcCXwDtb1CIluzpzk3ptCgSaQz2eAhpvkrbpfFHDkz3zvyfalMTSYG4dBJyH1GkCVH9cPw4uj3eF7Di2zu65JMaXDVmsr7X+g0kAY
X-Gm-Message-State: AOJu0YzeIO8Ka2GKZ6eGRd/WPH58xfTnbz64FNapfAUYrBtNrN96fi65
	EaKPNiUQ6eDKKF6/aLbUmoEhjP/+fhg6SAA1ol1dbtkvJjJFeJP8tVyIita3kKVwP/JRXC3Y/Kg
	nRwfoh26RrnHAwgZY63w4JsUHMUk=
X-Google-Smtp-Source: AGHT+IETygORyrcYxZ8FLrCL9rLmKgmqVnPFPIyt4gsRBxqRRUSroB6kqpJeQybleCAgxBRut1LoC6peW4FnoyzR5EE=
X-Received: by 2002:a2e:3217:0:b0:2ef:21a6:7c82 with SMTP id
 38308e7fff4ca-2ef21a67ff0mr15878521fa.20.1721638437357; Mon, 22 Jul 2024
 01:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240719103937.53742-1-ubizjak@gmail.com> <Zp3NXf9UBCtFKBsa@MiWiFi-R3L-srv>
In-Reply-To: <Zp3NXf9UBCtFKBsa@MiWiFi-R3L-srv>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 22 Jul 2024 10:53:45 +0200
Message-ID: <CAFULd4Y8vhcTWG-eNMSLEJHR_1=LuQzKj7q4JX8Kv7auJKAYDQ@mail.gmail.com>
Subject: Re: [PATCH] kexec: Use atomic_try_cmpxchg_acquire() in kexec_trylock()
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_015359_793380_FE5BDFE4 
X-CRM114-Status: GOOD (  12.44  )
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

T24gTW9uLCBKdWwgMjIsIDIwMjQgYXQgNTowOeKAr0FNIEJhb3F1YW4gSGUgPGJoZUByZWRoYXQu
Y29tPiB3cm90ZToKPgo+IE9uIDA3LzE5LzI0IGF0IDEyOjM4cG0sIFVyb3MgQml6amFrIHdyb3Rl
Ogo+ID4gVXNlIGF0b21pY190cnlfY21weGNoZ19hY3F1aXJlKCpwdHIsICZvbGQsIG5ldykgaW5z
dGVhZCBvZgo+ID4gYXRvbWljX2NtcHhjaGdfYWNxdWlyZSgqcHRyLCBvbGQsIG5ldykgPT0gb2xk
IGluIGtleGVjX3RyeWxvY2soKS4KPiA+IHg4NiBDTVBYQ0hHIGluc3RydWN0aW9uIHJldHVybnMg
c3VjY2VzcyBpbiBaRiBmbGFnLCBzbwo+ID4gdGhpcyBjaGFuZ2Ugc2F2ZXMgYSBjb21wYXJlIGFm
dGVyIGNtcHhjaGcuCj4KPiBTZWVtcyBpdCBjYW4gc2ltcGxpZnkgY29kZSBldmVuIHRob3VnaCBv
biBub24teDg2IGFyY2gsIHNob3VsZCB3ZQo+IHJlcGxhY2UgYXRvbWljX3RyeV9jbXB4Y2hnX2Fj
cXVpcmUoKSB3aXRoIGF0b21pY190cnlfY21weGNoZ19hY3F1aXJlKCkKPiBpbiBhbGwgc2ltaWxh
ciBwbGFjZXM/CgpZZXMsIHRoZSBjaGFuZ2UgaXMgYmVuZWZpY2lhbCBhbHNvIGZvciBub24teDg2
IGFyY2hpdGVjdHVyZXMsIHBsZWFzZQpzZWUgYW5hbHlzaXMgYXQgdGhyZWFkIFsxXS4gSSd2ZSBi
ZWVuIGxvb2tpbmcgdGhyb3VnaCB0aGUga2VybmVsCnNvdXJjZXMgZm9yIHRoZXNlIHBsYWNlcyBm
b3IgcXVpdGUgc29tZSB0aW1lLCBhbmQgSSBiZWxpZXZlIEkgaGF2ZQpjaGFuZ2VkIG1vc3Qgb2Yg
dGhlIHBsYWNlcy4gVGhlIGNoYW5nZSBpcyByZWxhdGl2ZWx5IHN0cmFpZ2h0Zm9yd2FyZCwKYW5k
IGltbWVkaWF0ZWx5IHJlc3VsdHMgaW4gYSBiZXR0ZXIgY29kZS4KClsxXSBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9sa21sLzg3MXF3Z21xd3MuZnNmQG1wZS5lbGxlcm1hbi5pZC5hdS8KCj4KPiBG
b3IgdGhpcyBvbmUsCj4KPiBBY2tlZC1ieTogQmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+CgpU
aGFua3MsClVyb3MuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
