Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031C2C46467
	for <kexec@archiver.kernel.org>; Mon, 16 Jan 2023 16:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P5Z5T9ng8ZVadmFgUONFFHo9puTDM9Y5rlyZzad5uKc=; b=cRVh/OFhQTgwRp
	vZoTadP1SzEGLJKJJFIjPCGca66mPiH1cojMWeHl2TW4sYewddoAIKrwK4+l+bHQAsUWjg1A5XD8p
	Bt/E8CYQ7uY9kFyUMOnmeCd3aJ+LG0kt2vwkgSmf8RrRclVx76j2KzoVcWLDYcCrfl7h4oF77psZd
	7JxK78JNR5w9GlBP4wo9poqkwwDx/SUo/xKzyz45sASs1AY2awNQQClj3fpC5/Xdtetr6sLPimfBy
	m9p+8gBwA7Hh24i8p+I/vQlxYhOR/4HEpX4sYKM1sgz4WLmQnzEZRV1aVoYlvrWM9USoqjgMFL2QD
	u7kb2Hif8uKR9tX3DSmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHSNI-00BNOq-18; Mon, 16 Jan 2023 16:30:20 +0000
Received: from bee.tesarici.cz ([2a03:3b40:fe:2d4::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHSNE-00BNLX-FN
	for kexec@lists.infradead.org; Mon, 16 Jan 2023 16:30:18 +0000
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-b985-910f-39e1-703f.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:b985:910f:39e1:703f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id E0D0413E0C9;
	Mon, 16 Jan 2023 17:30:08 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1673886609; bh=EWAvrD4RojL0LVOAIJLliUiQp4sAh2O0X95WyClxam4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=alOM8Qzex40r+j9quWCOGy7tiIciq8Q7+8fiyc9/pZhoxFF5X9wUKW3NqU+Iaq7p6
	 KTq6Qtohzbxc0PzE/MYr3dh7tf5HLtLEgZT1nUAC/zHWMSubGnajgAAgxK8TRiObis
	 G79qPHNI/lz08EJ9YJBczwh6sM5qfg7MxLxKlOCD/2tjLUjtoibZQaBH8v2SHAKYhd
	 fUDUzxjcAN/l7nU9lijkPyZY+eZ/YYDyWchZBnZ4BF/VldaIFy+tGTwKkYixVn4zjn
	 svympXbsTq8lyZUVakVP6liCaCU9Bo1OblIWUdR/3JR4PQ30FnveEN58ml2GozYFIL
	 xKShC5ULUX+fw==
Date: Mon, 16 Jan 2023 17:30:05 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
 dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 nramas@linux.microsoft.com, thomas.lendacky@amd.com, robh@kernel.org,
 efault@gmx.de, rppt@kernel.org, david@redhat.com, konrad.wilk@oracle.com,
 boris.ostrovsky@oracle.com
Subject: Re: [PATCH v15 1/7] crash: move crash_prepare_elf64_headers()
Message-ID: <20230116173005.21bd7b67@meshulam.tesarici.cz>
In-Reply-To: <b3f3a4e5-35e7-2cb4-f754-f425da094f28@oracle.com>
References: <20221209153656.3284-1-eric.devolder@oracle.com>
	<20221209153656.3284-2-eric.devolder@oracle.com>
	<09567e13-c5ed-d1b9-027c-9340fce6a0a8@linux.ibm.com>
	<b3f3a4e5-35e7-2cb4-f754-f425da094f28@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230116_083017_088950_47E12260 
X-CRM114-Status: GOOD (  15.34  )
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

Hi Eric,

On Thu, 12 Jan 2023 11:23:18 -0600
Eric DeVolder <eric.devolder@oracle.com> wrote:

>[...]
> After looking into this for a bit, to allow hotplug without kexec_file would require quite a bit of 
> code movement. Why? Because hotplug is basically built on top of (part of) the infrastructure that 
> was needed for kexec_file.
> 
> I'd be inclined to suggest that KEXEC_FILE be a required dependency for CRASH_HOTPLUG, ie:
> 
>   config CRASH_HOTPLUG
>          bool "Update the crash elfcorehdr on system configuration changes"
>          default n
> -       depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
> +       depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
> 
> 
> If that isn't feasible, then it would appear quite a bit of surgery is needed to properly separate 
> out the items hotplug needs from kexec_file.
> 
> Thoughts?

I would have thought that CPU hotplug can be handled in the kernel only
if the crash image was loaded by the kernel with kexec_file_load(2).
When the image is loaded with kexec_load(2), then all data structures
are prepared by the user-space utility kexec(8), and the kernel
generally has no idea how to handle them.

In short, I believe that by definition there must be this dependency of
CRASH_HOTPLUG on KEXEC_FILE.

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
