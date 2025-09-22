Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50562CAC592
	for <kexec@archiver.kernel.org>; Mon, 22 Sep 2025 18:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7O7GfAy87POK7Hz6aRD4fbUEkR8We3HH1S9T+qLS/mQ=; b=wWhlenJs2vsoZWwK8hsCye6fgb
	xWkeG6hcN0Wv5tLlYgeNaq0r34XQJBWh0lrs4WKM4d1noRhK2Qwf8oIE1dafIuwsIHN7BYM8I0ORP
	rnz1xL9S2HSfXmTs02EI3TkW6A3DkVg2ffoTlv2dYLzw8pVzJX+LTXCo+W5JKYq48Y+95qvJrv+i2
	zILdBBQnbBt8PUlKTLlRBxtP/zXkkLTe7u25eW9x+MYSlW9W2SOtM/z3cyAAIVTWcUZpxuYGB3hbr
	GrxGLjmAKct8h/XgDU3L5dfD77sN0/ZV+ejUqQrGHNo+jzbx6n+R/juBkN7pytZx9lXA+M1+kHCj7
	Um/zOBEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0lKW-0000000BFkG-1XPe;
	Mon, 22 Sep 2025 18:32:04 +0000
Received: from sender4-pp-o94.zoho.com ([136.143.188.94])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0lKT-0000000BFjN-0Ozi
	for kexec@lists.infradead.org;
	Mon, 22 Sep 2025 18:32:02 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1758565916; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c1POMfLAQvG7sTK+/77mgPlNJafzCKuS+mvHBJyJPYWDnv1QnieSDCF6cNmS0W1mrEbFqRjUqRJ0FLp0MTXLXptGD5JbXr/lG0AaogP5zpumOdamzSXcupTxdVUjp9B2SeyeOok7H7MaDEId1+Got4F8opgTYBUr6h4Znhbihrc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758565916; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7O7GfAy87POK7Hz6aRD4fbUEkR8We3HH1S9T+qLS/mQ=; 
	b=TKfHQnaea4+MNN/gKhbdDTcYZF4+fJdTWO3xCunmozRtyCDI52QheT/m3PdVE3TXS97df0hQEuwhd+j1GXPMMvZgj+6/MA1FCzlgGSwV8MlivKDS9uGMPcVEEswKf2HuGv17dq7d7NJwB4Tt/4albMx0J/4qHa5YoXaDFa7rhBs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758565916;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=7O7GfAy87POK7Hz6aRD4fbUEkR8We3HH1S9T+qLS/mQ=;
	b=EIx8wZAagCjfj6VQYtiAxbPnuRIjG4XsZn3Bd41Up11h7i8V8N4LM5kNn8qHMoVH
	BGJuq48FNiJIld0HxIQRRoNfTLzKrwVsyfSQJXY4TnZsCxtZEwcVjqVEeDjIoZTF79T
	9xEKP1Jw0GZuM0KA8XXmDWh5G9sXViQGZqbpFgw4=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1758565914240235.37893586745065; Mon, 22 Sep 2025 11:31:54 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Mon, 22 Sep 2025 11:31:54 -0700 (PDT)
Date: Mon, 22 Sep 2025 22:31:54 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Simon Horman" <horms@kernel.org>
Cc: "Jeremy Linton" <jeremy.linton@arm.com>,
	"kexec" <kexec@lists.infradead.org>,
	"Andy Shevchenko" <andy.shevchenko@gmail.com>
Message-ID: <19972b2566e.1115458b7339833.495097856732093802@zohomail.com>
In-Reply-To: <20250819213014.908757-1-safinaskar@zohomail.com>
References: <20250819213014.908757-1-safinaskar@zohomail.com>
Subject: Re: [PATCH v4 0/6] Fix printf string specifiers, otherwise kexec
 doesn't work on my laptop
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr080112273605c4d5675c9131eb0fb8290000aaaeef7d35e5f22e784a677e968facf4cc9814b50552eb593c:zu0801122768a79b7960bb2a91d411997e0000fdd5edbc27506c4f3c1e583f7663edef8512c8cf99b68a12c7:rf0801122c655e67553bb7a5477e44258200002aac07b9267b1f8bbb77216d409220d561d258fa90c06974d773531373cc:ZohoMail
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_113201_208630_638BDDBD 
X-CRM114-Status: UNSURE (   9.78  )
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

Simon Horman, so what? This patchset is still not merged.


 ---- On Wed, 20 Aug 2025 01:30:08 +0400  Askar Safin <safinaskar@zohomail.com> wrote --- 
 > TL;DR: this patchset fixes regression, introduced in aecc554e7b.
 > This patchset should be backported to all distributions, which packaged v2.0.31, otherwise
 > kexec doesn't work at all at my laptop with pretty common setup with v2.0.31.
 > v2.0.31 is broken without this patchset.

-- 
Askar Safin
https://types.pl/@safinaskar


