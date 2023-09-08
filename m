Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9F3EE7FF3
	for <kexec@archiver.kernel.org>; Fri,  8 Sep 2023 13:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ISWbTFPTTJ7j+VqxMKvWUxyJeJSuJpCS+9bNZu/nnow=; b=keMPw5NOrTgxbF
	4bHVHxXiSTu9UdCpssiT2/7kPtdUzzif4cylbzatLuudWgGoHhvA4USZ9QKn9ccOSd05p64M23SdE
	IpefcERbGy4Eng1P12NRvqOs59h2G8b1k5CIr+yjYuYw9gOqNrAvdxzcgqUefft1b7YvYJ6F2v+Rx
	tLYodxYSROw6BWyy9PRbXGbkGFQKVKUxRABb7/CgzJ4Lqu9sCLAlGgPY19QfYIXJQFwDyYXekPDLp
	QdTUAwnenn/5kBEDsRmh4KaWfzHHYJ490seU6zxDSRQKBVoPpKD282x1TfynoAEtLjQBbK6GjgXvk
	Gkc7op04mx/nuheRYG9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qebS7-00Dq8b-35;
	Fri, 08 Sep 2023 13:23:15 +0000
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qebS5-00Dq6s-0M
	for kexec@lists.infradead.org;
	Fri, 08 Sep 2023 13:23:14 +0000
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-502a25ab777so487064e87.2
        for <kexec@lists.infradead.org>; Fri, 08 Sep 2023 06:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694179388; x=1694784188; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F3bwfYcCfax2W/6G6e8Bu9Rry/CZk0T2gflxVUWD1AA=;
        b=sXUiJs5Nv3ksMaU2RM0Yug40cdz6gT/BCzsmolvqVLfaa2qbw6FJ310eOh+ZklJZpn
         jA4snhp97fLIQR4asF6SZi3hfujzYVxrNSpDAsMY8u5tOrSJwU2ZFF3Z7EOAU898qcY4
         PHfCk10/CeHkFjzXzYHpuwWf5hqGAih696AfHGmGkQao+WNNXlahQ0GH7razu19Q5k4A
         o3032bwbwq+8F/1Us84Y1LXO6+zA0EykccNOdBEjZvqUR6rzOXmmNt/86AG+aK5nkv1g
         fZV81SFfcsAjfO/EzGx8zzu5ArRJoHcDnkHXTC5V6C8rbzhmXozmnWLkyfiJ0V/Rqf+c
         SXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694179388; x=1694784188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3bwfYcCfax2W/6G6e8Bu9Rry/CZk0T2gflxVUWD1AA=;
        b=kQfLSrDHi01V92bpY8G8w526k58MVQ4YOTwNJOHvpgGEbg7x+zexf3OpqP+ONK44jw
         JhESSQC58LJdGq27PnhO5aaykUd/XLpwIVq9TFxFhoJZei+ZIetsHNhyCMEQQQ16rKJu
         onNoVuo62aEupEg2IVcJ+cctPSUA8yAz44DQusB63QsyjDMeFZcU2rSYEaG74U7iaCLN
         cHN128xnxyE4etpc9jESSAw6/nfeZZBFATeBkxXB+LAYQ4y4oCiyuP9gkpIu+d911j7R
         jAlCw1RNuvdD1vS73CQfOfjOhLDxGZkZz+Z85HzIUL6onVeosmqHf08LuUT5jUTIB7Ou
         cqag==
X-Gm-Message-State: AOJu0YxzvlUI3+UcSR99sGql/qVbeeW96HP0pjhaiIj7IZUHUtgKWeVD
	uFZR4RbQY/KZE8xoKQ1uUr0=
X-Google-Smtp-Source: AGHT+IHsbWj/tbUu0fBjassxuH/Te7MYFp5lDznI8mcQY9BpFsJcl2xzr+rfSlfIUUsXacLbIOB/oQ==
X-Received: by 2002:a05:6512:3d1c:b0:4ff:8c9e:eb0d with SMTP id d28-20020a0565123d1c00b004ff8c9eeb0dmr2349101lfv.0.1694179388078;
        Fri, 08 Sep 2023 06:23:08 -0700 (PDT)
Received: from pc636 (host-90-235-20-237.mobileonline.telia.com. [90.235.20.237])
        by smtp.gmail.com with ESMTPSA id eq7-20020a056512488700b00500a2091e2bsm287247lfb.99.2023.09.08.06.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 06:23:07 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 8 Sep 2023 15:23:04 +0200
To: Baoquan He <bhe@redhat.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, k-hagio-ab@nec.com,
	"lijiang@redhat.com" <lijiang@redhat.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH v2 4/9] mm: vmalloc: Remove global vmap_area_root rb-tree
Message-ID: <ZPsgOHZS4Iacxvbv@pc636>
References: <20230829081142.3619-5-urezki@gmail.com>
 <ZPkyw0nAQSQWj5H1@MiWiFi-R3L-srv>
 <ZPmaYgsT5EdLVUyO@pc636>
 <ZPmesS66PTl+1Mdz@MiWiFi-R3L-srv>
 <8939ea67-ca27-1aa5-dfff-37d78ad59bb8@nec.com>
 <ZPqmZq29U4hrJPaG@MiWiFi-R3L-srv>
 <1d613b25-58d8-375b-6ef4-b27bc9b735e3@nec.com>
 <ZPrC6F76sBLtDgjJ@MiWiFi-R3L-srv>
 <ZPsEqcREYksx9Ot8@pc636>
 <ZPsHwrjG+/6r7ln9@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZPsHwrjG+/6r7ln9@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_062313_151144_2E908E8B 
X-CRM114-Status: GOOD (  11.52  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> > > 
> > Appreciate for your great input. This patch can go as standalone
> > with slight commit message updating or i can take it and send it
> > out as part of v3.
> > 
> > Either way i am totally fine. What do you prefer?
> 
> Maybe take it together with this patchset in v3. Thanks.
> 
OK, i will deliver it with v3. Again, thank you very much.

--
Uladzislau Rezki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
