Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44806C25B77
	for <kexec@archiver.kernel.org>; Tue, 21 May 2024 01:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wb9QM2xUGBzznZjX1YMmrK62S4VGU1EhNZATi0aG5CI=; b=aD1WGaF4W92PlYWv89ANoKFYM3
	Dj+uuLXiHx2xKtQw0fhtN64dGEfvGO2pQr78FienO9IYrDpfQmNx7iHFjsMHInezYOxSH0jxxwLqw
	rmY4+4F2DDBRmPwCDinJ7RYLuMxDOWXFXpdY1b9rYTCeFMU7hlIuhcij6j8Q3xoNSzJ3n4uGWh7P4
	t77cL0rENLv66H5WUp6o7o8Q0AepViSnOfj6gpQY6TI6CfoySVMuFQtNwNLqK1rY+PT0gnCBu+quA
	AFTEcE/QNiJTvWgTt0Ysk4/2OJjgMvLIS1vGBw/efY6MrNkJwi4OykakgCehC1V0KowREpL9kqaM+
	EJ/2qvHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9EZi-0000000G0tC-1t7W;
	Tue, 21 May 2024 01:45:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9EZd-0000000G0sL-1V9f
	for kexec@lists.infradead.org;
	Tue, 21 May 2024 01:45:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716255949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HlCkg0tP4Cpfzk2bC4YEhkvWskQ1DD1aHNtJblqbcpg=;
	b=MECzBY100HCXpvfi13TJm642zigzC9OV3e+BHKDW5yhuYP/SbB8QXH+nP3YoEaaBAPFuJX
	PD4DKbIFJTLrfYNhLUmdmGHKZlbX9NreZMcDvaPIwKrF1N5Nr4ekTmKipMRlbiLrq2vWOe
	59vOAYZeGsv3zQzgEBYKLgo9Pnb37TE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-HftU9EnhO4GS9iw-GoeOpA-1; Mon, 20 May 2024 21:45:47 -0400
X-MC-Unique: HftU9EnhO4GS9iw-GoeOpA-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-66957d4e293so2065034a12.2
        for <kexec@lists.infradead.org>; Mon, 20 May 2024 18:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716255947; x=1716860747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlCkg0tP4Cpfzk2bC4YEhkvWskQ1DD1aHNtJblqbcpg=;
        b=bUf/3Z3LjOrupbe56bHBcIKWHoDdaaVLn7deKBuQh8R4jBYlSAOp+ZBBSfDTImc0cX
         tlkLWec/iYifSEp014tnvZu5KYoW3Gc+D5Omi+T6IBzdeXQMRzBj8QMSR+1CIe7s9qW8
         AcWkwJdYaeaiEg51tOsAza5DBzQ6uvuPGAmX7vYG5AxfPbCVOqVaB1fhZITAncujQCPW
         bAzS0wIzZW/LIS2PmfbG57PU7eOx/3emIV0LBUrQ4AHPHIXUUgC7DbIizw4hVMSXISY9
         MdPHqNIvNHxkSGod1KaDuPy8OaK9nLEO2X4T6HJ+QDIBneCzYjhOOzhYH8qU3vouTNuP
         hOyQ==
X-Gm-Message-State: AOJu0YxDT/8g1uATLwIYR2oZzzdX78yH4h5ZvWOndMs9PoMn9x7Iz1tN
	CYyVQiUVWnk7U178EsuvutBBIEIJHDHclVYjXtoz1ykZe4mUF5S5kVb+GHpmD03TNIvtQQC0KV1
	xC31EYZUyFtmRDfUlti7c0I7OwlHlEaAq+VUYK4qCrspXJeg7nmWjmBwGgg==
X-Received: by 2002:a17:903:1208:b0:1ea:bc:53ac with SMTP id d9443c01a7336-1ef44161e5bmr341628885ad.44.1716255946444;
        Mon, 20 May 2024 18:45:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN5g1E6nTlKOP21DL9Yzz2/p0qfOZR9sXI4bI9iM65GYg3ScXNcnblgsFIFUW7eoYcrmNjhw==
X-Received: by 2002:a17:903:1208:b0:1ea:bc:53ac with SMTP id d9443c01a7336-1ef44161e5bmr341628485ad.44.1716255945389;
        Mon, 20 May 2024 18:45:45 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f30c391ac9sm4521795ad.37.2024.05.20.18.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 18:45:44 -0700 (PDT)
Date: Tue, 21 May 2024 09:43:17 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v3 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <iwx2noaevjat4uzqvagmrwgxgxj3rufanut4gnjte33thx2bdr@r3fhtf45sgrv>
References: <20240425100434.198925-1-coxu@redhat.com>
 <ZkrrIf1P6rx3WhjM@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <ZkrrIf1P6rx3WhjM@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_184553_503021_445A688D 
X-CRM114-Status: GOOD (  12.13  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, May 20, 2024 at 02:18:09PM +0800, Baoquan He wrote:
>Please don't add dm-devel@redhat.com in the public list because it's a
>internal mailing list or aliase. And I got error when replying.

Thanks for the reminder! Actually it's a public mailing list and you
can find all emails publicly listed on [1]. I did some research and it
seems we should email to dm-devel@lists.linux.dev instead. Quoting [2],
> To post a message to all the list members (who were subscribed with
> mail delivery enabled as of 2023.10.20), send email to
> dm-devel@lists.linux.dev.  You can no longer subscribe to
> dm-devel@redhat.com, to subscribe to dm-devel@lists.linux.dev please
> send email to dm-devel+subscribe@lists.linux.dev.

[1] https://lore.kernel.org/dm-devel/
[2] https://listman.redhat.com/mailman/listinfo/dm-devel

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
