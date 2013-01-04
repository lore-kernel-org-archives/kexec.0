Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tr81C-0000gz-EP
 for kexec@lists.infradead.org; Fri, 04 Jan 2013 14:13:07 +0000
Date: Fri, 4 Jan 2013 15:12:32 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v3 02/11] x86/kexec: Add extra pointers to transition
 page table PGD, PUD, PMD and PTE
Message-ID: <20130104141232.GB3346@host-192-168-1-59.local.net-space.pl>
References: <71b94237-c365-47ba-8d75-5ee1d8caee73@default>
 <20121228125926.GA13224@x1.alien8.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20121228125926.GA13224@x1.alien8.de>
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
To: Borislav Petkov <bp@alien8.de>, hpa@zytor.com, kexec@lists.infradead.org, xen-devel@lists.xensource.com, konrad.wilk@oracle.com, tglx@linutronix.de, ebiederm@xmission.com, maxim.uvarov@oracle.com, andrew.cooper3@citrix.com, jbeulich@suse.com, mingo@redhat.com, x86@kernel.org, virtualization@lists.linux-foundation.org, vgoyal@redhat.com, linux-kernel@vger.kernel.org

On Fri, Dec 28, 2012 at 01:59:27PM +0100, Borislav Petkov wrote:
> On Thu, Dec 27, 2012 at 03:19:24PM -0800, Daniel Kiper wrote:
> > > Hmm... this code is being redone at the moment... this might conflict.
> >
> > Is this available somewhere? May I have a look at it?
>
> http://marc.info/?l=linux-kernel&m=135581534620383
>
> The for-x86-boot-v7 and -v8 branches.
>
> HTH.

Thanks.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
