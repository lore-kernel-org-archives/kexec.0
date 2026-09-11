Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7E6C88E4D
	for <kexec@archiver.kernel.org>; Fri, 11 Sep 2026 18:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=647PeDACYFGwHy56KY6C8DNyZ6c/Uo5FYVw3HHMYVSA=; b=dorMKIQRWCvCg+OaAL7oe+Q2Zx
	Rc4IysNFWvkVLz4z+1EXdRLHwdEdLBb6PBoybhfA9aGG5Gu1NdEs+9raK9zhiki0pcj2yWPdmTEY2
	5OnGXvVGagPmtwJMpDBAT6QubYmR34kafRxm8VFh9+nEzoLpupLIR13zBizY0FzJsxBlk/yQmPogF
	4yZfLfKLJIbwnDkinDm33M9ZWdz2Y5DUo3zZfWUdX1p8mR59CocOYdH2OW6jueGIMb2Ss6M3diQ2V
	wkYuX1o8UlEUItPa8Q3Ajuz80EDWwr4UeVNPBXX80IJE7ve3irAqEul5qPcZgcz8Lwjlg3Dtbk/gw
	7k2S+TRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x562g-0000000HRzw-0zN3;
	Fri, 11 Sep 2026 18:32:06 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x562e-0000000HRzZ-1aYX
	for kexec@lists.infradead.org;
	Fri, 11 Sep 2026 18:32:05 +0000
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-cc4aa02a269so1140899a12.2
        for <kexec@lists.infradead.org>; Fri, 11 Sep 2026 11:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789151523; x=1789756323; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=647PeDACYFGwHy56KY6C8DNyZ6c/Uo5FYVw3HHMYVSA=;
        b=qonKHT2B7qWeESWwsfOJxBD9yJ0V28AzsPGR9N2B6HOFo7rN0hgIicRDdCaz+98t5r
         lPjdsraldwYhzygdvkT/c2AP+wN8yPwjO+fvWm+CQ1cmQWROn2hNm6H+w8SBMOFb7yUZ
         U3ZN6XE5ad63pFkJpMsKUkOePVk11Se5Vu/TFZRACDijLpUwtZvarY6mdQrqTf6v8Kb5
         a8cpnIUHalbKMzYeMAdPISvwri5t/2wizN4ZxLVvS1rhfa5tzS+85STYuJgE0mtc3USG
         m/dCC/m5Ws8c3YOXJSQAVEw9z08+qZVQsEw2OsFIM8Eac3HcrYoUoPcarJbh8H+PJT6t
         F0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789151523; x=1789756323;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=647PeDACYFGwHy56KY6C8DNyZ6c/Uo5FYVw3HHMYVSA=;
        b=IpGXOkEiYw501bL4FKKb00rtnFr1VGUwUg/Sr+2qWvDi8sM+OEf6IguccMpHMSeoaW
         qhypB8ZXzVweJ0unPh8szpBKNbwmoYeawH2ffVDgF2/woZIdIb9x4CgYSGIH0HxgAc6Z
         EgTk/2pbLdE0lQM2jjaSK8xVN5zRKAftif+3xLwrwiS6x+M37EAr3xKY/rT6lxbPyk4Y
         ciLVC12HnNC/5egCJygoidM7RcGIqtgGPzoxzZ805LoE7v7wH3/fma63Ow3ATq/XUllr
         bBtptuHBzf55jFjGvsYm6mXjqKqAcX8P0fHtaCKsjGMcYn1l1zutkW/0wMi/hgRXHv4Z
         eUyw==
X-Gm-Message-State: AFuF++lXFQsT5rZz0WkjxkSE8tZQhumlTBJZudYSMqhaC3Pq2D+gfO5G
	qTKBtV+6hf3zkVH3veIt87TmlALiI9Nqm9vNXVFsUREX7pU2DlUu6LZpPphCzgIt4Q07biZxKxb
	0McqhRq7Z
X-Gm-Gg: AYBFou192Wzdw0qQC8cOmGWDw8m2KreF2buqsWWfC/FufhOAdbOciHasB/xQikKqWV0
	TdsDRLdx5V6ZkCCXPi1NxCiMAnBhLy67v4F1agt7VWetXiRvK1F6F1vNPhlVlDmA4btvdkZpYHH
	NoOAT50aqGq3Ym1GCYtc5X90mMCq3NHjAl/Xa+G8+/5M65CPThYQHs+Oir6WDymfj8kpM+Wbcqo
	yYokBxwrEYYOm61qDecYt/CjDD/0D7ZNg55NtVaCPguowT7kCG5JuOV0w0HLh8pb6xZJoXA5ld6
	jWBbcFpbZVPuPoL4qR5fhdticqkSrA6mcVeJY2zQQ96tX11Xq+SRPqTOXFbHeomBTQhAge75CYT
	l+l+1lSh5VX1yhbqpT5ijeJKbfqubEEBmCxgxQwdqiFQH6uov5tPiLmfzcYGj+tnxMNCML0VRMt
	mgWmBFIvZ85z22m+AfLoGvEmbyn3JiBoku+y0VJB3vQDB2Opta0Edn7ufxVph5LeOPXzmjPGJ7e
	+9xjXPeRE+1nu+EwvJZ7aIRxSV+Yo/jO8ch7Dgkvv/cAc9Fj24=
X-Received: by 2002:a05:6a20:4308:b0:3c4:3767:adb2 with SMTP id adf61e73a8af0-3daed46ab05mr10698355637.1.1789151522711;
        Fri, 11 Sep 2026 11:32:02 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c657156bsm1621771a12.21.2026.09.11.11.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:32:01 -0700 (PDT)
Date: Fri, 11 Sep 2026 18:31:51 +0000
From: David Matlack <dmatlack@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Subject: Re: [PATCH v8 08/12] PCI: liveupdate: Adopt ACS controls in incoming
 preserved devices
Message-ID: <aqRJF8OME7hn7CJr@google.com>
References: <20260728221007.2098560-9-dmatlack@google.com>
 <20260910235149.GA364189@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910235149.GA364189@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_113204_424268_28527EF5 
X-CRM114-Status: GOOD (  16.78  )
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

On 2026-09-10 06:51 PM, Bjorn Helgaas wrote:

> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 77b17b13ee61..22001bdf4c97 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -34,6 +34,8 @@
> >  #include <linux/aer.h>
> >  #include <linux/bitfield.h>
> >  #include <linux/suspend.h>
> > +
> > +#include "liveupdate.h"
> >  #include "pci.h"
> >  
> >  DEFINE_MUTEX(pci_slot_mutex);
> > @@ -1008,6 +1010,9 @@ void pci_enable_acs(struct pci_dev *dev)
> >  	bool enable_acs = false;
> >  	int pos;
> >  
> > +	if (!pci_liveupdate_enable_adopted_acs_controls(dev))
> > +		return;
> 
> Ugh.  The asymmetry between pci_save_state(), which does nothing
> ACS-related, and pci_restore_state(), which enables it, is sort of
> sketchy to begin with.
> 
> The command-line parsing in this path feels like kind of a wart (not
> that you're touching it).
> 
> It just seems like this path is already hard to analyze, and
> liveupdate is making it harder.
> 
> If we could save/restore the ACS state around the reset, wouldn't that
> solve this without any liveupdate specials here?

Yeah that would simplify the liveupdate support greatly. Let me work on
that for v9.

