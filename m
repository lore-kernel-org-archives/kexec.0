Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E62E668AF
	for <kexec@archiver.kernel.org>; Sat, 20 Dec 2025 03:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l+49Rimbg5lu33r/DaYgbOd2mhN16SETdATd5FhkZFI=; b=BTUQ/HsaCH/pJF9kKfa60JiAaF
	kn8D5+4Hn/DBMA8PBVRBMcXVKWBZe4xnUXzuz2XzEDZsTTXRjP9F/0qfHBUJTSPQxUr33fffspTbD
	L/lBTeqNlVb+ZGVVwj5x5eroFWXyTy42G+8eOfk6ogjzpGcEjWmVsBWyrEnWhdg2ZaCwSvVa+4RdK
	WNMVIsaiy0qUMVHpcYeO0Xncpvx0pbWxu73vpQhJ6T+LplV2wB+eq9o5CUhTAEW5xn8VGZ82Xs1BP
	KYUpo/PdfWJ2uKQ3IRof42FAXBU0BO8A3zM7LQjValOYY0qSYX6avW0gwIxTaXRBSCExnS8B4Aq7R
	+CUVzdkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWngB-0000000BFAi-2Vvj;
	Sat, 20 Dec 2025 03:30:51 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWng9-0000000BFAL-0zGX
	for kexec@lists.infradead.org;
	Sat, 20 Dec 2025 03:30:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 20D8C42E4B;
	Sat, 20 Dec 2025 03:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F37DC4CEF5;
	Sat, 20 Dec 2025 03:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766201447;
	bh=iUdJa3ZP1iU0bgE8m+U5BrelPEBq+tJ2Onv6xomprvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gcsrlEDN3DXmkvFdNY57ugc+QQe96QWVElttk9jICytrE5OUc2pgeqZlEes1FtmQS
	 Wq1OdG/EGBrFKpN2szp8TuYPDcvOgRWbL6jYBT0vfF7bKCNjmOaRSgzo2S+rBeJJs1
	 ppYT2+yZdSm0xlqRoXPtLmOVXhrqiGHvIM3ubwvFEVnHLzIyPcqqQ/whTHpGS7KmPV
	 tvvFdvUm6WFf9IqgVnfxxt3kVugGfrcHhfvQ+YB0qY8ZJjIhfsCk0He+SyfvqyhJeh
	 VQXRkZwqG/TFzY1PgHimR1e+wz3BP7JHjM4C1pFfgoIO/1tsW1vEzl8cuExCGIbWh3
	 Go+hvM1CBi66g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Arnd Bergmann <arnd@arndb.de>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Mike Rapoport
 <rppt@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,  Dan
 Carpenter <dan.carpenter@linaro.org>,  Jason Gunthorpe <jgg@nvidia.com>,
  Samiullah Khawaja <skhawaja@google.com>,  David Matlack
 <dmatlack@google.com>,  David Rientjes <rientjes@google.com>,  Jason Miu
 <jasonmiu@google.com>,  <linux-arch@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>,
  <kexec@lists.infradead.org>
Subject: Re: [RFC PATCH] liveupdate: list all file handler versions in
 vmlinux section
