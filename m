Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8D7C36018
	for <kexec@archiver.kernel.org>; Wed,  2 Apr 2025 18:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lzIzGe/A8K0FeDNd49e2UFCleX6gbOBWTXq2lLAmj28=; b=srBv0Don6rxtpZUichSUEps6WP
	Qz0K+w6MH1Wr5B9UiREl88hLEoRPTx8PttE7DpzxjQLMHetOmatcAcqgJLinqXz0fDak15AshNJ9u
	K/n5Ej11jKnpIO9NrACQkr7DxGnqIXDGh6wou57zkgYf6ycGieF1KIEuGS9r/mXHW/pJSV6OCcEO+
	fMWU5EPXuAMZVidJRMyLbjakhl8NpN1yQvZa08sjjGpd6KmwyGqGSKi47j/W4/BY6MBO5WiC69qo4
	0RolxV8tfimSOXJGA5MriTpRNjhsr47ihLW4q2hLuhqmjrYUC8j5HkEkv8Wj/fi0zM+ttWyRvFJT0
	/Apphf3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u039M-00000006y6y-1h3T;
	Wed, 02 Apr 2025 18:49:20 +0000
Received: from smtp-fw-52005.amazon.com ([52.119.213.156])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u039J-00000006y6D-3ZaN;
	Wed, 02 Apr 2025 18:49:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1743619758; x=1775155758;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=lzIzGe/A8K0FeDNd49e2UFCleX6gbOBWTXq2lLAmj28=;
  b=N2tQb1bp3qAv2NusgoPPUnXMweVB3/nS7LdTV9GYHbUntQQwMGCSt5gQ
   CzOr0x+as3Mg2yZi/OUBXSwDg6A6wInOT0nejWxGQ08Zz6rHBizhQ+FJT
   KQHBfSBPuaQj3Ubru/FC85qSGD7pTQhVKLgT8j0AREHnkQmra13pouAec
   Q=;
X-IronPort-AV: E=Sophos;i="6.15,183,1739836800"; 
   d="scan'208";a="732319846"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 18:49:12 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:38908]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.138:2525] with esmtp (Farcaster)
 id 7d79399a-a36b-4d73-99b6-98948cdf7eea; Wed, 2 Apr 2025 18:49:11 +0000 (UTC)
X-Farcaster-Flow-ID: 7d79399a-a36b-4d73-99b6-98948cdf7eea
Received: from EX19D020UWA002.ant.amazon.com (10.13.138.222) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 18:49:01 +0000
Received: from EX19MTAUWA002.ant.amazon.com (10.250.64.202) by
 EX19D020UWA002.ant.amazon.com (10.13.138.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 18:49:01 +0000
Received: from email-imr-corp-prod-iad-all-1b-85daddd1.us-east-1.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 18:49:01 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-iad-all-1b-85daddd1.us-east-1.amazon.com (Postfix) with ESMTP id B8E254076F;
	Wed,  2 Apr 2025 18:49:00 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id 74DA54F1C; Wed,  2 Apr 2025 18:49:00 +0000 (UTC)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
CC: Changyuan Lyu <changyuanl@google.com>, <akpm@linux-foundation.org>,
	<anthony.yznaga@oracle.com>, <arnd@arndb.de>, <ashish.kalra@amd.com>,
	<benh@kernel.crashing.org>, <bp@alien8.de>, <catalin.marinas@arm.com>,
	<corbet@lwn.net>, <dave.hansen@linux.intel.com>,
	<devicetree@vger.kernel.org>, <dwmw2@infradead.org>, <ebiederm@xmission.com>,
	<graf@amazon.com>, <hpa@zytor.com>, <jgg@nvidia.com>, <jgowans@amazon.com>,
	<kexec@lists.infradead.org>, <krzk@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <luto@kernel.org>,
	<mark.rutland@arm.com>, <mingo@redhat.com>, <pbonzini@redhat.com>,
	<peterz@infradead.org>, <robh+dt@kernel.org>, <robh@kernel.org>,
	<rostedt@goodmis.org>, <rppt@kernel.org>, <saravanak@google.com>,
	<skinsburskii@linux.microsoft.com>, <tglx@linutronix.de>,
	<thomas.lendacky@amd.com>, <will@kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory preservation
In-Reply-To: <CA+CK2bBnbEtw7jL2fbukJ3aBCjn=-OVT70oEAsZ435vtFe18Vw@mail.gmail.com>
References: <mafs0tt7eqt6f.fsf@amazon.de>
	<20250402164453.2470750-1-changyuanl@google.com>
	<mafs0ecyaqzmd.fsf_-_@amazon.de>
	<CA+CK2bBnbEtw7jL2fbukJ3aBCjn=-OVT70oEAsZ435vtFe18Vw@mail.gmail.com>
Date: Wed, 2 Apr 2025 18:49:00 +0000
Message-ID: <mafs0a58yqu03.fsf_-_@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_114918_038323_42CDE47F 
X-CRM114-Status: GOOD (  25.11  )
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

On Wed, Apr 02 2025, Pasha Tatashin wrote:

> On Wed, Apr 2, 2025 at 12:47=E2=80=AFPM Pratyush Yadav <ptyadav@amazon.de=
> wrote:
>>
>> Hi,
>>
>> On Wed, Apr 02 2025, Changyuan Lyu wrote:
>>
>> > Hi Pratyush, Thanks for suggestions!
>> >
>> > On Thu, Mar 27, 2025 at 17:28:40 +0000, Pratyush Yadav <ptyadav@amazon=
.de> wrote:
[...]
>> >>
>> >> The memblock_reserve side we can optimize later, I agree. But the mem=
ory
>> >> preservation format is ABI and I think that is worth spending a little
>> >> more time on. And I don't think it should be that much more complex t=
han
>> >> the current format.
>> >>
>> >> I want to hack around with it, so I'll give it a try over the next few
>> >> days and see what I can come up with.
>> >
>> > I agree with Jason that "nothing is ABI at this
>> > point" and it will take some time for KHO to stabilize.
>> >
>> > On the other hand if you have already came up with something working a=
nd
>> > simple, we can include it in the next version.
>>
>> I already have something that works with zero-order pages. I am
>> currently implementing support for other orders. It is almost done, but
>> I need to test it and do a performance comparison with the current
>> patch. Will post something soon!
>
> Hi Pratyush,
>
> Just to clarify, how soon? We are about to post v6 for KHO, with all
> other comments in this thread addressed.

I have it working, but I need to clean up the code a bit and test it
better. So hopefully end of this week or early next week.

--=20
Regards,
Pratyush Yadav

