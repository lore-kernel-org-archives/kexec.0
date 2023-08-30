Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A753C6FA8F
	for <kexec@archiver.kernel.org>; Wed, 30 Aug 2023 20:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kPkdpsxDu4gCKmBs0sNxUZbk5AtV/4lsGz/ywBbXkgY=; b=YEJPiEgn4rnSAz
	rlLoozmKBOtYv6k0sMZQkJyRxyQTNKC12JHXktsM6hvaQKUJF1EoeL9odVoB0rR++YLh26BYFZb0b
	UgCDK/epIEBNCxVWqt0R1vscGk7KPmyflpKeeSY24me1H6c5GvKcQrb/kyZd0QVE84wT0HIcK+8tg
	2704Wea/aK6GtBo0zIi5wVgoHaIY56kwmGS+bxgoLAQBvk0KWuJ1uyNJYqIsfnEEymlvzfDC2NfLi
	FKCcVzjBMgPyuCt6UcPo381E4Ir6LIWGEpecePETK/vQI9qa85w6PomZG2yifPhWoMY47PPasF4En
	eJviqkrQN7COCqU4gwjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbS6V-00E9xj-2v;
	Wed, 30 Aug 2023 20:47:55 +0000
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbS6T-00E9xP-1N
	for kexec@lists.infradead.org;
	Wed, 30 Aug 2023 20:47:54 +0000
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-59209b12c50so2790547b3.0
        for <kexec@lists.infradead.org>; Wed, 30 Aug 2023 13:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693428471; x=1694033271; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssuGzZWwIiUWbDzTGLwSAE+t2YPIoJ48hSVHvjVyTrQ=;
        b=Vtg6eAaC9JuxtCh+raOnfkMYPHdvJusytJLfHrPiSM25iHdsflZwS+fLxtWGiL+JHQ
         DMQmu39u8GhdfTWqZmbCkpGrmYuxlAJdzTad821TxikI3WYg0qg3pFW3NdZdZJ4blEeV
         wYSHol/v5qvIINl1/iJVOdamTcc2ah8IvUuKk3U7aC0vp1HlgKFolzVi5OemnVwN+AF0
         m54S5eH7/vWDFimQRbyTJEyiVqCyXjOS5hIok4cEsleSrzEkd4aP9hYLbOYAHMi04o4y
         sut8sr91AcUq1kOZMmfRWgAMRzfJv/dPkotGg9S34i1mfOoEPdi01Ql33vEXmy46DLJv
         sAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693428472; x=1694033272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssuGzZWwIiUWbDzTGLwSAE+t2YPIoJ48hSVHvjVyTrQ=;
        b=MJ0y0XVG3Yy6yyp95viaCshqsiK/Sh3zjAREbT4WirztUCOFg74pxA8NBm2vY93UTn
         SXQt0RlWAWOWkeUz4anRem5rAD1x77XuI0wnG+/W6uOlMf5J3MpQO7B/Xh1DQHdbJFr1
         AjLWc+UjMPgrJ+Hvujq1tH3TLySiUUtJcFcyouUQfAdSN7e1mvz5s34PpXYBM5vAgec5
         VprQ05Lf+wmfvPnE0ttFsUnWch96QmMB2s7hLeNW6FV6QRg3Mj2vI6Xfck9CgmiXRPCR
         HLV5EgqA3VXRyYwbMVOsaFXxlYqkVT9D4KUjHQck50DJ7dkfpRBju2fvczcJ5j5KLK0j
         yCbw==
X-Gm-Message-State: AOJu0YwBh+MJgiMqG/hSx3QNNijbIITzxwhIFf/r9y5WcLUteD1TzvqN
	0iiz7jKVE7A2zs+UANJtgvqT2e+qrrIA+LhXt45S
