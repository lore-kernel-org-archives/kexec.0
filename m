Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34ED2CAC5B8
	for <kexec@archiver.kernel.org>; Mon,  6 Oct 2025 16:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W3ezdJfUGEJ5h+e5P4gXyUh1Kf24KIpHMutjKUxVLWU=; b=d1pIuOTnXgjmcY5SHxSNVCHefE
	byiv3G+iLs9oT5F5bsj625BnTQkfBx9nBPgh4TA6FNzDN0dm7+And/o4eR9/YWf23yEE2Gy7x3qEF
	U4gah/8TRuYO0LfKB7shAZBcELAwJdu/h6rsZsybJ606O/HKRWHn0X4CfVCsQ0gGSRtDoE+iZKOuF
	3YPuay4QlMIQ3B6ig9UDGxgXzYz5QYvYkDXlrrnVi3/Tu15fStZfJ5//AsO+/UC3khN6cMhe65CEd
	LBYKyGyKzaNi99QGqqR/QKayVLudsoWKLDvJbDoKhsU3TZhuJLWzSaGq4RTACgGGB+ROlGeF8nCnA
	XYdzlWmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5o2C-00000000OXm-0NOu;
	Mon, 06 Oct 2025 16:26:00 +0000
Received: from mail-ed1-f48.google.com ([209.85.208.48])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5o29-00000000OXA-1oVE
	for kexec@lists.infradead.org;
	Mon, 06 Oct 2025 16:25:58 +0000
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-631df7b2dffso11888979a12.1
        for <kexec@lists.infradead.org>; Mon, 06 Oct 2025 09:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759767955; x=1760372755;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W3ezdJfUGEJ5h+e5P4gXyUh1Kf24KIpHMutjKUxVLWU=;
        b=PMQaf3/oid0a2zZTc2Ly71oF3GhOfIdSPG+ECzTKsoc5NOC1G0bn7i37QGv4/TvjXW
         R1Shpj30Wsmtu5jCcTYIAwkC3T5rRI/Ms8T3biMHiy/nKk+ZHXPlb/3+04mT+0MqOpMc
         aSb9nWmQhOj7YGEZDRgGk06rffCYk6EQSKGDJNj1e8ECacPBgK0rdjAnfxFuh1F5VNrv
         hO2s7PWGii6R7kjwuVka+g6WlEVTidjYIPVk7T3D+m62cXzvqjjfwlrf4ibJk69nlrRO
         S//6V4dj1zP7nCTYAe6lRDd0D4xlKWATCAjQDrZMMc5bpwJUs/aG86QfLdmNjoMHnC6k
         M6LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQrBsknmrsbWadFdS7AH0r3fKmbPs1kQwLq3YKI5hjqza1sMLijfUrqJjOgvvkmbARoeYApA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxZqv7uZ5qxdA+pLHqTcX4nl0z8InxksUNsf41JYTgkanvRUkWN
	M39HEcOmOkanFUJNcu+IYivRpYXzFEr02FKkVcroz4rkQJIZOtscWCkvpIbUFA==
X-Gm-Gg: ASbGncuD45/n5ZlsaKGmrlktjH333PKgTIqhJppIvyUsSsLBK1YT6pRfvFwSf4608v+
	qPiRi3EGXq4uJP0EUH1X5R/SSsU9xwNy8ng9uBB29GEQWsbMkI0X1m9AdZMrPPXvyxsv2AwGeR9
	Ft8D7sls3wHTz2DSrztFJvPnV3jRxHl060WBMo6IAsOn0qbq/5a1RFEBKoZ0OBk5X+jgXdBghxI
	VKTHEKchg7NXmUG7ZlzKLTaWE3n21k8dCtvsiJY4OaLLCmNWTtw35nRFcLpdZy59UdXtQY2rgli
	c2jv39XSEv0F2kDa6bSGowtBfgvZqqm6t2QwQLlrFjnAkRRhaucLJyeGMgE/KDqoCa0pk2h+az1
	JVXjt8q4On+SdmTINA2MN9Z/TWx4rZ7C7GJb4bdLm
