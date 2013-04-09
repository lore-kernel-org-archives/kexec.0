Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from nat28.tlf.novell.com ([130.57.49.28])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UPTEJ-0002LN-Ul
 for kexec@lists.infradead.org; Tue, 09 Apr 2013 07:44:36 +0000
Message-Id: <5163E2FE02000078000CB9B7@nat28.tlf.novell.com>
Date: Tue, 09 Apr 2013 08:44:30 +0100
From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH 4/8] kexec: add infrastructure for
 handling kexec images
References: <1365447593-11988-1-git-send-email-david.vrabel@citrix.com>
 <1365447593-11988-5-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1365447593-11988-5-git-send-email-david.vrabel@citrix.com>
Mime-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xen.org
Cc: kexec@lists.infradead.org, Daniel Kiper <daniel.kiper@oracle.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>, Ian Campbell <Ian.Campbell@citrix.com>

>>> On 08.04.13 at 20:59, David Vrabel <david.vrabel@citrix.com> wrote:
> +        ret = kimage_add_page(image, page_to_mfn(page) << PAGE_SHIFT);

Constructs like this aren't portable. You ought to use
page_to_maddr(), and have the called function have paddr_t
instead of unsigned long as the respective parameter.

> +    struct page_list_head unuseable_pages;

unusable_pages.

Also there appear to be a few hard tabs here and there.

Jan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
