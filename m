Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2830CCAC5A5
	for <kexec@archiver.kernel.org>; Wed, 24 Sep 2025 00:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Message-ID:To:
	From:Date:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=QFR3hTFd5nnfh/UQMuNQP9+f7ETKw6hucUfVFqCdPEY=; b=h5xZgHmVM3A/2x
	3+V/Z1AI20VZSC1M6SJ+yfoFGVgyn9ihHmmP1XfELAWkGApRcWy2qFXMFGnUrIk0ZKdq++R9E1fPQ
	R7+1SfAdkm1xrUWNIQ/pKGX8e5FMwn89naDsPvh2DXr8kr4t/LWOeqdknDo3L90XdBcnJz4N1rljy
	POvxWQlwcuzpl9R3yNrl8t6132E0zXwkez/nZQamILE8wBuzhPs3G2bx4mQBhWlVts7N0R8mHj9BD
	9+u9VlUWmRIVLN8M6ldv2FEj1j3CHaE1MwEn5Bfjb2ikZwYVjhX74GnpF2iT9kjzXgtDrxxSQx4mg
	AsrK+Ui/5LNYaTIVr7Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1Dao-0000000FEM1-3Gx6;
	Wed, 24 Sep 2025 00:42:46 +0000
Received: from sender4-g3-154.zohomail360.com ([136.143.188.154])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1Daj-0000000FELR-3LbP
	for kexec@lists.infradead.org;
	Wed, 24 Sep 2025 00:42:42 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1758674559; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=RwN19LiH6xz0/bTb2hpEAnRt5sajj3s/zyKhRvB6bLyckJUKYwGF2p0Fs7WdZq8P5PQIsGCzBJahXg29tCw+JS5FI8LHsGbLyHbo0YCg2iuAME4XsAh3h9wdsGBKLQh4U6gbXdFeJLbFlda4D0XAgCc1B5XL4PVkSQwKW1LcLD4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674559; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=QFR3hTFd5nnfh/UQMuNQP9+f7ETKw6hucUfVFqCdPEY=; 
	b=Xnjs38SP6TKRERvKfAJBWGCoDJmpxNdYaMT16izmXvFFgaHBbsZEdPbH+l7cojGfMCP6Bs96iwHK4ZzVT8uvnNLS0ZE33csiboJwPv39KOTxH2AQNyzhVTPA+HEbQqS5D4yS0lA2fTdVGFX3eRX7a73wdJAY+vNpU3GbusYyrFA=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+6fdf04d0-98d8-11f0-8217-5254007ea3ec_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758671582652294.1193236639883;
	Tue, 23 Sep 2025 16:53:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=Q/3zL24CRVafqK2wCXTM2cT9zNvX/jVYb7BLn84UhnT1zvQh4B7YphlVfkRTcBfjt+z5VdrTNJDyAzMH3YavzvOs7XWMacXLxIwSbELoSRuaJKckDk1bO5KvMrcjAr60/t3TYYNKFyjsjGGNxmUNnBwKyVAFLxm/3E/Ugt2NuNs=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=QFR3hTFd5nnfh/UQMuNQP9+f7ETKw6hucUfVFqCdPEY=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:53:02 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
To: kexec@lists.infradead.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.6fdf04d0-98d8-11f0-8217-5254007ea3ec.19978fead9d@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.6fdf04d0-98d8-11f0-8217-5254007ea3ec.19978fead9d
X-JID: 2d6f.1aedd99b146bc1ac.s1.6fdf04d0-98d8-11f0-8217-5254007ea3ec.19978fead9d
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.6fdf04d0-98d8-11f0-8217-5254007ea3ec.19978fead9d
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.6fdf04d0-98d8-11f0-8217-5254007ea3ec.19978fead9d
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.6fdf04d0-98d8-11f0-8217-5254007ea3ec.19978fead9d@zeptomail.com>
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_174241_896399_CE0E87E2 
X-CRM114-Status: UNSURE (   2.08  )
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
Reply-To: investorrelations@alhaitham-investment.ae
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

To: kexec@lists.infradead.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director

