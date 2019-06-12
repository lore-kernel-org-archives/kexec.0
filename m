Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1haw9N-0001kM-Kd
 for kexec@lists.infradead.org; Wed, 12 Jun 2019 05:50:23 +0000
Date: Wed, 12 Jun 2019 13:49:49 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 0/3 v11] add reserved e820 ranges to the kdump kernel
 e820 table
Message-ID: <20190612054949.GA23066@dhcp-128-65.nay.redhat.com>
References: <20190423013007.17838-1-lijiang@redhat.com>
 <12847a03-3226-0b29-97b5-04d404410147@redhat.com>
 <20190607174211.GN20269@zn.tnic>
 <20190608035451.GB26148@MiWiFi-R3L-srv>
 <20190608091030.GB32464@zn.tnic>
 <20190608100139.GC26148@MiWiFi-R3L-srv>
 <20190608100623.GA9138@zn.tnic>
 <20190608102659.GA9130@MiWiFi-R3L-srv>
 <20190610113747.GD5488@zn.tnic>
 <20190612015549.GI26148@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190612015549.GI26148@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>
Cc: Thomas.Lendacky@amd.com, x86@kernel.org, lijiang <lijiang@redhat.com>, peterz@infradead.org, dave.hansen@linux.intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, Borislav Petkov <bp@alien8.de>, luto@kernel.org, hpa@zytor.com, tglx@linutronix.de, akpm@linux-foundation.org

On 06/12/19 at 09:55am, Baoquan He wrote:
> On 06/10/19 at 01:37pm, Borislav Petkov wrote:
> > On Sat, Jun 08, 2019 at 06:26:59PM +0800, Baoquan He wrote:
> > > OK, I see. Then it should be the issue we have met and talked about with
> > > Tom.
> > > https://lkml.kernel.org/r/20190604134952.GC26891@MiWiFi-R3L-srv
> > > 
> > > You can apply Tom's patch as below. I tested it, it can make kexec
> > > kernel succeed to boot, but failed for kdump kernel booting. The kdump
> > > kernel can boot till the end of kernel initialization, then hang with a
> > > call trace. I have pasted the log in the above thread. Haven't got the
> > > reason.
> > > http://lkml.kernel.org/r/508c2853-dc4f-70a6-6fa8-97c950dc31c6@amd.com
> > 
> > I can confirm the same observation.
> 
> With further investigation, the failure after applying Tom's patch is
> caused by OOM. When increase crashkernel reservation to 512M, kdump
> kernel can boot successfully. I noticed your crashkernel reservation is
> 256M, that will fail and stuck there very possibly.

Usually for Fedora/RHEL variant kernel + userspace, 160M is a good value
works for common setup.  Sometimes people forgot to strip debuginfo,
thus the kernel modules packed in initramfs is too big and cause out of
memory.

> 
> So Tom's patch can fix the issue. We need further check why much more
> crashkernel memory is needed on those AMD boxes with sme support..
> 
> Thanks
> Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
