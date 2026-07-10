Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6650EC43458
	for <kexec@archiver.kernel.org>; Fri, 10 Jul 2026 12:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n6yMtU5a9xI+ekMnhRgl8xfMzS3v7/anO/PeMGwUz3g=; b=TevlmIIkaaaVAF3SodNBY5w8Sj
	gzwCDc04Yp4J9esVRJeFhPc2F5nA5BPWUyHj9UVMqZmFQhzj85+AinTES4Zg35uUknQp7s02MeShP
	/lMvOapF70/YjoivrlEKQFeaz85gG+0jlr8vPVE61+aGZ5h2rIKhvWb4RT6ch2APkwtDhipgk8kov
	ZLoOms0WQsZbsunErtWxdTQkzAz/jiyFj+IWTwEjxJ9nzIHt+RO90vce8oGB9o8vbLoXq9qrH54QS
	HzLo8QvM+x8qdzCs/QDm6jgA1y0vsSS4NmcsYHI1sVO8xxr3mKGh+wHdpc1Y9JW1obPC/efP0P+AN
	NOczb/QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi9yB-00000004tFU-10ui;
	Fri, 10 Jul 2026 12:04:39 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi9y9-00000004tFO-0zr2
	for kexec@bombadil.infradead.org;
	Fri, 10 Jul 2026 12:04:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=n6yMtU5a9xI+ekMnhRgl8xfMzS3v7/anO/PeMGwUz3g=; b=LcDI2H8No1JprxidNJQBFO+GWZ
	tK4qVUxsDXQhP3JPqSxCeSE663533k0DmIBlgqY2d2N6DTDTnqBNeUfZdKEcA88CJEVTRQk5lMUGd
	I9j3pCnHVsahcetApC7foossBC+jOWtlito6mgNKZUn/8B60Hn/MJfrmfPFw07jlJxQZUBET4mBG6
	sMGeXTeazP4MIqCn8qo9tqam3rOYkc0uvV0um7lbtAWcvk4Ezx1PyIk8krnk9fwXYUzwClGtlUEf7
	1U/93RjLPbtQiI6oBfQ8XM5tvM5SjlCByu8u8UMl1XBZ2HeY+RAUIo+iCmJt4PQXzKJ6ZonWYdVCp
	TRMqCc4A==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wi9y6-00000009zLc-20CE
	for kexec@lists.infradead.org;
	Fri, 10 Jul 2026 12:04:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783685066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n6yMtU5a9xI+ekMnhRgl8xfMzS3v7/anO/PeMGwUz3g=;
	b=Poyp1AlJTMKDCp6EGovvoZreO0aB/RzUFUuLgPzL3lL3bgkgZtix7dYxHKPcXTASzpriKA
	wTXaUcOP5JjduW73AWm+/XNr/WSjtcqoKPKJ2ajc4yS9BbEc3MneB1V53HM5i4w6++0Yix
	398zd+QKtEIAPZTwi2l2Tti6qckdGNo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783685073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n6yMtU5a9xI+ekMnhRgl8xfMzS3v7/anO/PeMGwUz3g=;
	b=gRkPXNiQcGsXNgvB8dh4/AFr05VAHgzx8HlWJpJwywWPah6nekGHNaNF+/NbBQsQGoEBMe
	dLLa5Z7SIYAr9Lu46QRaAsuqrbyWzfUWegksXwa75SkDlUIeo98YKa5mAchKRfBekwUw6+
	lAaL/uEQKosOIARhaqefT6k01NPfll4=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-cEeEn6x8OqCjqJ00xmaBQg-1; Fri, 10 Jul 2026 08:04:23 -0400
