Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABF6CA0FF0
	for <kexec@archiver.kernel.org>; Sat, 30 Aug 2025 00:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:
	To:From:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=IZxtw3z/9CaxWzHuOMx6eYG39iga0noJxPVFtMhYG7k=; b=pM8PepJnU0+8U3
	FRL0IM4BV6V+PlfqhRk2VxJlx7dnsC8ZvGtipXFYoKl/jwcYmwGUIrcdOuLdi+vb9qHL84drxvZ1i
	Wz9YFNt0qGbFeoVmmhX+DX6KzzulMDU5N7bRCBPMqoloYgZfqbRFg11dUggcCGjpZybf+UTzrtMC2
	SkVv3npSnsKoAPVsBlnGkUEYKuyh7Y7PLV3wC9bLp7i63/Apl9CWhVZh3elzjghpBs+K2YS4efHhr
	BBE9x8BH9MitQ9wHxr8F8xR0RBV2KLuN7jYTllmcGXc50gGN2GIHwMRU9naduWdIvgbz45pgUUg+D
	fNKXtqxut+z/9WF4p7VQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us9ll-00000007AhA-3oEC;
	Sat, 30 Aug 2025 00:48:37 +0000
Received: from mail.notificacionesdecoperu.com ([190.116.59.194])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us34c-00000006Yls-0rZ8
	for kexec@lists.infradead.org;
	Fri, 29 Aug 2025 17:39:39 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail.notificacionesdecoperu.com (Postfix) with ESMTP id C764E1CC5A99
	for <kexec@lists.infradead.org>; Fri, 29 Aug 2025 12:27:23 -0500 (-05)
Received: from mail.notificacionesdecoperu.com ([127.0.0.1])
 by localhost (mail.notificacionesdecoperu.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id DHPN9HZyagDG for <kexec@lists.infradead.org>;
 Fri, 29 Aug 2025 12:27:23 -0500 (-05)
Received: from localhost (localhost [127.0.0.1])
	by mail.notificacionesdecoperu.com (Postfix) with ESMTP id 9C4AF1CCEFBC
	for <kexec@lists.infradead.org>; Fri, 29 Aug 2025 12:27:23 -0500 (-05)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.notificacionesdecoperu.com 9C4AF1CCEFBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=notificacionesbys.com; s=804FB474-00E8-11EF-9D29-D8BF0EF47FA2;
	t=1756488443; bh=IZxtw3z/9CaxWzHuOMx6eYG39iga0noJxPVFtMhYG7k=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=MdYSVG0q1xSnB5Zygk29tBXswlDktr41G98azYjVqgRcT1Pf/AxEnkVGk4VIBVfkD
	 fPy9aBBeF+kBqpvM0k212kUTPBOgL1OaTF+BHPLcko0XBlbvfCgVBI+XAHsXvpm3kn
	 IkfYQpQVG0pr9A+BEN6YzpBqi1l0s1OxFcN31L8S1t65ZF8h1SPH6UIvv0E8x9SvHP
	 U+lS7FgD6zMssTw1hVUou1V7X4hAiZsJ+6y758f3OX9WC51hnjtVorY+46H+18s8bn
	 QPCjVcBHiTUUnD+LwVwxsXfvXo8jz0pdLXEbPiVor9B4AeQJZpeEdPKLsZNgmohcmM
	 mfW2vuU5jP5ZA==
X-Virus-Scanned: amavis at notificacionesdecoperu.com
Received: from mail.notificacionesdecoperu.com ([127.0.0.1])
 by localhost (mail.notificacionesdecoperu.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Hydy0cUdnfVi for <kexec@lists.infradead.org>;
 Fri, 29 Aug 2025 12:27:23 -0500 (-05)
Received: from [45.250.255.20] (unknown [45.250.255.30])
	by mail.notificacionesdecoperu.com (Postfix) with ESMTPSA id 084ED1CC5A99
	for <kexec@lists.infradead.org>; Fri, 29 Aug 2025 12:27:21 -0500 (-05)
From: Luis Fernandez Consultant <test@notificacionesbys.com>
To: kexec@lists.infradead.org
Subject: Re:Investment Invitation
Date: 29 Aug 2025 19:28:10 +0200
Message-ID: <20250829192807.EE71D34F29D103DC@notificacionesbys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250829_103938_382879_18E451D8 
X-CRM114-Status: UNSURE (  -3.47  )
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
Reply-To: luisfernandezconsultant@gmail.com
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Good Day, 


My name is Luis Fernandez, I am contacting you because we have investors th=
at have the capacity to invest in any massive project in your country or in=
vest in your existing project that requires funding. Kindly get back to me =
for more details. 


Best Regards,=20

Luis Fernandez

