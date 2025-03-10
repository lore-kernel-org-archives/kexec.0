Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8B9C36001
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 15:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tMClGTb/xowiN+wUj5f6h9i/suU0YoMn0juoJl6ktWM=; b=owXB6f2LarEP7UYEnlak6azieZ
	/hcqdHQMUCLny5TewSdg8gKOpYTTXP652g+2ahgBKJ/yl6Q3J0zxetIAbTrERCrsC6zoRPm+fhaLg
	vfHr/SHFsQwpW5o7//3XjRaWZo6SJqpg8zZOcZb8suEm3/23qBPUA5cJuLUJDLe83e5BrVcJDAQXf
	sDIHqCcL1Wtx4EJiiNKM1yLPQr/UeRibxPpz1tb3slcqdDIZ5EJMkx4E4A1AXAM2qLEfxR+dZVn+U
	RF3NGAA+b035U+Us5ZbDLIL49t6tcxi6M4yec0UIQeMWsoA5uXsPRiC4+cRXA+LPaN/DRKK9h7zFc
	lUXdGwwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvHS1-0000000CU5p-2rup;
	Thu, 20 Mar 2025 15:04:53 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trZel-000000027Uz-20IH;
	Mon, 10 Mar 2025 09:42:45 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-aaec111762bso771723366b.2;
        Mon, 10 Mar 2025 02:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741599762; x=1742204562; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMClGTb/xowiN+wUj5f6h9i/suU0YoMn0juoJl6ktWM=;
        b=Kgyuv+N+Q8UQ1SacwLg7Flt03X4LVQSkJIOn24rO/lgA9WYPWc+/AR5Lb7K030nbVE
         iOStAo4qDPL6csXLNXM71Etu8+UgIoiMJ+9XKoc7uKptOM8gRQpFLAxDF6pcMdWe0ylV
         kx04AhnsdQgsoF8X5As4KwV9rVbZNR3WfugAdEREgIwEIQ660VGEzWuvFHMWxz9GCGYg
         qlB9PSnjY0fxpAy02x6VhdJeMzYzMFzXHMXoqBQuA9T9b5Jw5VtIaJ935T+mYyLQtpRD
         1BTmV6smAaANUpE6y0c1LixQ1FKcwoh4CZ5WNdPVWjCI2iTpzdHv7dkZtBvo6NUZ97KS
         0AAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741599762; x=1742204562;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tMClGTb/xowiN+wUj5f6h9i/suU0YoMn0juoJl6ktWM=;
        b=fXt3/WnhyUptr+Q/vRaklH3n4PSyoHAj6upqQLOXwh/K8ZD5Jktl46cMRopQQNFvUJ
         gO/tPOI9GJexeVIWT8LngBpdtNg97rz2+eXcT+ZUAn91GTFNXP4CwRU5UpIztribihi1
         jso2IQbaSFxPx6EgHHFG3dXKRjlwA28ND98v7z0HTt4GZkYt9YuyNiZF24OA1eZOmHbY
         dnqTc2cf02lC2uOP7BDT8Je+5FfuN4zdeLUHx/ijszdG1QCVuZfaV6UavD02LBNPNBCh
         7dfCKpcjH6HJAdHUnGTShikWfiHXdE1Crld8qzKMB2zBKAPX9UYLv9h43ddjj+opeutt
         2OUA==
X-Forwarded-Encrypted: i=1; AJvYcCV/eJTxrOiq1ILYAMHZtejkht4Nr5fHDKIfJLo1LMkxhz2j4dOtYbkoUk8qKZFnBDG7hYRTt8yub+BOo8iGndA/aQ==@lists.infradead.org, AJvYcCXW7KmE5IAZ4ragFANZkGCQ6bUkG8yxojKrTIJ1JsUBAPkOOH46RlxCbR7j2L9vGHTKWbhD3Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YxukZ7qU9iWIix+uibe0H0kvIWfUhx1YURwk5+UW8dOY7/krR9t
	WtO6xGgFMp3egIrKhpRVz58s7WhB+kmtItkOwqWxKD2uMBBM7lo6
