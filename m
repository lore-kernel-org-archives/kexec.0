Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E032CC5B56A
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 13:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dopq0hZuPNS9L6jU5UttlRluDWhWW/kodS7OPbznp5U=; b=LzTkIN/kHuCbW19gP1qRWEpsMX
	eC+F+FeO9nkB90kMSo+cTgkxL3xZXB8lJ1hOsKoOBLVRM6Nm2FXK5xBJS+pqFujzBbJmc1EzLM5BS
	pTo00fNWDSS80xEFOFUymnCqcXLihrU3gC5SGzQzAdHp8Voc5XzK5V35ReuZRlYNbnW/u1gNXzYMN
	lnBjFN1V6po5AdnOqFsKLfONNKu/tmj0xL+ES0PTqsF5GV5ChEEUD12FtGVBe1kuw7rLIWLO+TD2d
	/s6G3iSHQAEp8UwVI90QBKm1NkJVqz/eVI4H/SDhtBBCsAMZnE8c9HakwYaRAE1cnAdIqKb7/Ew/3
	dyNKfDOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtPpe-0000000BsmB-1ch5;
	Mon, 10 Aug 2026 13:14:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtPpd-0000000Bsm1-2NZz
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 13:14:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 09AB160A71;
	Mon, 10 Aug 2026 13:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED92E1F00A3A;
	Mon, 10 Aug 2026 13:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786367660;
	bh=Dopq0hZuPNS9L6jU5UttlRluDWhWW/kodS7OPbznp5U=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=ZTS+CzXOge0c7xjMkrKDSitdlJb2MXjdM7cNZtGXWgtsbHA+9ttfxDsPd1cQ0a4uG
	 byJS9l2nrd5YP+hl8uJHlJAs0wUI7Y4tb7Hz0012rFnlsfnQEe04VFc6/+aT0NwZtL
	 PmTlCBjfcx70DdZwWK+0/Z1Xr4fKr7qKykhfES0jIIaZ3cTVhpM0yEHSwYOpOmyPwA
	 s/e1pXtC2rC3ojps1RNXiFZhuP0T5VC0xSd7mF+z8wKgtLDUP7cmTtjuxykkYf5C78
	 sXSAGmfe9cnlvq95znlldKzaOQzD/OTIVW8DVzP5/3WZby1rPXTe9IX4qkkD0TDgUb
	 gpEnmlrzWoWIw==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 78C1F198006A;
	Mon, 10 Aug 2026 09:14:18 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Mon, 10 Aug 2026 09:14:18 -0400
X-ME-Sender: <xms:p855avksB5MjYv2uIlrrKo5eJZanu9YxOmuYk6YAS2DgSn7JnfYI2w>
    <xme:p855atqvkEu3HuCb9SEPaY8piGTfc0LKaNWx9PyD0_V2bHqwacFKJC6bORjiHjMg7
    cxX5aN7ip-8rIuSrJXev9hTAWed7XYsprh8DN0NvRPqCvQHP3f3a1FS>
X-ME-Proxy-Cause: dmFkZTElIyFR+UBLKhjj7wjJYJ+/bRab/R8bgXSZhQJAboiCDV9kcSeRMzgD4qEk8nrTMR
    8dzEclZdHc8NT7LQtDZsQSoLVCWiTRS09HGGQiUcX395XimFvmVi0WIF2G+2OLsaXhUc55
    lRCWJF4294VbDePkB2p2D0IOKbKoeYRlthch1odD8UwicpIFcyIKt9aFdsLO5w7MlXuLzm
    b9e7LakwWP4q0f+GILnGDXQxLqbieGnCbUO2ZEzLr6drkMCLWGMQxxNtoFL/VVVSft7iKM
    4JVYw99RunPcuOZyuXcIUJJZDuQhdbgPEt0M6Yu4fPcMDJq2v3oroHExV/xy8R3ApFmOfH
    DeauLEe0UUJfMZCAppYDXn1Yc2t2edy35d2cszVIukp+A0CdClqJQlhmCElQ+qFTaH92Np
    szzQ9coQgErIO/r2V6MQhf8agkQDkghY3yrjcxJLarPGBPRj2LSNSDXaaZk5EyE0tS+YRv
    JkXW2AKFgSbjjBQZECLOYOZBtwlN/rW8qFPqVN69VrdRep89Xt8gsvMDHS6usrbvXjMEO2
    QoQJBeh6sS932RFVaiIdDwp4YKw4DkhaSEnZYZsCJWmG3YyZ5R+t6tGPGuSKK8wDlsmltv
    5uuwblKwRnI8LpXh894PPoxp6uPIK8UJpXnQCVlRa4onovQfb+XcNBEYY5BQ
