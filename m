Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from nat28.tlf.novell.com ([130.57.49.28])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UPqWg-0007XE-JE
 for kexec@lists.infradead.org; Wed, 10 Apr 2013 08:37:07 +0000
Message-Id: <516540CB02000078000CBFB6@nat28.tlf.novell.com>
Date: Wed, 10 Apr 2013 09:36:59 +0100
From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH 4/8] kexec: add infrastructure for
 handling kexec images
References: <1365447593-11988-1-git-send-email-david.vrabel@citrix.com>
 <1365447593-11988-5-git-send-email-david.vrabel@citrix.com>
 <5163E2FE02000078000CB9B7@nat28.tlf.novell.com>
 <51643F20.3010907@citrix.com>
In-Reply-To: <51643F20.3010907@citrix.com>
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
To: David Vrabel <david.vrabel@citrix.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Daniel Kiper <daniel.kiper@oracle.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>, Ian Campbell <Ian.Campbell@citrix.com>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

>>> On 09.04.13 at 18:17, David Vrabel <david.vrabel@citrix.com> wrote:
> On 09/04/13 08:44, Jan Beulich wrote:
>>>>> On 08.04.13 at 20:59, David Vrabel <david.vrabel@citrix.com> wrote:
>>> +        ret = kimage_add_page(image, page_to_mfn(page) << PAGE_SHIFT);
>> 
>> Constructs like this aren't portable. You ought to use
>> page_to_maddr(), and have the called function have paddr_t
>> instead of unsigned long as the respective parameter.
> 
> I will make this change but it isn't clear to me why this isn't portable.

Because left shifting an unsigned long may shift out significant bits,
namely on 32-bit architectures (and the code here is - iirc - living
under xen/common/).

Jan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
