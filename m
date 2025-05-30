Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EAAC3ABB2
	for <kexec@archiver.kernel.org>; Fri, 30 May 2025 08:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Dzf/b6l9QGCtMTCvICyRITM8gExIaAXao9oUV4gRsA=; b=TT67DNYKD2Pr+gNpCRLioUK618
	lUltf2wt6Y+2QnjCrTgOOa/z/CBbBrUi/w3JJRlK9J1MyPRZ9x6dsILZn1PgW6QPs0tiIavJsD+gc
	5reAjhCAA8bzdBl9LSM3YHG3nYlDc0OA2qw7MNw5TEZle69bDl909/gZQ07Id+MDwji1Pa2Y41UFb
	uDq6ckkTEv2JP6GSbK8joOmOGI5NQWvq8UhSjAs3sA6BmbWQhg1xfzXoMBf0IfkS2lIbBK5Yktltk
	l1T6JyZeaF8Yk5O62/WkTOYUz75/5vhSZhgL1Hy6yOaOUFmbwvZ0EJ+VeYIsE+NSDYX1IvjNUDmku
	MUikcVKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKv2u-0000000HatC-1NgL;
	Fri, 30 May 2025 08:24:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKula-0000000HYR6-0KYc
	for kexec@lists.infradead.org;
	Fri, 30 May 2025 08:07:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748592420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6Dzf/b6l9QGCtMTCvICyRITM8gExIaAXao9oUV4gRsA=;
	b=b/FLCOQmyO6YaAyO57zd3kMrnWVfPfLjewa2KHIKGTzqqIRCkaRK2Y/md9vMetBLhzzjxx
	veSPpTK+rurYBxw+7aZfAJHEdCQhzzVcbRsvjckkGLItWlQOAA5A192+i97tvyfGWXWIKm
	Pe6BsYyPzlY8wDH2LBEcQBfWci8rAu0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-uvhn3cPmOL-6XI48PmsMew-1; Fri, 30 May 2025 04:06:58 -0400
X-MC-Unique: uvhn3cPmOL-6XI48PmsMew-1
X-Mimecast-MFC-AGG-ID: uvhn3cPmOL-6XI48PmsMew_1748592417
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4edf5bb4dso987880f8f.0
        for <kexec@lists.infradead.org>; Fri, 30 May 2025 01:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748592414; x=1749197214;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Dzf/b6l9QGCtMTCvICyRITM8gExIaAXao9oUV4gRsA=;
        b=JQ0f4eq26R+Ga5CiY9QBZ96H3FbXROkm3d51aE716+FkJyxS6XXNzM9HdUHDFJHv/i
         Syhe3EkOTjCKsRTJlNxJVSps/KvaO4yR/RUTMGASYRrpYeswy5NM1XyZTFDzusAzaGNr
         YI8ZMJGA/k4Tkkx4+19n6zTmRwlAUvwO99gNIEIB527Yw0jGxZrebBoubzHJ/c8VVXoH
         yZZ4l1b0LXzzhOsHaRkIO/Ik9efpkrNAkq4GHp2ghbZeZ8RfJgC4BbrhMWxM/Sp6ZGeZ
         Rva1yFV6vqfg2BmWBq5bb0cdYx0yiYVTi3lnzCdqFglv84mEW8tB8M0Bw0BKLDGFTK7h
         zivA==
X-Forwarded-Encrypted: i=1; AJvYcCUHJs4w7PHPR5lFVzdv1knE9VOBReuAn+GO72KRvWNT8QKmIR5j8UVE6ZipkZIKOCrX2PM/GQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywiz1jdAEFhMEbXy7QBfOocRxwhpNI9JsC16OWXzYdIdGEHBca3
	fZIgPUXLlR8gRzAwEg2mDrUXK8gf0T1Pkedf9/7990FjV/pwH/GokeGjUcYPaJjC8dtMeU5Mlb7
	0+YDbjQvW5E8idQn17h5/bFOqMuJX02hnr7f5iDhjHURW/HsiP7MjDcooK4MkRg==
