Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giyKv-0005d8-8l
 for kexec@lists.infradead.org; Mon, 14 Jan 2019 09:15:14 +0000
Date: Mon, 14 Jan 2019 10:15:10 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
Message-ID: <20190114091509.GC2773@zn.tnic>
References: <20190110121944.6050-1-lijiang@redhat.com>
 <20190110121944.6050-2-lijiang@redhat.com>
 <20190111145650.GG4729@zn.tnic>
 <be8fbb64-7748-c7da-55f7-99fe69796a94@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <be8fbb64-7748-c7da-55f7-99fe69796a94@redhat.com>
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
To: lijiang <lijiang@redhat.com>
Cc: k-hagio@ab.jp.nec.com, bhe@redhat.com, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, anderson@redhat.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On Mon, Jan 14, 2019 at 01:30:30PM +0800, lijiang wrote:
> I noticed that the checkpatch was coded in Perl. But i am not familiar with
> the Perl program language, that would be beyond my ability to do this, i have
> to learn the Perl program language step by step. :-)

You could give it a try - it is not hard :-)

And there's no hurry for this, take your time.

> Do you mean this one 'KERNEL_IMAGE_SIZE'?

I mean, all those which are unused. Optimally, you should look at the
tools and see whether they're using those exports and if not, remove
them. But no hurry here too, take your time.

My final goal is to have this up-to-date documentation of what is
exported and what is used by user tools so that people can look at it
first before carelessly exporting yet another thing.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
