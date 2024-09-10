Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798F7EB64DE
	for <kexec@archiver.kernel.org>; Tue, 10 Sep 2024 13:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=80b+TXrHhjBhf4Jyywwcy67PJES+F/PFpl9H1wYn0/I=; b=y2UuPRBT1Q9rsR
	krguhj0iI/xiQltCnJdfrwrPZu0+Av4m6cP2Y2QZXIBjFjdu+OYyU6l2WYKNmWhg68gmVH3995zje
	x/oRR+jlnZaXmJRuoHp3wgetdhsMVDQtoxzl09cF0cE4RU57msnmOJNznpIdHKEkQpMRLLwepic8C
	StHRWNF5Vjk0/iH9F+2LDg69nQt9hLrH4JEaAIdcnG82pU0wugX/yuRiWYVONJqb+qS5iaT4xR9dJ
	DT+m7exkbKof1Bu8fTrxfQ2ig6m/NAiiC4tcckom9zaNV4mVQcYjaLcQiErNsBsPI87XEBIY6TcFy
	rflIGB2wUGR3an2NzZnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so1OP-00000005nHk-31tv;
	Tue, 10 Sep 2024 13:58:53 +0000
Received: from mail-lf1-f41.google.com ([209.85.167.41])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so1OM-00000005nH4-2SPt
	for kexec@lists.infradead.org;
	Tue, 10 Sep 2024 13:58:52 +0000
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5365c512b00so971371e87.3
        for <kexec@lists.infradead.org>; Tue, 10 Sep 2024 06:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725976728; x=1726581528;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgIpDVcWYMf0vuk5YN9yMPDXZSWDvspzC2nEKP5HOCI=;
        b=xGBNJk9kd67uxd9S58wLXjgPwZsA9g8mKIBQ2QQYU8W3jInMaKQ+SOs6wwYPFyLsTH
         Eavf3P78h75cmVSrcgsB1Ia+1bhVqDb91hRlCPAex/A3fLlGFxp2YkaKDqmCeOh5IrZZ
         jiH2A6GGHreYOYCsJ4XPwofR4hdraJF6sp4E6/WMALPwR4BMA2dNt7TFEEPapueqfT9K
         3tz+lHp0scZNUbsgVXAnDVu72Jt1xbLq5zU7diik3qP9N/7KRsuZL2QTjGhB9RO/SQCw
         9oZHlEM9XpxzpABxjrTelJsxUJ9cyC7bR/qrSnzdm5cujDVk+lNic3+IJVy7T685qdvk
         ifQw==
X-Forwarded-Encrypted: i=1; AJvYcCXmuPyHxEwDj5HVk1HzJNR+d5X6MS6Uu4ZEyaQalxuruu7phRI/L2VLbXzY8FIP6q44M38RXw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyKhAJ1NtnnSzrsUwPoo8gAbK8het9x6/FCrj8rHaTcN6h86X4O
	OwtQTQ/1WPpSNV8mhcU9fLQ9zobA7r46E0UTqYUUaMLvnQG1N98Z
X-Google-Smtp-Source: AGHT+IHhEuv8mrvn4438U00xZWueYNo2K4Ra1vZJaFUb6cxmb836Wz2QI3yrmjwC9AzNyQBdfgDXfg==
X-Received: by 2002:a05:6512:2215:b0:530:e228:7799 with SMTP id 2adb3069b0e04-53658813717mr11032307e87.58.1725976727247;
        Tue, 10 Sep 2024 06:58:47 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d2593cffcsm486589666b.55.2024.09.10.06.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 06:58:46 -0700 (PDT)
Date: Tue, 10 Sep 2024 06:58:44 -0700
From: Breno Leitao <leitao@debian.org>
To: ardb@kernel.org, linux-efi@vger.kernel.org, kexec@lists.infradead.org,
	bhe@redhat.com, vgoyal@redhat.com, devel@edk2.groups.io,
	ebiederm@xmission.com
Cc: rppt@kernel.org, usamaarif642@gmail.com, gourry@gourry.net,
	rmikey@meta.com
Subject: EFI table being corrupted during Kexec
Message-ID: <20240910-juicy-festive-sambar-9ad23a@devvm32600>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_065850_651934_448E8294 
X-CRM114-Status: GOOD (  12.38  )
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