X-Google-Smtp-Source: AGHT+IHDRYogg+GkQ5vRG7NJp8ux1iBN2Yw6FJC8DSmoHEs6dPTAHHn7AHBZfxkPF4xTpQ/AfDZfr3Fo/8jD1GOCr/k=
X-Received: by 2002:a0d:f747:0:b0:595:80e4:907d with SMTP id
 h68-20020a0df747000000b0059580e4907dmr3028540ywf.32.1693428471675; Wed, 30
 Aug 2023 13:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
 <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
 <0e1511e8819b24ab8a34a7b15821f06eff688f29.camel@linux.ibm.com>
 <8bc0f024-fc12-cb32-7af0-e500948cc6db@linux.microsoft.com>
 <7e32afa2596b9d8cfdc275614575b2023cd1d673.camel@linux.ibm.com>
 <CAHC9VhSVO9t=9e9JmniXKoqqvMv42E4dVeYtQTWZ4Eih3Sfr0Q@mail.gmail.com>
 <ed16f899485cbd559f9e6d7fbe17fa0d92335c20.camel@linux.ibm.com>
 <CAHC9VhTjej-GFjvEQhnL-HWnnkvJKA_DuOA_Md1KkV24Tx5haA@mail.gmail.com>
 <077249ac2bf2cb6d34347514e921720bb0f30b66.camel@linux.ibm.com>
 <CAHC9VhTvK=sJUgCUS0H9BWWXPnj3e0XkfE-4vB3-oxyt2_Wj9w@mail.gmail.com> <930e517c724fac27f7a1a4165af51dbc37cce4a0.camel@linux.ibm.com>
In-Reply-To: <930e517c724fac27f7a1a4165af51dbc37cce4a0.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 30 Aug 2023 16:47:40 -0400
Message-ID: <CAHC9VhStr3BAzb3tyHzHVPXzzuxyXjPQ4vmi+SrJqbTWio04+Q@mail.gmail.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Sush Shringarputale <sushring@linux.microsoft.com>, linux-integrity@vger.kernel.org, 
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, kgold@linux.ibm.com, 
	bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com, 
	kexec@lists.infradead.org, jmorris@namei.org, serge@hallyn.com, 
	code@tyhicks.com, nramas@linux.microsoft.com, 
	Tushar Sugandhi <tusharsu@linux.mic>, linux-security-module@vger.kernel.org, 
	AmirGoldstein <amir73il@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_134753_599179_ADF48093 
X-CRM114-Status: GOOD (  13.78  )
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

