Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4B6C25B67
	for <kexec@archiver.kernel.org>; Sat, 28 Oct 2023 14:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mCO90VKXfwt+ViQ0VxfqM3vbSVr0W5sODXOQuItYOlc=; b=w7ZeCkaPlJD8O7
	bkY82l0IabtFjMntyrDI6a1M+dK0ItgD3li4WJRHV9IFl2qCXnk2/qCh+bmVrg8mI0FR4Dou3OrDs
	NpH63FQNXVZSl2AOp7CJnB3PokjsddS91uqqsZWwgMmyFh/Iz/6IE4ljdIFYh/kOoAxZ9TLL3kcEF
	R+Yx4ue6Z1ww+v3bSEvjBmPeLPgsMYw52z55B0smGWPnUoqfENm4f/tq8i4c7WgsK2GYctD0LsTYO
	ZPMwThYM4Ud1ofOvxx3iyWupQQBK9FnSBG7X8/SYlWeGeU5LpGu2LeVqFym4QTQnLXHUjnq8Mmi6I
	ROcXJY+YurM6+SP70eiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwjyX-000XeT-30;
	Sat, 28 Oct 2023 14:07:41 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwjyT-000XcU-2A
	for kexec@lists.infradead.org;
	Sat, 28 Oct 2023 14:07:39 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1698502042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAZ8/ypQKsb51hCx92Cob0mTqPJOPxsmPa1MSwvVBmI=;
	b=YsJghcFYnSnqaFixz9uQHA7H4GDu4EHF504t285r81imS4UrUXnPT7YZN34If4C/dh+bOP
	K5ZdubvR6YTKatdEDUX1TC7aRCAyU5/iYVjBzvRMnmc2D45lUbRwQG+3B2wOs+kERUPnOu
	vUu92xav5dw2XbLRya3dl0Ntcxr/dpI9kSWW0r2h9hEPu0Vo2+4wG9FpVoVhvo2hNBd0gd
	8toq2qfb5G0Ca0iLOmPt/iklKwmQZoQAc04gz4EWI+/wM/mw8DgWNz6+X5jfaz0HrwnUcE
	oODwu7U1noneAif+trmRttQ7fMZOD9YS5PqnruGGQYzWNJDUpZTHtszTjNQtUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1698502042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAZ8/ypQKsb51hCx92Cob0mTqPJOPxsmPa1MSwvVBmI=;
	b=1xqjRVFuL6iiObo0Dw71zi0nfUttrZD+bjTM8N6jPRzmNK6+9jzAnIn6ESFXTGWIc3WdYN
	G+CPAZn6ODbbhjAg==
To: "Huang, Kai" <kai.huang@intel.com>, "kirill.shutemov@linux.intel.com"
 <kirill.shutemov@linux.intel.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "Hunter, Adrian"
 <adrian.hunter@intel.com>, "Reshetova, Elena" <elena.reshetova@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "Christopherson,, Sean"
 <seanjc@google.com>, "bhe@redhat.com" <bhe@redhat.com>, "Nakajima, Jun"
 <jun.nakajima@intel.com>, "peterz@infradead.org" <peterz@infradead.org>,
 "bp@alien8.de" <bp@alien8.de>, "Edgecombe, Rick P"
 <rick.p.edgecombe@intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "sathyanarayanan.kuppuswamy@linux.intel.com"
 <sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
 <x86@kernel.org>
Subject: Re: [PATCHv2 02/13] kernel/cpu: Add support for declaring CPU
 offlining not supported
In-Reply-To: <e3ffb5c47126f03ef998f4ae5df81b9c9bd20da7.camel@intel.com>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
 <20231020151242.1814-3-kirill.shutemov@linux.intel.com>
 <0a29fef814e51a2aa0030ec9cc97366718859411.camel@intel.com>
 <20231023153142.bes7zxcjc2soihsl@box>
 <e3ffb5c47126f03ef998f4ae5df81b9c9bd20da7.camel@intel.com>
Date: Sat, 28 Oct 2023 16:07:21 +0200
Message-ID: <87cywy263q.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231028_070737_858174_6C44900F 
X-CRM114-Status: GOOD (  13.13  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Oct 23 2023 at 22:07, Kai Huang wrote:
> On Mon, 2023-10-23 at 18:31 +0300, kirill.shutemov@linux.intel.com wrote:
>> On Mon, Oct 23, 2023 at 09:30:59AM +0000, Huang, Kai wrote:
>> > IMHO it's a little bit odd to have two mechanisms in place, even in this middle
>> > state patch.  Is it better to completely replace CC_ATTR_HOTPLUG_DISABLED with
>> > the new cpu_hotplug_offline_disabled in this patch? You can explicitly call
>> > cpu_hotplug_disable_offlining() in tdx_early_init() so no functional change is
>> > done.
>> 
>> I can. But I don't see how it makes a difference.
>
> Personally I think this is better because it is odd to have two mechanisms in
> place even temporarily especially when we can avoid it.  But no hard opinion. 
> Up to you.

It's not at all better because having this clear split makes it simpler
to review and ponder the individual changes.

Thanks,

        tglx



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
