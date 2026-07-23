Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011D8C531CC
	for <kexec@archiver.kernel.org>; Thu, 23 Jul 2026 22:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G0SzsDUN/BFXoWvc6OI68QQ0aGQFC3X7Tv8gtb7Mzg8=; b=YeD3CasdyLZCaZgedlj6uMk9bI
	LADoTxOHg30XNAQmiu5HKFnSjoFg6kbaxywSm/ByYl+UolrVIu7hZwjHcjxX+662REbiMTjyJYWZl
	nBYisq5ihP8M4Z8Rg8qWNbwa68TRj+dWxVa0wFwym7oUeIz9pn4+fErHo9yUc5IWqWeOuwBMQzvky
	kkvSls8HFOy3vm4NdK4BtI8fGW+6nNTKdMfRvFpLgT3vabU30BiC6XjJUL2PObhUiKbG5xN+MmC4e
	IuHUVznotehJlDrzdr2hNVB6jbwIKZA3BDMKiY3zha4mrpCfkVSkR+BwUsLfFvc5AcSJkmSZJSGGL
	b7/Ke+qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn1l6-0000000FC5C-2vrF;
	Thu, 23 Jul 2026 22:19:16 +0000
Received: from out-181.mta0.migadu.com ([2001:41d0:1004:224b::b5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn1l2-0000000FC4f-3uVx
	for kexec@lists.infradead.org;
	Thu, 23 Jul 2026 22:19:15 +0000
Message-ID: <cebd1045-5dd7-4f35-8750-9c39790ceae9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784845145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0SzsDUN/BFXoWvc6OI68QQ0aGQFC3X7Tv8gtb7Mzg8=;
	b=o1hEm5gqbSFXjNQ4yIfcWqVF8F2VgF7agEYdG4EH8wmp+G1vDgDZuukjZsNrRRZEMTLDn8
	e2RghIzHx5oniMfYsrV4kpaicQc52zsfUQFC/Lj9EgU93DFRi4xAAwgenWevULM+oLxJIs
	Z9M3QnjiLFjyIalbt7oDxrbrLyVCbiY=
Date: Thu, 23 Jul 2026 15:18:55 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v5 00/20] vfio/pci: Base Live Update support for VFIO
To: Vipin Sharma <vipinsh@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, ajayachandra@nvidia.com, alex@shazbot.org,
 amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com,
 chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net,
 dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com,
 jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com,
 kees@kernel.org, kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com,
 lukas@wunner.de, mattev@meta.com, michal.winiarski@intel.com,
 parav@nvidia.com, pasha.tatashin@soleen.com, praan@google.com,
 pratyush@kernel.org, rananta@google.com, rientjes@google.com,
 rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com,
 schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com,
 vivek.kasireddy@intel.com, witu@nvidia.com, yi.l.liu@intel.com
References: <20260714151505.3466855-1-vipinsh@google.com>
 <2c03ac97-60a6-4352-a942-27dcebae8d22@linux.dev>
 <8fd94fad-e457-4839-9e41-ae257a138bee@linux.dev>
 <20260720163452.GC1191959.vipinsh@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260720163452.GC1191959.vipinsh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_151913_615668_E24BFA49 
X-CRM114-Status: GOOD (  26.63  )
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


On 7/20/26 10:08 AM, Vipin Sharma wrote:
> On Thu, Jul 16, 2026 at 06:22:07PM -0700, Yanjun.Zhu wrote:
>> On 7/16/26 4:24 PM, Yanjun.Zhu wrote:
>>>
>>> On 7/14/26 8:14 AM, Vipin Sharma wrote:
>>>> Testing
>>>> -------
>>>>
>>>> Tested using VFIO Live Update selftests in both QEMU and bare-metal
>>>> environment (Intel DSA PCIe device).
>>> I want to make tests VFIO Live Update selftests in QEMU. But how to
>>> select a PCIe device?
>>>
>>> what device do the PCI ID 0000:00:04.0 and 0000:6a:01.0 mean in the
>>> following testcase?
> Sorry, this was my copy-paste mistake when combining things from both
> qemu and baremetal. You only need one device not two separate ones.
>
> For testing using QEMU, you can use QEMU PCI test device.
>
>    -device pci-testdev
>
> In VM, use `lspci` command to find the BDF of the PCI device. It will show
> output like:
>
>    00:04.0 Unclassified device [00ff]: Red Hat, Inc. QEMU PCI Test Device
>
> Then prefix the domain (generally, 0000) to the BDF and use the testing
> commands.
>
> `0000:6a:01.0` was the BDF of the Intel DSA device on my host. I
> incorrectly mixed two devices during my copy-paste.
>
> Limitation of qemu pci-testdev is that it does not have the DMA
> capability. I used physical host with Intel DSA to verify that the
> device performing DMA during live update gets reset.
>
>> In my qemu,
>>
>> 00:04.0 System peripheral: InnoTek Systemberatung GmbH VirtualBox Guest
>> Service
>>      Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>      Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
>> <MAbort- >SERR- <PERR- INTx-
>>      Interrupt: pin A routed to IRQ 20
>>      Region 0: I/O ports at d040 [size=32]
>>      Region 1: Memory at f0400000 (32-bit, non-prefetchable) [size=4M]
>>      Region 2: Memory at f0800000 (32-bit, prefetchable) [size=16K]
>>      Kernel driver in use: vboxguest
>>      Kernel modules: vboxguest
>>
>> I am wondering if the above pci device can work well with this patch set or
>> not.
> I think you should be able to test Live Update with any PCI device which
> can be attached vfio-pci driver.
>
> `vfio_pci_liveupdate_kexec_test` will initiate DMA if the VFIO selftest
> framework has the driver for the passed device (Intel DSA) otherwise it
> will just skip over the DMA flow and do the remaining things.

Thanks a lot. I'll run some tests with QEMU's `pci-testdev`.

If I understand correctly, when using `pci-testdev`, only the DMA test 
case is expected not to work, while all the other test cases should work 
correctly.

Yanjun.Zhu

>
> Let me know if you still face some issue in running Live Update, I will
> be happy to provide more details.
>
> Thanks
> Vipin

