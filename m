Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A027CE8B37E
	for <kexec@archiver.kernel.org>; Wed,  4 Feb 2026 00:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zPnG+2FnaGlQfzxXfIjWuGajlOFPpBxdoaiBCLVKvoU=; b=VLj9mYtA4EV5UCd0gOpp6cpheP
	4nhMqV3HmQMuXIk/x0cQzbc/cNv71RDQoqWi9ZN0lOFLL71KMHfEu9QWaMwbeGhmF/0tciaUJA6b/
	kw7N6j3n2tDX7U59UROssLcvEbQiX3grSm/V1Ey2i9tXq0qwTSFeZ0iS0tntRbcgGT2rWpDoyMRfT
	LvjXvcY29K0XM0rPNKc+kjRlk7Cdt7aSnE6rhTgmaAIsMV0bmyDajpNbyg9wOL4RhNM3wrLDoXyHN
	5880xGfiFPviTci1CjxxTTfcqCvZP6fT3pnIHtfctDuDxZVhmot0G3XMr+wdIT5QUKor9SrjDaqe9
	nYczDzvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnQTT-00000007c6o-2WlO;
	Wed, 04 Feb 2026 00:10:27 +0000
Received: from out-181.mta0.migadu.com ([2001:41d0:1004:224b::b5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnQTO-00000007c5g-48mg
	for kexec@lists.infradead.org;
	Wed, 04 Feb 2026 00:10:25 +0000
Message-ID: <7e49472c-4bbc-49fe-92c6-621e4675d882@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770163814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPnG+2FnaGlQfzxXfIjWuGajlOFPpBxdoaiBCLVKvoU=;
	b=ApRMKyWeexGTzglygbcOHhU7Wfd4rnLeiMI+Jogeatu2nhRqIkK0lA//+bUOV3vFAbHCoJ
	mS0BsrYP93R9bxyxRU1fhniBcUvx2p4NhTCXzAkUT0zL/EyR+YUdOmdiWZC6zP6HhDzLGT
	UyQfu6GTd6zJWiBQ6KJq5hvzWsaEowg=
Date: Tue, 3 Feb 2026 16:10:04 -0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 02/22] PCI: Add API to track PCI devices preserved
 across Live Update
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
 Adithya Jayachandran <ajayachandra@nvidia.com>,
 Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
 Alistair Popple <apopple@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal
 <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>,
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>,
 Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>,
 kexec@lists.infradead.org, kvm@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
 =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pranjal Shrivastava <praan@google.com>, Pratyush Yadav
 <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Samiullah Khawaja <skhawaja@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-3-dmatlack@google.com>
 <44484594-5b5d-4237-993c-ac1e173ad62e@linux.dev>
 <CALzav=d1ZrHrWd-HhZJ8aY6aqxkBcLoet_5+-LL1mOakVTj6Ww@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <CALzav=d1ZrHrWd-HhZJ8aY6aqxkBcLoet_5+-LL1mOakVTj6Ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_161023_315710_6DC5F247 
X-CRM114-Status: GOOD (  18.51  )
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


On 2/2/26 10:14 AM, David Matlack wrote:
> On Sat, Jan 31, 2026 at 10:38 PM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>> 在 2026/1/29 13:24, David Matlack 写道:
>>> Add an API to enable the PCI subsystem to track all devices that are
>>> preserved across a Live Update, including both incoming devices (passed
>>> from the previous kernel) and outgoing devices (passed to the next
>>> kernel).
>>>
>>> Use PCI segment number and BDF to keep track of devices across Live
>>> Update. This means the kernel must keep both identifiers constant across
>>> a Live Update for any preserved device. VFs are not supported for now,
>>> since that requires preserving SR-IOV state on the device to ensure the
>>> same number of VFs appear after kexec and with the same BDFs.
>>>
>>> Drivers that preserve devices across Live Update can now register their
>>> struct liveupdate_file_handler with the PCI subsystem so that the PCI
>>> subsystem can allocate and manage File-Lifecycle-Bound (FLB) global data
>>> to track the list of incoming and outgoing preserved devices.
>>>
>>>     pci_liveupdate_register_fh(driver_fh)
>>>     pci_liveupdate_unregister_fh(driver_fh)
>> Can the above 2 functions support the virtual devices? For example,
>> bonding, veth, iSWAP and RXE.
>>
>> These virtual devices do not have BDF. As such, I am not sure if your
>> patches take these virtual devices in to account.
> No this patch series only supports PCI devices, since those are the
> only devices so far we've needed to support.
>
> I am not familiar with any of the devices that you mentioned. If they
> are virtual then does that mean it's all just software? In that case I
> would be curious to know what problem is solved by preserving them in
> the kernel, vs. tearing them down and rebuilding them across a Live
> Udpate.

Bonding, veth, rxe, and siw can be used in KVM environments.

Although these are software-only virtual devices with no associated 
hardware,

they may maintain state that is observable by userspace.

As a result, Live Update should preserve their state across the update.

Zhu Yanjun


