Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7522C43334
	for <kexec@archiver.kernel.org>; Thu, 23 Jun 2022 11:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aN2qH8lnyYm3Y+JDuJMueLGwj49VQf4H/JhUGBs+Rmo=; b=bALn4qBJcpCGKP
	RJKOsP0J0wtyJiLoq66Q3LC7yiCBZUO0Vl+KfLCpvwLcKXV5RdMv7p6OwM1Kzwe3I3m3gC1W7YVWy
	Kiv1B8gRZ/72tboTiHAh7YK4gxyR8aNKWlWVwcFfvNMrDKH4eAFbx0y0h1/2povTTYu8bpGz1Kzdx
	rWU8kVXOY3pvZdj+yJFtU1iZvKzcwtM0sjwFOjdJwcMrUt5jCcprWirNBhlFPzNXP6RhlbHmwbAsT
	Y2UpjMhQB39mztJmCsl+m2HMLhgutRTHqD58+WDpGy6gmsMuGxjC7HWeeHCtuk++Z7r0qJOAmG8ki
	fkKFSezPMtoVogcR2bDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4LC0-00EkMr-14; Thu, 23 Jun 2022 11:40:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4LBw-00EkKD-Mu
	for kexec@lists.infradead.org; Thu, 23 Jun 2022 11:40:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655984401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C3uXJWHIFEsUlxqCHW/QDb8EVa4+GiFC6Od24kRlHAY=;
	b=QHOJVGYjUFs8XU9T6tlaNsUJJnXuOF0vW+v26w3fmwYNe1OwUErCykeJ2DG9Mc1HnXTmJb
	DjzdNqjZwGinJYEvy3ntyoVBph60g034dDX5OYuVl8CZcB3Zlg0x6ucO+Yq785SqjNiAwL
	7ZcNgqL7JLdXIzp2IjdHX7NvW0RfCDw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-f-bLpBBkNTSx9YA8NqgD_g-1; Thu, 23 Jun 2022 07:40:00 -0400
X-MC-Unique: f-bLpBBkNTSx9YA8NqgD_g-1
Received: by mail-wm1-f70.google.com with SMTP id k28-20020a05600c1c9c00b003a0308775faso889466wms.1
        for <kexec@lists.infradead.org>; Thu, 23 Jun 2022 04:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=pXX1Tci8u6uSkWlCeJ6TegtPSfgMP3wYaXXEz0pOrgM=;
        b=X/GCYj6uZrMn1PY0F/NzmWunH6W8L+GbxkIyXDNQijExaLYKt+J+1//sVX+lp1XJSa
         coh8JSZBpXDEvrWf3NJNbsK4Cvj9q9nW6uITvcCNhmaBRqHbpuEvxmTXBhaQv8Z6w+b6
         Nw+F+0CJVDb4+qHKm6Qx7IITwU2s2j3x7L3/r8oWtDYiNYhNTbdov7H5Kb9wfoA+zGrB
         egAtL78l+4/wxUdcPVIHVG9OfBRgxOPAYj30A+yBUe2fvSQXJuXOdOlVFHRmND6UZcma
         9O0M8EbDah4HRPQTRdAS7zVsX2AMlwYXDHTsIk9z9qs2yGI5L/dtxKyAi+qAprzn0UII
         /hew==
X-Gm-Message-State: AJIora9iWFhgALd7uL6eu/XRHvFe9iweYevyAvxMC+WBaQYOHQLfdZ9G
	9DIWMn/zEDrWjtDd7yWiTKVlmXF9N9b+AaWf3BqcgeMnZi3rzbYL6MHw9+pMzdcq8mohHCn3aNS
	88X5Gbc4h4246nx6mXhCJ
X-Received: by 2002:adf:dece:0:b0:21b:a4b0:f7e3 with SMTP id i14-20020adfdece000000b0021ba4b0f7e3mr4817784wrn.197.1655984399533;
        Thu, 23 Jun 2022 04:39:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sK/dnm6ZYIya+uSaMaOutOXp1zODWOwg9uNXRImx0f7YrOK+SdjBXJeYaIC5fXn2ZDefBv4A==
X-Received: by 2002:adf:dece:0:b0:21b:a4b0:f7e3 with SMTP id i14-20020adfdece000000b0021ba4b0f7e3mr4817761wrn.197.1655984399335;
        Thu, 23 Jun 2022 04:39:59 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id h30-20020adfaa9e000000b0020c7ec0fdf4sm27013707wrc.117.2022.06.23.04.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 04:39:58 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-rt-users@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>, Thomas
 Gleixner <tglx@linutronix.de>, Juri Lelli <jlelli@redhat.com>, "Luis
 Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
In-Reply-To: <YrQzB7sPD8BNxSFq@linutronix.de>
References: <20220620111520.1039685-1-vschneid@redhat.com>
 <YrQzB7sPD8BNxSFq@linutronix.de>
