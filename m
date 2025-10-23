Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66440CCD1BE
	for <kexec@archiver.kernel.org>; Thu, 23 Oct 2025 00:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W8Jk8TbFz+c+orpz7oeJzw7HBha49CvaH4Ccjpa3WnU=; b=M4ObhfiZ23728sv91lCHGW415+
	mgbFwjTlLrHkVKKv8RJIe+zsC+23r6X+ckb35+uJ1Mbb7A7Dj4gDzGecIDrMQJV4C4zH59KNg1+xy
	a9cvGRTtZCu5Cfngypf+2y68i9DGmObeEVyQfqeV9eK5KgttU6AOB+Ow0MS1iP6Ss7tGkxB9TzXgn
	/8MqxjL36+JQSPkDAeWPWE2R0bj/nkss1glUNx4fIcRaHKjB7t8lAqMpvAXAw+ig80g/TnlhNrRxv
	dMTc9VMkIoGAoUTWrHj9byAU0MfnT5BHBxVNjpBnAc7z7Xw2hxeDgIgUT+XTmoM/b3+xPUgwzOOnV
	G005ehqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBjYp-00000004hHy-2RoR;
	Thu, 23 Oct 2025 00:52:11 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBjYi-00000004hGz-1QD2
	for kexec@lists.infradead.org;
	Thu, 23 Oct 2025 00:52:09 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso986944f8f.1
        for <kexec@lists.infradead.org>; Wed, 22 Oct 2025 17:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761180721; x=1761785521; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8Jk8TbFz+c+orpz7oeJzw7HBha49CvaH4Ccjpa3WnU=;
        b=IhT8b+I2eKZbzxQ8dNBJW8Y1LbEnTMJkocQazJgbzCbFkq0EmG/S6WA7/QlW3EKS9C
         68vqdA1SZFCbpT/9YMocyPH0o3GfKnahC9bcmTDmSdfrpEIV6/pz3jT+XWRlVrlH4baK
         oZWmhjoyMqn4zbNnOQR94gP/86w//rxwqQNoHyEMzwiPkM0mq0jPufGYdevidgYfaq0K
         U4Md5hxVSj0LkbB9obfezHwQ0P8DvxdqkvFIzkO5FitJiYAgyiP/HgZsX4k72ZjUjFEd
         Z/mq9NymC14t02tneV3Q0mQJTBqMv/jPlMS2cZW9ZcJCzcF9uiHpVDub0VG35M+NuM+s
         k7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761180721; x=1761785521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8Jk8TbFz+c+orpz7oeJzw7HBha49CvaH4Ccjpa3WnU=;
        b=f5AdBahtgsi8hAgUNOIoArYcvXcyj8sJv29kg6B+S2GkUheu42AIRmY2hAgk+LGDoa
         abIjteK28OeWjsg83AVNIay/IS1RG6tp6PRYVsNAn6SiEMIii3AkmA+WgLExOQdPN6Xh
         xXeRNH9B/8ngAYBgCYlmIQwMKBYKFjLCKHR3v5iuw1WXIxbw162IMtbz78TjTlpGEVu5
         XtlGzvCKQ15lLBu+UapE8ZXZRFOnRxy9Smm+Mj4HGgdJQgVSSVx0rod0eV8fH3NgP/Dj
         SLZWfZh5FEjfD2zQHvHB8gtlyW/Q9MjvuKCYjlkUtZb+X3NbfyUP4ndLq3PmMG2rAbhN
         gMtw==
X-Forwarded-Encrypted: i=1; AJvYcCX0NvVDkeH5359yygKsxfHsHKBFl2iORBmAB6fcSNlBWAxaoLC79uYmLUmaj3YYrprd0Qx5bA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwMfXBREVS/SMCg4Qc9ZTZ33ySL+cakBr/gvr8VoiUQSeZUgxCE
	3K/U7mEWxm+7CU+QveV4G6cU03qPY0eabap3tjWxAgovtNveChDBxjorkQPZXbyNe6qSSx1+pAr
	1nrxvVNYedHCdpkDQ2I/duIyikNI3D4gmrwfhpIug
