Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFDBCD11DD
	for <kexec@archiver.kernel.org>; Thu, 28 Mar 2024 20:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kbwXLFyZcDCXLcacs49k/1+QZD8pPWy8+vS0bSDKPhk=; b=wd9XDEtg5gH3Yl
	OGWs9amJepzSwOzMa524C5pxXQ1w9BleVOKlWw2hOXSszwmWnDtr1LEvv/2s2/xRElJWqaTEca7Ep
	xi0vPQKtmbUqQl6OWr3NttQNoHG1q8Uch21bW6bbCVZ0i63zS6v9Bh/NO250/2KXChIDZ6QEO/11v
	5Hr07yUgg6Vca3QHc9HXmmwRdz+XhyosLdJKRdJj4bPj8YAq9MaVk/VBJsHElxtu3GgK7Wa7+KVVA
	vFaORRoSnfVXrCyt1i5t5xChObVvHbbO/j/HmkH5G3HQ7La4CB30hz8JrCBmilpQMcVa0glYw6mkA
	+/2OvjdlAzLVJwvQ8xHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpwaA-0000000FdpK-0hpP;
	Thu, 28 Mar 2024 20:42:42 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpwa5-0000000Fdhh-1pJf
	for kexec@lists.infradead.org;
	Thu, 28 Mar 2024 20:42:39 +0000
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a472f8c6a55so180673666b.0
        for <kexec@lists.infradead.org>; Thu, 28 Mar 2024 13:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711658547; x=1712263347; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xvp2uzp/QTshAzSCZHYKZUXilg18C3KOX1kGmd5mi/k=;
        b=QCYFKDdLYct8sOffvyoMAwvP06x9oewAcEaHWWV0LBtjg8UgIQ71OxeBk8byBvQzvW
         LCSIHvV1ifhM2EgrgUv1AiOt6cr5vxtgdJeJomdn/k29NM0ZnlpVGVJ0dQJyb7d2xaAi
         +2w3/9cCdrIohi4iD5Sbzy6NObO2PMHtgsN6uVs3jIV0wc1yx0u94Sa2RBUluHxXDYjf
         BdGPwWDE8LdiMKH57SVIkzK8jbds/ClHZ2pNHWYS74zA5+NvPRPdKNWRNeYVKuZA7f1c
         xT7ZAgEFacG7gJ+oxeRdtmVWcOre02sp7cwcn88shy8BIoy+23P3ygx28A6ZXYxW0Qp3
         GhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711658547; x=1712263347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xvp2uzp/QTshAzSCZHYKZUXilg18C3KOX1kGmd5mi/k=;
        b=W4zW1u8dXTPLOFua0C0JwQZZKvAdFd740L2i7idYD0tDukl65IVmUC8PgkQAyDnwmK
         R44d0+2tW4xS62toyzgTmmQcGt7tiaXlnGCzP7AVhr8kz8+DCUoZkdKtjySRAioLGiwP
         cls5J9zx/mEcPpt50u/3izAqBtOPzXIE+gAe3KUDCQZocenWu7QST/HwAn9GCajJYAm/
         1SbxyBd7cqIDFlBsyRKB83kNbmkiU6vIxd1hcDxVhCvo9RxtpYptYJ0BrcfldN2CJDdL
         d7MVuS2mCSHigii7iL+lktLiVeEo/KoJVR5VK/8JGf9orCdo5q4JbAYWKw2JI8TAulLV
         NGFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2j0ShGgNK13mc60HC62MkscTLcQ56yRrq74rJXUvrxPg/MShnFDmE7p6ZlWR5ZuCfuS88B+uWttGQMXPIgPpgbZmnvW0PfmjW
X-Gm-Message-State: AOJu0Yz921PaE6H87j964oOTBm351Kzmu5l4H6IHyVT0BHYOmUkA5KZk
	Bd7cgozBSAeuRCYmz5dcqO13oYl1fPE74iG/ShEZjN1FjW9JceGrUxpU9uPoio2scBPubjEeGER
	nstzJbc3xvEvIiSeRMGhH3qdasFjSmo/2uNum
