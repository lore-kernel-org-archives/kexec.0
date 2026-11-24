Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB22E606A326
	for <kexec@archiver.kernel.org>; Tue, 24 Nov 2026 19:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QovvjW2C;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CzI5BMaW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=vmPlBJsxyoTZOO9g2mmGNuUfH7b/frSSah/ZWuzVmhc=; b=QovvjW2CVF3its
	WZpJ6PajiY/ieL0xwdqsYdUF2uP/vZWLzXVlFJ1QMnxSa0J7tgpo1flt5VGun6rDDAjf4WebzxMR5
	UZxizymJe40QT/0PMP8mTNEXtaqrk6dNTeN8mHgOSFD9g2qwGcNXQNRRJGjy/OdY+nLr8TLV7LGzX
	o/rAowYkEbrDu+4TUjdhJVhB2BIisng4rrfOSyX0xFUvFRMrLCBZ4WJAudUIZ+UfSHTWxFvN8GjQR
	YCm7q7+keA7hNtXtIQpDodkq+qjAiOPvpKO+TxY2LxgDLvpJK8YeHfYiSRCe8R9hdppBg+/XUpaLW
	/YqW9GW26GQFmRZFwLnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVvma-00000007Ywy-1eLi;
	Tue, 24 Nov 2026 19:02:24 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVvmS-00000007Ytw-444x
	for kexec@lists.infradead.org;
	Tue, 24 Nov 2026 19:02:18 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-cdb684859cbso2801031a12.1
        for <kexec@lists.infradead.org>; Tue, 24 Nov 2026 11:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795546935; x=1796151735; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vmPlBJsxyoTZOO9g2mmGNuUfH7b/frSSah/ZWuzVmhc=;
        b=CzI5BMaWuC0hQ9uIuLTKOn/jybCILgpABGJVJVudIarMPGIgjcQODq5YGD26KqPOxQ
         89G9s4FL89fkUH456Urw+bzmvFY2kShE8YQWgEcRLkhbvhnAT5FXVTC34H2mh+oYm33u
         ie031oaAusPA7djBsIXfJMHjDbPH596vClQXvtpirKe4ME/JzNc6wY7oyMEQiVreBI3p
         Jbzra6t/VpXdic1yWe9Na3htLakf+Bnv3KcJkQz7dK4xXyQHdNo6WZxWKg1pRWJKyOQh
         K9u2VNBFOgr5xuofBRsPIt2BylxPj/ykVWkb3VFEChpYr2RDJrUMhtJmD5EvybupDHwA
         YaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795546935; x=1796151735;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vmPlBJsxyoTZOO9g2mmGNuUfH7b/frSSah/ZWuzVmhc=;
        b=gqdvHpApuzdjOunLtoPUt/0cQ1cXYaloRXhGy8E5ySI/KQfOxi0A/Rcn+lmSWiXF8d
         9We8rJi5BdswHNl40VZeemQ7j13Vjp+gA6itxyV0IYrk3i+ckwM1YFEGy/g8/AQg+pZO
         vkuQZVn56N/31FqZG85TDhoNx2efLwQc6S2bJtPmjVV9w/YGvuT/OuXmH0hwWhS6f2c/
         4Qqmi+RrXhGyXfNMrdLTd1ZPZAA8Reoi8iRZhuP+TGZqb9J3Z+gLr3UHjpgVOYTQl2dV
         jr+IZEmyXfTtXu8wql+EH5FCzzuP23zlyecBZZuymNgFkio581P7LjQfuBaSkMRWVtz1
         CeHw==
X-Forwarded-Encrypted: i=1; AL+hErHEqEkC9b2ag32dYaUD22ES3rBMFCd2tUpqWfpIspCBEsM9ofLERp3te0z6tfBgUlIDyVj+6Q==@lists.infradead.org
X-Gm-Message-State: APuU4Z8qYmu6qKP8odDetaKU96aL86vvclpVjE+xjEWU7r/WBxMnt9Ou
	GeJI4H9nSZNPBJA2UAOqd0pusyh//AAE6KZvXfI9XPk/7SWrWZmX6G4FakjuKvxxnw==
