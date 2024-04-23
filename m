Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F9BC4345F
	for <kexec@archiver.kernel.org>; Tue, 23 Apr 2024 13:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gGiXduR1K4Z9ZfmD/h4jep274HxFyxnTL/mpHttDahk=; b=qiTargML6abdLw
	yeltBuaQrbHHd6512k9DJchxi45Nmq3wJxKQOqVM/wcKVWkuV9GYgsbUDMH+pqDUDTAUPwkfS0RkK
	kYxa49+WFuwcxEteKVNydmp3suU2EfEPcXWDBn9XBo3Bc7kAr6KZSt6zQZdCEp/cr5J66/y9eoIgu
	HV4tKi5nFRkWHBse93Hp6KG7Sues/8xUrJkNPh4IUcibpRyC8UFjYEmQIiYE+gDgQ//fgAo6f56+l
	hctJbdj6EgJ1ruQzz1hwuBpe7IvNmVH5EQ55UDzdCR7TR3QvP+6MDBaykc3t4GM2nuxb78WmCyy3t
	zA2qsRzecPlWdl/+e7Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzG2E-000000001tN-3VGk;
	Tue, 23 Apr 2024 13:18:10 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzG2A-000000001on-3cCZ
	for kexec@lists.infradead.org;
	Tue, 23 Apr 2024 13:18:08 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7476E40E0249;
	Tue, 23 Apr 2024 13:17:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZmmPyGl0kbM1; Tue, 23 Apr 2024 13:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1713878268; bh=bGv9rvNJpD/Du1WCJOGw7wL73HyEy9ZaslIxxlYF+L0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aEd8+rWoBs1tm/jlNDLyHiPCgDXZIYMDCzd59OM6O9E3NsADxYrDxSXD7Gn98Dfcb
	 XqBNHMns7F0jCVwlNXPZSxs1W3h6CWNzEzdPitMGbLggU2c3kc/QoJBdKs4SIZOsw6
	 B1F6YlJuPEhgeqURMgzNaI25MnI0wrSn7U+3iIuIxKLAHeGBzHO2mNTfpxE3o/mBOQ
	 uNt0VodVP1wLaANb6Yhdeyh/JlibaJyagFJ/EH1w0zOJ8wyTZZiTBBivSb2ad0/upD
	 qvBbqZLI5tqGDo1+9gVhDhfG5q6jHa0GMye1l70kWqLkTbj5Lcw3Pa5VNlUi+UziQM
	 c4eHwxOFiX9GyIJ8AlbkjXCAkBuceg9fFFv75OPJEHNZtfbx7HuUTIRnQ8axRe03+Y
	 DmI5QzC/V6YTixrwTzDyK0twmRx+0xKZbXYK7BdLKi9qLqYcJ3Hj0DpIttttObKj1a
	 rhKl6s/LcVdujmQAKnlkfW2IlSm3AHBP6v/s/q1FnB06uPQKd9fwvLKHbWLqEfSfu3
	 hbdNvUEm5FHycGeSK6QBM+Z3glqFBCMxTA3H0kmTPT20WFEeceXQEcaA0wYHZtkpJy
	 9BFfWVol1wINcVUC7lRP7Wc88AEjkPSMizpHXgWcbJJnYD+cY9P+eep/SO1/MQ8Uwr
	 kxr+RwxTI/5xscJgUhKSi2JM=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5B8AA40E0177;
	Tue, 23 Apr 2024 13:17:27 +0000 (UTC)
Date: Tue, 23 Apr 2024 15:17:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv10 03/18] cpu/hotplug: Add support for declaring CPU
 offlining not supported
Message-ID: <20240423131722.GIZie04oK5g5f8Jftr@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-4-kirill.shutemov@linux.intel.com>
 <20240418143709.GJZiEwFejGQY3jiwsp@fat_crate.local>
 <rju6u37prtr5nf4upcntcy4jcnul6atqmbh6impzqdn3dlo2pj@lqodxa7elohz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <rju6u37prtr5nf4upcntcy4jcnul6atqmbh6impzqdn3dlo2pj@lqodxa7elohz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_061807_070769_B756CF11 
X-CRM114-Status: GOOD (  10.46  )
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

On Fri, Apr 19, 2024 at 04:31:39PM +0300, Kirill A. Shutemov wrote:
> Yes, it is one-off. I guess we could use READ_ONCE()/WRITE_ONCE() to
> access the variable with the same result. I am not sure why it would be
> better.

Nah, and it is not even the first one-off:

cpu_hotplug_disable/_enable() uses the same locking to update
cpu_hotplug_disabled.

I guess we need to update the comment over cpu_maps_update_begin().

I guess this is fine wrt big picture of the CPU hotplug universe. Lemme
point tglx to it just in case.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
