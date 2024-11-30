Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FECD7360E
	for <kexec@archiver.kernel.org>; Sat, 30 Nov 2024 20:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=is582WBBi937WdWYFufHhkkhP+21AhVYgF4uiSgdXuo=; b=GopW3p8NGMKBRF+9i/VGr9D1fX
	eNvTJ2hrwa4T6c9QKtbE9goAspKbmY7+2wO5mgQvY/SlTSNP5bVQrwBRIWQJ9UOH7b/U5VVgZo8Z8
	jzN5zMqr17GOwCNodN0Z8f6LlpfAPckYsoNa3kf0F5fgZsFyL9OCsQ6vi3mpYWYGqdMNSAunnhjIh
	lKC/WrIXOB6xbvbmmQSW8BoGXhJ5/O/rgHWXpdz10q/Nutyetgstfng9QxmQt9IUuIsKcXNZrIyoj
	LLDANOfBEH02UKdygugVj8RJJEbTKowMJXNejh3qHwNxQWITvBiYdx383bkGs5PFXRpv+lZEQN3rF
	9vxHw00A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tHTo7-00000002Vma-1Z7v;
	Sat, 30 Nov 2024 20:11:11 +0000
Received: from smtp-fw-52005.amazon.com ([52.119.213.156])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tHTo4-00000002Vlz-0f0v;
	Sat, 30 Nov 2024 20:11:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732997468; x=1764533468;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=is582WBBi937WdWYFufHhkkhP+21AhVYgF4uiSgdXuo=;
  b=TZZeCmk/s8NmYk/qCEF2p74m5GMpRI9BEJdaTVy/zTjABhI01IBc0lao
   Wf4roLsCTLrvbslNNPa1+bUVLuQpgPl36v/1IH9kX9nltkINa7ihnqX7m
   68QCSdI/vONiiSqw465xZOGyAForR9aM7Sk8oLfSi5eVSZBeTfKE7gneN
   k=;
X-IronPort-AV: E=Sophos;i="6.12,199,1728950400"; 
   d="scan'208";a="699401236"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 20:11:01 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.10.100:31389]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.11.83:2525] with esmtp (Farcaster)
 id 120978b2-243c-4482-ad00-e4a375ddd09f; Sat, 30 Nov 2024 20:11:00 +0000 (UTC)
X-Farcaster-Flow-ID: 120978b2-243c-4482-ad00-e4a375ddd09f
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sat, 30 Nov 2024 20:11:00 +0000
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sat, 30 Nov 2024 20:10:59 +0000
Received: from EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d]) by
 EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d%3]) with mapi id
 15.02.1258.034; Sat, 30 Nov 2024 20:10:59 +0000
From: "Farber, Eliav" <farbere@amazon.com>
To: Thomas Gleixner <tglx@linutronix.de>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>, "mpe@ellerman.id.au"
	<mpe@ellerman.id.au>, "npiggin@gmail.com" <npiggin@gmail.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"naveen@kernel.org" <naveen@kernel.org>, "maddy@linux.ibm.com"
	<maddy@linux.ibm.com>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "ebiederm@xmission.com" <ebiederm@xmission.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "bhe@redhat.com"
	<bhe@redhat.com>, "hbathini@linux.ibm.com" <hbathini@linux.ibm.com>,
	"sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>,
	"adityag@linux.ibm.com" <adityag@linux.ibm.com>, "songshuaishuai@tinylab.org"
	<songshuaishuai@tinylab.org>, "takakura@valinux.co.jp"
	<takakura@valinux.co.jp>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: "Chocron, Jonathan" <jonnyc@amazon.com>
Subject: RE: [PATCH v4 2/2] kexec: Prevent redundant IRQ masking by checking
 state before shutdown
Thread-Topic: [PATCH v4 2/2] kexec: Prevent redundant IRQ masking by checking
 state before shutdown
Thread-Index: AdtDY+7g3Mjx3Vru6kGTSk5UpEUWVw==
Date: Sat, 30 Nov 2024 20:10:59 +0000
Message-ID: <0e467b4c2bc34eb59c8f23f36a9a6956@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.85.143.175]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241130_121108_466579_70F8B2DF 
X-CRM114-Status: UNSURE (   5.90  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 11/29/2024 3:32 PM, Thomas Gleixner wrote:
>> This patch addresses the issue by:
>
> Again:  git grep 'This patch' Documentation/process/
Done (in v5 series)