X-ME-Proxy: <xmx:qs55alKHpGUj-1USUQY-auZJumm3h2ApqRthfvd7a-VUJW-Hj2sYTw>
    <xmx:qs55amup7KdOabGd7I5IlmQ3ZriKwchkKZ83tDFP9xrkWJwafelzeA>
    <xmx:qs55anTM7yyVTzqD9_XHqHWUbO_7Pc8TuEgb_UUnscExvoc3WfA5TA>
    <xmx:qs55anSDQIb8GBjvgUF5e1dlYBH2OfP_qG62PuJIIFpZFJYVn5RdZg>
    <xmx:qs55ajpMflwEATQhtjqX-axiio6anFKqf9KsqX0q879R7m_X6VU7gUIc>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 144A8F8006E; Mon, 10 Aug 2026 09:14:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Mon, 10 Aug 2026 15:13:54 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Huacai Chen" <chenhuacai@kernel.org>,
 "George Guo" <dongtai.guo@linux.dev>
Cc: "Mike Rapoport" <rppt@kernel.org>, pasha.tatashin@soleen.com,
 pratyush@kernel.org, shuah@kernel.org, guodongtai@kylinos.cn,
 "WANG Xuerui" <kernel@xen0n.name>, graf@amazon.com,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-efi@vger.kernel.org
Message-Id: <96bd0e57-b517-4008-905f-9860661afaf2@app.fastmail.com>
In-Reply-To: <CAAhV-H4xxPXVRNXP42CBtMdVXbBZ4E6A997jZmw7HpEUSFAj9g@mail.gmail.com>
References: <20260807103714.33074-1-dongtai.guo@linux.dev>
 <20260807103714.33074-2-dongtai.guo@linux.dev>
 <CAAhV-H4xxPXVRNXP42CBtMdVXbBZ4E6A997jZmw7HpEUSFAj9g@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] efi: add a KHO configuration table GUID
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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



On Sun, 9 Aug 2026, at 06:18, Huacai Chen wrote:
> Hi, George,
>
> On Fri, Aug 7, 2026 at 6:38=E2=80=AFPM George Guo <dongtai.guo@linux.d=
ev> wrote:
>>
>> From: George Guo <guodongtai@kylinos.cn>
>>
>> Kexec Handover (KHO) passes the address of its state FDT and of its
>> scratch area from the current kernel to the next one.  On architectur=
es
>> that boot with a device tree, the current kernel writes the
>> linux,kho-fdt and linux,kho-scratch properties into /chosen, and the =
next
>> kernel reads them back in early_init_dt_check_kho().
>>
>> Architectures that boot through EFI without a device tree have no such
>> channel.  LoongArch is one of them: its efistub passes the EFI system
>> table and the command line to the core kernel directly and never crea=
tes
>> an FDT.  x86 has the same problem and carries the state out of band
>> instead, in a struct kho_data in the setup_data chain of its boot
>> protocol.
>>
>> Add an out-of-band channel for EFI: a LINUX_EFI_KHO_TABLE_GUID
>> configuration table entry, under a randomly generated GUID, pointing =
at a
>> struct linux_efi_kho_data.  The
>> current kernel loads the structure and an extended configuration tabl=
e as
>> kexec segments, then switches the EFI system table to the new table
>> before jumping.  The next kernel finds the entry by GUID and calls
>> kho_populate().
>>
>> The structure carries no version field.  An incompatible change to the
>> layout must use a new GUID, which is the usual rule for EFI configura=
tion
>> tables.  The handover payload itself is versioned separately, by the
>> compatible string of the KHO state FDT that kho_populate() checks.
>>
>> This patch adds the definitions only.  LoongArch is the first user; a=
ny
>> other EFI architecture without a boot FDT can use the same channel.
>>
>> Signed-off-by: George Guo <guodongtai@kylinos.cn>
>> ---
>>  include/linux/efi.h | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/include/linux/efi.h b/include/linux/efi.h
>> index ccbc35479684..789ab9e4312a 100644
>> --- a/include/linux/efi.h
>> +++ b/include/linux/efi.h
>> @@ -422,6 +422,7 @@ void efi_native_runtime_setup(void);
>>  #define LINUX_EFI_COCO_SECRET_AREA_GUID                EFI_GUID(0xad=
f956ad, 0xe98c, 0x484c,  0xae, 0x11, 0xb5, 0x1c, 0x7d, 0x33, 0x64, 0x47)
>>  #define LINUX_EFI_BOOT_MEMMAP_GUID             EFI_GUID(0x800f683f, =
0xd08b, 0x423a,  0xa2, 0x93, 0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
>>  #define LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID    EFI_GUID(0xd5d1de3c, =
0x105c, 0x44f9,  0x9e, 0xa9, 0xbc, 0xef, 0x98, 0x12, 0x00, 0x31)
>> +#define LINUX_EFI_KHO_TABLE_GUID               EFI_GUID(0xc941b6c7, =
0x7b3f, 0x4af6,  0x9e, 0x50, 0xfc, 0xb3, 0xa8, 0x86, 0x8a, 0x17)
> I don't know whether it is allowed to define a new TABLE ID while
> doesn't touch the UEFI SPEC.
>

That is fine in principle: the whole reason for using GUIDs as identifie=
rs
in UEFI is that everyone can invent their own, and the risk of conflicts=
 is
negligible.

All LINUX_EFI_* GUIDs are Linux inventions, and are not mentioned in the
UEFI spec at all.


