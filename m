Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A461C4828D
	for <kexec@archiver.kernel.org>; Tue,  6 Feb 2024 11:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YUxGtQAshOfDIg5MBFjtSWRf5cG0Yb8DoLkwD1FnbXY=; b=oZVpizJFdky7+U
	EjV066jBbnwQoV/ZvIZTQhlTszZMBXyyWw/a7Fho9Xlol6zgA+69gcrxl9VopWdHMQjym2rO9Ei03
	a+7vnDSFtFjQdI9XbdXjodXAB6rJTy1YC5mjTUKltrLg3p7QQqjZkl1e6AgzkAx2TWDbVi87PQh3q
	fCCWGzYGeE7DIHx7AhoS9UoV+0bnCLP+Ozo7AiK91AXuyik+zpw86kcIDULmfUJF+t9VjebJ7X2Bw
	ftdX5uY1DHvmIcYkCL6izcS4CVbdwQpCl6C8LmhQnsKFtRfeOdrmPkfDCopuGiI/1QtIcr2ilyNec
	22uKn3MUSpih1KSLilnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXJEF-00000007CRf-3DyY;
	Tue, 06 Feb 2024 11:03:03 +0000
Received: from mail.thrivehub.pl ([164.132.48.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXJEB-00000007CPR-1AMw
	for kexec@lists.infradead.org;
	Tue, 06 Feb 2024 11:03:01 +0000
Received: by mail.thrivehub.pl (Postfix, from userid 1002)
	id CBEE12B738; Fri,  2 Feb 2024 08:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=thrivehub.pl; s=mail;
	t=1706862925; bh=m3ZUCTPRVLoDFM+cXi7VhHW+xNF3eUdGHrj1eDbLwQI=;
	h=Date:From:To:Subject:From;
	b=RxQQj2Af8/IhrO6Lc00BxlRyDFB38K8Vb/nWn1AcLvh7TgKwfEAyhruXuynGQsa6U
	 0HCGSooFnH+v79xEY13AjLwHQMm0fFuEW9I8D6uLLW076/nzWq1FDlaM8iKDwZNnBq
	 WgtKG195zvjZcWAQEIyuAQ/FLN3fLaypQto6gIRFUm7eT39mmIMhDcPKBTVHl46CWA
	 AdLVswvIuh85uoAV4D/hC1Z+VEu7k5UGvbxhhAwa3k1UPGiBt6AkITb1YEi4LCQKQW
	 nSqV285jRNIIkNbHplbcI69weuV0SG/NNSH6NaYaaOVDQqVAhxbrf1crmn3QbFNjpN
	 6uyXQ/xZ44gKA==
Received: by mail.thrivehub.pl for <kexec@lists.infradead.org>; Fri,  2 Feb 2024 08:31:05 GMT
Message-ID: <20240202074500-0.1.4e.1wti8.0.2f7y5gqop6@thrivehub.pl>
Date: Fri,  2 Feb 2024 08:31:05 GMT
From: "Szymon Jankowski" <szymon.jankowski@thrivehub.pl>
To: <kexec@lists.infradead.org>
Subject: Zapytanie ofertowe 
X-Mailer: mail.thrivehub.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240206_030300_064676_7BABE80E 
X-CRM114-Status: UNSURE (   1.23  )
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

RHppZcWEIGRvYnJ5LAoKUG96d29sacWCZW0gc29iaWUgbmEga29udGFrdCwgcG9uaWV3YcW8IGpl
c3RlbSB6YWludGVyZXNvd2FueSB3ZXJ5ZmlrYWNqxIUgbW/FvGxpd2/Fm2NpIG5hd2nEhXphbmlh
IHdzcMOzxYJwcmFjeS4KCldzcGllcmFteSBmaXJteSB3IHBvenlza2l3YW5pdSBub3d5Y2gga2xp
ZW50w7N3IGJpem5lc293eWNoLgoKQ3p5IG1vxbxlbXkgcG9yb3ptYXdpYcSHIHcgY2VsdSBwcnpl
ZHN0YXdpZW5pYSBzemN6ZWfDs8WCb3d5Y2ggaW5mb3JtYWNqaT8gCgoKUG96ZHJhd2lhbQpTenlt
b24gSmFua293c2tpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
