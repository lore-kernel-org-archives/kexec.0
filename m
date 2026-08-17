Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3B4C5DF66
	for <kexec@archiver.kernel.org>; Mon, 17 Aug 2026 15:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LkIXCvEaOBZrdi7ChK3r5JFweXwKUKZFGDYp1HFtFrY=; b=n2ziCNg+2GbusvC9E+5hcYXgx5
	ae+u13tM3pjiKIeCG3x3BtwfTEbK07AdQfs5uZvBE0Y8haf8458I0Mb15W53EOT7LZGyr+WX426M8
	VIMdV3rYpnmzDEJoG4jhVj2bZzmgHSBhvyne1myet3w9uuG4864H5GpY2s9UTtVBqdtnjKNWlM6VP
	Uwtq9mM/rguGgnElqszIfaw/beepurhx9EDKVJ+bt1Di4xSybiaQgri5CuZJsWpneQtKUUpAmZdpG
	NYrz6dw3LLicpaj7B3XV/93liOJ3D1nWAKhnmflt4nPK0vnU59rUTXimUHDaXD9IENYgGvXFSoMUO
	BcYSdu8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvz49-00000006Nz2-0RU1;
	Mon, 17 Aug 2026 15:15:57 +0000
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvz45-00000006Nxu-18rb
	for kexec@lists.infradead.org;
	Mon, 17 Aug 2026 15:15:56 +0000
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-92e5b048375so179215585a.1
        for <kexec@lists.infradead.org>; Mon, 17 Aug 2026 08:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1786979752; x=1787584552; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LkIXCvEaOBZrdi7ChK3r5JFweXwKUKZFGDYp1HFtFrY=;
        b=snsrP++LFuZO+jikbTnouaDJ6fRqp+S7cx2UkW04x0eVw2GO/35elQ5yQHcWhFIzpj
         7N42SoG0jdWbW/hdPU42Qa9kTUIomHUlfat2lYWqrFF/jcbllC5syfpXRyInxxjwttiq
         d5/5tAo+bBHW+L1AKtEN0clHdc81nrIf4wQ7Ice4hmEK/OOz0zNihtE6nbhbo2q8HLoO
         BDJ0MyjF4V2v+R1BbAPcCY47EZ2XYu4CmglfALues6wIi4aThIrosZqFQHSPvnNZSyb9
         z7qzeFK68PXwhXWA81AnH4nEnhijIib0y8zooSO6vsvCGllk/8JLEYv1o/cJ16GeJmIc
         3WLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786979752; x=1787584552;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LkIXCvEaOBZrdi7ChK3r5JFweXwKUKZFGDYp1HFtFrY=;
        b=RPlr74tkLwm8ks25xHjGdQtmX/6z61IQ5JD9cV9lsOLcF5Fb3R1gLOvGcGGCPMIeQF
         5oMsBhExlLSvsnwdgQaqsKGQkI9j2PKYMYpFoTKuGloIs9Dhii7awCxIV55N2pzcXTlY
         DyoZ1/mtE5I/lWrnKaMLH11NOpst9PUIi3kaSrRzgWUGkSJx6zcu+bF7UCRCdibzaWqS
         XA0uQshfY+dylUNaTlx+89bM9MpxDypfJ+QjznoNh3ikU4V3b0mHGmegqVeSpRZG7Plt
         sTw0qRSkZaB56AiieY9nkgW7qcOo2f+L7FF7IGZgkkgbLvbak33KMJK4wXa8X+x0J3Gr
         eQfA==
X-Forwarded-Encrypted: i=1; AHgh+RqoKvvTdTUiMQEoyF3JkWBT/AM4jpo4KOUfkV6UWHrXxQbo5Yt1LhVbDljFIdjxEhWwSpdT4w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw72/959jgttfMuknJqgGSzjpLT+EBOVHW/vX9EhGpXgTNQH0oV
	RalTFunOIoQUbRXuw2f+V08U6roAuEMJNqv3HeuWE+UPzEk/QUW/8zEE4c8mOtTTnxA=
X-Gm-Gg: AR+sD11JZOr8rpPXL46QMRQu5riCAHr9r/QLsFNmJOJ8qfWzSvp9e+yTI6VbZRb8m15
	HQiVf6oenauU0oubwVM6QIiBTN5UqxxYxu1k0VXcTucfpjFO7cwNo6PNteKxE/HIxZmSvCBq1am
	pFNVeW27qKYqjjtaMKwa4km7thU5UUgU47OLnEmFuxM1hjU2kqD3Wm9mhYtpZnVpL7lwD6pBBTn
	QT4/fOTXGFRy/BlfaC5gQ7R5B8dxA2oTnxFTlYzxGR8oF/rtRGi3Zb6jAk/sLEElOYMEuZOKAtJ
	I9qUB4H8JLHVQfbwhldvftJTuBQ/vY9ILOJCcGLEGFKVameeyCPhd/9MVEiHlGm7Ob2a4cVg+B9
	ai6bK9SretWsozhdDOR8HcNVsZ34uRYb7e4i0A61WTxRShlwlYBrII4rYRVMcK9bau51Hcp/lj9
	K+J/rCnjeuueKbRcloO/PJCDdCCUdx8D0l7UdYfd/eYvHjJT45uZOJJzFbyKQ7lY2E5NhMmPaPP
	aD1Qpkbcx3xRHySRn6WBl3fZC7yZEVkVwKX24khoLDI
X-Received: by 2002:a05:620a:f06:b0:92e:7d53:8e8d with SMTP id af79cd13be357-93704b7d4dfmr142017785a.27.1786979751821;
        Mon, 17 Aug 2026 08:15:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937033d2ccdsm67050085a.30.2026.08.17.08.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 08:15:51 -0700 (PDT)
Date: Mon, 17 Aug 2026 11:15:49 -0400
From: Gregory Price <gourry@gourry.net>
To: Rob Herring <robh@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Saravana Kannan <saravanak@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Baoquan He <baoquan.he@linux.dev>, 
	x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-efi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 0/4] kho: rename "scratch" to "bootmem"
Message-ID: <aoMlXHFTvcpwOv8W@gourry-fedora-PF4VCD3F>
References: <20260811162642.3504565-1-pratyush@kernel.org>
 <aoMdJ7hpr1GonLz8@gourry-fedora-PF4VCD3F>
 <20260817145231.GA579285-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817145231.GA579285-robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_081553_320249_C6D7527D 
X-CRM114-Status: GOOD (  14.59  )
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

On Mon, Aug 17, 2026 at 09:52:31AM -0500, Rob Herring wrote:
> On Mon, Aug 17, 2026 at 10:42:00AM -0400, Gregory Price wrote:
> > 
> > Is there a non-verbiage reason to justify these changes?  Living with
> > "scratch" seems better than potentially breaking folks.
> 
> I don't think these are the first breaking changes. And if the changes 
> are fine, then that means more breaking changes are fine, too. So why is 
> this upstream at all until the design is settled?
> 

Surely we should not break deployments for the sake of renaming
something that is very arguably already aptly named?

~Gregory

