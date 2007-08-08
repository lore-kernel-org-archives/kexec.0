Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IIa1O-0004EV-9e
	for kexec@lists.infradead.org; Tue, 07 Aug 2007 21:07:35 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: PATCH/RFC: [kdump] fix APIC shutdown sequence
References: <46B73955.2080007@fujitsu-siemens.com>
	<20070807142928.GA18839@in.ibm.com>
	<46B8AECA.7050908@fujitsu-siemens.com>
Date: Tue, 07 Aug 2007 19:04:50 -0600
In-Reply-To: <46B8AECA.7050908@fujitsu-siemens.com> (Martin Wilck's message of
	"Tue, 07 Aug 2007 19:41:30 +0200")
Message-ID: <m1ir7qg7kd.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
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
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, "vgoyal@in.ibm.com" <vgoyal@in.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


A couple of questions.

How bad is it if you just run with irqpoll in the kdump kernel?
If running with irqpoll is usable that is probably preferable
to putting in a hardware work around we can survive without.


Have you done any looking at moving where the kernel initalizes
io_apics?  One of the todo items on the path is to leave
io_apic mode enabled and just startup the kernel in io_apic
mode.

When doing that a version of your work around (if needed)
would certainly be reasonable.

My general concern is that the trickier we get in the code
running in the crashed kernel the less reliable the entire
process will be.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
