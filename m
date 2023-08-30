Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA737C83F01
	for <kexec@archiver.kernel.org>; Wed, 30 Aug 2023 22:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4EzupER9ZvNnl5Q6r/JLQuo+azDx8ccCUY9sQRY/VKI=; b=k9aI3Rfk0rs4R4
	7NdS/fdz+ONKABu54CsEvUiuLxN3IWeCIt1Ezwe/7cg180hq18tylHyLtaPmkH9BQX4vSHPxV3u5p
	+x5NluLz2nlrTLkQ10j+A8yh7GfbdhAEz3oFsuvms0cWlnFlWrhdgTlkFwAhBE1bMUeVC1LVsnYFa
	68q40lljvtQNfoBFrrFbgNGZv7pc57YHg9oNfGBft2Rss1dDJgNQyQh/98qHj5T+lXY5MajXQjRtZ
	DHHrcg1Ti2IY+4zXR4Xa20KcOPP9aWocs3Hu/Vzwuj9op22S2DZoh7OMcklzGAq50nET+AqQpt/KW
	wnqnN7FZtC+qs7A5vFxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbTbX-00EH6C-2d;
	Wed, 30 Aug 2023 22:24:03 +0000
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbTbU-00EH5m-2Y
	for kexec@lists.infradead.org;
	Wed, 30 Aug 2023 22:24:02 +0000
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-594ebdf7bceso3297917b3.2
        for <kexec@lists.infradead.org>; Wed, 30 Aug 2023 15:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693434239; x=1694039039; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjWmqDok0J1WfVl6IlIiwasRztrJpGXO0N2RYmQkhlE=;
        b=X5GtXWk8VVAjveNZuru5p8rIc7G+6F+16c6kJ057WYVAeHyWlZhrua49pjoKdYJZGe
         rsSFU+PpCdHyqh/T+z4y3+C0dDv8xGiYXewEsw22pl6jMa7U5oNWHJcIVNFZDM5BSqCa
         N5oC/YOriLMwR4loe6eIjoTkEgO3E0lP6BIpS6Jzzy87hEGQQXZeVUrduS0rjwV7lQn1
         TG0zd1QRW/DL7bAVrWO0fnD8WOf0+KiB62vM57OzWjjBbDtYpi2zhYxGqUrbwxHmjBU5
         l8gbwhNXnrEZSVkpVcnQuJ4rQQKnZrZpljn9mrJzNHR935SOQC1Gh0uUWg7wK8fWWMyG
         7mhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693434239; x=1694039039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjWmqDok0J1WfVl6IlIiwasRztrJpGXO0N2RYmQkhlE=;
        b=Sm+oh4ZNBhgz3qDHr+JSK6WiQEXto0gm+q+jwLGB0PWmgrDAPxVWtsYBC2HXc1qYzn
         VkDniJMbM56iPlDqs/+HvPCWZj3hPkQiun7jtqU2yFPGLCN5iAq7uM1R1c7TP1X1s+v/
         Q38moDngAb8jcJ6aVC4qybhMAMxf22qUC3QV1kDo+OG6csm7uSO5aJKuOQ0p9+A2fknO
         WdvpuusZ0iZyYHv5v/0mfF/72YJ7UresYT9ognopyMV8LTqnG+yr5EZHhKuWfyuE+Qxu
         j2bFduI6R+kvVZJg02nN1iTD8yxQnC2me8ozyJ6NHgczvRtw3xboKI625bEW5iilsLP+
         P7vA==
X-Gm-Message-State: AOJu0YzJzhNsQOYNzby+KElgGerk1FJhMXFybFFGDoJGQIANCJtLI58a
	2FMv8S4T8sj+EpjRZu8a34NOfczlVvVCzgCLU+Hv
X-Google-Smtp-Source: AGHT+IGrEi6pt0g8LModQuWcTQ9oESq9pt27wk/7QM3vj0Gkl/gBXWjflCeUVKhjBNYNZStP5dOPT7d4NSwl0eq/5AM=
X-Received: by 2002:a81:9981:0:b0:586:9cbb:eef4 with SMTP id
 q123-20020a819981000000b005869cbbeef4mr3404191ywg.2.1693434239191; Wed, 30
 Aug 2023 15:23:59 -0700 (PDT)
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
 <CAHC9VhTvK=sJUgCUS0H9BWWXPnj3e0XkfE-4vB3-oxyt2_Wj9w@mail.gmail.com>
 <930e517c724fac27f7a1a4165af51dbc37cce4a0.camel@linux.ibm.com>
 <CAHC9VhStr3BAzb3tyHzHVPXzzuxyXjPQ4vmi+SrJqbTWio04+Q@mail.gmail.com>
 <2d800c3c0b6b4908843b490c36ef9df0cb4da134.camel@linux.ibm.com> <CAHC9VhSRepx+Q5pwhD3+AYPLXJAeL84FykLDnABfAwCUWXaWJA@mail.gmail.com>
In-Reply-To: <CAHC9VhSRepx+Q5pwhD3+AYPLXJAeL84FykLDnABfAwCUWXaWJA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 30 Aug 2023 18:23:48 -0400
Message-ID: <CAHC9VhR1s+p-q35xqHL5Jj2WuzE=bhMrK6PBBThaUBiMRxwvuQ@mail.gmail.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Sush Shringarputale <sushring@linux.microsoft.com>, linux-integrity@vger.kernel.org, 
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, kgold@linux.ibm.com, 
	bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com, 
	kexec@lists.infradead.org, jmorris@namei.org, serge@hallyn.com, 
	code@tyhicks.com, nramas@linux.microsoft.com, 
	linux-security-module@vger.kernel.org, AmirGoldstein <amir73il@gmail.com>, 
	Tushar Sugandhi <tusharsu@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_152400_849576_07734728 
