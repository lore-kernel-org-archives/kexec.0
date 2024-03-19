Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7166BC54E5D
	for <kexec@archiver.kernel.org>; Tue, 19 Mar 2024 13:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rCJEL2ldqRbWOZw0j+99gMRMa4/zFVKS+9YFYiCwrDg=; b=A2v4aVo5Jif+R+
	nOonoS/99Mn89k0TmTTGYqH6VUws/TeYlcUFcHL9Qzoe/l5r1nCEOUOYtcKuSQ8T80iixNV+hmmuk
	0i1l3e9Kr/78xjOSWHMMLw74UjM8ljEjUy3zVmXWjR/ZvBKCWYpbfObA8Gwj9kgSU5NvQ0BHpBrBn
	2SG8zTiY8ubmmz1IQ9Bj2fEFWtz25A02edcN5j3QN4yRptRZDMHrkNS20NGFzOxkPMUIkqe4MF4lf
	I7j65AQjIL6OMAoteRvKlp0VtzKrsQK66/Vh2wRz/q+TNVGmJx/lZ8OK4gop0sIVUmdUz6E/eIxqH
	Wd8QcgBFVQD9rUhdwHQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmZiF-0000000Cpz3-0iGr;
	Tue, 19 Mar 2024 13:41:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmZiB-0000000CpxL-1xN7
	for kexec@lists.infradead.org;
	Tue, 19 Mar 2024 13:41:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710855661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DOoHg4cHMBv0U+cGgq05M8kV7oKhTeBGztGMvwMOPk0=;
	b=EYxaIxEVOLDKGW6znL0sDaa63MY1fbg27ZkHg2H65NYJC1ZaH3znxtjHNd2EsgESniQox5
	LWh5WQgbJ24KiyTYjONpuW9OowKV8sXD9ziSn8uwnaox5wzJd2LOLz2YU0oQpF3zpgke/c
	wTXB6IuTZakr9p6Engs2XKt5dggEnpE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-weEuzjTpPdqYWXjFcmtu0A-1; Tue, 19 Mar 2024 09:39:17 -0400
X-MC-Unique: weEuzjTpPdqYWXjFcmtu0A-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-29de982f09aso3847644a91.1
        for <kexec@lists.infradead.org>; Tue, 19 Mar 2024 06:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710855557; x=1711460357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOoHg4cHMBv0U+cGgq05M8kV7oKhTeBGztGMvwMOPk0=;
        b=aMIePLWVADJN4ITJSGCDlhk1xzIWrYtgYTr1fgqvXlb2ukzJR2xRsStNZdU0alMruk
         xxAf+7Bw3+gETZMGseJ61A1h6gkQBFXNj4qypyPVohT4GQ2osnleDTqEJsYN6SQo8dMK
         nFNZkNwnsRAf3Cd7pw7SF3jVDZJJ9FN0xJzQizPft48N2tzPHnZSzTAqQOHgjpjsRake
         mFxe+cXEZW36pqR4aFxQR9Bu5NBUK22webDcCgTDuZWOIbNtAisawHmZ+xSkJHDFfsFV
         GHrUZWSU2PVTYho6GI3qc86BbTN7rzXPpu/EWVIcKhkYfi4AzPpN8XQK9oguv6iwqVhD
         8bEw==
X-Forwarded-Encrypted: i=1; AJvYcCU2dXujcjDDr209l1Rm95jEM5s254Lx2MYPP39E3WUjuxUTAaGEpLTe4BNJujpqHTDCXN0fAvC7e6qO1OuxbfCnWPfpjt5UPHnf
X-Gm-Message-State: AOJu0Yw+tJTO7Ef53kcqrYr0C67NlxV45bRUZb3nmWL/RsvMtsRkWelf
	DoMUDxbiyo1Op/z52goQ9P93JRxCf4Z/rF7gQiXbeT7YVvkRBnIb//8L+E791uuyK60Ds535h09
	x3zoyU502ImNPocyjnwyt+4YP9MTKyNDZX8U14y/8X7E/VKlX7u8/BaRvblz1Y0q+v0wlGUnI2Q
	usr+S5A53niTxc0KVzl/Kq3eq7bFQuoX9V
