Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7F0CDB474
	for <kexec@archiver.kernel.org>; Mon, 23 Oct 2023 08:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZWknHUY0BCVXgp3t8siRWJzGnKBkXyS1aO2hOifJIRM=; b=PB9l14tv7TCFcv
	05WrDuInknwMibztluQ6LJ1pIfMsfX0b5dy7nyuq6SkbLvv3ScrZQ1Bz+rUbBIg7zucc2Mrh7bup7
	zIKCETw1hMTfo5JmQV+h1XD/kfI9Hu84q609Tt/QQRuDahi9l3Sa5iX3Y94g5o9c1PiYrxubghoLY
	7gEQKOVzExnTd7+ZO99JHOXhvtqHfq7Gom4vBcTdMl4UeY5fYSpi3QUTJvwqwXZvwEro/Cd7Z/zpV
	sCUi7tM4rePONPtjOt1IFTf6pVi94oHMNzvVHEAD/H6yyliBRMnV+BOZazC71K/70nyFPDzoDjYez
	y4skjOXRzmFZSuH46F3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qupwc-006iBr-1I;
	Mon, 23 Oct 2023 08:05:50 +0000
Received: from mail.projektbudowlany.biz.pl ([94.177.230.190])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qupwZ-006iBD-1R
	for kexec@lists.infradead.org;
	Mon, 23 Oct 2023 08:05:49 +0000
Received: by mail.projektbudowlany.biz.pl (Postfix, from userid 1002)
	id 6F08B829A0; Mon, 23 Oct 2023 10:05:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=projektbudowlany.biz.pl; s=mail; t=1698048342;
	bh=biyW755MzzVxeTjJpyR/fzHTo/SOjoGZzb8vJNzw6Bg=;
	h=Date:From:To:Subject:From;
	b=kX3yx4LqvJDByerh9aFCMzzrJfyNGu3DbJgq69pp9zBYPIgxNU9+Fo9tIMhDoUiJg
	 Sdl6c6S109agDLQ9+gBtRZzanD/VTNk7ZpJugYeolEtWBjPrZKegrM3S4DmYcqe0H0
	 YFWEpHmdz4eWpapW9kFzCJFSP5BHxcwG8UvW5vR1LoOA/gK60b4/9lnQMH8xXg/eIJ
	 EVZHN42y53u6vsX4cEELbiX6iGc0Mk4VGp2MlBWZOOCKljByF9+q+g9dzacUc1Y2Wr
	 4csqRnX2ziMoWB7oTgygtRtf2TPq2FOm8xr+5ocpCIA2AF/NB0DHxhYUFw5wmxKWBS
	 Rw6IvkjlxLYXA==
Received: by mail.projektbudowlany.biz.pl for <kexec@lists.infradead.org>; Mon, 23 Oct 2023 08:05:40 GMT
Message-ID: <20231023084500-0.1.32.a3x3.0.p780ladx3g@projektbudowlany.biz.pl>
Date: Mon, 23 Oct 2023 08:05:40 GMT
From: =?UTF-8?Q?"Robert_Miko=C5=82ajczyk"?= <robert.mikolajczyk@projektbudowlany.biz.pl>
To: <kexec@lists.infradead.org>
Subject: Apartament  nad morzem  - inwestycja
X-Mailer: mail.projektbudowlany.biz.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231023_010547_650604_2BB58DE0 
X-CRM114-Status: UNSURE (   0.54  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

RHppZcWEIGRvYnJ5LAoKY3p5IGJ5bGlieSBQYcWEc3R3byB6YWludGVyZXNvd2FuaSBpbndlc3R5
Y2rEhSB3IGplZG5vIHogbmFqYmFyZHppZWogZG9jaG9kb3d5Y2ggcHJ6ZWRzacSZd3ppxJnEhyBu
YSByeW5rdT8KCklud2VzdHljamEgdyBsdWtzdXNvd3kgY29uZG9ob3RlbCB3IE1pxJlkenl3b2R6
aXUgdG8gZ3dhcmFuY2phIHN0b3B5IHp3cm90dSBkbyA4JSwgY29yb2N6bmVqIHdhbG9yeXphY2pp
IGN6eW5zenUgbyB3c2thxbpuaWsgaW5mbGFjamksIHJlbnRvd25vxZtjaSwgcm9zbsSFY2VqIHdh
cnRvxZtjaSBuaWVydWNob21vxZtjaSBpIG1vxbxsaXdvxZvEhyByb3psaWN6ZW5pYSBWQVQgZG8g
MjMlLiAgIAoKSW53ZXN0b3IgbmllIG11c2kgemFqbW93YcSHIHNpxJkgb2LFgm/FvGVuaWVtLCBv
Z8WCb3N6ZW5pYW1pIGkgbmVnb2NqYWNqxIUgY2VuLCBwb25pZXdhxbwgZGJhasSFIG8gdG8gcHJv
ZmVzam9uYWxpxZtjaS4gQXBhcnRhbWVudCBwcmFjdWplIGRsYSBQYcWEc3R3YSBwcnp5IG1pbmlt
dW0gemFhbmdhxbxvd2FuaWEuCgpNb2fEmSBwcnplZHN0YXdpxIcgc3pjemVnw7PFgnkgdGVnbyBw
cm9qZWt0dT8KCgpQb3pkcmF3aWFtClJvYmVydCBNaWtvxYJhamN6eWsKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhl
Y0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8va2V4ZWMK
