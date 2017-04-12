Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cyDdk-0005mp-RU
 for kexec@lists.infradead.org; Wed, 12 Apr 2017 08:28:37 +0000
Date: Wed, 12 Apr 2017 16:27:44 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: KASLR causes intermittent boot failures on some systems
Message-ID: <20170412082744.GA3766@dhcp-128-65.nay.redhat.com>
References: <x49shlk700k.fsf@segfault.boston.devel.redhat.com>
 <20170412082433.GA3546@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170412082433.GA3546@dhcp-128-65.nay.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: bhe@redhat.com, linux-nvdimm@lists.01.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@kernel.org, dan.j.williams@intel.com, thgarnie@google.com

On 04/12/17 at 04:24pm, Dave Young wrote:
> On 04/07/17 at 10:41am, Jeff Moyer wrote:
> > Hi,
> > 
> > commit 021182e52fe01 ("x86/mm: Enable KASLR for physical mapping memory
> > regions") causes some of my systems with persistent memory (whether real
> > or emulated) to fail to boot with a couple of different crash
> > signatures.  The first signature is a NMI watchdog lockup of all but 1
> > cpu, which causes much difficulty in extracting useful information from
> > the console.  The second variant is an invalid paging request, listed
> > below.
> > 
> > On some systems, I haven't hit this problem at all.  Other systems
> > experience a failed boot maybe 20-30% of the time.  To reproduce it,
> > configure some emulated pmem on your system.  You can find directions
> > for that here: https://nvdimm.wiki.kernel.org/
> > 
> > Install ndctl (https://github.com/pmem/ndctl).
> > Configure the namespace:
> > # ndctl create-namespace -f -e namespace0.0 -m memory
> > 
> > Then just reboot several times (5 should be enough), and hopefully
> > you'll hit the issue.
> > 
> > I've attached both my .config and the dmesg output from a successful
> > boot at the end of this mail.
> > 
> [snip]
> 
> I did some tests about emulated pmem via memmap=, kdump kernel hangs or
> just reboots early during compressing kernel, no clue how to handle it.

s/compressing/uncompressing

> Since for kdump kernel kaslr is pointless a workaround is use "nokaslr"
> 
> In Fedora or RHEL, just add "nokaslr" in KDUMP_COMMANDLINE_APPEND
> in /etc/sysconfig/kdump 
> 
> Can you try if this works?
> 
> Thanks
> Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
