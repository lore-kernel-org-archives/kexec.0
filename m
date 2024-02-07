Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F01C4828D
	for <kexec@archiver.kernel.org>; Wed,  7 Feb 2024 15:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TDZL1glKxinOSSfU25DKzlHJ9wgIeoX6OHjt0xbVcL0=; b=y+UJYAjLfuI14x
	24TweuoJOreAJ516AJ8zuDC7SejEA/pVv1t5B7j1UgH7cBCRNzGyMY+4uiqSSpf9+kqJt2cThiXa1
	1nrkjMOD8/TFzNWSpMr9F+15UHVnP+ZNtdAt4gEEu6c14eQY4NU7wRHHs44m2K+X+jX5ALOGlOCkw
	xNuVNoEmATbfQ47MHKk0f0/8StNTyu6CfvA6xXyN3u0qHXAPvbPu7Yx/8V2PfzXr1W6yzeZQbI8GP
	2DcR3bEp9DF7Ad97J8xbRh9FqHjHV0p6kFQjAG/gzrtvc0l/wRhhTWFJnBonMFmZpkUHBvTuk3Oi9
	i30FHVQrlPI1TlAQuLxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXjrC-0000000B5n9-0Bdy;
	Wed, 07 Feb 2024 15:29:02 +0000
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXjr8-0000000B5m0-3nQI
	for kexec@lists.infradead.org;
	Wed, 07 Feb 2024 15:29:00 +0000
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-218f4589f0cso273389fac.3
        for <kexec@lists.infradead.org>; Wed, 07 Feb 2024 07:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707319736; x=1707924536; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KgcZE+tbSx7VYsRad6qU230OGLkbrGEcFdePnG3XBqw=;
        b=IOo/lk0gIggFEIJ/OSMNb20J1SvJCXiijoEzlQkROdjbvG5s5+XGsB3P1BC/Ljp9F4
         GwAuxqWD8qz5FaPSoHbfy9NRLutaRK/8HU3W9fmwt3crVXkaUGt/P6i0cJ2ILBru27uK
         YqSxUOMCyr63lOIkeMQQuj7BydFBVDJMwf58eeY/cJux9b6XhwakP8XiC1yhfDbqaYX2
         vLS6S28DM9aQ9OSqAvCSw0RKVlApcswkC9n/lqs/O+l1JfN/BIoRXLczY+bFdfBpE5JT
         H/F05lKfa7+ob8Z6TpRv9Ox8zZBFd+PWNbMc58FFJ+6Y2AseJTYvAeQ6b9J5cbv/QOVO
         gTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707319736; x=1707924536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgcZE+tbSx7VYsRad6qU230OGLkbrGEcFdePnG3XBqw=;
        b=U075TwXZVr2H1n/9w7Eq0cE4m5Tp6QFMcPu/f2aOojBDnpmH9kRYAKsyENaAa1T04E
         EZxwB46qYRdyd2M+LozRNZ8a53w2Gex2rMlcVeggz7EpGVBQtRZjrymKUWFWbrF8uTHw
         BLqc5gEnpkEFpibuL7IH5SQBhcVdZEW4y0u+bmTgjzb5q0egfl5yxDQ+v1MLGG/Yti9R
         ePaYP98/8lL3odmLYrVEnvtgSrm9B6YMUQGvSnxDP/rOD4qhCuyC5BAnDtIzry2r5A/P
         WPP8+QzU+iHgd/kG5C9eJoQ/R8WiW0td2hjXKcY3h2k1NK1DaThiE/MfmM2eQtB7avQU
         WmfQ==
X-Gm-Message-State: AOJu0YzE7aZQw7VMpbAqRXBPOApSVxvyzxSkgj9YI9zCpqm3BmFjMbLd
	NP6XIyiEvBoR64Uk6hELmQ9qs4UjF/UwEIIql68Chc3NycrzlBHJTKDvssQ5LNc=
