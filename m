Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F79CC6FD1F
	for <kexec@archiver.kernel.org>; Sat, 30 Mar 2024 14:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B03jlmLxHIFHm2ZR5nFzVcaaWOd67JLOct+QaXusmso=; b=z9i4UlPt7jvWFP
	1W3wb4t8v5NCblvyOwh+VTAWNgSqt6qOWgZ9DLka/zihMggA/JAJGjifwXXvpDI19T9KsRHE5kp1k
	Zaj73LZNHd9C5UKrjcOdKNUgoKRZC5lBSzaUHKiYs55cHSBeUSHzUII4sSaBnCwp89922xKjDL2hO
	zbieA18DhDPlS3cdJtTwIa0+LStX9H5TkuJL5OlxDW6wAN4cCy/5nC5763Ub+fk6A0ogc2j4L9O9j
	42xYWLbADepTtauK9W7VdVExmTpucE/YtAyATzwAH4o+zSMlPayhWN54JBwz2ve8GAtKK1HMPcPl5
	pyB1nwKVAL2HB0dNv09w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqZFb-00000003apx-3cT4;
	Sat, 30 Mar 2024 14:00:03 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqZFY-00000003aoG-3wWf
	for kexec@lists.infradead.org;
	Sat, 30 Mar 2024 14:00:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 75D9E60B79
	for <kexec@lists.infradead.org>; Sat, 30 Mar 2024 13:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229CCC433C7
	for <kexec@lists.infradead.org>; Sat, 30 Mar 2024 13:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711807198;
	bh=FGD97a2BLDJE4wXb5b/jxGrqNvSwEG6LTQPxYP1fNkQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Vl8F1+0G66SuOSa0IW5EuQqh1sHWTEhu8p5uCySHbMMhanIpU9WGcRYZro87GsOi0
	 fW5I3bHSyNASIs9gHDTHdInBSI17sYC7w4x1lq8xxVwiFWZYRymZziMFeim3AIXwjr
	 XXTHeokxjMa0FMC23DKWe/UmDaqptQKoehC9kzYD63z+IVVhg1dEB0Y+gZ8AU1Nw0C
	 1bZR+4Maq9j99bXJDqNKBM34L6MnEwGH+L5efx9d8SzY3ohP+4AuMNBc9UMZQsyokU
	 yl4hCNk0C74QNCU+LykeGCBfBMqiqvddSRcs1N105u0+Kbh8vg1GRZF3NYuULDIUS7
	 8zslmdO9is0RA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a466e53f8c0so356611766b.1
        for <kexec@lists.infradead.org>; Sat, 30 Mar 2024 06:59:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YwMfbyZzA43l0XxQ/n8OT8ppfoe1MZzgytlCuEATUkvYso3n42v
	8562mPDKDmNxE17fkTIOtTPwf6IeZpLyA5+A/G2zbvIIqE4jYqlfnM84DqO3DGPKr4bN6JxBOyY
	YGS+sB3PUE/Hg7EkmZjus+Doejvk=
X-Google-Smtp-Source: AGHT+IHc3m2uZv7lcnXrkX1wRtlEpjeE35rVhJUzINHtpYXXLFAaIbzPIfaS5VBxQZkz1jOW3uw1Ht4ocwxkRM0QZUg=
X-Received: by 2002:a17:906:48c6:b0:a4e:4bb2:2ab1 with SMTP id
 d6-20020a17090648c600b00a4e4bb22ab1mr1372473ejt.20.1711807196707; Sat, 30 Mar
 2024 06:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240329132825.1102459-1-bhe@redhat.com> <20240329132825.1102459-2-bhe@redhat.com>
In-Reply-To: <20240329132825.1102459-2-bhe@redhat.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 30 Mar 2024 21:59:45 +0800
X-Gmail-Original-Message-ID: <CAAhV-H76-FOvcTXB_rW1B1wFthYK6txVtC+brfzk6nwOhar8iQ@mail.gmail.com>
Message-ID: <CAAhV-H76-FOvcTXB_rW1B1wFthYK6txVtC+brfzk6nwOhar8iQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arch/loongarch: clean up the left code and Kconfig
 item related to CRASH_CORE
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, akpm@linux-foundation.org, geert@linux-m68k.org, 
	WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240330_070001_201626_AB718492 
X-CRM114-Status: GOOD (  14.35  )
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

