Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523B4D32D9C
	for <kexec@archiver.kernel.org>; Fri,  5 Dec 2025 15:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u9Sh1gr9sSQ2OQz4zUzJ40SzpPcpTrnjv9Hty5mB8+A=; b=bLfM6Wju9ZOUtZaqJsBNIUmPTk
	Nf5+E7Kn3UsDDU7iiSPsKxMwhl0H5JRPL1cDEc3EDGKaMeGrZZfN3ZlEdJH/zne5YfL5DQKE+Bng1
	EzyhTNH6ypy5BJjdA4Q3EiY/fQp27s4U/s71exEJvzOP+oDn/Svf3EuZlBlmWipN54gQJbroXhgp1
	/WQMJvkH0vOAJIZw587A3lUBiOk/XpfoAhAf0q8FLrZpEYP+T5Etxmtqn0yQEiRve8kQC1908pdBY
	+k9v1t3rVsybsqeY2UdHmoi6St+TMxEj7qLTId2kTxdWkpLP5BC/7TU6CEGYoffM+9CmhgvudH2em
	27zTjP6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRXP7-00000009d1Z-3TL4;
	Fri, 05 Dec 2025 15:07:29 +0000
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRXP5-00000009d0U-1uv7
	for kexec@lists.infradead.org;
	Fri, 05 Dec 2025 15:07:28 +0000
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-42e2e445dbbso1138715f8f.2
        for <kexec@lists.infradead.org>; Fri, 05 Dec 2025 07:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764947246; x=1765552046; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9Sh1gr9sSQ2OQz4zUzJ40SzpPcpTrnjv9Hty5mB8+A=;
        b=dlCenZLF+F9sYaOfCVmR/xikp80EVs1Bgjjb6MNeULqlCcgtNJ6F5vAZ4YGSe9NmUM
         /vTGI5UnVtDHWM3NcwlBGiFEy4gJLFdQYk/RHVJ2y2kOzlyN74nAoxjPLwFZZxJuZLEx
         XR1HuWHKPI6LuOjK0rWG72jO7Tid28yLD+nlJpXzQlJi7oJ5HsM0TCYXqeMouksxcYNy
         Po6O8Ph/kTn8oFw/V5i1y7lB3kPP6X7Jt4q/oVwbeZve+55XSX9ChcdD5rnjPjPLXvo5
         7GEkyeOZaQGnrgHd0lZofPT/Q+v48+4bDamCTVCvY0RWh5FNPpKOU8XB/RIW8gkiOViH
         CNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764947246; x=1765552046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u9Sh1gr9sSQ2OQz4zUzJ40SzpPcpTrnjv9Hty5mB8+A=;
        b=GW5/4X6EgUOp1VPNMALwbgb6hDxQv7Ov6v1S4MwzU7rNbTZYugKReqBPxerr1L7zbZ
         oSnfxJRr3IHYYd3tAs0Juw5eMjk/ohZSmyhbR9nOCR2sy9cktnzyY5UpyQ3VDHRp6Gjb
         R88aBSf3+meRgw4F3SOQiX/tfSGl0Vs8PRj//LMNVGd3c8bXVc+HpSGcR8ynSC/8C9c0
         SFpaMn3Ax8JSdVynKOdITtw8JRfrwWqPsAI3fN11TLeut29aZjzj0ckhwpCT1xirzprn
         dKplFd63ZjMl9rk3WYcu1Aquhos2HBajwkyBTwWQ8uT2yaCGGGiywdo77lbROWOwx5xx
         kBlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhHe4TeqGY7h1J+GMR+cy0RfJs5KoZ5uxC01EWQSmo++g9sbsbTCMjWVmjjdHU9yW+0npTkg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyJpGCCqvn0EfP6ucbgdgSTXKAedmCjt9ijAe/2vpTfPIXgXv1Z
	g73VcDi19A4peW6hY2MH9Hlw3cQjFDySP4AbhMF9kLymW+1wngM+AmfzSB0Lu2tzgMbGkJYUZZt
	lijD2M3tLeWeXZuyHsVE16FccPvtbFFA=
X-Gm-Gg: ASbGncugVcvcqj7p/D6yt6qNFyvs5qR1HZSmbbZsDFx1tDCr5w42f2XBc1jnp+N8t04
	g5r2rUac8dF+q29G+hocHlJYoADdE2XuV/MuvNa7tIJ/k3mFHYt4Lt/XtJm7FWGrr5A0goEE1AA
	Y2DA9gHaiU9cU9j7Qlk8OXr+umM2jwLgzLi7MtC2dzR+2yCClNu8SdYHl2ywqkjtkqjnqz4yh3R
	0zszWLjyX4UMFdHZ1wT5MV6G13cZRbEGBBkpOR1qHK6MeHpCkbe1QNCzOvNSo2kplN5d0BIzihb
	vYEn+6+airxNb943nFmHyQ0K+rFidiTnlQ==
X-Google-Smtp-Source: AGHT+IFPNstD42JyEsdAwcyvNzKrPqWXxWF88WKwbukJxgV5AcHCpundKVhQRbFA20xriAn3ElLB1BNzDwQJkxHjQm4=
X-Received: by 2002:a05:6000:2c09:b0:429:8b01:c08d with SMTP id
 ffacd0b85a97d-42f731bc24dmr11041756f8f.41.1764947245574; Fri, 05 Dec 2025
 07:07:25 -0800 (PST)
MIME-Version: 1.0
References: <20251128033320.1349620-1-bhe@redhat.com> <CA+fCnZcVV5=AJUNfy6G2T-UZCbAL=7NivmWkBr6LMSnzzTZ8Kg@mail.gmail.com>
 <aTKGYzREbj/6Hwz6@fedora>
In-Reply-To: <aTKGYzREbj/6Hwz6@fedora>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 5 Dec 2025 16:07:14 +0100
X-Gm-Features: AQt7F2pv1BpZjdGZf4uiwOOKMqx6h_y-AphkDn6MuXmCXnyvxBMukG84fsup2wA
Message-ID: <CA+fCnZewpfDzdo51s6eGPzNohdQ6xHkBwX-Sxo1qty8pBgHZ4w@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, elver@google.com, sj@kernel.org, 
	lorenzo.stoakes@oracle.com, snovitoll@gmail.com, christophe.leroy@csgroup.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251205_070727_501691_DB99C12D 
X-CRM114-Status: GOOD (  18.71  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, Dec 5, 2025 at 8:14=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> > I also wonder if we should keep this kasan=3Doff functionality
> > conservative and limit it to x86 and arm64 (since these are the only
> > two tested architectures).
>
> We may not need to do that. I tested on arm64 because it has sw_tags and
> hw_tags. And if x86_64 and arm64 works well with kasan=3Doff in generic
> mode, it should be fine on other architectures. I am a little more
> familiar with operations on x86/arm64 than others.  I can manage to get
> power system to test kasan=3Doff in generic mode, if that is required.
> From my side, I would like to see x86_64/arm64/s390/power to have
> kasan=3Doff because RHEL support these architectures. I need consult peop=
le
> to make clear how to change in s390. Will post patch later or ask other
> people to help do that.
>
> While there seems to be no reason we don't let other arch-es have this
> benefit if the underlying code has paved the way, the arch side only need=
s
> two lines of judgement code. Personal opinion.

OK, but it would be great if the arch maintainers could review and
test the changes.

