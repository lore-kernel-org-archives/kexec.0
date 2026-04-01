Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084CB10F6FA5
	for <kexec@archiver.kernel.org>; Wed,  1 Apr 2026 14:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8h0ChXywYOozRzlTLLnCXSm74OrmWHjAXIktN37FNBA=; b=cnfm8/25OlaOr/m0+sDNt/SeSC
	pKtVykMNl1jEr4z4yFdIWsyW0JagQnG1EMqPQzCz3FaCgrqpmDv9pcl55DbzIMB7sNdZ9Ztip/bqS
	RemyaH4DkujV3BHMcODPOhVh3YUejL2zkuz30xdJpV2xt6opdZmZoYsANz7FGSMbXnniCruvQIUJM
	cmR0aNfsbVWESvB326D+LvIU1kMHhuR0h9Yic3dyZkw28JPQ51E+T6cmMGNQ+R4fhRG9CCebOtAEU
	UqubAolc/QSabbxcE8zPXh4sMY333/mfOIRCXxAJryDXVFWxayqFkQBHEMVGxxutKd0Juj1KX8KDY
	+2OqWuKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7wgj-0000000FVY6-3Z08;
	Wed, 01 Apr 2026 14:36:57 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7wgh-0000000FVXi-0T5l
	for kexec@lists.infradead.org;
	Wed, 01 Apr 2026 14:36:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4757640ADF;
	Wed,  1 Apr 2026 14:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA7AC4CEF7;
	Wed,  1 Apr 2026 14:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775054214;
	bh=RihWe9fQIxmIgwDhwcNSbhkpSL03nKNn1qbJPB0J2+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Mh1uVFU6JNai1F9LdjWZbPPl7KJBJc8d/UReYXUGnDCRuxJaxSzbVyb7uI1yVk0eY
	 z4tCaC1+/jcFn4w7FOqjQ5BcWgrcLvdBZQzSVhYpDx26G+zrVLqFu14gCt8nS+Vi5h
	 Ifn3lWC0ydfzvZHrDwRLhJVy/vnguhYMQZ6l43sez2ujouO57nd14+jJqIsNMuLjTZ
	 qsftSArXs+pzZFPBoUFoOUWsuqKUAjQ/4tInVAjNM80oBXZLDQZQZZu14Wg+LXTNBF
	 ChHo0rv201AbzjEGvwdUL3WGHrR1zPBnYNTp0o7SujROuhxgfybL+8NoXMIyzSXYsG
	 8x5XQRwJKsnHA==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>,  Adithya Jayachandran
 <ajayachandra@nvidia.com>,  Alexander Graf <graf@amazon.com>,  Alex Mastro
 <amastro@fb.com>,  Alistair Popple <apopple@nvidia.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Ankit Agrawal <ankita@nvidia.com>,  Bjorn
 Helgaas <bhelgaas@google.com>,  Chris Li <chrisl@kernel.org>,  David
 Rientjes <rientjes@google.com>,  Jacob Pan
 <jacob.pan@linux.microsoft.com>,  Jason Gunthorpe <jgg@nvidia.com>,  Jason
 Gunthorpe <jgg@ziepe.ca>,  Jonathan Corbet <corbet@lwn.net>,  Josh Hilke
 <jrhilke@google.com>,  Kevin Tian <kevin.tian@intel.com>,
  kexec@lists.infradead.org,  kvm@vger.kernel.org,  Leon Romanovsky
 <leon@kernel.org>,  Leon Romanovsky <leonro@nvidia.com>,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,
  linux-pci@vger.kernel.org,  Lukas Wunner <lukas@wunner.de>,  =?utf-8?Q?M?=
 =?utf-8?Q?icha=C5=82?=
 Winiarski <michal.winiarski@intel.com>,  Mike Rapoport <rppt@kernel.org>,
  Parav Pandit <parav@nvidia.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pranjal Shrivastava <praan@google.com>,
  Pratyush Yadav <pratyush@kernel.org>,  Raghavendra Rao Ananta
 <rananta@google.com>,  Rodrigo Vivi <rodrigo.vivi@intel.com>,  Saeed
 Mahameed <saeedm@nvidia.com>,  Samiullah Khawaja <skhawaja@google.com>,
  Shuah Khan <skhan@linuxfoundation.org>,  Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>,  Tomita Moeko <tomitamoeko@gmail.com>,
  Vipin Sharma <vipinsh@google.com>,  Vivek Kasireddy
 <vivek.kasireddy@intel.com>,  William Tu <witu@nvidia.com>,  Yi Liu
 <yi.l.liu@intel.com>,  Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 06/22] vfio/pci: Retrieve preserved device files
 after Live Update
In-Reply-To: <aaDZ-ffs4kiUo3GY@google.com> (David Matlack's message of "Thu,
	26 Feb 2026 23:40:41 +0000")
References: <20260129212510.967611-1-dmatlack@google.com>
	<20260129212510.967611-7-dmatlack@google.com>
	<20260226155222.5452a741@shazbot.org> <aaDZ-ffs4kiUo3GY@google.com>
Date: Wed, 01 Apr 2026 14:36:44 +0000
Message-ID: <2vxzjyuqhhmr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_073655_189798_7374F4B4 
X-CRM114-Status: GOOD (  18.99  )
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

On Thu, Feb 26 2026, David Matlack wrote:

> On 2026-02-26 03:52 PM, Alex Williamson wrote:
>> On Thu, 29 Jan 2026 21:24:53 +0000 David Matlack <dmatlack@google.com> wrote:
>
>> > diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
>> > index 8ceca24ac136..935f84a35875 100644
>> > --- a/drivers/vfio/device_cdev.c
>> > +++ b/drivers/vfio/device_cdev.c
>> > @@ -52,6 +46,19 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
>> >  	vfio_device_put_registration(device);
>> >  	return ret;
>> >  }
>> > +EXPORT_SYMBOL_GPL(__vfio_device_fops_cdev_open);
>> 
>> I really dislike that we're exporting the underscore variant, which
>> implies it's an internal function that the caller should understand the
>> constraints, without outlining any constraints.
>> 
>> I'm not sure what a good alternative is.  We can drop fops since this
>> isn't called from file_operations.  Maybe vfio_device_cdev_open_file().
>
> Ack. Due to the bug you pointed out below, I think the changes in this
> file will look fairly different in the next version. But no matter what
> I'll avoid exporting a underscore variant without outlining the
> constraints.

I haven't yet had a chance to read v3 so maybe you already solved this
problem. But I dealt with some similar problems for the memfd patches
[0] and the hugetlb patches [1]. What I did was to just use/add a
internal header (mm/internal.h or mm/hugetlb_internal.h). This lets you
share functions within your subsystem but avoid exporting everywhere
else.

I see that there already is drivers/vfio/vfio.h so perhaps you can use
that to avoid exporting these functions outside the subsystem?

[0] https://git.kernel.org/torvalds/c/ed6f45f81bf9
[1] https://lore.kernel.org/linux-mm/20251206230222.853493-6-pratyush@kernel.org/

[...]

-- 
Regards,
Pratyush Yadav

