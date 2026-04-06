Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDF9F46C69
	for <kexec@archiver.kernel.org>; Mon,  6 Apr 2026 18:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=85/sv/Jd+nnLebgu7yOJ82/6JMUXxVcSgRKO3WW/KJM=; b=tpRHoF6yea485rAIAa7y/anA6l
	rM+w1mOnskZiZ+ebFOxER99kExRQq8ilEx8ZR7F1HdNgXY+A4vqgkai26whmxOUzm1p35RNXaqq9+
	FjSCHqxgUesHMWXfaBJdmDFRpKWsDbmVco7Z0D/gqoQstT0GLqGDiUz5bDGP67H0Kr6Ki70Ww5BS4
	b3K9GTKcwfc5dD6ZXgqs0pEmtfPz+J/+G02/3zPFkW7Yaa7ysXjceHmnPQg+Ao4j5ni7VVT9LC0SH
	+XM9ok1aIn6jPKJmcMt8ZKllewebmQB/+k9DYDapOUZ113Yi6s5q2vSMWYSKUWdG3t/BEj4E2ovvl
	pDX/8qAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9oPB-00000005Nq4-0vEo;
	Mon, 06 Apr 2026 18:10:33 +0000
Received: from out-177.mta1.migadu.com ([95.215.58.177])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9oP5-00000005NoO-2NIX
	for kexec@lists.infradead.org;
	Mon, 06 Apr 2026 18:10:29 +0000
Message-ID: <1c5fd907-f610-48e4-89cc-4040aaef2674@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775498991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=85/sv/Jd+nnLebgu7yOJ82/6JMUXxVcSgRKO3WW/KJM=;
	b=HrKy4i01v27KUFcXt/1w2kf+yZsl5MXCFBmMdpuBla2c4B2kFG8UdHSH93UsEojRTPjWIJ
	RVbUZS7qtBOUTvf1Fe92L2hJ6/CpkB4KYvevqVhozqjWCBottlm/LzMr5DomESqDJznrrj
	NsvzlhYZFx9aBwmc2y/0M9aHDJw9o8k=
Date: Mon, 6 Apr 2026 11:09:37 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v3 02/24] PCI: Add API to track PCI devices preserved
 across Live Update
To: David Matlack <dmatlack@google.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Adithya Jayachandran <ajayachandra@nvidia.com>,
 Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
 Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal
 <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
 Askar Safin <safinaskar@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 David Rientjes <rientjes@google.com>, Feng Tang
 <feng.tang@linux.alibaba.com>, Jacob Pan <jacob.pan@linux.microsoft.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
 Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
 kexec@lists.infradead.org, kvm@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, Li RongQing <lirongqing@baidu.com>,
 Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>,
 =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Pranjal Shrivastava <praan@google.com>, Pratyush Yadav
 <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>,
 Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>
References: <20260323235817.1960573-1-dmatlack@google.com>
 <20260323235817.1960573-3-dmatlack@google.com>
 <e3fe7085-1297-47b8-bb17-a48196e8f37f@linux.dev>
 <CALzav=eyf4XRTi8MfE_GBNSm+tjmfX7=d0M8Aj5Hh0vJn7huew@mail.gmail.com>
 <c4138f66-edf2-4689-b5fe-16dc4839e9c3@linux.dev>
 <CALzav=ei_xSfM0MTdPFhGDjNwe3EQ0vHPiEk=vszFX-Xi_KjQw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <CALzav=ei_xSfM0MTdPFhGDjNwe3EQ0vHPiEk=vszFX-Xi_KjQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260406_111027_760421_53C547AB 
X-CRM114-Status: GOOD (  14.93  )
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


On 4/6/26 9:06 AM, David Matlack wrote:
> On Sun, Apr 5, 2026 at 9:56 AM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>> 在 2026/4/3 14:58, David Matlack 写道:
>>> On Thu, Apr 2, 2026 at 2:29 PM Yanjun.Zhu <yanjun.zhu@linux.dev> wrote:
>>>> On 3/23/26 4:57 PM, David Matlack wrote:
>>>>> +config PCI_LIVEUPDATE
>>>>> +     bool "PCI Live Update Support (EXPERIMENTAL)"
>>>>> +     depends on PCI && LIVEUPDATE
>>>>> +     help
>>>>> +       Support for preserving PCI devices across a Live Update. This option
>>>>> +       should only be enabled by developers working on implementing this
>>>>> +       support. Once enough support as landed in the kernel, this option
>>>>> +       will no longer be marked EXPERIMENTAL.
>>>>> +
>>>>> +       If unsure, say N.
>>>> Currently, it only supports 'n' or 'y'. Is it possible to add 'm'
>>>> (modular support)?
>>>>
>>>> This would allow the feature to be built as a kernel module. For
>>>> development
>>>>
>>>> purposes, modularization means we only need to recompile a single module
>>>>
>>>> for testing, rather than rebuilding the entire kernel. Compiling a
>>>> module should
>>>>
>>>> be significantly faster than a full kernel build.
>>> I don't think it is possible for CONFIG_PCI_LIVEUPDATE to support 'm'.
>>> pci_setup_device() (which is under CONFIG_PCI) needs to call
>>> pci_liveupdate_setup_device(), and CONFIG_PCI cannot be built as a
>>> module. This call is necessary so the PCI core knows whether a device
>>> being enumerated was preserved across a previous Live Update.
>> After the following changes, the liveupdate.ko can be generated
>> successfully.
> Sure but you've broken the feature. Now devices can be probed before
> liveupdate.ko is loaded and the PCI core will have an incorrect view

 From this perspective, I think it makes sense.

Zhu Yanjun

> of which devices were preserved by the previous kernel.

