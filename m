Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B1EE77188
	for <kexec@archiver.kernel.org>; Fri, 10 Jan 2025 21:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Subject:To:From:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uelumPW6y4IBgwZvCWG1L7ZVSOgXlVtIrmVJXy2FhwY=; b=EXMsqHZgD9kCMiPUX46OmfvpYh
	13zOimOmg15m170WE9eRgLS7ecpfv+KwJUwzMzVc1fIG4bG2GI8psUwyB9wB2ETno+Qjkg1ykC7nA
	87iVGjzqtINxMqN7VaeCQM1k2TLJPvjQcaPXaPH3U4RpsAR52zsG9yA90VORvTVuhuMk/xpXUmKW8
	kFMzPcN0d+I3xNygtyNsKtGZENh+x/ko+TVtT0TNkoyPNJoIaRehbDIEXVVZWUGfMDUo+Q+nhNljA
	hgmijc7Omm8k2lRcxKghBIV3w5knT4CVOgYXadmBibw25trINjCGtwE1aoLKCAeyO1rvoloNQGdo2
	D6HzI8qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWMAq-0000000Gy6T-2niQ;
	Fri, 10 Jan 2025 21:04:08 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWMAo-0000000Gy66-0pov
	for kexec@lists.infradead.org;
	Fri, 10 Jan 2025 21:04:07 +0000
Received: by mail-oi1-x242.google.com with SMTP id 5614622812f47-3ebb4aae80dso893888b6e.2
        for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 13:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bizdrive.in.net; s=google; t=1736543044; x=1737147844; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:subject:to:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uelumPW6y4IBgwZvCWG1L7ZVSOgXlVtIrmVJXy2FhwY=;
        b=exjwL4fWecPN7e8xd/3Pohzx4dWaJcKHhGhkKWgsqFw0LVxmdwoyOXYewrcvYl6FiQ
         TbZSNPmtgFf0HMVnfav8aXXpfKI3M2aWLtAaWC9xtOeC8sZ+IBFSZcVr38j9EJq883kx
         1rukbQDkTFCw9zr3mNeMG/uzgqsKgBN2DCtjYeUUFK3etyVKbqPnHch7Pw6KV9s0Z8Bd
         xwxePp61NdEcZCjGA6aVSfgC6pItnYFM66r8PSPtESRXppsyIAElJ+8VNjIqIG2OoPzI
         TTUzLQshabpJQznZYNKZPKXT0aIV4yrrI7Mh+JhrLRFW8Zfhnul8dBrQwuIyJAMeMqkb
         1T2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736543044; x=1737147844;
        h=content-transfer-encoding:mime-version:date:subject:to:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uelumPW6y4IBgwZvCWG1L7ZVSOgXlVtIrmVJXy2FhwY=;
        b=DivJox1AFoOP3a+XEHiBG8Qn6c8olBOf7Of0poiVTww5hudX4GeXBXcd0hC87QbKPD
         epwkdAuOOtncHyPFvxGkVx6y0mZUhVaQOrYScA5078zlAxCX1CT0Z0z1QD0cALYa/6fF
         LQVzcym6vZk1gnNt7XTgY96kH0Lptl2zjAI4bWZQ8yzbrXx1uaJBUvrZMXq6tXeuQr5D
         jNm/GEIv4VHxw+/prc4/cKCWvoqwaW2SWoBfipTDXCvcdDCgXk9soK4ck03Y6w2uPu3S
         l8t3MlqrrkTVYQsVYWaF225YDrw56n/OAwg4JFF1Kl4NesbiywS/sm5r2GjJlgsp+l1X
         q9XQ==
X-Gm-Message-State: AOJu0YzIcY9nYJoUd+t77tYdz8MOjbMRm60IXzKhtTOQVX3QEz7mC1/H
	CP5IpCJ1ETJ1aUz9WI1OAvv78mwVHfoC2Rvwp0b4ABi6TEkPPMgERrJLtifZxLhsIIGMzEAik+K
	LjiQ=
X-Gm-Gg: ASbGncvT9V5R5fJkIaEqiaVzYxrSMzQkEbqbnYU9lJTF91pQlAZmbEWgKC7ImN/0iNX
	E4uR8G+Ik54cswTwk+32fyYaEsla6wNQD2Q2CzzJl+IuUTCKUo8AEJr0MkvgZ+fo1bYYreE5530
	rBpw3HbjzwOm8zxEgdj27gIpvRXQRtG5yxYLAVYy6IOxK1n1N3d/eofFRarU6/B2NGXYASvvWmd
	aG8q18fwgY3LJL02ZTr8PAknXKcZoOikwHDVAkjgm13OL2Q+QFysc6P7wy5jXVwxMMP7z5uAHJu
	7JMqOtibQKJE4GRqU0sDb51F/5dMPP8mNuIX
