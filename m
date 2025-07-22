Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DE2C83F34
	for <kexec@archiver.kernel.org>; Tue, 22 Jul 2025 08:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KDRQi4pCoVVuRyGkn9jX/8tJgyEhGA8Bz0yDnVVeEfs=; b=RQoF94fA9yJXmVRIyC5ipC/am0
	f9mxgRYTKA9K3m/WIkMm3kIXtvj9SUw+voFEU6vwdD4YXlPXdqmNH2/8pMvQ5jNMMTlgwgoJfJ4r4
	qM8udpgmjjNFXrVebdEKfYwkd1KTYMsipwMu+gV6IWS6oHC16DHz4QWp3a75ThFy8+dxg2Q+qnT7r
	L9uIlwdoDP0xtM0qOfYJMVaeginuozxUijUdrC2IJaNSG6tSdJtKTJwolmpj9Juk6ly4Da0DsMs1Q
	r8L1kXglmJOx49vXBgc0Wu81rYlw4tQKjsoQyybFXYCw7Jrzgx85w4ARG7qWfajVwHS4uBTtmlIgX
	4MmUmAIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue8gb-00000001t0E-1See;
	Tue, 22 Jul 2025 08:49:21 +0000
Received: from mail.tasknomic.com ([141.95.16.86])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue7ZL-00000001hCq-3S5A
	for kexec@lists.infradead.org;
	Tue, 22 Jul 2025 07:37:49 +0000
Received: by mail.tasknomic.com (Postfix, from userid 1002)
	id DA6D1A4460; Tue, 22 Jul 2025 09:36:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tasknomic.com;
	s=mail; t=1753169865;
	bh=KDRQi4pCoVVuRyGkn9jX/8tJgyEhGA8Bz0yDnVVeEfs=;
	h=Date:From:To:Subject:From;
	b=nrsrMu/VFiPACAw9vLxJU53bKwCnrpAuU80qhXXUoKdCfrtsQD0EMGETPubAMTyps
	 tR4C4jS0ydpS8c7t9sSmUqMsk9ETJQWo20WP/yJ/pBkKMAxRbEXKm5okc2D6doJXnl
	 jcAfM7TvwPoUyFCccFSDQPBlZsjFVGGBxR4rkcIPvNIoezZ2jJH99WsnFyJPosnrVz
	 7ED7/QKE47jc9Wxn6n/GNBlFLSEYwvJWKtnJfynCXC6bTDIDDVp7oVk5kxVaUQvV6V
	 McG1s6SIctb/p3o9zKlYXMOCkgKH58l9sNOj3PQDmIFBd/KikYM5TGQABy0wfeQNQI
	 vLJoKeAOeBTSg==
Received: by mail.tasknomic.com for <kexec@lists.infradead.org>; Tue, 22 Jul 2025 07:35:06 GMT
Message-ID: <20250722084500-0.1.k6.18c5b.0.za6vn3bth9@tasknomic.com>
Date: Tue, 22 Jul 2025 07:35:06 GMT
From: "Jon Brennan" <jon.brennan@tasknomic.com>
To: <kexec@lists.infradead.org>
Subject: Equipment - chairs
X-Mailer: mail.tasknomic.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250722_003748_132982_EF99CA9D 
X-CRM114-Status: UNSURE (   1.53  )
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

