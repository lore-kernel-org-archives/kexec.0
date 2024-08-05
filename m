Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49EAC52D6F
	for <kexec@archiver.kernel.org>; Mon,  5 Aug 2024 07:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D2arctFfCmu3Auj0IAyPDK+WcNygxhLiakCAtnGg30s=; b=3Vo+DtprAISXq6
	EIemNOctFiBgJD0laWJTRT/pwafxfIeV8RsJErSJ5yHLwzd3kxhL1yvnIYm+JdOy1BTk4oWA7ypPM
	Hroqy0vSu+JW4yC778FWrKQxhaONKp8rT8+DhrLn5RVhLJSlXQ4KrSIEfGfVndIGTUr6MdFP76buk
	q1JKewOvIvA8xRVdfrggunP/6tpa+AtYQnbVFzKJo4NenwRN67zGGpgh6w556W/5l5H53bTo8fRQp
	0lJlT7Sta2hzKSqmlGAn7wx6L6aO8DxAASxfWSPpnUrLitzJCLenzn+5u+7Ko092iTIkOq5gONFLy
	0d8z+/2FWH/N4/dcOH8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sarwF-0000000EtYW-1fKb;
	Mon, 05 Aug 2024 07:15:27 +0000
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sarvh-0000000EtKy-3leQ
	for kexec@lists.infradead.org;
	Mon, 05 Aug 2024 07:14:55 +0000
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2f183f4fa63so4618071fa.1
        for <kexec@lists.infradead.org>; Mon, 05 Aug 2024 00:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722842092; x=1723446892; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y19XxSyjp3CKMWvlV4BQJW0+ZXcKqmWJAVbV5kfedD0=;
        b=Pq+0ilHqaH69NDxrtpSAsbQpAtJVJPcMmL8IvRlUlHbvm2Vi+G5yMl3ikNN+p+MRMT
         sOTrQOhODcT63nNgf5YX5tMvCjMDb3DJUFk1Ke9CHoMDg2/L+zi1hXhOsOwpkIeFiJe6
         21FopM85F+6STVdJ3DQJIbze3+BVD+AvAH7kQYvdh+ZEDoF5Qczht8byVc6Ql/DPivP/
         tDsq9ZO6gFi5ToRqEWKpyi66HO70vC+P7qI9cbw2vteDawJw6xG+nWtzxKB+pDkP+reR
         VnnJTk+ui4fClk1wV1Q3z18meYq2n5ytwwz+aEnQ6+F193Iukij2+OQhEN0sTQNvQ84y
         +G8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722842092; x=1723446892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y19XxSyjp3CKMWvlV4BQJW0+ZXcKqmWJAVbV5kfedD0=;
        b=Ca7IM1RQRie1VXGshT+ZgN9HchWvviFHTME+2Tq9PoxxE43I2Bu8ik8e7BFwjsc5vD
         WRyY93LgStp2GW42/VJw0wspsGTyreSALJXYBTH7d6ER5AkTCrMzBLk2UD/4Q0XjCUX7
         ueAJMEwfdoOxfZbE45D+nMUmiUwt3vUVL9mLArFCpXmJHcjmb2HkY9VHHRFvDJQzLlYn
         XQw+9AZDwuySjI2rjmzo4HO1wr5uGP1gW4Y/N6U7uOWZr6wLugYM76Z+2jGTI1NNc/Es
         rlpzR0e0wJCe3xDMRq6L8FuND1lPa4y80Tg0spLrTBTEMnzzNInLbgX2Rq2AbxhUc0fs
         SDwg==
X-Forwarded-Encrypted: i=1; AJvYcCW6/JGegmVhnupVFGsz6Y3S8jR1Db4nZRcnpq6SHKZytA13bQo4aj7mmzagCAKoO49Mz+8LOZQ09tBPsr+X299k4TTw1so1ZKaH
X-Gm-Message-State: AOJu0YyJuFnNaDS7m2UceQYSLkgFbD0TzvKlA2pFGIr5yQqOXcCrEiBC
	Kp7mtcdKWGvcQ2IT7aM60Lhw81PVIDmRFKdZIXXl5oCQJfewIrBqJLZErcqLvyRZvor//9XJih+
	MyNXzimuMXBjYw9/lrsrl4ny+3LqkxCdnw62U+w==