X-CRM114-Status: GOOD (  18.57  )
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

T24gV2VkLCBBdWcgMzAsIDIwMjMgYXQgNjoyMeKAr1BNIFBhdWwgTW9vcmUgPHBhdWxAcGF1bC1t
b29yZS5jb20+IHdyb3RlOgo+IE9uIFdlZCwgQXVnIDMwLCAyMDIzIGF0IDU6NTDigK9QTSBNaW1p
IFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiB3cm90ZToKPiA+IE9uIFdlZCwgMjAyMy0wOC0z
MCBhdCAxNjo0NyAtMDQwMCwgUGF1bCBNb29yZSB3cm90ZToKPiA+ID4gT24gV2VkLCBBdWcgMzAs
IDIwMjMgYXQgNDoyNeKAr1BNIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+IHdyb3Rl
Ogo+ID4gPiA+IFlvdXIgaW5pdGlhbCBxdWVzdGlvbiB3YXMgIndoYXQgaGFwcGVucyBpZiB0aGUg
ZmlsZS9maWxlc3lzdGVtIGJlY29tZXMKPiA+ID4gPiBpbmFjY2Vzc2libGUgYXQgc29tZSBwb2lu
dCBhbmQgYW4gYXR0ZXN0YXRpb24gY2xpZW50IGF0dGVtcHRzIHRvIHJlYWQKPiA+ID4gPiB0aGUg
ZW50aXJlIGxvZz8iLiAgRm9yIHdoYXQgcmVhc29uIHdvdWxkIGl0IGJlIGluYWNjZXNzaWJsZT8g
IEZvciB0aGUKPiA+ID4gPiBvcmlnaW5hbCBzaW5nbGUgdG1wZnMgZmlsZSwgd2hhdCB3b3VsZCBt
YWtlIGl0IGluYWNjZXNzaWJsZT8KPiA+ID4KPiA+ID4gSW4geW91ciByZXBseSB0aGF0IEkgaGFk
IHJlc3BvbmRlZCB0byB5b3UgaGFkIG1lbnRpb25lZCB0aGF0IHRoZQo+ID4gPiBrZXJuZWwgd2Fz
IHNpbXBseSBiZWluZyBwYXNzZWQgYSBmZCBhbmQgdGFraW5nIG93bmVyc2hpcCBvZiBpdCwgdGhl
IGZkCj4gPiA+IGNvdWxkIGVpdGhlciBiZSBhIHRtcGZzIGJhY2tlZCBmaWxlIG9yIHNvbWUgZm9y
bSBvZiBwZXJzaXN0ZW50IHN0b3JhZ2UKPiA+ID4gYXMgYm90aCB3ZXJlIGRpc2N1c3NlZCBpbiB0
aGlzIHRocmVhZC4gIEkgaW1hZ2luZSBhIHRtcGZzIGZpbGVzeXN0ZW0KPiA+ID4gY291bGQgc3Rp
bGwgYmUgZm9yY2libHkgdW5tb3VudGVkLCByZXN1bHRpbmcgaW4gcHJvYmxlbXMsIGJ1dCBJIGNh
bid0Cj4gPiA+IHNheSB0aGF0IGZvciBjZXJ0YWluLiAgSG93ZXZlciwgdGhlcmUgYXJlIGRlZmlu
aXRlbHkgY2FzZXMgd2hlcmUgYSBmZAo+ID4gPiBiYWNrZWQgYWdhaW5zdCBhbiBhcmJpdHJhcnkg
ZmlsZXN5c3RlbSBjb3VsZCBydW4gaW50byBwcm9ibGVtczoKPiA+ID4gc3RvcmFnZSBkZXZpY2Ug
aXNzdWVzIGZvciBsb2NhbCBmaWxlc3lzdGVtcywgbmV0d29ya2luZyBpc3N1ZXMgZm9yCj4gPiA+
IG5ldHdvcmsgZmlsZXN5c3RlbXMsIGFuZCBnb29kIG9sZCBmYXNoaW9uZWQgdXNlci9hZG1pbiBp
bnRlcnZlbnRpb24gaW4KPiA+ID4gYm90aCBjYXNlcy4KPiA+Cj4gPiAiSSBpbWFnaW5lIHRtcGZz
IGZpbGVzeXN0ZW0gY291bGQgc3RpbGwgYmUgZm9yY2libHkgdW5tb3VudGVkIiBzb3VuZHMKPiA+
IGxpa2UgYW4gYXR0YWNrLiBOb3QgYmVpbmcgYWJsZSB0byB2ZXJpZnkgdGhlIG1lYXN1cmVtZW50
IGxpc3QgYWdhaW5zdCBhCj4gPiBxdW90ZSBpcyBwcm9iYWJseSBhIGdvb2QgdGhpbmcuCj4KPiBP
a2F5LCBjYW4geW91IGFuc3dlciB0aGUgcXVlc3Rpb24gZm9yIGFuIGFyYml0cmFyeSBwZXJzaXN0
ZW50Cj4gZmlsZXN5c3RlbT8gIFRoYXQgd2FzIGFsd2F5cyB0aGUgbW9yZSBpbXBvcnRhbnQgcXVl
c3Rpb24sIGFuZCB5b3VyCj4gY29udGludWVkIGF2b2lkYW5jZSBpcyBnZXR0aW5nIG1lIGluY3Jl
YXNpbmdseSBhbm5veWVkLgoKU3BlYWtpbmcgb2YgYmVpbmcgYW5ub3llZCwgSSdtIGZpeGluZyBU
dXNoYXIncyBlbWFpbCBhcyB0aGUgYm91bmNlcwphcmUgYWxzbyBkcml2aW5nIG1lIG51dHMuCgot
LSAKcGF1bC1tb29yZS5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
