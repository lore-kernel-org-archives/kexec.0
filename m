Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bPlJi-0000ML-6N
 for kexec@lists.infradead.org; Wed, 20 Jul 2016 06:49:14 +0000
Date: Wed, 20 Jul 2016 14:48:50 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH 0/3] Enable legacy irq mode before jump to kexec/kdump
 kernel
Message-ID: <20160720064850.GC2608@x1.redhat.com>
References: <1468983483-3952-1-git-send-email-bhe@redhat.com>
 <1468986741.2020.41.camel@localhost>
 <20160720041527.GA5273@x1.redhat.com>
 <alpine.DEB.2.11.1607200830270.3564@nanos>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1607200830270.3564@nanos>
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
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "fenghua.yu@intel.com" <fenghua.yu@intel.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "hpa@zytor.com" <hpa@zytor.com>, "Wei, Jiangang" <weijg.fnst@cn.fujitsu.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 07/20/16 at 08:32am, Thomas Gleixner wrote:
> On Wed, 20 Jul 2016, bhe@redhat.com wrote:
> > On 07/20/16 at 03:54am, Wei, Jiangang wrote:
> >
> > >  In fact, Eric and Ingo suggested that "it should be fixed in the bootup
> > > path of the dump kernel, not the crash kernel reboot path", which is
> > > convincing and reasonable.
> > 
> > Well this patch doesn't do differently with Eric's original implemention
> > in kexec/kdump path.
> > By taking out clear_IO_APIC from disable_IO_APIC, the left code of
> > disable_IO_APIC will only do the virtual wire setting. So for
> > kexec/kdump path, code basically is the same as Eric's method. But for
> > poweroff/halt/reboot, it's enough to call clear_IO_APIC to disable
> > IO-APIC.
> 
> You're completely ignoring what Jiangang said: 
> 
>  "it should be fixed in the bootup path of the dump kernel, not the crash
>   kernel reboot path"
> 
> and that's the right way to do it. End of story.

Thanks, tglx. What I did is like reverting commit 522e6646446. But it
would be great if we can change to fix it in bootup path.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