X-Google-Smtp-Source: AGHT+IHTdpA0zEqEOLtB+HjVImjUU0ECe1QSWxgIxQTb/UwEPQR5ZGbAA+8IxrYbKsRHP5GMNZS5RQ==
X-Received: by 2002:a05:6402:1ecc:b0:61c:db49:aec0 with SMTP id 4fb4d7f45d1cf-639baf1bbc5mr216512a12.5.1759767954748;
        Mon, 06 Oct 2025 09:25:54 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63788111f1fsm10608112a12.36.2025.10.06.09.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:25:54 -0700 (PDT)
Date: Mon, 6 Oct 2025 09:25:51 -0700
From: Breno Leitao <leitao@debian.org>
To: David Hildenbrand <dhildenb@redhat.com>, kas@kernel.org
Cc: Jiri Bohac <jbohac@suse.cz>, riel@surriel.com, vbabka@suse.cz, 
	nphamcs@gmail.com, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, akpm@linux-foundation.org, 
	Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>, 
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org, 
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
Message-ID: <f7x2flir2c5zpkusgiyk7qnrdqo4dek3iksyldw6w22r55s4vy@4b47lrcv3fag>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
 <vojlxf5pelxlr6omsfsccd4e4cdzn5qyxpgiqajorkgmgd7ruh@e5wwhkmvntpb>
 <26ae6b04-3beb-47e9-9639-b081003dc9bb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26ae6b04-3beb-47e9-9639-b081003dc9bb@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251006_092557_489600_62150A85 
X-CRM114-Status: GOOD (  23.89  )
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

On Mon, Oct 06, 2025 at 10:16:26AM +0200, David Hildenbrand wrote:
> On 03.10.25 17:51, Breno Leitao wrote:
> > Hello Jiri,
> > 
> > On Thu, Jun 12, 2025 at 12:11:19PM +0200, Jiri Bohac wrote:
> > 
> > > Currently this is only the case for memory ballooning and zswap. Such movable
> > > memory will be missing from the vmcore. User data is typically not dumped by
> > > makedumpfile.
> > 
> > For zswap and zsmalloc pages, I'm wondering whether these pages will be missing
> > from the vmcore, or if there's a possibility they might be present but
> > corrupted—especially since they could reside in the CMA region, which may be
> > overwritten by the kdump environment.
> 
> That's not different to ordinary user pages residing on these areas, right?

Will zsmalloc on CMA pages be marked as "userpages"?

makedump file iterates over the pfns and check for a few flags before
"copying" them to disk.

In makedumpfile, userpages are basically discarded if they are anonymous
pages:
	#define isAnon(mapping, flags, _mapcount) \
		(((unsigned long)mapping & PAGE_MAPPING_ANON) != 0 && !isSlab(flags,
		_mapcount))

	https://github.com/makedumpfile/makedumpfile/blob/master/makedumpfile.h#L164

	called from:
	https://github.com/makedumpfile/makedumpfile/blob/master/makedumpfile.c#L6671

For zsmalloc pages in the CMA, The page struct (pfn)) is marked with old
page struct (from the first kernel), but, the content has changed
(replaced by kdump environment - 2nd kernel).

So, whatever decision makedumpfile does based on the PFN, it will dump
incorrect data, given that the page content does not match the data
anymore.

If my understanding is valid, we don't want to dump any page that points
to the PFN, because they will probably have garbage.

That said, I see two options:

 1) Ignore the CMA area completely in makedump.
    - I don't think there is any way to find that area today. The kernel
      might need to print the CMA region somewhere (/proc/iomem?)

 2) Given that most of the memory in CMA will be anonymous memory, and
    already discard by other rules, just add an additional entry for
    zsmalloc pages.

    Talking to Kirill offline, it seems we can piggy back on MovableOps
    page flag.