In-Reply-To: <aUFdp_fsGCNrFf76@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>
	(Evangelos Petrongonas's message of "Tue, 16 Dec 2025 13:24:55 +0000")
References: <20251211042624.175517-1-pratyush@kernel.org>
	<aUFdp_fsGCNrFf76@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>
Date: Sat, 20 Dec 2025 12:30:40 +0900
Message-ID: <86sed5j0db.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251219_193049_318527_15FD8535 
X-CRM114-Status: GOOD (  34.63  )
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

On Tue, Dec 16 2025, Evangelos Petrongonas wrote:

> On Thu, Dec 11, 2025 at 01:26:22PM +0900 Pratyush Yadav wrote:
>> As live update evolves, there will be a need to update the serialization
>> formats for the different file types. This could be for adding new
>> features, for supporting a change in behaviour, or to fix bugs.
>> 
>> If the current kernel does not understand the same set of versions as
>> the next kernel, live update will inevitably fail. The next kernel will
>> be unable to understand the handed over data and will be unable to
>> restore memory, devices, IOMMU page tables, etc.
>> 
>> List the set of versions the kernel understands in a section in vmlinux.
>> This can then be used by userspace tooling to make sure the set of file
>> descriptors it uses have the same version between both kernels. If there
>> is a mismatch, the tooling can catch this early and abort live update
>> before it is too late.
>> 
>> The versions are listed in a section called ".liveupdate_versions". The
>> section has a header that contains a magic number and the version of the
>> data format. The list of version strings directly follow this header.
>> Only the version strings are listed, and it is up to userspace to map
>> them to file descriptor types.
>> 
>> The format of the section has the same ABI rules as the rest of LUO ABI.
>> 
>> Introduce a LIVEUPDATE_FILE_HANDLER macro that makes it easy to define a
>> file handler while also adding its version string to the right section.
>> 
>> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
>> ---
>> 
>> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>> index e04d56a5332e..a474c9529a5f 100644
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
>> @@ -342,6 +342,17 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
>>  #define THERMAL_TABLE(name)
>>  #endif
>>  
>> +#ifdef CONFIG_LIVEUPDATE
>> +#define LIVEUPDATE_VERSIONS						\
>> +	. = ALIGN(8);							\
>> +	.liveupdate_versions : AT(ADDR(.liveupdate_versions) - LOAD_OFFSET) {	\
>> +		KEEP(*(.liveupdate_sec_hdr))				\
>> +		KEEP(*(.liveupdate_versions))				\
>> +	}
>> +#else
>> +#define LIVEUPDATE_VERSIONS
>> +#endif
>> +
>>  #define KERNEL_DTB()							\
>>  	STRUCT_ALIGN();							\
>>  	__dtb_start = .;						\
>> @@ -544,6 +555,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
>>  	RO_EXCEPTION_TABLE						\
>>  	NOTES								\
>>  	BTF								\
>> +	LIVEUPDATE_VERSIONS						\
>>  									\
>>  	. = ALIGN((align));						\
>>  	__end_rodata = .;
>> diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
>> index 4a1cc6a5f3f8..57ef75695f62 100644
>> --- a/include/linux/kho/abi/luo.h
>> +++ b/include/linux/kho/abi/luo.h
>> @@ -244,4 +244,38 @@ struct luo_flb_ser {
>>  #define LIVEUPDATE_TEST_FLB_COMPATIBLE(i)	"liveupdate-test-flb-v" #i
>>  #endif
>>  
>> +#define LIVEUPDATE_VER_HDR_MAGIC 0x4c565550 /* 'LVUP' */
>> +#define LIVEUPDATE_VER_HDR_VER   1
>> +
>> +/**
>> + * struct liveupdate_ver_hdr - Header of vmlinux section with version lists
>> + * @magic:     Magic number.
>> + * @version:   Version of the header format.
>> + *
>> + * This struct is the header for the vmlinux section ".liveupdate_versions". The
>> + * section contains the list of file handler versions that the kernel can
>> + * support.
>> + */
>> +struct liveupdate_ver_hdr {
>> +	u32 magic;
>> +	u32 version;
>> +};
>
> I believe we are going to have two main classes of LUO objects that are
> going to participate in Liveupdates, when it comes to their criticality
>
> - Core/Mandatory components. Theese components are necessary for the
> kexec to be succesfull. Think components like IOMMU page tables, as
> you have mentioned.
>
> - Acceleration/Optional Components. As we strive to minimise the blackout
> time, we will trying to persist more and more state across kexec, that
> are currently being initialised from scratch during boot. Thing of
> certain optimisation like PCI onboarding (at least parts of it)
> and the PCI Config Space Cache. If theese components are incompatible
> between versions, we might still want to proceed, with the LU, at the
> cost of increased blackout time.
>
> I believe it will be quite usefull to be able to have the ability
> to differentiate between the two.

I agree that it would be useful. But I've been thinking about this for a
bit. I think it will be hard for the kernel to judge what is a mandatory
component and what is an optional one. There might be some setups where
you would deem some PCI devices as mandatory and some as optional. I
don't think we should even try to encode that kind of policy in the
kernel.

So I think we need a UAPI for userspace to tell us what is mandatory.
That is more UAPI exposure. Dunno if now is the right time to take
that, before we know more how this works out in practice...

[...]

-- 
Regards,
Pratyush Yadav

