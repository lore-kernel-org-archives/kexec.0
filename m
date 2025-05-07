Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C82C3ABC0
	for <kexec@archiver.kernel.org>; Wed,  7 May 2025 09:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0Yjr6NsrKkaYb/LNYm1mPKHuxqkR0iWhkNkzH9QSzrg=; b=V4A67xqtDhZwHfY9KzZmkr6lIW
	F+jwTLhPJ11ov139FW4xSZuYaqMe7F93CWAt455tcYwV4udEChkc3JU+T86HiDHpNj8rzm9nTv3KU
	MYVNHrwbmjKQHuqdglekMf6RKo3XZcR4nRxgUrPG8frhWu+bhH2eLqX4adPy1yOr6dp7Uk+cBfZxE
	rwoSjPoIUlc7IWO6gW9vLGxUGDBNMvzvgDHd3VdzhQnvddS/WNQeY3/ROdNIpPhUrw1/3y+boBwEz
	gxjJP6W8JoYyrBNLPZl6XEpiAueoB9v3IHUQryPVHucbtGG3f1ugzLdfHmh2tcfLuPDPIQ2S2EtSf
	TRQAEqVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCarb-0000000EtAO-3wlG;
	Wed, 07 May 2025 09:14:51 +0000
Received: from mail.fintara.pl ([51.68.214.200])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZwv-0000000Egox-0uWW
	for kexec@lists.infradead.org;
	Wed, 07 May 2025 08:16:19 +0000
Received: by mail.fintara.pl (Postfix, from userid 1002)
	id 00E734A9F1; Wed,  7 May 2025 10:11:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fintara.pl; s=mail;
	t=1746605498; bh=0Yjr6NsrKkaYb/LNYm1mPKHuxqkR0iWhkNkzH9QSzrg=;
	h=Date:From:To:Subject:From;
	b=Ct+qHEL45S69buCetyxa+bnIK+sRYBTA8G/E7Y2/YgV49fkiP6fho65F5CB7SXHuN
	 haR578shsFX71UIOuX/Qhie3TopALAqGBBfUImXLgz868WQyx9WyU5kAUGbOhm/Fk7
	 ETA3IaNcYA3e3Z14mwgtJnobC7lJYnsKdvjSyE8IMoTk9U9eVz9ojGBVKjv93wLAc6
	 bxTSHj4AkPlX+76u3N0dp3dw8iclgoLpSRpRu37eB7tUci9JecVH0FAUgUc+8b9irG
	 cht341lz8Z/aLoTeQbBzrEXBZV+IsuGTFhCXDRzG3zcwCia1B2vvdWsCyieCO17kAI
	 0+p9wzeYWGbjw==
Received: by mail.fintara.pl for <kexec@lists.infradead.org>; Wed,  7 May 2025 08:10:41 GMT
Message-ID: <20250507084500-0.1.9c.28ajw.0.jhlna6qv4v@fintara.pl>
Date: Wed,  7 May 2025 08:10:41 GMT
From: "Dominik Lotka" <dominik.lotka@fintara.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Prosz=C4=99_o_kontakt?=
X-Mailer: mail.fintara.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_011617_942638_47A6DA88 
X-CRM114-Status: UNSURE (   0.36  )
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

Dzie=C5=84 dobry,

Czy jest mo=C5=BCliwo=C5=9B=C4=87 nawi=C4=85zania wsp=C3=B3=C5=82pracy z =
Pa=C5=84stwem?

Z ch=C4=99ci=C4=85 porozmawiam z osob=C4=85 zajmuj=C4=85c=C4=85 si=C4=99 =
dzia=C5=82aniami zwi=C4=85zanymi ze sprzeda=C5=BC=C4=85.

Pomagamy skutecznie pozyskiwa=C4=87 nowych klient=C3=B3w.

Zapraszam do kontaktu.


Pozdrawiam
Dominik Lotka

