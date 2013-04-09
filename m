Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UPbEp-0007Bk-6u
 for kexec@lists.infradead.org; Tue, 09 Apr 2013 16:17:39 +0000
Message-ID: <51643F20.3010907@citrix.com>
Date: Tue, 9 Apr 2013 17:17:36 +0100
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 4/8] kexec: add infrastructure for handling
 kexec images
References: <1365447593-11988-1-git-send-email-david.vrabel@citrix.com>
 <1365447593-11988-5-git-send-email-david.vrabel@citrix.com>
 <5163E2FE02000078000CB9B7@nat28.tlf.novell.com>
In-Reply-To: <5163E2FE02000078000CB9B7@nat28.tlf.novell.com>
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
To: Jan Beulich <JBeulich@suse.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Daniel Kiper <daniel.kiper@oracle.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>, Ian Campbell <Ian.Campbell@citrix.com>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On 09/04/13 08:44, Jan Beulich wrote:
>>>> On 08.04.13 at 20:59, David Vrabel <david.vrabel@citrix.com> wrote:
>> +        ret = kimage_add_page(image, page_to_mfn(page) << PAGE_SHIFT);
> 
> Constructs like this aren't portable. You ought to use
> page_to_maddr(), and have the called function have paddr_t
> instead of unsigned long as the respective parameter.

I will make this change but it isn't clear to me why this isn't portable.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
