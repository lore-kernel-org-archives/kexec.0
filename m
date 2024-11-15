Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCD0D6DDEC
	for <kexec@archiver.kernel.org>; Fri, 15 Nov 2024 09:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X8E6eVxLWOK+GWUhh6BU4TxxW/inMa7I4h3tnqFTYNo=; b=FlKZN4ZnSVO1OPgEQGBMC51+H/
	jVIpIlwh6j2UU91SCNiJ7V+bM5iM5sKhUqqoYw/qNi/EFaPNnufCeTKUXUHdSDD2DZNc/g92fFJbo
	3WlLzpo+YUI3bquN5IIvm9OQGtDpOfuBBaueJPyZErW5A1TuflhLXNMWt1mM6LQCMIHa5jkLl7MDg
	6qw64ndup3HT5gR72k1YWiqeUxMThpEs/J/4tRNv1hkGIcnqSJV7rk1BjUJD2WlwbOZdTAHr7oQhc
	UZag39njfVayM4DIBONTIPsoGGJmO910v/u5azrej6hhE1xzCh5hztcbetliMb46e3KNI1Q1gEo69
	53fqEbCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBt6p-00000002HEN-0yHd;
	Fri, 15 Nov 2024 09:59:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBt6m-00000002HDU-2jOn
	for kexec@lists.infradead.org;
	Fri, 15 Nov 2024 09:59:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731664759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X8E6eVxLWOK+GWUhh6BU4TxxW/inMa7I4h3tnqFTYNo=;
	b=Ji6hcrKCjjgGMliKtA4uonmL4654OFsbm2PoYANsWs2Cnbr7B3ZLcIjP4+X/csHo91lNZr
	RDU5ZqVGDOlqrKS7aTT0F2b46VVUNuY/VHfWRErh1jY7/htoSx+T4c1qqZn01+ZSM8pAg3
	zfXLMVpQZfaILJxBirzgr9+WeQ4fX8o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-XpxTuwwyOlGtDqhvG7ssWA-1; Fri, 15 Nov 2024 04:59:16 -0500
X-MC-Unique: XpxTuwwyOlGtDqhvG7ssWA-1
X-Mimecast-MFC-AGG-ID: XpxTuwwyOlGtDqhvG7ssWA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-381e8cf69a6so972471f8f.1
        for <kexec@lists.infradead.org>; Fri, 15 Nov 2024 01:59:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731664755; x=1732269555;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X8E6eVxLWOK+GWUhh6BU4TxxW/inMa7I4h3tnqFTYNo=;
        b=jv+sga9HPjVEtxqkKruwKCVsH79FADiEPv2lWPtTxOPuNClhy2FQIMR7QeHtWezsJs
         DGYlcYyc99oVQf6W6zY9Af4IEW5oFVJcUkVsLosYfAXCWpvBEQ2WmlJxNmAnQXEBTuqa
         0CzBPHT73+3nA3GqbRZwykyHVqU9oIAJI9wex+X5B266+Ru6ZHqXIohPC9f/3+PeVKzP
         WYmo91x/HEnBRuRnckAq8WYUlYLMT/MquJkvtBURlrZmWt3w4FvuP7tLBzSXmq/VF79f
         f3dQ/XIN6bMKDcepSORReAkHtGN7tHBjfwAXYb10rpIw5LK9DuQolyWcUjspzP7IVE/1
         WFHg==
X-Forwarded-Encrypted: i=1; AJvYcCXmAVxrv/0E/805AgFqTc1xqoj3ucBJZSu7NZ5nznmm6ctO62i5MPwuSUpJMdJKwsSabh5Gyw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxrxwWdNafFEe2dcz2T4MtixkKl3VGucr+gctsCZR1gL2CfJync
	paYsnF6pPwi91Ae4ZkGolS+HSNvLbMmWvFr7ljzrULACu+W82HlFrmw5npsgaDweRFMmQz3RrOn
	nJc8e0/TdBiIBmXyjycIpztQhgAjrKnIicEFzE3VcLvHOpn1ackbWZQBQTA==
X-Received: by 2002:a05:6000:2c6:b0:37d:3985:8871 with SMTP id ffacd0b85a97d-38225a92969mr1465105f8f.39.1731664755028;
        Fri, 15 Nov 2024 01:59:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZtrG1VPT+SoEB/3JsuRD2OwYh3OfRLaHmZweS8mwoREWkahoGdQaIQlreC1JDkXSdWnBgeA==
X-Received: by 2002:a05:6000:2c6:b0:37d:3985:8871 with SMTP id ffacd0b85a97d-38225a92969mr1465079f8f.39.1731664754683;
        Fri, 15 Nov 2024 01:59:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:8100:177e:1983:5478:64ec? (p200300cbc7218100177e1983547864ec.dip0.t-ipconnect.de. [2003:cb:c721:8100:177e:1983:5478:64ec])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae3102asm3937372f8f.93.2024.11.15.01.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 01:59:13 -0800 (PST)
Message-ID: <ca0dd4a7-e007-4092-8f46-446fba26c672@redhat.com>
Date: Fri, 15 Nov 2024 10:59:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/11] fs/proc/vmcore: move vmcore definitions from
 kcore.h to crash_dump.h
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kexec@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-5-david@redhat.com> <ZzcYEQwLuLnGQM1y@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZzcYEQwLuLnGQM1y@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xCaDX0hCkqCIJPe_vt0FAt-JW8Fa6Fdi4Xl58urAxd4_1731664755
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_015920_792657_70DC9F65 
X-CRM114-Status: GOOD (  15.96  )
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

On 15.11.24 10:44, Baoquan He wrote:
> On 10/25/24 at 05:11pm, David Hildenbrand wrote:
>> These defines are not related to /proc/kcore, move them to crash_dump.h
>> instead. While at it, rename "struct vmcore" to "struct
>> vmcore_mem_node", which is a more fitting name.
> 
> Agree it's inappropriate to put the defintions in kcore.h. However for
> 'struct vmcore', it's only used in fs/proc/vmcore.c from my code
> serching, do you think if we can put it in fs/proc/vmcore.c directly?
> And 'struct vmcoredd_node' too.

See the next patches and how virtio-mem will make use of the feactored 
out functions. Not putting them as inline functions into a header will 
require exporting symbols just do add a vmcore memory node to the list, 
which I want to avoid -- overkill for these simple helpers.

> 
> And about the renaming, with my understanding each instance of struct
> vmcore represents one memory region, isn't it a little confusing to be
> called vmcore_mem_node? I understand you probablly want to unify the
> vmcore and vmcoredd's naming. I have to admit I don't know vmcoredd well
> and its naming, while most of people have been knowing vmcore representing
> memory region very well.

I chose "vmcore_mem_node" because it is a memory range stored in a list. 
Note the symmetry with "vmcoredd_node"

If there are strong feelings I can use a different name, but 
"vmcore_mem_node" really describes what it actually is. Especially now 
that we have different vmcore nodes.

-- 
Cheers,

David / dhildenb


