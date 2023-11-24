Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E088DC61D97
	for <kexec@archiver.kernel.org>; Fri, 24 Nov 2023 08:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YUxGtQAshOfDIg5MBFjtSWRf5cG0Yb8DoLkwD1FnbXY=; b=jYT4Oyv+DoINLO
	OXiJpm8kLddBDb7GJxTAvYb0XGGzjNLMfSrWNgAIsLSmLlAntOTNIy11z7CHdGH77D+F2BucSrfYJ
	ajlsXrGnRuSfoyeEbp1R+c95kWL+U6MkeOlI8xiR9NNOFdmUXVAEUzgfITAnPDWN8GPZj5K8zIa18
	FF4G7P+hI0Tw0VsgyhDUgqhTZJ7F57nEd0gyjNC8c+eqeRrfeQki+Ike6Nd2gNF3Yhit/cyMpkND+
	259Ptmb+XHgwvZrK5r1PkaJl3Z5RZd+sqg4IddhH8D2bu+4+JsOOciXTGPGuVKSnpnHVMDgGCiNLR
	MqVtu3g2ij2fTfLzfimw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6RoZ-006ZYl-0f;
	Fri, 24 Nov 2023 08:45:31 +0000
Received: from mail.thrivehub.pl ([164.132.48.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r6RoW-006ZXl-37
	for kexec@lists.infradead.org;
	Fri, 24 Nov 2023 08:45:30 +0000
Received: by mail.thrivehub.pl (Postfix, from userid 1002)
	id A33DA23E71; Fri, 24 Nov 2023 08:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=thrivehub.pl; s=mail;
	t=1700814996; bh=m3ZUCTPRVLoDFM+cXi7VhHW+xNF3eUdGHrj1eDbLwQI=;
	h=Date:From:To:Subject:From;
	b=MI0/lPscYyLY1EAV7ZNWxs0MsCzA4yPA0d5AAZ6Vr4C0J5xmvwGgBZZTA2YROVgD/
	 Z9cncNhM3AoN8zCE53eDJieY/3LsJ6vwoWlGH3CSAjAlmbA0nxtzRIYrKzzi3waxjC
	 RwaSPhAlnlte9MA+97+jMe6gYLcB17Hm1SZTrZpu4P+r+NCiKX8WwGdmi2mU1TJ5/F
	 mww50a29Y7TryJEpn6DiLmeMPBOWSTuKje7vVAOZVIBOBJasne75yxnlf+zdkRcKT1
	 Q4e6LpGV6UmsUerevT/1jy4CpOnf7cQzENFvMQ6b4rq+ptwCm+y2vRUt5lttoRdPVt
	 BpzvD4hkHwYKA==
Received: by mail.thrivehub.pl for <kexec@lists.infradead.org>; Fri, 24 Nov 2023 08:35:43 GMT
Message-ID: <20231124074500-0.1.34.1ayox.0.qiuhpbo3r7@thrivehub.pl>
Date: Fri, 24 Nov 2023 08:35:43 GMT
From: "Szymon Jankowski" <szymon.jankowski@thrivehub.pl>
To: <kexec@lists.infradead.org>
Subject: Zapytanie ofertowe 
X-Mailer: mail.thrivehub.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231124_004529_148711_36E4C7A0 
X-CRM114-Status: UNSURE (   1.15  )
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
