Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913AFC5B549
	for <kexec@archiver.kernel.org>; Mon,  2 Jun 2025 13:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wCEIkq/QBvT/I5Z/2mQqLxVzlY70J1M2F2Tly1uc08g=; b=gfphmoE+GutTWGUhSUo4nX8xVA
	zEPV1hqgD39ttrBB1qhVV0BC7ZQYXfzaAwRejXVoZunvkX1Ep1c9vgNH4yDJ1FT7TpXAfSna4Lu49
	+Z/chjBhqWhb7ck1ys6ihd7k92l7FQtrfaas9ZM+7tE8bzzQFcTNpjmED4E5oJdqoUyyOpKqD09kL
	Pur9tqTpjgPcIBNJQRNoGItCMm+9W8xTgSQrJrJCev7wz6WjSrXT1dADaJxfLSZxjra6DfjVPLf98
	jF8QTNwIpDfjseExamU8Y+3h3nImEgbzKiRhlbbciDy/BIJizhJ5JMqddn+ZZkZ1RJrf626pT1deX
	9H4WJ2ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM54m-00000007Rpu-40hw;
	Mon, 02 Jun 2025 13:19:40 +0000
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM54k-00000007RoS-2O5N
	for kexec@lists.infradead.org;
	Mon, 02 Jun 2025 13:19:40 +0000
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4a5903bceffso6118421cf.3
        for <kexec@lists.infradead.org>; Mon, 02 Jun 2025 06:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1748870376; x=1749475176; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCEIkq/QBvT/I5Z/2mQqLxVzlY70J1M2F2Tly1uc08g=;
        b=D/6/Xwk1X0xTfONW15Jt/tqUioZWqtbv8tL2JzEf00AzEE3YLXa5kIjk5+higw358V
         VrlcoJ15JtounUflpm1zA8i9E0M8NnpDAYz4roIrX4h+s02spzcchAPMEOHG9jBja5t1
         DRm3RJD9evYWoJHPCwrYgPM502AhaLrOHJKCfgibJ8PIhOn2SxATugAFI9wmOBWjp8dw
         eYKGoaQxArGESE7XFjco1RT44c2C/myum1UhvKFGC7mWOYGEcs2e7PpJZpCbGqgwd9GA
         f+EDBQMQqlB/d9OIKTYhEDP79SuxmJJD0THRezt83E1rOjBKmjjTL5D1ZF1oVbtZ3TW0
         4dyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748870376; x=1749475176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCEIkq/QBvT/I5Z/2mQqLxVzlY70J1M2F2Tly1uc08g=;
        b=PfKL9tSpT9dEWCKwl6Z9nxfu5/G1nyC2O+d4ZNRxTBVGwjEwRNaY3Qpc4SMeuCVary
         WdSPzZNlJypZ3Mud8YKGkwAw1ESU3Ky+AWeyUCeJcQ76x9Q8KpS735/0XyvSsTgpqfKL
         +Cz5jIpBqewDBo8J/RmtlmF7xHU7wOUDfbCk1DT3sFYXxip4iR4oo4KPUDx9i6WKgkCt
         J+By8J5/S0B+cqQZL1WS/Yi/rFKblIPbbU3mzGGsURNzUlEHitfdlXdC4TiAG2KkifJb
         Wf/52o3fC7X2P+sjdYfhNninkk7JQZAR6j2Gse7TUOtpHTzDE48XBXCVD08PK5dZD+6H
         gkYg==
X-Forwarded-Encrypted: i=1; AJvYcCUilZJbvbCGkyMl4KUWojwjqLis0xF7j39o9r1k0xHzP2s9lcM6MxgHE7KZeit51p159qXXIA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx5ZN0UjoT6PXP7dI40uZ1Umjn68ZM1zlO91S7qSsu0B72LS0SY
	6MrfZZCQtkR1SdTwCdTe7ly86OeygO1lZ5ejPiPJxD13R3UTWmRARD5S53B8a63y/SaV/E/Jzse
	qNR7fgXKO5/PkVx+Do0/DIXyufdpfBIv6SOJh7NJRLA==