X-Google-Smtp-Source: AGHT+IFnwcOQ/2Pq7i9AYzu4vdalVTDjFhQ7k7yCs9NkccCOgd55u/m2H++yh4brbjOZSJq+/DDxZA==
X-Received: by 2002:a05:6808:2f05:b0:3eb:63c9:fe87 with SMTP id 5614622812f47-3ef2ec267ecmr7581137b6e.16.1736543044596;
        Fri, 10 Jan 2025 13:04:04 -0800 (PST)
Received: from sxwps.de (69-209-96-243.lightspeed.sntcca.sbcglobal.net. [69.209.96.243])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f88266e273sm1096693eaf.26.2025.01.10.13.04.03
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jan 2025 13:04:04 -0800 (PST)
Message-ID: <6ccb48591a7e5bb1e4c637ce008888f5@bizdrive.in.net>
From: =?utf-8?Q?=EF=BC=AA=EF=BC=A1=E3=83=8D=E3=83=83=E3=83=88=E3=83=90=E3=83=B3=E3=82=AF?= <sendonly313@bizdrive.in.net>
To: "=?utf-8?Q?kexec@lists.infradead.org?=" <kexec@lists.infradead.org>
Subject: =?utf-8?Q?=E3=80=90=E7=B7=8A=E6=80=A5=E6=83=85=E5=A0=B1?=
	=?utf-8?Q?=E3=80=91=E7=99=BB=E9=8C=B2=E5=80=8B=E4=BA=BA=E6=83=85?=
	=?utf-8?Q?=E5=A0=B1=E5=86=8D=E7=A2=BA=E8=AA=8D=E3=81=AE=E3=81=8A?=
	=?utf-8?Q?=E9=A1=98=E3=81=84?=
Date: Fri, 10 Jan 2025 21:04:02 +0000
X-Priority: 3
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_130406_242372_B979F56F 
X-CRM114-Status: UNSURE (   2.02  )
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

