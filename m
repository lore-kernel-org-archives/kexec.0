Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nat28.tlf.novell.com ([130.57.49.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TbpzJ-0005k1-AX
 for kexec@lists.infradead.org; Fri, 23 Nov 2012 09:56:01 +0000
Message-Id: <50AF567402000078000AABF6@nat28.tlf.novell.com>
Date: Fri, 23 Nov 2012 09:56:52 +0000
From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [PATCH v2 01/11] kexec: introduce kexec_ops struct
References: <1353423893-23125-1-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-2-git-send-email-daniel.kiper@oracle.com>
 <87lidwtego.fsf@xmission.com>
 <20121121105221.GA2925@host-192-168-1-59.local.net-space.pl>
 <87txshx28b.fsf@xmission.com> <50AE62E9.3000602@zytor.com>
In-Reply-To: <50AE62E9.3000602@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: xen-devel@lists.xensource.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, Daniel Kiper <daniel.kiper@oracle.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, tglx@linutronix.de

>>> On 22.11.12 at 18:37, "H. Peter Anvin" <hpa@zytor.com> wrote:
> I actually talked to Ian Jackson at LCE, and mentioned among other 
> things the bogosity of requiring a PUD page for three-level paging in 
> Linux -- a bogosity which has spread from Xen into native.  It's a page 
> wasted for no good reason, since it only contains 32 bytes worth of 
> data, *inherently*.  Furthermore, contrary to popular belief, it is 
> *not* pa page table per se.
> 
> Ian told me: "I didn't know we did that, and we shouldn't have to." 
> Here we have suffered this overhead for at least six years, ...

Even the Xen kernel only needs the full page when running on a
64-bit hypervisor (now that we don't have a 32-bit hypervisor
anymore, that of course basically means always). But yes, I too
never liked this enforced over-allocation for native kernels (and
was surprised that it was allowed in at all).

Jan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
