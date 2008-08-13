Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KT7Mf-0003S8-JE
	for kexec@lists.infradead.org; Wed, 13 Aug 2008 03:49:37 +0000
Date: Tue, 12 Aug 2008 20:49:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -v3 1/7] kexec jump: clean up #ifdef and comments
Message-Id: <20080812204900.db63deaa.akpm@linux-foundation.org>
In-Reply-To: <1218510861.24951.40.camel@caritas-dev.intel.com>
References: <1218510861.24951.40.camel@caritas-dev.intel.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Huang Ying <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Torvalds <torvalds@linux-foundation.org>, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, mingo@elte.hu, Linus, Vivek Goyal <vgoyal@redhat.com>

On Tue, 12 Aug 2008 11:14:21 +0800 Huang Ying <ying.huang@intel.com> wrote:

>  	xchg(&kexec_lock, 0);

kernel/kexec.c: In function 'kernel_kexec':
kernel/kexec.c:1501: warning: value computed is not used

Is there any reason why we cannot use the more conventional
test_and_set_bit() etc, rather than this peculiarity?

Or perhaps spin_trylock?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
