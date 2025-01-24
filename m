Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B32C02182
	for <kexec@archiver.kernel.org>; Thu, 23 Jan 2025 23:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:
	To:From:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=jTXMQLYLnzzl4tMhcmVu4eyUgjcdCEZafbd/djhgyDc=; b=xZt1HUtHoZjxcK
	DHm3FFEDIbO2D1Yrnw/K9ocjECVm7VXDtdwan6A/JRzN++sttrfeAXstsXHdtqXxb2C2UGrdOzlCY
	HRj3+nEn3srPztP2uEFCqnCUJgPiQs5n3Rz9m+x4Q0k2jY7NuYyaR1FYiFF82FAReWC4MJHmF15Y+
	Rs/pEoT4hOB9yQ3bsXbRRK/O/klAD064eFPsszBS39CIRUt5OLgvUjJwjxNCdz+RhjRI32RWbeD5U
	0mDqiZ9VeaVAwx0y/g/NT82zjRPxxl8mKF/R7qbFarb1gAGq5oL68WcAPQU+C6vVr0aB2FTGuxsU1
	J0cwbcsFQg73odwVQeOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tb6mK-0000000DVAG-1Fqp;
	Thu, 23 Jan 2025 23:38:28 +0000
Received: from [38.43.111.254] (helo=mail.grupoarka.pe)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tb6mF-0000000DV9q-2P69
	for kexec@lists.infradead.org;
	Thu, 23 Jan 2025 23:38:24 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.grupoarka.pe (Postfix) with ESMTP id 1D59510A1378C
	for <kexec@lists.infradead.org>; Thu, 23 Jan 2025 18:14:10 -0500 (-05)
Received: from mail.grupoarka.pe ([127.0.0.1])
 by localhost (mail.grupoarka.pe [127.0.0.1]) (amavis, port 10032) with ESMTP
 id tahjk_tKYBwr for <kexec@lists.infradead.org>;
 Thu, 23 Jan 2025 18:14:09 -0500 (-05)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.grupoarka.pe (Postfix) with ESMTP id 5A1BD10A14D99
	for <kexec@lists.infradead.org>; Thu, 23 Jan 2025 17:58:13 -0500 (-05)
X-Virus-Scanned: amavis at grupoarka.pe
Received: from mail.grupoarka.pe ([127.0.0.1])
 by localhost (mail.grupoarka.pe [127.0.0.1]) (amavis, port 10026) with ESMTP
 id 4LrNXeCZv4gu for <kexec@lists.infradead.org>;
 Thu, 23 Jan 2025 17:58:13 -0500 (-05)
Received: from gosfordukfinanceltd.com (gateway [172.27.225.126])
	by mail.grupoarka.pe (Postfix) with ESMTP id 391A210A14D9B
	for <kexec@lists.infradead.org>; Thu, 23 Jan 2025 17:57:09 -0500 (-05)
From: Mr Simon <simon@gosfordukfinanceltd.com>
To: kexec@lists.infradead.org
Subject: RE: RE: NEW BUSINESS PLAN
Date: 23 Jan 2025 23:54:22 -0800
Message-ID: <20250123235421.C895B131F7DAFCAE@gosfordukfinanceltd.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250123_153823_738166_B00F1073 
X-CRM114-Status: UNSURE (  -0.25  )
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
Reply-To: ritchie@gosfordukfinance.com
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Greetings,

The GOSFORD FINANCE & LOANS LTD (UK) invites you to partner with=20
us and benefit from our new Loan and Project funding program. We
offer loans and funding for various good projects. This is=20
however in the form of a partnership.

Do you have projects and businesses that require funding? We are=20
ready to give out Loans (big or small), at just 2% per annum for
15 years. If you're interested in any of our proposals, then send=20
me your mobile phone number so that I can write to you or give
you a call for more details on our Loan Investment Funding Plan.

I look forward to your response

Mr Simon
GOSFORD FINANCE &
LOANS LTD

