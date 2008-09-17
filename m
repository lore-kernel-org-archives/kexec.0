Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kfn2Z-0006lz-9L
	for kexec@lists.infradead.org; Wed, 17 Sep 2008 02:45:15 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <48D0067F.3020007@esentire.com>
	<20080917005542.GD15750@verge.net.au>
Date: Tue, 16 Sep 2008 19:40:55 -0700
In-Reply-To: <20080917005542.GD15750@verge.net.au> (Simon Horman's message of
	"Wed, 17 Sep 2008 10:55:42 +1000")
Message-ID: <m1tzcfa408.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec, kernel 2.6.26.5,
	segmentation fault in kimage_add_entry
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Jonathan Steel <jon.steel@esentire.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Simon Horman <horms@verge.net.au> writes:

> On Tue, Sep 16, 2008 at 03:18:23PM -0400, Jonathan Steel wrote:
>> A segmentation fault can occur in kimage_add_entry in kexec.c when 
>> loading a kernel image into memory. The fault occurs because a page is 
>> requested by calling kimage_alloc_page with gfp_mask GFP_KERNEL and the 
>> function may actually return a page with gfp_mask GFP_HIGHUSER. The high 
>> mem page is returned because it was swapped with the kernel page due to 
>> the kernel page being a page that will shortly be copied to.
>> 
>> This patch ensures that kimage_alloc_page returns a page that was 
>> created with the correct gfp flags.
>
> I wonder if this problem might also affect other users of
> kimage_alloc_pages(), and if so, perhaps it should guard
> against this?

No.  kimage_alloc_pages() is a light wrapper around alloc_pages that simply
marks the pages as reserved so they don't get used for other things while
we have a hold of them.

kimage_alloc_page() does a check to see if the page we have just allocated
is the a page we are going to copy to and if so it does the copy of the
data now, and frees the page that was holding the data.

As an optimization it returns the page holding the data.  The problem is that
we allocate control pages as GFP_KERNEL and data pages GFP_HIGHUSER.  And so
they are not completely interchangeable.

Since this check and swap only happens inside of kimage_alloc_page it only affects
kimage_alloc_page.

Eric
n

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
