Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cavan.codon.org.uk ([93.93.128.6])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QiBT5-0003Y8-7j
	for kexec@lists.infradead.org; Sat, 16 Jul 2011 20:28:07 +0000
Date: Sat, 16 Jul 2011 21:27:53 +0100
From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [RFC][PATCH] Replace a function call chain of
	kmsg_dump(KMSG_DUMP_KEXEC) with static function calls
Message-ID: <20110716202753.GA16161@srcf.ucam.org>
References: <5C4C569E8A4B9B42A84A977CF070A35B2C17AAE59A@USINDEVS01.corp.hds.com>
	<m14o2mjj5l.fsf@fess.ebiederm.org>
	<20110716162805.GA13127@srcf.ucam.org>
	<m1hb6mgf3w.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1hb6mgf3w.fsf@fess.ebiederm.org>
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

On Sat, Jul 16, 2011 at 01:11:47PM -0700, Eric W. Biederman wrote:

> Without some real understanding of what is going on I'm not inclined
> to meet any of this half way and summarily reject every change to
> the kexec on panic code path.

There are platforms that simply refuse to correctly function with a 1:1 
physical/virtual mapping. But that's not the point here - this patch 
simply hardcodes saving dmesg to an EFI variable rather than using 
kmsg_dump and pstore in order to avoid handling the locking, and does 
nothing whatsoever to change the amount of EFI code involved.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
