Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E70C5B56C
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 15:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZgoC3EVHJl6ia8wuwHBh/UBVnOr2ch9hVINB/bxGV/U=; b=i61iBWmWSt+QgPV1HpCSTlG8ZO
	O3BUjliroZQZNDvBqi+DMiIkfhkwhV8uwpnt3GRohHcL2EXvauaApdlpNtKsAdC0ydYFM2zawCvMP
	kN8QbfBqvVuRXEQ3QnBKFGPd2od3OOIK/NObm8QirjB6ZG8DhwUTA5fp+wSzJrlXjB0o9UzOpdTlU
	QdwOwccNFZh9Ri5C3jSSWG1cLKJTBPQ3+bkaau5qqRD/FvVh+5rjBUqJrmbk7tBbxHx7BiBpfjFfU
	KmPAq6/wRVx7kvhDY1HGBfMAUOiIprsMeZsCDTXxuJayuk8ejZMIgJyCBTYnLCcPs7m629w/q6nta
	13HQMVpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtRy4-0000000CGzX-1CtL;
	Mon, 10 Aug 2026 15:31:12 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtRy3-0000000CGzC-00Yu
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 15:31:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 73996600E2;
	Mon, 10 Aug 2026 15:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 94C821F000E9;
	Mon, 10 Aug 2026 15:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786375870;
	bh=ZgoC3EVHJl6ia8wuwHBh/UBVnOr2ch9hVINB/bxGV/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XCwFFAEe1Sf0qajqt32ItNxUt9zLYHwaT1IcEnbSahBhN3nnERgPwaXvMP2QJCFMe
	 KQthG99ng2h3wLISdbzBBnE63ZRoecRSzYDITyeqXKdas3hAgjfs7+8wOXl1MyBxZE
	 R2f2d1JyTmu+tfyEhWytkipRiRCSGxyXqW+k883Ng9huX9i+mJqHUktkIM4iFxuiH0
	 Pq1/M2PcpIzjCy4ieeIhlG82xjElda7RKVQeD5gfgBAAbW1EcEHTvVWZZPvf7b82FD
	 lqvSzMWwI//qHCB13jg6xeEVStnFNEKvpYbhLTx6iiPtmb6g/W3WPQZaddeXKbK2wN
	 TlUP6SR1Ydacg==
Date: Mon, 10 Aug 2026 18:31:06 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Jan Sebastian =?iso-8859-1?Q?G=F6tte?= <linux@jaseg.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>, Coiby Xu <coxu@redhat.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, keyrings@vger.kernel.org,
	linux-mm@kvack.org, linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH 4/4] security/keys: zeroize key payloads before kdump
Message-ID: <annuus46w5SXmlsA@kernel.org>
References: <20260731154608.153258-5-linux@jaseg.de>
 <20260731154608.153258-1-linux@jaseg.de>
 <2259835.1785538211@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2259835.1785538211@warthog.procyon.org.uk>
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

On Fri, Jul 31, 2026 at 11:50:11PM +0100, David Howells wrote:
> I've no particular objection to this, though I'd prefer the name 'wipe' to
> 'zeroize'.

LOL, I responded exactly same before reading your response :-)

So yeah, +1 to this.

> 
> You should also wipe fscrypt, tls, rxrpc*, ceph and cifs spnego type keys and
> maybe asymmetric type keys.
> 
> David
> 


BR< Jarkko

