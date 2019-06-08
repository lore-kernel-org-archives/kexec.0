Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hZYAY-0000Ju-0p
 for kexec@lists.infradead.org; Sat, 08 Jun 2019 10:01:52 +0000
Date: Sat, 8 Jun 2019 18:01:39 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 0/3 v11] add reserved e820 ranges to the kdump kernel
 e820 table
Message-ID: <20190608100139.GC26148@MiWiFi-R3L-srv>
References: <20190423013007.17838-1-lijiang@redhat.com>
 <12847a03-3226-0b29-97b5-04d404410147@redhat.com>
 <20190607174211.GN20269@zn.tnic>
 <20190608035451.GB26148@MiWiFi-R3L-srv>
 <20190608091030.GB32464@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190608091030.GB32464@zn.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas.Lendacky@amd.com, x86@kernel.org, lijiang <lijiang@redhat.com>, peterz@infradead.org, dave.hansen@linux.intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, luto@kernel.org, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On 06/08/19 at 11:10am, Borislav Petkov wrote:
> On Sat, Jun 08, 2019 at 11:54:51AM +0800, Baoquan He wrote:
> > Is it a UEFI box?
> 
> Yes.

OK, it doesn't matter with uefi since CONFIG_RANDOMIZE_BASE is not set. 


> 
> > If it's uefi machine, it should relate to below issue. Because kexec
> > always fails to randomly choose a new position for kernel.
> 
> The kernel succeeds in selecting a position for the kernel - the kexec
> kernel doesn't load when a panic happens. Rather, the box panics and
> nothing more.

OK, it may be different with the case we met, if panic happened when
load a kdump kernel.

We can load with 'kexec -l' or 'kexec -p', but can't boot after triggering
crash or execute 'kexec -e' to do kexec jumping.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
