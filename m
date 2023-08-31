Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CDBC83F35
	for <kexec@archiver.kernel.org>; Thu, 31 Aug 2023 17:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EvgiWQKcVwVSi35Rhu3fDOJ3ri+JcIyrJ8ttcFyggW8=; b=GzzSGbcPQHPQBs
	2sI87m07EAgWzbN688qhw9oNHZ13LnpCtn8+99yHfAxlDeJHptElExuH9LUKEiTUCg3Kel+7udOoz
	YvTntKs8KOUaaJ3nyHX/TxySftr9ItG2CI5/6lxxAHWQr0k08W8yzRyl20BJndpSTZevbJcNAYOcO
	btT+OVWNFRzp7N9Wvo1z9OjL+4OYlgP56A6vkjTO9K4hI9yaMyObl+WnY0K7/JRNaJrvEW6BCFcru
	JyiO7nDdvQaeoXJOSpT/wZiH9qCmRxd3+Xjfp4pVZWLCe+MNS0CXko2nNwzCTeCu5Xof1Ak/D7Qka
	AR5MPtKDZcvDODtiRESg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbluq-00Ffjp-1R;
	Thu, 31 Aug 2023 17:57:12 +0000
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qblun-00FfjF-0u
	for kexec@lists.infradead.org;
	Thu, 31 Aug 2023 17:57:10 +0000
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a7ca8720a0so664101b6e.2
        for <kexec@lists.infradead.org>; Thu, 31 Aug 2023 10:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693504623; x=1694109423; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Vw7y/sATNYmg+CnDBRVlhC4jceuaKp59KaohI9L20c=;
        b=Ii16rmGZQnLsDezFn5/CTuH3uMIlCWQ/ZLO90JvbCZskJVbTtC0lWw6EMhnGBqx8ic
         0zUfREJrUQGd7kvE/4iffopPfD5RTT5b8EuuuWD+TMLnKmRfOHKKPlDOYERqUBOwJnyH
         yLBc0nwk8cH48IuOPJU3/lcToKm8XqUi21j2aGRUk/tAzEig6cgT/q3ydJ63wAauNI8H
         VNsZgVsymTtw3UO6bWk98T2eJoSQNNgYV/GHvqY0Al0cVLyb7thF/YGvPbD0dgeeh0Ih
         EP0+tYFB1aUkz4A702d0vnk3bS/3b9p2/VRdUVFZ3WsMr8nzGWd3RGCkmDNUexlTQ1G1
         9FLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693504623; x=1694109423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Vw7y/sATNYmg+CnDBRVlhC4jceuaKp59KaohI9L20c=;
        b=gNrRc+uCaYKor0oAoXuaPI6154b2IrjASBoRi6r0Blxf2qS0LcNoqfQqTpnxUx0b9j
         mt1JOxN4tIkfzpqLrAzbFr412Whe6EKPVhs2Cn+21RoO3phjz/XSNT9MWzU+fBN8y/4S
         oE2GTUbBWstp8NaVrS3+TeAUGSRYSNpY2PzE3j/C2hS3kJzQcSV1myVpNRRxzB4Oc5I3
         nOz7fZDdg5T+Ef8wM7pLlAC/eo0d+xC3PXkH0V1axyn7asakMahNmf2gxKj5sZIaQCM7
         1JrvuKbQQKwEijXMW967BZKVtLKNYqEd2t6sQIKCsyoi/s7WLP469b6oogEqnbeNL0EK
         lE+A==
X-Gm-Message-State: AOJu0YxHZnKFsQY6Obq/0mjD7OGXjLzDE3CF98fqYJTg8XXHcKCWbvzE
	yVxiLXoxa4XNxnkff6vV+PAm/iN0OSv9tibzKFFR
