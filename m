Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ms.lwn.net ([2600:3c01:e000:3a1::42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsZEc-00Bagc-3a
 for kexec@lists.infradead.org; Sun, 13 Jun 2021 23:09:43 +0000
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3] Documentation: kdump: update kdump guide
In-Reply-To: <20210609083218.GB591017@MiWiFi-R3L-srv>
References: <20210609083218.GB591017@MiWiFi-R3L-srv>
Date: Sun, 13 Jun 2021 17:09:40 -0600
Message-ID: <878s3dbbuz.fsf@meer.lwn.net>
MIME-Version: 1.0
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
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org, kexec@lists.infradead.org, akpm@linux-foundation.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Hari Bathini <hbathini@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Russell King <linux@armlinux.org.uk>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "H. Peter Anvin" <hpa@zytor.com>, vgoyal@redhat.com, x86@kernel.org, Eric Biederman <ebiederm@xmission.com>, dyoung@redhat.com

Baoquan He <bhe@redhat.com> writes:

> Some parts of the guide are aged, hence need be updated.
>
> 1) The backup area of the 1st 640K on X86_64 has been removed
>    by below commits, update the description accordingly.
>
>    commit 7c321eb2b843 ("x86/kdump: Remove the backup region handling")
>    commit 6f599d84231f ("x86/kdump: Always reserve the low 1M when the crashkernel option is specified")
>
> 2) Sort out the descripiton of "crashkernel syntax" part.
>
> 3) And some other minor cleanups.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>

Applied, thanks.

jon

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
