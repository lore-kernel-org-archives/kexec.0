Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E046FC531F9
	for <kexec@archiver.kernel.org>; Sat, 25 Jul 2026 21:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VW4Itax4uaoOUozvRTGW+C9GkAjA2igtg5x/nUSArMo=; b=4iuK6yiShSXNIbMsVd6WCgkjIq
	lHPJDSVKq0zFA/O1l4gD2xnKlvybxwWsT4vWQ09yOkaaTteJRFRIdl0emjou3P+RCXZ6eDZj2PIiJ
	+fz8Dyl3o4xeDsGz6JpoMTUIA+xKw5MfWvmD8n9ddnPnjGEB1WzLFEzGjozvOlGtI5Bb0+e+AJLEv
	1pRFzQNeOTbFD2Wq+4kCRqSDpDN32WmmzzvsTAtfRDu1Mxm5KZXwxWF6ICFOLjIGNEsGhz73bh4sI
	u05c56W+ZejrTmhOKZs1/VrpZn/t8GsSzho9YI+ghB8kCcpX/tHzFdumn2CHuz398x/DFzMYnImHD
	SmYik3Zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnk41-00000000jNp-1W8n;
	Sat, 25 Jul 2026 21:37:45 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnk3y-00000000jNf-1Tke
	for kexec@lists.infradead.org;
	Sat, 25 Jul 2026 21:37:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 67EB54393C;
	Sat, 25 Jul 2026 21:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAD91F000E9;
	Sat, 25 Jul 2026 21:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785015459;
	bh=VW4Itax4uaoOUozvRTGW+C9GkAjA2igtg5x/nUSArMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aeUZK1YeDV5CnqM+wNZjzhm24RcMioMzbLfMV/YltypRgeB+j417/pVDmBUIgRG1q
	 +WmUeKXEas44pAsguF1wIvjbr+ffU9aQUbnHE/NfzNKzdpH2C1+0AWjA3eiu2KcPEG
	 pyxSopA9mMB4fC6Ioy0JHbR2Ra8b8s8l32khIajc=
Date: Sat, 25 Jul 2026 14:37:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>, Baoquan He <baoquan.he@linux.dev>,
 Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Simona Vetter
 <simona.vetter@ffwll.ch>, Suren Baghdasaryan <surenb@google.com>, Vlastimil
 Babka <vbabka@kernel.org>, Dave Young <ruirui.yang@linux.dev>,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
 kexec@lists.infradead.org, driver-core@lists.linux.dev
Subject: Re: [PATCH v2 0/3] mm,kernfs,proc: Unmap mmaps of removed files via
 file->f_mapping
Message-Id: <20260725143737.daa698b50289257fbaa9c6f1@linux-foundation.org>
In-Reply-To: <20260725210549.3716546-1-kwilczynski@kernel.org>
References: <20260725210549.3716546-1-kwilczynski@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On Sat, 25 Jul 2026 21:05:46 +0000 Krzysztof Wilczyński <kwilczynski@kernel.org> wrote:

> Hello,
> 
> The PCI resource files in sysfs and the /proc/bus/pci device files swap
> their f_mapping to the shared iomem address space at open time, so that
> revoke_iomem() can unmap userspace mappings when a driver claims a
> region, see commit 636b21b50152 ("PCI: Revoke mappings like devmem").
> 
> Their VMAs are therefore attached to the shared address space, which
> neither removal path reaches: kernfs_drain_open_files() unmaps the
> sysfs inode's own mapping, which contains none of them, and
> proc_entry_rundown() does not unmap anything at all.
> 
> As a result, userspace mappings of PCI BARs survive device removal,
> and also survive a BAR resize on the sysfs side, keeping stale PTEs
> into physical address space that the kernel may have reassigned since.
> A mapping made before the device is removed still returns the previous
> register value after the device has been released, through both
> interfaces.

Thanks.  Can we please have full description of the userspace-visible
effects of this?

AI review might have found a few things:
	https://sashiko.dev/#/patchset/20260725210549.3716546-1-kwilczynski@kernel.org