X-Google-Smtp-Source: AGHT+IGr70igKt/tEaJygcDeix/HwaHPsscAUhwqEcG8R2uSt7r9yy6+xjVuFSLpUh3ychzJ8C8yTqcJfidLivEII/4=
X-Received: by 2002:a05:6808:9bb:b0:3a7:2621:2daf with SMTP id
 e27-20020a05680809bb00b003a726212dafmr216996oig.42.1693504623564; Thu, 31 Aug
 2023 10:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTjej-GFjvEQhnL-HWnnkvJKA_DuOA_Md1KkV24Tx5haA@mail.gmail.com>
 <077249ac2bf2cb6d34347514e921720bb0f30b66.camel@linux.ibm.com>
 <CAHC9VhTvK=sJUgCUS0H9BWWXPnj3e0XkfE-4vB3-oxyt2_Wj9w@mail.gmail.com>
 <930e517c724fac27f7a1a4165af51dbc37cce4a0.camel@linux.ibm.com>
 <CAHC9VhStr3BAzb3tyHzHVPXzzuxyXjPQ4vmi+SrJqbTWio04+Q@mail.gmail.com>
 <2d800c3c0b6b4908843b490c36ef9df0cb4da134.camel@linux.ibm.com>
 <CAHC9VhSRepx+Q5pwhD3+AYPLXJAeL84FykLDnABfAwCUWXaWJA@mail.gmail.com>
 <CAHC9VhR1s+p-q35xqHL5Jj2WuzE=bhMrK6PBBThaUBiMRxwvuQ@mail.gmail.com>
 <0835ea7fd96df23419431301dfbc0d190e6c36f4.camel@linux.ibm.com>
 <CAHC9VhTbmmVrZCHCeZe-=s9fCGmEEDdb4p-skKJ=0wmX_K3arQ@mail.gmail.com> <20230831164627.GA4371@wind.enjellic.com>
In-Reply-To: <20230831164627.GA4371@wind.enjellic.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 31 Aug 2023 13:56:52 -0400
Message-ID: <CAHC9VhQx6LxSGEj_quZtVnf6VXfiBwazqpEqHdJT9Ro7BWTYHg@mail.gmail.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
To: "Dr. Greg" <greg@enjellic.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Sush Shringarputale <sushring@linux.microsoft.com>, 
	linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jarkko@kernel.org, 
	jgg@ziepe.ca, kgold@linux.ibm.com, bhe@redhat.com, vgoyal@redhat.com, 
	dyoung@redhat.com, kexec@lists.infradead.org, jmorris@namei.org, 
	serge@hallyn.com, code@tyhicks.com, nramas@linux.microsoft.com, 
	linux-security-module@vger.kernel.org, AmirGoldstein <amir73il@gmail.com>, 
	Tushar Sugandhi <tusharsu@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230831_105709_473559_08AF2391 
X-CRM114-Status: GOOD (  14.75  )
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

