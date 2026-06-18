Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED0DCD98F9
	for <kexec@archiver.kernel.org>; Thu, 18 Jun 2026 13:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=97YgfxmG6Chl0Ir+S9QMmQ5bxu5X/S2hJhh/DZ4TYTw=; b=n0znZ6sjUcJcv8Hsqq2+f12ulv
	0OF+vzbRLNel4mlp/Zpsnsxt6yKjkL4TKYjsZlRt72wIRsJ9OmSp42qxDJb8vtIBh9peClFRqCiA4
	rcKFpRjWrgT7Bmcaz50EQIosrKTedvHrSORJX9jU0i8dhqgupOlc6Ci8MYJzw5v3/l3so4JhIpkNy
	BC6UwqIugVlJ9i2IlEP/0VHlndi0JzhQ/3Xh8qds/dxTVGLG1Erou6QJhW8AbSUJIjbkRarcVEYCj
	S5j9t9gy/9aWDyrsyJnRjXlM6+yuCAbf3AszQhp1EAlOxx9dXYKAKA0reQARpytozDgtpBl9nqFTW
	TsReSXVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waCpn-00000001MkX-03g5;
	Thu, 18 Jun 2026 13:31:07 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waCpk-00000001Mjc-2Yg2
	for kexec@lists.infradead.org;
	Thu, 18 Jun 2026 13:31:05 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2c6a4eccab1so50075ad.1
        for <kexec@lists.infradead.org>; Thu, 18 Jun 2026 06:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781789463; x=1782394263; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=97YgfxmG6Chl0Ir+S9QMmQ5bxu5X/S2hJhh/DZ4TYTw=;
        b=CEKhY13PqUt9zCW1go+iEAhMSQjYTJzlUqzsY2zmFyR+uD1QJdneD4Pe3f2q1bfeKp
         gflFVjEgnzVN85AFfwvtHOYLHJPkOOYJtR7CUd0YlV4og8Orbm1iJma8uLM0eLTfHj7d
         JV8z6rSny7R2UHi6Aq489rzQvm6i+ruEmRGkJC8Yd226ZKZ7LgW0Ksvo5WJELsxCYfx5
         m+bqHJNihfWrhNg5/CxFMy6ehPvCzl0jyCWTC9FxqjEjgJ12/RIX4Jhz8lAohqYfi+FS
         krv18ctxIXxX7qvYus6r3scEKQD6brgKkCy0SRpc0n7Ln9W0/Qw5atno+/BbDeQ7KT/w
         RLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781789463; x=1782394263;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=97YgfxmG6Chl0Ir+S9QMmQ5bxu5X/S2hJhh/DZ4TYTw=;
        b=OdU7kYwOSuu3KzvPH0rC9thOhx2EIz6xE/WLQ9CL/TGwEbi2T5x34qaVGquFsQAV14
         9uM5mnlsWgaOAMV7q0UGW9J1/8vNs85XQFopZj0ebz2bHmwdRTgC12IwRLckAXy0WBII
         pbxQ8GTmt1qh0ECYGvrTJB7L3L0hBksoRhlbx2zyIaeOqCxf/M7J6oOZDBVKaBeZcdXs
         muXmBu5tYvC2rCvVhS8KR8ntosRfm7e5KdH61EgAaXYvFOPirFmQ4YALzXkz3D4mzkLZ
         w8sS01LW9fqFlqq5NhLLVlHhdjyoLcbnFa9NsW12tk5bRyI/sOW72+9ZuOORLyF49NEw
         nRnw==
X-Forwarded-Encrypted: i=1; AFNElJ/Q8A39h9wC6v4Bmz45BLYIMlShU6DtemPl4HupGAd7yujkO9y8Hpb3SAXLzUaUgIKgOB5X8g==@lists.infradead.org
X-Gm-Message-State: AOJu0YywZ9Z6GS1dWh7n9wAioFS2ymcHSPls8nuIrre8LxixvfoBztwJ
	tyZESFOP0JmUlu30r1sO6CyU/vDGvPcwlhlxiHHd1qAg/DS066yqAuzYJa7pdEeJMA==
X-Gm-Gg: AfdE7ckmcXUhsg1e0xDlYMQg8WRLgeKMOiAjklOfbKrh+dl92tYlBytye0TlWiLK20M
	UTVux2nT1tJHmn2htBajgQfx0MWe0M+h8QLz2FQERzMjmoqZ0gEVlOH/x/FASLi/uWz9sQJppT9
	rH1YGgvEtp3weZti7ykp0ob4HB7B/FSncq6bt8ZwGbWLm5h2uEZbEcjv/WQsYAx4OKsz46ldATl
	XqQSIByASRg4eJ5reJrEWs1yxfC2JWCerrd2LDG6TNM/i4ViExKZWHmp8pjpytmwUFA6tRJ+xiM
	iotRsUnXZBTwa7BYVZjHuMlZpjkZhc5qxvOG6HK+C6ebQgMNNaf939O7gIN30CIAFReG526cxDQ
	MTV9bQmoadMpvVEbP3Obh+NKJibzRwl5ij9x7r9OWys6DjYYqa0Ht2vUTh9IfsHLF1iYpUrfmO7
	twv587xp6ggiYmBGRyemv/foa5yGmE0I8YN4DwIc7UBSl+BgEFtw==
X-Received: by 2002:a17:902:d587:b0:2b4:58ad:e987 with SMTP id d9443c01a7336-2c6e8692cdamr1747625ad.17.1781789461980;
        Thu, 18 Jun 2026 06:31:01 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521aa16fsm9477952a91.4.2026.06.18.06.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 06:31:00 -0700 (PDT)
Date: Thu, 18 Jun 2026 13:30:51 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org,
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
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <ajPzC2Xh1NMbfokP@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-2-dmatlack@google.com>
 <178124130274.908199.14827357870284807134.b4-review@b4>
 <aiutNINqxhtlm2Dt@kernel.org>
 <178126123047.908199.12042730612990730743.b4-reply@b4>
 <ajB6V6yBHOjgK5ew@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajB6V6yBHOjgK5ew@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260618_063104_647773_4EBD7943 
X-CRM114-Status: GOOD (  22.53  )
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

On Mon, Jun 15, 2026 at 10:19:03PM +0000, David Matlack wrote:
> On 2026-06-12 10:47 AM, Pasha Tatashin wrote:
> > On 2026-06-12 09:54:44+03:00, Mike Rapoport wrote:
> > > On Fri, Jun 12, 2026 at 05:15:02AM +0000, Pasha Tatashin wrote:
> > > 
> > > > On Fri, 22 May 2026 20:23:59 +0000, David Matlack <dmatlack@google.com> wrote:
> > > > 
> > > > Please add Pratyush, Mike, and myself so we are notified directly of 
> > > > incoming patches, the same as with other areas where the liveupdate/ 
> > > > tree is specified.
> > > 
> > > Or we can add PCI liveupdate files to LIVEUPDATE entry.
> > 
> > That will not work, as we cannot serve as maintainers for 
> > PCI/VFIO/IOMMU/KVM, etc. David Matlack will be the maintainer for the 
> > PCI components, and we will accept patches once they have been approved 
> > by him.
> > 
> > The simplification we could do is to create an email alias 
> > for the live-update tree maintainers. This would allow us to use a 
> > single entry instead of listing all three of us individually.
> 
> We could create a Live Update mailing list for all code that can be CCed
> on all patches that must be merged through the Live Update tree. I would
> also be interested in subscribing to that list.

+1. I'd like if there's a specific Live Update mailing list for
submissions & discussion about the Live Update tree.

Thanks,
Praan

