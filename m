Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsxdP-007E65-7n
 for kexec@lists.infradead.org; Tue, 15 Jun 2021 01:13:04 +0000
Date: Tue, 15 Jun 2021 09:08:56 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3] Documentation: kdump: update kdump guide
Message-ID: <20210615010856.GA630506@MiWiFi-R3L-srv>
References: <20210609083218.GB591017@MiWiFi-R3L-srv>
 <878s3dbbuz.fsf@meer.lwn.net> <87sg1l9vo5.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87sg1l9vo5.fsf@meer.lwn.net>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org, akpm@linux-foundation.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Hari Bathini <hbathini@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Russell King <linux@armlinux.org.uk>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "H. Peter Anvin" <hpa@zytor.com>, vgoyal@redhat.com, x86@kernel.org, Eric Biederman <ebiederm@xmission.com>, dyoung@redhat.com

On 06/13/21 at 05:44pm, Jonathan Corbet wrote:
> Jonathan Corbet <corbet@lwn.net> writes:
> 
> > Baoquan He <bhe@redhat.com> writes:
> >
> >> Some parts of the guide are aged, hence need be updated.
> >>
> >> 1) The backup area of the 1st 640K on X86_64 has been removed
> >>    by below commits, update the description accordingly.
> >>
> >>    commit 7c321eb2b843 ("x86/kdump: Remove the backup region handling")
> >>    commit 6f599d84231f ("x86/kdump: Always reserve the low 1M when the crashkernel option is specified")
> >>
> >> 2) Sort out the descripiton of "crashkernel syntax" part.
> >>
> >> 3) And some other minor cleanups.
> >>
> >> Signed-off-by: Baoquan He <bhe@redhat.com>
> >
> > Applied, thanks.
> 
> Actually, this patch added a docs build warning:
> 
>   /stuff/k/git/kernel/Documentation/admin-guide/kdump/kdump.rst:286: WARNING: Literal block ends without a blank line; unexpected unindent.
> 
> I've gone ahead and inserted the blank line to fix this.  In the future,
> please build-test your changes to make sure that you are not adding new
> warnings.

Thanks, jon. I didn't know doc change can cause build failure, so didn't
build. Will remember this.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