UXVldWVkLCB0aGFua3MuCgpIdWFjYWkKCk9uIEZyaSwgTWFyIDI5LCAyMDI0IGF0IDk6MjjigK9Q
TSBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBJbiBjb21taXQgODVmY2Rl
NDAyZGIxICgia2V4ZWM6IHNwbGl0IGNyYXNoa2VybmVsIHJlc2VydmF0aW9uIGNvZGUKPiBvdXQg
ZnJvbSBjcmFzaF9jb3JlLmMiKSwgY3Jhc2hrZXJuZWwgcmVzZXJ2YXRpb24gY29kZSBpcyBzcGxp
dCBvdXQgZnJvbQo+IGNyYXNoX2NvcmUuYywgYW5kIGFkZCBDUkFTSF9SRVNFUlZFIHRvIGNvbnRy
b2wgaXQuIEFuZCBhbHNvIHJlbmFtZSBlYWNoCj4gQVJDSCdzIDxhc20vY3Jhc2hfY29yZS5oPiB0
byA8YXNtL2NyYXNoX3Jlc2VydmUuaD4gYWNjb3JkaW5nbHkuCj4KPiBCdXQgdGhlIHJlbGV2YW50
IHBhcnQgaW4gbG9vbmdhcmNoIGlzIG1pc3NlZC4gRG8gaXQgbm93Lgo+Cj4gU2lnbmVkLW9mZi1i
eTogQmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+Cj4gQ2M6IEh1YWNhaSBDaGVuIDxjaGVuaHVh
Y2FpQGtlcm5lbC5vcmc+Cj4gQ2M6IFdBTkcgWHVlcnVpIDxrZXJuZWxAeGVuMG4ubmFtZT4KPiBD
YzogbG9vbmdhcmNoQGxpc3RzLmxpbnV4LmRldgo+IC0tLQo+ICBhcmNoL2xvb25nYXJjaC9LY29u
ZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAyICstCj4gIGFyY2gv
bG9vbmdhcmNoL2luY2x1ZGUvYXNtL3tjcmFzaF9jb3JlLmggPT4gY3Jhc2hfcmVzZXJ2ZS5ofSB8
IDQgKystLQo+ICAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkKPiAgcmVuYW1lIGFyY2gvbG9vbmdhcmNoL2luY2x1ZGUvYXNtL3tjcmFzaF9jb3JlLmggPT4g
Y3Jhc2hfcmVzZXJ2ZS5ofSAoNzUlKQo+Cj4gZGlmZiAtLWdpdCBhL2FyY2gvbG9vbmdhcmNoL0tj
b25maWcgYi9hcmNoL2xvb25nYXJjaC9LY29uZmlnCj4gaW5kZXggYTVmMzAwZWM2ZjI4Li41NGFk
MDRkYWNkZWUgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9sb29uZ2FyY2gvS2NvbmZpZwo+ICsrKyBiL2Fy
Y2gvbG9vbmdhcmNoL0tjb25maWcKPiBAQCAtNTk1LDcgKzU5NSw3IEBAIGNvbmZpZyBBUkNIX1NF
TEVDVFNfQ1JBU0hfRFVNUAo+ICAgICAgICAgc2VsZWN0IFJFTE9DQVRBQkxFCj4KPiAgY29uZmln
IEFSQ0hfSEFTX0dFTkVSSUNfQ1JBU0hLRVJORUxfUkVTRVJWQVRJT04KPiAtICAgICAgIGRlZl9i
b29sIENSQVNIX0NPUkUKPiArICAgICAgIGRlZl9ib29sIENSQVNIX1JFU0VSVkUKPgo+ICBjb25m
aWcgUkVMT0NBVEFCTEUKPiAgICAgICAgIGJvb2wgIlJlbG9jYXRhYmxlIGtlcm5lbCIKPiBkaWZm
IC0tZ2l0IGEvYXJjaC9sb29uZ2FyY2gvaW5jbHVkZS9hc20vY3Jhc2hfY29yZS5oIGIvYXJjaC9s
b29uZ2FyY2gvaW5jbHVkZS9hc20vY3Jhc2hfcmVzZXJ2ZS5oCj4gc2ltaWxhcml0eSBpbmRleCA3
NSUKPiByZW5hbWUgZnJvbSBhcmNoL2xvb25nYXJjaC9pbmNsdWRlL2FzbS9jcmFzaF9jb3JlLmgK
PiByZW5hbWUgdG8gYXJjaC9sb29uZ2FyY2gvaW5jbHVkZS9hc20vY3Jhc2hfcmVzZXJ2ZS5oCj4g
aW5kZXggMjE4YmRiZmE1MjdiLi5hMWQ5Yjg0YjFjN2QgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9sb29u
Z2FyY2gvaW5jbHVkZS9hc20vY3Jhc2hfY29yZS5oCj4gKysrIGIvYXJjaC9sb29uZ2FyY2gvaW5j
bHVkZS9hc20vY3Jhc2hfcmVzZXJ2ZS5oCj4gQEAgLTEsNiArMSw2IEBACj4gIC8qIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkgKi8KPiAtI2lmbmRlZiBfTE9PTkdBUkNIX0NS
QVNIX0NPUkVfSAo+IC0jZGVmaW5lIF9MT09OR0FSQ0hfQ1JBU0hfQ09SRV9ICj4gKyNpZm5kZWYg
X0xPT05HQVJDSF9DUkFTSF9SRVNFUlZFX0gKPiArI2RlZmluZSBfTE9PTkdBUkNIX0NSQVNIX1JF
U0VSVkVfSAo+Cj4gICNkZWZpbmUgQ1JBU0hfQUxJR04gICAgICAgICAgICAgICAgICAgIFNaXzJN
Cj4KPiAtLQo+IDIuNDEuMAo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