CldlJ3ZlIHNlZW4gYSBwcm9ibGVtIGluIHVwc3RyZWFtIGtlcm5lbCBrZXhlYywgd2hlcmUgYSBF
RkkgVFBNIGxvZyBldmVudCB0YWJsZQppcyBiZWluZyBvdmVyd3JpdHRlbi4gIFRoaXMgcHJvYmxl
bSBoYXBwZW4gb24gcmVhbCBtYWNoaW5lLCBhcyB3ZWxsIGFzIGluIGEKcmVjZW50IEVESzIgcWVt
dSBWTS4KCkRpZ2dpbmcgZGVlcCwgdGhlIHRhYmxlIGlzIGJlaW5nIG92ZXJ3cml0dGVuIGR1cmlu
ZyBrZXhlYywgbW9yZSBwcmVjaXNlbHkgd2hlbgpyZWxvY2F0aW5nIGtlcm5lbCAocmVsb2NhdGVf
a2VybmVsKCkgZnVuY3Rpb24pLgoKSSd2ZSBhbHNvIGZvdW5kIHRoYXQgdGhlIHRhYmxlIGlzIGJl
aW5nIHByb3Blcmx5IHJlc2VydmVkIHVzaW5nCm1lbWJsb2NrX3Jlc2VydmUoKSBlYXJseSBpbiB0
aGUgYm9vdCwgYW5kIHRoYXQgcmFuZ2UgZ2V0cyBvdmVyd3JpdHRlbiBsYXRlciBpbgpieSByZWxv
Y2F0ZV9rZXJuZWwoKS4gSW4gb3RoZXIgd29yZHMsIGtleGVjIGlzIG92ZXJ3cml0aW5nIGEgbWVt
b3J5IHRoYXQgd2FzCnByZXZpb3VzbHkgcmVzZXJ2ZWQgKGFzIG1lbWJsb2NrX3Jlc2VydmUoKSku
CgpVc2FtYSBmb3VuZCB0aGF0IGtleGVjIG9ubHkgaG9ub3VycyBtZW1vcnkgcmVzZXJ2YXRpb25z
IGZyb20gL3N5cy9maXJtd2FyZS9tZW1tYXAKd2hpY2ggY29tZXMgZnJvbSBlODIwX3RhYmxlX2Zp
cm13YXJlIHRhYmxlLgoKTG9va2luZyBhdCB0aGUgVFBNIHNwZWMsIEkgZm91bmQgdGhlIGZvbGxv
d2luZyBwYXJ0OgoKCUlmIHRoZSBBQ1BJIFRQTTIgdGFibGUgY29udGFpbnMgdGhlIGFkZHJlc3Mg
YW5kIHNpemUgb2YgdGhlIFBsYXRmb3JtIEZpcm13YXJlIFRDRyBsb2csCglmaXJtd2FyZSDigJxw
aW5z4oCdIHRoZSBtZW1vcnkgYXNzb2NpYXRlZCB3aXRoIHRoZSBQbGF0Zm9ybSBGaXJtd2FyZSBU
Q0cgbG9nLCBhbmQgcmVwb3J0cwoJdGhpcyBtZW1vcnkgYXMg4oCcUmVzZXJ2ZWTigJ0gbWVtb3J5
IHZpYSB0aGUgSU5UIDE1aC9FODIwIGludGVyZmFjZS4KCgpGcm9tOiBodHRwczovL3RydXN0ZWRj
b21wdXRpbmdncm91cC5vcmcvd3AtY29udGVudC91cGxvYWRzL1BDLUNsaWVudFBsYXRmb3JtX1By
b2ZpbGVfZm9yX1RQTV8ycDBfU3lzdGVtc192NDlfMTYxMTE0X3B1YmxpYy1yZXZpZXcucGRmCgpJ
IGFtIHdvbmRlcmluZyBpZiB0aGF0IG1lbW9yeSByZWdpb24vcmFuZ2Ugc2hvdWxkIGJlIHBhcnQg
b2YgZTgyMCB0YWJsZSB0aGF0IGlzCnBhc3NlZCBieSBFRkkgZmlybXdhcmUgdG8ga2VybmVsLCBh
bmQgaWYgaXQgaXMgbm90IHBhc3NlZCAoYXMgaXQgaXMgbm90IGJlaW5nCnBhc3NlZCB0b2RheSks
IHRoZW4gdGhlIGtlcm5lbCBkb2Vzbid0IG5lZWQgdG8gcmVzcGVjdCBpdCwgYW5kIGl0IGlzIGZy
ZWUgdG8Kb3ZlcndyaXRlIChhcyBpdCBkb2VzIHRvZGF5KS4gSW4gb3RoZXIgd29yZHMsIHRoaXMg
aXMgYSBmaXJtd2FyZSBidWcgYW5kIG5vdCBhCmtlcm5lbCBidWcuCgpBbSBJIG1pc3Npbmcgc29t
ZXRoaW5nPwoKVGhhbmtzCi0tYnJlbm8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
