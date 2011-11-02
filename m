Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RLhsL-0005JM-Lh
	for kexec@lists.infradead.org; Wed, 02 Nov 2011 20:57:34 +0000
From: "Luck, Tony" <tony.luck@intel.com>
Date: Wed, 2 Nov 2011 13:57:26 -0700
Subject: RE: [PATCH v2] kdump: Fix crash_kexec - smp_send_stop race in panic
Message-ID: <987664A83D2D224EAE907B061CE93D5301F527F980@orsmsx505.amr.corp.intel.com>
References: <1319639649.3321.11.camel@br98xy6r>
	<20111028161143.e5ebf617.akpm@linux-foundation.org>
	<1320055036.2796.8.camel@br98xy6r>
	<20111031033948.a0edb7f3.akpm@linux-foundation.org>
	<1320064459.2796.26.camel@br98xy6r> <20111101200420.GN17705@redhat.com>
	<1320228239.2776.14.camel@br98xy6r>
In-Reply-To: <1320228239.2776.14.camel@br98xy6r>
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
To: "holzheu@linux.vnet.ibm.com" <holzheu@linux.vnet.ibm.com>, Don Zickus <dzickus@redhat.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

> Instead of introducing the panic lock, as an alternative we could move
> smp_send_stop() to the beginning of panic(). Eric told me that the
> function is currently "insufficiently reliable" for that, but perhaps we
> could make it more reliable.

That's tough to do.  We are in panic because something went horribly
wrong somewhere in the kernel - so we can make few assumptions about
which subsystems are still working. In the worst case (for this example)
our panic was caused by a failure in the code that sends cross-processor
interrupts ... so calling that same code to stop the other cpus is
likely to run into the same problem - perhaps causing a nested panic.

So what looks like a good fix for some panic scenarios actually makes
others worse.

-Tony

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
