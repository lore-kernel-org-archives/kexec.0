Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA1EC10F1B
	for <kexec@archiver.kernel.org>; Wed, 21 Dec 2022 15:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1432PFZzO0ucak5O5NsXPRgjTxt2L/11I+FMnfnLi8I=; b=lwx6hcmLzi6hjz
	oiaz0cT1StgrAGGrfT/NcpBKTZHTtum+UUAHzzXmv7xtghhNDNKTfJBgQIh8YGM+GSzbl3lbQe+Cs
	L+5Smooxzz7WHjRjgqzj4kTefCB7KMzOuoeXWPtmE1uxm6CRupX2/pdcQAPlSAEvf/JCmKIorpIOI
	Nn1FYP674+6xKNoNk7S9peMFFJXqfMdemlfeqiDDideqLrm3WlYJEk1zIs3VCmZ90OCJ+JkY+c4xg
	9hIdKB8V9NX1o1ABDoKpaIQS8Ozww3+7sL4f4Kr8IYgW2JMWSO93vwDxVnKTWNO37DeogdKYpqg4x
	EvypLRfJ7J6wvP6krx4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p81JX-00GcWO-E0; Wed, 21 Dec 2022 15:47:27 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p81JT-00GcJS-Uz
	for kexec@lists.infradead.org; Wed, 21 Dec 2022 15:47:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WMvM3oIiYKel5HPXqZ0wwZClubdzV5QaZHrYn2xq4Js=; b=H4uE0QPetyV6wWmK/W9fnNlXos
	2pHteCy74MP5gpU+YESUl4xuXHRtqxahK3xludCQtQzK9OfPx7qLa1KLs3ELbFpW5I1kC9wGCk8Fu
	mfLAT/rdyCAeILUFWL9GFbqc5S1m40SeI6STM5OAGJV3wWotRcHS07RJVFZdtsNWK08FZh0yuCuS3
	vT0OTlvGTTqDEwV+vCZKMoaQW0BXkl1NgU53OX138Wmvlk708ggE4hCA3dmkWSmr6HTYBO+Vdi6LD
	8z6ZV9wfcjka58WIZIlLC2WUs8XleCxfvahrHIPNtjdf3XKpz6htcRr6Y/kWDDdX3rnh6exvvy0BD
	kktjH1YQ==;
Received: from [177.103.98.201] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1p81J8-007ZDo-1S; Wed, 21 Dec 2022 16:47:02 +0100
Message-ID: <efe7e25e-8b05-90e7-fc02-4f1dc84fe324@igalia.com>
Date: Wed, 21 Dec 2022 12:46:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: kdump kernel randomly hang with tick_periodic call trace on bare
 metal system
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: x86@kernel.org, kexec@lists.infradead.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <Y6FJgh3fOYoF0wSV@MiWiFi-R3L-srv>
 <Y6FK++b4buO5EgjD@MiWiFi-R3L-srv> <Y6FNTFbH9DbhEogg@MiWiFi-R3L-srv>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <Y6FNTFbH9DbhEogg@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221221_074724_091360_7CADF6E6 
X-CRM114-Status: UNSURE (   8.37  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 20/12/2022 02:51, Baoquan He wrote:
> On 12/20/22 at 01:41pm, Baoquan He wrote:
>> On one intel bare metal system, I can randomly reproduce the kdump hang
>> as below with tick_periodic call trace. Attach the kernel config for
>> reference.
> 
> Forgot mentioning this random hang is also caused by adding
> 'nr_cpus=2' into normal kernel's cmdline, then triggering crash will get
> kdump kernel hang as below kdump log shown.
> 

The weird thing is that you seem to be using "nr_cpus=1" instead - this
is the cmdline from the log:

"nr_cpus=2 irqpoll nr_cpus=1 reset_devices cgroup_disable=memory mce=off
numa=off udev.children-max=2 panic=10 acpi_no_memhotplug
transparent_hugepage=never nokaslr hest_disable novmcoredd cma=0
hugetlb_cma=0 disable_cpu_apicid=16 [...]"

You seems to pass twice the "nr_cpus" thing, and I guess kernel pick the
last one?

Also, what is "disable_cpu_apicid=16"? Could this be related?


Thanks for the report!
Cheers,


Guilherme




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
