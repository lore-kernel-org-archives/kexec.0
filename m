Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93267EC8758
	for <kexec@archiver.kernel.org>; Thu,  7 Sep 2023 20:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uoLQQ7kUGUPmEtp4EM0COYFRN27AKVDrjIbUuArwf+Y=; b=ulnyT3Z8293N3H
	NCCXTg97RKhhAp58+HeXdaITvWbyHlEsM1pH8VF+7VJ8X/FOH3xb7YboYFvB3o60IBj1rvfUNOJFF
	vBtJsHQ5PnN2wSOEyvUIOyoZri5WP9W+UzaTAZ1SKir8U10qUvMaCJu4huF1eY2OwmM228t/miPW9
	pJmAtBv3YCHz/b8wFCXa2VmB6GBFQd4dhZFV0LG+VU7vglWq2ya3o57zmNv3hkFUDAxKb9PV1Mje5
	hmVEIoxR6oQIx6t6fS4VugGMrNpQ9TTtLS1hS/kx3l6OGUIKP7FeaJZy6ZUTUVkGjZq6e85HbQ593
	kvB5ytci37PVEW0JjMYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeLnl-00CfCp-3C;
	Thu, 07 Sep 2023 20:40:33 +0000
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeLni-00CfCM-05
	for kexec@lists.infradead.org;
	Thu, 07 Sep 2023 20:40:31 +0000
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59b53488f7cso2990977b3.0
        for <kexec@lists.infradead.org>; Thu, 07 Sep 2023 13:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694119227; x=1694724027; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19mrjjoxcwe4/BUgYp85zEpI/cd8uYB/AjYV4M2OpCk=;
        b=LYLTqbeRJCPKZu0Reyquu57BEMe0oOWWRafXVPPBHeDcYpswuKvEOLh3IAjuGYmNx6
         oF78W+kHyaIopHPOZV0i2YS+FC6IFylnWkVS+7y49Zrgr/oR02U7QpulFS9KOj9Ye5+M
         JB060fJwMtrA/XvxYnCpM7VWOJNVT0X0TY7rking+F2/+AEQJQOpwgqg97nRAKTz6l1U
         I4HKJLP4U68zYXmegQZoKMwEvPvr6ONbHGvoq42t0tbLEbeK8WO2lpvAGg12UcHC4MUw
         y+Lb7tuJ8GYzDHukELmkbtSef0xY2GW8c1egmou1qS0RCasBI/NLWzKDs/By7/g/Dihd
         CYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694119227; x=1694724027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19mrjjoxcwe4/BUgYp85zEpI/cd8uYB/AjYV4M2OpCk=;
        b=ikRmA5gGGbmlhgpYdpBcqwc6yU7DEPfUIQS6cTgPnA2uQwJnboTlmYDtv42NgJvR9B
         zatlWib0VouejjrIXdm+hLWUsaiC2i/PEgLbff0QERG4h3sBv+XFBx7Z0zU+xZdcu75n
         h2HzdE56swayg8dXjwFGZIDyui1W3vVqNqfosN1K/9Mki0GYOAwSBb8NDyE2vVMQQJFr
         Fbm1kPbi1ITu4OlYMyeGNHMOAmWDnktiDqX/LvdIUAj3kzjUy2EZRQcaMQx6sxb/IgNv
         +8u9EzcpGsCBlO83OWsbXfSFF0sBu3Pl/k1DhsBNo6r2sfNVWbDYqABnVqW/9BAhkGBh
         EmGw==
X-Gm-Message-State: AOJu0YxuEvUUc/vGQ30mIRsE7VZEHP/6qA9lzgWbPMXEt4ClsXSxbews
	Sv6tUnnq8oXWNicM7mH+zJfGpOVGgjc9imxJDxp7
X-Google-Smtp-Source: AGHT+IHwQv9AehS0KpaqBcHRMN5DynaFfcJvsCrwHhe2Bq+Il/WaOenPnY+AGB1mwVw6G5udIdrzbR8b6ETZoEVANjo=
X-Received: by 2002:a0d:db81:0:b0:594:fd81:c3bf with SMTP id
 d123-20020a0ddb81000000b00594fd81c3bfmr709829ywe.1.1694119227671; Thu, 07 Sep
 2023 13:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <5c323243-e22e-dd61-f808-2875654936a6@linux.ibm.com> <5ce32966-c8c5-adc4-8b9e-f8300b266a61@linux.microsoft.com>
 <696e8be1-ad31-4ffd-711d-6fb5ce54fbd4@linux.ibm.com>
