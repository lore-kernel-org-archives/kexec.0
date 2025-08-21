Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE64ACA0EEB
	for <kexec@archiver.kernel.org>; Thu, 21 Aug 2025 19:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:
	To:From:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=E2sh7PkU99v95gXhyMFBk9zs8wQA9SBmo0ZEWgF1/ao=; b=xKVWxxkGZqJe/o
	JKga05RlhkKQyly2+XS479riApb/gE8TBYOVJmlglQOPRSz2Tv7jrU7+b4kDT++qNhtaUFE9VQT9Q
	a+KElAoPv1Y5qk031ew1jaThiU6NlopI3vUFJbqS01hj4VUbWws6qFegDUWSfR3bdNuJfG6YWzMf2
	3I+G0urYAr9GJUOh/JvmiH90n++sg19FVzTfdoZcVs3ohyWnUom7O77wNS4pEkxgc3gkUVt3cTERY
	SWSMPr3fZjrbINbgy0hdNqjs0wAoQ8JLoQFKG5gXB79yx5/48RT1JwRKh58ecxQ1ExgLryCuwKJEK
	NHZpJAWSMzzOQhVQBImg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upAhj-00000000EKG-08ks;
	Thu, 21 Aug 2025 19:12:07 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up5VF-0000000H5FT-1vPs
	for kexec@bombadil.infradead.org;
	Thu, 21 Aug 2025 13:38:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=E2sh7PkU99v95gXhyMFBk9zs8wQA9SBmo0ZEWgF1/ao=; b=KJ+T9LQw2sdOXrA6FbmvURUQcs
	3Tdx5NUPieyir8+RhzEz/AePoQ97UNGjBvX0cQjyfMHv8mmTFqpAxypk4ufjR+QSehZQaRJd7Bsnn
	DdIYtwg6ZyBbutQKTwutaM/APr+FvWIDs7XvlX2qYDrkJmqlJlCHEHe2DAMEgvXw4YtnMVjiBzaDx
	uVj8lPEGUhS3OcJcxhyIt+16ZN+6j4nJp8TXaLGYPXQhkM2nqvA6oz0Mm1OX6lueSNHOmc7GCFupB
	cYCV0DWeptlbzArG0umErXuEey33pn7pBLF4xPQaKaLbCPvEn6tiYnEC332eOckQV3xggM5VEpk2P
	ti/5N1qQ==;
Received: from securitygw1.exwire.com ([216.171.192.25])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up5VC-00000000Zdv-16De
	for kexec@lists.infradead.org;
	Thu, 21 Aug 2025 13:38:52 +0000
X-exwire-MailScanner-EFA-Watermark: 1756383954.88947@7JCls6AsY+gy44nAKDu1iw
X-exwire-MailScanner-EFA-To: kexec@lists.infradead.org
X-exwire-MailScanner-EFA-From: nancymc@exwire.com
X-exwire-MailScanner-EFA-SpamScore: sssssss
X-exwire-MailScanner-EFA: Found to be clean
X-exwire-MailScanner-EFA-ID: 5F3B51CFE9D.A6B78
X-exwire-MailScanner-EFA-Information: Please contact jdeverse@exwire.com for more information
Received: from smtp01.exwire.com (smtp01.exwire.com [216.171.192.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by securitygw1.exwire.com (Postfix) with ESMTPS id 5F3B51CFE9D
	for <kexec@lists.infradead.org>; Thu, 21 Aug 2025 04:52:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 securitygw1.exwire.com 5F3B51CFE9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=exwire.com;
	s=default; t=1755777125;
	bh=HV6ngFc0kAPeZqm3RhmqrUX5EZoxx49VvdfM3cgWoeI=;
	h=Reply-To:From:To:Subject:Date:From;
	b=fBPtFzc+rWhWykQHMOvGO+6UiTvhFAMbJuK90OXHBsU67MsTgQSjXyCXNfz4yOwBl
	 UZIfY9qp7Glp1Hf8SvSmNpEOkB0OD2WsbY70Spa/FLKi7JAXgyMD/gWzx5Sm7ygTdb
	 jroJBteLJ66QLrQGyshCleD8tEE8vFANXtDep4HU=
Received: from localhost (localhost [127.0.0.1])
	by smtp01.exwire.com (Postfix) with ESMTP id 7F36858891D
	for <kexec@lists.infradead.org>; Thu, 21 Aug 2025 01:16:27 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at smtp01.exwire.com
Received: from smtp01.exwire.com ([127.0.0.1])
	by localhost (smtp01.exwire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TjR75akJrJaR for <kexec@lists.infradead.org>;
	Thu, 21 Aug 2025 01:16:27 -0700 (PDT)
Received: from [45.138.16.152] (unknown [45.138.16.152])
	by smtp01.exwire.com (Postfix) with ESMTPSA id 0F8A846C900
	for <kexec@lists.infradead.org>; Wed, 20 Aug 2025 23:09:38 -0700 (PDT)
From: nancymc@exwire.com
To: kexec@lists.infradead.org
Subject: xl
Date: 20 Aug 2025 23:09:38 -0700
Message-ID: <20250820230938.A09BEED2A66A890B@exwire.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_143850_582142_54E40965 
X-CRM114-Status: UNSURE (   2.62  )
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
Reply-To: info.superenalotto@gmail.com
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Wir freuen uns, Ihnen mitteilen zu k=C3=B6nnen, dass Sie zu den=20
Gewinnern der j=C3=BCngsten SuperEnalotto-Ziehung in Zusammenarbeit=20
mit Lotto24, EuroMillions und Powerball geh=C3=B6ren. Sie haben einen=20
einmaligen Gewinn von =E2=82=AC3.850.000  in der zweiten Gewinnklasse=20
gewonnen. Um Ihren Gewinn abzuwickeln, senden Sie uns bitte=20
folgende Informationen per E-Mail:

Vollst=C3=A4ndiger Name: Land: Wohnadresse: Alter: Geschlecht: Beruf:=20
Handynummer: WhatsApp-Nummer.

Im Namen der Online-Lotterieabteilungen SuperEnalotto,=20
EuroMillions und Powerball gratulieren wir Ihnen herzlich zu=20
Ihrem Gewinn.

Mit freundlichen Gr=C3=BC=C3=9Fen

Frau Katherine Federico
Leiterin Online-Zahlungen / Validierungsmanagerin
Code-Nachricht: 737GHS98

