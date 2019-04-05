Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hCDmo-0000wQ-UD
 for kexec@lists.infradead.org; Fri, 05 Apr 2019 01:36:56 +0000
Date: Fri, 5 Apr 2019 09:36:45 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v3] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190405013645.GA8865@dhcp-128-65.nay.redhat.com>
References: <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190402102529.GA21698@jeru.linux.bs1.fc.nec.co.jp>
 <20190404073233.GC5708@dhcp-128-65.nay.redhat.com>
 <20190404122425.GC22539@zn.tnic>
 <20190404141241.GB7789@dhcp-128-65.nay.redhat.com>
 <20190404144115.GE22539@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190404144115.GE22539@zn.tnic>
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
Cc: "x86@kernel.org" <x86@kernel.org>, "kasong@redhat.com" <kasong@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Junichi Nomura <j-nomura@ce.jp.nec.com>

On 04/04/19 at 04:41pm, Borislav Petkov wrote:
> On Thu, Apr 04, 2019 at 10:12:41PM +0800, Dave Young wrote:
> > The early code hang can make people confused, it is hard to
> > say what happens and not easy to debug.   But if we return 0 then kernel
> > just continue to boot, and fail later because of no acpi root pointer, at
> > least we can have some kernel boot log.
> 
> Is it clear from that boot log where we failed?

The early boot log in compress/*.c is not visible for kexec EFI boot so
the log is useless unless serial is usable.

the early putstr only works for legacy boot with some ioport outb()
callbacks unless serial is available.  For EFI boot it does not work,
and for kexec, it is even worse because 1st kernel booted with kms mode
setting, it is not like the firmware initialized video mode any more
when we run kexec reboot.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
