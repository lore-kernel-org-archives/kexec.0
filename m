Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2ED2C4167B
	for <kexec@archiver.kernel.org>; Mon, 27 Nov 2023 22:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8w92xAy3i65xn39lBmIC/33vGeRWN2ivHe5tXyIx2+k=; b=dgdIur2Zz3HfUa
	HcUAyncgVg/jQkIIoM+yclHdTdJOCwnMt2OPdz7EUHb26uyQAvNxyjOXMj6TFtBTqd4Dg7QxbwaZz
	q05K0TQGudH9WqDspZHTrWqfibVAxCfuxOvuvZL4lT5Cdj2sL2JyhVZ+VeSF1JfokLEegGcE6/OED
	UyzUiaXh+GiDQ5O3DztI7XXo7ORxoQP5/lgz+8e4WTN6R/KeMQQcoDvlNyNqXJUsWKyITyI/IEtnT
	WTbiTL/gMtUgAzdezUwLDPHGf1GhYX5eX8cCEaWCtcBF5hJh+vHK3XVGjV6Gzuo6oTv1dVtsvTogZ
	gLnScpDQXWA8FJDSDYjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7ju1-003ZvH-1s;
	Mon, 27 Nov 2023 22:16:29 +0000
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7jtx-003ZuD-2a
	for kexec@lists.infradead.org;
	Mon, 27 Nov 2023 22:16:28 +0000
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5d17d58c194so478347b3.3
        for <kexec@lists.infradead.org>; Mon, 27 Nov 2023 14:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701123383; x=1701728183; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTXtOQ06AyJD+S/3ZuEjq3dS8iIU8CK5Q8QDa1uxM6Y=;
        b=NB488uCf+T+pg0yOeMAZxmUFHL6J5gBHOr2Np+HFiJAGqkiF/iB95auigZ2QZNJFm9
         pCn5GPoHV+G+j6mMtf8IOefjYGEWh/Tt4pitKAnUGNuq6SlCtcCDYl8ljRBn3KQL46r1
         GQAPhO+sqm7yZJnr/5aXoj3h9fdQNmdfjdIC46gDHHHrcJtZpuS2O9a4WI8rIKWWws0d
         oGsX/zv0Y2z4TpkMSzGxHuGQm97FWch6fl2n1/+oBafJ315rNuN6xUvAipO1efM8VFOL
         sVWQABPKbsOMsdE+ZdW/FQwRTtLi8LXOMaFTAkP6A3W7yLTMZhYSAytmybPxKWoL+m55
         LLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123383; x=1701728183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTXtOQ06AyJD+S/3ZuEjq3dS8iIU8CK5Q8QDa1uxM6Y=;
        b=MMs+i2nNMem3FNDn87Qyj/q0hdEusecAhEhSh3VXW5nUc8YodvUEi5DJpo2kUhFe+T
         Pcg43z/jQwZLpkxeQ5YjBa4pwMHXMM7c0xrfBEhDxxMEdQALFQVqKVgyVNszoOWEZQx/
         BSuaDtp8PyENIQHet2v2/DjLGa0edHi2ZAPaGBDPFx8vh8k7O/VkVUvjMD8Z/f0KaaY2
         fNMYlp2QQKQklbR43RuAGEcxsBeh9g2ilD0fqS/J94wS8GcXbTIid0uNQVwx1CXws1uR
         rjkYMHDhV3o8dOeRGpTyb83je7L1x+9SP23lF4pYnNbIXXgbtYJG1Tf/QlhNUosCcxOl
         Qsjw==
X-Gm-Message-State: AOJu0Yx/NxXI+Mf3p0IxF65YPj4DRo2KjMhwHYWyLfZp5+LKB84otzda
	SFX84VXd912GQgpkndyfsG3u3rfpqnRaD/hsF3Bd
X-Google-Smtp-Source: AGHT+IHT/uujwb4aLiR9oamAow6VMBCwqTDyAseQWPVGHc7HKJrLQ1qRdJzOPHyQiiNjlQfnDWkBV7v9+pDw/Ob1SC0=
X-Received: by 2002:a25:1541:0:b0:da0:6cf3:c629 with SMTP id
 62-20020a251541000000b00da06cf3c629mr9988242ybv.41.1701123383283; Mon, 27 Nov
 2023 14:16:23 -0800 (PST)
