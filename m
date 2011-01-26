Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PiEfw-0005Vb-Hq
	for kexec@lists.infradead.org; Wed, 26 Jan 2011 23:21:21 +0000
From: "Luck, Tony" <tony.luck@intel.com>
Date: Wed, 26 Jan 2011 15:21:01 -0800
Subject: RE: [PATCH 0/2][concept RFC] x86: BIOS-save kernel log to disk	upon
	panic
Message-ID: <987664A83D2D224EAE907B061CE93D53019438EB02@orsmsx505.amr.corp.intel.com>
References: <20110125134748.GA10051@laptop>
	<AANLkTinU0KYiCd4p=z+=ojbkeEoT2G+CAYvdRU02KJEn@mail.gmail.com>
	<20110126124954.GC24527@laptop>
	<987664A83D2D224EAE907B061CE93D53019438EABF@orsmsx505.amr.corp.intel.com>
	<20110126231620.GA14807@redhat.com>
In-Reply-To: <20110126231620.GA14807@redhat.com>
Content-Language: en-US
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Dave Jones <davej@redhat.com>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, Dirk Hohndel <hohndel@infradead.org>, =?iso-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>, FBDEV-ML <linux-fbdev@vger.kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Randy Dunlap <rdunlap@xenotime.net>, James Bottomley <James.Bottomley@suse.de>, "H. Peter
	Anvin" <hpa@zytor.com>, X86-ML <x86@kernel.org>, "Ahmed S. Darwish" <darwish.07@gmail.com>, Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>, Vivek Goyal <vgoyal@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, "Hohndel,
	Dirk" <dirk.hohndel@intel.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Mark Lord <kernel@teksavvy.com>, Arjan van de Ven <arjan@infradead.org>, KEXEC-ML <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Haren Myneni <hbabu@us.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Willy Tarreau <w@1wt.eu>

> How is this more useful than a photograph of the backtrace ?

You can fit a lot more data into the 2-d barcode that will fit on
the screen.  You can also automate the recovery of the data (e.g.
for posting to kerneloops.org).

-Tony

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
