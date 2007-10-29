Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 29 Oct 2007 16:15:34 -0700
From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] Revert x86: add lapic_shutdown for x86_64
Message-ID: <20071029161534.6e7f0db6@laptopd505.fenrus.org>
In-Reply-To: <47266132.5050001@ct.jp.nec.com>
References: <47195763.1090803@ct.jp.nec.com> <47195807.6030809@ct.jp.nec.com>
	<20071024062933.GA4622@in.ibm.com> <47266132.5050001@ct.jp.nec.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, vgoyal@in.ibm.com, "Eric W.
	Biederman" <ebiederm@xmission.com>, tglx@linutronix.de

On Mon, 29 Oct 2007 15:39:46 -0700
Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com> wrote:

> lapic_shutdown is useless on x86_64.
> 

.... but since the goal is to get apic_32.c and apic_64.c to be more
converging (to the point of becoming the same file)... isn't your patch
going in the opposite direction?

-- 
If you want to reach me at my work email, use arjan@linux.intel.com
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
