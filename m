Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDC1C83F1A
	for <kexec@archiver.kernel.org>; Thu, 10 Jul 2025 08:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KDRQi4pCoVVuRyGkn9jX/8tJgyEhGA8Bz0yDnVVeEfs=; b=u3GYM3qZXJ4Si7flIQYq7l+uh1
	S3Ou1gX2GfGgZiepBreEUug0nnMBjjCmHTEiUy13HpP5b4zeP0oWB9mK+rb5quKxwhSD2sFEFYCRh
	V8etmehTQlwOhwG6/J4OH7GW7p4Nl7Q1hY0xfEjUXzDLRhyRfe/dfQeNlVTjmIjGZolbGMIhweWOq
	QmPVrXcYmNebp6tihBIC0BJtxPGyt/zUBSL/qnHu6pH40GUbkcO4qBPFxArtzC7zTaywTFTI2E27s
	0ARE1YDLe3WDYXI1GJOgU6JFWm580qt5H3rnlAfZ+INc1OeazsVOALOg+wdUvT0Yx0Goi/FUm0XsZ
	IhlO2XZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZn1N-0000000BEla-2NHq;
	Thu, 10 Jul 2025 08:52:49 +0000
Received: from mail.tasknomic.com ([141.95.16.86])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZlrd-0000000B2Rt-1MQ6
	for kexec@lists.infradead.org;
	Thu, 10 Jul 2025 07:38:43 +0000
Received: by mail.tasknomic.com (Postfix, from userid 1002)
	id 82732A4ED9; Thu, 10 Jul 2025 09:37:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tasknomic.com;
	s=mail; t=1752133117;
	bh=KDRQi4pCoVVuRyGkn9jX/8tJgyEhGA8Bz0yDnVVeEfs=;
	h=Date:From:To:Subject:From;
	b=fA0H5JWoLIcUZz77oWdPwZ1gXol+rqTIaQKyckE/VmjjrtFOHrzc9xWGwEj9uqCrF
	 AOHgL5FEITPVZj/rY5Y8yzvrNsOc3dK9yxIY1vjsmn5yOI9h1d6I1Jb4B3Ay56QCEb
	 ZYpg1HjxUoPKA7oe5DOfFdzei2Aio7wHcS7O1XVaHI03huE3gLra94P13SljvnIBi2
	 OM3KKT66wAXDgGnoqdjmTRuup9Bc85ABijpve1QcI4WJ0Rlc62U1M/X4aP1yod8937
	 ESQ/X6iNjpnMA8cBGAH7DPJEPMjFN5XQ/UpUmDN45iaz6L14zjwaVHjr4Sg3Z+Ofr4
	 r9I5rfmCVlD4Q==
Received: by mail.tasknomic.com for <kexec@lists.infradead.org>; Thu, 10 Jul 2025 07:36:14 GMT
Message-ID: <20250710084500-0.1.jy.13c1b.0.4gk1n4u28f@tasknomic.com>
Date: Thu, 10 Jul 2025 07:36:14 GMT
From: "Jon Brennan" <jon.brennan@tasknomic.com>
To: <kexec@lists.infradead.org>
Subject: Equipment - chairs
X-Mailer: mail.tasknomic.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250710_003842_044433_42948955 
X-CRM114-Status: UNSURE (   1.48  )
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

Hi,

Do you offer a seat for corridors or waiting rooms?

The shortest possible length is about 12 cm, with a wide range of practic=
al dimensions, with a little over a centimeter of space - with a small, l=
arge, large roof.

This is a solid and convenient solution that can be selected by furniture=
 distributors, for use in public matters throughout Europe.

I will send you the specification or photos - can our product be used?


Sincerely,
Jon Brennan

