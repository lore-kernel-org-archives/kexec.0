Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127E6D26284
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 18:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OFnwDkZU7Jyj9BN+wJryS5fMKIElBRiPVeTddDtgh1w=; b=Tjya9Expe5cLWBVAqYjqef5PTp
	HZ4Q+feQ6ClwXtrA6rAfBGGsrcixbt4Kn1NpReUpEqiwXtYv0rT9S7KFuiQeV9Wtaz28RAKBXfBfv
	U460dGBS3zZ1fkyo1n4UVBsNp75gEnLKeFzhg50OMz97q0GfqbUAu1tRbvmH2yetlnS+kg9C9S7nM
	qUbleWpB2siZrn2RKBIxXuQOpft0xtb1XVNIm1xpGBOWslB5jC25Vbm3NNnc/Iw51WCoVgcCyM3yO
	DEwqlBnLPep7OFhVxbemQ3CrkocCcx+MxoYP+egG7ypI3fJPVZGHoA+ZlxdQxhvYIbZIE7/cWjZXM
	WMjH9JmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viGu0-00000004KVj-3Twz;
	Tue, 20 Jan 2026 18:56:32 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viGtq-00000004KVB-1avL
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 18:56:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8BCEE438E3;
	Tue, 20 Jan 2026 18:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A84DC16AAE;
	Tue, 20 Jan 2026 18:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768935379;
	bh=NXgqW8xOX8NnK1Jm5wywr5UqQugivqCTFBrNxOL3X9o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=a5PDQPI4CaRseh0D+/3F6Ex115b3FY9vj36ryNtZS+MfjEwSdXipBJo3n9LMFULYx
	 JspPLSyiE46U5m4JWjjmsxPwhYXpAqnDX8l83Uqezxi497ThDqickWfFFV7KBUjzg/
	 IGIOcSf6ucIMXtt7ddriGQY2zFdfBJEpKDg36vP/pKaDRG9BYduuKbzeOSkhYjvmIc
	 2ODsi+ype4fBmrSJNDAPiQMbUoDOWXftp5Xjbfw8E2aYNGA8pK+h8A/N+ifPyly8K3
	 DwzprpcHZkOyMly23EdJhxlrGbotqeCVhYiPYpgwioayp/INcxmby38um4ghp+yQlc
	 uKF//m23MJqSA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Graf <graf@amazon.com>,  Jason Miu
 <jasonmiu@google.com>,  Jonathan Corbet <corbet@lwn.net>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  kexec@lists.infradead.org,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH 5/6] kho: Relocate vmalloc preservation structure to KHO
 ABI header
In-Reply-To: <aW_Mqp6HcqLwQImS@kernel.org> (Mike Rapoport's message of "Tue,
	20 Jan 2026 20:42:50 +0200")
References: <20260105165839.285270-1-rppt@kernel.org>
	<20260105165839.285270-6-rppt@kernel.org> <2vxzy0lscks4.fsf@kernel.org>
	<aW_Mqp6HcqLwQImS@kernel.org>
Date: Tue, 20 Jan 2026 18:56:16 +0000
Message-ID: <2vxz5x8wcdv3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260120_105628_796986_A556CD73 
X-CRM114-Status: GOOD (  18.92  )
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

On Tue, Jan 20 2026, Mike Rapoport wrote:

> On Tue, Jan 20, 2026 at 04:26:51PM +0000, Pratyush Yadav wrote:
>> On Mon, Jan 05 2026, Mike Rapoport wrote:
>> 
>> > From: Jason Miu <jasonmiu@google.com>
>> >
>> > The `struct kho_vmalloc` defines the in-memory layout for preserving
>> > vmalloc regions across kexec. This layout is a contract between kernels
>> > and part of the KHO ABI.
>> >
>> > To reflect this relationship, the related structs and helper macros are
>> > relocated to the ABI header, `include/linux/kho/abi/kexec_handover.h`.
>> > This move places the structure's definition under the protection of the
>> > KHO_FDT_COMPATIBLE version string.
>> >
>> > The structure and its components are now also documented within the
>> > ABI header to describe the contract and prevent ABI breaks.
>> >
>> > Signed-off-by: Jason Miu <jasonmiu@google.com>
>> > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> [...]
>> > +/* Helper macro to define a union for a serializable pointer. */
>> > +#define DECLARE_KHOSER_PTR(name, type)	\
>> > +	union {                        \
>> > +		u64 phys;              \
>> > +		type ptr;              \
>> > +	} name
>> > +
>> > +/* Stores the physical address of a serializable pointer. */
>> > +#define KHOSER_STORE_PTR(dest, val)               \
>> > +	({                                        \
>> > +		typeof(val) v = val;              \
>> > +		typecheck(typeof((dest).ptr), v); \
>> > +		(dest).phys = virt_to_phys(v);    \
>> > +	})
>> > +
>> > +/* Loads the stored physical address back to a pointer. */
>> > +#define KHOSER_LOAD_PTR(src)						\
>> > +	({                                                                   \
>> > +		typeof(src) s = src;                                         \
>> > +		(typeof((s).ptr))((s).phys ? phys_to_virt((s).phys) : NULL); \
>> > +	})
>> 
>> Nit: not a fan of exposing code internals to the ABI header. But without
>> this the definition of kho_vmalloc_hdr won't make any sense to someone
>> reading the doc without looking at the code. Dunno if we can do anything
>> better though...
>
> These might be actually useful for other KHO users. 

Hmm, okay. Let's keep them here then.

[...]

-- 
Regards,
Pratyush Yadav