=E3=81=84=E3=81=A4=E3=82=82=EF=BC=AA=EF=BC=A1=E3=83=8D=E3=83=83=E3=83=88=E3=
=83=90=E3=83=B3=E3=82=AF=E3=82=92=E3=81=94=E5=88=A9=E7=94=A8=E3=81=84=E3=81=
=9F=E3=81=A0=E3=81=8D=E3=81=82=E3=82=8A=E3=81=8C=E3=81=A8=E3=81=86=E3=81=94=
=E3=81=96=E3=81=84=E3=81=BE=E3=81=99=E3=80=82=0D=0A=0D=0A=E7=8F=BE=E5=9C=A8=
=E3=80=81=E5=BD=93=E8=A1=8C=E3=81=AB=E3=81=A7=E3=81=AF=E9=87=91=E8=9E=8D=E5=
=BA=81=E6=8C=87=E5=B0=8E=E3=81=AE=E3=82=82=E3=81=A8=E3=80=81=E3=83=9E=E3=83=
=8D=E3=83=AD=E3=83=B3=E7=AD=89=E5=AF=BE=E7=AD=96=E3=81=AE=E4=B8=80=E7=92=B0=
=E3=81=A8=E3=81=97=E3=81=A6=E3=80=81=E3=81=8A=E5=8F=96=E5=BC=95=E3=81=AE=E5=
=86=85=E5=AE=B9=E3=80=81=E7=8A=B6=E6=B3=81=E7=AD=89=E3=81=AB=E5=BF=9C=E3=81=
=98=E3=81=A6=E3=80=81=E9=81=8E=E5=8E=BB=E3=81=AB=E7=A2=BA=E8=AA=8D=E3=81=97=
=E3=81=9F=E6=B0=8F=E5=90=8D=E3=83=BB=E4=BD=8F=E6=89=80=E3=83=BB=E7=94=9F=E5=
=B9=B4=E6=9C=88=E6=97=A5=E3=83=BB=E3=81=94=E8=81=B7=E6=A5=AD=E3=82=84=E3=80=
=81=E5=8F=96=E5=BC=95=E3=81=AE=E7=9B=AE=E7=9A=84=E7=AD=89=E3=81=AB=E3=81=A4=
=E3=81=84=E3=81=A6=E3=80=81=E5=86=8D=E5=BA=A6=E7=A2=BA=E8=AA=8D=E3=82=92=E3=
=81=95=E3=81=9B=E3=81=A6=E3=81=84=E3=81=9F=E3=81=A0=E3=81=84=E3=81=A6=E3=81=
=8A=E3=82=8A=E3=81=BE=E3=81=99=E3=80=82=0D=0A=0D=0A=E3=81=8A=E6=89=8B=E6=95=
=B0=E3=81=8A=E3=81=8B=E3=81=91=E3=81=97=E3=81=BE=E3=81=99=E3=81=8C=E3=80=81=
=E4=B8=8B=E8=A8=98=E3=81=AE=E3=83=AA=E3=83=B3=E3=82=AF=E3=82=92=E3=82=A2=E3=
=82=AF=E3=82=BB=E3=82=B9=E3=81=97=E3=80=81=E6=8F=90=E5=87=BA=E3=81=AB=E3=81=
=94=E5=8D=94=E5=8A=9B=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84=E3=80=82=0D=0A=0D=
=0Ahttps://genrepllc.com/yabitha.html=0D=0A=0D=0A=0D=0A=E3=81=94=E7=A2=BA=
=E8=AA=8D=E3=82=92=E3=81=84=E3=81=9F=E3=81=A0=E3=81=91=E3=81=AA=E3=81=84=E5=
=A0=B4=E5=90=88=E3=80=81=E3=82=BB=E3=82=AD=E3=83=A5=E3=83=AA=E3=83=86=E3=82=
=A3=E4=B8=8A=E3=81=AE=E8=A6=B3=E7=82=B9=E3=81=8B=E3=82=89=E3=81=94=E5=88=A9=
=E7=94=A8=E5=88=B6=E9=99=90=E3=82=92=E3=81=8B=E3=81=91=E3=81=95=E3=81=9B=E3=
=81=A6=E3=81=84=E3=81=9F=E3=81=A0=E3=81=8F=E3=81=93=E3=81=A8=E3=82=92=E4=BA=
=88=E3=82=81=E3=81=94=E4=BA=86=E6=89=BF=E4=B8=8B=E3=81=95=E3=81=84=E3=80=82=
=0D=0A=0D=0A=E3=81=8A=E5=AE=A2=E6=A7=98=E3=81=AB=E3=81=AF=E3=81=94=E8=BF=B7=
=E6=83=91=E3=80=81=E3=81=94=E5=BF=83=E9=85=8D=E3=82=92=E3=81=8A=E6=8E=9B=E3=
=81=91=E3=81=97=E3=80=81=E8=AA=A0=E3=81=AB=E7=94=B3=E3=81=97=E8=A8=B3=E3=81=
=94=E3=81=96=E3=81=84=E3=81=BE=E3=81=9B=E3=82=93=0D=0A=EF=BC=8D=EF=BC=8D=EF=
=BC=8D=EF=BC=8D=EF=BC=8D=EF=BC=8D=EF=BC=8D=EF=BC=8D=EF=BC=8D=EF=BC=8D=EF=BC=
=8D=EF=BC=8D=EF=BC=8D=EF=BC=8D=EF=BC=8D=EF=BC=8D=EF=BC=8D=EF=BC=8D=EF=BC=8D=
=EF=BC=8D=EF=BC=8D=EF=BC=8D=EF=BC=8D=EF=BC=8D=EF=BC=8D=EF=BC=8D=EF=BC=8D=EF=
=BC=8D=0D=0A=0D=0A=E3=81=94=E4=B8=8D=E6=98=8E=E3=81=AA=E7=82=B9=E3=81=8C=E3=
=81=94=E3=81=96=E3=81=84=E3=81=BE=E3=81=97=E3=81=9F=E3=82=89=E3=80=81=E4=B8=
=8B=E8=A8=98=E3=81=BE=E3=81=A7=E3=81=94=E9=80=A3=E7=B5=A1=E3=81=8F=E3=81=A0=
=E3=81=95=E3=81=84=E3=80=82=0D=0A=E9=80=A3=E7=B5=A1=E5=85=88 =EF=BC=90=EF=
=BC=91=EF=BC=92=EF=BC=90=EF=BC=8D=EF=BC=90=EF=BC=95=EF=BC=98=EF=BC=8D=EF=BC=
=90=EF=BC=99=EF=BC=98=0D=0A=E3=81=93=E3=82=8C=E3=81=8B=E3=82=89=E3=82=82=EF=
=BC=AA=EF=BC=A1=E3=83=8D=E3=83=83=E3=83=88=E3=83=90=E3=83=B3=E3=82=AF=E3=82=
=92=E3=82=88=E3=82=8D=E3=81=97=E3=81=8F=E3=81=8A=E9=A1=98=E3=81=84=E3=81=97=
=E3=81=BE=E3=81=99=E3=80=82