Date: Thu, 23 Jun 2022 12:39:57 +0100
Message-ID: <xhsmhy1xn622a.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vschneid@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220623_044008_870759_A85735A7 
X-CRM114-Status: GOOD (  15.65  )
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

T24gMjMvMDYvMjIgMTE6MzEsIFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3Igd3JvdGU6Cj4gT24g
MjAyMi0wNi0yMCAxMjoxNToyMCBbKzAxMDBdLCBWYWxlbnRpbiBTY2huZWlkZXIgd3JvdGU6Cj4+
IEF0dGVtcHRpbmcgdG8gZ2V0IGEgY3Jhc2ggZHVtcCBvdXQgb2YgYSBkZWJ1ZyBQUkVFTVBUX1JU
IGtlcm5lbCB2aWEgYW4gTk1JCj4+IHBhbmljKCkgZG9lc24ndCB3b3JrLiBUaGUgY2F1c2Ugb2Yg
dGhhdCBsaWVzIGluIHRoZSBQUkVFTVBUX1JUIGRlZmluaXRpb24KPj4gb2YgbXV0ZXhfdHJ5bG9j
aygpOgo+PiAKPiDigKYKPgo+PiBGaXhlczogNmNlNDdmZDk2MWZhICgicnRtdXRleDogV2FybiBp
ZiB0cnlsb2NrIGlzIGNhbGxlZCBmcm9tIGhhcmQvc29mdGlycSBjb250ZXh0IikKPj4gU2lnbmVk
LW9mZi1ieTogVmFsZW50aW4gU2NobmVpZGVyIDx2c2NobmVpZEByZWRoYXQuY29tPgo+Cj4gUmV2
aWV3ZWQtYnk6IFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3IgPGJpZ2Vhc3lAbGludXRyb25peC5k
ZT4KPgo+PiAtLS0KPj4gdjEgLT4gdjIKPj4gKysrKysrKysKPj4gCj4+IG8gQ2hhbmdlZCBmcm9t
IFBldGVyc29uLWxpa2Ugc3luY2hyb25pemF0aW9uIHRvIHNpbXBsZXIgYXRvbWljX2NtcHhjaGcK
Pj4gICAoUGV0cikKPj4gbyBTbGlnaHRseSByZXdvcmRlZCBjaGFuZ2Vsb2cKPj4gbyBBZGRlZCBG
aXhlczogdGFnLiBUZWNobmljYWxseSBzaG91bGQgYmUgdXAgdG8gc2luY2Uga2V4ZWMgY2FuIGhh
cHBlbgo+PiAgIGluIGFuIE5NSSwgYnV0IHRoYXQgaXNuJ3Qgc3VjaCBhIGNsZWFyIHRhcmdldAo+
Cj4gUlQtd2lzZSBpdCB3b3VsZCBiZSBuZWVkZWQgZm9yIGVhY2ggcmVsZWFzZS4KClNvIGdpdCB0
ZWxscyBtZSB0aGUgRml4ZXM6IGNvbW1pdCBkYXRlcyBmcm9tIHY0LjI7IGZyb20gWzFdIGFuZCBb
Ml0gSSBnZXQKdGhhdCBib3RoIGN1cnJlbnQgbG9uZ3Rlcm0gc3RhYmxlIGFuZCBzdGFibGUtcnQg
dHJlZXMgZ28gYXMgZmFyIGJhY2sgYXMKdjQuOSwgc28gSSdtIGd1ZXNzaW5nIGlmIHRoYXQgZ2V0
cyBwaWNrZWQgdXAgZm9yIHRoZSBzdGFibGUgdHJlZXMgdGhlbiBpdApzaG91bGQgbWFrZSBpdHMg
d2F5IGludG8gdGhlIHN0YWJsZSAtcnQgdHJlZXM/CgpbMV06IGh0dHBzOi8vd2lraS5saW51eGZv
dW5kYXRpb24ub3JnL3JlYWx0aW1lL3ByZWVtcHRfcnRfdmVyc2lvbnMKWzJdOiBodHRwczovL3d3
dy5rZXJuZWwub3JnL2NhdGVnb3J5L3JlbGVhc2VzLmh0bWwKCj4gVGhlcmUgaXMgYWxzbyBhIG11
dGV4X3VubG9jaygpIGluIGNhc2UgYW4gaW1hZ2UgaXMgbWlzc2luZy4gVGhpcyBjYW4gZ28KPiB2
aWEgdGhlIHNjaGVkdWxlciBpZiB0aGVyZSBpcyBhIHdhaXRlciB3aGljaCBkb2VzIG5vdCBsb29r
IGdvb2Qgd2l0aCB0aGUKPiBOTUkgaW4gdGhlIHBpY3R1cmUuCj4KPiBTZWJhc3RpYW4KCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5n
IGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
