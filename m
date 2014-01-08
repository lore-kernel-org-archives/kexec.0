Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W0uK6-0007aK-8E
 for kexec@lists.infradead.org; Wed, 08 Jan 2014 14:41:35 +0000
Date: Wed, 8 Jan 2014 09:41:09 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kexec: reuse 1st kernel as kexec/kdump kernel?
Message-ID: <20140108144109.GA13649@redhat.com>
References: <20140107023405.GC3967@dhcp-16-126.nay.redhat.com>
 <20140107143723.GB1524@redhat.com>
 <20140108012422.GA3819@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140108012422.GA3819@dhcp-16-126.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: hpa@zytor.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com

On Wed, Jan 08, 2014 at 09:24:22AM +0800, Dave Young wrote:
> On 01/07/14 at 09:37am, Vivek Goyal wrote:
> > On Tue, Jan 07, 2014 at 10:34:06AM +0800, Dave Young wrote:
> > > Hi, all
> > > 
> > > I have a question in mind: can we copy and prepare kexec kernel while
> > > normal booting?
> > > 
> > > Just like below wild idea:
> > > 
> > > Kernel uncompress itself (assume kernel is relocatable)
> > > -> copy the kernel image somewhere for backup
> > >   -> reserver crashkernel memory
> > >     -> copy the backuped kernel image/initrd image to reserved memory
> > >       -> copy the purgatory which can be embedded in elf section?
> > >         -> prepare the e820 memory ranges which is for kdump kernel
> > > 
> > > So userspace only need to call kexec reboot, kexec_load is not necessary.
> > > The initrd for kdump should be different, but we can add some different logic
> > > which will be only for kdump and it can be skipped in normal boot.
> > > 
> > > Is it doable?
> > 
> > What's the advantage of doing all this? Why are you trying to skip load
> > step.
> 
> Hi, Vivek
> 
> It's just a thought that kernel already have all the information for kexecing so
> we can save user space works. Rethinking about it it benefits more to kexec than
> kdump. For kexec user he can reboot with kexec without any user space actions.
> For kdump there's no much advantage though.

We should rather have a kexec service which starts and loads the kernel
at startup and reboot will simply use kexec boot to boot into that kernel.
We don't need to do anything at kernel level.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
