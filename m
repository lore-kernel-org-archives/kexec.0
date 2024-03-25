Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C14C54E58
	for <kexec@archiver.kernel.org>; Mon, 25 Mar 2024 08:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=059YrpbxX9RWWzfbeRf9jbZjn+DkVp6hT1+tmOkCGh4=; b=46Onkv3WmZ4PHY
	PiykktdHWjRG1tbJucJL/rKpvIiua1bLvrxXqzl7D/gsBk3hItpcwr9IOvFQEIGrXzEy6RZ8pgIUe
	sf3UYJPI0pBKzRPH4Z87G6hAPwBizuKIVDRohMO/bsifP6kcuuKVyuGS2LiCqxUvspAh6WMWvOoYT
	HwINt3m1Mtsgr2oZoqYEyeSjcalbhEET36VT9gwwDQdn0KbPnY42iGKcSp/m5FTfsAernysTgfj5A
	fUuIfYeqjwBJkQImcM8JJfKlGaiqmvrlfbWGOarj7ZJsADXJivC8YipSyvhy5HCZUG7g8TXUCSYgi
	8b+7ObpfF0/dteb62y5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rofdb-0000000G8nN-423L;
	Mon, 25 Mar 2024 08:24:59 +0000
Received: from mail-yw1-f177.google.com ([209.85.128.177])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rofdX-0000000G8lA-0V9X;
	Mon, 25 Mar 2024 08:24:57 +0000
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60a0579a931so43543127b3.0;
        Mon, 25 Mar 2024 01:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711355091; x=1711959891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEfLIiCMu33AlwMloMoi4ICYWpFuuaEkY/DY4cDIgmE=;
        b=MuDAoncGAdicIWX3P2UeOxSoRJOo0DZq/LlZe1FY4rB0XLdaM5IyprmxcBgP9CDsWS
         5f4dAsZjcu7e1fjIGbH3c9lzBo4AilIyfhkNkL3NI2XeJwsrPoPYs4crtQ2ZewDQKgWv
         Hm3cEEKQ7s1Mk8wXRl8JFyRTeAlUCO2UjIpXlVthDx3xRdAeh1nhOO29+pqZgXF6Ts24
         7IzB0iHvN18A0o1d0h+zxNXORjIzAI/aPTXT95AGztvPknlsAQH6pP1aXV+LPROAOF9R
         iGG9jS1eQgte1wC90KNyahXgvB/IVi6Bctem0mElLQ9Cc7tB5lXwHW+maAaN3uWUhhuX
         9YBg==
X-Forwarded-Encrypted: i=1; AJvYcCUXXtJyYJTXMJhUZlw7SM+3JuatjTYgR8uSWbeSRdlHge4XsQ9WdIJmMJpoq7OeYYhw7r5IVjDk7eMrr0du6j2bysW/rArK4nWwn+i56KDLSFtBXd8s+WEMCHhygT3+yGcuGE08EYl/6ck+fuzdc2evdPzReoEp0AWX/MxKQdTqaCB+yt5aqi9QdU9f/lGYFHM=
X-Gm-Message-State: AOJu0YwrUJovnjqmyjM3D7n1Z7nf5SO/s44LWqqjQ70LsGFtqpxD/kya
	K7sBZD2JtKBz/m652VfjiItkU8yiJ9SEJSgS1TrPD6SFz/td40vwXH0nlFBDGr8=
X-Google-Smtp-Source: AGHT+IGPwF8W5gAud6P8cQb5dunS2q+i+0igxBIjR/aGpQ0AQQkM6ywDytrcNbaYT5AIdTqIv9cHww==
X-Received: by 2002:a0d:e703:0:b0:611:1456:c817 with SMTP id q3-20020a0de703000000b006111456c817mr4744649ywe.51.1711355091043;
        Mon, 25 Mar 2024 01:24:51 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id g6-20020a0dc406000000b0060cb9691f78sm959666ywd.52.2024.03.25.01.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 01:24:50 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60a068e26d8so46133667b3.3;
        Mon, 25 Mar 2024 01:24:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjtFPXE9w6qtE/UvaZvwPIm6z6vp9IaPHB1/7ns9blI4fKCFS/i2EutIbGqTFS886qJuulFeCxEN+QEmFI5C/12gXtdjg9GPgUrXxKrmtDElCHRF7tX2IxDJsMaqj3d+c73Yt8tJD3/LoOgEyC9b7wAQbjaLX2PUxqHWs94nhcrKrq2jGTqP3ztow9CxoGqj8=
X-Received: by 2002:a25:a2cf:0:b0:dcc:f0a:e495 with SMTP id
 c15-20020a25a2cf000000b00dcc0f0ae495mr4291545ybn.3.1711355089475; Mon, 25 Mar
 2024 01:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240124051254.67105-1-bhe@redhat.com> <20240124051254.67105-3-bhe@redhat.com>
In-Reply-To: <20240124051254.67105-3-bhe@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 25 Mar 2024 09:24:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVxKEGYj9C1=P-493vcrN_HmLNx8gS6i1nheXO9gH46oA@mail.gmail.com>
Message-ID: <CAMuHMdVxKEGYj9C1=P-493vcrN_HmLNx8gS6i1nheXO9gH46oA@mail.gmail.com>
Subject: Re: [PATCH linux-next v3 02/14] crash: split vmcoreinfo exporting
 code out from crash_core.c
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, 
	loongarch@lists.linux.dev, akpm@linux-foundation.org, ebiederm@xmission.com, 
	hbathini@linux.ibm.com, piliu@redhat.com, viro@zeniv.linux.org.uk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240325_012455_506106_B0631673 
