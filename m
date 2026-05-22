Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE27CD5BB0
	for <kexec@archiver.kernel.org>; Fri, 22 May 2026 17:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=QvhytzGMgy3nE/I3M4lZRHo1Fz4WHKJA8K2mHNM+zQY=; b=ibDtALDUSky/LB
	Mo8ZS8YKW9H6M0Suevpxz/75UgLPRn9IgZdsNPmCNPIclqcv9AISfVrJngCeGkakmqw23VZDZSgWC
	m6g85fSXhLOdbm7JQ95OQiklu0vLCnnB98UNgyhMeOaBUuwNRxZsZ7PkM+Mq6Ty24Kuln4g1fRX04
	JOF3jXodY9OJuVhgfduQRktF+qHOlY3Y4HwCGWSfkPC5medhaeU/DSRPkNuXeN76IU0VYcm5OTGRL
	CVnNqFkNgRzaLbOyxkWhbJ2knIWga8diO9XkNwCCcI+bHwVHuyhALmj395xIXRkxEL0U0eq7hbbsK
	ub56s4raxCMhplMRKoqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQU9N-0000000BcaS-32pX;
	Fri, 22 May 2026 17:59:09 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQU9L-0000000BcYe-0ovG
	for kexec@lists.infradead.org;
	Fri, 22 May 2026 17:59:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id 6A2A140D81;
	Fri, 22 May 2026 17:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 23DC41F000E9;
	Fri, 22 May 2026 17:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779472746;
	bh=QvhytzGMgy3nE/I3M4lZRHo1Fz4WHKJA8K2mHNM+zQY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=R/lF87yYK3T8ZgihOcJLjT1tJ2iqucYpoTXz+lE+iNM8GsdPFgTHohAXTIRWiXCaq
	 Z3sLJcXDGLxdXpbjd5vXsU6R9vl67LHiffd1HrCgb9F7RXCuMOOfdz7pnSMbp79xKx
	 bqeV2FB/iwmC+djHEZ5mqJS5Do9oSrdFTfzKqDljYArEUikYmdVLSGNtDVRe2CbZXe
	 nSlHxZCLg/t15FV7B3ebQdjPPEJOXYtquDgAXX27hU8eVFNYP8lGHAlA4FwFKLJOmb
	 9sPWoEQ7WIovdqVHFNJR3cl90/fD+OjTmJ5s3ncJReREDo+cltiTIVjISJ3mzjWVrW
	 j+eMJNK+bTxAw==
Date: Fri, 22 May 2026 12:59:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Matlack <dmatlack@google.com>
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
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v5 05/11] PCI: liveupdate: Keep bus numbers constant
 during Live Update
Message-ID: <20260522175905.GA232400@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512184846.119396-6-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_105907_254999_7EE19417 
X-CRM114-Status: GOOD (  11.08  )
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

On Tue, May 12, 2026 at 06:48:40PM +0000, David Matlack wrote:
> ...

> + * The PCI core guarantees that preserved devices can be identified by the same
> + * bus, device, and function numbers for as long as they are preserved
> + * (including across kexec). To accomplish this, the PCI core always inherits
> + * the secondary and subordinate bus numbers assigned to bridges during scanning
> + * if any device is preserved. This is true even on architectures that always
> + * assign new bus numbers during scanning. The kernel assumes the previous
> + * kernel established a sane bus topology across kexec.
> + *
> + * If a misconfigured or unconfigured bridge is encountered during enumeration
> + * while there are preserved devices, itss secondary and subordinate bus numbers
> + * will be cleared and devices below it will not be enumerated.

s/itss/its/

> + * To keep things simple, inherit the secondary and subordinate bus numbers on
> + * _all_ bridges if _any_ PCI devices are preserved (i.e.  even bridges without
> + * any downstream endpoints that were preserved).  This avoids accidentally
> + * assigning a bridge a new window that overlaps with a preserved device that is
> + * downstream of a different bridge.

s/i.e.  even/i.e. even/ (remove extra space)

