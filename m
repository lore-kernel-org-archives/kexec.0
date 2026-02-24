Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E3EE9B249
	for <kexec@archiver.kernel.org>; Tue, 24 Feb 2026 09:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eblwuyUmTR+DmwKKXt5BlH8l1BOeREzivs7XkohPLYU=; b=ocOD/O2ZRXhYo63F9EIDZEXzak
	hyTHT1hxykQZB9v6KWww8TKJPlSdX+4ssE0B5S5hMTBkdTgNtfqmaHqbGtrdxvUXsA3aSJCelFO7i
	aeUMvUtomPRr7oib0nEKot8jEho/7nn/SUcZ1SQ9l15jwewrzUP6L5NPYvzcLNWq3HT+9xBPAmJ/W
	UP0WbKV/x7yYp20bZbWvJk+S1XokP92c4d2oMEUymqqjxphoZj6x8npO9x7QXtUIGGh/qmmHIQIlu
	koU844lFtfAJvKUk+N1io6CQhx5bewzxJ1sz6w0T8qahRAvWirJT7pygQvVfV9k78CXJGqqTdBQZV
	6yccItBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vupC8-00000001oOG-0FRa;
	Tue, 24 Feb 2026 09:59:08 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vupC6-00000001oNr-2Fhj
	for kexec@lists.infradead.org;
	Tue, 24 Feb 2026 09:59:07 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2adb1c1f9d4so17125ad.0
        for <kexec@lists.infradead.org>; Tue, 24 Feb 2026 01:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771927145; x=1772531945; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eblwuyUmTR+DmwKKXt5BlH8l1BOeREzivs7XkohPLYU=;
        b=1C+DBR4fB4K6hh6BLw6uAYuAM7egXRety2Sb3afUI8HxYXpUAkQe85nr7LBKZTn4e9
         /19HEqg5DKFVlqZz4RK82oNRWDGZN/N7GuGeqYaR1EgaA06K5BzvNoG+Oic5uDTPLYMs
         FaQKn4SncJuh6lTd8LoNj0ADKlc5K3FqHPcULzBHZkRWA3XQDtKxcJnyVFTe/Fs04YgG
         6ciswEg4+0A/qG2r/sdLzeJZRjsDjoeIvxaxbi+vRTtDcHvcKrnBd8A0heogWQK88U5k
         bmKK/ynxF5Hlkfp8aB+VzkXx+EUMCdGNVibL8IwcuwS+clFXdXt8X3WCn0EALKtTBS3K
         pSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771927145; x=1772531945;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eblwuyUmTR+DmwKKXt5BlH8l1BOeREzivs7XkohPLYU=;
        b=Hk1/A0F6FwJCHiZ7MdiuY8lxjm0gNGU/+dOqSJINV54Irm6x2IMqV6waQNIzerZ6vf
         vnlKLefHngSaJRCYzHG/5xODd6qrY+I06kcaFzWppMq3oRqbO9sGIO+fXnlQwO9PVneI
         U63Usl0+G2ov9Gn98lv7MrXE5BIttQKMz/UPDhOooz8pU+ddPkqvx8l1zU9S+oCb3F5G
         o4tKCM1orCXpQxMsKqPjJ/XZCVhmX1FtP/ffnxlHEJK/MSgLgSUe/RvD/SooG4E7Ookg
         IFzWfVU5P8hS6sSwc9ZovtXREDF7/+YQV7u8MshcyqiUjqadHm/i7CpZmJ2F4GEh+IaR
         rX7A==
X-Forwarded-Encrypted: i=1; AJvYcCUOEgSK2pZY8Y9hpNx3pj5Ecr6uSQCFzL0aNL2Bdf0bn2NtK9CxAyagTaJ8p7J9yphf3mmI3w==@lists.infradead.org
X-Gm-Message-State: AOJu0YzgCfL3dlZEQQBI+k6u1BqZO1Srv+O/uGTqnq2+iIR/j4QId7X3
	3q4KNbAg8rtlud1npJ3VfJK/c/CQoVk6v4LhCdNzT1bTo7u/uRV3M6F2njPzNaS4Rw==
X-Gm-Gg: ATEYQzztI3JO4vwcv4rC27ivPLh10B5CtC3npevFKHtgeFhbnjcJO+TgDRNc+AfCP/J
	4VCk0nbAjzRLWSKoLQfHpjQQJScoI/q5iv7ERcfeSL2JNDcN5EQec8gJDHCtn9Tg2ti6cO+6rqk
	OlPYOLmHWjoPA6y1KTZmevmda5+jvtv3O82pYNOwc6kkJ3L6KYLIF48z/NztIP5uG1/H3QdMxws
	F0lfzO1SFWqRdwghhuoB3nbDpgNc1a1Tk4lXihKvajwTDIFHEeBfN6SRdcnPEgbCS9RcycqSvKw
	VOo8GsvGvde+4e5Q9rkj62LO7CQFo5JXlJGsxhmpulC/Jmcrs6WHFezwINo0L6mNrgUe4NSdUcc
	y3Qa4USs52X8UQ7jwIlJ2sMnEqh1c5JyXsJU3ZoM/dlkx1d22WkBdO13+a6vS+1DzOfPovtyT0N
	28WPEHcx9Tn2T82AZrKPrQ2zsf5Rr1NdQM1Dg2vziC4/LHx781kg6rjqw4VpOBFoFGMaGYKQc=
X-Received: by 2002:a17:902:ec89:b0:2a9:5ef5:399b with SMTP id d9443c01a7336-2ada3497c30mr1333915ad.19.1771927145136;
        Tue, 24 Feb 2026 01:59:05 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd47c737sm9949341b3a.0.2026.02.24.01.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 01:59:04 -0800 (PST)
Date: Tue, 24 Feb 2026 09:58:55 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: "Yanjun.Zhu" <yanjun.zhu@linux.dev>, Alex Williamson <alex@shazbot.org>,
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
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 04/22] vfio/pci: Register a file handler with Live
 Update Orchestrator
Message-ID: <aZ12X3tGn3W7YP4I@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-5-dmatlack@google.com>
 <6dc423bd-36e6-4f97-b2b2-c7030575a3a1@linux.dev>
 <aYZ15u120FEa8Qw2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYZ15u120FEa8Qw2@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_015906_579666_24E9B5E3 
X-CRM114-Status: GOOD (  16.56  )
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

On Fri, Feb 06, 2026 at 11:14:46PM +0000, David Matlack wrote:
> On 2026-02-06 02:37 PM, Yanjun.Zhu wrote:
> > On 1/29/26 1:24 PM, David Matlack wrote:
> 
> > > +int __init vfio_pci_liveupdate_init(void)
> > > +{
> > > +	if (!liveupdate_enabled())
> > > +		return 0;
> > 813 int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
> > 814 {
> > 815         struct liveupdate_file_handler *fh_iter;
> > 816         int err;
> > 817
> > 818         if (!liveupdate_enabled())
> > 
> > 819                 return -EOPNOTSUPP;
> > 
> > In the function liveupdate_register_file_handler, liveupdate_enabled is also checked.
> > as such, it is not necessary to check here?
> 
> Yeah that is a bit odd. I see that memfd_luo_init() just checks for
> -EOPNOTSUPP. We can do the same thing here.

If we move to checking the return value for -EOPNOTSUPP, we should
ensure the pattern is consistent for the upcoming PCI registration in
Patch 7 as well. With this addressed:

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

