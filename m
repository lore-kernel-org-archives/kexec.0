Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A564D2F7C2
	for <kexec@archiver.kernel.org>; Fri,  5 Dec 2025 08:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LHmroAf0IX0JOjVUiIwqM4s8ghVxxktECxT6AQD+q2c=; b=s2A60HYnZ5AVEiGFO/unYPUWf+
	7Cph8G5IhrctS/SJ855MD7SIxBAfxOn+S264rVtiQJdCJsz0rlPDt7A8pTd0ru+Bt92XWHtpBE/BW
	jJ9MCkKFB2ez8bboZkTK1xjOnAvzuHuz8PJsCbyt+crLvEB0X9gZyqlIgCQC+ZeMbIL3bO0ZvAGfY
	KwMNT1+VmPVmibSu4EtoTP05+UDhWvdgGzk0glL8hcA61xS/gvnTs9kiBEPmE6hMOjtS8IuX3mKtv
	FUG+6rT1zuw6hKmJUDEKg1WbIjFk6ULTr+pISSb/adiDKhPfLUtjPvmc443UhbNGje9SRxSkNtUbm
	EEk7xH0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRRZY-00000009FG4-1wZL;
	Fri, 05 Dec 2025 08:53:52 +0000
Received: from mail.growzi.pl ([51.75.73.133])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRRZU-00000009FFY-3oul
	for kexec@lists.infradead.org;
	Fri, 05 Dec 2025 08:53:50 +0000
Received: by mail.growzi.pl (Postfix, from userid 1002)
	id 95210276BF; Fri,  5 Dec 2025 09:50:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=growzi.pl; s=mail;
	t=1764924649; bh=LHmroAf0IX0JOjVUiIwqM4s8ghVxxktECxT6AQD+q2c=;
	h=Date:From:To:Subject:From;
	b=Oz0uMKkrqu8dKmtGBP2l6XzIaKLyXrcMuDcJm55ojDKbe20rEbiyf5BLOaM5j8Ivb
	 jOzh/n1XLckzxqR3Gkabcw/3i7LS6BM9AXSoN7qzQK3y8y/fCNO1GDHggKo8y/1hDZ
	 IAacEhrKyOGz6Mb6llYeSuTqAFbbTc5rYuShI6yA4mExj2Ir0pkw8J99EJcqJwX5yP
	 QKYK9vXnexFuw7jQMONgBbGOcIrvJo1zH4d4Qpq5zl8HDl26egM8dM/4A5b9aXFMWF
	 RLd3PovY5rV8KzKYUHAOJZUjEneDIVHtUVy+H0ZfdsLAvTVmpFZHclD2SyXRJTMeFs
	 w9MjrSpAdHiQg==
Received: by mail.growzi.pl for <kexec@lists.infradead.org>; Fri,  5 Dec 2025 08:50:35 GMT
Message-ID: <20251205084501-0.1.eu.16jam.0.60ldaq6b8q@growzi.pl>
Date: Fri,  5 Dec 2025 08:50:35 GMT
From: "Eryk Wawrzyn" <eryk.wawrzyn@growzi.pl>
To: <kexec@lists.infradead.org>
Subject: Zwrot
X-Mailer: mail.growzi.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251205_005349_332380_B2A681C6 
X-CRM114-Status: UNSURE (   0.77  )
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

kontaktuj=C4=99 si=C4=99 w imieniu kancelarii specjalizuj=C4=85cej si=C4=99=
 w zarz=C4=85dzaniu wierzytelno=C5=9Bciami.

Od lat wspieramy firmy w odzyskiwaniu nale=C5=BCno=C5=9Bci. Prowadzimy ko=
mpleksow=C4=85 obs=C5=82ug=C4=99 na etapach: przeds=C4=85dowym, s=C4=85do=
wym i egzekucyjnym, dostosowuj=C4=85c dzia=C5=82ania do bran=C5=BCy Klien=
ta.

Kiedy mo=C5=BCemy porozmawia=C4=87?


Pozdrawiam
Eryk Wawrzyn

