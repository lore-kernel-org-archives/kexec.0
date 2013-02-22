Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nat28.tlf.novell.com ([130.57.49.28])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U8sO4-0002bL-Fz
 for kexec@lists.infradead.org; Fri, 22 Feb 2013 13:10:04 +0000
Message-Id: <51277C7602000078000C0634@nat28.tlf.novell.com>
Date: Fri, 22 Feb 2013 13:11:02 +0000
From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH 5/8] kexec: extend hypercall with
 improved load/unload ops
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
 <1361468894-18655-6-git-send-email-david.vrabel@citrix.com>
 <51273D9D02000078000C03D4@nat28.tlf.novell.com>
 <51275C8C.80506@citrix.com>
In-Reply-To: <51275C8C.80506@citrix.com>
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
Cc: Daniel Kiper <daniel.kiper@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

>>> On 22.02.13 at 12:54, David Vrabel <david.vrabel@citrix.com> wrote:
> I take your point though and will change it to use the dom heap.  Is
> there a way to verify that all the map/unmaps are correctly done and it
> isn't just working by chance?  Some sort of debug option?

Not currently (other than running out of map space at some point,
resulting in a BUG_ON() to trigger).

Jan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
