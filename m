Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nat28.tlf.novell.com ([130.57.49.28])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U8oCa-0007Iq-QY
 for kexec@lists.infradead.org; Fri, 22 Feb 2013 08:41:57 +0000
Message-Id: <51273D9D02000078000C03D4@nat28.tlf.novell.com>
Date: Fri, 22 Feb 2013 08:42:53 +0000
From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH 5/8] kexec: extend hypercall with
 improved load/unload ops
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
 <1361468894-18655-6-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1361468894-18655-6-git-send-email-david.vrabel@citrix.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, xen-devel@lists.xen.org

>>> On 21.02.13 at 18:48, David Vrabel <david.vrabel@citrix.com> wrote:
> Crash images are copied directly into the crash region on load.
> Default images are copied into Xen heap pages and a list of source and
> destination machine addresses is created.  This is list is used in
> kexec_reloc() to relocate the image to its destination.

Did you carefully consider the implications of using Xen heap pages
here as opposed to domain heap ones? On huge systems, this may
prevent kexec from working, as you're not just trying to allocate a
handful of pages. IOW, is the less complex code really worth the
increased likelihood of a failure here?

Jan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
