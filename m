Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C859CCA470
	for <kexec@archiver.kernel.org>; Wed,  8 Oct 2025 08:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qsFkU/uX4KHJ4f1uzm2iz39kAHCe9u2uFgt0PtntkBE=; b=sAuGFE4iDJ0migg5SrAtFErKGv
	RtDm2Z0wLAhcB1gwGNALyE87dBxfcuKJpdpPS7868zrmfyVrhpGLABdZLJmEveyqHS6/H8UBaNx7C
	7yVu8TgbWMKSHbCs6T66OwXa2g8yY1BBPICICeU0ZZKbndzvOw6cpW0aYLnXLfaG7uBb4HpfYtUZX
	c+oXObghzN73ZjURlYjG2Pr9wb5qzDR3zY/gSV10C6fKXBsZPLEfgX0GQRKCk6QlVmuvmZHBArasz
	Q8XyqBCYWaWf923OovHYs5mqtRmwlo8A6hp73XFDnyv1pApTxrKV1a4j8L8zWGQDgwJn0cwc55QEx
	APtoxuDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6P6r-00000003PCH-36sy;
	Wed, 08 Oct 2025 08:01:17 +0000
Received: from mail.scalenook.pl ([51.91.253.187])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6P6p-00000003PBy-0nu3
	for kexec@lists.infradead.org;
	Wed, 08 Oct 2025 08:01:16 +0000
Received: by mail.scalenook.pl (Postfix, from userid 1002)
	id D41C625D2F; Wed,  8 Oct 2025 07:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=scalenook.pl; s=mail;
	t=1759910282; bh=qsFkU/uX4KHJ4f1uzm2iz39kAHCe9u2uFgt0PtntkBE=;
	h=Date:From:To:Subject:From;
	b=LLZ6GZhF31G7/zNqw8Z3OWb0tukukpWRfon8DZieSp/+sX6zePfg4k0JiLjAqvoTZ
	 qbktR0qEvr4pEL8WnxGBRHWlr+s6phsWKU4HMmPs7ZuhGpbwea8rA1c0OOZOhDhM7f
	 pjNAginkzO+VEUlvYVUeUcTUtUepaRfXrut0HcNRF2rPSwg4+8iRInr7CNEzb/mB4R
	 qVj3pLWBJrwdZrDfTcZRMruiodRkAkxztLvK/oMFDFz2E/FuhL4/Rb5bjtlIgfaEZE
	 exm7PYZcDcwCrr07iHDd3b8vwSPRHS6f99MAV3KXPDeZaKz5X9VesJ0oCw6dQMzpoQ
	 XuCvq73BVkZkw==
Received: by mail.scalenook.pl for <kexec@lists.infradead.org>; Wed,  8 Oct 2025 07:55:45 GMT
Message-ID: <20251008064500-0.1.k.8q2a.0.bq9hqsh01r@scalenook.pl>
Date: Wed,  8 Oct 2025 07:55:45 GMT
From: "Ewelina Koprowska" <ewelina.koprowska@scalenook.pl>
To: <kexec@lists.infradead.org>
Subject: Karta lunchowa
X-Mailer: mail.scalenook.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251008_010115_506491_3AD969FB 
X-CRM114-Status: UNSURE (   1.01  )
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

Szanowni Pa=C5=84stwo,

czy zastanawiali si=C4=99 Pa=C5=84stwo, jak zwi=C4=99kszy=C4=87 zadowolen=
ie pracownik=C3=B3w i jednocze=C5=9Bnie zaoszcz=C4=99dzi=C4=87 na kosztac=
h zatrudnienia?=20

Obecnie jest mo=C5=BCliwo=C5=9B=C4=87 zwolnienia z op=C5=82at ZUS a=C5=BC=
 do 450 z=C5=82 miesi=C4=99cznie na ka=C5=BCdego pracownika poprzez dofin=
ansowanie posi=C5=82k=C3=B3w.=20

Za pomoc=C4=85 karty lunch pracownicy mog=C4=85 p=C5=82aci=C4=87 w restau=
racjach, zamawia=C4=87 jedzenie online, korzysta=C4=87 z cateringu czy ro=
bi=C4=87 zakupy spo=C5=BCywcze. To doskona=C5=82e narz=C4=99dzie motywacy=
jne, kt=C3=B3re tak=C5=BCe wyr=C3=B3=C5=BCnia firm=C4=99 na rynku pracy.

Ch=C4=99tnie opowiem wi=C4=99cej na ten temat, czy mogliby=C5=9Bmy porozm=
awia=C4=87 w najbli=C5=BCszym czasie?


Pozdrawiam
Ewelina Koprowska