X-Gm-Gg: ASbGncsCf7QQJYmxEChYp6s8cXLVj9IBbIB6CHR/9PmVdCym27KwDfn9xudTxN10OST
	zBW5TXjiH4BikcpUTsL/Xj3AbSG05c9ffxHjCjlfIbvhqyuEhworjyOKrEbnbBz3o/GKiQKNsAM
	1Ph1Pp20kp/GGp/GzlR1FnijtnJK1qL2KUj2YAgJQGCYMiwVYwKzUgi8ysYDveTGBKSLpwUit2D
	BVGGHRCRb9cNnlEJkKhuvtUKPagqJKXtOQgDAX61ZUZoXHi98x25qynWupgS5uFpgedIKfGy+TW
	sjkqMrLsD+LOOGM=
X-Google-Smtp-Source: AGHT+IFK/T7RW48hj+WP37N9B2l1dCUkOXONz78Rxgy6qFPZrqWAJdOfNPD+bEnJuzrg23GT3t2tLGdMLUv/EK5dHM0=
X-Received: by 2002:a05:6000:401f:b0:428:3d14:7378 with SMTP id
 ffacd0b85a97d-42856a824dbmr2474671f8f.24.1761180720791; Wed, 22 Oct 2025
 17:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20251020100306.2709352-1-jasonmiu@google.com> <20251020100306.2709352-2-jasonmiu@google.com>
 <CALzav=eqwTdzFhZLi_mWWXGuDBRwWQdBxQrzr4tN28ag8Zr_8Q@mail.gmail.com>
In-Reply-To: <CALzav=eqwTdzFhZLi_mWWXGuDBRwWQdBxQrzr4tN28ag8Zr_8Q@mail.gmail.com>
From: Jason Miu <jasonmiu@google.com>
Date: Wed, 22 Oct 2025 17:51:49 -0700
X-Gm-Features: AS18NWC_Hu82xF4WRuApY2_35h--MDrT0GhF0LG3r2mN6SSshPCeTMJF4FJ7YTM
Message-ID: <CAHN2nP+uiz5MMPTi5pBVF355_=GibgYf+6jQR1xVOAdtD-2aZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kho: Adopt KHO radix tree data structures
To: David Matlack <dmatlack@google.com>
Cc: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Rientjes <rientjes@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Vipin Sharma <vipinsh@google.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_175204_979378_2B4D46F5 
X-CRM114-Status: GOOD (  12.39  )
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

On Wed, Oct 22, 2025 at 8:51=E2=80=AFAM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Mon, Oct 20, 2025 at 3:03=E2=80=AFAM Jason Miu <jasonmiu@google.com> w=
rote:
> > diff --git a/include/linux/live_update/abi/kexec_handover.h b/include/l=
inux/live_update/abi/kexec_handover.h
> > new file mode 100644
>
> The need for this directory also came up in Vipin's VFIO series [1],
> so let's align on a directory we can all use.
>
> Should we s/live_update/liveupdate/ to align with the file/directory
> naming convention Pasha is using in LUO (no underscore)? [2]
>
> Otherwise, LGTM.
>
> [1] https://lore.kernel.org/kvm/20251018231126.GS3938986@ziepe.ca/
> [2] https://lore.kernel.org/lkml/20250929010321.3462457-1-pasha.tatashin@=
soleen.com/

Thanks for the suggestion. Yes, let's follow the convention in LUO
[1]. Will use "include/linux/liveupdate/abi/kexec_handover.h" in this
patch and share the "include/linux/liveupdate/abi/" path for
liveupdate components.

[1] https://lore.kernel.org/lkml/20250929010321.3462457-7-pasha.tatashin@so=
leen.com/

--
Jason Miu

