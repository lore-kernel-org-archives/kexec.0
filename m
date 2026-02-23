Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59386EEC2AB
	for <kexec@archiver.kernel.org>; Mon, 23 Feb 2026 23:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/Nz0fZa7S09a21wJlX7cSiDYFAmJR+w6WbxCWC6v114=; b=ztCZXr62E1QMFPJkxjl3Iofd5e
	AqOjaX5gjVcTbGmQiLpCoRxsZfla8Th1N2OVeYAx4Me8jZRhIz9q1yx7VJPGLkRG8nDvV0YWYcF+I
	l7X5Y1sshlF7b2JKwEDJInb+Qn9Y4mziXX/J5dwEVSGpVtd/EXt37VZfyCuuCNS5iulcthXsMEWrh
	UKYwdbnIYEIEODzRfAa+YpyHFLXVqQ1gWrpbo/kQ1P1QyjVnCBdgxCJ+7LI8n+nrvt0XW7YLIfLQH
	DLcw4ZnJ+1y734yTeQf7+jj+uZvuRX+gtrf4Zuj5bYCb8SyUvA7koy63PK6VT1Ktgz1Opn4uuK5Qo
	yWbhADdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vufah-00000001ClU-13pF;
	Mon, 23 Feb 2026 23:43:51 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vufae-00000001Cl6-251C
	for kexec@lists.infradead.org;
	Mon, 23 Feb 2026 23:43:49 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2a964077671so33115ad.0
        for <kexec@lists.infradead.org>; Mon, 23 Feb 2026 15:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771890227; x=1772495027; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/Nz0fZa7S09a21wJlX7cSiDYFAmJR+w6WbxCWC6v114=;
        b=qa7gOreOKgNXwwt0/bz8Y3+BPkpZRuMK9AsT2laaVnOuUFGk9EBV2ZNCV/lbqNL0Wh
         PGamIyHMjwxPqvWNP/rbScXllaZkz/FdCMM+UJ7Nt2RPya8ya9DH324keI8jim9eR4Np
         0+d7e+kJbQba5w3zz94u6vXD3SkpfEwHnKk2JXLRXqZ6jUjPeITQYh53DT6HH4kKJuFa
         mpBHvwfyB4Joni7gJdILSDYgwNLs3Ky5vTyxdWW/RPASP/rBtEJnPNyAhoqPw8uZft+m
         jYlTn1DA/DJLaQ0MRzEPuD4Tsfqnva5R5lJnipbhObpWIB7tPkbPo7czTXAgOTOr29xL
         UMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771890227; x=1772495027;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Nz0fZa7S09a21wJlX7cSiDYFAmJR+w6WbxCWC6v114=;
        b=HH/jNKxoF1KMDP+Nt9Y7KnXDdzlvEvdYUJDqc4KBK4Jw37FQO0tkvPDjCIaQK9/CvV
         /kYXFRPXeRAZLB9uvmcCScf5+OGzWq9mk2cm3F9hTepFtXCi1o7ZrVAdrlQgaNBcS+ni
         LAwL+byTA2tjVmDw2fMS2p5W96ap7uPDzKFPJ1sDhrtmNkT/JGRLWO6i+3h8dZUAAmfx
         g67/7MaMlaKkq/7EkZ2oIWMt8Lm0/TUbEUXrXYMEqQN+8LYsS8VdVkzCmnjBEWy+rSDv
         CGKs0f/xJXMYJi4htq3fswpogywsbyoJNoL5Gqz0avuOqQVS9t7dr/x+TyqpacSMdGU5
         u7dw==
X-Forwarded-Encrypted: i=1; AJvYcCUJVP0ctMUxzLHxgGp961Sriu/bJlnbju4bjC1d/TpbB5mTZstK5YYerIhVTHDGDmA0ex0SIQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzR/W04We+ArVNUgwk8c3VlmqftikjKFKk0whw+iJgGZRDXczxA
	95IAc+HeBun8YLrwn+j+Z9TJhGQhgqdA2Lcw3MDSQyHbhcusrrGQj1AzeFgG+4a4kw==
