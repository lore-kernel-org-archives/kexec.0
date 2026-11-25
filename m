Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AA7606A32A
	for <kexec@archiver.kernel.org>; Wed, 25 Nov 2026 00:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Wa6/nsF9;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Qx5nr7x9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=YKxHcqUXjQp/1J5J8B8/Kkrmh8UptW8ucEK7buHNuos=; b=Wa6/nsF9XP6n4J
	oHCvLa1Z/kV8bbfGLHZnP5/slX2uvyxxqILoPCJILM3ni2EaQOnFuw6xZIJwOd5tluquUngCIVjwz
	WpoUt7U1W/JMH1+MFb/NQ/Y4WM9JONBAljVBXEcqb9C3rpT7PD7YW/J5r5bMdj9tvKrxlLK4u1kuO
	uS77P4Clen3GDM8STckLp0p2FUfMndZdFPHDaGS8J++EJVrsyIcmKT30ROLvGNDyEl3PcVAwW1bqq
	8Dbpze2GI1DIzUsWoRDnYg/lNNKp6FNTlRxQtv2aEKHu8485gKpsuep1zsms2M980qKyKLmtWOUGA
	egtJgZeYMR/lXqVZUwvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW13F-000000089nH-3dRE;
	Wed, 25 Nov 2026 00:39:57 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW13C-000000089m5-3LCP
	for kexec@lists.infradead.org;
	Wed, 25 Nov 2026 00:39:56 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2f052ae3c86so27744615ad.1
        for <kexec@lists.infradead.org>; Tue, 24 Nov 2026 16:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567194; x=1796171994; darn=lists.infradead.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YKxHcqUXjQp/1J5J8B8/Kkrmh8UptW8ucEK7buHNuos=;
        b=Qx5nr7x99qqffU8G0syxmxT7zLvtObe4+TBYQz3LhfdtVMPThrtDcW5HBTLbclFprV
         fmUbpJLBwP/oTb4OmiC8w9xlK6GduNWuv9z8SX7+jOxoak2VyWq4xgyX40p6lVsxp8tQ
         PjUGR8B6cjynL7nAAIMerk4384S8gZ8gntcO2kxLJ2kzaBY6I1K9QmUQ8XejTm0Eql/b
         gCmIBSEo+bjNGjYD+M74gzRQpb0UHSReTQKdHZ9pwsgFxUfhXC/IouXnIq4sbO2YsHxr
         x6KNg1ICU86Nm5dpwqWZmFp3kb3pqILU1rh7n8+RcMsvxRrcHrx3deO6x3duBgQTeE/f
         r5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567194; x=1796171994;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YKxHcqUXjQp/1J5J8B8/Kkrmh8UptW8ucEK7buHNuos=;
        b=K69O/zdpeNBdVH0FDjxLTPHLWcPQPDelRxilVOkSCD+FGehSTk/HoLrvxSaJydjLMH
         wDS5drw7xl9TaGcOcKmJSjJIU/NB/peEMvyERbdIQtD7jXtS83KG6O/FNZywer1mg3x7
         kIKL0w/Pv9hoXk7jMMdF/rG1Hn42prvKOt8hJv12uvK2VcE9yuZuVtnIOl5DFD02Gsnr
         nCS0iWeToMltebR/Ht6zlQLV8Apl9u3LFTC2Xuxe4L4LWmwh1yrBUK1jB3Jc/2Vuom1F
         p22qVLmWwRCkUY7kuiwG/tLc0DLLJ16oHARAT5p/5WVbspmPDmmWmeT8V7P1QBaUis+v
         qvhQ==
X-Forwarded-Encrypted: i=1; AL+hErEkwnBUWtof04HPAfFCYaJwRPbB23B3xRuBwrFtOduN/Ye702TfTkjw3ZGxZxN9BuxOyGwKug==@lists.infradead.org
X-Gm-Message-State: APuU4Z/SBe6MERLjhCD2jJC4c9+ggc59OaaG1QWiQ2P9tdTrVM9G32CK
	JdgCJH+gCwI4klbIN2d4NW4MsUEuaJHhZCu4ny3Q+I2o+amzon2oHiXfYnbVrn0hKA==
