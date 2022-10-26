Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CD0C433FE
	for <kexec@archiver.kernel.org>; Wed, 26 Oct 2022 14:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:Subject:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/rDuVdfcaZ1j30GaEjmForZB1uJD9KODR79F10VjWjo=; b=TNIyRJI6RmYb4L
	LLccZVTp9bLlh3CmLYbbhzQqWXzvl8WTZB+l5BGT+aWN+IkPBkMBt4j6v4FexsirBI0WvFYR6v0Wh
	mMn5eOpAlgFhX3Schv8aSxato1AINz6ergPGj8NF54qtiH1lCM4k/T1tnKUMwvSX5IRmnXpMRBbs5
	CMk5mb1cFmF5H37VYQSF7XnB5mTu9wI3XScRsItsq1+c8qCpck65MwugcH3wIqm/S/2C6T/YZofSd
	fwB45xuNPcImeKkYtqkl2ESskYffQSZ4lHpb+CWUCYTi6wZXRAQvK/th12v8B2FG5MMv+ZsI/wwWN
	rGVCx17VVes+RHWhEyWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onhnk-009lLe-Q5; Wed, 26 Oct 2022 14:54:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onhnh-009lJ7-2P
	for kexec@lists.infradead.org; Wed, 26 Oct 2022 14:54:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666796075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8jRuzj8aI2I9CbJusoP/+rcWnTpr8peB8CRFVJrzDj8=;
	b=e+rJYr5JnsAEdSHO+sqs7TgNNbkpckzOXkM/r3ynanMfLwFysJN/UV2p/y6vn1tB3JeZ87
	oizkrh8v4HAXIfWNSDqauc5Dq944YYXmhFQuiO2UWtvwBymRbld9kgR7viuLvQvmMIjWQJ
	E1DKfGLKs2ubvBmn1xi6Kb0E4J9aZJw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-665-5-2pEYeRNs2232TE05D6bQ-1; Wed, 26 Oct 2022 10:54:34 -0400
X-MC-Unique: 5-2pEYeRNs2232TE05D6bQ-1
Received: by mail-wr1-f70.google.com with SMTP id c18-20020adfa312000000b002364fabf2ceso6077961wrb.2
        for <kexec@lists.infradead.org>; Wed, 26 Oct 2022 07:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jRuzj8aI2I9CbJusoP/+rcWnTpr8peB8CRFVJrzDj8=;
        b=ceT/OYSyVeu0L9kXQtOrhRtspt1BQXNk0PuiFMM0ao0dr7zSMYpdvglD6v+5czZbn8
         I+memT8EQRFBRPFnfQi6zghEEpPHDrU14l8WORiAmI7Yxj5/Hm0T1H0kfNLMfqJa1rt9
         3sSe5zjwFR+0Nx0eQEY3Kjb5FZdNhywPlGpbMZvYBIQZKbBOINpVwQqjdDkPkUTSD0SX
         rqHEU01PhHXyg/2nMFTQ0ckr3dUZqQD2lGcEZA3AxXQV72kTukmTWd+hrjn4ei8j6I3d
         BgsD7UBOLe3T91lDDsqpXKdHhDpDNrrPOrfCGCBl4+3z0EWssXdsl7fOvV9ZzRBlMpwE
         qPWg==
X-Gm-Message-State: ACrzQf1eURiJIJYzd6HdNFqP/zCwEZXiXVtfj/rt3dsN6r+H1BOnok8W
	N5IYj5sbxkTwvQH/KG1Lexio+jyrsdcbdw0IIJzRhylA3Cn3M0JCl05nI+0nRZ6oHoSWNsbudp0
	d8iWRy0/hUmq3AAky6mOr
X-Received: by 2002:adf:f6c9:0:b0:236:547f:698a with SMTP id y9-20020adff6c9000000b00236547f698amr18358541wrp.180.1666796073170;
        Wed, 26 Oct 2022 07:54:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM58Oi6r6VCYZDISEQe29opH4/96LoWRdQ0kTHG43cIiSkE59tlwcXeKwFPxUQIGviW/ZHEPNw==
