Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cavan.codon.org.uk ([93.93.128.6])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qi7j8-0002kC-Cy
	for kexec@lists.infradead.org; Sat, 16 Jul 2011 16:28:26 +0000
Date: Sat, 16 Jul 2011 17:28:06 +0100
From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [RFC][PATCH] Replace a function call chain of
	kmsg_dump(KMSG_DUMP_KEXEC) with static function calls
Message-ID: <20110716162805.GA13127@srcf.ucam.org>
References: <5C4C569E8A4B9B42A84A977CF070A35B2C17AAE59A@USINDEVS01.corp.hds.com>
	<m14o2mjj5l.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m14o2mjj5l.fsf@fess.ebiederm.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "dle-develop@lists.sourceforge.net" <dle-develop@lists.sourceforge.net>, "tony.luck@intel.com" <tony.luck@intel.com>, "hpa@zytor.com" <hpa@zytor.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Satoru Moriya <satoru.moriya@hds.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Jarod Wilson <jwilson@redhat.com>, Americo Wang <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Seiji Aguchi <seiji.aguchi@hds.com>, Vivek Goyal <vgoyal@redhat.com>

On Sat, Jul 16, 2011 at 09:16:06AM -0700, Eric W. Biederman wrote:

> What is going on with EFI support?  We are still making efi calls in
> virtual mode, and we don't have the one unified identity mapped physical
> page table that hpa and I think others were working a while back.  Even
> if because of bugs we need to transition EFI to virtual mode we can
> still set physical to virtual so we don't have to deal with the nonsense.

No, we can't. It doesn't work.

> Can we please make our EFI support ask the minimal from EFI before
> adding lots more to it?

No.

> Am I wrong in thinking that the core motivation behind this patch is
> that our EFI support sucks and thus kdump on EFI does not work on some
> platforms?

Yes, you are.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
