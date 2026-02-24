Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74830EFB811
	for <kexec@archiver.kernel.org>; Tue, 24 Feb 2026 08:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iUKKSXBfGZuIEKcFLX2f8iJcwGvlTC3YM5y4lXwVnQE=; b=l3kkkJFiWerd9yCqXO1Qaa1eMR
	2FeYMlSGjPm9wfJsJh+B3WVv5HNfGj9R8440596zHr67clKOXaqh4OOkBtBTb/F8oN/PuPG389cHh
	9ZXUHhAPETHhYKsIW0d2kCjHZ2XYktJAbs8674+UwithtcpXOMXp3KwyQjX0fgRvgeHtQUOw90awP
	ZoGtDMU9VP3hnS3Psi5ChK7mgbDpRNo1qumZIMcvS01M90uZNvUqO0XkTryaePsdlHZrovYwdmeJJ
	QYzVoHkRDoOUZK+fuFz7UffGcZVq9f8TX6sNZZjupB1WmJ9953GlLbsx8xXN8g0M/7WSGKkLtD+2q
	kctl3EgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vunkO-00000001dty-1Bpg;
	Tue, 24 Feb 2026 08:26:24 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vunkL-00000001dtH-3hUY
	for kexec@lists.infradead.org;
	Tue, 24 Feb 2026 08:26:23 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2a964077671so69505ad.0
        for <kexec@lists.infradead.org>; Tue, 24 Feb 2026 00:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771921579; x=1772526379; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iUKKSXBfGZuIEKcFLX2f8iJcwGvlTC3YM5y4lXwVnQE=;
        b=1eLtCk00rGabjf9yj1BpA7cygPuJRKvsGIYvTvulRR5NlbMwOz6IvfeKVnrYDmljmv
         4/jJ0HVSAx0VLveQ/zWe17SwYkEkD669oBhlEcO4iPE8TFBFFDQH5KR1Il5TSFfAYGW9
         a52TsiS73Be/wwh9Euq+BrOSYtxhKrSaP10LkXtkk1LU9SYyzwoY6zvSIbe0TMnX4uZS
         LIwRuWbX7NjCw+1Zb8WfYCHpmdfTQqP9xi2lPnM/I80SNrafu+9iR0Y3fS+OUrmfzaS1
         Jva2MbItq3xms2MvDQeVo9aJxkvE8VHJb4Tolj9DZvFuJYxGWuSNlj3zHN4e+n4bHSh7
         5CzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771921579; x=1772526379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUKKSXBfGZuIEKcFLX2f8iJcwGvlTC3YM5y4lXwVnQE=;
        b=q50Iq4tro+Y3k6WFU5NScxZXuWXYs8n/BgXISpOscJcMMo8J9iLFKLx/baWwSOmzfj
         ZTwBQMzhec8yu6uBjfglpz5vtlm5B0NIT1XnkOeqx8FTtcJByNP2bdK2obP9twdUrOKK
         XZwsdrTD0Mf/3rqRTTyJ/KNahq96YNi9JBHwZ7wCZGH8S0OXNlnT50eW0iERkttm3ECu
         7lNEqig0i6sVuub0wM6/Xg2eDTCZttUXabiRt+z1zb5yT/cOdNWYPfSSmPlsN/23Inwq
         GlRIzjmhs9QMoIAQp6knON6NgrNur0kTO2GDVyF+LE8UsOh6DWk1GUBaybbJSuvLZlN4
         hvAw==
X-Forwarded-Encrypted: i=1; AJvYcCVBx+8dLO+qco66KgRIxtRsr/MrvKbQEKFUTdShqdw5gCo2vWheam5by+D54pr+Dxvp1Kyh1g==@lists.infradead.org
X-Gm-Message-State: AOJu0YwqVivXrpzppvwVNeB5RX5rOQ2jYLJsh3pXfphAzMcJ9LOMLlOh
	R+ZchGn0BjBEnquBwk//GyCqSuToXmxz8KEQ6Es37ujTxctYe1n0rQTKsYdevb3EMA==
X-Gm-Gg: ATEYQzyOxpNW5+OEnAwOodN/TnOcaEH1WcXwAJECnJvBy1/HzQscMSjNrVeAXkUsGZC
	RcUs9g0XyHnisiuEerkuH2wkx+fkUkFDQQpvT95xOfFtdPinBamjhi9Igd0T09VEvrsttayNssZ
	CE5wqDx+v1WlN4GiCOEAkSdoD8x/fEe9dveoeqTzmhcscVG5lth39mD94+GRexECip3NvQcxOHn
	7Vgr00/YV9rR4NM/E1i8F2qfHFXntDoLGS4p70oGHwo0X2HWcV02OUKRLNSW+vKSdRmiFL574rE
	6RwQgS638fd1CgPTkDMhfE/IFKYE9gtJT4IAPG2q6UJ968HO1cLYSXoQt6ANbdKr6/dOyGXzk42
	VbH5M/R8P4JYCA+EdnoV6aWbNVU4djhR74HYg4Ffikxe0DVkJGwtI82VvKbCa3sUW0c332MyLea
	nyao5oIai3DWYFo50/GLRbCNEzym/vR706JU2X0JXHCHXUsld/E5CcZHMSPdxARjwZHBg9+tM=
X-Received: by 2002:a17:903:2f04:b0:2a0:7fac:c031 with SMTP id d9443c01a7336-2ad997f5113mr1474945ad.14.1771921579006;
        Tue, 24 Feb 2026 00:26:19 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ada77cc13bsm13228715ad.47.2026.02.24.00.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 00:26:18 -0800 (PST)
Date: Tue, 24 Feb 2026 08:26:08 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 01/22] liveupdate: Export symbols needed by modules
Message-ID: <aZ1goNCgY8xz9n6K@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-2-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129212510.967611-2-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_002622_030300_47E040C6 
X-CRM114-Status: GOOD (  16.54  )
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

On Thu, Jan 29, 2026 at 09:24:48PM +0000, David Matlack wrote:
> Export liveupdate_enabled(), liveupdate_register_file_handler(), and
> liveupdate_unregister_file_handler(). All of these will be used by
> vfio-pci in a subsequent commit, which can be built as a module.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  kernel/liveupdate/luo_core.c | 1 +
>  kernel/liveupdate/luo_file.c | 2 ++
>  2 files changed, 3 insertions(+)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
> index dda7bb57d421..59d7793d9444 100644
> --- a/kernel/liveupdate/luo_core.c
> +++ b/kernel/liveupdate/luo_core.c
> @@ -255,6 +255,7 @@ bool liveupdate_enabled(void)
>  {
>  	return luo_global.enabled;
>  }
> +EXPORT_SYMBOL_GPL(liveupdate_enabled);
>  
>  /**
>   * DOC: LUO ioctl Interface
> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
> index 35d2a8b1a0df..32759e846bc9 100644
> --- a/kernel/liveupdate/luo_file.c
> +++ b/kernel/liveupdate/luo_file.c
> @@ -872,6 +872,7 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
>  	luo_session_resume();
>  	return err;
>  }
> +EXPORT_SYMBOL_GPL(liveupdate_register_file_handler);
>  
>  /**
>   * liveupdate_unregister_file_handler - Unregister a liveupdate file handler
> @@ -917,3 +918,4 @@ int liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
>  	liveupdate_test_register(fh);
>  	return err;
>  }
> +EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
> -- 
> 2.53.0.rc1.225.gd81095ad13-goog
> 

