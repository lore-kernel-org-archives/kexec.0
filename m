Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U8rDK-0003sc-Su
 for kexec@lists.infradead.org; Fri, 22 Feb 2013 11:54:55 +0000
Message-ID: <51275C8C.80506@citrix.com>
Date: Fri, 22 Feb 2013 11:54:52 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 5/8] kexec: extend hypercall with improved
 load/unload ops
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
 <1361468894-18655-6-git-send-email-david.vrabel@citrix.com>
 <51273D9D02000078000C03D4@nat28.tlf.novell.com>
In-Reply-To: <51273D9D02000078000C03D4@nat28.tlf.novell.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jan Beulich <JBeulich@suse.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On 22/02/13 08:42, Jan Beulich wrote:
>>>> On 21.02.13 at 18:48, David Vrabel <david.vrabel@citrix.com> wrote:
>> Crash images are copied directly into the crash region on load.
>> Default images are copied into Xen heap pages and a list of source and
>> destination machine addresses is created.  This is list is used in
>> kexec_reloc() to relocate the image to its destination.
> 
> Did you carefully consider the implications of using Xen heap pages
> here as opposed to domain heap ones? On huge systems, this may
> prevent kexec from working, as you're not just trying to allocate a
> handful of pages. IOW, is the less complex code really worth the
> increased likelihood of a failure here?

I wouldn't say carefully considered... I thought about using dom heap
briefly and took the lazy route.

I take your point though and will change it to use the dom heap.  Is
there a way to verify that all the map/unmaps are correctly done and it
isn't just working by chance?  Some sort of debug option?

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