T24gVGh1LCBBdWcgMzEsIDIwMjMgYXQgMTI6NDfigK9QTSBEci4gR3JlZyA8Z3JlZ0BlbmplbGxp
Yy5jb20+IHdyb3RlOgo+IE9uIFdlZCwgQXVnIDMwLCAyMDIzIGF0IDA3OjIyOjI3UE0gLTA0MDAs
IFBhdWwgTW9vcmUgd3JvdGU6Cj4gPiBPbiBXZWQsIEF1ZyAzMCwgMjAyMyBhdCA3OjA3Pz8/UE0g
TWltaSBab2hhciA8em9oYXJAbGludXguaWJtLmNvbT4gd3JvdGU6Cj4gPiA+IE9uIFdlZCwgMjAy
My0wOC0zMCBhdCAxODoyMyAtMDQwMCwgUGF1bCBNb29yZSB3cm90ZToKPiA+ID4gPiBPbiBXZWQs
IEF1ZyAzMCwgMjAyMyBhdCA2OjIxPz8/UE0gUGF1bCBNb29yZSA8cGF1bEBwYXVsLW1vb3JlLmNv
bT4gd3JvdGU6Cj4gPiA+ID4gPiBPbiBXZWQsIEF1ZyAzMCwgMjAyMyBhdCA1OjUwPz8/UE0gTWlt
aSBab2hhciA8em9oYXJAbGludXguaWJtLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+IE9uIFdlZCwg
MjAyMy0wOC0zMCBhdCAxNjo0NyAtMDQwMCwgUGF1bCBNb29yZSB3cm90ZToKPiA+ID4gPiA+ID4g
PiBPbiBXZWQsIEF1ZyAzMCwgMjAyMyBhdCA0OjI1Pz8/UE0gTWltaSBab2hhciA8em9oYXJAbGlu
dXguaWJtLmNvbT4gd3JvdGU6CgouLi4KCj4gPiBBc3N1bWluZyBTdXNoIGFuZCBUdXNoYXIgcmV3
b3JrIHRoZSBkb2N1bWVudCB0byBjbGFyaWZ5IHRoZQo+ID4gbW90aXZhdGlvbi9wdXJwb3NlIGZv
ciB0aGUgd29yaywgYXMgeW91IHN1Z2dlc3RlZCBlYXJsaWVyLCBJJ20KPiA+IGFzc3VtaW5nIHdl
IGNhbiByZXZpc2l0IHRoaXMgcHJvYmxlbSBhbmQgc29sdXRpb25zPwo+Cj4gSU1BIHdpbGwgb2J2
aW91c2x5IGdvLCB3aXRoIG91ciBibGVzc2luZ3MsIGluIGl0cyBvd24gZGlyZWN0aW9uLgo+Cj4g
SSB3b3VsZCBvbmx5IGNhbGwgb3V0LCBhcyBJIGluZGljYXRlZCBpbiBteSByZXBseSB0byBLZW4g
R29sZG1hbiwgdGhhdAo+IG91ciAyMCsgeWVhciBvbGQgaW50ZWdyaXR5IGFuZCBhdHRlc3RhdGlv
biBhcmNoaXRlY3R1cmVzIGFuZCBtb2RlbHMKPiBhcmUgbm93IGFyZ3VhYmx5IGNoYWxsZW5nZWQs
IGdpdmVuIGVtZXJnaW5nIHRlY2hub2xvZ2llcyBhbmQgdGhlaXIKPiByZXF1aXJlbWVudHMgZm9y
IGludGVncml0eSBhbmQgY29uZmlkZW50aWFsaXR5Lgo+Cj4gVGhpcyB0aHJlYWQgaGlnaGxpZ2h0
cyBhIGxvdCBvZiB0aGUgaXNzdWVzIHRoYXQgY2F1c2VkIHVzIHRvIGJyaW5nCj4gVFNFTSB0byB0
aGUgdGFibGUgLi4uCgpJdCB3b3VsZCBiZSBoZWxwZnVsIGlmIHlvdSBjb3VsZCByZWZyYWluIGZy
b20gaGlqYWNraW5nIGJhcmVseQp0YW5nZW50aWFsbHkgcmVsYXRlZCB0aHJlYWRzIGFzIGEgbWFy
a2V0aW5nIHBpdGNoIGZvciBUU0VNLgoKRXZlcnlvbmUgaXMgd2VsY29tZSwgYW5kIGVuY291cmFn
ZWQgKCEpLCB0byBqb2luIHRoZSB1cHN0cmVhbQpkaXNjdXNzaW9uIHRocmVhZHMsIGVzcGVjaWFs
bHkgd2hlbiBvbmUgaGFzIHNvbWV0aGluZyByZWxldmFudCB0bwpjb250cmlidXRlIHdoaWNoIGhh
c24ndCBiZWVuIHByZXZpb3VzbHkgZGlzY3Vzc2VkLiAgSG93ZXZlciwgd2hlbgpldmVyeSBvdGhl
ciBjb250cmlidXRpb24gYW4gaW5kaXZpZHVhbCBtYWtlcyBmb2xsb3dzIHRoZSBwYXR0ZXJuIG9m
CiJ3ZSBjb3VsZCBzb2x2ZSBhbGwgb2YgdGhpcyBpZiB3ZSBvbmx5IGhhZCBmZWF0dXJlICdYJyB3
aGljaCBJCmhlbHBmdWxseSBwb3N0ZWQgaGVyZSA8bG9yZSBsaW5rPiIgdGhlbiB0aG9zZSBjb250
cmlidXRpb25zIGdyb3cgdmVyeQp0aXJpbmcgYW5kIEkgdGVuZCB0byBzdGFydCBpZ25vcmluZyB0
aGF0IGluZGl2aWR1YWwuCgotLSAKcGF1bC1tb29yZS5jb20KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8va2V4ZWMK