In-Reply-To: <696e8be1-ad31-4ffd-711d-6fb5ce54fbd4@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 7 Sep 2023 16:40:16 -0400
Message-ID: <CAHC9VhTsSKLwnSscgc=HXtBd9N2Ot+3FQCj5SyStFjVDVv-w6w@mail.gmail.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal - network bandwidth
To: Ken Goldman <kgold@linux.ibm.com>
Cc: Tushar Sugandhi <tusharsu@linux.microsoft.com>, 
	Sush Shringarputale <sushring@linux.microsoft.com>, linux-integrity@vger.kernel.org, 
	zohar@linux.ibm.com, peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, 
	bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com, 
	kexec@lists.infradead.org, jmorris@namei.org, serge@hallyn.com, 
	code@tyhicks.com, nramas@linux.microsoft.com, 
	linux-security-module@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_134030_182237_2E061CE3 
X-CRM114-Status: GOOD (  19.47  )
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

T24gV2VkLCBTZXAgNiwgMjAyMyBhdCA0OjIx4oCvUE0gS2VuIEdvbGRtYW4gPGtnb2xkQGxpbnV4
LmlibS5jb20+IHdyb3RlOgo+IE9uIDkvMS8yMDIzIDU6MjAgUE0sIFR1c2hhciBTdWdhbmRoaSB3
cm90ZToKPiA+IE9uIDgvMzAvMjMgMTE6MDYsIEtlbiBHb2xkbWFuIHdyb3RlOgo+ID4+IE9uIDgv
MS8yMDIzIDM6MTIgUE0sIFN1c2ggU2hyaW5nYXJwdXRhbGUgd3JvdGU6Cj4gPj4+IEluIGFkZGl0
aW9uLCBhIGxhcmdlIElNQSBsb2cgY2FuIGFkZCBwcmVzc3VyZSBvbiB0aGUgbmV0d29yawo+ID4+
PiBiYW5kd2lkdGggd2hlbgo+ID4+PiB0aGUgYXR0ZXN0YXRpb24gY2xpZW50IHNlbmRzIGl0IHRv
IHJlbW90ZS1hdHRlc3RhdGlvbi1zZXJ2aWNlLgo+ID4+Cj4gPj4gSSB3b3VsZCBub3Qgd29ycnkg
dG9vIG11Y2ggYWJvdXQgbmV0d29yayBiYW5kd2lkdGguCj4gPiBPdXIgYmFuZHdpZHRoIGNvbmNl
cm5zIGFyZSBhYm91dCBzY2FsZWQgb3V0IHN5c3RlbS4KPiA+Cj4gPiBXaGVuIElNQSBsb2cgc2l6
ZSBpbmNyZWFzZXMgaW4gdGhlIHJhbmdlIG9mIG1lZ2FieXRlcywgYW5kIHdoZW4gdGhlCj4gPiBu
dW1iZXIgb2YgY2xpZW50IGRldmljZXMgaW5jcmVhc2VzLCBpdCBtYWtlcyBhbiBpbXBhY3Qgb24g
dGhlIG92ZXJhbGwKPiA+IG5ldHdvcmsgYmFuZHdpZHRoLgo+Cj4gSXQgc2hvdWxkIG5vdCwgYmVj
YXVzZSB0aGUgY2xpZW50IG9ubHkgc2VuZHMgbmV3IG1lYXN1cmVtZW50cy4gIEl0IG9ubHkKPiBz
ZW5kcyB0aGUgZW50aXJlIGxpc3Qgb25jZSBwZXIgYm9vdC4KPgo+IERvZXMgYSBtZWdhYnl0ZSBt
YXR0ZXIgaW4gYSBtb2Rlcm4gbmV0d29yaz8gQXMgZm9yIG92ZXJhbGwgcGVyZm9ybWFuY2UsCj4g
YSBtZWdhYnl0ZSBtYXkgdGFrZSAxMCBtc2VjLCB3aGlsZSB0aGUgVFBNIHF1b3RlIGNvdWxkIHRh
a2UgMTAwMCBtc2VjLAo+IGFuZCB2ZXJpZmllciBoYXNoIGFuZCBhc3ltbWV0cmljIHNpZ25hdHVy
ZSBjaGVja3MgYXJlIGFsc28gc2xvd2VyLgoKSSB0aGluayB0aGVyZSBhcmUgdHdvIGlzc3VlcyBo
ZXJlOiB0aGUgZmlyc3QgaXMgdGhlIGF0dGVzdGF0aW9uCm1ldGhvZG9sb2d5LCB0aGUgc2Vjb25k
IGlzIHNpbXBseSB0aGUgc2l6ZSBvZiB0aGUgZGVwbG95bWVudC4KClRoZXJlIGlzIHJhcmVseSBq
dXN0IG9uZSBhbnN3ZXIgdG8gYSBxdWVzdGlvbiwgYW5kIGluIHRoZSBjYXNlIG9mCnJlbW90ZSBh
dHRlc3RhdGlvbiBJIGJlbGlldmUgdGhhdCBob2xkcyB0cnVlLiAgU2VuZGluZyBzb21lIGRlbHRh
IG9mCm1lYXN1cmVtZW50cyB0byBhIHJlbW90ZSBub2RlIHBlcmZvcm1pbmcgYXR0ZXN0YXRpb24g
ZG9lcyByZWR1Y2UgdGhlCmFtb3VudCBvZiBuZXR3b3JrIHRyYWZmaWMsIGJ1dCBpdCBkb2VzIGFk
ZCBhbiBhZGRpdGlvbmFsIGJ1cmRlbiBvZgpzdGF0ZSB0cmFja2luZyB0byB0aGUgYXR0ZXN0YXRp
b24gbm9kZS4gIFNlbmRpbmcgdGhlIGZ1bGwgbWVhc3VyZW1lbnQKbG9nIGRlY3JlYXNlcyB0aGlz
IHRyYWNraW5nIGJ1cmRlbiwgYnV0IGl0IGRvZXMgcmVzdWx0IGluIG1vcmUgbmV0d29yawp0cmFm
ZmljLiAgQXJndWFibHkgdGhlICJiZXN0IiBjaG9pY2UgaXMgbGlrZWx5IGdvaW5nIHRvIGJlIGRl
cGVuZGVudApvbiBhIG51bWJlciBvZiBjb21wbGV4IGZhY3RvcnMgaW5jbHVkaW5nIHRoZSBzaXpl
IGFuZCBjb21wbGV4aXR5IG9mCnRoZSBkZXBsb3ltZW50LgoKSG93ZXZlciwgdGhlIHNuYXBzaG90
dGluZyB3b3JrIGlzIG5vdCBhYm91dCBtYW5hZ2luZyBuZXR3b3JrIHRyYWZmaWMsCml0IGlzIGFi
b3V0IG1pdGlnYXRpbmcgYW4gdW5ib3VuZGVkIG1lbW9yeSBidWZmZXIgdGhhdCBoYXMgYmVlbgpj
YXVzaW5nIHByb2JsZW1zIGluIGF0IGxlYXN0IG9uZSByZWFsIHdvcmxkIGRlcGxveW1lbnQuICBU
aGUgSU1BCm1lYXN1cmVtZW50IGxvZyBzbmFwc2hvdCBpcyBkZXNpZ25lZCB0byBhbGxvdyBhbiBh
ZG1pbiwgb3Igc29tZSBvdGhlcgpwcml2aWxlZ2VkIGVudGl0eSwgdG8gY2hlY2twb2ludCB0aGUg
bG9nIGFuZCB0cmltIHRoZSBvbGQgZW50cmllcyBpbgpzdWNoIGEgd2F5IGFzIHRvIHByZXNlcnZl
IHRoZSBhYmlsaXR5IHRvIHBlcmZvcm0gYSBtZWFuaW5nZnVsCmF0dGVzdGF0aW9uIHdpdGhvdXQg
aGF2aW5nIHRvIG1haW50YWluIHRoZSBlbnRpcmUgbWVhc3VyZW1lbnQgbG9nIGluIGEKbWVtb3J5
IGJ1ZmZlci4KCi0tIApwYXVsLW1vb3JlLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhl
Ywo=
