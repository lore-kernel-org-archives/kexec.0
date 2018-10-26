Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr710048.outbound.protection.outlook.com
 ([40.107.71.48] helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gFz5q-0001kk-0F
 for kexec@lists.infradead.org; Fri, 26 Oct 2018 10:11:51 +0000
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Subject: Re: [BUG] vmcore-dmesg cant' read dmesg log from /proc/vmcore if
 log_buf is reallocated due to large number of CPUs
Date: Fri, 26 Oct 2018 10:11:37 +0000
Message-ID: <20181026101133.GA31868@localhost.localdomain>
References: <MWHPR07MB3007D9D79825933D958943EC8AF60@MWHPR07MB3007.namprd07.prod.outlook.com>
 <CACi5LpO6JH=Fepu97GVa-oZK7v4kj0+RL9WqYZuMp=KRJ2=diQ@mail.gmail.com>
 <20181025104017.GA29339@localhost.localdomain>
 <CACi5LpO56hq4jC76d7B5vLoG-wVoe-rGQoqeWYhYhjOEWG0sqA@mail.gmail.com>
In-Reply-To: <CACi5LpO56hq4jC76d7B5vLoG-wVoe-rGQoqeWYhYhjOEWG0sqA@mail.gmail.com>
Content-Language: en-US
Content-ID: <DB180B70805CDB4184D2C57053CB606B@namprd07.prod.outlook.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: "Lomovtsev, Vadim" <Vadim.Lomovtsev@cavium.com>, kexec mailing list <kexec@lists.infradead.org>

Hi Bhupesh,

On Fri, Oct 26, 2018 at 12:25:17PM +0530, Bhupesh Sharma wrote:
> 
> ease p
> before seiHi Vadim,
> 
> On Thu, Oct 25, 2018 at 4:10 PM Vadim Lomovtsev
> <Vadim.Lomovtsev@caviumnetworks.com> wrote:
> >
> > Hello Bhupesh,
> >
> > On Thu, Oct 25, 2018 at 03:00:08AM +0530, Bhupesh Sharma wrote:
> > > External Email
> > >
> > > Hello Vadim,
> > >
> > > On Wed, Oct 24, 2018 at 6:23 PM Lomovtsev, Vadim
> > > <Vadim.Lomovtsev@cavium.com> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > Following issue has been found for vmcore-dmesg app with latest release (94159bc3c264fa26395e56302072276a139d18af 2.0.18-rc1) of kexec-tools at CentOS 7.5 distro:
> > > >
> > > > While having systems with large number of CPUs (e.g. Cavium ThunderX2 has 224) the log_buf gets reallocated by memblock_virt_alloc() at the setup_log_buf routine (https://elixir.bootlin.com/linux/v4.16.18/source/kernel/printk/printk.c#L1108).
> > > >
> > > > Then while dumping vmcore the vmcore-dmesg can't find dmesg log at /proc/vmcore file and exits with following message:
> > > >   Failed to read log text of size 0 bytes: Bad address
> > > >
> > > > However it (vmcore-dmesg app) reads properly the log_buf symbol, it's address and eventually it's value from /proc/vmcore but fails to find dmesg data then.
> > > >
> > > > In the same time the makedumpfile is able to find and extract dmesg buffer from /proc/vmcore.
> > > > The makedumpfile comes with kexec-tools-2.0.15-13.el7_5.2.aarch64 package.
> > > >
> > > > The issue is not reproduced for systems with small number of CPUs and log_buf not reallocated to memblock section.
> > >
> > > Seems like you are hitting a known issue we saw on qualcomm amberwing
> > > platforms as well.
> > > I have sent a patch-series titled 'kexec-tools/arm64: Add support to
> > > read PHYS_OFFSET from vmcoreinfo inside '/proc/kcore' to this list
> > > just a few minutes back.
> > >
> > > I have Cc'ed you to the patchset as I think it might fix the issue for
> > > you.
> >
> > Got them, thank you.
> >
> > > Kindly try the patchset on your platform (cavium?) and let me
> > > know if this fixes the issue for you.
> >
> > Sure, I'd like to check them at my side, but..
> > I fall into merge conflicts while trying to apply them onto
> > https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/
> > master, kexec-tools 2.0.18-rc1 94159bc3c264fa26395e56302072276a139d18af
> 
> Hmm.. that's strange as I rebased them on kexec-tools 2.0.18-rc1
> (94159bc3c264fa26395e56302072276a139d18af)
> before sending out the patchset.
> 
> > Are there any specific branch/revision for them to be applied ?
> > (or it might be my mail server issues with formatting emails).
> >
> 
> Can you please try picking them up from my public github tree instead?
> Here you can find the same:
> https://github.com/bhupesh-sharma/kexec-tools/tree/read-phys-offset-from-kcore-upstream-v1
> 
> Please pick the top 2 commit from here.

Applied them onto commit '94159bc kexec-tools 2.0.18-rc1'.

Still having following error while saving dmesg by vmcore-dmesg:

kdump: saving vmcore-dmesg.txt                                 
Failed to read log text of size 0 bytes: Bad address           
kdump: saving vmcore-dmesg.txt failed 

So far tried kernels 4.14.78, 4.16.18.

WBR,
Vadim

> 
> Thanks,
> Bhupesh
> 
> >
> > >
> > > Thanks,
> > > Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