MIME-Version: 1.0
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
 <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
 <CAHC9VhSJ7MKNM7nMXR3xE-cNMrYB4AT+B76wzF1cKy2JM9tBrA@mail.gmail.com>
 <1b6853e8354af7033e6d87e77cfb175526753c38.camel@linux.ibm.com>
 <CAHC9VhSnDQ-d9dh_icqNyhpT+cTGQOqGh8+cbN3QzF_qPehvaA@mail.gmail.com> <28c4136d0fe360a7fcf6a6547120dc244be0edc3.camel@linux.ibm.com>
In-Reply-To: <28c4136d0fe360a7fcf6a6547120dc244be0edc3.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Nov 2023 17:16:12 -0500
Message-ID: <CAHC9VhTykrsXTuWfRe3rzg2SMbzynvgwXmxVpN5T0cfY7YrkwA@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20231127_141625_972971_3B467D8F 
X-CRM114-Status: GOOD (  40.39  )
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

T24gTW9uLCBOb3YgMjcsIDIwMjMgYXQgMTI6MDjigK9QTSBNaW1pIFpvaGFyIDx6b2hhckBsaW51
eC5pYm0uY29tPiB3cm90ZToKPiBPbiBXZWQsIDIwMjMtMTEtMjIgYXQgMDk6MjIgLTA1MDAsIFBh
dWwgTW9vcmUgd3JvdGU6CgouLi4KCj4gPiBPa2F5LCB3ZSBhcmUgc3RhcnRpbmcgdG8gZ2V0IGNs
b3NlciwgYnV0IEknbSBzdGlsbCBtaXNzaW5nIHRoZSBwYXJ0Cj4gPiB3aGVyZSB5b3Ugc2F5ICJp
ZiB5b3UgZG8gWCwgWSwgYW5kIFosIEknbGwgYWNjZXB0IGFuZCBtZXJnZSB0aGUKPiA+IHNvbHV0
aW9uLiIgIENhbiB5b3UgYmUgbW9yZSBleHBsaWNpdCBhYm91dCB3aGF0IGFwcHJvYWNoKGVzKSB5
b3Ugd291bGQKPiA+IGJlIHdpbGxpbmcgdG8gYWNjZXB0IHVwc3RyZWFtPwo+Cj4gSW5jbHVkZWQg
d2l0aCB3aGF0IGlzIHdhbnRlZC9uZWVkZWQgaXMgYW4gZXhwbGFuYXRpb24gYXMgdG8gbXkgY29u
Y2VybnMKPiB3aXRoIHRoZSBleGlzdGluZyBwcm9wb3NhbC4KPgo+IEZpcnN0IHdlIG5lZWQgdG8g
ZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIGtlcm5lbCBhbmQgdWhzZXJzcGFjZQo+IHJlcXVpcmVtZW50
cy4gIChUaGUgInNuYXBzaG90dGluZyIgZGVzaWduIHByb3Bvc2FsIGludGVybWl4ZXMgdGhlbS4p
Cj4KPiBGcm9tIHRoZSBrZXJuZWwgcGVyc2VjdGl2ZSwgdGhlIExvZyBTbmFwc2hvdHRpbmcgRGVz
aWduIHByb3Bvc2FsICJCLjEKPiBHb2FscyIgaXMgdmVyeSBuaWNlLCBidXQgb25jZSB0aGUgbWVh
c3VyZW1lbnQgbGlzdCBjYW4gYmUgdHJpbW1lZCBpdCBpcwo+IHJlYWxseSBpcnJlbGV2YW50LiAg
VXNlcnNwYWNlIGNhbiBkbyB3aGF0ZXZlciBpdCB3YW50cyB3aXRoIHRoZQo+IG1lYXN1cmVtZW50
IGxpc3QgcmVjb3Jkcy4gIFNvIGluc3RlYWQgb2YgcGF5aW5nIGxpcCBzZXJ2aWNlIHRvIHdoYXQK
PiBzaG91bGQgYmUgZG9uZSwganVzdCBjYWxsIGl0IGFzIGl0IGlzIC0gdHJpbW1pbmcgdGhlIG1l
YXN1cmVtZW50IGxpc3QuCgpGYWlyIGVub3VnaC4gIEkgcGVyc29uYWxseSB0aGluayBpdCBpcyBu
aWNlIHRvIGhhdmUgYSBicmllZiBkaXNjdXNzaW9uCm9mIGhvdyB1c2Vyc3BhY2UgbWlnaHQgdXNl
IGEga2VybmVsIGZlYXR1cmUsIGJ1dCBpZiB5b3UgcHJlZmVyIHRvIGRyb3AKdGhhdCBwYXJ0IG9m
IHRoZSBkZXNpZ24gZG9jIEkgZG91YnQgYW55b25lIHdpbGwgb2JqZWN0IHZlcnkgc3Ryb25nbHku
Cgo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCj4gfCBCLjEgR29hbHMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwKPiAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+IFRv
IGFkZHJlc3MgdGhlIGlzc3VlcyBkZXNjcmliZWQgaW4gdGhlIHNlY3Rpb24gYWJvdmUsIHdlIHBy
b3Bvc2UKPiBlbmhhbmNlbWVudHMgdG8gdGhlIElNQSBzdWJzeXN0ZW0gdG8gYWNoaWV2ZSB0aGUg
Zm9sbG93aW5nIGdvYWxzOgo+Cj4gICBhLiBSZWR1Y2UgbWVtb3J5IHByZXNzdXJlIG9uIHRoZSBL
ZXJuZWwgY2F1c2VkIGJ5IGxhcmdlciBpbi1tZW1vcnkKPiAgICAgIElNQSBsb2dzLgo+Cj4gICBi
LiBQcmVzZXJ2ZSB0aGUgc3lzdGVtJ3MgYWJpbGl0eSB0byBnZXQgcmVtb3RlbHkgYXR0ZXN0ZWQg
dXNpbmcgdGhlCj4gICAgICBJTUEgbG9nLCBldmVuIGFmdGVyIGltcGxlbWVudGluZyB0aGUgZW5o
YW5jZW1lbnRzIHRvIHJlZHVjZSBtZW1vcnkKPiAgICAgIHByZXNzdXJlIGNhdXNlZCBieSB0aGUg
SU1BIGxvZy4gSU1BJ3MgSW50ZWdyaXR5IGd1YXJhbnRlZXMgc2hvdWxkCj4gICAgICBiZSBtYWlu
dGFpbmVkLgo+Cj4gICBjLiBQcm92aWRlIG1lY2hhbmlzbXMgZnJvbSBLZXJuZWwgc2lkZSB0byB0
aGUgcmVtb3RlIGF0dGVzdGF0aW9uCj4gICAgICBzZXJ2aWNlIHRvIG1ha2Ugc2VydmljZS1zaWRl
IHByb2Nlc3NpbmcgbW9yZSBlZmZpY2llbnQuCgpUaGF0IGxvb2tzIGZpbmUgdG8gbWUuCgo+IEZy
b20gdGhlIGtlcm5lbCBwZXJzcGVjdGl2ZSB0aGVyZSBuZWVkcyB0byBiZSBhIG1ldGhvZCBvZiB0
cmltbWluZyBOCj4gbnVtYmVyIG9mIHJlY29yZHMgZnJvbSB0aGUgaGVhZCBvZiB0aGUgbWVhc3Vy
ZW1lbnQgbGlzdC4gIEluIGFkZGl0aW9uCj4gdG8gdGhlIGV4aXN0aW5nIHNlY3VyaXR5ZnMgInJ1
bnRpbWUgbWVhc3VyZW1lbnQgbGlzdCIsICBkZWZpbmluZyBhIG5ldwo+IHNlY3VyaXR5ZnMgZmls
ZSBjb250YWluaW5nIHRoZSBjdXJyZW50IGNvdW50IG9mIGluIG1lbW9yeSBtZWFzdXJlbWVudAo+
IHJlY29yZHMgd291bGQgYmUgYmVuZWZpY2lhbC4KCkkgaW1hZ2luZSB0aGF0IHNob3VsZCBiZSB0
cml2aWFsIHRvIGltcGxlbWVudCBhbmQgSSBjYW4ndCBpbWFnaW5lCnRoZXJlIGJlaW5nIGFueSBv
YmplY3Rpb24gdG8gdGhhdC4KCklmIHdlIGFyZSBnb2luZyB0byBoYXZlIGEgcmVjb3JkIGNvdW50
LCBJIGltYWdpbmUgaXQgd291bGQgYWxzbyBiZQpoZWxwZnVsIHRvIG1haW50YWluIGEgc2VjdXJp
dHlmcyBmaWxlIHdpdGggdGhlIHRvdGFsIHNpemUgKGluIGJ5dGVzKQpvZiB0aGUgaW4tbWVtb3J5
IG1lYXN1cmVtZW50IGxvZy4gIEluIGZhY3QsIEkgc3VzcGVjdCB0aGlzIHdpbGwKcHJvYmFibHkg
YmUgbW9yZSB1c2VmdWwgZm9yIHRob3NlIHdobyB3aXNoIHRvIG1hbmFnZSB0aGUgc2l6ZSBvZiB0
aGUKbWVhc3VyZW1lbnQgbG9nLgoKPiBEZWZpbmluZyBvdGhlciBJTUEgc2VjdXJpdHlmcyBmaWxl
cyBsaWtlCj4gaG93IG1hbnkgdGltZXMgdGhlIG1lYXN1cmVtZW50IGxpc3QgaGFzIGJlZW4gdHJp
bW1lZCBtaWdodCBiZQo+IGJlbmVmaWNpYWwgYXMgd2VsbC4KCkkgaGF2ZSBubyBvYmplY3Rpb24g
dG8gdGhhdC4gIFdvdWxkIGEgdG90YWwgcmVjb3JkIGNvdW50LCBpLmUuIGEgdmFsdWUKdGhhdCBk
b2Vzbid0IHJlc2V0IG9uIGEgc25hcHNob3QgZXZlbnQsIGJlIG1vcmUgdXNlZnVsIGhlcmU/Cgo+
IE9mIGNvdXJzZSBwcm9wZXJseSBkb2N1bWVudCB0aGUgaW50ZWdyaXR5Cj4gaW1wbGljYXRpb25z
IGFuZCByZXBlcmN1c3Npb25zIG9mIHRoZSBuZXcgS2NvbmZpZyB0aGF0IGFsbG93cyB0cmltbWlu
Zwo+IHRoZSBtZWFzdXJlbWVudCBsaXN0LgoKT2YgY291cnNlLgoKPiBEZWZpbmluZyBhIHNpbXBs
ZSAidHJpbSIgbWFya2VyIG1lYXN1cmVtZW50IHJlY29yZCB3b3VsZCBiZSBhIHZpc3VhbAo+IGlu
ZGljYXRpb24gdGhhdCB0aGUgbWVhc3VyZW1lbnQgbGlzdCBoYXMgYmVlbiB0cmltbWVkLiAgSSBt
aWdodCBldmVuCj4gaGF2ZSBjb21wYXJlZCBpdCB0byB0aGUgImJvb3RfYWdncmVnYXRlIi4gIEhv
d2V2ZXIsIHRoZSBwcm9wb3NlZCBtYXJrZXIKPiBiYXNlZCBvbiBUUE0gUENScyByZXF1aXJlcyBw
YXVzaW5nIGV4dGVuZGluZyB0aGUgbWVhc3VyZW1lbnQgbGlzdC4KCi4uLgoKPiBCZWZvcmUgZGVm
aW5pbmcgYSBuZXcgY3JpdGljYWwtZGF0YSByZWNvcmQsIHdlIG5lZWQgdG8gZGVjaWRlIHdoZXRo
ZXIKPiBpdCBpcyByZWFsbHkgbmVjZXNzYXJ5IG9yIGlmIGl0IGlzIHJlZHVuZGFudC4gIElmIHdl
IGRlZmluZSBhIG5ldwo+ICJjcml0aWNhbC1kYXRhIiByZWNvcmQsIGNhbiBpdCBiZSBkZWZpbmVk
IHN1Y2ggdGhhdCBpdCBkb2Vzbid0IHJlcXVpcmUKPiBwYXVzaW5nIGV4dGVuZGluZyB0aGUgbWVh
c3VyZW1lbnQgbGlzdD8gIEZvciBleGFtcGxlLCBhIG5ldyBzaW1wbGUKPiB2aXN1YWwgY3JpdGlj
YWwtZGF0YSByZWNvcmQgY291bGQgY29udGFpbiB0aGUgbnVtYmVyIG9mIHJlY29yZHMgKGUuZy4K
PiA8c2VjdXJpdHlmcz4vaW1hL3J1bnRpbWVfbWVhc3VyZW1lbnRzX2NvdW50KSB1cCB0byB0aGF0
IHBvaW50LgoKV2hhdCBpZiB0aGUgc25hcHNob3RfYWdncmVnYXRlIHdhcyBhIGhhc2ggb2YgdGhl
IG1lYXN1cmVtZW50IGxvZwpzdGFydGluZyB3aXRoIGVpdGhlciB0aGUgYm9vdF9hZ2dyZWdhdGUg
b3IgdGhlIGxhdGVzdApzbmFwc2hvdF9hZ2dyZWdhdGUgYW5kIGVuZGluZyBvbiB0aGUgcmVjb3Jk
IGJlZm9yZSB0aGUgbmV3CnNuYXBzaG90X2FnZ3JlZ2F0ZT8gIFRoZSBwZXJmb3JtYW5jZSBpbXBh
Y3QgYXQgc25hcHNob3QgdGltZSBzaG91bGQgYmUKbWluaW1hbCBhcyB0aGUgaGFzaCBjYW4gYmUg
aW5jcmVtZW50YWxseSB1cGRhdGVkIGFzIG5ldyByZWNvcmRzIGFyZQphZGRlZCB0byB0aGUgbWVh
c3VyZW1lbnQgbGlzdC4gIFdoaWxlIHRoZSBoYXNoIHdvdWxkbid0IGNhcHR1cmUgdGhlClRQTSBz
dGF0ZSwgaXQgd291bGQgYWxsb3cgc29tZSBjcnVkZSB2ZXJpZmljYXRpb24gd2hlbiByZWFzc2Vt
YmxpbmcKdGhlIGxvZy4gIElmIG9uZSBjb3VsZCBiZWFyIHRoZSBjb3N0IG9mIGEgVFBNIHNpZ25p
bmcgb3BlcmF0aW9uLCB0aGUKbG9nIGRpZ2VzdCBjb3VsZCBiZSBzaWduZWQgYnkgdGhlIFRQTS4K
Cj4gVGhlIG5ldyBjcml0aWNhbC1kYXRhIHJlY29yZCBhbmQgdHJpbW1pbmcgdGhlIG1lYXN1cmVt
ZW50IGxpc3Qgc2hvdWxkCj4gYmUgZGlzam9pbnQgZmVhdHVyZXMuICBJZiB0aGUgZmlyc3QgcmVj
b3JkIGFmdGVyIHRyaW1taW5nIHRoZQo+IG1lYXN1cmVtZW50IGxpc3Qgc2hvdWxkIGJlIHRoZSBj
cml0aWNhbC1kYXRhIHJlY29yZCwgdGhlbiB0cmltIHRoZQo+IG1lYXN1cmVtZW50IGxpc3QgdXAg
dG8gdGhhdCBwb2ludC4KCkkgZGlzYWdyZWUgYWJvdXQgdGhlIHNuYXBzaG90X2FnZ3JlZ2F0ZSBy
ZWNvcmQgYmVpbmcgZGlzam9pbnQgZnJvbSB0aGUKbWVhc3VyZW1lbnQgbG9nLCBidXQgSSBzdXNw
ZWN0IFR1c2hhciBhbmQgU3VzaCBhcmUgd2lsbGluZyB0byBmb3Jnbwp0aGUgc25hcHNob3RfYWdn
cmVnYXRlIGlmIHRoYXQgaXMgYSBibG9ja2VyIGZyb20geW91ciBwZXJzcGVjdGl2ZS4KT25jZSBh
Z2FpbiwgdGhlIG1haW4gZ29hbCBpcyB0aGUgYWJpbGl0eSB0byBtYW5hZ2UgdGhlIHNpemUgb2Yg
dGhlCm1lYXN1cmVtZW50IGxvZzsgd2hpbGUgaGF2aW5nIGEgc25hcHNob3RfYWdncmVnYXRlIHRo
YXQgY2FuIGJlIHVzZWQgdG8KZXN0YWJsaXNoIGEgcm9vdCBvZiB0cnVzdCBzaW1pbGFyIHRvIHRo
ZSBib290X2FnZ3JlZ2F0ZSBpcyBuaWNlLCBpdCBpcwpub3QgYSBNVVNUIGhhdmUuCgo+IEZyb20g
YSB1c2Vyc3BhY2UgcGVyc3BlY3RpdmUsIHRyaW1taW5nIHRoZSBtZWFzdXJlbWVudCBsaXN0IGlz
IGEgbWFqb3IKPiBjaGFuZ2UgYW5kIHdpbGwgYnJlYWsgZXhpc3RpbmcgYXR0ZXN0YXRpb24gcmVx
dWVzdHMsIHVubGVzcyB0aGUgY2hhbmdlCj4gaXMgdHJhbnNwYXJlbnQuICBSZW1vdmluZyAic25h
cHNob3RzIi8ic2hhcmRzIiB3aWxsIG9mIGNvdXJzZSBicmVhawo+IGF0dGVzdGF0aW9uIHJlcXVl
c3RzLiAgUmVmZXIgdG8gU3RlZmFuJ3Mgc3VnZ2VzdGlvbnM6Cj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtaW50ZWdyaXR5LzFlZDJkNzJjLTRjYjItNDhiMy1iYjBmLWIwODc3ZmMxZTlj
YUBsaW51eC5pYm0uY29tLwoKWW91IHdpbGwgbm90ZSB0aGF0IFN1c2ggYW5kIEkgcmVwbGllZCB0
byBTdGVmYW4gdHdvIHdlZWtzIGFnby4KCi0tIApwYXVsLW1vb3JlLmNvbQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0Cmtl
eGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9rZXhlYwo=
