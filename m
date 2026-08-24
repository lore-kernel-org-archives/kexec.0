Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79036C5DF94
	for <kexec@archiver.kernel.org>; Mon, 24 Aug 2026 13:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vCw4dJI8ZifsRp4I78bl5/NA1XA7Yj79m2p41cLSM34=; b=p9dXuTTgazpfYFf0FOwLfAhkeQ
	bPa/sUl8GHI8nT9RGJHpYoEgbTvN4imuKnVtoyIxCou3enZDkm2aivQ+Q4vRwlsv0tVDiDED+js24
	3EOZlC3FIiOR2HonON8KZsE1nsYnwZOj9yLfTC++C6i2njhBo4pmSRDPu8p7YC5i0/6O9Xdi3cZBZ
	cx0yx8YzdUAQ9TYJuElsoicai0HoPXM5M1p/FkanYpp1NfNSV0SoRkIzB+QlST+eTJWdrgiUbIvdE
	FHpEBMvv87p43v8sMLnKTkJIQQig5o389dsbVn/mRXfEU+vDU19JisEhPsKYqG8uf4ARc+iSjWVwP
	9rlpWEFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyUxE-0000000Gigy-1huM;
	Mon, 24 Aug 2026 13:43:12 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyUxB-0000000Gigb-282u
	for kexec@lists.infradead.org;
	Mon, 24 Aug 2026 13:43:10 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2cede6375caso165165ad.0
        for <kexec@lists.infradead.org>; Mon, 24 Aug 2026 06:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787578989; x=1788183789; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vCw4dJI8ZifsRp4I78bl5/NA1XA7Yj79m2p41cLSM34=;
        b=OpdVRxtbiDcQwYsK346Yl3lCy52ASom1gPNyvZQU7uSh/2XPTPmdVPNX/oRJ2PLdtQ
         shyzzKcOLhsuM1oICMUUUfgw5NS+hY9onxiEb0G/J/OffNhtyEugyVVfYVl+nWDnT1c2
         Bc2XRbMtvr7AWOaHBceMUWVPirLrgkfJsnpInvmc3anv5mlJrgmzM2anSrY0ehZW5Egz
         hzVquaNAgNzQa7n+V7wpdE4hOdpSlrv1wy0r/UHY1KKm2sGpRPOzY4OoKV42YL/9NgOX
         npiUDujBlsskCN4Qu+oujEs4sKytZlMldOvVKCtWeWpUpif6vXkiDfkJC8OTVZSHn4Ld
         pkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787578989; x=1788183789;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vCw4dJI8ZifsRp4I78bl5/NA1XA7Yj79m2p41cLSM34=;
        b=rEga9XvkP1Pn8iEgvjdpc1eTAj3JAFdtZFRQOC9KRZ2lOm2GzPM7yXse/PsywUZ4wr
         HxcjEhLMetOhGqbHbc1ydfKbrPulJHK4XxYMx1DjpG+IjLZLKNxnPYEUbfOyluz97oUJ
         z8N7YY6Q+I4hSFo1uQC0NTzpIInGgPGGRcem33uS5Ig97yDvc1ehZQ6/51ZW9jjvYDz4
         HmM2Tz3uar+iDZd3o63gf68tnEsCCshfc2BiJyAU/1OleLtkTDsyN0Z2b8t763jSKK/R
         acUTsEpkisPRYxyd+tYBLQMAUJ7RurkGj7ZGTbqTH8QvK9i2XejgxuVncMQxwBC5qVXV
         rYew==
X-Gm-Message-State: AFuF++mlWRxPG8hs1go10ls1wEgFus8fCLgcBpNxUqDvoA6T+TVDESDT
	EV5ww4SLZTh1HKwv84v43+K5QUQM6r0P0215+84VJF7rOj7n2gVQOZIPI80oDrkTuQ==
X-Gm-Gg: AR+sD12RewbyiGYvyPgahVqncpkshMXInAV2X7kS/umTBpqs67K99EnoJtiz6fsVzml
	CBWN6J0vWexbOParUQEUNhhUJPZgr6WUnSDwetjEnS5xFHycPglanKgBIRmvjXsTeseAkG/Vyz9
	kbn+60NOPDGp+OpHD4HjXZgZTUtY8h3cjAhHoxIhIcRkbLzYdlN21kyywa1QRAqayZdUzbokb5V
	ZtV9OJDNPdYOFx2YFQnfPJ/hiBNf1fuG/ChdlkdmgbJxGY8gnDd7pF9+A0i/ELn9aPT2IIvinjt
	naLAKWQUS8D6SaVaTUd0RBmKtBj9oQIiw1eQtll7MJTgk63ZFZj3u8DfkO61jGhjEg71ZfKbE4s
	j/okN0SP+CFDiAvfa4TCbTvnVqf9C7kkVDod0nYxo9FJbS7kiPwd7XlEvip+IoIcXYXtDhEeGgx
	oxBGrYNa8DeBrigv96eIcIL5B3sQ5MwM9lQvHdp2EsQ5tn1kcoqqNwdjHNkGIu8y6JaE6gfPwwt
	fusYsT+0azmbCbbC/AWbAK1PBEELq6EzMBf
X-Received: by 2002:a17:903:2384:b0:2d5:db3d:1a44 with SMTP id d9443c01a7336-2d673bfffd2mr8845215ad.17.1787578987936;
        Mon, 24 Aug 2026 06:43:07 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b2b97fsm10656102a91.16.2026.08.24.06.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:43:07 -0700 (PDT)
Date: Mon, 24 Aug 2026 13:42:58 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 08/12] PCI: liveupdate: Adopt ACS controls in incoming
 preserved devices
Message-ID: <aoxKYg_9BXs3U6fN@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-9-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-9-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_064309_551344_4E6538E3 
X-CRM114-Status: GOOD (  10.28  )
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

On Tue, Jul 28, 2026 at 10:10:02PM +0000, David Matlack wrote:
> Adopt Access Control Services (ACS) controls on all incoming preserved
> devices (endpoints and upstream bridges) during a Live Update.
> 
> Inheriting ACS flags avoids changing routing rules while memory
> transactions are in flight from preserved devices. This is also strictly
> necessary to ensure that IOMMU group assignments do not change during or
> after Live Update.
> 
> Cache the inherited ACS controls established by the previous kernel in
> struct pci_dev so that ACS controls do not change after a reset
> (pci_restore_state() calls pci_enable_acs()).
> 
> To simplify ACS inheritance, reject preserving any devices that require
> quirks to enable ACS as those quirks would also have to take Live Update
> into account.
> 
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

