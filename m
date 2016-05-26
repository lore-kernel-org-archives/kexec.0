Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b5qlu-0000vY-CP
 for kexec@lists.infradead.org; Thu, 26 May 2016 08:36:03 +0000
Date: Thu, 26 May 2016 09:35:28 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH kexec-tools 01/32] kdump: mmap() and munmap() only work
 on page-aligned quantites
Message-ID: <20160526083528.GE19428@n2100.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXS0-0004gz-5a@e0050434b2927.dyn.arm.linux.org.uk>
 <CAHB_GupQcopOR7Qn5Nk0kNvYT_p0AWTzp+vJe87b+BsQTwr1CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHB_GupQcopOR7Qn5Nk0kNvYT_p0AWTzp+vJe87b+BsQTwr1CQ@mail.gmail.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Wed, May 25, 2016 at 11:46:08AM +0530, Pratyush Anand wrote:
> On Tue, May 3, 2016 at 3:51 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> > The man page for mmap() and munmap() says that mmap() and munmap()
> > only works for page-aligned addresses, sizes and offsets.  Arrange
> > to give these interfaces what they want.
> >
> 
> If I read correctly, it talks only offsets to be page aligned.

Yes, it's not really needed, but as we have to adjust the size anyway to
compensate for the reduced file offset, it makes little difference whether
we align the size or not.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
