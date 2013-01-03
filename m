Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nat28.tlf.novell.com ([130.57.49.28])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TqhCV-00079A-9s
 for kexec@lists.infradead.org; Thu, 03 Jan 2013 09:34:59 +0000
Message-Id: <50E55ECF02000078000B2A13@nat28.tlf.novell.com>
Date: Thu, 03 Jan 2013 09:34:55 +0000
From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [PATCH v3 02/11] x86/kexec: Add extra pointers to
 transition page table PGD, PUD, PMD and PTE
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-2-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-3-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1356574740-6806-3-git-send-email-daniel.kiper@oracle.com>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: hpa@zytor.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel <xen-devel@lists.xen.org>, mingo@redhat.com, ebiederm@xmission.com, maxim.uvarov@oracle.com, tglx@linutronix.de, virtualization@lists.linux-foundation.org, vgoyal@redhat.com

>>> On 27.12.12 at 03:18, Daniel Kiper <daniel.kiper@oracle.com> wrote:
> Some implementations (e.g. Xen PVOPS) could not use part of identity page 
> table
> to construct transition page table. It means that they require separate 
> PUDs,
> PMDs and PTEs for virtual and physical (identity) mapping. To satisfy that
> requirement add extra pointer to PGD, PUD, PMD and PTE and align existing 
> code.

So you keep posting this despite it having got pointed out on each
earlier submission that this is unnecessary, proven by the fact that
the non-pvops Xen kernels can get away without it. Why?

Jan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
