Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7342F357BA
	for <kexec@archiver.kernel.org>; Tue, 24 Feb 2026 17:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xJz4QDTcumvz9JVrQMb51pWWatd7LKwHk5h8C7Rf46E=; b=T094IQEn/tWGGySCvxEizA79vS
	vTJveTbNzIQIcLyG2ZkVVrdtSZ8jRuMI10CSzd3LmkBEcHgjf8OBtEjkasH5GJkat13qyLHdFYBFw
	WobUbEMrQwiRi8xrB7iCsP6mxfi9EXBHMkt7ChOVFfe2PwvyUUVQzzBCU7EMz75AJLP+wzR90UG/l
	aYn+eNCwqZ4MAIb9VfOLPvy0Nm7pD102QpW6UdVIRXu39u9hCt9Ujoz/InZdRnkgx2pmyiYCUpmKu
	h3es9e1Fizd3wAyYV0VW8L19fepJ69/bwrmDI/papOmpPwrUcREiI5Zt912n/D39KhwUBNe0f6NYV
	7W+hl7Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuvtX-00000002Rsi-30ot;
	Tue, 24 Feb 2026 17:08:23 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuvtS-00000002RsO-1pQ3
	for kexec@lists.infradead.org;
	Tue, 24 Feb 2026 17:08:19 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2ada9e4ea32so15045ad.1
        for <kexec@lists.infradead.org>; Tue, 24 Feb 2026 09:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771952897; x=1772557697; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xJz4QDTcumvz9JVrQMb51pWWatd7LKwHk5h8C7Rf46E=;
        b=opff7LTglY+cKuoWFY7O+wfIqTU9e8vEpUAnD46mI03scHYhHfbfLyC5RvpbrjW/xT
         tgcRec/fUcOIRcpo73A+A94ImXqvQ/adY7MdSdcd3tby5da5Sdx9pg8YKM0V+OmLzrN/
         sKyCPOKm7iHkwMmrKtSO0QO7Rg/NJc7jw09qrAp+CmFSTyJ9KVlEXR7RN4LenJbiucQJ
         BCl9TsLJa85wy5wlntGsFlTcx3h+Amge3H9hfmbxN700KwX4vy9jRWQugKmoWFgMWF5v
         I2v1HMsamZSo8P5Ku60Uj/2fCOlT808xAYkAycsz3KEqtK2SA1kMtO9AnCa8W18dHU4W
         r1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771952897; x=1772557697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJz4QDTcumvz9JVrQMb51pWWatd7LKwHk5h8C7Rf46E=;
        b=DKnESnCxmgPoqQSpjfOytkzl2ZPXjO9luCC8Jbfh3HqYJXEuJcLHBa3Uyp5nvK5+FZ
         BPuO7CXQtgB4A7y7ifN4+ZSZQVUqCAguppwijP3Ci6OpQL2LByP/kZvDCBIClHJ9w1nW
         CVaIyFkxpAFkyv9l+5AwxNXZj5rliUhcmqZILz1FeT46rgEgUUHka9CS8NNJ3s2ESRgC
         EWQ/y/nHcZwr6YK/gxe1CIZPXCcYXALaoqdxpIb92sskdMQa/FGLktoBAGxy04HHVNDb
         uSSnouGjk5iUO9h7isPnVfMfc/nIL57sOhHjH0xbV6qZFE/1ypdlL5pqI2WTGUahnqW4
         ya3A==
X-Forwarded-Encrypted: i=1; AJvYcCU8in9yz8u1qym5XiRGvWfKZ+rXlFYr5xer6E5cbRq2nKlGixKQOwCYW1SzuQnmJtuaYWIJ7w==@lists.infradead.org
X-Gm-Message-State: AOJu0YwB3W4W40HgOWFhJ5LHFUNoA8ee+hyJ0AwLCJzlD4Vbb//Kqnxa
	wI9GCbRczAwSAvGYuO1hQOnRPYrGrkgxyPjlmSlurke6EnHTRtXKvQsQ2yKyODtdAg==
X-Gm-Gg: ATEYQzyMVERwDW/kcHJv48M5KT7DNcwTuw8PfIrnu8NFyH0ZcwooRus0kWHYdFAnqfQ
	G48xY1b7DnCN0RGhOewX6DLwf+p1aBqIbmOfiOrrtfTW8ajjxR/H6BgcN7EiHve0/DttuiT9n8D
	FjCK6/Fn/1SwHDnTdABDitAQtQFpY6Z6TTd0POecsflZp7fKsiD1KvBsddOyh1fGYB6DH2JQu0f
	RGUk/7RMM25SwPDl3cjnThwRn8V0FPGurmOl+5OQ3M2/lg5IMVQ++Ay/HSLpOt1X9fotu+zDBuM
	bRfBA9l5BAZrSZA+5yIJObpsLjWuL4L30XziBf5iiYJRmbHAeptFOfRQoDlLZYP9ec7j10/5fsx
	7AdTDVzGoQvIKhMYMh+6g2cfNLRwCjRYF+rj4n/1etMH73mt7iQGxaGygGTBPS+sMojAc1PquFi
	6BdsntL7V8t7ESvhxnhps8A7ohYaDP4yFOtty4qq/xR/BIOukBVHpkpVakhP68vw==
X-Received: by 2002:a17:903:b87:b0:297:f2a0:e564 with SMTP id d9443c01a7336-2ada346b6c2mr1775335ad.11.1771952896593;
        Tue, 24 Feb 2026 09:08:16 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82719e7ed8asm1521995b3a.5.2026.02.24.09.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 09:08:15 -0800 (PST)
Date: Tue, 24 Feb 2026 17:08:11 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vipin Sharma <vipinsh@google.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 01/22] liveupdate: Export symbols needed by modules
Message-ID: <rlftyyae4w4frzcpvyecda32vxod6uambsb7cja274lugs4nhy@3yk3oki2kwo5>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-2-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260129212510.967611-2-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_090818_619925_4ED1F3E8 
X-CRM114-Status: GOOD (  12.14  )
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
>Export liveupdate_enabled(), liveupdate_register_file_handler(), and
>liveupdate_unregister_file_handler(). All of these will be used by
>vfio-pci in a subsequent commit, which can be built as a module.
>
>Signed-off-by: David Matlack <dmatlack@google.com>
>---
> kernel/liveupdate/luo_core.c | 1 +
> kernel/liveupdate/luo_file.c | 2 ++
> 2 files changed, 3 insertions(+)
>
>diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
>index dda7bb57d421..59d7793d9444 100644
>--- a/kernel/liveupdate/luo_core.c
>+++ b/kernel/liveupdate/luo_core.c
>@@ -255,6 +255,7 @@ bool liveupdate_enabled(void)
> {
> 	return luo_global.enabled;
> }
>+EXPORT_SYMBOL_GPL(liveupdate_enabled);
>
> /**
>  * DOC: LUO ioctl Interface
>diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
>index 35d2a8b1a0df..32759e846bc9 100644
>--- a/kernel/liveupdate/luo_file.c
>+++ b/kernel/liveupdate/luo_file.c
>@@ -872,6 +872,7 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
> 	luo_session_resume();
> 	return err;
> }
>+EXPORT_SYMBOL_GPL(liveupdate_register_file_handler);
>
> /**
>  * liveupdate_unregister_file_handler - Unregister a liveupdate file handler
>@@ -917,3 +918,4 @@ int liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
> 	liveupdate_test_register(fh);
> 	return err;
> }
>+EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
>-- 
>2.53.0.rc1.225.gd81095ad13-goog
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