X-Gm-Gg: AZFdTZcaPq1i28Ca2CYVGRmXDX25asc+ipiEq8aVqw0mTlHKy1S8X9OZUnxnaIs20lR
	3Rq1n9lhl2Ji0JNWXQXyhjIeJ7HnboqirJjv+FAIdj0Y9Kpv0XjK1OvSHELQ0zb7sW0LaNemTFX
	N9VSdDXjG/WSSJmaAqqJ5nbZ0fuYA3oWI0/M4LfIqYjMZfJwoCsJ/t1QlAg2uy7ElOqc06geAm1
	lANV2zH5J4nHuR96nUtPyoSdLZTYdkn9KfCqpbgC4fSWHiC53Y5c4vUD/V+3fDalO1GAhHpvxlV
	rkeoKAR7dI+h7uaXf1ZRBB6bc8psnKahicblBz84LJjoOoe0DqJh5zjZVYzzDHO8hJaaEGJkZgy
	dw2h2kDktS4VoFcVSY1+bAxoUYX+ORtF0iYEhTQRbYPr5OMknoSJKgJC4zuQ7y6O9rlmlY8L9dW
	esdJo7okqleH9oh8yl0LGHMrzYzYtg3i5EmUn6qTcS00GtYILtfYxNX75TVGcd+3V6h3ZLPiFXP
	jklxc6xeV/JY4gDzkSfnLGXIBcuAg6fASq0fiRMRTAIKz890eKyzXm2xig/7CzbE3A9bNJXLRJy
	Sy/8jO0qRYNtJ2yv3/vXXblWCYQtwNWER0ujhDQhK1mGgwJbU1GwXfBNjf/1GEJ7
X-Received: by 2002:a17:902:eccf:b0:2f0:25ea:8fa8 with SMTP id d9443c01a7336-2f03f176abamr169618335ad.19.1795567193320;
        Tue, 24 Nov 2026 16:39:53 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee848c1sm75603595ad.10.2026.11.24.16.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 16:39:52 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 16:39:52 -0800
Message-Id: <DN3VG4JCILOO.YN40XHHSWRPH@google.com>
Subject: Re: [PATCH v4 03/19] kho, memfd_luo: Reference struct kho_vmalloc
 via serialized pointer
From: "David Matlack" <dmatlack@google.com>
To: "Pratyush Yadav" <pratyush@kernel.org>, "Tarun Sahu"
 <tarunsahu@google.com>
Cc: "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike Rapoport"
 <rppt@kernel.org>, <robin.murphy@arm.com>, <maz@kernel.org>,
 <will@kernel.org>, "David Matlack" <dmatlack@google.com>, "Alexander Graf"
 <graf@amazon.com>, <seanjc@google.com>, <jgg@nvidia.com>,
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
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-4-tarunsahu@google.com>
 <2vxz4idb1i2w.fsf@kernel.org>
In-Reply-To: <2vxz4idb1i2w.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_163954_867308_ADC26896 
X-CRM114-Status: GOOD (  16.95  )
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

On Fri Nov 20, 2026 at 10:19 AM PST, Pratyush Yadav wrote:
[...]

>> +static size_t memfd_luo_ser_size(void)
>> +{
>> +	return sizeof(struct memfd_luo_ser) + sizeof(struct kho_vmalloc);
>> +}
>> +
>> +static struct memfd_luo_ser *memfd_luo_ser_init(void *mem)
>> +{
>> +	struct kho_vmalloc *kho_vmalloc =3D mem + sizeof(struct memfd_luo_ser)=
;
>> +	struct memfd_luo_ser *ser =3D mem;
>> +
>> +	KHOSER_STORE_PTR(ser->folios, kho_vmalloc);
>> +	return ser;
>> +}
>> +
>
> Hmm, I am not a huge fan of this. This makes doing such allocations
> quite annoying, and I reckon we will be seeing a fair bit of them in
> many places.
>
> The key observation here is that most file handlers need to allocate a
> bunch of preserved memory, but they usually can free it all at once. So
> we can get away with a very simple allocator that hands out memory
> linearly.
>
> I have sketched out some code for this, take a look at the patch below.
> Note that it is only compile tested.
>
> Perhaps give it a try and see if it does the job better.

I agree the manual packing in memfd_luo_ser_init() isn't great, but I'm
not sure we need an arena. This seems like something KHO slab support
will solve properly, and since kho_alloc_preserve() already takes a
size, KHO slab can be dropped in underneath it later without changing
any callers.

Until then, maybe we should just allocate struct kho_vmalloc separately
with kho_alloc_preserve() and accept wasting a folio per object. For
memfd that's one extra page per preserved file.

