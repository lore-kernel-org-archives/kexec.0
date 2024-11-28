Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FC7D6911B
	for <kexec@archiver.kernel.org>; Thu, 28 Nov 2024 15:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:CC:To
	:From:Subject:Message-ID:Date:Content-Type:Content-Transfer-Encoding:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z2xmP1cZOfYevSvzD/k3N5akpqcpBaaiEKDmAcJtr6A=; b=D6PdyPDqu6y1fEvCVlK45H5IOm
	xIE/xkshKoThH5Ihf6NbKE4niM/XlXJbrDHzs/jVcgCKjvMj6R9yHc0IkpyQjNuO1mxy0iejSG69b
	ZgTZ/PHba0KB0N92tG9UgxHMvwqYLX6oFDMUM3u9pcD31nXS3h9yP+x6j6FUTthBIFPUba0Kyf7y3
	gnfWLlnfoQVEEXW5GTievERt2j+wXlSXizw1YtuzqzUA/lL88/vSMt/k76u46b0UOOy6vRQjRULZ9
	rhpaPvU4wXvSadVn50cFoqiB7kIlZ0ZnoKGqumkVc3LQq1wFA8OHqhJxSM/Nlrcb4Xa2x2fjdQ8F9
	Lp98l09Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGguT-0000000Fwqm-1Dk7;
	Thu, 28 Nov 2024 15:58:29 +0000
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGguK-0000000FwpM-1CT2
	for kexec@lists.infradead.org;
	Thu, 28 Nov 2024 15:58:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732809500; x=1764345500;
  h=mime-version:content-transfer-encoding:date:message-id:
   subject:from:to:cc:references:in-reply-to;
  bh=z2xmP1cZOfYevSvzD/k3N5akpqcpBaaiEKDmAcJtr6A=;
  b=B4T1dCDI9+GQDZPGLhayHG2WyY0pZ5vmZlL06vyNXZMPjGNFulpY3+g8
   zYjL+scHYkktrYj4JNHaLQnsJdDgFMs1KRaYqkO+kjN21arVktyAMW43w
   uLNOcYTUXDeUnOxxiA5x3GMBMgGpwxb5xiibYCG93Vpx+Jwg1k1A/9r7d
   w=;
X-IronPort-AV: E=Sophos;i="6.12,192,1728950400"; 
   d="scan'208";a="389106589"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 15:58:11 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:12251]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.26.116:2525] with esmtp (Farcaster)
 id aa97e48e-099c-4014-b6d4-1285e8d7c9c0; Thu, 28 Nov 2024 15:58:10 +0000 (UTC)
X-Farcaster-Flow-ID: aa97e48e-099c-4014-b6d4-1285e8d7c9c0
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 28 Nov 2024 15:58:10 +0000
Received: from localhost (10.13.235.138) by EX19D004EUC001.ant.amazon.com
 (10.252.51.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Thu, 28 Nov 2024
 15:58:05 +0000
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 28 Nov 2024 15:58:02 +0000
Message-ID: <D5XXP2PU3PUK.3HN27QB1GEW09@amazon.com>
Subject: Re: [PATCH v2 2/2] x86/efi: Apply EFI Memory Attributes after kexec
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: Dave Young <dyoung@redhat.com>
CC: Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H . Peter Anvin"
	<hpa@zytor.com>, Matt Fleming <matt@codeblueprint.co.uk>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stanspas@amazon.de>, <nh-open-source@amazon.com>, <stable@vger.kernel.org>,
	<kexec@lists.infradead.org>
X-Mailer: aerc 0.18.2-100-gc2048ef30452-dirty
References: <20241112185217.48792-1-nsaenz@amazon.com>
 <20241112185217.48792-2-nsaenz@amazon.com>
 <CALu+AoTnrPPFkRZpYDpYxt1gAoQuo_O7YZeLvTZO4qztxgSXHw@mail.gmail.com>
In-Reply-To: <CALu+AoTnrPPFkRZpYDpYxt1gAoQuo_O7YZeLvTZO4qztxgSXHw@mail.gmail.com>
X-Originating-IP: [10.13.235.138]
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_075820_819559_D55AE984 
X-CRM114-Status: GOOD (  10.84  )
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

Hi Dave,

On Fri Nov 22, 2024 at 1:03 PM UTC, Dave Young wrote:
> On Wed, 13 Nov 2024 at 02:53, Nicolas Saenz Julienne <nsaenz@amazon.com> =
wrote:
>>
>> Kexec bypasses EFI's switch to virtual mode. In exchange, it has its own
>> routine, kexec_enter_virtual_mode(), which replays the mappings made by
>> the original kernel. Unfortunately, that function fails to reinstate
>> EFI's memory attributes, which would've otherwise been set after
>> entering virtual mode. Remediate this by calling
>> efi_runtime_update_mappings() within kexec's routine.
>
> In the function __map_region(), there are playing with the flags
> similar to the efi_runtime_update_mappings though it looks a little
> different.  Is this extra callback really necessary?

EFI Memory attributes aren't tracked through
`/sys/firmware/efi/runtime-map`, and as such, whatever happens in
`__map_region()` after kexec will not honor them.

> Have you seen a real bug happened?

If lowered security posture after kexec counts as a bug, yes. The system
remains stable otherwise.

Nicolas