X-MC-Unique: cEeEn6x8OqCjqJ00xmaBQg-1
X-Mimecast-MFC-AGG-ID: cEeEn6x8OqCjqJ00xmaBQg_1783685063
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-495b8b30310so861148b6e.1
        for <kexec@lists.infradead.org>; Fri, 10 Jul 2026 05:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783685063; x=1784289863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n6yMtU5a9xI+ekMnhRgl8xfMzS3v7/anO/PeMGwUz3g=;
        b=jzYArAi7tNOxesnpemseRJK8eOptnS0KNKHWgC/zbZ9Ep54NGnqVG7cTHYER2ny2pj
         N+JK5g4z4AI22B3H8buycwDRr8yhwg4Y0StsLUOAB2YUSBVfTL1308sEdwAYdKlhSivs
         c9oVzF0Hz4CxWTmxp8X5HlC8ZpRlN2NLs7z7UWYsxPmlMmKxBe9kIxmyRZIf8MnuTfes
         NnaATg3bWjXeCRw5XzjosdWENiJAOw5xe1XzmhnS76+uxja1Bt06s+1EymFmZV0kmP2i
         NGl75txnMxDQau4wVTrYs129uTVaBTJp4v0gapVF/+81a/gA7p7yZ632K+06EHJV9kck
         WEtg==
X-Gm-Message-State: AOJu0YyzFQ5MR9FbFD4k18aYle1njW4oKWhwWor/xyav0sU3Zeh+bOvQ
	G5UX01iug2G01kiAT7s+OAKg/8aUZYvHR6/Jat5E6Da986AtSk1gVaQ5xXzyv+YUvp94sdik+8M
	X2qcwsHt8/yTVZ0xbb7kI3tArvMtscFyeDhZZJCaj/rJtlVkdWeHFsHF/2onWddN1EU09R8Erzp
	nLdZ385XBahnvZqOWrvYLg3PVneGQaLEeGoTwb
X-Gm-Gg: AfdE7cnNvSdpymnH54K6qhJwKcU1XCCPAZhpcAsn82pATZArFhtR37LeI3tDtbmthGk
	IH2uFS1IV0pjRwNdd8aVl8w3q69BQuDBMlpEycod906+2uNF2ZErBgZNmUEF3FZpT1B1OdeeUN4
	Z4QLpW6ERhfxmLU8aP4af7d/Fo1hmztGCLEKPjRVMxj5ibuxzPh3Kylyojd7MCCpyC0P+9i1fea
	q+WWQgz1d086KbcPA41I8rO3Lw=
X-Received: by 2002:a05:6808:4495:b0:495:d6b7:6004 with SMTP id 5614622812f47-4a2045e17aemr8153642b6e.26.1783685063069;
        Fri, 10 Jul 2026 05:04:23 -0700 (PDT)
X-Received: by 2002:a05:6808:4495:b0:495:d6b7:6004 with SMTP id
 5614622812f47-4a2045e17aemr8153631b6e.26.1783685062691; Fri, 10 Jul 2026
 05:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260629144837.3244851-1-desnesn@redhat.com> <akRTVinqeeZnVARD@localhost.localdomain>
In-Reply-To: <akRTVinqeeZnVARD@localhost.localdomain>
From: Desnes Nunes <desnesn@redhat.com>
Date: Fri, 10 Jul 2026 09:04:11 -0300
X-Gm-Features: AUfX_mzVC853Yhxe5IzKb6IGxVPhPJKkZ0EBhVqEVYwZEn7zq3i4mNWDrdm-aj8
Message-ID: <CACaw+exCLSLRUNU38uorD9r+fk4AjD-Oe+RZNzFXzjwE2q9rsQ@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/vt-d: Fix UCTP context table slot when copying
 root entries
To: Tao Liu <ltao@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, stable@vger.kernel.org, baolu.lu@linux.intel.com, 
	dwmw2@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: STr9OK6RCaRe_CXxpDS9yVjou97n3tIVr7dBhxFuJ8U_1783685063
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_130434_698512_61B027F1 
X-CRM114-Status: UNSURE (   7.70  )
X-CRM114-Notice: Please train this message.
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

Greetings Tao,

On Tue, Jun 30, 2026 at 8:38=E2=80=AFPM Tao Liu <ltao@redhat.com> wrote:
> Thanks for attaching the kernel stack trace, which is similar to the one =
I have
> encountered recently. And I have applied & tested the patch, works good f=
or me.
>
> Tested-by: Tao Liu <ltao@redhat.com>

Thanks for testing it on another system and confirming the fix.

Best regards,

Desnes


