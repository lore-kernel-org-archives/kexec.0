Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2238CD5BA2
	for <kexec@archiver.kernel.org>; Thu, 13 Nov 2025 09:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Kb7u+lszG/nXqIAGpk/hByhDC/8HGhmWaIRwB9KIYkQ=; b=l0Gu6W3pP7H+KaBZ/bZaJG1lZt
	szBOlmfJSE1qzPF17V3smVKJI99Pp8WTavJjk7/8BLFZfiB3p6cAVKUC2EDOnoojO0dr8G8m3iw+k
	rmhK4IHr67Nel3+hXvh+FQL4aDl4naD2gGuYSihbFoLt8uwGaIWcuPRXvIZqunvDQHcLXFBn+GfmK
	wuVXEvdWzZHmaXdCeWCS/IjYIyd7CKv6KVQIVLs8NoXHXWrWLe4UnD+ZzvbDSbREbOKG8+inR2Iqk
	NuQT1Y8Q5g/B7+Ax4R76+26R1E/7nHztM5d9rxzchj73CG1LbFFXvcIuGpe8yWkG+SGLXGVCSCdBD
	dwrHIjtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJTD2-0000000A9Yq-2hwS;
	Thu, 13 Nov 2025 09:01:40 +0000
Received: from mail.fontri.pl ([51.195.90.156])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJTCx-0000000A9YC-04cl
	for kexec@lists.infradead.org;
	Thu, 13 Nov 2025 09:01:39 +0000
Received: by mail.fontri.pl (Postfix, from userid 1002)
	id 4ACB3A87A2; Thu, 13 Nov 2025 10:01:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fontri.pl; s=mail;
	t=1763024489; bh=Kb7u+lszG/nXqIAGpk/hByhDC/8HGhmWaIRwB9KIYkQ=;
	h=Date:From:To:Subject:From;
	b=CiVnbq+NtbQAnYiMyPu1lJRvRixkfv+TszdRh5jAiYtIjYX9bikhhjkggYGzMLdC2
	 jELr/+yjSWVIaOkFNA2I+YtEVN61C0mcVkvvUIVpHuDJ+rEgn60OSbqJtoNLNs8Fy4
	 mvztE/22l2ly1TC2p55Ea0IGEZBJdUiuaYEkrMhNF1RDPGlv3yB9PQU9yZ4E67ogF4
	 jTbukwRmNP3lVKSv1YOP8eC1QgKEwuRbjeLygQYAKqx/cGam81qpmtseeOxGptYl1F
	 qsiUNyDS32B/e2mpgC2AeezprTdWRoJztCNYz6T0BVkenz//E3hZxOWxsWX77tVhvu
	 75lVYIF2CUBDw==
Received: by mail.fontri.pl for <kexec@lists.infradead.org>; Thu, 13 Nov 2025 09:01:21 GMT
Message-ID: <20251113084500-0.1.sc.5zo8i.0.pqjh2cikjm@fontri.pl>
Date: Thu, 13 Nov 2025 09:01:21 GMT
From: =?UTF-8?Q?"=C5=BBaneta_K=C4=99dzierska"?= <zaneta.kedzierska@fontri.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Odbi=C3=B3r_w_paczkomacie_?=
X-Mailer: mail.fontri.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_010135_333869_114B4F50 
X-CRM114-Status: UNSURE (   1.37  )
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

jako lider w us=C5=82ugach kurierskich w Polsce przygotowali=C5=9Bmy elas=
tyczne rozwi=C4=85zanie dla przedsi=C4=99biorc=C3=B3w.

Stworzyli=C5=9Bmy abonament =C5=82=C4=85cz=C4=85cy dostawy do Paczkomat 2=
4/7 oraz obs=C5=82ug=C4=99 kuriersk=C4=85 - jeden dostawca, jedna faktura=
 i przewidywalne, sta=C5=82e koszty.=20

Czy mog=C4=99 przedstawi=C4=87, co mo=C5=BCemy zaproponowa=C4=87 wzgl=C4=99=
dem Pa=C5=84stwa potrzeb?


Pozdrawiam
=C5=BBaneta K=C4=99dzierska

