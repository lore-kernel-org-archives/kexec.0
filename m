Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1avie6-0006K2-9d
 for kexec@lists.infradead.org; Thu, 28 Apr 2016 09:54:06 +0000
Date: Thu, 28 Apr 2016 17:53:41 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/3] kexec: don't invoke OOM-killer for control page
 allocation
Message-ID: <20160428095341.GA10691@x1.redhat.com>
References: <20160414195938.GV19428@n2100.arm.linux.org.uk>
 <E1aqnQo-0001Tu-Ch@rmk-PC.arm.linux.org.uk>
 <20160418053253.GA3602@x1.redhat.com>
 <20160418083932.GA19428@n2100.arm.linux.org.uk>
 <20160418101214.GA6694@x1.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160418101214.GA6694@x1.redhat.com>
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
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org

On 04/18/16 at 06:12pm, Baoquan He wrote:
> On 04/18/16 at 09:39am, Russell King - ARM Linux wrote:
> > On Mon, Apr 18, 2016 at 01:32:53PM +0800, Baoquan He wrote:
> > > On 04/14/16 at 09:00pm, Russell King wrote:
> > > > If we are unable to find a suitable page when allocating the control
> > > > page, do not invoke the OOM-killer: killing processes probably isn't
> > > > going to help.
> > > 
> > > Originally kexec was made to reboot to test kernel quickly. If 1st
> > > kernel is palyed and hurted in a bad state and developer want to discard
> > > it and take a quick reboot, why don't we have a best try to make a
> > > successful kexec load?
> > 
> > And if it kills off every process trying to get a suitable page,
> > which then means you can't do anything other than power cycle,
> > that's okay?
> 
> Yes, I agree on that it's non-sense if every process is killed. But will
> each kexec load which need OOM-killer go that far? And there's only one
> page (if 32 bit) or 2 pages (if 64 bit) for control page, it may not
> need kill that many processes to pick one.

Sorry, I was wrong. Those control pages are imtermediate pages which
is used to copy kenrel and initrd from user buffer to their final place,
they should be dozens of MB. So I am fine with this change, ack it.

Acked-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
