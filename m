Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCD2C54E76
	for <kexec@archiver.kernel.org>; Thu, 16 Nov 2023 22:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZPAzU9iArN5Bmj8PfYtWcJNPl6TomOdVMof9pBzu1KI=; b=ArQ/JoCCn02KHu
	PMjBy8j2A7xPSLl6+YCnN5t2EJ6IkoJA2BqhE67SbRyaVxpJfrBN9IduGR2IG6zjgt6lEzoo095z0
	wJfA94t93PXga7ihNz5Y+X+LaNiLZ83tuKGtd21Q/Nrl6d156Mzo4pgpOcvj5NbFfv4pBMSNsOgJb
	Ccl6yljrghM/LLq+GwFbW5gx7U3ImNiCXwRJv5x6VxmFhBpCRK3iHtYn/7IrL4yVydb8OlODr35Et
	M/Wn7yXLeEtujc+ExOE4Sq2jRLmyEl608r2Uho4mFdgo2jKd0WfqDX7GCWeJSN9B4JqOXSErkAm/c
	J7S7yGtzpv/JtiZC545g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3kqx-0053yP-0K;
	Thu, 16 Nov 2023 22:28:51 +0000
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3kqu-0053xb-09
	for kexec@lists.infradead.org;
	Thu, 16 Nov 2023 22:28:49 +0000
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9cbba16084so1313225276.1
        for <kexec@lists.infradead.org>; Thu, 16 Nov 2023 14:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700173727; x=1700778527; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y93mqvQuQ3cyR5SUPkiKyzE0itYPgBxsZ6Yl8asHxJU=;
        b=LBaIBL5jwYuIFMYwFdg3lrtOwttNN0rqAk++qApklIeJISew8uXxuBgHgCNUJNbdY5
         OjD2cARZ7t+VEQUHQU7FIsat56sHLUuzL9cEhzlwWD8ZfKhwBS09buz2F4R3K05H7E3d
         ODa7K/4bn+c7zDQQWhNDTn+av4lU8VNJn0eBHJUW1SpJ8ZtaNKkaVkxOLKeJXi+p7iCB
         Yj+UIIUorHRky2rZE1kAMKgGot4llAKYyEfJk0T4jfqgeXS/duv1jdI/3Ca5Qx4PMVUy
         QVyXtq7cePQwBpC8RN6plDxXQfFoE45FYMoFp7YraHOGG2VkVd+JGmg+O9Ed8jwKCDCR
         nXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700173727; x=1700778527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y93mqvQuQ3cyR5SUPkiKyzE0itYPgBxsZ6Yl8asHxJU=;
        b=iM9BSlzRDIbI/MQL27PP5p/uUxC0gwXfceuf///xC7SDS+CxjJsZRcKIYq98fpk79l
         JoZRo5MgJST6XB8AHXr6UlJfFH4QE4WwA+adhv0LnliYbHG0wHo+MYs0/y2gPqWEk5xu
         /G5lPjgneybcfZRFEHTXFMSjbqbgqSxkQbcJXr+3Jl+e0fZSdmrawpIAgYJIoI7TggFk
         nbU06ScLE2vg9UtauVjaKbVlPDs9BZpKcBCqwDCiURfDf5qqDP5VlDT9esduRmeMSL1V
         d0DmAfYy8cahRw325fRWcpKw/tsEInuTwK9N85fnje0VSM1wgk6wkoBZeYWDOeVOv/c9
         Dumw==
X-Gm-Message-State: AOJu0YxivHM6KX8xf/6PVfIUxEqr9DZxY5siutaaPH0/wzO2BesIQ64p
	KzaGEHLKyu4l8Wxp6TstrQbHM6irtibeX3BcXGSJ
X-Google-Smtp-Source: AGHT+IFH0V8fklGmPgdOyUiaO72Xq2JkkoI8N9fz5QX6EKc/JUzxtZpHmzPeAmVX3/H+pR3wMRJkHhEUa4N1n3bO95Q=
X-Received: by 2002:a25:2106:0:b0:da3:b466:1f73 with SMTP id
 h6-20020a252106000000b00da3b4661f73mr14599148ybh.24.1700173726615; Thu, 16
 Nov 2023 14:28:46 -0800 (PST)
