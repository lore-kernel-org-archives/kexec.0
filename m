Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C34C5AE59
	for <kexec@archiver.kernel.org>; Thu,  5 Jun 2025 08:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mZMd3f26MpswmzYZZn/Tr1Z4PC0U9JwB1C0CWQHeQ5I=; b=3kN1pvOxWTETiF1+l0esHTXBeX
	kR46Rjr8nOgK5KLXG9qSEKk+2+UK+8KjddBvRR0g/9J6/ZZJBL1EIqP94hmFGDax9pFifjDtzeGot
	Ws/aQMaqiZy6hb7k3c93usfhBkztSWS/h9vkuIUak4EK9HQyHlvPE4uQ+JvIkRWzIWhh2uvfzw8S8
	doWFiR/lL5G7Nv0IKOJeAoV3ysPFYPLzaYtVuxJdsaGfGkAWdgoNI59kv/+OCO13B9WDw91KxXxY3
	xsdZPXu8vw22bGi5uTi/+82NnPhXF/G8ra+COxMAJkK9iOK6upSiE7KimTmZ+xGdJD+jZTxg5T7ME
	IW7J3QyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uN5Y2-0000000F1Nr-3K5t;
	Thu, 05 Jun 2025 08:02:02 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uN5W2-0000000F1A7-1AuP
	for kexec@bombadil.infradead.org;
	Thu, 05 Jun 2025 07:59:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=mZMd3f26MpswmzYZZn/Tr1Z4PC0U9JwB1C0CWQHeQ5I=; b=pYsG4RdW7tZ9w/GFF04AGs2OEZ
	Qcq1DfR/DxEjAeOBRGieiYMd+x0nRCf21PHzq5Q+z9oRgo0/xPDHVWse7+ryWigYury/keRk3p93n
	nHfUFY23V/FHYTjaXhZ0PxQteU+Kfdc9hliJUVt7y4SAvtbUKY2s1VjIVNl5qMf9MQJxo0njmzfOC
	kOANoN1eWywAMk4fPcdog+aAY3vN1CuiM4q4t02G3B6ssma7tnxpQXY6hdj6o4nY9LnHJNU3V0gJ8
	ERsmrkNHuoKEQ8qtLJRbQimFUJ7tiFpAjrFMG28gpfRE4gbBSF1xw7+RQRO0jWUeM15xxTG/9M0y3
	qxYcBUyQ==;
Received: from mail.primefinix.com ([141.95.160.218])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uN5Vz-000000016hp-0mtj
	for kexec@lists.infradead.org;
	Thu, 05 Jun 2025 07:59:57 +0000
Received: by mail.primefinix.com (Postfix, from userid 1002)
	id AB15EA8DAB; Thu,  5 Jun 2025 09:56:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=primefinix.com;
	s=mail; t=1749110196;
	bh=mZMd3f26MpswmzYZZn/Tr1Z4PC0U9JwB1C0CWQHeQ5I=;
	h=Date:From:To:Subject:From;
	b=J4Pm2t1nNSZBr8a+2j7dWjErW8ISOHxERYHY3J/1CZkA0OCEdxSODqDYQyKuSiwpH
	 cmF7vvS9CpCOZ48Um+w3jJU/6i5SgWV8DPEZe5LejRzwZFdFqNWgDaXyq9/gtWAPc6
	 3cK0zdSx/pm1hjbNiDKwWlIVHsiuBNBPqzkdR2dDpy44tPK4lQnAYl8gfEtX2pedkl
	 Jc7eiJk47A9AWELgER7RdnlsRmjLAWzOPD41qKqitcthZs786sIiNbgzPDWme0l93A
	 gBcq5XOQWDAHb0z+nClf56oRMx7b68kPl8JVGxf8BQY1WcjxubmBKAO0BIi2xGC95f
	 OvvmapYcvgyIQ==
Received: by mail.primefinix.com for <kexec@lists.infradead.org>; Thu,  5 Jun 2025 07:55:15 GMT
Message-ID: <20250605084500-0.1.l0.2iwjw.0.rdoihqwrj7@primefinix.com>
Date: Thu,  5 Jun 2025 07:55:15 GMT
From: "Brendon Roy" <brendon.roy@primefinix.com>
To: <kexec@lists.infradead.org>
Subject: New mattresses
X-Mailer: mail.primefinix.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250605_085955_724693_21DA1C9A 
X-CRM114-Status: UNSURE (  -0.04  )
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

Hello,

Our dropshipping model for mattresses is gaining increasing interest in t=
he market.

It=E2=80=99s an efficient way to run a business without having to invest =
capital in warehouse space, logistics systems, or shipping operations.

Your role is limited to acquiring customers, while we take care of all ot=
her operational responsibilities. We offer marketing and sales support, h=
elping you achieve satisfying financial results more quickly.

Would you be interested in learning more about our partnership program?


Best regards
Brendon Roy

