Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537D2C4332F
	for <kexec@archiver.kernel.org>; Wed, 13 Dec 2023 23:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b4HZPQIpEGrME5xVGEeN/fv1T9EoZ+SIu2bUkqfR5oE=; b=CMiDl9Ip8gFKdf
	j6QXbIu7ADX53o65fR+XCzop4zL4zc63xHA2uAMHvPRCmZ2kgM4h1LnMpO1vku0pT0df881a7C/RJ
	fNyrApY9m2G1P5VTDXEpwygD0hieINb6UeLKk0ihqK1p34Pu36YfzgbZOjIAKvzVnnMvCjIYWtqp7
	1s4DPBTY45NMkz26Pl6tadFlAhvChhKNdgvTroLiJrrzFlfBvNQSyQ+tYWx1P1/7Qtr8FhXrV/Y7C
	6zCON85HleDaYhlfcTZTS7SJH7Ifl8i58oV6xBO4yG1pWmKnL6B6vcUoLu4a8WTc2wpK1K3OupGRx
	20LchnpTbRsyRVmwO35g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDYmq-00GFjV-0C;
	Wed, 13 Dec 2023 23:37:08 +0000
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDYmm-00GFdn-1N;
	Wed, 13 Dec 2023 23:37:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702510625; x=1734046625;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uhcOfQRbinzPEwd7PFn+5HZ7ZrYv/GL0E6TNEd2zF1E=;
  b=C/27V3RcJeEBLwnQ0x4rjDOAoersSqYmyrMX1EwPAdv2QWiAwdwWsQIY
   zKzV6PLhIkTYDX7WXJ189yNW8pzPxa4F/DEozGiKuh6y9ePiJOAks5jym
   dbgAfyjRhSohYv7GuwNptaGYhdpGaYvqLxxWNFw+46zzFk77lOjjkIIoG
   w=;
X-IronPort-AV: E=Sophos;i="6.04,274,1695686400"; 
   d="scan'208";a="317067437"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 23:36:46 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com (Postfix) with ESMTPS id BC6F1A0F68;
	Wed, 13 Dec 2023 23:36:41 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:7953]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.64:2525] with esmtp (Farcaster)
 id f9b5748f-49e6-459d-89c3-cedde6930958; Wed, 13 Dec 2023 23:36:41 +0000 (UTC)
X-Farcaster-Flow-ID: f9b5748f-49e6-459d-89c3-cedde6930958
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 23:36:40 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Dec
 2023 23:36:34 +0000
Message-ID: <6748dc7e-534e-4b45-8fa9-052fae591534@amazon.com>
Date: Thu, 14 Dec 2023 00:36:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] kexec: Add Kexec HandOver (KHO) generation helpers
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <x86@kernel.org>, Eric Biederman
	<ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring
	<robh+dt@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton
	<akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>, <arnd@arndb.de>, <pbonzini@redhat.com>,
	<madvenka@linux.microsoft.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>, David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20231213000452.88295-1-graf@amazon.com>
 <20231213000452.88295-4-graf@amazon.com>
 <20231213183614.GA14669@skinsburskii.>
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20231213183614.GA14669@skinsburskii.>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_153704_533245_6C136879 
X-CRM114-Status: UNSURE (   9.78  )
X-CRM114-Notice: Please train this message.
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


On 13.12.23 19:36, Stanislav Kinsburskii wrote:
> On Wed, Dec 13, 2023 at 12:04:40AM +0000, Alexander Graf wrote:
>> +int register_kho_notifier(struct notifier_block *nb)
>> +{
>> +     return blocking_notifier_chain_register(&kho.chain_head, nb);
>> +}
>> +EXPORT_SYMBOL_GPL(register_kho_notifier);
>> +
>> +int unregister_kho_notifier(struct notifier_block *nb)
>> +{
>> +     return blocking_notifier_chain_unregister(&kho.chain_head, nb);
>> +}
>> +EXPORT_SYMBOL_GPL(unregister_kho_notifier);
>> +
>> +bool kho_is_active(void)
>> +{
>> +     return kho.active;
>> +}
>> +EXPORT_SYMBOL_GPL(kho_is_active);
>> +
> Why should these helpers be restricted to GPL code?


That's a simple one: Everything should be EXPORT_SYMBOL_GPL by default. 
You need to have really good reasons to export anything for non-GPL 
modules. I don't have a good reason for them, so it's GPL only :)


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
