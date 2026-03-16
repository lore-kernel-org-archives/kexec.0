Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D112FF53D7E
	for <kexec@archiver.kernel.org>; Mon, 16 Mar 2026 18:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hacBXTanIx+HGRz6G551slI/wF3dk8INyCTw5fzLvmE=; b=ZqDmEPV94Qlzeu6HcEgJIOzzFg
	WZdwjfkJ21lFFSEvT7aYagEa8IxOhwWKp8cDcRrdQCwZ4meshSinGfzq/hAxVvRv/GPxX6bEjQ0Me
	zKgNNT071OoRZIZ9cm9i8sH+2/aipycUGlVxpX3pj4YqKI5A4nQYwjM4vCtKYkT3YJ/E15zW2p9Kq
	Adw/oqpC2JCylzJiZZ2e7fxy1R0mEV+7bhozE0TqjPCSbqivrpxrz+Ys+e6d6WNLGzNl7ii9Uv0cx
	WJZzpGykbx+5XWtLrOOSdOqtnk+XCLB78QiXEzjuJdeclG8xXWjksplXKMNv6nnP7hcNfOCrEGECA
	A/jyLx7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2CQ1-00000004f2U-0XVP;
	Mon, 16 Mar 2026 18:11:57 +0000
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2CPx-00000004f1t-3Nit
	for kexec@lists.infradead.org;
	Mon, 16 Mar 2026 18:11:55 +0000
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5a12cd0bd79so6220840e87.2
        for <kexec@lists.infradead.org>; Mon, 16 Mar 2026 11:11:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773684712; cv=none;
        d=google.com; s=arc-20240605;
        b=cEH/SBJz/iU5ZZeDyqZ40reKAInJGlMZf5kZc0qQvcZ+8qcRqV3Z1T3CP5Wvj1ZxQs
         6cLI0nuX8pYDyuqWV1kZOOCvPvlpBHkL4yK4fDKPOMMnUULDzMtM1tVCZ5JpJmBGTk6U
         BSN+BNs1GaWEhNrKpgR4wwZrsHex9zNmOfCuHT4nZoo9UwI+EdzDu0bojIzpojA1220u
         XZFASLwMGUQvC7ncyqX0jlEDyooWNfZwS3ffX1w33P3tBgX1SeF0nSaRn1wvPqpCZnXs
         3MSgk4EXixiXUKViGQxSJyDBH36ELhA6N49d1cReVJDqWR0JvDqZVzUClBtn1g3bJUUp
         3ULg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hacBXTanIx+HGRz6G551slI/wF3dk8INyCTw5fzLvmE=;
        fh=WBth9PW+mxat1vPF1bSWKABRz5yzUy23QKm8qhZKGyE=;
        b=B74aAGdLYH1LKSL/87hpG4u+zeXOeNY/Ocy79XDw/3f4db7Cl0T8oB8CeTL4yr9zjV
         fbsvEvc0/AXKJvBB5rkyr9mEXC2JFW81XzI3l1FF251/FvQmmtN+XhHdJgEbFgQbRDSB
         E0r8154i73/o05FwzZ7Id+CrdX4SqxElTPXKay6f/gUjzePo0Qv2xCDrqj9LXQIvURjC
         navVDnGKd49V9prPY+FlZ8QwhpTBb32HkWaPUU60c7x6+Mk9M7nll2UFUQ00elLTgmId
         uh+q9ukWyWSxOzaMKYRBdGbGB7wqmAKf9+3Kmwbf79uddt7Jqrrj/XQALyuR0Is/DVh8
         3o+Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773684712; x=1774289512; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hacBXTanIx+HGRz6G551slI/wF3dk8INyCTw5fzLvmE=;
        b=BmTsrh9QAlRUIzJIz+1NHczlyKfsXjB8SFRRpfsvokDCpc/Njv6+w+a+vu/NQ+C1FD
         6JS+oyIB+yZqdDoVdpHweuAyz2oUlRMggBmXmOvvGew+dtRzE22w/4OZWGVmSnTDGSZF
         GGfd7xOfU/pKh1JwtQynkrxBi9PkQkB4n4xfVvMGY6z5K5Mf1W/rsw2cDbnvHIfxbzfg
         chAjgXUpazwsHiViUwb2bgpalaAxZIGnVVMYaUileTi36hUpnmnhKFuJ+wjk/1e7cMFR
         zamoKgQrIkpD29mAvRVy+8pUzpupNekAMSzFEvnAFvFmN5ewVL8USxLqFqBC90HMayd1
         DMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773684712; x=1774289512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hacBXTanIx+HGRz6G551slI/wF3dk8INyCTw5fzLvmE=;
        b=eHnTpnXeMXjYsTLQt6EuNC1DFKDHJm6Na73c8kSf4W4VwFcOnYgRHjh3WMLEXlbe6w
         O7nJmzdTjArYcCsq+N7sl+91rZDsqc2nq04TVO9tyoDNMs+BfAcmlCjlRK53e9PRkBgu
         kXYefMJpNvgZhV/A3tLbTr7VhT6aLUBm7ho4pC3Oal2++bGd/ORqBThWqFAkDJFONQvZ
         X3pXQ60q2G7zI4Cy+q3bL4LFClWKYHdLvhXJT6s0mI16039EEK61szDWk/yqtAdTFJ4g
         OaN5HYh8s+kjUREmG/THkwQAUxoGB87hubQBsrXPMKw8TcMYeCLpvffB2MsXj/dWk7vB
         5mvA==
