Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C93D729E7
	for <kexec@archiver.kernel.org>; Fri, 29 Nov 2024 17:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:CC:Message-ID:Date:Content-Type:Content-Transfer-Encoding:MIME-Version:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NtnAJBiaXOZ9zNEkjDYjYXdU6aFjbbL/ZqV4zjqWvX8=; b=b3tj0EGkadUwBkPt7Uyj1DuCI0
	oCxO3ofQ7EyIgNWyLcNP19Ow4t2p6FSYr+ogIU+Y7ShjxGu1dxMqtfUWroUTtvHyBPlQBYB2no0O/
	ykQ+D8VO9Wkv48rZJCYeS8eYdoRprWogIuEPhEWk8vQXE83v97yg3P07IF+262LD5xQdnPIFjVGDn
	+DtU3ykSs4Kp94sBnUoUUk3Vbfi/LrBecIkIYYmOl5GQl2BFQLGIID3WbcN8n8Fl4Si9j67XV3sej
	TX/8RkHoPTgqtN0BMyJtsMoinr2QkOO2LccxYAZj7e5wUZMJDKNnrUaP1SUZ9gVUPm+XpMMWGFNfT
	moVRj1HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tH4P0-00000000fkx-1jvZ;
	Fri, 29 Nov 2024 17:03:34 +0000
Received: from smtp-fw-80007.amazon.com ([99.78.197.218])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tH4Ox-00000000fjv-0TEp
	for kexec@lists.infradead.org;
	Fri, 29 Nov 2024 17:03:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732899812; x=1764435812;
  h=mime-version:content-transfer-encoding:date:message-id:
   cc:from:to:references:in-reply-to:subject;
  bh=NtnAJBiaXOZ9zNEkjDYjYXdU6aFjbbL/ZqV4zjqWvX8=;
  b=kGe9EdmD2ctim2SiB7HLstrF8CQhkj6VMZwhKynhaEcUVf4gDjOfb4jq
   4Abl/pJvWdXj+h1MXhtM7sbN+qT2utbFd02yw2wmMveSPK0Z7J70AzNVx
   EXR67dI4hAzv25td/ho4TfR3mt0FK6oT5f1/GMtSplUbtfAgtlqf6p6z9
   M=;
X-IronPort-AV: E=Sophos;i="6.12,196,1728950400"; 
   d="scan'208";a="356747171"
Subject: Re: [PATCH v2 2/2] x86/efi: Apply EFI Memory Attributes after kexec
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 17:03:25 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:37136]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.26.13:2525] with esmtp (Farcaster)
 id 47e3b7c1-6e2d-419d-82e4-56743fc7e28b; Fri, 29 Nov 2024 17:03:23 +0000 (UTC)
