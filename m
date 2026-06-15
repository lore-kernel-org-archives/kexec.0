Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6E8CD98CE
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 22:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XHiAwX7OKZgj8s+7kUMrC2Agg+yOPIiQF0+UWU7tqUg=; b=S7hgsU0FZBArncXbIANtY0Xc3z
	ex/+iH0BjmdMM2FaQdtR0S9FU5BdaizIY2VmuhP5NOtnTfGpZIkrljyKsgsCpx315OUNXZLnsVOBK
	/PzKTuci61ZgsejA2mpX5ZnXIU5Zg86ygPhDfee4xV3UYM/w5EEM6c33l4Y7vAwVntKIGU3Htuzbj
	3D1XWhDcXs/ZpirD7TyI1K7O5HydB1a0EOW8JW10pwK7U44Wr3LcLN8b1MHBYmu2UuyPiwSbvrA+L
	7BwKAJccj/vGAfypM6jktXiIEIag+Pj1YbuRDOceYRvbQxaOMATGJQS1f/uyOpn/YQgvpZ8o9Enpg
	Aj/kUSyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZFeA-0000000EtOz-2O1Y;
	Mon, 15 Jun 2026 22:19:10 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZFe8-0000000EtOd-1bbz
	for kexec@lists.infradead.org;
	Mon, 15 Jun 2026 22:19:09 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-84229481d44so1893780b3a.0
        for <kexec@lists.infradead.org>; Mon, 15 Jun 2026 15:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781561947; x=1782166747; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XHiAwX7OKZgj8s+7kUMrC2Agg+yOPIiQF0+UWU7tqUg=;
        b=tklt4uBItgwNekkdx28hOvJ8ElRcWq0DkAGlB5hrCW+DSbiG974cdsv4wLp5CHRH+y
         7EyOZYCwskUvzEagR6dNB7UAg0n49DgfE9Gb2/xZ3YUQ76Gav/gUcTAWUCKN8rkFGtm7
         iKGmOsn79Y85TBVyCVfzrBx/u+89YdP2OyBHa2Yv8/cEcH9pqtzfApxcyySOtlDLUeWJ
         lbYd08wzR5bVhJe5oMH7f//4wsoluqb7yg/77wK16cZvntDFrcqOJ//sTFzLnKdPw262
         JVY4ZB8riIdPx+PWDeuT52SnCb/m/HS4OhjYeyWQHbx7l5Ez3KHX313Nn63yUGsHx4LC
         r2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781561947; x=1782166747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHiAwX7OKZgj8s+7kUMrC2Agg+yOPIiQF0+UWU7tqUg=;
        b=IqyXqSVQTM6psVrqiksarEemLOH0U2F10EvcK9GbCzNmlwoRqjW4elCR6W1jJ6loGf
         suRIRJrGDf48ML/SNm/175yn6R7+PAxJlY4vOV3a/j3SpKOPmdl4Y0jQApRX1A4tOzk+
         M7MREbpZAb0d33J5awa7NOliHwhPZYf3YSl7+R1Hv+bTLORlubfotVZRNSPZ2gufHDU+
         LxwXNQ8WnkDGeZ0fhCW4GfkmD390tyVyTDhg0OU0GNs2/wedRSH49eYqxYp1fHuTZcpJ
         soujDIZG1ZIHC4kmz2JNlL512oxrP7049SYJ0XmXxU3v5en9729iEdBjinoDV8NpnXqu
         hU3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+cL2BtosF7WTr0SeTIF9jdB4Q3IMoymDmu9QG1SuL1WyVmSip0Fk8EOvVBWFyEXT8CzQ3ccA==@lists.infradead.org
X-Gm-Message-State: AOJu0YygIJG4uHXKfUPPo5Lh0Hm/8hS7yPbVzabJAKr2sRmzknD/KnE7
	nPl6ZtbVYPcidJ91e0IhR5QMSUn5a4uWio+itYrYQcWD9gy8VbdWH9PfxYtn3llhsA==
X-Gm-Gg: Acq92OFthQBNH79cSQvbaJQaz492zDzVziWdNR5H5fQhIwgr7Rno3APFs+syIUVAj8f
	wWKFNNfodO51z3neAc/oMmOU9cYgc6oUTdB+A6+KLhtWEhiLbjrB+3L4uC94HC9j7zjeOkvlXf/
	UNgFeI3YcH6SLwT8My+0CAX97eUAgpleXmj3xcilcVv81Yrc+wErqnZDoP0D54Hm+w4zl1JWNP1
	l1YrgdYrR1BbiH64EH+E+HCo4VT7xafego0AUM8jyYGuug+ODZjh9Oh9PQjYriw35U67nenPLpJ
	Ur0NVCNv72f4dwVcYDD4+KfILdWhJQmJ03gtZWcU/Mu+so2SDzvI9coM/DX0pmkfRJWjMOo3mB0
	AVWde9P8XJvxWbajOuvC62Pyg5mTHzvqg3sgP/9IXwR9zv64mgqSKSBiqOVzQ6t2H5Ht9wD9fk0
	rc4ORgMAzlmwyzQ8SYTkNUGM6+XXox5xhVz4PLEYUcFOhj3uq2NTSV8BiH97/sog==
X-Received: by 2002:a05:6a00:3e02:b0:841:dc7d:306a with SMTP id d2e1a72fcca58-844e1a3d7c7mr13260407b3a.25.1781561946731;
        Mon, 15 Jun 2026 15:19:06 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434accac96sm11985798b3a.14.2026.06.15.15.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 15:19:06 -0700 (PDT)
Date: Mon, 15 Jun 2026 22:19:03 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Parav Pandit <parav@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <ajB6V6yBHOjgK5ew@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-2-dmatlack@google.com>
 <178124130274.908199.14827357870284807134.b4-review@b4>
 <aiutNINqxhtlm2Dt@kernel.org>
 <178126123047.908199.12042730612990730743.b4-reply@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178126123047.908199.12042730612990730743.b4-reply@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260615_151908_429599_84521EE9 
X-CRM114-Status: GOOD (  18.66  )
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

On 2026-06-12 10:47 AM, Pasha Tatashin wrote:
> On 2026-06-12 09:54:44+03:00, Mike Rapoport wrote:
> > On Fri, Jun 12, 2026 at 05:15:02AM +0000, Pasha Tatashin wrote:
> > 
> > > On Fri, 22 May 2026 20:23:59 +0000, David Matlack <dmatlack@google.com> wrote:
> > > 
> > > Please add Pratyush, Mike, and myself so we are notified directly of 
> > > incoming patches, the same as with other areas where the liveupdate/ 
> > > tree is specified.
> > 
> > Or we can add PCI liveupdate files to LIVEUPDATE entry.
> 
> That will not work, as we cannot serve as maintainers for 
> PCI/VFIO/IOMMU/KVM, etc. David Matlack will be the maintainer for the 
> PCI components, and we will accept patches once they have been approved 
> by him.
> 
> The simplification we could do is to create an email alias 
> for the live-update tree maintainers. This would allow us to use a 
> single entry instead of listing all three of us individually.

We could create a Live Update mailing list for all code that can be CCed
on all patches that must be merged through the Live Update tree. I would
also be interested in subscribing to that list.

But if you want to create a LUO maintainers-only list that would work
fine too.

For now, I'll plan to add you as Reviewers under PCI LIVE UPDATE in v7.