X-Gm-Gg: ASbGncsvm7ZT5hiWg7GP1XAJfks0yt9M8VRTLIbK7c70nHmQ8/+ByktGdT4fkv/oGIx
	Vc0O4yKKjtgp9D891MB24hpvz00YI67fARb56oYo3HieOcezmc19uurQeGexT5K4iEbEoKSBjcf
	fxRzYnz8IhkWimH37iILS5JYAAutqZRhPtwrSKTImUt5EJUxkvUbSo4YTa/9IfwZOp2fAQpodnI
	hPq8CO4RgZPncaMrZvWJm8MecfN2TY5AFg73zvYqbWZHGUERHKPIvLSs16uzDVDCuGzVBFOwhPz
	xzEPS+qqwzZ4d3+OfRIRQCv2tCLWkhXEwAuRgUKwj52lz+cSzO1E2okHrOOT4AciRt0YlXNx+uB
	QC8Vgs3yoaOvLzy+B5LSbBoxjn/zeOq+NnRouCMU=
X-Received: by 2002:a5d:4e84:0:b0:3a4:f7e6:2b29 with SMTP id ffacd0b85a97d-3a4f7e62b33mr1233189f8f.5.1748592414508;
        Fri, 30 May 2025 01:06:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFitKTov933TL6/U7IMqJv7qvimg/JjiUTLT8m5lvXzWlGBTnGMyap/xgTwc/uDHj8b7FUqpQ==
X-Received: by 2002:a5d:4e84:0:b0:3a4:f7e6:2b29 with SMTP id ffacd0b85a97d-3a4f7e62b33mr1233158f8f.5.1748592414107;
        Fri, 30 May 2025 01:06:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f03:5b00:f549:a879:b2d3:73ee? (p200300d82f035b00f549a879b2d373ee.dip0.t-ipconnect.de. [2003:d8:2f03:5b00:f549:a879:b2d3:73ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe2b35dsm4136917f8f.0.2025.05.30.01.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 01:06:53 -0700 (PDT)
Message-ID: <a1a5af90-bc8a-448a-81fa-485624d592f3@redhat.com>
Date: Fri, 30 May 2025 10:06:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] kdump: crashkernel reservation from CMA
To: Michal Hocko <mhocko@suse.com>
Cc: Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>,
 Jiri Bohac <jbohac@suse.cz>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
 Philipp Rudo <prudo@redhat.com>, Pingfan Liu <piliu@redhat.com>,
 Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <dhildenb@redhat.com>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
 <04904e86-5b5f-4aa1-a120-428dac119189@redhat.com>
 <427fec88-2a74-471e-aeb6-a108ca8c4336@redhat.com>
 <Z8Z/gnbtiXT9QAZr@MiWiFi-R3L-srv>
 <e9c5c247-85fb-43f1-9aa8-47d62321f37b@redhat.com>
 <aDgQ0lbt1h5v0lgE@tiehlicka>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aDgQ0lbt1h5v0lgE@tiehlicka>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ImYi0fFox6ozSMf1oYxYa1HY1WPf0gZRNkjmeTKk-ng_1748592417
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250530_010702_214669_3DBF7C1C 
X-CRM114-Status: GOOD (  15.87  )
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

On 29.05.25 09:46, Michal Hocko wrote:
> On Wed 28-05-25 23:01:04, David Hildenbrand wrote:
> [...]
>> I think we just have to be careful to document it properly -- especially the
>> shortcomings and that this feature might become a problem in the future.
>> Movable user-space page tables getting placed on CMA memory would probably
>> not be a problem if we don't care about ... user-space data either way.
> 
> I think makedumpfile could refuse to capture a dump if userspace memory
> is requested to enforce this.

Yeah, it will be tricky once we support placing other memory on CMA 
regions. E.g., there was the discussion of making some slab allocations 
movable.

But probably, in such a configuration, we would later simply refuse to 
active CMA kdump.

> 
>> The whole "Direct I/O takes max 1s" part is a bit shaky. Maybe it could be
>> configurable how long to wait? 10s is certainly "safer".
> 
> Quite honestly we will never know and rather than making this
> configurable I would go with reasonably large. Couple of seconds
> certainly do not matter for the kdump situations but I would go as far
> as minutes.

I recall that somebody raised that kdump downtime might be problematic 
(might affect service downtime?).

So I would just add a kconfig option with a default of 10s.

But even better if we can avoid the kconfig and just make it 10s for all 
setups.

I would not suggest having a different (runtime/boottime) way of 
configuring this.

-- 
Cheers,

David / dhildenb


