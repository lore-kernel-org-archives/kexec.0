Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14603C36008
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 15:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SEaHAsDM2MLSNpt7MvRkD4rjd16wxN3bWpPMinYr6Xg=; b=ywRskCs6gekinuqL0Q3pPQeMTX
	7szJV+uae0rbn221fxUDIqPooH/+r9MhE79Yi7nplXhbUIdBgwkpbTUtqkgfS2hZyuA5058wgnXdZ
	jbTMXsXSZGDMjtbYZeSeQRUXw6DVZskv0LB7jSzEf39IJFMFWect+ZpY+RAH/oql/wuQeHmhSyIle
	T8zEHpbBE/DXiWNlWrPhoLUOc37X1Btrne6M+k4shlOVYFpJUAeDgZu0JqNmKXTLOs7iBBl6xLoaw
	lUQcqneYIX9Lub5/eQNMWwObr6wjGYDQ3l+nz1YEhvz5pElL+M8XThXAUkWhquQCh1fUY4q1Ac6FD
	kg3272NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvHRw-0000000CTy5-34Ve;
	Thu, 20 Mar 2025 15:04:48 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tl22O-0000000HOMf-3qVk;
	Thu, 20 Feb 2025 08:36:06 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5e0505275b7so933870a12.3;
        Thu, 20 Feb 2025 00:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740040563; x=1740645363; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEaHAsDM2MLSNpt7MvRkD4rjd16wxN3bWpPMinYr6Xg=;
        b=N/vFxa1O4RpuI7t9nSJAp4l7aA9E9Y967s8JaQgBzGUvTwG17rtyJ2T/oWtpwd464E
         VYTSS2PP0+UR9GEWTrqDd1atWVdUnXW29g7JS9NLbkOT2xWolKQTdPr2Bz5WuQahtCJf
         cYwkVtcw9slWOE089SxQi/TJERhqBkYCe61CWmVyBsER9oEBrIv5xGf448W9PIlNJ6kD
         I7lKWJGQDcd9SR5jzN+pcd5kK9/7++nCqvSkiK/KQczhebLPa8W1z0vVePw4HRG7lm2g
         qGojMRzULfTRNxKna8WjHARKXn1HfDtQxhsDTcFBBDtMR25vn47N6NOOK95jfx4ee+iN
         ybCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740040563; x=1740645363;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SEaHAsDM2MLSNpt7MvRkD4rjd16wxN3bWpPMinYr6Xg=;
        b=oS6xdbv/97sfxqly4rrKA8eQkYWdc6+RLPF1ofgLikQEsvn4HUSde3r18d0PhVuryY
         dYKKDMDfGlxJUxvBto1omg7jNU1l1y9MMh/6NL9/Ya6EcSe5MWkiivD8YGRXmRP8/LW3
         WGltuXtM6X5KLbPyebV58M516rDLliArgOQVrGZRcAEA8OWdZ3joVLYho/tjO+rbPw+u
         MFhEnSJkzjI6sj6fznZAuEKc+ZmCitzYbtU0no9JckpRBcbGECRlWJ1+ZooZYGTP8ZRN
         lxvN9cbagvBIwDnYm6bEXt+aloOv6WVvkHGgRQwWRK1BBE7pt5Cu6eHMEsrdeTqOb6Pa
         YGAg==
X-Forwarded-Encrypted: i=1; AJvYcCVNS/PvPxI33OxivdnmP5p5p340prn4Oo1lCKOeUNV9ajdBf+30XzlvkdhNketVYls3gDYnKaEjYnAyOcEPi2Aa4g==@lists.infradead.org, AJvYcCXIyN2MZ+T2ka1Yy0HhcCYgCFsSbgpWnt8unQamBXhIbeihVp8NitIZ1NY0nWf+hUUi2+8mNQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzP7XcdtlUr29o+Q0oTXclvUGdX79J7yIaaF4IfITcqcczvEnQh
	VzPDV50viGSLMl45O9FahMN4MW+r7AKc1Xsd4FHnWQ4kqrAk6DHt
