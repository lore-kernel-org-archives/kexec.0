Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Date: Tue, 19 Jul 2011 19:52:13 +0100
From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [RFC][PATCH -mmotm 1/4] Add static function calls of pstore to
	kexec path
Message-ID: <20110719185213.GA24420@srcf.ucam.org>
References: <5C4C569E8A4B9B42A84A977CF070A35B2C199C64C3@USINDEVS01.corp.hds.com>
	<20110719183506.GA23770@srcf.ucam.org>
	<5C4C569E8A4B9B42A84A977CF070A35B2C199C64D6@USINDEVS01.corp.hds.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5C4C569E8A4B9B42A84A977CF070A35B2C199C64D6@USINDEVS01.corp.hds.com>
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
To: Seiji Aguchi <seiji.aguchi@hds.com>
Cc: "dzickus@redhat.com" <dzickus@redhat.com>, Satoru Moriya <satoru.moriya@hds.com>, "dle-develop@lists.sourceforge.net" <dle-develop@lists.sourceforge.net>, "tony.luck@intel.com" <tony.luck@intel.com>, "hpa@zytor.com" <hpa@zytor.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Jarod Wilson <jwilson@redhat.com>, Americo Wang <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On Tue, Jul 19, 2011 at 02:48:22PM -0400, Seiji Aguchi wrote:
> >How is this safe? What happens if there's a pstore access in process
> >when you hit this codepath?
> 
> This will never happen because pstore_kmsg_dump_in_interrupt() is called after machine_crash_shutdown().
> 
> Panicked cpu sends NMI to all other cpus in machine_crash_shutdown() and they stop.

And how does that handle the case where we're halfway through a pstore
access when the NMI arrives? ERST, at least, has a complex state 
machine. You can't guarantee what starting one transaction without 
completing one that was in process will do.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