T24gV2VkLCBBdWcgMzAsIDIwMjMgYXQgNDoyNeKAr1BNIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4
LmlibS5jb20+IHdyb3RlOgo+IFlvdXIgaW5pdGlhbCBxdWVzdGlvbiB3YXMgIndoYXQgaGFwcGVu
cyBpZiB0aGUgZmlsZS9maWxlc3lzdGVtIGJlY29tZXMKPiBpbmFjY2Vzc2libGUgYXQgc29tZSBw
b2ludCBhbmQgYW4gYXR0ZXN0YXRpb24gY2xpZW50IGF0dGVtcHRzIHRvIHJlYWQKPiB0aGUgZW50
aXJlIGxvZz8iLiAgRm9yIHdoYXQgcmVhc29uIHdvdWxkIGl0IGJlIGluYWNjZXNzaWJsZT8gIEZv
ciB0aGUKPiBvcmlnaW5hbCBzaW5nbGUgdG1wZnMgZmlsZSwgd2hhdCB3b3VsZCBtYWtlIGl0IGlu
YWNjZXNzaWJsZT8KCkluIHlvdXIgcmVwbHkgdGhhdCBJIGhhZCByZXNwb25kZWQgdG8geW91IGhh
ZCBtZW50aW9uZWQgdGhhdCB0aGUKa2VybmVsIHdhcyBzaW1wbHkgYmVpbmcgcGFzc2VkIGEgZmQg
YW5kIHRha2luZyBvd25lcnNoaXAgb2YgaXQsIHRoZSBmZApjb3VsZCBlaXRoZXIgYmUgYSB0bXBm
cyBiYWNrZWQgZmlsZSBvciBzb21lIGZvcm0gb2YgcGVyc2lzdGVudCBzdG9yYWdlCmFzIGJvdGgg
d2VyZSBkaXNjdXNzZWQgaW4gdGhpcyB0aHJlYWQuICBJIGltYWdpbmUgYSB0bXBmcyBmaWxlc3lz
dGVtCmNvdWxkIHN0aWxsIGJlIGZvcmNpYmx5IHVubW91bnRlZCwgcmVzdWx0aW5nIGluIHByb2Js
ZW1zLCBidXQgSSBjYW4ndApzYXkgdGhhdCBmb3IgY2VydGFpbi4gIEhvd2V2ZXIsIHRoZXJlIGFy
ZSBkZWZpbml0ZWx5IGNhc2VzIHdoZXJlIGEgZmQKYmFja2VkIGFnYWluc3QgYW4gYXJiaXRyYXJ5
IGZpbGVzeXN0ZW0gY291bGQgcnVuIGludG8gcHJvYmxlbXM6CnN0b3JhZ2UgZGV2aWNlIGlzc3Vl
cyBmb3IgbG9jYWwgZmlsZXN5c3RlbXMsIG5ldHdvcmtpbmcgaXNzdWVzIGZvcgpuZXR3b3JrIGZp
bGVzeXN0ZW1zLCBhbmQgZ29vZCBvbGQgZmFzaGlvbmVkIHVzZXIvYWRtaW4gaW50ZXJ2ZW50aW9u
IGluCmJvdGggY2FzZXMuCgo+IEluIHRoZQo+ICJzbmFwc2hvdHRpbmciIGRlc2lnbiB0aGlzIHBy
b2JsZW0gYmVjb21lcyBhIHVzZXJzcGFjZSBpc3N1ZS4KClllcywgZXhhY3RseS4gIFVzZXJzcGFj
ZSBpcyBhbG1vc3QgYWx3YXlzIGdvaW5nIHRvIGhhdmUgYW4gZWFzaWVyIHRpbWUKcmVjb3Zlcmlu
ZyBmcm9tIHRoZXNlIHR5cGVzIG9mIGVycm9ycyAuLi4gb3IgYXQgbGVhc3QgSSBiZWxpZXZlIHNv
LApwZXJoYXBzIHlvdSBoYXZlIGEgY2xldmVyIHNvbHV0aW9uIGZvciBob3cgdGhlIGtlcm5lbCBj
YW4gaGFuZGxlIHRoZQpmaWxlL2ZpbGVzeXN0ZW0gZGlzYXBwZWFyaW5nIGZyb20gdW5kZXIgdGhl
IGZkPwoKPiBUaGUgZmlyc3Qgc2VudGVuY2Ugb2YgdGhlIGNvdmVyIGxldHRlciBpcyAiRGVwZW5k
aW5nIG9uIHRoZSBJTUEgcG9saWN5LAo+IHRoZSBJTUEgbG9nIGNhbiBjb25zdW1lIGEgbG90IG9m
IEtlcm5lbCBtZW1vcnkgb24gdGhlIGRldmljZS4iIC4uLgoKQXMgSSdtIHN0aWxsIGxvb2tpbmcg
Zm9yIGFuIGFuc3dlciB0byBteSBxdWVzdGlvbiwgbGV0J3Mgc3RheSBmb2N1c2VkCm9uIHRoYXQg
YmVmb3JlIHdlIHN0YXJ0IHdvcnJ5aW5nIHRvbyBtdWNoIGFib3V0IHRoZSBwaHJhc2luZyBvZiB0
aGUKZGVzaWduIHByb3Bvc2FsIHRoYXQgd2FzIHN1Ym1pdHRlZC4KCi0tIApwYXVsLW1vb3JlLmNv
bQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMg
bWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
