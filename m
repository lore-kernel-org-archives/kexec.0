Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949DE606A320
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 07:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Wu9Yr8Ed;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GewONFtE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+ByBpVD7FPTufElpNoOF6mqXMOL+Kv6Ik0YaJGkEPtg=; b=Wu9Yr8EdH+eDX0RNCtWiP1aWoQ
	Xu5D0kb5WYWEBmQlohO05Y37t2PkCgR7N4jxnVioWny68Lj5eUi7wFH8SnKdpwXylnCrI88LwIuM9
	LvKe3b9rGvvOktCFHUPo4zFTP2+KTHdPKcY9xjVxZlZDmmAqndaLzPHMwz0cQvuYaYkr/7/eyywxY
	AEo/e0UMKxePF93zFakLbe7RxY8DDSjDxfXoz4JeNvABm6ZEiGEEQ11hrzlscai3DyA9ZNkzZIR4q
	7l7t7Yngiear65R96rz+xv559IYY41+tXKpYZDpfKlO7bZTQZV65T/1nwQ8T8/Vyq5oVjSPxaggWT
	vsoYR9+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJmqb-0000000DX7l-3xsa;
	Thu, 22 Oct 2026 07:04:21 +0000
Received: from mail-pj2-x08.google.com ([2607:f8b0:4864:39::8])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJmqY-0000000DX6b-1Tq0
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 07:04:20 +0000
Received: by mail-pj2-x08.google.com with SMTP id d9443c01a7336-2e4a61a2ff9so5392095ad.0
        for <kexec@lists.infradead.org>; Thu, 22 Oct 2026 00:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792652657; x=1793257457; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ByBpVD7FPTufElpNoOF6mqXMOL+Kv6Ik0YaJGkEPtg=;
        b=GewONFtEPkfPZnIRMeU5EnecWvrmzWCSKgScWzyiY80kPdpys4iWqSE22mRL5ReEK1
         KDu6xkgFmjcJgwG5MqgbWov7/fCcZeZmI/Pna/fiXi5tAz4UZ7jjjmUUSibt86Fo/Ol9
         Ewgh0hK50hP3RMVcURUAYWzmzMP4l7G3TY0Vd4L/YXgrrETOA0dPOr5Wnqa6ZcPM9ioL
         h2fPoPsEQlIAmdY87Gi5l5WN6PyOL+Ttfsonbsv/nqMFdqY0UXf6IGj7zoolXsFWvhnK
         fT4MZy6kDvFr3JboDEfMLVpiBjYRJ4DBN2ykjfuafURDhXjGzU3N4pxAAQzd1b+M2jGb
         WWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792652657; x=1793257457;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ByBpVD7FPTufElpNoOF6mqXMOL+Kv6Ik0YaJGkEPtg=;
        b=gsPLM9fqr5Q80bU+bYvyLE3pG28AXDD0mtRty8Rf/fxgTU32wAD4vTGGWQKQ/9eCHq
         5Wv5yHQkPmv5rkomaCBg+5S4n/bi9ZHNIaGI4ot79bcM/jnXri4fvSShxSUOGf+i8PjR
         tqrLNqB9VcT8VAfNn1iFsFfYymwN8dcpPmVjNPlXWhAtKvpGsu5OTMIVE72t2sUKTRnD
         qtRMMQUpSbgkUFI50ersdQZslIbltbgBOnRnPpVe8RYq5Bi6AgECH+1QTECLqLCbCIrM
         5pnnPfb0sgrBoFp61O4HMu5RO43653pVA4ge+zhXPNTRp5KQ9tY62X4uLowvz86p3U6R
         RK4g==
X-Forwarded-Encrypted: i=1; AKwUvByE1Up+/aPyDS84qP43XV9AEe/iB9lNUVSsesgKIzeESjLnlsaR65ROqCI2jgUInqv2MLCc/Q==@lists.infradead.org
X-Gm-Message-State: AFq9FYLk5m2HkBN8WC3ROvq8aEqz59EkMq8xtGS6DtfiPlG0cqfE2eO9
	qL5Gx/2dUfiyP/YcYPR0Hmep0En+h+SUbO31MYRuqpHP+3dRKChzDRDb