X-Google-Smtp-Source: AGHT+IHEL7CFznI2Gw3SaxhMoycGQY1ZAMJ2M/MoHIzeasU/nr/2JepWSFEuheW8Ams28t9PtymRRw==
X-Received: by 2002:a05:6870:bac7:b0:219:83cc:287c with SMTP id js7-20020a056870bac700b0021983cc287cmr6065943oab.18.1707319736190;
        Wed, 07 Feb 2024 07:28:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVUY+po1giBXhl03Vf0urto5lU8KkUE0xa/D+uEwt3aAnuuk7whgR0HTCfY+MTVQpslUqqUs/wsMp+t3ROMVbRdiv139tCe2ZBXKAtq4ZceV9PQJGgSNRI8IXanfewIYC0pI3FzZsKmRPGCkekyIVSuYunEdq/NKi0/3z9aOOnSjGhG1HWtDCKx6tkf7sG69wd0voFNXVKcPnx/Nm+iJxlnF6OfGX8tZ9W5Ef2TdHxCT40iWFJmfW6S8uQKXx/coePehrn7fBGc1ApNtwTAo8s/s5HRc5UVF5kRUR22WO8nHBRkrzcJX/Ul/xP8hPJikjNY5otCJsvQrEVBk2ZaVzx3MkqaDTyR4Ul7c2lNd1sQoJE9R4hMA5FyNT4k6cGm9+PELO3Pd2X6HZW5Jm8qV/VAErzvt6LcaoXye2Wua/2AYMT/wp1V94k8M1zgi8oPWuI9edPTgsfIAIs+qSWZnIHymtDR0ZDoa4pbEKoLlGJm39ZpBPkOgypT7AHFEI8rU/GAr/BBLOvIN75lw9qDVd4OTS7E4DjE+P+TXjW/ejHtWFFjkRAxscCfnxXGlxTCjMW8flXh31SrWNWQb7kthgrk5FZ0nc1rQCTq6Q8fWQP0Awd0gAJf2PwiCs47eD05aetIREJ1Gf81uCiJ/HxdH+LBZUmXJT18VOvJdRMBqtyz
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id p6-20020a9d76c6000000b006e112c93b1esm228799otl.6.2024.02.07.07.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 07:28:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rXjr4-008ccK-Kk;
	Wed, 07 Feb 2024 11:28:54 -0400
Date: Wed, 7 Feb 2024 11:28:54 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gowans, James" <jgowans@amazon.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"Woodhouse, David" <dwmw@amazon.co.uk>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	=?utf-8?B?U2Now7ZuaGVyciwgSmFuIEgu?= <jschoenh@amazon.de>,
	"will@kernel.org" <will@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>
Subject: Re: [RFC 00/18] Pkernfs: Support persistence for live update
Message-ID: <20240207152854.GL31743@ziepe.ca>
References: <20240205120203.60312-1-jgowans@amazon.com>
 <20240205101040.5d32a7e4.alex.williamson@redhat.com>
 <6387700a8601722838332fdb2f535f9802d2202e.camel@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6387700a8601722838332fdb2f535f9802d2202e.camel@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_072858_978514_E0E4D396 
X-CRM114-Status: GOOD (  10.29  )
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

On Wed, Feb 07, 2024 at 02:56:33PM +0000, Gowans, James wrote:
> 2. Tell VFIO to avoid mapping the memory in again after live update
> because it already exists.
> https://github.com/jgowans/qemu/commit/6e4f17f703eaf2a6f1e4cb2576d61683eaee02b0
> (the above flag should only be set *after* live update...).

Definately no to that entire idea. It completely breaks how the memory
lifetime model works in iommufd.

iommufd has to re-establish its pins, and has to rebuild all its
mapping data structures. Otherwise it won't work correctly at all.

This is what I was saying in the other thread, you can't just ignore
fully restoring the iommu environment.

The end goal must be to have fully reconstituted iommufd with all its
maps, ioas's, and memory pins back to fully normal operation.

IMHO you need to focus on atomic replace where you go from the frozen
pkernfs environment to a live operating enviornment by hitlessly
replacing the IO page table in the HW. Ie going from an
IOMMU_DOMAIN_PKERFS to an IOMMU_DOMAIN_PAGING owned by iommufd that
describes exactly the same translation.

"adopting" an entire io page table with unknown contents, and still
being able to correctly do map/unmap seems way too hard.

Jason

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