X-Forwarded-Encrypted: i=1; AJvYcCVmPlQo3MN4Laga8zeXddzT7zpvy6naudo8hCIQDBK1UoqaGYjmtgldWHfjjUQZtE9f7Npmww==@lists.infradead.org
X-Gm-Message-State: AOJu0YzfwV+ke5ezv3TVLNkR+JyLZQ/ebil2W7qyzKYF73brfZanBw7j
	gF5aQIB8wr2k3HnGfazW5ZiWUJAxi5DGXjWE4OVT4Y0Cid8dCT9K+9kHEMc3rse50DILoVtxzgB
	f77FEjoy2bXvmd4BF17vMkqINxqTFF3pq44wW1E5Z
X-Gm-Gg: ATEYQzwInp5addCwKUWZWBNb/mx5tiphzLf3inIlJt9w+Y/KPv7d+3YkrnCH7w3ULY7
	PXuj0PGVGRAx5HonJRAnCK4+zZdVQtVLFqFTyhl+O4PPdDHQRnFL/0CwhesYAwYXd7S3mCVz0hH
	Y/TClZtAMRFu7yTyznnzs5HGvxQJG8XxinPq1PHmJF5eq0AXPDTRlFtxolzD9AFKIcpYSXFxcT0
	+aHJsf8zNTNkHGMnLOkFm2bTnhhCt8SYg3VHB+VBepCZXTH0cljRpLGea5NlxoO/MS/gPaz4UpL
	KWt6r46A
X-Received: by 2002:a05:6512:24db:b0:5a1:44d3:7601 with SMTP id
 2adb3069b0e04-5a162afb717mr3098120e87.20.1773684710999; Mon, 16 Mar 2026
 11:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-11-dmatlack@google.com>
 <20260226170030.5a938c74@shazbot.org> <aaDqhjdLyf1qSTSh@google.com>
 <20260227084658.3767d801@shazbot.org> <CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
 <20260227105720.522ca97f@shazbot.org> <CALzav=fjRPa_ZbXu7iFXyemcf_8Kq_dZTWT6c-A0bc6czF_Rdw@mail.gmail.com>
 <abNOwcOTXqxCxNzt@google.com> <20260313083918.00005731@linux.microsoft.com>
In-Reply-To: <20260313083918.00005731@linux.microsoft.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 16 Mar 2026 11:11:20 -0700
X-Gm-Features: AaiRm52c977M5CVgCJmgqL9NIwQ1v_KtuafdRnOMJexlLUpZndu_UH9phsJ7tcA
Message-ID: <CALzav=eGLpo5nrsHq5L8bUTC=FWZ-SgrTE1FoScrWB4p+NDgnA@mail.gmail.com>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_111153_931346_FD1CC23C 
X-CRM114-Status: GOOD (  18.86  )
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

On Fri, Mar 13, 2026 at 8:39=E2=80=AFAM Jacob Pan <jacob.pan@linux.microsof=
t.com> wrote:
> On Thu, 12 Mar 2026 23:39:45 +0000
> David Matlack <dmatlack@google.com> wrote:

> > +config VFIO_PCI_LIVEUPDATE
> > +       bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> > +       depends on LIVEUPDATE && VFIO_PCI
> > +       help
> > +         Support for preserving devices bound to vfio-pci across a
> > Live
> > +         Update. The eventual goal is that preserved devices can run
> > +         uninterrupted during a Live Update, including DMA to
> > preserved
> > +         memory buffers and P2P. However there are many steps still
> > needed to
> > +         achieve this, including:
> > +
> > +          - Preservation of iommufd files
> > +          - Preservation of IOMMU driver state
> In the interim, what do you think about moving forward with noiommu
> mode without preserving IOMMU driver state?

I haven't gotten a chance to look at your noiommu patches yet, but I
do think noiommu will probably be a good way to develop the VFIO and
PCI support for Live Update without blocking on IOMMU driver support.

> I=E2=80=99ve tested your
> vfio_pci_liveupdate_kexec_test with the noiommu cdev, and it works as
> expected.

Would you be able to send patches to add noiommu support to VFIO
selftests? That would be very helpful toward allowing us to develop
and test Live Update support with noiommu.