X-Received: by 2002:adf:f6c9:0:b0:236:547f:698a with SMTP id y9-20020adff6c9000000b00236547f698amr18358523wrp.180.1666796072882;
        Wed, 26 Oct 2022 07:54:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:5b00:c9f4:7535:9360:70d7? (p200300cbc7065b00c9f47535936070d7.dip0.t-ipconnect.de. [2003:cb:c706:5b00:c9f4:7535:9360:70d7])
        by smtp.gmail.com with ESMTPSA id j9-20020adfe509000000b0023647841c5bsm5663674wrm.60.2022.10.26.07.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 07:54:32 -0700 (PDT)
Message-ID: <d2ce1bed-a053-4840-2e84-643b678392c1@redhat.com>
Date: Wed, 26 Oct 2022 16:54:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
To: Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc: Eric DeVolder <eric.devolder@oracle.com>,
 Oscar Salvador <osalvador@suse.de>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org,
 kexec@lists.infradead.org, ebiederm@xmission.com, dyoung@redhat.com,
 vgoyal@redhat.com, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
 thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de, rppt@kernel.org,
 sourabhjain@linux.ibm.com, linux-mm@kvack.org
References: <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
 <Yzceb/y3SSFMuALR@zn.tnic> <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com>
 <YzcqE1RVtPcuLlxN@zn.tnic> <Y0Dh4ieUUZ4oXa1/@MiWiFi-R3L-srv>
 <Y0b9apyIs+RpSo1e@zn.tnic> <53aed03e-2eed-09b1-9532-fe4e497ea47d@oracle.com>
 <Y0cmaPTKQuWtwIRh@zn.tnic> <Y0d+mFivS+88+Chr@MiWiFi-R3L-srv>
 <Y1e7Hw0PRDI9NxU9@zn.tnic> <Y1lIoTBNvHrKX5K9@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
In-Reply-To: <Y1lIoTBNvHrKX5K9@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_075437_222326_D90C6470 
X-CRM114-Status: GOOD (  18.29  )
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

On 26.10.22 16:48, Baoquan He wrote:
> On 10/25/22 at 12:31pm, Borislav Petkov wrote:
>> On Thu, Oct 13, 2022 at 10:57:28AM +0800, Baoquan He wrote:
>>> The concern to range number mainly is on Virt guest systems.
>>
>> And why would virt emulate 1K hotpluggable DIMM slots and not emulate a
>> real machine?

IIRC, ACPI only allows for 256 slots. PPC dlpar might provide more.

> 
> Well, currently, mem hotpug is an important feature on virt system to
> dynamically increase/shrink memory on the system. If only emulating real
> machine, it won't be different than bare metal system.
> 
> IIRC, the ballon driver or virtio-mem feature can add memory board, e.g
> 1G, block size is 128M, 8 blocks added. When shrinking this 1G memory
> later, it will take best effort way to hot remove memory. Means if any
> memory block is occupied, it will be kept there. Finally we could only
> remove every second blocks, 4 blocks altogether. Then the left
> un-removed blocks will produce 4 separate memory regions. Like this, a
> virt guest could have many memory regions in kernel after memory
> being added/removed.
> 
> If I am wrong, Please correct me, David.

Yes, virtio-mem (but also PPC dlpar) can result in many individual 
memory blocks with holes in between after hotunplug. Hotplug OTOH, 
usually tries to "plug" these holes and reduce the total number of 
memory blocks. It might be rare that our range will be heavily 
fragmented after unplug, but it's certainly possible.

[...]

> 
> Yes, now assume we have a HPE SGI system and it has memory hotplug
> capacity. The system itself has already got memory regions more than
> 1024. Then when we hot add extra memory board, we want to include the
> newly added memory regions into elfcorehdr so that it will be dumped out
> in kdump kernel.
> 
> That's why I earlier suggested 2048 for number of memory regions.

The more the better, unless "it hurts". Assuming a single memory block 
is 128 MiB, that would be 256 GiB.

Usually, on big systems, the memory block size is 2 GiB. So 4 TiB.

-- 
Thanks,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
