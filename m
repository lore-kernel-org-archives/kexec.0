Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCEEC4332F
	for <kexec@archiver.kernel.org>; Wed, 13 Dec 2023 01:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8JObu6IONpCpi3h8zD+m9mi0SA+7Zmh0xbUA9yCFnF4=; b=2P89PiSPO8eCt+
	JByBGSnbYKVFt/r0egJTuuA0MJB5VmwlextNS7okMNf2XlPnrjNp9YgZJCPiskmJyy2d5r7DHfwfu
	LQ5DGfA+UkDbhkAkjJ9DgVQZtlUK85roKKM9h3vYrV8nWEzLFHdFAqrpm5SkPHuUDayvg0h/dvatX
	tN1uxYVMVobCWKalOE/bJyC4YDRjyz666YhKbGhHzA5QQb2/2Q5DVRRAbA7BCy2ysCWxL09d1eP+T
	pF+EchRlPJs/3KGsL9TQErstkTnieydBBpCBjYKC3F5AThgS3HjH08ftsxhY8PsOfezdeM8rV1uo0
	9cM4saEQ9meMWRC60brg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDEKM-00DLQI-30;
	Wed, 13 Dec 2023 01:46:22 +0000
Received: from smtp-fw-80007.amazon.com ([99.78.197.218])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDDDo-00DCZt-1g;
	Wed, 13 Dec 2023 00:35:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702427732; x=1733963732;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VBKvTcQi72PcvnK4SFQYGqORB7BIbXX6crvus+RXOaY=;
  b=VSau86g+hgAvpNEhvQq2TITJrNMB4SWMV+6VgA2VazzPBXqgrr6EU3Cm
   0aPvptWHP4IjfQRszkgutWdFF1WjSZWPx9kgpgjryfL165H7qR75+zeLt
   f4m1HmypvWZP6kkdRJA4A9BIxOK4xl8eqm3xBlx7cYlpYNTKAKH2rS5Mr
   k=;
X-IronPort-AV: E=Sophos;i="6.04,271,1695686400"; 
   d="scan'208";a="259294536"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 00:35:31 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com (Postfix) with ESMTPS id 634AC80DCC;
	Wed, 13 Dec 2023 00:35:25 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:10819]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.95:2525] with esmtp (Farcaster)
 id 911b45ff-f732-45cd-b0a4-dcec0b0539c8; Wed, 13 Dec 2023 00:35:24 +0000 (UTC)
X-Farcaster-Flow-ID: 911b45ff-f732-45cd-b0a4-dcec0b0539c8
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:35:24 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Dec
 2023 00:35:19 +0000
Message-ID: <eb567d99-e03b-4718-9cc9-e27c5e408ea2@amazon.com>
Date: Wed, 13 Dec 2023 01:35:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] tracing: Introduce names for ring buffers
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <x86@kernel.org>, Eric Biederman
	<ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring
	<robh+dt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mark Rutland
	<mark.rutland@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra
	<ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>, "Stanislav
 Kinsburskii" <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
References: <20231213000452.88295-1-graf@amazon.com>
 <20231213000452.88295-9-graf@amazon.com>
 <20231212191546.603c0703@gandalf.local.home>
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20231212191546.603c0703@gandalf.local.home>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_163532_608654_E07BDAC0 
X-CRM114-Status: GOOD (  17.77  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Steve,

On 13.12.23 01:15, Steven Rostedt wrote:
>
> On Wed, 13 Dec 2023 00:04:45 +0000
> Alexander Graf <graf@amazon.com> wrote:
>
>> With KHO (Kexec HandOver), we want to preserve trace buffers across
>> kexec. To carry over their state between kernels, the kernel needs a
>> common handle for them that exists on both sides. As handle we introduce
>> names for ring buffers. In a follow-up patch, the kernel can then use
>> these names to recover buffer contents for specific ring buffers.
>>
> Is there a way to use the trace_array name instead?
>
> The trace_array is the structure that represents each tracing instance. And
> it already has a name field. And if you can get the associated ring buffer
> from that too.
>
> struct trace_array *tr;
>
>          tr->array_buffer.buffer
>
>          tr->name
>
> When you do: mkdir /sys/kernel/tracing/instance/foo
>
> You create a new trace_array instance where tr->name = "foo" and allocates
> the buffer for it as well.

The name in the ring buffer is pretty much just a copy of the trace 
array name. I use it to reconstruct which buffer we're actually 
referring to inside __ring_buffer_alloc().

I'm all ears for alternative suggestions. I suppose we could pass tr as 
argument to ring_buffer_alloc() instead of the name?


Alex




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
