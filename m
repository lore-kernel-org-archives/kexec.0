Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4046CAC589
	for <kexec@archiver.kernel.org>; Tue,  9 Sep 2025 07:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CMlqYlKj+ILUokIqP1ABAMFD7Ot5oBLbcsJFMFm2zE0=; b=Ip5uZCvjmX/guf4ooEFPBY+cp7
	y9PVRtNxD5XbUxoRWVQY0zq+XqEJijmkjRhpljMeghdFsmPVuyQr4sdTy1DE4fX6Rnvq2lePc0JuP
	LTSxv/mAdsP5otu7BTQ/beVtCk4AczgPydFq1KNzugz21xBnXkS5PET0lcL3O7qym2FQ8E/HUgIcX
	WdS35MyH3GJc6V5LPZFyuCa2tOWLkJR8p1WtIFW02b1gnaEQWFI7bNaWss4aIkh2vKxfWZL2gd4QQ
	wTUI2DqHXLYOkml8/u7N80HP+7p2A3U7dJfTaZtnBno4VpMDNyxkuOs60PtZMereFDBIGXOxshN/B
	hXOBTudw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvsye-00000005HJ7-1Ty5;
	Tue, 09 Sep 2025 07:41:20 +0000
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvl6s-00000002unf-1xHe;
	Mon, 08 Sep 2025 23:17:18 +0000
Message-ID: <c0d7df5f-ac43-4e15-8400-155bf87d5e77@infradead.org>
Date: Mon, 8 Sep 2025 16:17:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] doc: update porting, vfs documentation for
 mmap_[complete, abort]
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Guo Ren <guoren@kernel.org>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Nicolas Pitre <nico@fluxnic.net>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Uladzislau Rezki <urezki@gmail.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
 kexec@lists.infradead.org, kasan-dev@googlegroups.com,
 Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <1ceb56fec97f891df5070b24344bf2009aca6655.1757329751.git.lorenzo.stoakes@oracle.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1ceb56fec97f891df5070b24344bf2009aca6655.1757329751.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 08 Sep 2025 23:53:50 -0700
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

Hi--

On 9/8/25 4:10 AM, Lorenzo Stoakes wrote:
> We have introduced the mmap_complete() and mmap_abort() callbacks, which
> work in conjunction with mmap_prepare(), so describe what they used for.
> 
> We update both the VFS documentation and the porting guide.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  Documentation/filesystems/porting.rst |  9 +++++++
>  Documentation/filesystems/vfs.rst     | 35 +++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 

> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 486a91633474..172d36a13e13 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst

> @@ -1236,6 +1240,37 @@ otherwise noted.
>  	file-backed memory mapping, most notably establishing relevant
>  	private state and VMA callbacks.
>  
> +``mmap_complete``
> +	If mmap_prepare is provided, will be invoked after the mapping is fully

s/mmap_prepare/mmap_complete/ ??

> +	established, with the mmap and VMA write locks held.
> +
> +	It is useful for prepopulating VMAs before they may be accessed by
> +	users.
> +
> +	The hook MUST NOT release either the VMA or mmap write locks. This is

You could also do **bold** above:

	The hook **MUST NOT** release ...


> +	asserted by the mmap logic.
> +
> +	If an error is returned by the hook, the VMA is unmapped and the
> +	mmap() operation fails with that error.
> +
> +	It is not valid to specify this hook if mmap_prepare is not also
> +	specified, doing so will result in an error upon mapping.

-- 
~Randy


