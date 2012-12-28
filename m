Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1ToZXB-0001Cr-Hh
 for kexec@lists.infradead.org; Fri, 28 Dec 2012 12:59:35 +0000
Date: Fri, 28 Dec 2012 13:59:27 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 02/11] x86/kexec: Add extra pointers to transition
 page table PGD, PUD, PMD and PTE
Message-ID: <20121228125926.GA13224@x1.alien8.de>
References: <71b94237-c365-47ba-8d75-5ee1d8caee73@default>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <71b94237-c365-47ba-8d75-5ee1d8caee73@default>
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
Cc: xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, maxim.uvarov@oracle.com, kexec@lists.infradead.org, x86@kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, ebiederm@xmission.com, jbeulich@suse.com, hpa@zytor.com, tglx@linutronix.de, vgoyal@redhat.com

On Thu, Dec 27, 2012 at 03:19:24PM -0800, Daniel Kiper wrote:
> > Hmm... this code is being redone at the moment... this might conflict.
> 
> Is this available somewhere? May I have a look at it?

http://marc.info/?l=linux-kernel&m=135581534620383

The for-x86-boot-v7 and -v8 branches.

HTH.

-- 
Regards/Gruss,
Boris.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
