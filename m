Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g54ew-0001nm-Ag
 for kexec@lists.infradead.org; Wed, 26 Sep 2018 07:54:59 +0000
Date: Wed, 26 Sep 2018 15:54:33 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/3] x86/boot: Add bit fields into xloadflags for 5-level
 kernel checking
Message-ID: <20180926075433.GD2555@MiWiFi-R3L-srv>
References: <20180829141624.13985-1-bhe@redhat.com>
 <20180829141624.13985-2-bhe@redhat.com>
 <6ea94875-ae07-6220-eb3e-d3f830cdac03@zytor.com>
 <20180904034414.GI1740@192.168.1.3>
 <4546fc39-4982-4c91-c812-0df1e9bc9e20@zytor.com>
 <20180904052036.GJ1740@192.168.1.3>
 <c4f65956-ad99-84ee-d4bf-044a6f0c5010@zytor.com>
 <20180904084231.ubyjaqp4xhqcnper@kshutemo-mobl1>
 <7a1147d7-05af-98fe-3a14-b18ea445c2b5@zytor.com>
 <alpine.DEB.2.21.1809051002020.1416@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809051002020.1416@nanos.tec.linutronix.de>
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
To: Thomas Gleixner <tglx@linutronix.de>, mingo@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com

On 09/05/18 at 10:02am, Thomas Gleixner wrote:
> On Tue, 4 Sep 2018, H. Peter Anvin wrote:
> 
> > On 09/04/18 01:42, Kirill A. Shutemov wrote:
> > > 
> > > Switching between 4- and 5-level paging modes (in either direction)
> > > requires paing disabling. It means the code that does the switching has to
> > > be under 4G otherwise we would lose control.
> > > 
> > > We handle the switching correctly in kernel decompression code, but not on
> > > kexec caller side.
> > > 
> > > XLF_5LEVEL indicates that kernel decompression code can deal with
> > > switching between paging modes and it's safe to jump there in 5-level
> > > paging mode.
> > > 
> > > As an alternative we can change kexec to switch to 4-level paging mode
> > > before starting the new kernel. Not sure how hard it will be.
> > > 
> > 
> > Have a flag saying entering in 5-level mode is fine.  However, you really
> > should support returning to 4-level mode in kexec.  It is *much* easier to do
> > on the caller side as you have total control of memory allocation there.
> 
> Works for a regular kexec, but not for starting a crash kernel....

Agree, it's not appropriate to do this after normal kernel crashed and
prepare to jump to 2nd kernel.

Can this patchset be merged? I will post patches to kexec-tools utility
since it will make use of these flags.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