X-Gm-Gg: ASbGncsaA18lULck1krQxLGPNZ+eMIfLcXVLA4gUd4XX29X/HzXzNbMDddNxaumo0/f
	c5hGncslyhb7rg+K5eo928Heyk62SwmSsd8hMHSWG6mW2sfL+S2/uHeS2WIUJnJdCY4oszy0EFK
	tJLvbAWiIaVVJ6JmLICd712mFx9P28sZy8tbqRu6EdejfnjWOai9DHwPWA4AHB7tvdjHS+j76uK
	TqBCeKtOqXzJTKLp6OMfzpw71kHiXL2Lcu8hvutsvelbxYHdow8WzX0bbCWstIjiT6AI8SKOFMv
	T70pfhJTiZkkg6dO7+FNJw2vPtqevO17HrFLqon/0VVk
X-Google-Smtp-Source: AGHT+IGr1BXamH0TMzryWGEFJPRvklcDIRXonoj2fHuOVeIPkUnC7Qwd3/v9Pu02iEAlM/2ZB1tn9g==
X-Received: by 2002:a17:907:3f96:b0:abf:62a4:14ef with SMTP id a640c23a62f3a-ac25274a051mr1561659766b.9.1741599761642;
        Mon, 10 Mar 2025 02:42:41 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2b0daaa0asm28863966b.38.2025.03.10.02.42.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Mar 2025 02:42:40 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:42:38 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 02/14] memblock: add MEMBLOCK_RSRV_KERN flag
Message-ID: <20250310094238.lgsiyqci3aqdzrhj@master>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-3-rppt@kernel.org>
 <20250218155004.n53fcuj2lrl5rxll@master>
 <Z7WHL_Xqgoln9oLg@kernel.org>
 <20250224013131.fzz552bn7fs64umq@master>
 <Z711VP45tjBi0kwx@kernel.org>
 <20250226020915.ytxusrrl7rv4g64l@master>
 <20250310075627.5hettrn2j2ien5bj@master>
 <Z86ikkLVHQhLmBWj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z86ikkLVHQhLmBWj@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_024243_516227_09DFE64B 
X-CRM114-Status: GOOD (  23.46  )
X-Mailman-Approved-At: Thu, 20 Mar 2025 08:04:44 -0700
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Mar 10, 2025 at 10:28:02AM +0200, Mike Rapoport wrote:
>Hi Wei,
>
>On Mon, Mar 10, 2025 at 07:56:27AM +0000, Wei Yang wrote:
>> On Wed, Feb 26, 2025 at 02:09:15AM +0000, Wei Yang wrote:
>> >>> 
>> >>> From the above call flow and background, there are three cases when
>> >>> memblock_alloc_range_nid() would be called:
>> >>> 
>> >>>   * If it is called before (1), memblock.reserved's nid would be adjusted correctly.
>> >>>   * If it is called after (2), we don't touch memblock.reserved.
>> >>>   * If it happens between (1) and (2), it looks would break the consistency of
>> >>>     nid information in memblock.reserved. Because when we use
>> >>>     memblock_reserve_kern(), NUMA_NO_NODE would be stored in region.
>> >>> 
>> >>> So my question is if the third case happens, would it introduce a bug? If it
>> >>> won't happen, seems we don't need to specify the nid here?
>> >>
>> >>We don't really care about proper assignment of nodes between (1) and (2)
>> >>from one side and the third case does not happen on the other side. Nothing
>> >>should call membloc_alloc() after memblock_free_all(). 
>> >>
>> >
>> >My point is if no one would call memblock_alloc() after memblock_free_all(),
>> >which set nid in memblock.reserved properly, it seems not necessary to do
>> >__memblock_reserve() with exact nid during memblock_alloc()? 
>> >
>> >As you did __memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN) in this
>> >patch.
>> >
>> 
>> Hi, Mike
>> 
>> Do you think my understanding is reasonable?
>
>Without KHO it is indeed not strictly necessary to set nid during memblock_alloc().
>But since we anyway have nid parameter in memblock_alloc_range_nid() and it
>anyway propagates to memblock_add_range(), I think it's easier and cleaner
>to pass nid to __memblock_reserve() there.
>
>And for KHO estimation of scratch size it is important to have nid assigned to
>the reserved areas before memblock_free_all(), at least for the allocations
>that request particular nid explicitly.

Thanks, I see your point.

> 
>> -- 
>> Wei Yang
>> Help you, Help me
>
>-- 
>Sincerely yours,
>Mike.

-- 
Wei Yang
Help you, Help me

