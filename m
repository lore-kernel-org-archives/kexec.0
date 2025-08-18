Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4308ECA0EF2
	for <kexec@archiver.kernel.org>; Mon, 18 Aug 2025 13:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=g/ZnFTuVYued68oe7XL8RDnKQ+ZMKy0qE+LfBacqvSc=; b=gXbj4ZtvEBXATMufEG93wWqOc9
	glGBE9pOyPxI+iNgTSxonhlxzM69u5Lfk5K9LekodbJNatJG3/xV0UqDBA1ow1kd0eVGfmG50aR9S
	jbQJcdjWKtrPtGsn8hiQClVByMAMNHWuOy7iB1dWK7XNAVGn+/C99iI20xMNwqdbYmio5VOQ+nIMe
	666IYNPXoQ4REJtVMd+3gbbDi0yaoGHJcDWrchVSP2KRSouj+pYfQS7ISfKOYaPCdOfVAqExxCuAp
	+OOi3MgxZRZiAhIQfanSlGZ+eStGrLFurNeWU7gSAI6gxr93XMLUrsXWr4Yum+4DP3J01rPH4mb6l
	9LyY1jbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo03C-00000007Tqo-20ff;
	Mon, 18 Aug 2025 13:37:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unupg-00000006u3m-0Q4a
	for kexec@bombadil.infradead.org;
	Mon, 18 Aug 2025 08:03:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=g/ZnFTuVYued68oe7XL8RDnKQ+ZMKy0qE+LfBacqvSc=; b=P+m/c2HmEiZ44FfEaz4eCU6jBf
	exsxAJ5qwwsxhUv3nO1d4KMc1Vj70y6D2qsPFqBaYAF62+TYk8oycgaJnPcL/oy/tCXzNjKfHXzbH
	Rvta/eG9b5vfGj1hn+nWmkqWbJ7JPux24zY0UQSqK96AlJkULCjqQ+CEvKKrgVW3VTq+IwnjVBO5V
	jH2OD2D3nCtBW7gepQ20YAnc96fP5EmdpyuNOkvtVto7u02uWPLlkJFwDdQmlLFplQNVgk6jMRCHf
	xhUPPTmupnQtoHIFlf4nfH+m0e2DS4AulXQYxrPhF9AuMc+Ksh4CGVGFRfu/gK36TbB8Ys70UrgKr
	tU8uUPEg==;
Received: from mail.ventrixio.pl ([57.129.137.141])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unupa-0000000HJNj-1AHz
	for kexec@lists.infradead.org;
	Mon, 18 Aug 2025 08:03:05 +0000
Authentication-Results: ventrixio.pl; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; d=ventrixio.pl; s=default; a=rsa-sha256; cv=none; t=1755504178;
	b=OZWnzXslui2Gj/051vbbkbDfZKaeq1WoY7aym6XISZb4Blpfvpp70oiQmHcgckN7klUY
	 RyvgFQOLSWQUC8yMrbuxBLanaEQmywzA4LKXE0L5VIuaW4hxtC4WHaowFkd/IBZvio+gj
	 Rv+g9xeCXJx9iMgBVfpEQ26nZQr/eXIHvRtDtjWZ6OBxcZV7j0rLmXhAR8GsSUtxnBu7H
	 upmTvJGCnF1XILmD9u+SwLWsrlaJgHwdCzdV1U5rI9Sw8WmYeDfVkTEHx1rkxZUF0rNe+
	 3/edtGfK/3bIzDcvta2JeauQRfrikQU03Cd8Io/KU74UQeIYaBr85XLSOVwXc9DMC6Q==
ARC-Message-Signature: i=1; d=ventrixio.pl; s=default; a=rsa-sha256;
	c=relaxed/simple; t=1755504178;
	h=Message-ID:Date:From:Subject:From;
	bh=g/ZnFTuVYued68oe7XL8RDnKQ+ZMKy0qE+LfBacqvSc=;
	b=2cPkRk7ra/tYJ9mhMI5gokKBVNLSvVC7AlFNUPYfsKEMGamGRoARFsHTQqvtHQiePbX4
	 Y10kJrLCWNTNOdPsSYOVdCHi8Jdv4GdGmAwxhjg3JAQk4nFEbT5RH42BQZOspKesPk5XR
	 HT20AAA6TXPu35fsm18jEnGN4y8pkMLFGhSVdxbhiBwEyM2Y14UWa/hkxu6s2oM02Crk3
	 fqXFqR414eSSG/QA7OPmvcE6bG3Ht4kE5YHXmkcnj5TU/lun5OJvimAAe91rB5PGXt3F+
	 aogjYP+TH/+vrtWhDJ2X1IPzJF2TXKGXsNp2uo5xs+bQ7s0eVDdUH/XOuScw/T17urw==
ARC-Authentication-Results: i=1; ventrixio.pl; arc=none smtp.remote-ip=127.0.0.1
Received: by mail.ventrixio.pl (Postfix, from userid 1002)
	id E0FA223EBA; Mon, 18 Aug 2025 08:02:10 +0000 (UTC)
Received: by mail.ventrixio.pl for <kexec@lists.infradead.org>; Mon, 18 Aug 2025 08:01:04 GMT
Message-ID: <20250818064500-0.1.42.1n0lq.0.a6fr71mmxn@ventrixio.pl>
Date: Mon, 18 Aug 2025 08:01:04 GMT
From: "Karol Bednaszewski" <karol.bednaszewski@ventrixio.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Mniejsze_wydatki_na_samoch=C3=B3d?=
X-Mailer: mail.ventrixio.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_090302_843367_3A96C22E 
X-CRM114-Status: UNSURE (   1.12  )
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

Dzie=C5=84 dobry!

Czy m=C3=B3g=C5=82bym przedstawi=C4=87 rozwi=C4=85zanie, kt=C3=B3re umo=C5=
=BCliwia monitoring ka=C5=BCdego auta w czasie rzeczywistym w tym jego po=
zycj=C4=99, zu=C5=BCycie paliwa i przebieg?

Dodatkowo nasze narz=C4=99dzie minimalizuje koszty utrzymania samochod=C3=
=B3w, skraca czas przejazd=C3=B3w, a tak=C5=BCe umo=C5=BCliwia tworzenie =
planu tras czy dostaw.

Z naszej wiedzy i do=C5=9Bwiadczenia korzysta ju=C5=BC ponad 49 tys. Klie=
nt=C3=B3w. Monitorujemy 809 000 pojazd=C3=B3w na ca=C5=82ym =C5=9Bwiecie,=
 co jest nasz=C4=85 najlepsz=C4=85 wizyt=C3=B3wk=C4=85.

Bardzo prosz=C4=99 o e-maila zwrotnego, je=C5=9Bli mogliby=C5=9Bmy wsp=C3=
=B3lnie om=C3=B3wi=C4=87 potencja=C5=82 wykorzystania takiego rozwi=C4=85=
zania w Pa=C5=84stwa firmie.


Pozdrawiam
Karol Bednaszewski