X-Gm-Gg: AZFdTZcBHVzvN2zJjoIigxIrZD6qpMA+AWtymgBA7JertwZN1SeoxAdtVl5CvRdgY9Y
	yvKETUoWmiPP2sVXA3vSQu4y1fFDkKPSPe4Bf4h0fzQWqvA9fCcVOtG6P6g9Q6ZXH3U7m2e7uBk
	Yieh0YMXlt2o3IdMAqpzOfNw5KSz0aJIE49v/yeoxPXqbeBn27sAu0r72YR67c5lgrnBi+Z1Fr4
	nC6Qzda1GaTqbdBsUeLjXp/FbUhwA4tZhv7nHtEHTuyIUNp2JDFt2q3hd22oaVQX/iwN+1DoFTT
	QsAzbHzQv2t0HOe1vSMYjZndejlo3kIn8JnJAkR//T+46NPZycF5nwdgUNSwje8l8oNh5OGaWt8
	ySSNGcpACopO1ilMbtnmOvbB0q2/1PdwC6TQCerWtnUQ8W85PWfvuPS0o80T7shvwmuX3JcH3SR
	sk1dCh4GAAn46iwcaXcyZD1WqoSPlhaaAqws1G7r2W79p4TL5tjN+h5MpdXpEgpp7ZhwUayKmU4
	9jTfcaS/Xk2aasPcb9ZKiuFepUM8jxyOkAX8aaYy1pzsOCabPmTp9N57I9N1alRnTq6LRlTDw9P
	IYSSS4ELCLBUGPD2RxW0mM3/z37G++XDrJC+0hjM1Lc9fjBaA4ybwTT7E9JT1eMxQw==
X-Received: by 2002:a05:6a20:a11f:b0:3e9:f2d:d556 with SMTP id adf61e73a8af0-4014ca44d17mr16159174637.55.1795546934090;
        Tue, 24 Nov 2026 11:02:14 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde9bb05981sm2247135a12.26.2026.11.24.11.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 11:02:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 11:02:12 -0800
Message-Id: <DN3O9LHR4XNH.1EYLA6D1F0J2P@google.com>
Cc: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "Alexander
 Graf" <graf@amazon.com>, <seanjc@google.com>, <jgg@nvidia.com>,
 <loganodell@google.com>, <arnd@arndb.de>, <dwmw2@infradead.org>,
 <baolu.lu@linux.intel.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 <oupton@kernel.org>, <alex@shazbot.org>, <gle.com@google.com>,
 <pbonzini@redhat.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 <kevin.tian@intel.com>, <joro@8bytes.org>, <kvmarm@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <kexec@lists.infradead.org>,
 <kvm@vger.kernel.org>, <iommu@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <skhawaja@google.com>,
 <sagis@google.com>, <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI
 compatibility
From: "David Matlack" <dmatlack@google.com>
To: "Pratyush Yadav" <pratyush@kernel.org>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-6-tarunsahu@google.com>
 <2vxzse0rzjdn.fsf@kernel.org> <DN2RQ7LGX224.3W3PSQ2PBHTJZ@google.com>
 <2vxz33sqz1xj.fsf@kernel.org>
In-Reply-To: <2vxz33sqz1xj.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_110217_010069_3EE4C21C 
X-CRM114-Status: GOOD (  14.75  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 24, 2026 at 7:25 AM PST, Pratyush Yadav wrote:
> I don't think it buys us any functionality. It just hides the problem in
> some lucky cases.

Following up on our offline discussion: I think it's worth keeping
support for optional features, both before and after the spec changes
land.

Before the spec lands, optional features are the only way to enable new
features at all. For example, the PCI follow-up series [1] preserves
BARs and bridge windows using an optional flag. It's purely additive: a
kernel that doesn't understand it keeps behaving the way it does today.
With optional features it can be enabled as soon as it lands, and Live
Update keeps working in both directions, including rollback. If every
feature is required, there is no way to enable it until the outgoing
kernel can learn what its target supports.

After the spec lands, optional features are still useful, and at worst
harmless:

 - Kernels that predate the spec mechanism can't provide a spec. As long
   as one of them is a possible target (e.g. for rollback), optional
   features are still the only features the outgoing kernel can use.

 - The outgoing kernel doesn't need to consult the spec for optional
   features at all (less complexity), since by definition the target can
   ignore them. It can always produce the same payload, and only
   required features need to be gated on what the target supports.

 - Nothing prevents an outgoing kernel that has a spec from choosing not
   to set optional bits its target doesn't understand, if we ever want
   that.

The cost of keeping them is negligible in the current design: the same
number of bits in the header, and one range check on the incoming side.

The one rule we need is that optional really means safe to ignore, e.g.
optional data must not reference preserved memory or carry restrictions
that the next kernel has to act on. Anything like that must be a
required feature.

[1] https://lore.kernel.org/linux-pci/20261019213054.3157159-5-dmatlack@goo=
gle.com/