X-CRM114-Status: GOOD (  19.68  )
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

SGkgQmFvcXVhbiwKCk9uIFdlZCwgSmFuIDI0LCAyMDI0IGF0IDY6MTPigK9BTSBCYW9xdWFuIEhl
IDxiaGVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gTm93IG1vdmUgdGhlIHJlbGV2YW50IGNvZGVzIGlu
dG8gc2VwYXJhdGUgZmlsZXM6Cj4ga2VybmVsL2NyYXNoX3Jlc2VydmUuYywgaW5jbHVkZS9saW51
eC9jcmFzaF9yZXNlcnZlLmguCj4KPiBBbmQgYWRkIGNvbmZpZyBpdGVtIENSQVNIX1JFU0VSVkUg
dG8gY29udHJvbCBpdHMgZW5hYmxpbmcuCj4KPiBBbmQgYWxzbyB1cGRhdGUgdGhlIG9sZCBpZmRl
ZmZlcnkgb2YgQ09ORklHX0NSQVNIX0NPUkUsIGluY2x1ZGluZyBvZgo+IDxsaW51eC9jcmFzaF9j
b3JlLmg+IGFuZCBjb25maWcgaXRlbSBkZXBlbmRlbmN5IG9uIENSQVNIX0NPUkUKPiBhY2NvcmRp
bmdseS4KPgo+IEFuZCBhbHNvIGRvIHJlbmFtaW5nIGFzIGZvbGxvd3M6Cj4gIC0gYXJjaC94eHgv
a2VybmVsL3tjcmFzaF9jb3JlLmMgPT4gdm1jb3JlX2luZm8uY30KPiBiZWNhdXNlIHRoZXkgYXJl
IG9ubHkgcmVsYXRlZCB0byB2bWNvcmVpbmZvIGV4cG9ydGluZyBvbiB4ODYsIGFybTY0LAo+IHJp
c2N2Lgo+Cj4gQW5kIGFsc28gUmVtb3ZlIGNvbmZpZyBpdGVtIENSQVNIX0NPUkUsIGFuZCByZWx5
IG9uIENPTkZJR19LRVhFQ19DT1JFIHRvCj4gZGVjaWRlIGlmIGJ1aWxkIGluIGNyYXNoX2NvcmUu
Yy4KPgo+IFNpZ25lZC1vZmYtYnk6IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQuY29tPgo+IC0tLQo+
IHYyLT52MzoKPiAtIFRoZXJlJ3MgY29uZmxpY3Qgd2hlbiByZWJhc2luZyB0byBsaW51eC1uZXh0
IGluIGtlcm5lbC9jcmFzaF9jb3JlLmMKPiAgIGJlY2F1c2Ugb2YgYmVsb3cgY29tbWl0cyBmcm9t
IFVsYWR6aXNsYXU6Cj4gICBjb21taXQgNjk5ZDkzNTE4MjJlICgibW06IHZtYWxsb2M6IEZpeCBh
IHdhcm5pbmcgaW4gdGhlIGNyYXNoX3NhdmVfdm1jb3JlaW5mb19pbml0KCkiKQo+ICAgY29tbWl0
IDVmNGMwYzFlMmE1MSAoOm1tL3ZtYWxsb2M6IHJlbW92ZSB2bWFwX2FyZWFfbGlzdCIpCgpUaGFu
a3MgZm9yIHlvdXIgcGF0Y2gsIHdoaWNoIGlzIG5vdyBjb21taXQgNDQzY2JhZjllMmZkYmVmNwoo
ImNyYXNoOiBzcGxpdCB2bWNvcmVpbmZvIGV4cG9ydGluZyBjb2RlIG91dCBmcm9tCmNyYXNoX2Nv
cmUuYyIpIGluIHY2LjktcmMxLgoKQWZ0ZXIgdGhpcywgdGhlcmUgYXJlIHN0aWxsIHR3byByZWZl
cmVuY2VzIGxlZnQgdG8gQ1JBU0hfQ09SRToKCiAgMS4gRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlk
ZS9rZHVtcC9rZHVtcC5yc3Q6CgogICAgICAgICBTdWJzZXF1ZW50bHksIENSQVNIX0NPUkUgaXMg
c2VsZWN0ZWQgYnkgS0VYRUNfQ09SRTo6CgogIDIuIGFyY2gvbG9vbmdhcmNoL0tjb25maWcKCiAg
ICAgICAgIGNvbmZpZyBBUkNIX0hBU19HRU5FUklDX0NSQVNIS0VSTkVMX1JFU0VSVkFUSU9OCiAg
ICAgICAgICAgICBkZWZfYm9vbCBDUkFTSF9DT1JFCgpHcntvZXRqZSxlZXRpbmd9cywKCiAgICAg
ICAgICAgICAgICAgICAgICAgIEdlZXJ0CgotLSAKR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJl
J3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZwoKSW4g
cGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNl
bGYgYSBoYWNrZXIuIEJ1dAp3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBz
YXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
a2V4ZWMK