X-Google-Smtp-Source: AGHT+IF34z/ZLUVlzH77E64wmhKMmfMRwH+K/qOicLm/MuBaXCwJmFb/RSZD904NTBGvXcfzD9/ptc74/DWwaWjwUNY=
X-Received: by 2002:a2e:7a05:0:b0:2ef:2d83:c136 with SMTP id
 38308e7fff4ca-2f15b113e4bmr29565551fa.1.1722842091808; Mon, 05 Aug 2024
 00:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240708133348.3592667-1-ruanjinjie@huawei.com> <20240708133348.3592667-3-ruanjinjie@huawei.com>
In-Reply-To: <20240708133348.3592667-3-ruanjinjie@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Aug 2024 09:14:40 +0200
Message-ID: <CACRpkda+ZqXXbvXBotNbpK39_ghtY77AVi_bGLYMn2r_r-X6-Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: Fix crash kenrel data type bug
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux@armlinux.org.uk, bhe@redhat.com, vgoyal@redhat.com, 
	dyoung@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, arnd@arndb.de, afd@ti.com, akpm@linux-foundation.org, 
	rmk+kernel@armlinux.org.uk, eric.devolder@oracle.com, 
	gregkh@linuxfoundation.org, deller@gmx.de, javierm@redhat.com, 
	robh@kernel.org, thunder.leizhen@huawei.com, austindh.kim@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240805_001453_957374_5D250485 
X-CRM114-Status: GOOD (  11.42  )
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

T24gTW9uLCBKdWwgOCwgMjAyNCBhdCAzOjI54oCvUE0gSmluamllIFJ1YW4gPHJ1YW5qaW5qaWVA
aHVhd2VpLmNvbT4gd3JvdGU6Cgo+IE9uIFFFTVUgdmV4cHJlc3MtYTkgd2l0aCAxR0IgbWVtb3J5
LCB0aGUgY3Jhc2gga2VybmVsICJjcmFzaGtlcm5lbD00RyIKPiBpcyBvayBhcyBiZWxvdzoKPiAg
ICAgICAgIFJlc2VydmluZyA0MDk2TUIgb2YgbWVtb3J5IGF0IDI0MzJNQiBmb3IgY3Jhc2hrZXJu
ZWwgKFN5c3RlbSBSQU06IDEwMjRNQikKPgo+IFRoZSBhYm92ZSBpbmZvIGlzIGNvbmZ1c2luZywg
YmVjYXVzZSB0aGUgU3lzdGVtIG1lbW9yeSBpcyBhcyBiZWxvdzoKPiAgICAgICAgICMgY2F0IC9w
cm9jL2lvbWVtIHwgZ3JlcCBTeXMKPiAgICAgICAgIDYwMDAwMDAwLTlmZmZmZmZmIDogU3lzdGVt
IFJBTQo+Cj4gVGhlIGNhdXNlIGlzIHRoYXQgdGhlIGNyYXNoX3NpemUgaXMgcGFyc2VkIGFuZCBw
cmludGVkIHdpdGggInVuc2lnbmVkIGxvbmcKPiBsb25nIiBkYXRhIHR5cGUgd2hpY2ggaXMgOCBi
eXRlcyBidXQgdXNlZCB3aXRoICJwaHlzX2FkZHJfdCIgd2hpY2ggaXMKPiA0IGJ5dGVzIGluIG1l
bWJsb2NrX3BoeXNfYWxsb2NfcmFuZ2UoKS4KCklzIHRoYXQgdGhlIHdob2xlIGV4cGxhbmF0aW9u
PwoKPiAgICAgICAgIC8qIGludmFsaWQgdmFsdWUgc3BlY2lmaWVkIG9yIGNyYXNoa2VybmVsPTAg
Ki8KPiArICAgICAgIGNyYXNoX3NpemUgPSAocGh5c19hZGRyX3QpY3Jhc2hfc2l6ZTsKPiAgICAg
ICAgIGlmIChyZXQgfHwgIWNyYXNoX3NpemUpCj4gICAgICAgICAgICAgICAgIHJldHVybjsKCkhv
dyBkaWQgY3Jhc2hfc2l6ZSBnZXQgYXNzaWduZWQgYmVmb3JlIHlvdSBhZGRlZCB0aGlzIG9uZWxp
bmVyPwoKWW91cnMsCkxpbnVzIFdhbGxlaWoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
