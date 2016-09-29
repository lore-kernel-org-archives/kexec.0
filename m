Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bpWDW-0001YI-Mn
 for kexec@lists.infradead.org; Thu, 29 Sep 2016 07:57:19 +0000
Date: Thu, 29 Sep 2016 09:43:24 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v1] kexec/arch/i386: Add support for KASLR memory
 randomization
Message-ID: <20160929074324.GD14497@verge.net.au>
References: <1473750605-5955-1-git-send-email-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1473750605-5955-1-git-send-email-bhe@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: kernel-hardening@lists.openwall.com, kexec@lists.infradead.org, Thomas Garnier <thgarnie@google.com>, keescook@chromium.org, tonli@redhat.com

On Tue, Sep 13, 2016 at 03:10:05PM +0800, Baoquan He wrote:
> From: Thomas Garnier <thgarnie@google.com>
> 
> Multiple changes were made on KASLR (right now in linux-next). One of
> them is randomizing the virtual address of the physical mapping, vmalloc
> and vmemmap memory sections. It breaks kdump ability to read physical
> memory.
> 
> This change identifies if KASLR memories randomization is used by
> checking if the page_offset_base variable exists. It search for the
> correct PAGE_OFFSET value by looking at the loaded memory section and
> find the lowest aligned on PUD (the randomization level).
> 
> Related commits on linux-next:
>  - 0483e1fa6e09d4948272680f691dccb1edb9677f: Base for randomization
>  - 021182e52fe01c1f7b126f97fd6ba048dc4234fd: Enable for PAGE_OFFSET
> 
> Signed-off-by: Thomas Garnier <thgarnie@google.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