X-Received: by 2002:a17:90a:7785:b0:29e:2b58:ba55 with SMTP id v5-20020a17090a778500b0029e2b58ba55mr2380911pjk.20.1710855556901;
        Tue, 19 Mar 2024 06:39:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDwbo7UTYBpL5bbgUeLQDyqOLaaHTpVgDoMxZ1AHofxC5vKDoFZMRofr2v6GT8rff/1W4Q/ho/qJyLMFXvjSM=
X-Received: by 2002:a17:90a:7785:b0:29e:2b58:ba55 with SMTP id
 v5-20020a17090a778500b0029e2b58ba55mr2380892pjk.20.1710855556482; Tue, 19 Mar
 2024 06:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAGVVp+U+s692sC8-ioGQ7aP2shhQ6qyGOThVk=L6P4_XovDo5Q@mail.gmail.com>
 <73a510c8-51a0-4a4a-1aa8-7bdcd4cdde22@linux.intel.com>
In-Reply-To: <73a510c8-51a0-4a4a-1aa8-7bdcd4cdde22@linux.intel.com>
From: Changhui Zhong <czhong@redhat.com>
Date: Tue, 19 Mar 2024 21:39:05 +0800
Message-ID: <CAGVVp+W_YYJJ_-+dmLEca=Lu=xfSC53O6Yu1qmLrWJ-qHchWfA@mail.gmail.com>
Subject: Re: [bug report] WARNING: CPU: 0 PID: 1 at kernel/resource.c:834 __insert_resource+0x84/0x110
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Baoquan He <bhe@redhat.com>, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240319_064103_637420_399B9680 
X-CRM114-Status: GOOD (  15.43  )
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