X-Gm-Gg: ASbGncv4vAI4MKmV0UfTtKiLLWuyag4f99vv7ZPS1k/5EDAzXCMPG5CBeQw4MFNAS0z
	lOGJSSrbQ+q3A3EOl2VRtPwuMPRerv7uTOCZWOl8daMZbphwgkhi7IOGtnjCqegwSacxfc3L4Bh
	U15BGgzuVA8JlevmE5S58lrCSbWk6IRA==
X-Google-Smtp-Source: AGHT+IGFmkydXO+sczuNNRYo4Eu79m/mgDeEOnnqDm93pFwgpdtCNN9UKEfNISo1YHJ7Ssp43Ko9yBw+x5aEJ84aju8=
X-Received: by 2002:a05:622a:5814:b0:48c:5c4d:68e7 with SMTP id
 d75a77b69052e-4a4400105b9mr212977601cf.6.1748870375817; Mon, 02 Jun 2025
 06:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <958b2ec3-f5f1-b714-1256-1b06dcf7470f@google.com> <20250602131100.GA233377@nvidia.com>
In-Reply-To: <20250602131100.GA233377@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 2 Jun 2025 09:18:59 -0400
X-Gm-Features: AX0GCFsCbpQOBu0kFkSm-ry9ouMuNNwdjYa0Ym6eN1GK8q_28VYNalhAb3wBX9E
Message-ID: <CA+CK2bBff9zzJs=OQApLSP96-GCNxExM2JxRkeQzhO54VGiX0A@mail.gmail.com>
Subject: Re: [Hypervisor Live Update] Notes from May 19, 2025
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Rientjes <rientjes@google.com>, Alexander Graf <graf@amazon.com>, 
	Anthony Yznaga <anthony.yznaga@oracle.com>, Dave Hansen <dave.hansen@intel.com>, 
	David Hildenbrand <david@redhat.com>, David Matlack <dmatlack@google.com>, 
	Frank van der Linden <fvdl@google.com>, James Gowans <jgowans@amazon.com>, Junaid Shahid <junaids@google.com>, 
	Mike Rapoport <rppt@kernel.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
	Pasha Tatashin <tatashin@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Vipin Sharma <vipinsh@google.com>, Vishal Annapurve <vannapurve@google.com>, 
	"Woodhouse, David" <dwmw@amazon.co.uk>, linux-mm@kvack.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250602_061938_712754_6D2FFFF0 
X-CRM114-Status: GOOD (  12.69  )
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

On Mon, Jun 2, 2025 at 9:11=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Sat, May 31, 2025 at 08:16:14PM -0700, David Rientjes wrote:
> > Pratyush asked about the relationship between KHO and LUO.  Pasha noted
> > that KHO provides a state machine and in RFC v2 of LUO, LUO can drive K=
HO
> > which makes the KHO debugfs interface optional.  KHO activate will caus=
e
> > LUO to switch to the prepared phase, for example.  /dev/liveupdate
> > continues to be the preferred mechanism.  Think of KHO as preserving st=
ate
> > across kexec whereas LUO provides the state machine.
>
> IMHO LUO should superceed the statemachine in KHO and it's
> debugfs. Just remove all the KHO stuff here. We don't need two things..

I agree, these two patches [1] [2] make KHO debugfs optional. I think
it is reasonable to keep KHO debugfs interface optionally available
for selftests, debugging, and development purposes. I do not think it
will be needed in production.

[1] https://lore.kernel.org/all/20250515182322.117840-2-pasha.tatashin@sole=
en.com/
[2] https://lore.kernel.org/all/20250515182322.117840-3-pasha.tatashin@sole=
en.com/

Pasha

