Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66DAD3000C
	for <kexec@archiver.kernel.org>; Fri, 18 Oct 2024 13:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/4m+8zC8kST9VqAtvnY7cJoijczDcv+CbcDDPUlmOaU=; b=Zuc2CMNkVb7ijV
	NF3T/6HGpIKVdVlrxlV2sTlJeKejIvUyZX68aTWrfRr/TaPyzZYAfhYA0XE6lm4ZkC4V8AK9Dl7Nn
	h6YnW0wve2vtGR4brzxfsHIl7wQU2cJaxZ700CQhnVmcjldqmKCuEpPJzG3cEuyFCD59j1Lyx5Dak
	Utz8zS0edd7GU4yG8fvLfpFXhFxuzdOG06HfKYuK2D2laHxX/BtYxgRSBjcVMXneTZnreQhJrkRi6
	TVg7yvzZYT2GHcQaB/MW9BCw6R5W2NA49VMtFHGzFDMNyPLKu7e1tq9uJA69v6eSlL0peVFdm3rCP
	iSTz2zivoRPb5khT/NfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1nM2-00000000xE9-3AVZ;
	Fri, 18 Oct 2024 13:49:22 +0000
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1nBf-00000000uWb-2yUe
	for kexec@lists.infradead.org;
	Fri, 18 Oct 2024 13:38:41 +0000
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-71815313303so869019a34.1
        for <kexec@lists.infradead.org>; Fri, 18 Oct 2024 06:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729258718; x=1729863518; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nVQC71FpKRWshBPwUAPRSfOi9KhTjaLXAKPeTx4sMCY=;
        b=aXkiSH6zamgFvFfEXPI7Arm3sxOdfVV56rTuiCKjVvwYNPUmO6ReS+o6+bcIEoW9KD
         vlNs7unyBgJLAJPQzKCIVOyGqQymG2BwKHDD2IQ3JWp5PLJm0uJeT6NCO0yDRqk2rPFQ
         OwpzC9KBqEbzBm6acpl03SrdYEqdw8Q+gPiv3JR87BKmxBHJ8clQEoEBpyLybjbYliZ1
         Jr+toh/I+vGyagmeNx2LM2QjJmQAYNPFnjg4N8RbTdJViIpbRVtelgk3UdhLoxRAiKoE
         6q80leuv37Ds/VLN69xPyJL9CXxKTLGexNDl03DPdHYMnj5YRe7AV/tmJX4ON6nrtmyb
         AAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729258718; x=1729863518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVQC71FpKRWshBPwUAPRSfOi9KhTjaLXAKPeTx4sMCY=;
        b=LEm1yFz/k+ipGOCQ0uZ9pMchcczBILD8siuSpmH4MSkgkBVwgivPHBucU8T9gI1pli
         vgNV81bRF/lpX0+hMYKMmi3CZUWVPBv20gA6GdBoNk8WC13cY0IFzv6htwtsTT1b9e30
         Kgg8Sc3Os3fcpXbarpU71+1G4Hym+GUq7DPF6TzM8XbbEz6IF9wTmtUskDbthbnA6QHW
         bD22PTEcxAtAUQxQBXEOCiWw32k99IJDXU9QKmi7h+Tw4QR0WhnSrixIieSR9yBxDEk6
         m9oBRT0HQm/4wHwzpj3N7jjizqsHmks7k3oPhvDCMOEH4Zsl1Wsg+jZhk2n5ADDxGQLt
         y1rw==
X-Gm-Message-State: AOJu0YwBVmL5XiCJiZ4jt+ir/9xzn03QsIlNmCGwd7Rwtj2zYc8A1e8J
	7iy3F1WqTZGGhAWQad1eaHbxxoCy0Irp2q0HZ47lLOOJy8Yg+lAfUilkiheZKJo=
X-Google-Smtp-Source: AGHT+IHhM/hhdws8NWJZR7xLe9RfCiROWNQkWuLLhXb3EaaMsAeiBTYEXM+95+rEIX3njEZZmQYboA==
X-Received: by 2002:a05:6830:6f49:b0:718:a52:e1c7 with SMTP id 46e09a7af769-7181a81d73fmr1358859a34.17.1729258718312;
        Fri, 18 Oct 2024 06:38:38 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde122b017sm6974436d6.78.2024.10.18.06.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 06:38:37 -0700 (PDT)
Date: Fri, 18 Oct 2024 09:38:37 -0400
From: Gregory Price <gourry@gourry.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com, mika.westerberg@linux.intel.com,
	ying.huang@intel.com, bhe@redhat.com, tglx@linutronix.de,
	takahiro.akashi@linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH] resource,kexec: walk_system_ram_res_rev must retain
 resource flags
Message-ID: <ZxJk3RYDTpYkELCa@PC2K9PVX.TheFacebook.com>
References: <20241017190347.5578-1-gourry@gourry.net>
 <ZxJbOinZ0E4Ppmak@smile.fi.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZxJbOinZ0E4Ppmak@smile.fi.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241018_063839_925671_E7AA1397 
X-CRM114-Status: GOOD (  17.47  )
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

On Fri, Oct 18, 2024 at 03:57:30PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 17, 2024 at 03:03:47PM -0400, Gregory Price wrote:
> > walk_system_ram_res_rev() erroneously discards resource flags when
> > passing the information to the callback.
> > 
> > This causes systems with IORESOURCE_SYSRAM_DRIVER_MANAGED memory to
> > have these resources selected during kexec to store kexec buffers
> > if that memory happens to be at placed above normal system ram.
> > 
> > This leads to undefined behavior after reboot. If the kexec buffer
> > is never touched, nothing happens. If the kexec buffer is touched,
> > it could lead to a crash (like below) or undefined behavior.
> > 
> > Tested on a system with CXL memory expanders with driver managed
> > memory, TPM enabled, and CONFIG_IMA_KEXEC=y. Adding printk's
> > showed the flags were being discarded and as a result the check
> > for IORESOURCE_SYSRAM_DRIVER_MANAGED passes.
> > 
> > find_next_iomem_res: name(System RAM (kmem))
> > 		     start(10000000000)
> > 		     end(1034fffffff)
> > 		     flags(83000200)
> > 
> > locate_mem_hole_top_down: start(10000000000) end(1034fffffff) flags(0)
> > 
> > [.] BUG: unable to handle page fault for address: ffff89834ffff000
> 
> Please, cut this down to only important ~3-5 lines as suggested in
> the Submitting Patches documentation.
> 
> Yeah, I see that Andrew applied it to hist testing branch, if it's not going to
> be updated there, consider above as a hint for the future contributions with
> backtraces.
>

noted, thank you!
 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