SGnvvIxJbHBvCgp0aGFua3MgZm9yIHlvdXIgcmVwbHksCkkgZGlkbid0IGtub3cgd2hpY2ggbWFp
bGluZyBsaXN0IEkgc2hvdWxkIHJlcG9ydCB0aGlzIGlzc3VlIHRvLCBhbmQKdGhlbiBJIHNlYXJj
aGVkIGFuZCBzYXcgdGhhdCB0aGVyZSB3YXMgYSBwYXRjaCBhYm91dCBrZXJuZWwvcmVzb3VyY2Uu
YwppbiB0aGUgbGludXgtcGNpIG1haWxpbmcgbGlzdCwgc28gSSByZXBvcnRlZCBpdCBoZXJlLgoK
VGhhbmtz77yMCgpPbiBUdWUsIE1hciAxOSwgMjAyNCBhdCA4OjAw4oCvUE0gSWxwbyBKw6Rydmlu
ZW4KPGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgMTkg
TWFyIDIwMjQsIENoYW5naHVpIFpob25nIHdyb3RlOgo+Cj4gPiBIZWxsbywKPiA+Cj4gPiBmb3Vu
ZCBhIGtlcm5lbCB3YXJuaW5nIGlzc3VlIGF0ICJrZXJuZWwvcmVzb3VyY2UuYzo4MzQKPiA+IF9f
aW5zZXJ0X3Jlc291cmNlKzB4ODQvMHgxMTAiICxwbGVhc2UgaGVscCBjaGVjaywKPiA+Cj4gPiBy
ZXBvOmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZh
bGRzL2xpbnV4LmdpdAo+ID4gYnJhbmNoOiBtYXN0ZXIKPiA+IGNvbW1pdCBIRUFEOmY2Y2VmNWY4
YzM3ZjU4YTNiYzk1YjM3NTRjM2FlOThlMDg2NjMxY2EKPiA+Cj4gPiAgWyAgICAwLjEzMDE2NF0g
LS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tCj4gPiBbICAgIDAuMTMwMzcwXSBX
QVJOSU5HOiBDUFU6IDAgUElEOiAxIGF0IGtlcm5lbC9yZXNvdXJjZS5jOjgzNAo+ID4gX19pbnNl
cnRfcmVzb3VyY2UrMHg4NC8weDExMAo+ID4gWyAgICAwLjEzMTM2NF0gTW9kdWxlcyBsaW5rZWQg
aW46Cj4gPiBbICAgIDAuMTMyMzY0XSBDUFU6IDAgUElEOiAxIENvbW06IHN3YXBwZXIvMCBOb3Qg
dGFpbnRlZCA2LjguMCsgIzEKPiA+IFsgICAgMC4xMzMzNjVdIEhhcmR3YXJlIG5hbWU6IERlbGwg
SW5jLiBQb3dlckVkZ2UgUjY0MC8wNkRLWTUsIEJJT1MKPiA+IDIuMTUuMSAwNi8xNS8yMDIyCj4g
PiBbICAgIDAuMTM0MzY0XSBSSVA6IDAwMTA6X19pbnNlcnRfcmVzb3VyY2UrMHg4NC8weDExMAo+
ID4gWyAgICAwLjEzNTM2NF0gQ29kZTogZDAgNGMgMzkgYzEgNzYgYjEgYzMgY2MgY2MgY2MgY2Mg
NGMgOGQgNGEgMzAgNDgKPiA+IDhiIDUyIDMwIDQ4IDg1IGQyIDc1IGI3IDQ4IDg5IDU2IDMwIDQ5
IDg5IDMxIDQ4IDg5IDQ2IDI4IDMxIGMwIGMzIGNjCj4gPiBjYyBjYyBjYyA8MGY+IDBiIDQ4IDg5
IGQwIGMzIGNjIGNjIGNjIGNjIDQ5IDg5IGQyIGViIDFhIDRkIDM5IDQyIDA4IDc3Cj4gPiAxOSA0
ZAo+ID4gWyAgICAwLjEzNjM2M10gUlNQOiAwMDAwOmZmZmZiMjU3NDAwZGZlMDggRUZMQUdTOiAw
MDAxMDI0Ngo+ID4gWyAgICAwLjEzNzM2M10gUkFYOiBmZmZmOWUxNDdmZmNhNjQwIFJCWDogMDAw
MDAwMDAwMDAwMDAwMCBSQ1g6IDAwMDAwMDAwMjYwMDAwMDAKPiA+IFsgICAgMC4xMzgzNjNdIFJE
WDogZmZmZmZmZmY4NmM0NWVlMCBSU0k6IGZmZmZmZmZmODZjNDVlZTAgUkRJOiAwMDAwMDAwMDI2
MDAwMDAwCj4gPiBbICAgIDAuMTM5MzYzXSBSQlA6IGZmZmZmZmZmODY4NGQxMjAgUjA4OiAwMDAw
MDAwMDM1ZmZmZmZmIFIwOTogMDAwMDAwMDAzNWZmZmZmZgo+ID4gWyAgICAwLjE0MDM2M10gUjEw
OiAwMDAwMDAwMDJmMzE2NDZmIFIxMTogMDAwMDAwMDA1OWE3ZmZlZSBSMTI6IGZmZmZmZmZmODZj
NDVlZTAKPiA+IFsgICAgMC4xNDEzNjNdIFIxMzogMDAwMDAwMDAwMDAwMDAwMCBSMTQ6IDAwMDAw
MDAwMDAwMDAwMDAgUjE1OiAwMDAwMDAwMDAwMDAwMDAwCj4gPiBbICAgIDAuMTQyMzYzXSBGUzog
IDAwMDAwMDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjllMTI3NzgwMDAwMCgwMDAwKQo+ID4ga25s
R1M6MDAwMDAwMDAwMDAwMDAwMAo+ID4gWyAgICAwLjE0MzM2M10gQ1M6ICAwMDEwIERTOiAwMDAw
IEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwo+ID4gWyAgICAwLjE0NDM2M10gQ1IyOiBm
ZmZmOWUxMzMzNjAxMDAwIENSMzogMDAwMDAwMDMzMjIyMDAwMSBDUjQ6IDAwMDAwMDAwMDA3NzA2
ZjAKPiA+IFsgICAgMC4xNDUzNjNdIERSMDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6IDAwMDAwMDAw
MDAwMDAwMDAgRFIyOiAwMDAwMDAwMDAwMDAwMDAwCj4gPiBbICAgIDAuMTQ2MzYzXSBEUjM6IDAw
MDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAwMDAwMGZmZmUwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQw
MAo+ID4gWyAgICAwLjE0NzM2M10gUEtSVTogNTU1NTU1NTQKPiA+IFsgICAgMC4xNDgzNjNdIENh
bGwgVHJhY2U6Cj4gPiBbICAgIDAuMTQ5MzY0XSAgPFRBU0s+Cj4gPiBbICAgIDAuMTUwMzY1XSAg
PyBfX3dhcm4rMHg3Zi8weDEzMAo+ID4gWyAgICAwLjE1MTM2M10gID8gX19pbnNlcnRfcmVzb3Vy
Y2UrMHg4NC8weDExMAo+ID4gWyAgICAwLjE1MjM2NF0gID8gcmVwb3J0X2J1ZysweDE4YS8weDFh
MAo+ID4gWyAgICAwLjE1MzM2NF0gID8gaGFuZGxlX2J1ZysweDNjLzB4NzAKPiA+IFsgICAgMC4x
NTQzNjNdICA/IGV4Y19pbnZhbGlkX29wKzB4MTQvMHg3MAo+ID4gWyAgICAwLjE1NTM2M10gID8g
YXNtX2V4Y19pbnZhbGlkX29wKzB4MTYvMHgyMAo+ID4gWyAgICAwLjE1NjM2NF0gID8gX19pbnNl
cnRfcmVzb3VyY2UrMHg4NC8weDExMAo+ID4gWyAgICAwLjE1NzM2NF0gID8gYWRkX2RldmljZV9y
YW5kb21uZXNzKzB4NzUvMHhhMAo+ID4gWyAgICAwLjE1ODM2M10gIGluc2VydF9yZXNvdXJjZSsw
eDI2LzB4NTAKPiA+IFsgICAgMC4xNTkzNjRdICA/IF9fcGZ4X2luc2VydF9jcmFzaGtlcm5lbF9y
ZXNvdXJjZXMrMHgxMC8weDEwCj4gPiBbICAgIDAuMTYwMzYzXSAgaW5zZXJ0X2NyYXNoa2VybmVs
X3Jlc291cmNlcysweDYyLzB4NzAKPgo+IEhpLAo+Cj4gVGhpcyBzZWVtcyByZWxhdGVkIHRvIGNy
YXNoa2VybmVsIHN0dWZmLCBJIGFkZGVkIGEgZmV3IENjcyByZWxhdGVkIHRvCj4gaXQuCj4KPiBJ
IGRvbid0IGtub3cgd2h5IHlvdSBzZW50IHRoaXMgb25seSB0byBsaW51eC1wY2kgbGlzdCBhcyBp
dCBzZWVtcyBsaWtlbHkKPiB0byBiZSBlbnRpcmVseSB1bnJlbGF0ZWQgdG8gUENJLgo+Cj4gLS0K
PiAgaS4KPgo+ID4gWyAgICAwLjE2MTM2NV0gIGRvX29uZV9pbml0Y2FsbCsweDQxLzB4MzAwCj4g
PiBbICAgIDAuMTYyMzY0XSAga2VybmVsX2luaXRfZnJlZWFibGUrMHgyMWUvMHgzMjAKPiA+IFsg
ICAgMC4xNjMzNjVdICA/IF9fcGZ4X2tlcm5lbF9pbml0KzB4MTAvMHgxMAo+ID4gWyAgICAwLjE2
NDM2NF0gIGtlcm5lbF9pbml0KzB4MTYvMHgxYzAKPiA+IFsgICAgMC4xNjUzNjRdICByZXRfZnJv
bV9mb3JrKzB4MmQvMHg1MAo+ID4gWyAgICAwLjE2NjM2NF0gID8gX19wZnhfa2VybmVsX2luaXQr
MHgxMC8weDEwCj4gPiBbICAgIDAuMTY3MzYzXSAgcmV0X2Zyb21fZm9ya19hc20rMHgxYS8weDMw
Cj4gPiBbICAgIDAuMTY4MzY1XSAgPC9UQVNLPgo+ID4gWyAgICAwLjE2OTM2M10gLS0tWyBlbmQg
dHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBdLS0tCj4gPgo+ID4gVGhhbmtzLAo+ID4KPiA+Cj4KCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWls
aW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