X-Gm-Gg: ASbGncux7eS145pXQtiAp2re5+SFJ464gDGkbMF5jDL7onrnQRiU12golb1XAcONTBZ
	TYYrHZJHgemNyxxVpEPmZnojZEsRXRKjjhSAno8I5aA90KhfyBJy/rOWz6mTKTsJT24yE6p6tMj
	5nBdEZCvmVt/hFff8JgP4C+zbJet7mzTj+FB7mJuP1kMEesHkOopqdGJPbSHG7aEv2P0nxxEA8p
	8iHGGdA9yC7DQWkoe+Oi2KmeBYy6Wv+Kxx9IcImjrUJLCEc+ZomlVDb94RwYc7JUuCQ4uSXJeI4
	+WZDfKjUDQa3ltU=
X-Google-Smtp-Source: AGHT+IE9Q2O6cgNo6w+VEkK3+GcOBd0W7VIAg8ovqvSo1Dx6kdse3rC3i3ABuRQoN+lqO1U9Ke9Kyg==
X-Received: by 2002:a17:907:60d6:b0:ab7:f0fa:1340 with SMTP id a640c23a62f3a-abbcd0b2d3dmr769569466b.50.1740040562436;
        Thu, 20 Feb 2025 00:36:02 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb86c9320csm915498766b.55.2025.02.20.00.36.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Feb 2025 00:36:01 -0800 (PST)
Date: Thu, 20 Feb 2025 08:36:01 +0000
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
Subject: Re: [PATCH v4 01/14] mm/mm_init: rename init_reserved_page to
 init_deferred_page
Message-ID: <20250220083601.4p6ehmfhyvs5q5io@master>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-2-rppt@kernel.org>
 <20250218145904.x57chhz3whvckzu3@master>
 <Z7WEktyNoCPylytL@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7WEktyNoCPylytL@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_003604_992015_B91A3BDD 
X-CRM114-Status: GOOD (  23.23  )
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

On Wed, Feb 19, 2025 at 09:13:22AM +0200, Mike Rapoport wrote:
>Hi,
>
>On Tue, Feb 18, 2025 at 02:59:04PM +0000, Wei Yang wrote:
>> On Thu, Feb 06, 2025 at 03:27:41PM +0200, Mike Rapoport wrote:
>> >From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>> >
>> >When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, init_reserved_page()
>> >function performs initialization of a struct page that would have been
>> >deferred normally.
>> >
>> >Rename it to init_deferred_page() to better reflect what the function does.
>> 
>> Would it be confused with deferred_init_pages()?
>
>Why? It initializes a single page, deferred_init_pages() initializes many.
>

See below.

>> And it still calls __init_reserved_page_zone(), even we __SetPageReserved()
>> after it. Current logic looks not clear.
>
>There's no __init_reserved_page_zone(). Currently init_reserved_page()
>detects the zone of the page and calls __init_single_page(), so essentially
>it initializes one struct page.
>
>And we __SetPageReserved() in reserve_bootmem_region() after call to
>init_reseved_page() because pages there are indeed reserved.
> 

Hmm... I am not sure we are looking at the same code. I take a look at current
mm-unstable, this patch set is not included.  So I am looking at previous
version with this last commit:

  8bf30f9d23eb 2025-02-06 Documentation: KHO: add memblock bindings

Here is what I see for init_deferred_page()'s definition:

init_deferred_page()
  __init_deferred_page()
    __init_reserved_page_zone()   <--- I do see this function, it is removed?
      __init_single_page()

What I want to say is __init_deferred_page() calls
__init_reserved_page_zone(). This sounds imply a deferred page is always
reserved page. But we know it is not.  deferred_init_pages() initialize the
pages are not reserved one. Or we want to have this context in
__init_deferred_page()?

>-- 
>Sincerely yours,
>Mike.

-- 
Wei Yang
Help you, Help me