MIME-Version: 1.0
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com> <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
In-Reply-To: <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 16 Nov 2023 17:28:35 -0500
Message-ID: <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Tushar Sugandhi <tusharsu@linux.microsoft.com>, linux-integrity@vger.kernel.org, 
	peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, 
	Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com, vgoyal@redhat.com, 
	Dave Young <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, jmorris@namei.org, 
	serge@hallyn.com, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-security-module@vger.kernel.org, 
	Tyler Hicks <tyhicks@linux.microsoft.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Sush Shringarputale <sushring@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231116_142848_221569_CFF6C78B 
X-CRM114-Status: GOOD (  34.40  )
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

T24gVHVlLCBPY3QgMzEsIDIwMjMgYXQgMzoxNeKAr1BNIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4
LmlibS5jb20+IHdyb3RlOgo+IE9uIFRodSwgMjAyMy0xMC0xOSBhdCAxMTo0OSAtMDcwMCwgVHVz
aGFyIFN1Z2FuZGhpIHdyb3RlOgo+Cj4gWy4uLl0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPiB8IEMu
MSBTb2x1dGlvbiBTdW1tYXJ5ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfAo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+IFRvIGFjaGlldmUgdGhlIGdvYWxzIGRl
c2NyaWJlZCBpbiB0aGUgc2VjdGlvbiBhYm92ZSwgd2UgcHJvcG9zZSB0aGUKPiA+IGZvbGxvd2lu
ZyBjaGFuZ2VzIHRvIHRoZSBJTUEgc3Vic3lzdGVtLgo+ID4KPiA+ICAgICAgYS4gVGhlIElNQSBs
b2cgZnJvbSBLZXJuZWwgbWVtb3J5IHdpbGwgYmUgb2ZmbG9hZGVkIHRvIHNvbWUKPiA+ICAgICAg
ICAgcGVyc2lzdGVudCBzdG9yYWdlIGRpc2sgdG8ga2VlcCB0aGUgc3lzdGVtIHJ1bm5pbmcgcmVs
aWFibHkKPiA+ICAgICAgICAgd2l0aG91dCBmYWNpbmcgbWVtb3J5IHByZXNzdXJlLgo+ID4gICAg
ICAgICBNb3JlIGRldGFpbHMsIGFsdGVybmF0ZSBhcHByb2FjaGVzIGNvbnNpZGVyZWQgZXRjLiBh
cmUgcHJlc2VudAo+ID4gICAgICAgICBpbiBzZWN0aW9uICJELjMgQ2hvaWNlcyBmb3IgU3Rvcmlu
ZyBTbmFwc2hvdHMiIGJlbG93Lgo+ID4KPiA+ICAgICAgYi4gVGhlIElNQSBsb2cgd2lsbCBiZSBk
aXZpZGVkIGludG8gbXVsdGlwbGUgY2h1bmtzIChzbmFwc2hvdHMpLgo+ID4gICAgICAgICBFYWNo
IHNuYXBzaG90IHdvdWxkIGJlIGEgZGVsdGEgYmV0d2VlbiB0aGUgdHdvIGluc3RhbmNlcyB3aGVu
Cj4gPiAgICAgICAgIHRoZSBsb2cgd2FzIG9mZmxvYWRlZCBmcm9tIG1lbW9yeSB0byB0aGUgcGVy
c2lzdGVudCBzdG9yYWdlCj4gPiAgICAgICAgIGRpc2suCj4gPgo+ID4gICAgICBjLiBTb21lIFVN
IHByb2Nlc3MgKGxpa2UgYSByZW1vdGUtYXR0ZXN0YXRpb24tY2xpZW50KSB3aWxsIGJlCj4gPiAg
ICAgICAgIHJlc3BvbnNpYmxlIGZvciB3cml0aW5nIHRoZSBJTUEgbG9nIHNuYXBzaG90IHRvIHRo
ZSBkaXNrLgo+ID4KPiA+ICAgICAgZC4gVGhlIHNhbWUgVU0gcHJvY2VzcyB3b3VsZCBiZSByZXNw
b25zaWJsZSBmb3IgdHJpZ2dlcmluZyB0aGUgSU1BCj4gPiAgICAgICAgIGxvZyBzbmFwc2hvdC4K
PiA+Cj4gPiAgICAgIGUuIFRoZXJlIHdpbGwgYmUgYSB3ZWxsLWtub3duIGxvY2F0aW9uIGZvciBz
dG9yaW5nIHRoZSBJTUEgbG9nCj4gPiAgICAgICAgIHNuYXBzaG90cyBvbiB0aGUgZGlzay4gIEl0
IHdpbGwgYmUgbm9uLXRyaXZpYWwgZm9yIFVNIHByb2Nlc3Nlcwo+ID4gICAgICAgICB0byBjaGFu
Z2UgdGhhdCBsb2NhdGlvbiBhZnRlciBib290aW5nIGludG8gdGhlIEtlcm5lbC4KPiA+Cj4gPiAg
ICAgIGYuIEEgbmV3IGV2ZW50LCAic25hcHNob3RfYWdncmVnYXRlIiwgd2lsbCBiZSBjb21wdXRl
ZCBhbmQgbWVhc3VyZWQKPiA+ICAgICAgICAgaW4gdGhlIElNQSBsb2cgYXMgcGFydCBvZiB0aGlz
IGZlYXR1cmUuICBJdCBzaG91bGQgaGVscCB0aGUKPiA+ICAgICAgICAgcmVtb3RlLWF0dGVzdGF0
aW9uIGNsaWVudC9zZXJ2aWNlIHRvIGJlbmVmaXQgZnJvbSB0aGUgSU1BIGxvZwo+ID4gICAgICAg
ICBzbmFwc2hvdCBmZWF0dXJlLgo+ID4gICAgICAgICBUaGUgInNuYXBzaG90X2FnZ3JlZ2F0ZSIg
ZXZlbnQgaXMgZGVzY3JpYmVkIGluIG1vcmUgZGV0YWlscyBpbgo+ID4gICAgICAgICBzZWN0aW9u
ICJELjEgU25hcHNob3QgQWdncmVnYXRlIEV2ZW50IiBiZWxvdy4KPiA+Cj4gPiAgICAgIGcuIElm
IHRoZSBleGlzdGluZyByZW1vdGUtYXR0ZXN0YXRpb24gY2xpZW50L3NlcnZpY2VzIGRvIG5vdCBj
aGFuZ2UKPiA+ICAgICAgICAgdG8gYmVuZWZpdCBmcm9tIHRoaXMgZmVhdHVyZSBvciBkbyBub3Qg
dHJpZ2dlciB0aGUgc25hcHNob3QsCj4gPiAgICAgICAgIHRoZSBLZXJuZWwgd2lsbCBjb250aW51
ZSB0byBoYXZlIGl0J3MgY3VycmVudCBmdW5jdGlvbmFsaXR5IG9mCj4gPiAgICAgICAgIG1haW50
YWluaW5nIGFuIGluLW1lbW9yeSBmdWxsIElNQSBsb2cuCj4gPgo+ID4gQWRkaXRpb25hbGx5LCB0
aGUgcmVtb3RlLWF0dGVzdGF0aW9uIGNsaWVudC9zZXJ2aWNlcyBuZWVkIHRvIGJlIHVwZGF0ZWQK
PiA+IHRvIGJlbmVmaXQgZnJvbSB0aGUgSU1BIGxvZyBzbmFwc2hvdCBmZWF0dXJlLiAgVGhlc2Ug
cHJvcG9zZWQgY2hhbmdlcwo+ID4KPiA+IGFyZSBkZXNjcmliZWQgaW4gc2VjdGlvbiAiRC40IFJl
bW90ZS1BdHRlc3RhdGlvbiBDbGllbnQvU2VydmljZSBTaWRlCj4gPiBDaGFuZ2VzIiBiZWxvdywg
YnV0IHRoZWlyIGltcGxlbWVudGF0aW9uIGlzIG91dCBvZiBzY29wZSBmb3IgdGhpcwo+ID4gcHJv
cG9zYWwuCj4KPiBBcyBwcmV2aW91c2x5IHNhaWQgb24gdjEsCj4gICAgVGhpcyBkZXNpZ24gc2Vl
bXMgb3Zlcmx5IGNvbXBsZXggYW5kIHJlcXVpcmVzIHN5bmNocm9uaXphdGlvbiBiZXR3ZWVuIHRo
ZQo+ICAgICJzbmFwc2hvdCIgcmVjb3JkIGFuZCBleHBvcnRpbmcgdGhlIHJlY29yZHMgZnJvbSB0
aGUgbWVhc3VyZW1lbnQgbGlzdC4gWy4uLl0KPgo+ICAgIENvbmNlcm5zOgo+ICAgIC0gUGF1c2lu
ZyBleHRlbmRpbmcgdGhlIG1lYXN1cmVtZW50IGxpc3QuCj4KPiBOb3RoaW5nIGhhcyBjaGFuZ2Vk
IGluIHRlcm1zIG9mIHRoZSBjb21wbGV4aXR5IG9yIGluIHRlcm1zIG9mIHBhdXNpbmcKPiB0aGUg
bWVhc3VyZW1lbnQgbGlzdC4gICBQYXVzaW5nIHRoZSBtZWFzdXJlbWVudCBsaXN0IGlzIGEgbm9u
IHN0YXJ0ZXIuCgpUaGUgbWVhc3VyZW1lbnQgbGlzdCB3b3VsZCBvbmx5IG5lZWQgdG8gYmUgcGF1
c2VkIGZvciB0aGUgYW1vdW50IG9mCnRpbWUgaXQgd291bGQgcmVxdWlyZSB0byBnZW5lcmF0ZSB0
aGUgc25hcHNob3RfYWdncmVnYXRlIGVudHJ5LCB3aGljaApzaG91bGQgYmUgbWluaW1hbCBhbmQg
b25seSBvY2N1cnMgd2hlbiBhIHByaXZpbGVnZWQgdXNlcnNwYWNlIHJlcXVlc3RzCmEgc25hcHNo
b3Qgb3BlcmF0aW9uLiAgVGhlIHNuYXBzaG90IHJlbWFpbnMgb3B0LWluIGZ1bmN0aW9uYWxpdHks
IGFuZApldmVuIHRoZW4gdGhlcmUgaXMgdGhlIHBvc3NpYmlsaXR5IHRoYXQgdGhlIGtlcm5lbCBj
b3VsZCByZWplY3QgdGhlCnNuYXBzaG90IHJlcXVlc3QgaWYgZ2VuZXJhdGluZyB0aGUgc25hcHNo
b3RfYWdncmVnYXRlIGVudHJ5IHdhcyBkZWVtZWQKdG9vIGNvc3RseSAoYXMgZGV0ZXJtaW5lZCBi
eSB0aGUga2VybmVsKSBhdCB0aGF0IHBvaW50IGluIHRpbWUuCgo+IFVzZXJzcGFjZSBjYW4gYWxy
ZWFkeSBleHBvcnQgdGhlIElNQSBtZWFzdXJlbWVudCBsaXN0KHMpIHZpYSB0aGUKPiBzZWN1cml0
eWZzIHthc2NpaSxiaW5hcnl9X3J1bnRpbWVfbWVhc3VyZW1lbnRzIGZpbGUocykgYW5kIGRvIHdo
YXRldmVyCj4gaXQgd2FudHMgd2l0aCBpdC4gIEFsbCB0aGF0IGlzIG1pc3NpbmcgaW4gdGhlIGtl
cm5lbCBpcyB0aGUgYWJpbGl0eSB0bwo+IHRyaW0gdGhlIG1lYXN1cmVtZW50IGxpc3QsIHdoaWNo
IGRvZXNuJ3Qgc2VlbSBhbGwgdGhhdCBjb21wbGljYXRlZC4KCkZyb20gbXkgcGVyc3BlY3RpdmUg
d2hhdCBoYXMgYmVlbiBwcmVzZW50ZWQgaXMgYmFzaWNhbGx5IGp1c3QgdHJpbW1pbmcKdGhlIGlu
LW1lbW9yeSBtZWFzdXJlbWVudCBsb2csIHRoZSBhZGRpdGlvbmFsIGNvbXBsZXhpdHkgKHdoaWNo
IHJlYWxseQpkb2Vzbid0IGxvb2sgdGhhdCBiYWQgSU1PKSBpcyB0aGVyZSB0byBlbnN1cmUgcm9i
dXN0bmVzcyBpbiB0aGUgZmFjZQpvZiBhbiB1bnJlbGlhYmxlIHVzZXJzcGFjZSAocHJvY2Vzc2Vz
IGRpZSwgZ2V0IGtpbGxlZCwgZXRjLikgYW5kIHRvCmVzdGFibGlzaCBhIG5ldywgdHJhbnNpdGl2
ZSByb290IG9mIHRydXN0IGluIHRoZSBuZXdseSB0cmltbWVkCmluLW1lbW9yeSBsb2cuCgpJIHN1
cHBvc2Ugb25lIGNvdWxkIHNpbXBsaWZ5IHRoaW5ncyBncmVhdGx5IGJ5IGhhdmluZyBhIGRlc2ln
biB3aGVyZQp1c2Vyc3BhY2UgIGNhcHR1cmVzIHRoZSBtZWFzdXJlbWVudCBsb2cgYW5kIHRoZW4g
d3JpdGVzIHRoZSBudW1iZXIgb2YKbWVhc3VyZW1lbnQgcmVjb3JkcyB0byB0cmltIGZyb20gdGhl
IHN0YXJ0IG9mIHRoZSBtZWFzdXJlbWVudCBsb2cgdG8gYQpzeXNmcyBmaWxlIGFuZCB0aGUga2Vy
bmVsIGFjdHMgb24gdGhhdC4gIFlvdSBjb3VsZCBkbyB0aGlzIHdpdGgsIG9yCndpdGhvdXQsIHRo
ZSBzbmFwc2hvdF9hZ2dyZWdhdGUgZW50cnkgY29uY2VwdDsgaW4gZmFjdCB0aGF0IGNvdWxkIGJl
CnNvbWV0aGluZyB0aGF0IHdhcyBjb250cm9sbGVkIGJ5IHVzZXJzcGFjZSwgZS5nLiB3cml0ZSB0
aGUgbnVtYmVyIG9mCmxpbmVzIGFuZCBhIGZsYWcgdG8gaW5kaWNhdGUgaWYgYSBzbmFwc2hvdF9h
Z2dyZWdhdGUgd2FzIGRlc2lyZWQgdG8KdGhlIHN5c2ZzIGZpbGUuICBJIGNhbid0IHNheSBJJ3Zl
IHRob3VnaHQgaXQgYWxsIHRoZSB3YXkgdGhyb3VnaCB0bwptYWtlIHN1cmUgdGhlcmUgYXJlIG5v
IGdvdGNoYXMsIGJ1dCBJJ20gZ3Vlc3NpbmcgdGhhdCBpcyBhYm91dCBhcwpzaW1wbGUgYXMgb25l
IGNhbiBnZXQuCgpJZiB0aGVyZSBpcyBzb21ldGhpbmcgZWxzZSB5b3UgaGFkIGluIG1pbmQsIE1p
bWksIHBsZWFzZSBzaGFyZSB0aGUKZGV0YWlscy4gIFRoaXMgaXMgYSB2ZXJ5IHJlYWwgcHJvYmxl
bSB3ZSBhcmUgZmFjaW5nIGFuZCB3ZSB3YW50IHRvCndvcmsgdG8gZ2V0IGEgc29sdXRpb24gdXBz
dHJlYW0uCgotLSAKcGF1bC1tb29yZS5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
