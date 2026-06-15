Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E52DCD98CE
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 20:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ynJ3evPKTv+CHJxYf+R9sPicm7rQMH20Hi7EX5GWIM=; b=G0ifkNfilV7O+ZHq0rfH2GmM6U
	HpHsFBbx4nqQM3LyApeRDImhgeWbQHuisTsmkIGDl6JmhL4vSS4vP2pqRW4clF+POJg8GIGkAAUm5
	LY3SgtYq8T8ORBcARoG5cnn13AKKchxCailLxAfu+pSjgq/lOvWBy9bvEICEasWY5LxnFQD/CXSSn
	6bHkZWr/f4+6iYnuTMDVXShyiR8I3AsH2kKguUDx9ikF11JAcI37M5CHRwF7szrGCk/+EfXpqf0qy
	eCYZtKPvpNwNain96H9VMthgbuRi0SwwX+sUeU78p2I0X/dnBnH7JRXjkJ58+PFGFUdIgJNpQACGi
	dYAf0Rew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZDnX-0000000EoQu-0uQm;
	Mon, 15 Jun 2026 20:20:43 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZDnV-0000000EoQY-0FGX
	for kexec@lists.infradead.org;
	Mon, 15 Jun 2026 20:20:42 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-37474afe908so1950108a91.1
        for <kexec@lists.infradead.org>; Mon, 15 Jun 2026 13:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781554839; x=1782159639; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ynJ3evPKTv+CHJxYf+R9sPicm7rQMH20Hi7EX5GWIM=;
        b=kYDqHFBOhpmFM807u/zdCtNhqKjslsT6I+sdwRn8jexdkeefc/97pC8Z/6j+cw6yZi
         6MCOpD0VzyFXzprwvT7uBDf/6pNwekkVE2hF/uSvveY9fLneqwXZrBkx6S7tbJpjW46B
         hpHdORJeSz0/2sRDcuA5CKm2U7vrJYbj2zLVUf/ZQWzY07ec2ayQnH3f6ThWZxT+i+Z3
         PGMgZsQHpHV5adX8spn9GlDyY4cqzLgCg1V/Nb8t7CXKsdrm8DsJ7TPRVnh9pdTM7W+R
         7jsUWGJlkknvVAALHyqGVdmqmy5gcwfHXvplTOmf5mIZFox1adrWb6r9b1HaKLz6btUi
         n5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781554839; x=1782159639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ynJ3evPKTv+CHJxYf+R9sPicm7rQMH20Hi7EX5GWIM=;
        b=J5V36KBesC0Pa/Zfsqzb5iN/JU2KU3UYR9RAuQLcxC7o7vPuPzm+9Vfu7uHO1rmjKS
         Wa61BmPiyph0bsYMiFcUpDGqHxyZFypP6cof2xExxjW7wvZ94K5DAdXmveOWlWWXMcGq
         6ncX80U55JPsTe4PZ5huLz3BaMqZgZrKLV7kziv9p/RDg9GGSep06P3fu5gQFEUCgYPS
         Jgl+n3VaHPcoT3JPtc3isDlh8G/K4JLpqop3dfIAfg+7J6OJFS34/Afs6vhsZUiBJWUE
         ipHWWFGcBSw/HuRTru5+6+7RpAKEGmNONZnBD6I33fc0+o7uPGLDJp6qGchdMEcb/tSk
         Rn7w==
X-Gm-Message-State: AOJu0Yx6D060MduPT5tgmvy73m4qTqRmkJ4sTEHkrJ0xIB3w0zFr3AT9
	ktxN6T1iys3kQ9/7vBEavZvFFzCLTq7a2Y7VyE8s3fRDei6JzhX7tw4oJ+W4yksUGA==
X-Gm-Gg: Acq92OGxBcxCziHGDa3lPw0B7N+aX8iNZJap8kKlsIDZDZb7wsClxEYy77+kTKJVHrD
	jbHIj6l4Fyg+VBKBTaRYMjcPNGiTv+OQJynir6R1wQck7KwxYomphVSMyz61ShATGTve7qmiBEq
	2vkVQPAu90fhJMuOsGjWbApRAjWo6SXuOeMM2Dcl8RQj6iC/Oka2FGMK4xO+sNCspGb9EKpczrs
	x7kzeM/R3ee16f6U+WzXstEnPdboEsRiJALCHO8FVDcBj0ksegIaL3w4vLNvsIA81LHl2mDTBTz
	pxqtun9LtxApVRnkUxZ60dHHwg2aL6otKi3A1GDEGdjuO4sXXCK2xLa3ZH5dvPihTvTruBd/vgL
	jcHA8dCYBscKam8SsjBrDR6f25vP2ycz2wein/NmySzV2u/GCIg3lR6Pvh7KqPnX71ApXBbPvEY
	hmZEjmPUuzE69bgr2h6+zkAsDsPbTCREqa1J5aznO4wAdf4Fk8sQzcqGhEOCsq3A==
X-Received: by 2002:a17:90b:2f05:b0:368:6998:b4a9 with SMTP id 98e67ed59e1d1-37c2bc7c378mr12049662a91.11.1781554838812;
        Mon, 15 Jun 2026 13:20:38 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521d96ddsm470060a91.6.2026.06.15.13.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 13:20:38 -0700 (PDT)
Date: Mon, 15 Jun 2026 20:20:34 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 05/12] PCI: liveupdate: Keep bus numbers constant
 during Live Update
Message-ID: <ajBektwaDID-NqQk@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-6-dmatlack@google.com>
 <178144546090.1266136.8524338598480624580.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178144546090.1266136.8524338598480624580.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260615_132041_097904_54A91E0D 
X-CRM114-Status: GOOD (  16.40  )
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

On 2026-06-14 01:57 PM, Pasha Tatashin wrote:
> On Fri, 22 May 2026 20:24:03 +0000, David Matlack <dmatlack@google.com> wrote:
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > index 4f2ec6ffdd16..2421bc218916 100644
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
> > @@ -103,7 +118,7 @@
> >  /**
> >   * struct pci_liveupdate_global - Global state for PCI Live Update support
> >   * @rwsem: Reader/writer semaphore used to protect the incoming and outgoing
> > - *         FLBs, and the references to them in struct pci_dev.
> > + *         FLBs and references to them in struct pci_dev.
> 
> This change does not belong to this patch.

Yes, will fix.

> 
> > @@ -396,6 +411,72 @@ static void pci_liveupdate_flb_put_incoming(void)
> >  	liveupdate_flb_put_incoming(&pci_liveupdate_flb);
> >  }
> >  
> > +bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus, struct pci_dev *dev,
> > +				      int pass)
> 
> This function requires a header comment; it is public and not self-descriptive.

It is private to the PCI core, but I can still add a comment in v7.

> 
> -- 
> Pasha Tatashin <pasha.tatashin@soleen.com>