X-Gm-Gg: ATEYQzwwUCfY7vocQ+H8mNop1bg+AgURB0Slx+hwPLuFUbrFzkcvOYCk2J50Dp1RLbv
	utQ0UDvcsxj2njur08IlTWquRspNfLCnjOWVlK0CLDs1gwpwhfcmBaZtcThupgOG5GTAPcn0602
	k+kKlxAxW7WmNtaTzfWranyFZFKdru6e/OFdq01ZV7sBb3ogtJZflA6CDTStJ5XWXWlq9vR5MdP
	6v8HSrLSyBA+TgMYGNnNzsKjwDfjlXOm/CarXI0DtqhVSeTRaHgoh1VNI0BLn89RdF3HqXXgKbc
	8zaOsdG1eoSJWNdSpbpHoFHXRyv31Ecx+MhyCmVriNlPdmRtUKepSr5Pe3pi7IcPL8F6rKIilp3
	X13OiIWljkd0qUXhEUyr3izXPZjQOsXAOrSveSzMWT/vb4zOeLCHn8Yg4hykTEWbpUN6ow3oGQM
	rUiwzz28JH3pS250jPJLaeku8cb89qXAZjFj6EEHasV/iqZ/8yiF89ClYtsw0VAw==
X-Received: by 2002:a17:903:41c3:b0:271:9873:80d9 with SMTP id d9443c01a7336-2ada3483c30mr271955ad.7.1771890226940;
        Mon, 23 Feb 2026 15:43:46 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7500e1c0sm90833575ad.45.2026.02.23.15.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 15:43:46 -0800 (PST)
Date: Mon, 23 Feb 2026 23:43:42 +0000
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
Subject: Re: [PATCH v2 02/22] PCI: Add API to track PCI devices preserved
 across Live Update
Message-ID: <574e4wq43zm5tyfvvtjfvzqlhoyijcgvvk7gptghrx3ofq5ck2@l2q7xbmtibbq>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-3-dmatlack@google.com>
 <4mbhcmimhin2ulz57mbzpe5p5dkhfziiyep5k3vgls4zmom3sb@g6jlouyvmpuz>
 <CALzav=eXY=ZBshmpi9axt+_0SxaAm0Xbo7w==nCWJwKK3xcThw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=eXY=ZBshmpi9axt+_0SxaAm0Xbo7w==nCWJwKK3xcThw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260223_154348_542358_13499AB6 
X-CRM114-Status: GOOD (  21.83  )
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

On Mon, Feb 23, 2026 at 03:08:19PM -0800, David Matlack wrote:
>On Mon, Feb 23, 2026 at 2:04 PM Samiullah Khawaja <skhawaja@google.com> wrote:
>> On Thu, Jan 29, 2026 at 09:24:49PM +0000, David Matlack wrote:
>
>> >Drivers can notify the PCI subsystem whenever a device is preserved and
>> >unpreserved with the following APIs:
>> >
>> >  pci_liveupdate_outgoing_preserve(pci_dev)
>> >  pci_liveupdate_outgoing_unpreserve(pci_dev)
>>
>> nit: Preserve and Unpreserve can only be done from outgoing kernel, maybe
>> remove the "outgoing" from the function name.
>
>That's reasonable, I can make that change in v3.

I should have added it earlier, but the same applies to the
pci_liveupdate_incoming_finish() as it can only be done with incoming
kernel. Maybe we can remove incoming from it also for consistency?
>
>> >+static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
>> >+{
>> >+      struct pci_dev *dev = NULL;
>> >+      int max_nr_devices = 0;
>> >+      struct pci_ser *ser;
>> >+      unsigned long size;
>> >+
>> >+      for_each_pci_dev(dev)
>> >+              max_nr_devices++;
>>
>> This will not work for SRIOV as new devices will be registered when
>> sriov is enabled and the max will increase. As we are not handling VFs
>> with this patch series, this can be fine?
>
>That's right. Since this series does not support VFs
>(pci_liveupdate_outgoing_preserve(VF) will return -EINVAL), I dropped
>the logic from v1 that included the maximum possible number of VFs in
>max_nr_devices.
>
>Once we add support for preserving VFs, we can update this logic.
>
>Another way that pci_liveupdate_outgoing_preserve() could fail due to
>running out of room is if hot-plugged devices are preserved. But I
>don't think that's an important problem to solve right now.