X-Gm-Gg: AYBFou0hneZP8WOM0okXnHqx07bfT4ck9PIlZoIALR+1t+CN3bVpPjB03mGc9Ii941v
	h8nfDVaJSB5C861njZmngpPIVNybNxymCoT8UktnbgRBz5bJvt1Yd+SDueOhn4rmUF7EFIWjEq8
	g1R8N7cRpjZfbU8L4OfUlSS+WoJTlqHFdJqHYRNGz+q56vTFyyhuBGx9TA74MeAxwBw7Vdn++Sk
	QpcHMRCzGLCVLjjLSZI1KdNv6BnzAMMwxEBarM+LfaF+yuDz/gEFJ6+AAhrEcJBqh/zYVHsJVyY
	zw/ANKTrWJZvsIW1EVPi8/ONQrDBh1HtMo6y/hKT0eKKr0P/XoNefn2rzTCii5bCbj3ipDR+LpW
	g2RcPLVDm/9nl4ZJ4J5j+b/7rgy7D0Ult1HicBV5Sd6snaH7V5bXQUaaYx8OI+2Uof+17DzFWkK
	4/Ko9PSTyb913AP474z2aqjUr5vDLo5P8Iws00sfGCL4dpGGjfXsDHQUwCTvmyUdGubfKEObq0a
	MaFA+mYgycmBjpCDZ46I9vPDV5P5x1whcKh5Kx6qI0btkvnospxoFGT1Iy7OwQ=
X-Received: by 2002:a17:902:e947:b0:2e9:9bac:2e84 with SMTP id d9443c01a7336-2ea43d3a8e5mr34417885ad.66.1792652657298;
        Thu, 22 Oct 2026 00:04:17 -0700 (PDT)
Received: from [10.125.112.22] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b43478csm19901295ad.28.2026.10.22.00.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 00:04:16 -0700 (PDT)
Message-ID: <95f18ef2-8fda-447e-bc64-1732febea363@gmail.com>
Date: Thu, 22 Oct 2026 15:04:02 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/8] kdump: reduce vmcore size and capture time
To: Rob Herring <robh@kernel.org>, "rppt@kernel.org" <rppt@kernel.org>
Cc: baoquan.he@linux.dev, m.szyprowski@samsung.com, catalin.marinas@arm.com,
 will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org,
 kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 saravanak@kernel.org, akpm@linux-foundation.org, pasha.tatashin@soleen.com,
 pratyush@kernel.org, ruirui.yang@linux.dev, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 iommu@lists.linux.dev
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
 <20261021132308.GB3667411-robh@kernel.org>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <20261021132308.GB3667411-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_000418_397897_EE59A257 
X-CRM114-Status: GOOD (  15.25  )
X-Spam-Score: -1.9 (-)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/21/26 21:23, Rob Herring wrote:
> On Wed, Oct 21, 2026 at 04:30:03PM +0800, Wandun Chen wrote:
>> From: Wandun Chen <chenwandun@lixiang.com>
>>
>> On SoCs that carve out large firmware-owned reserved memory (GPU,
>> camera ISP, ...), kdump currently dumps those carveouts as part of
>> system RAM even though their contents are firmware state that is not
>> useful for kernel crash analysis.
>>
>> ACPI systems already filter reserved memory out of the vmcore through
>> their existing path: firmware reports those carveouts as unusable in
>> the EFI memory map, they get MEMBLOCK_NOMAP set in memblock.memory
>> (is_usable_memory(), efi-init.c), and the ELF header builder has
>> always skipped nomap regions; only DT-based systems currently fail
>> to filter these regions, which is what this series addresses.
>>
>> This series introduces a MEMBLOCK_NODUMP flag (suggested by Rob) in
>> memblock to filter reserved memory on DT-based architectures. A new
>> flag is needed because MEMBLOCK_NOMAP can only express regions without
>> a linear mapping, while MEMBLOCK_NODUMP can filter regions that are
>> linearly mapped. Reserved regions are marked MEMBLOCK_NODUMP by default
>> so kdump omits them; reusable CMA regions are different because their
>> pages are handed back to the buddy allocator and may carry crash-relevant
>> data.
> 
> There is little point in continuing to send new versions until Mike 
> agrees with MEMBLOCK_NODUMP being added. You didn't answer him on v7.

Hi Rob,

Thanks for the reminder. On v7 your reply to Mike stated exactly what
I wanted to say, after a week without further objections, so I assumed
the question was settled and went ahead with next version. That was a
mistake on my part: I should have gotten Mike's agreement on the flag
before sending a new version. I'll hold off further versions until then.



Hi Mike,

Sorry for not following up on your v7 question. The reason a new flag
is needed is described in the v9 cover letter:

    A new flag is needed because MEMBLOCK_NOMAP can only express
    regions without a linear mapping, while MEMBLOCK_NODUMP can
    filter regions that are linearly mapped.

Put differently: today, whether a region ends up in the vmcore is a
side effect of how it is mapped, mapped regions are always dumped,
nomap regions never are. Nothing can express "mapped, but not useful
in a crash dump". MEMBLOCK_NODUMP decouples the two, and DT is simply
the first user.



> 
> Also, I intend to apply this[1] before any further reserved memory 
> changes which will greatly simplify the code.

Understood, and it makes sense. It removes the two-pass reserved_mem
initialization and indeed simplify the code, I'll rebase on top of
it once it lands;


Best regards,
Wandun




> 
> Rob
> 
> [1] https://lore.kernel.org/all/20261015082315.56876-1-m.szyprowski@samsung.com/


