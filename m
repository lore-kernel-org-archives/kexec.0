Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE333E732FD
	for <kexec@archiver.kernel.org>; Thu, 28 Sep 2023 17:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sd3eNrsOkAmGrTRGe/3IyjCQ/ykX1z36s9AKSV2v4ao=; b=tlOlF9Lou30TvF
	6zTXohPF7t34/9e3sUc64WfGEYh2Mmrnw6M3bbgIpmNWpd6W0qYSq1MyxHmKVlJnZkxuSm7JGWezK
	SqYyFntu+2KqaPTZTDdFToO0oUlTaXo2mNdBjczVrdJFbMSg24dxEQ1PimIcJAFyhVJ0d9LaTFZ3t
	wV0hjrgMpLClsaT8Nf6i9WKSu2o5V8+G+vDOerTzKiUneFRFZHSfvW1F/aDKeFR1UFR/j0R0b77dL
	ki8mgw73tCdLbxP76JZ3ipfcEb7T6kaCwJX8FRzL5SV5yTMuIp5m5nTSyD4iYvfPBbCKGKq9k7do3
	XYDRJ+jqJPaWgBJngsnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qluvQ-006RQb-1U;
	Thu, 28 Sep 2023 17:35:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qluvM-006RNw-0b
	for kexec@lists.infradead.org;
	Thu, 28 Sep 2023 17:35:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695922537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhJQz2nsCHp2m+57NVX3KFHSV/EDTbVztb5rANet7Mk=;
	b=AfbKWxAV8Z4Qj4NMqWIFy1uA10sRE5DzBsl1ZS9h83tRtYUcYSxIvF9G7AmepLTdYP7UL3
	/aaurcBVcZbId/oxPL98dxdpD41MsWRQWcUhi4nX1PvvleU9QQ6lj3mjYrBkYt/BNAGPxL
	GrF9+As0qB2rg2J0ovhntIEPGb5Tok8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-hazlMqc8OD-WQO79YCJFSw-1; Thu, 28 Sep 2023 13:35:35 -0400
X-MC-Unique: hazlMqc8OD-WQO79YCJFSw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4065478afd3so4112005e9.0
        for <kexec@lists.infradead.org>; Thu, 28 Sep 2023 10:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695922534; x=1696527334;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bhJQz2nsCHp2m+57NVX3KFHSV/EDTbVztb5rANet7Mk=;
        b=I2Z4Bh0LTmd8sAD90EEqlaYXt56uHsTieJ/DNNjCRSrmWgpcJ30WBSQ9Nb9iVd+cgI
         F+dWJMQt7DnullyBfFo+/t+2j/ja8XvkBCOb2Y0vUSY3FXadWguvjb4QvfYILDTunY/P
         WkuYX191cskl7yEj0TNEPQcIC2ol79olc9ZvrcG5nwtMvDfsJ9mf0YR6L1tID+sEtkec
         j96DGQAlegFlTn9LMUn8KMSk55O7GGvor5jmDIB/irowIUq0sDam6JCp+2uhs1zZCSjk
         WvgSPeXSmYO4c8umItuvY3KmIURhsXK9U3Qt/M5f70e1K8ul36EOLJjhEVLSHwHgFYMJ
         cmDQ==
X-Gm-Message-State: AOJu0Yz4VVm9Q8RVLh2fk0ovDllay+uyB8Z4yvi/79FRMdIFmGUCEAm5
	lpY3sBBfH8KY2AJDGkRi2oCXEMkZi7yYh/3yaXzyZbeGrX+bzBAdwtYpimoIBE21wtzyqVtuTXR
	6dhFqSURC4fYddTBG/x82
X-Received: by 2002:a7b:cd95:0:b0:405:95ae:4a94 with SMTP id y21-20020a7bcd95000000b0040595ae4a94mr1736586wmj.5.1695922534551;
        Thu, 28 Sep 2023 10:35:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1D4mtRbNaTqnzKHYbzNWGSnEHm8nnG9RRLTvd9ee4kE9dx1bCsUvsR1IDCdX32RkbnUVjNw==
X-Received: by 2002:a7b:cd95:0:b0:405:95ae:4a94 with SMTP id y21-20020a7bcd95000000b0040595ae4a94mr1736570wmj.5.1695922534181;
        Thu, 28 Sep 2023 10:35:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:f00:b37d:4253:cd0d:d213? (p200300cbc7180f00b37d4253cd0dd213.dip0.t-ipconnect.de. [2003:cb:c718:f00:b37d:4253:cd0d:d213])
        by smtp.gmail.com with ESMTPSA id x5-20020a05600c21c500b0040644e699a0sm4315192wmj.45.2023.09.28.10.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 10:35:33 -0700 (PDT)
Message-ID: <fa924c8d-c954-5612-37eb-43e1976a1b7b@redhat.com>
Date: Thu, 28 Sep 2023 19:35:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 0/7] Introduce persistent memory pool
To: Dave Hansen <dave.hansen@intel.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Baoquan He <bhe@redhat.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 ebiederm@xmission.com, akpm@linux-foundation.org,
 stanislav.kinsburskii@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 kys@microsoft.com, jgowans@amazon.com, wei.liu@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, graf@amazon.de, pbonzini@redhat.com
References: <01828.123092517290700465@us-mta-156.us.mimecast.lan>
 <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv> <20230927161319.GA19976@skinsburskii.>
 <ee1907a1-2f04-cfa3-9f09-75b94994e88b@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ee1907a1-2f04-cfa3-9f09-75b94994e88b@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_103540_294812_EC8D7D08 
X-CRM114-Status: GOOD (  10.64  )
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

On 28.09.23 15:22, Dave Hansen wrote:
> On 9/27/23 09:13, Stanislav Kinsburskii wrote:
>> Once deposited, these pages can't be accessed by Linux anymore and thus
>> must be preserved in "used" state across kexec, as hypervisor state is
>> unware of kexec.
> 
> If Linux can't access them, they're not RAM any more.  I'd much rather
> remove them from the memory map and move on with life rather than
> implement a bunch of new ABI that's got to be handed across kernels.

The motivation of handling kexec (faster?) in a hyper-v domain doesn't 
sound particularly compelling got me for such features. If you inflated 
memory, just don't allow to kexec. It's been broken for years IIUC.

Maybe the other use cases are more "relevant".

-- 
Cheers,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