X-Google-Smtp-Source: AGHT+IH8/usAUioO+qTpOeTXvg7l2hto6OnlgP6NOT2Q0qO008pCvTP/WT/jXd9Z+X+Kqw0CBmjAO9+FEscgo7LRR4o=
X-Received: by 2002:a17:906:594:b0:a47:32b3:18c5 with SMTP id
 20-20020a170906059400b00a4732b318c5mr203139ejn.68.1711658547456; Thu, 28 Mar
 2024 13:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240327-strncpy-fs-proc-vmcore-c-v1-1-e025ed08b1b0@google.com> <ZgTMZ1HYheBMDbei@MiWiFi-R3L-srv>
In-Reply-To: <ZgTMZ1HYheBMDbei@MiWiFi-R3L-srv>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 28 Mar 2024 13:42:15 -0700
Message-ID: <CAFhGd8pU-utbgHhU5s_20pC_aNK7xtsJDbf+Ayg4Dck2K=4kag@mail.gmail.com>
Subject: Re: [PATCH] vmcore: replace strncpy with strtomem
To: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_134237_605449_F4EA9E2B 
X-CRM114-Status: GOOD (  10.31  )
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

SGksCgpPbiBXZWQsIE1hciAyNywgMjAyNCBhdCA2OjQ44oCvUE0gQmFvcXVhbiBIZSA8YmhlQHJl
ZGhhdC5jb20+IHdyb3RlOgo+ID4gTWFyayB0aGVzZSBidWZmZXJzIGFzIF9fbm9uc3RyaW5nIGFu
ZCB1c2Ugc3RydG9tZW1fcGFkLgo+Cj4gVGhhbmtzLgo+Cj4gSSBkaWRuJ3QgYnVpbGQsIHdvbmRl
cmluZyBpZiAnX19ub25zdHJpbmcnIGhhcyB0byBiZSBzZXQgc28gdGhhdAo+IHN0cnRvbWVtX3Bh
ZCgpIGNhbiBiZSB1c2VkLgoKSSBkbyBub3QgYmVsaWV2ZSBtYXJraW5nIGJ1ZmZlcnMgYXMgX19u
b25zdHJpbmcgaXMgc3RyaWN0bHkgYQpyZXF1aXJlbWVudC4gSG93ZXZlciwgdGhlIGRvY3VtZW50
YXRpb24gZnJvbSBzdHJpbmcuaCArMzAyIHNheXMgd2UKc2hvdWxkIGRvIGl0OgovKioKICogc3Ry
dG9tZW1fcGFkIC0gQ29weSBOVUwtdGVybWluYXRlZCBzdHJpbmcgdG8gbm9uLU5VTC10ZXJtaW5h
dGVkIGJ1ZmZlcgogKgogKiBAZGVzdDogUG9pbnRlciBvZiBkZXN0aW5hdGlvbiBjaGFyYWN0ZXIg
YXJyYXkgKG1hcmtlZCBhcyBfX25vbnN0cmluZykKLi4uCgphbmQgc28gZG9lcyBbMV0gLi4uICJt
YXJrIHRoZSBkZXN0aW5hdGlvbiBidWZmZXIgdmFyaWFibGUgKG9yCnN0cnVjdHVyZSBtZW1iZXIp
IHdpdGggdGhlIF9fbm9uc3RyaW5nIGF0dHJpYnV0ZS4uLiIKCkZXSVcsIHRoaXMgYnVpbGRzIGp1
c3QgZmluZSB3aXRob3V0IHRoZSBfX25vbnN0cmluZyBhdHRyaWJ1dGUgYnV0IHdlCnNob3VsZCB1
c2UgaXQgOikKCj4KPiBUaGFua3MKPiBCYW9xdWFuCj4KClsxXSBodHRwczovL2dpdGh1Yi5jb20v
S1NQUC9saW51eC9pc3N1ZXMvOTAKClRoYW5rcwpKdXN0aW4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8va2V4ZWMK