X-Farcaster-Flow-ID: 47e3b7c1-6e2d-419d-82e4-56743fc7e28b
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 29 Nov 2024 17:03:22 +0000
Received: from localhost (10.13.235.138) by EX19D004EUC001.ant.amazon.com
 (10.252.51.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Fri, 29 Nov 2024
 17:03:18 +0000
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 29 Nov 2024 17:03:15 +0000
Message-ID: <D5YTPJS0CBZE.3I95FH2WL1ZJK@amazon.com>
CC: Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H . Peter Anvin"
	<hpa@zytor.com>, Matt Fleming <matt@codeblueprint.co.uk>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stanspas@amazon.de>, <nh-open-source@amazon.com>, <stable@vger.kernel.org>,
	<kexec@lists.infradead.org>
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: Dave Young <dyoung@redhat.com>
X-Mailer: aerc 0.18.2-100-gc2048ef30452-dirty
References: <20241112185217.48792-1-nsaenz@amazon.com>
 <20241112185217.48792-2-nsaenz@amazon.com>
 <CALu+AoTnrPPFkRZpYDpYxt1gAoQuo_O7YZeLvTZO4qztxgSXHw@mail.gmail.com>
 <D5XXP2PU3PUK.3HN27QB1GEW09@amazon.com>
 <CALu+AoSDY6tmD-1nzqBoUh53-9C+Yr1dOktc0eaeSx+uYYEnzw@mail.gmail.com>
 <CALu+AoTAQ_v7SL-_c_F74TfXWmwYMNV_MRD9zWVyiHuXfa6WtA@mail.gmail.com>
In-Reply-To: <CALu+AoTAQ_v7SL-_c_F74TfXWmwYMNV_MRD9zWVyiHuXfa6WtA@mail.gmail.com>
X-Originating-IP: [10.13.235.138]
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_090331_455294_7D46C251 
X-CRM114-Status: GOOD (  25.71  )
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

On Fri Nov 29, 2024 at 7:31 AM UTC, Dave Young wrote:
> CAUTION: This email originated from outside of the organization. Do not c=
lick links or open attachments unless you can confirm the sender and know t=
he content is safe.
>
>
>
> On Fri, 29 Nov 2024 at 15:11, Dave Young <dyoung@redhat.com> wrote:
>>
>> Hi Nicolas,
>>
>> On Thu, 28 Nov 2024 at 23:58, Nicolas Saenz Julienne <nsaenz@amazon.com>=
 wrote:
>> >
>> > Hi Dave,
>> >
>> > On Fri Nov 22, 2024 at 1:03 PM UTC, Dave Young wrote:
>> > > On Wed, 13 Nov 2024 at 02:53, Nicolas Saenz Julienne <nsaenz@amazon.=
com> wrote:
>> > >>
>> > >> Kexec bypasses EFI's switch to virtual mode. In exchange, it has it=
s own
>> > >> routine, kexec_enter_virtual_mode(), which replays the mappings mad=
e by
>> > >> the original kernel. Unfortunately, that function fails to reinstat=
e
>> > >> EFI's memory attributes, which would've otherwise been set after
>> > >> entering virtual mode. Remediate this by calling
>> > >> efi_runtime_update_mappings() within kexec's routine.
>> > >
>> > > In the function __map_region(), there are playing with the flags
>> > > similar to the efi_runtime_update_mappings though it looks a little
>> > > different.  Is this extra callback really necessary?
>> >
>> > EFI Memory attributes aren't tracked through
>> > `/sys/firmware/efi/runtime-map`, and as such, whatever happens in
>> > `__map_region()` after kexec will not honor them.
>>
>> From the comment below the reason to do the mappings update is that
>> firmware could perform some fixups.  But for kexec case I think doing
>> the mapping correctly in the mapping code would be good enough.
>>
>>         /*
>>          * Apply more restrictive page table mapping attributes now that
>>          * SVAM() has been called and the firmware has performed all
>>          * necessary relocation fixups for the new virtual addresses.
>>          */
>>         efi_runtime_update_mappings();
>>
>> Otherwise /sys/firmware/efi/runtime-map is a copy for kexec-tools to
>> create the virtual efi memmap,  but I think the __map_region is called
>> after kexecing into the 2nd kernel, so I feel that at that time the
>> mem attr table should be usable.
>
> Another thing I'm not sure why the updated mem attr is not stored in
> the memmap md descriptor "attribute" field, if that is possible then
> the runtime-map will carry them,  anyway, the __map_region still needs
> tweaking to use the attribute.

AFAIK there isn't a technical reason we why couldn't do it through the
runtime-map, but it's annoying to do so because EFI Memory Attributes
are allowed to segment EFI memory regions into smaller sections with
distinct attributes. We'd have to carefully update the kernel's
representation of the EFI runtime memory map as we apply the attributes
(the one that's ultimately used to populate
`/sys/firmware/efi/runtime-map`).

On the other hand, the config table and memory region that holds the
attributes is already being persisted through kexec, so using it is
straightforward.

Nicolas

