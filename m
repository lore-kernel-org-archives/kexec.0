Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B78C02198
	for <kexec@archiver.kernel.org>; Mon, 10 Feb 2025 08:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=s9FvBgec2vOLzZMd+I0JTxSJ2jvdHkBRar46owoDscI=; b=QsdnnElMnE3auAtNP7hd5H06MC
	3ceLKgWx5bIhJq8n9doWuwgyWxyxSAGg9x1XBzTGmtGpj8ZxYHqi4u/0Mtvljh+ayt/YavTqONUOW
	O0nxlwCqLSfDCQ2BLpemsKfN2Dpj5SO7MTQmLuCcXULV5+JuPq+uRS0lz+UvhmH7wDZDg2uWT0Xji
	L0DZ1Y/XQp/AObJVR9aq+CDWeOg44wDiQIAB1HetGjpc6czCxgHBixEhW8UsjH2MyrJ6v7ySyItwv
	d3A3eWcXaBwcximiwr+nHvcr/BTaY6XajxVuGxNeVLKQF4dVA0rfwJgJ5m/jLnVAU4WlAvWqxd47z
	5cXyj6Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thPRx-0000000GhbO-49z7;
	Mon, 10 Feb 2025 08:47:29 +0000
Received: from mail.commetrax.com ([141.95.18.165])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thPRB-0000000GhTV-3WYI
	for kexec@lists.infradead.org;
	Mon, 10 Feb 2025 08:46:44 +0000
Received: by mail.commetrax.com (Postfix, from userid 1002)
	id 65F3B23A6D; Mon, 10 Feb 2025 09:46:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=commetrax.com;
	s=mail; t=1739177196;
	bh=s9FvBgec2vOLzZMd+I0JTxSJ2jvdHkBRar46owoDscI=;
	h=Date:From:To:Subject:From;
	b=ULhwLIx7e+HiojslTelhocwhvO3ruIq4Q9cFRxdOlerUzQs4vHVEAM8b8DrnUrzGb
	 4/uCq5hkQozjiVZVk/athvBH63m3SghiFG13b/K5wDCg2RAkhLqLX1gYa0ZrQ2pJ7z
	 Cv2vTxc46jO7xA7/3XO/guN7j8Ad4RKxsjzjueYkE2TeqUr5tVZa6JtN8UR2nSx6BA
	 3V4hHZfdl8S3BCHtY8PR7Ay5eGZnt8bSO9Y0jXYfdncXeFL3wDjzN93IIAQbztvOBB
	 Y/nwWgJ3nYvn6y+gztk0xFbQeK15MPbflV0jeLSV9NSqzaHKmlWZADthR0om+cs3c/
	 QLZHAkZ9hZEzg==
Received: by mail.commetrax.com for <kexec@lists.infradead.org>; Mon, 10 Feb 2025 08:45:58 GMT
Message-ID: <20250210084500-0.1.7r.inxx.0.8cz4jisbd9@commetrax.com>
Date: Mon, 10 Feb 2025 08:45:58 GMT
From: "Vincenc Turek" <vincenc.turek@commetrax.com>
To: <kexec@lists.infradead.org>
Subject: Wide range of packaging
X-Mailer: mail.commetrax.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_004642_574509_C445DCC7 
X-CRM114-Status: UNSURE (   1.16  )
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

Are you looking for packaging that not only protects your product but als=
o enhances its value in the eyes of your customers?

We manufacture a wide range of bottles, caps, and buckets made of HDPE an=
d PP, designed to meet the demands of industries such as cosmetics, chemi=
cals, and food.

Our packaging stands out for its durability, aesthetic appearance, and th=
e ability to customize colors and closures =E2=80=93 helping to build bra=
nd recognition and trust.

Are you interested in solutions that perfectly align with your company's =
needs?


Best regards
Vincenc Turek

