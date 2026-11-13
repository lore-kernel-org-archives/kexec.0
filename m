Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3B3606A332
	for <kexec@archiver.kernel.org>; Fri, 13 Nov 2026 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=poFYtRUd;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=tykrYpsJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Content-Type:
	MIME-Version:References:In-Reply-To:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=a2cHGLKa4ChBnuzA4CAjFivDrSBNfot35o4OmhNmk7I=; b=poFYtRUdGcGjhV9ofsuUwaxQ1L
	GHccQKFlSNBdmKn+Na4WaeqeWGxFJ7fFT5fvnyWKakyh0sikNq7QWiA0FTuOAC6E6Jb6kLu79Vyvi
	DlNiVu5RdSERmNsv4pakox6OvLwBzD96tIIsNDFSCvmFkEp7+ZGLgBsBOqm5UnpbwfPDzfvnK2Qiz
	9Vpc/fVcYhrDoFeiBDrTBROEn0Qq7B2KvWcd+j8MPCMttbDK2a/yNWQ/iAO6+lvKtmdsrMm0AcuYV
	fvi+AH+85WNaCqwF3oeiCKbUohB0bDfVM8YTlNVN9byl3vU4Mt6NyZzgHcDruMTM4pGnmkUtJmYzK
	AGKdqeKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRxI8-0000000EHzO-3lwg;
	Fri, 13 Nov 2026 19:50:32 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRxI6-0000000EHyo-2U1j
	for kexec@lists.infradead.org;
	Fri, 13 Nov 2026 19:50:32 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2ed1e9ae5a8so4967505ad.1
        for <kexec@lists.infradead.org>; Fri, 13 Nov 2026 11:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794599430; x=1795204230; darn=lists.infradead.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a2cHGLKa4ChBnuzA4CAjFivDrSBNfot35o4OmhNmk7I=;
        b=tykrYpsJDp3fhiKhyB5LE7aG1NAzONEetrgxcisUtmLyw5Fs92yB0zNZfOo0i60Or6
         zGsihHxTt67cNgiX49xzGljIJu0eSInae2BhU3kQqcOAK32+BvWQS1x5GJiCXpBsYT/3
         OTiuQ0YCtnsKyG/tdW47B78sSPkP2ZAhnz+y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599430; x=1795204230;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a2cHGLKa4ChBnuzA4CAjFivDrSBNfot35o4OmhNmk7I=;
        b=NoE/Nm56vWwpEC1lTFKvJlDnAJjDZjaqL3pkiF+oI7BSsBl3PbZwnkozFzOozj1v5b
         sHmAKrDhzx+sJSptas4gUn3xw+IWjG8foNbijfMSdqQLqH0JPJPsBkdGly0/l13zuhEh
         GKlfovGYvPK3Pi3D47pyrHbyRe3v+VG7W13ekdjyAFT5m6gaMBQuqns7FeS5rfi7Q2c5
         8SJtTZ7M0dLVRDdMmedzlQcCAgw+f8qYbBE41DB88vb30UQItGhZ08K5wHLLxePpoEji
         D1sPbdWD9OBtECKj0XZeDOgTqJCujvpj9D2T8Un2huT7n7PXHH5GDsF8GMgPwfTeDHoE
         9atQ==
X-Gm-Message-State: APuU4Z+9DkpOnZ0V5Yd+Qe/ShThSdPu0UnDOUvw7zO7sKa9x3fjjcb9H
	YgNreRMG+U1NA7IFGo9zqvy1aZnbqosrW2rE5MRrJ9t83ETy0vD76+8QrRqKH9YgK4Q=
X-Gm-Gg: AYBFou1o1slG1HQkXDDoJ/IS8aNe1rmRyrNcV+G1JDHPaGTeoBwWY3Ikp6pduIpsWdI
	KhBzE1k58ZmypeqHDdndA4F3DKo1DNXlLf1vclqY5+bWxbp/jMUD2qd/+fubKafrm95w5sZMMLp
	MIYprX92drDBOgc557Cdpu+LHsOIzlCOI0AgoEL5eNQdsvwulPG8G9uDo+3QkzKf7VGUAWx8O8f
	Mn56fIKgHeQ2PKdaUt1lJpnZbzKDs655fPQJ5FeCV+9eVUyw38w3WXBrQAyZl8efgCBY+lk01t3
	MNNYQLnjhNbPKBxsT1w/IC/e+/6EKtjbNXXoqPsMERCDUocS1DNbezuRZSFRRaaBjtwZrdPQ2tP
	SMB5LxDm/YmTFLTmbb2Pdp6Y1ya+1ougIUQXb1lxP1zEF/fWCQRraGMBBhvxTrEDtuS9bimB/qS
	adzZyDTr0TOrY/Dm/EpgNrR2vWZ5EtzHK9jwCGlxQugs7SFScFNcy4Wseh1hHYY5K+IwkHFa9tl
	tNUGsU/CZAdtKsBLegLz+qKmVsILnJBc4IbZW4joTdpzv3+Q5R6oL1ib7FJQG6p80Yo+VnmnJ6n
	DEfZq+0y6I0YunPEXtqz6XfAIf39h6QaIRGG8Cyea1taDmLWdbSKPnLcTVt7UkkvmnXsJv+X7Kv
	1zEuSYmpS2mL0KSf2ikT9K5CR6gXySJZ//5Dp897QUsGwkaV3ziqVTLu1l9w14EcRv8pZfH4RHa
	KR5H/405I5M1z1sEARmxM+k1vSiLKPOrBHFTtmjV8qd0SPvnmmQKGHlEg/bSAf
X-Received: by 2002:a17:90b:134f:b0:3ac:b048:fa13 with SMTP id 98e67ed59e1d1-3b1b0cf9ad5mr3440579a91.67.1794599429822;
        Fri, 13 Nov 2026 11:50:29 -0800 (PST)
Received: from [172.22.0.2] ([50.175.87.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18adce4sm1656569a12.23.2026.11.13.11.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:50:28 -0800 (PST)
Date: Fri, 13 Nov 2026 11:50:23 -0800
From: Chris Down <chris@chrisdown.name>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>
Subject: Re: [PATCH] PCI: liveupdate: Factor out pci_dev_ser allocation and release
In-Reply-To: <20261109174009.735309-1-dmatlack@google.com>
References: <20261109174009.735309-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261113115023.0690d833fdabaa41@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_115030_747195_7F6B9BE3 
X-CRM114-Status: UNSURE (   5.30  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi David,

Thanks for following up on this! I've tested that this works well.

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Chris

