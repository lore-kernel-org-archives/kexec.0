Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C149C282D1
	for <kexec@archiver.kernel.org>; Thu,  6 Mar 2025 23:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:
	To:From:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=UOdy1uc1Ja6Ouzx9Gp3orqw2OLpxN4Hd+lHG4CKFzvE=; b=BsF+8mJae0+r+F
	B75cJqkKDCyPnKDKKR6aC+fWFqNuvpOfcMXoxtao6KQVTUUKN2V8CazWH1W87jtK/H8/vo91oVYFz
	MQXIdtYmtpdXj50PEpU61VPEYZP+tuoMyO1hzitJ4nsxTbRDsHqSFNwmDAgcELeIwzH7CoBCWSCso
	/xWZNpW7cchQJ3baV2awTODMz0+7bH5fxHcXR8tJ+/aWBSdBuWBQlrvGldPaxoFQHHR6bpUnqc+vT
	mv1RFuLahrT18s3nL2Bxoeivy/XbKaWDPTYR3PFK4DAltp0wGTiA5F7zLsRVzUOj63PgH0P/XEagm
	yscIDSyst4QZdS7V2rAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqKJ0-0000000CRok-2c3H;
	Thu, 06 Mar 2025 23:07:06 +0000
Received: from outgoing42.cpt4.host-h.net ([196.40.103.37])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqKIF-0000000CRd9-38kM
	for kexec@lists.infradead.org;
	Thu, 06 Mar 2025 23:06:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=delugo.co.za; s=xneelo; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:sender:cc:bcc:
	in-reply-to:references; bh=UOdy1uc1Ja6Ouzx9Gp3orqw2OLpxN4Hd+lHG4CKFzvE=; b=fD
	jNXpzNeice60aJxZheQbKpl6uTcwgiI5CMMtfkHKPPpcW+l29S9XPAk+Cm1I4GJGO8wYHHdIltc/B
	QrfmhZqPIxB8dmSU+PvXQhwuCwQRuaYHD+aTFP4FbLZNE07J3W5+4/+4AXmSnUSYGUajdgq+MrVAi
	N6ifuaOkoluvkx8omRQXL2QZe2yODEQVl83FLX3acjIJCrCHcxzyu67WtlSs7bDHKYTTGoj2xzKi9
	utAMkiDE9ePzxKMf15zeCoU0OOB6zUIr54vAlfsOIKAagkPWIbPa7VlSTHb+U6soop04BG1qCBRUU
	RLFgMHidDMBPZZmChqFQGkN7mlNAD/Kw==;
Received: from www46.cpt3.host-h.net ([197.221.14.46])
	by antispam7-cpt4.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <orders@delugo.co.za>)
	id 1tqKI9-003y7U-Fi
	for kexec@lists.infradead.org; Fri, 07 Mar 2025 01:06:14 +0200
Received: from [104.192.5.240] (helo=delugo.co.za)
	by www46.cpt3.host-h.net with esmtpsa (TLS1.2:ECDHE_SECP521R1__RSA_SHA512__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <orders@delugo.co.za>)
	id 1tqK54-0000000Dm3b-0afp
	for kexec@lists.infradead.org;
	Fri, 07 Mar 2025 00:52:42 +0200
From: Barry <orders@delugo.co.za>
To: kexec@lists.infradead.org
Subject: Re: The Business Loan/financing.1
Date: 06 Mar 2025 22:52:41 +0000
Message-ID: <20250306223012.937D17E19A7EBF02@delugo.co.za>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: orders@delugo.co.za
X-Virus-Scanned: Clear
X-Originating-IP: 197.221.14.46
X-SpamExperts-Domain: delugo.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@delugo.co.za
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.75)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+5DhM0jw86KsbkaGfFMuQCPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5xbZKjtsikTYl0PM6nJY/gjRyryw85/rAZb27+VZ3biGhPm
 p87GC1OZvsh7yKER8spgIIBy+ry+jilho6aMzblDeb4o0/MLsfRXq2B6Bj1eqDD4K7StLTuqEF9y
 eNim1jV+hJyAsgQN3+fJ25MXybLTUK8SYXIQrp7xzRip84U4OwRo87oeATC+hGtbNyLqD7/fFhPa
 nBWDGAqq7nfzzxHXYlwzjvDZ/FkpvR7cwSxN+RTHswbbB/ha+ZWrSAi8SkwqWAikMcSxTAWn8RCv
 ieGEzRrIdLp/AwmQcey+hPKVq9dnf3S1NcNv3U2dp/UbPvviEnzvvDcGs5qmm9XDE2pdJqvyYkhT
 hwsslykRZitI8icIFYnZsBkzvNJDT1vaZMrr4xH02iXtFm4w0sCOFbA4fwJOVDCkeSWm5+LqlnjK
 VXjpYNeJ770wY8Cv58UhX5OHiBSoGdSAwB7sMnqRmZNfcesLA3GlTLthqqp+mHWG0CxaRQsif/YU
 G8XfVQduyd16EipRzMVZ5LqwTx7Vvn9SVpfQCjlf31OWLN2NaNeFy9CCvR9s2hhUN1llvs2pDTTE
 wGdo4nrYxdgOEU3rAwu7YGkXQCJSF80dKnrUYIbK+weYUOp7A73HI6oJg7w/VodEHmuli4HWc8JZ
 AE9pngGkHAvZhEyfejztGtIuuaSVkVTlrnc3c2glXiMCoZ0pxS7/uu5T+18U++/649pip92rEfDA
 pB33nVxQCQ9hjTX5pOhjQKJ+5rOPvQnlXh9FhIFc9aUV1oY4fX3W5eOCNA39EdyDtRg/dstU4WtD
 czFKEIcZTNg+W52F57maFge3P1US3OfHM/Z7VPRBWdsQUE3h2JAk8XNcFqRuUzLEWfjSoQ97Bvm6
 U3nD3jtNJ8DXdlOuJOSn6FAlGPXmAYLEQx1jwaPVj4uCBOOSfEjCAVrAOzTmDyM+MpzGu6WUOIYv
 xxowBYbMtXBJQROtDH/rAH/E
X-Report-Abuse-To: spam@antispamquarantine.host-h.net
X-Complaints-To: abuse@antispammaster.host-h.net
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_150619_780776_34C42C02 
X-CRM114-Status: UNSURE (  -2.54  )
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
Reply-To: barry@investorstrustco.net
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hello,

My name is Barry at Investment Consult, we are a consultancy and
brokerage Firm specializing in Growth Financial Loan and joint
partnership venture. We specialize in investments in all Private
and public sectors in a broad range of areas within our Financial
Investment Services.

 We are experts in financial and operational management, due
diligence and capital planning in all markets and industries. Our
Investors wish to invest in any viable Project presented by your
Management after reviews on your Business Project Presentation
Plan.

 We look forward to your Swift response. We also offer commission
to consultants and brokers for any partnership referrals.

 Regards,
Barry
Senior Broker

